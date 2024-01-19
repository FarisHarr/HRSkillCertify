package com.web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/NewPassword")
public class NewPassword extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String IC = request.getParameter("IC");
        String password = request.getParameter("Password");
        RequestDispatcher dispatcher = null;

        if (IC != null && password != null && !IC.equals(password)) {
            try {
                // Load JDBC driver and establish a connection
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");

                // Check if the candidate with the given IC exists
                PreparedStatement checkStmt = con.prepareStatement("SELECT * FROM candidate WHERE cand_IC = ?");
                checkStmt.setString(1, IC);
                ResultSet resultSet = checkStmt.executeQuery();

                if (resultSet.next()) {
                    // Candidate with the given IC exists, update the password
                    PreparedStatement updateStmt = con.prepareStatement("UPDATE candidate SET cand_Pass = ? WHERE cand_IC = ?");
                    updateStmt.setString(1, password);
                    updateStmt.setString(2, IC);

                    int rowCount = updateStmt.executeUpdate();

                    if (rowCount > 0) {
                        // Password update successful, set success message attribute
                        request.setAttribute("status", "resetSuccess");
                        dispatcher = request.getRequestDispatcher("Login.jsp");
                    } else {
                        // Password update failed, set error message attribute
                        request.setAttribute("status", "Invalid. Please try again.");
                        dispatcher = request.getRequestDispatcher("Login.jsp");
                    }
                } else {
                    // Candidate with the given IC doesn't exist, set error message attribute
                    request.setAttribute("status", "Candidate not found. Please check your IC.");
                    dispatcher = request.getRequestDispatcher("Login.jsp");
                }

                // Close the connections
                resultSet.close();
                checkStmt.close();
                con.close();

            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            // Invalid input, set error message attribute
            request.setAttribute("status", "Invalid input. Please try again.");
            dispatcher = request.getRequestDispatcher("Login.jsp");
        }

        dispatcher.forward(request, response);
    }
}

