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
import java.sql.SQLException;
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
}
