/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author FarisHarr
 */
@WebServlet("/PaymentServ")
public class PaymentServ extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String paymentID = request.getParameter("paymentID");
        String newPrice = request.getParameter("newPrice");

        // Update price in the database
        Connection con = null;
        String message = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");

            PreparedStatement ps = con.prepareStatement("UPDATE payment SET price = ? WHERE payment_ID = ?");
            ps.setString(1, newPrice);
            ps.setString(2, paymentID);

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                message = "Price updated successfully!";
            } else {
                message = "No rows were updated.";
            }

            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            message = "ERROR: " + e.getMessage();
            e.printStackTrace(); // Print the stack trace for debugging purposes
        }

        // Redirect to appropriate page based on update result
        if (message != null && message.equals("Price updated successfully!")) {
            // Redirect to TimeTable.jsp and display success message
            response.getWriter().println("<script>alert('Price updated successfully!'); window.location='TimeTable.jsp';</script>");
        } else {
            // Redirect to CandidateProfile.jsp and display error message
            response.getWriter().println("<script>alert('Failed to update price!'); window.location='HomePage.jsp';</script>");
        }

    }
}
