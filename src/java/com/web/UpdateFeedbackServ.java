package com.web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UpdateFeedbackServ")
public class UpdateFeedbackServ extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(); // Get the session
        String candidateID = request.getParameter("candidateID"); // Retrieve candidate ID from request
        String feedbackID = request.getParameter("feedbackID"); // Retrieve feedback ID from request

        // Get form parameters
        String reply = request.getParameter("reply");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            String myURL = "jdbc:mysql://localhost/hrsc";

            try (Connection myConnection = DriverManager.getConnection(myURL, "root", "admin"); PreparedStatement ps = myConnection.prepareStatement("UPDATE feedback SET response = ? WHERE feedback_ID = ? AND cand_ID = ?")) {

                ps.setString(1, reply);
                ps.setString(2, feedbackID);
                ps.setString(3, candidateID);

                // Execute the SQL statement
                int rowsUpdated = ps.executeUpdate();

                // Close resources
                ps.close();

                // Provide feedback to the user
                if (rowsUpdated > 0) {
                    // Send email notification
                    sendEmailNotification(candidateID);
                    
                    // Set content type to HTML
                    response.setContentType("text/html");
                    response.getWriter().println("<script>alert('Response successfully!'); window.location='ViewFeedback.jsp';</script>");
                } else {
                    // Redirect to feedback page
                    response.sendRedirect("ViewFeedback.jsp");
                }
            }
        } catch (Exception e) {
            response.getWriter().println("Error: " + e.getMessage());
        }
    }

    // Method to send email notification
    private void sendEmailNotification(String candidateID) {
        try {
            // Load candidate's email from the database
            String candidateEmail = getCandidateEmail(candidateID);
            
            // Email content
            String subject = "Feedback Response Received";
            String body = "Dear Candidate,\n\nYour feedback response has been received and processed.\n\nPlease check on the website.";

            // Send email if candidate's email address is not empty
            if (!candidateEmail.isEmpty()) {
                sendEmail(candidateEmail, subject, body);
            } else {
                System.out.println("Candidate's email address not found.");
            }
        } catch (Exception e) {
            System.out.println("Error sending email notification: " + e.getMessage());
        }
    }

    // Method to get candidate's email from the database
    private String getCandidateEmail(String candidateID) throws SQLException {
        String candidateEmail = "";
        try (Connection myConnection = DriverManager.getConnection("jdbc:mysql://localhost/hrsc", "root", "admin");
                PreparedStatement ps = myConnection.prepareStatement("SELECT cand_Email FROM candidate WHERE cand_ID = ?")) {
            ps.setString(1, candidateID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                candidateEmail = rs.getString("cand_Email");
            }
        }
        return candidateEmail;
    }

    // Method to send email
    private void sendEmail(String to, String subject, String body) {
        // SMTP email configuration
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "465");

        // Sender's credentials
        final String username = "muhdfaris1324@gmail.com";
        final String password = "oeyk zhiy cqtx slfg";

        // Create session
        Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            // Create MimeMessage object
            MimeMessage message = new MimeMessage(session);

            // Set sender and recipient
            message.setFrom(new InternetAddress(username));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

            // Set email subject and body
            message.setSubject(subject);
            message.setText(body);

            // Send email
            Transport.send(message);
            System.out.println("Email sent successfully to: " + to);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
}
