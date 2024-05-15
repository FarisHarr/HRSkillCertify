/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import java.sql.ResultSet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AttendanceServ", urlPatterns = {"/AttendanceServ"})
public class AttendanceServ extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form parameters
        String classID = request.getParameter("class_ID");
        String candID = request.getParameter("cand_ID");
        String attendance = "--"; // Defaulting to "attend"

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String myURL = "jdbc:mysql://localhost/hrsc";

            try (Connection myConnection = DriverManager.getConnection(myURL, "root", "admin")) {
                // Check if the user has already applied for this classID
                try (PreparedStatement checkStatement = myConnection.prepareStatement("SELECT * FROM attendance WHERE class_ID = ? AND cand_ID = ?")) {
                    checkStatement.setString(1, classID);
                    checkStatement.setString(2, candID);
                    try (ResultSet checkResult = checkStatement.executeQuery()) {
                        if (checkResult.next()) {
                            // If a record already exists, inform the user
                            response.getWriter().println("<script>alert('You have already applied for this class!'); window.location='TimeTable.jsp';</script>");
                        } else {
                            // If no record exists, insert a new attendance record
                            try (PreparedStatement insertStatement = myConnection.prepareStatement("INSERT INTO attendance(class_ID, cand_ID, attendance) VALUES (?, ?, ?)")) {
                                insertStatement.setString(1, classID);
                                insertStatement.setString(2, candID);
                                insertStatement.setString(3, attendance);
                                int rowsInserted = insertStatement.executeUpdate();

                                if (rowsInserted > 0) {
                                    response.getWriter().println("<script>alert('Attendance registered successfully!'); window.location='TimeTable.jsp';</script>");
                                } else {
                                    response.getWriter().println("<script>alert('Failed to register attendance.'); window.location='TimeTable.jsp';</script>");
                                }
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}





