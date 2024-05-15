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
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author FarisHarr
 */
@WebServlet("/DeleteClassServ")
public class DeleteClassServ extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String classID = request.getParameter("classID");
        String action = request.getParameter("action");

        if (action != null && action.equals("Delete")) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin")) {
                    PreparedStatement pst = con.prepareStatement("DELETE FROM class WHERE class_ID = ?");
                    pst.setString(1, classID);
                    int rowsDeleted = pst.executeUpdate();
                    
                    if (rowsDeleted > 0) {
                        response.getWriter().println("<script>alert('Class has been removed'); window.location='ManageCertificate.jsp';</script>");
                    } else {
                        request.setAttribute("errorMessage", "Class not found or couldn't be deleted.");
                        RequestDispatcher dispatcher = request.getRequestDispatcher("/TestPage.jsp");
                        dispatcher.forward(request, response);
                    }
                }
            } catch (IOException | ClassNotFoundException | SQLException | ServletException e) {
                request.setAttribute("errorMessage", "Error: " + e.getMessage());
                RequestDispatcher dispatcher = request.getRequestDispatcher("/ErrorPage.jsp");
                dispatcher.forward(request, response);
            }
        } else if (action != null && action.equals("Cancel")) {
            // Redirect back to the previous page
            response.sendRedirect("DeleteClass.jsp");
        }
    }
}

