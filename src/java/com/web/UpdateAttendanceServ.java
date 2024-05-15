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

@WebServlet("/UpdateAttendanceServ")
public class UpdateAttendanceServ extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the form parameters
        int attendanceID = Integer.parseInt(request.getParameter("attendanceID"));
        String attendanceStatus = request.getParameter("attendanceStatus");

        // Update attendance status in the database
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");
            PreparedStatement ps = con.prepareStatement("UPDATE attendance SET attendance = ? WHERE attendance_ID = ?");
            ps.setString(1, attendanceStatus);
            ps.setInt(2, attendanceID);
            int rowsAffected = ps.executeUpdate();
            con.close();

            if (rowsAffected > 0) {
                // Redirect to homepage upon successful registration
                String alertMessage = "Update Successfull";
                response.setContentType("text/html");
                String script = "<script>alert('" + alertMessage + "'); window.location.href='ManageCertificate.jsp';</script>";
                response.getWriter().println(script);
            } else {
                response.sendRedirect("ManageCertificate.jsp"); // Redirect to an error page
            }
        } catch (Exception e) {
            response.sendRedirect("StaffDashboard.jsp"); // Redirect to an error page
        }
    }
}
