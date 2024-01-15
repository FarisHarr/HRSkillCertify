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
@WebServlet("/RegisterStaffServ")
public class RegisterStaffServ extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        com.model.RegisterStaff staff = new com.model.RegisterStaff();

        staff.setIC(request.getParameter("IC"));
        staff.setName(request.getParameter("Name"));
        staff.setEmail(request.getParameter("Email"));
        staff.setPassword(request.getParameter("Password"));
        staff.setPhone(request.getParameter("Phone"));
        staff.setRole(request.getParameter("Role"));

        int result;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            String myURL = "jdbc:mysql://localhost/hrsc";
            try (Connection myConnection = DriverManager.getConnection(myURL, "root", "admin")) {
                String sInsertQry = "INSERT INTO staff(staff_IC, staff_Name, staff_Email, staff_Pass, staff_Phone, roles) VALUES (?,?,?,?,?,?) ";
                try (PreparedStatement myPS = myConnection.prepareStatement(sInsertQry)) {
                    myPS.setString(1, staff.getIC());
                    myPS.setString(2, staff.getName());
                    myPS.setString(3, staff.getEmail());
                    myPS.setString(4, staff.getPassword());
                    myPS.setString(5, staff.getPhone());
                    myPS.setString(6, staff.getRole());
                    
                    result = myPS.executeUpdate();
                }
            }

            if (result > 0) {
                response.sendRedirect("ManageStaff.jsp"); // Redirect to the desired page
            } else {
                response.getWriter().println("Registration failed. Please try again."); // Display error message
            }
        } catch (ClassNotFoundException | SQLException e) {
            response.getWriter().println("Error: " + e.getMessage()); // Display error message
        }
    }
}
