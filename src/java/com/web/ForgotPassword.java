package com.web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ForgotPassword")
public class ForgotPassword extends HttpServlet {

        @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String candidateEmail = request.getParameter("email");
        RequestDispatcher dispatcher = null;
        int otpValue = 0;
        HttpSession session = request.getSession();

        if (candidateEmail != null && !candidateEmail.equals("")) {
            Connection con = null;
            PreparedStatement pst = null;
            ResultSet rs = null;

            try {
                // Fetch candidate's email from the database
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");
                pst = con.prepareStatement("SELECT cand_Email FROM candidate WHERE cand_Email = ?");
                pst.setString(1, candidateEmail);
                rs = pst.executeQuery();

                if (rs.next()) {
                    // Candidate email found in the database
                    // Generate OTP
                    Random rand = new Random();
                    otpValue = rand.nextInt(1255650);

                    // Send OTP to candidate's email
                    sendOTPEmail(candidateEmail, otpValue);

                    dispatcher = request.getRequestDispatcher("EnterOtp.jsp");
                    request.setAttribute("message", "OTP is sent to your email id");
                    session.setAttribute("otp", otpValue);
                    session.setAttribute("email", candidateEmail);
                } else {
                    // Candidate email not found in the database
                    dispatcher = request.getRequestDispatcher("forgotPassword.jsp");
                    request.setAttribute("error", "Invalid email address. Please try again.");
                }

                dispatcher.forward(request, response);

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // Close the connections
                try {
                    if (rs != null) {
                        rs.close();
                    }
                    if (pst != null) {
                        pst.close();
                    }
                    if (con != null) {
                        con.close();
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private void sendOTPEmail(String to, int otpValue) {
        // Send OTP to the provided email address
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "465");
        Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
               //admin email to check otp
                return new PasswordAuthentication("muhdfaris1324@gmail.com", "oeyk zhiy cqtx slfg");
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress("muhdfaris1324@gmail.com"));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject("Password Reset OTP");
            message.setText("Your OTP is: " + otpValue);
            Transport.send(message);
            System.out.println("OTP sent successfully");
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
}
