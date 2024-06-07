/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
@WebServlet("/FeedbackServ")
public class FeedbackServ extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(); // Get the session
        String candidateID = (String) session.getAttribute("candidateID"); // Retrieve candidate ID from session

        // Get form parameters
        String feedback = request.getParameter("feedback_ID");
        String message = request.getParameter("message");
//        String reply = request.getParameter("response");
        String reply = "--"; // Defaulting to "attend"

        try {
            Class.forName("com.mysql.jdbc.Driver");
            String myURL = "jdbc:mysql://localhost/hrsc";

            try (Connection myConnection = DriverManager.getConnection(myURL, "root", "admin"); PreparedStatement ps = myConnection.prepareStatement("INSERT INTO feedback(feedback_ID, cand_ID, message, response) VALUES (?, ?, ?,?)")) {

                ps.setString(1, feedback);
                ps.setString(2, candidateID);
                ps.setString(3, message);
                ps.setString(4, reply);

                // Execute the SQL statement
                int rowsInserted = ps.executeUpdate();

                // Close resources
                ps.close();

                // Provide feedback to the user
                if (rowsInserted > 0) {

                    // Set content type to HTML
                    response.setContentType("text/html");

                    response.getWriter().println("<script>alert('Feedback submitted successfully!'); window.location='Feedback.jsp';</script>");

                } else {
                    // Redirect to feedback page
                    response.sendRedirect("Feedback.jsp");
                }
            }
        } catch (Exception e) {
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
