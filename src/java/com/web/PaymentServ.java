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
//@MultipartConfig(maxFileSize = 16177215) // 16 MB
public class PaymentServ extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String cand_ID = (String) session.getAttribute("candidateID");

//        String payment = request.getParameter("payment_ID");
        String price = request.getParameter("price");
        String date = request.getParameter("date");
//        String status = request.getParameter("status");

        Connection con = null;
        String message = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");
            String myURL = "INSERT INTO payment (cand_ID, price, date) VALUES (?, ?, ?)";
            PreparedStatement statement = con.prepareStatement(myURL);
//            statement.setString(1, payment);
            statement.setString(1, cand_ID);
            statement.setString(2, price);
            statement.setString(3, date);
//            statement.setString(5, status);
            int row = statement.executeUpdate();
            if (row > 0) {
                message = "Payment details added successfully!";
                // Redirect to Homepage.jsp upon successful payment
                response.sendRedirect("HomePage.jsp");
                return; // Exit the method to prevent further processing
            }
        } catch (ClassNotFoundException | SQLException e) {
            message = "ERROR: " + e.getMessage();
            // Print the stack trace for debugging purposes
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    // Print the stack trace for debugging purposes

                }
            }
        }
        request.setAttribute("Message", message);
        getServletContext().getRequestDispatcher("/CandidateProfile.jsp").forward(request, response);
    }
}
