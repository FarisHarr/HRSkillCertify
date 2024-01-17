/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.web;

import com.model.Register;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;

@WebServlet("/RegisterServ")
public class RegisterServ extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Register candidate = new Register();

        candidate.setIC(request.getParameter("IC"));
        candidate.setName(request.getParameter("Name"));
        candidate.setEmail(request.getParameter("Email"));
        candidate.setPassword(request.getParameter("Password"));
        candidate.setPhone(request.getParameter("Phone"));
        candidate.setAddress(request.getParameter("Address"));

        int result;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            String myURL = "jdbc:mysql://localhost/hrsc";

            try (Connection myConnection = DriverManager.getConnection(myURL, "root", "admin"); PreparedStatement myPS = myConnection.prepareStatement("INSERT INTO candidate(cand_IC, cand_Name, cand_Email, cand_Pass, cand_Phone, cand_Add) VALUES (?,?,?,?,?,?)")) {

                myPS.setString(1, candidate.getIC());
                myPS.setString(2, candidate.getName());
                myPS.setString(3, candidate.getEmail());
                myPS.setString(4, candidate.getPassword());
                myPS.setString(5, candidate.getPhone());
                myPS.setString(6, candidate.getAddress());

                result = myPS.executeUpdate();

                if (result > 0) {
                    response.sendRedirect("Login.jsp"); // Redirect to login page
                } else {
                    request.setAttribute("errorMessage", "The IC number has been registered.");
                }

            } catch (SQLException e) {
                if (e.getSQLState().equals("23000") && e.getErrorCode() == 1062) {
                    // Duplicate entry error (SQLState 23000, MySQL error code 1062)
                    request.setAttribute("errorMessage", "The IC number has been registered.");

                    // Set the candidate object as an attribute to retain the entered values
                    request.setAttribute("candidate", candidate);

                    // Forward to register.jsp
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/Register.jsp");
                    dispatcher.forward(request, response);
                } else {
                    e.printStackTrace(); // Log the exception
                }
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}
