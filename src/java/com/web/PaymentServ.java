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

@WebServlet("/PaymentServ")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2 MB
    maxFileSize = 1024 * 1024 * 10,      // 10 MB
    maxRequestSize = 1024 * 1024 * 50    // 50 MB
)
public class PaymentServ extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String paymentID = request.getParameter("paymentID");
        String newPrice = request.getParameter("newPrice");

        // Handling file upload
        Part filePart = request.getPart("receipt"); // Retrieves <input type="file" name="receipt">
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String contentType = filePart.getContentType();
        
        if (!contentType.startsWith("image/")) {
            // Uploaded file is not an image
            response.getWriter().println("<script>alert('Uploaded file is not an image. Please upload an image file.'); window.location='Payment.jsp';</script>");
            return;
        }

        InputStream receipt = filePart.getInputStream();

        // Update price and receipt in the database
        Connection con = null;
        String message = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");

            PreparedStatement ps = con.prepareStatement("UPDATE payment SET price = ?, receipt = ? WHERE payment_ID = ?");
            ps.setString(1, newPrice);
            ps.setBlob(2, receipt);
            ps.setString(3, paymentID);

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                message = "Price and receipt updated successfully!";
            } else {
                message = "No rows were updated.";
            }

            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            message = "ERROR: " + e.getMessage();
            e.printStackTrace(); // Print the stack trace for debugging purposes
        }

        // Redirect to appropriate page based on update result
        if (message != null && message.equals("Price and receipt updated successfully!")) {
            // Redirect to TimeTable.jsp and display success message
            response.getWriter().println("<script>alert('Price and receipt updated successfully!'); window.location='AboutCertificate.jsp';</script>");
        } else {
            // Redirect to CandidateProfile.jsp and display error message
            response.getWriter().println("<script>alert('Failed to update price and receipt!'); window.location='Payment.jsp';</script>");
        }
    }
}
