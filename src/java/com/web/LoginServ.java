/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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

@WebServlet("/LoginServ")
public class LoginServ extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String IC = request.getParameter("IC");
        String Password = request.getParameter("Password");

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        if (IC != null && Password != null) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                String myURL = "jdbc:mysql://localhost/hrsc";
                try (Connection myConnection = DriverManager.getConnection(myURL, "root", "admin")) {
                    String sSelectQry = "SELECT * FROM candidate WHERE cand_IC = ? AND cand_Pass = ?";
                    try (PreparedStatement myPS = myConnection.prepareStatement(sSelectQry)) {
                        myPS.setString(1, IC);
                        myPS.setString(2, Password);
                        try (ResultSet resultSet = myPS.executeQuery()) {
                            if (resultSet.next()) {
                                // User found, set session and redirect to home page
                                HttpSession loginsession = request.getSession();
                                loginsession.setAttribute("candidateID", resultSet.getString("cand_ID"));
                                loginsession.setAttribute("redirect", "true");
                                response.sendRedirect("Login.jsp");
                            } else {
                                // User not found, set error message attribute
                                request.setAttribute("errorMessage", "Invalid IC or password. Please try again.");
                                // Forward to login.jsp
                                RequestDispatcher dispatcher = request.getRequestDispatcher("/Login.jsp");
                                dispatcher.forward(request, response);
                            }
                        }
                    }
                }
            } catch (ClassNotFoundException | SQLException e) {
                // An error occurred, set error message attribute
                request.setAttribute("errorMessage", "An error occurred. Maybe not connect to the database.");
                // Forward to login.jsp
                RequestDispatcher dispatcher = request.getRequestDispatcher("/Login.jsp");
                dispatcher.forward(request, response);
            }
        }

    }
}
