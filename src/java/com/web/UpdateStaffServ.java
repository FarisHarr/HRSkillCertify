/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.web;

import com.dao.StaffDAO;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet("/UpdateStaffServ")
public class UpdateStaffServ extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ID = request.getParameter("id");
        String IC = request.getParameter("ic");
        String Name = request.getParameter("name");
        String Email = request.getParameter("email");
        String Password = request.getParameter("password");
        String Phone = request.getParameter("phone");
        String Role = request.getParameter("roles");

        StaffDAO staffDao = new StaffDAO();
        boolean isUpdated = staffDao.updateStaff(ID, IC, Name, Email, Password, Phone, Role);

        if (isUpdated) {
            request.setAttribute("message", "Staff updated successfully.");
        } else {
            request.setAttribute("message", "Staff not found or couldn't be updated.");
        }

        response.getWriter().println("<script>alert('Profile updated successfully.'); window.location='ManagerProfile.jsp';</script>");
//        RequestDispatcher dispatcher = request.getRequestDispatcher("/ManagerProfile.jsp");
//        dispatcher.forward(request, response);
    }
}
