/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.web;

import com.mysql.cj.xdevapi.Statement;
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

/**
 *
 * @author FarisHarr
 */
@WebServlet(name = "RegisterClassServ", urlPatterns = {"/RegisterClassServ"})
public class RegisterClassServ extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form parameters
        String certType = request.getParameter("cert_Type");
        String date = request.getParameter("date");
        String startTime = request.getParameter("start_time");
        String endTime = request.getParameter("end_Time");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            String myURL = "jdbc:mysql://localhost/hrsc";

            try (Connection myConnection = DriverManager.getConnection(myURL, "root", "admin"); PreparedStatement ps = myConnection.prepareStatement("INSERT INTO class(cert_Type, date, start_Time, end_Time) VALUES (?, ?, ?, ?)")) {

                ps.setString(1, certType);
                ps.setString(2, date);
                ps.setString(3, startTime);
                ps.setString(4, endTime);

                // Execute the SQL statement
                int rowsInserted = ps.executeUpdate();

                // Provide feedback to the user
                if (rowsInserted > 0) {
                    // Set content type to HTML
                    response.setContentType("text/html");

                    response.getWriter().println("<script>alert('Attendance registered successfully!'); window.location='ManageCertificate.jsp';</script>");

                } else {
                    // Redirect to attendance page
                    response.sendRedirect("ManageCertificate.jsp");
                }
            }
        } catch (Exception e) {
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
