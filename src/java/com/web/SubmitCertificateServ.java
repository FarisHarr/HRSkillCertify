/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.web;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.*;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/SubmitCertificateServ")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
public class SubmitCertificateServ extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String candID = request.getParameter("candID");

        // Handling file upload
        Part filePart = request.getPart("certificate"); // Retrieves <input type="file" name="certificate">
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String contentType = filePart.getContentType();

        // Check if the uploaded file is not an image
        if (!contentType.startsWith("image/")) {
            response.getWriter().println("<script>alert('Uploaded file is not an image. Please upload an image file.'); window.location='ManageCandidate.jsp';</script>");
            return;
        }

        InputStream certificate = filePart.getInputStream();

        // Update certificate in the database
        Connection con = null;
        String message = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");

            PreparedStatement ps = con.prepareStatement("UPDATE candidate SET Cand_Certificate = ? WHERE cand_ID = ?");
            ps.setBlob(1, certificate);
            ps.setString(2, candID);

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                message = "Certificate updated successfully!";
                
                // Send notification email to candidate
                sendNotificationEmail(candID, con);
            } else {
                message = "No rows were updated.";
            }

            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            message = "ERROR: " + e.getMessage();
            e.printStackTrace(); // Print the stack trace for debugging purposes
        }

        // Redirect to appropriate page based on update result
        if (message != null && message.equals("Certificate updated successfully!")) {
            // Redirect to ManageCandidate.jsp and display success message
            response.getWriter().println("<script>alert('Certificate updated successfully.'); window.location='ManageCandidate.jsp';</script>");
        } else {
            // Redirect to ManageCandidate.jsp and display error message
            response.getWriter().println("<script>alert('Failed to update certificate!'); window.location='ManageCandidate.jsp';</script>");
        }
    }
    
    private void sendNotificationEmail(String candID, Connection con) {
        // Retrieve candidate's email address from the database using candID
        String candidateEmail = ""; // Retrieve candidate's email address from the database based on candID

        try {
            // Query to retrieve candidate's email address based on candID
            PreparedStatement ps = con.prepareStatement("SELECT cand_Email FROM candidate WHERE cand_ID = ?");
            ps.setString(1, candID);
            
            // Execute the query
            ResultSet rs = ps.executeQuery();
            
            // Check if a record is found
            if (rs.next()) {
                candidateEmail = rs.getString("cand_Email");
            }
            
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        // Email content
        String subject = "Certificate Uploaded Successfully";
        String body = "Dear Candidate,\n\nYour certificate has been successfully generated.\n\nThank you.";

        // Send email if candidate's email address is not empty
        if (!candidateEmail.isEmpty()) {
            sendEmail(candidateEmail, subject, body);
        } else {
            System.out.println("Candidate's email address not found.");
        }
    }

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
