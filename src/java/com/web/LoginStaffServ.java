/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginStaffServ")
public class LoginStaffServ extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String IC = request.getParameter("IC");
        String Password = request.getParameter("Password");
        String userType = request.getParameter("user-type");

        if (IC != null && Password != null && userType != null) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                String myURL = "jdbc:mysql://localhost/hrsc";
                try (Connection myConnection = DriverManager.getConnection(myURL, "root", "admin")) {
                    String sSelectQry = "SELECT * FROM staff WHERE staff_IC = ? AND staff_Pass = ? AND roles = ?";
                    try (PreparedStatement myPS = myConnection.prepareStatement(sSelectQry)) {
                        myPS.setString(1, IC);
                        myPS.setString(2, Password);
                        myPS.setString(3, userType);
                        try (ResultSet resultSet = myPS.executeQuery()) {
                            if (resultSet.next()) {
                                // User found, set session and redirect to the appropriate page
                                HttpSession loginsession = request.getSession();
                                loginsession.setAttribute("staffID", resultSet.getString("staff_ID"));

                                if (userType.equals("administrator")) {
                                    response.sendRedirect("AdminDashboard.jsp");
                                } else if (userType.equals("coordinator")){
                                    response.sendRedirect("StaffDashboard.jsp");
                                }
                            } else {
                                // User not found, set error message attribute
                                request.setAttribute("errorMessage", "Invalid Role or IC or Password. Please try again.");
                                // Forward to LoginStaff.jsp
                                RequestDispatcher dispatcher = request.getRequestDispatcher("/LoginStaff.jsp");
                                dispatcher.forward(request, response);
                            }
                        }
                    }
                }
            } catch (ClassNotFoundException | SQLException e) {
                // An error occurred, set error message attribute
                request.setAttribute("errorMessage", "An error occurred. Maybe not connect to database.");
                // Forward to LoginStaff.jsp
                RequestDispatcher dispatcher = request.getRequestDispatcher("/LoginStaff.jsp");
                dispatcher.forward(request, response);
            }
        }
    }
}
