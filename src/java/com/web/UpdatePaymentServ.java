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


/**
 *
 * @author FarisHarr
 */
@WebServlet("/UpdatePaymentServ")
public class UpdatePaymentServ extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String paymentID = request.getParameter("paymentID");
        String newStatus = request.getParameter("newStatus");

        // Update status in the database
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");
            PreparedStatement ps = con.prepareStatement("UPDATE payment SET status = ? WHERE payment_ID = ?");
            ps.setString(1, newStatus);
            ps.setString(2, paymentID);
            int rowsAffected = ps.executeUpdate();
            con.close();

            if (rowsAffected > 0) {
                response.sendRedirect("ManagePayment.jsp"); // Redirect to a success page
            } else {
                response.sendRedirect("ManagePayment.jsp"); // Redirect to an error page
            }
        } catch (Exception e) {
            response.sendRedirect("ManagePayment.jsp"); // Redirect to an error page
        }
        
        
    }
    
    public String getBackgroundColor(String status) {
        switch (status) {
            case "Pending":
                return "#ffd700"; // Gold color for pending option
            case "Approved":
                return "#32cd32"; // Lime green color for approved option
            case "Rejected":
                return "#ff6347"; // Tomato red color for rejected option
            default:
                return "#ffffff"; // Default background color (white)
        }
    }
}
