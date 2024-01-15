/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.web;

import com.dao.CandidateDAO;
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
// Import statements

@WebServlet("/UpdateCandidateServ")
public class UpdateCandidateServ extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ID = request.getParameter("id");
        String IC = request.getParameter("ic");
        String Name = request.getParameter("name");
        String Email = request.getParameter("email");
        String Password = request.getParameter("password");
        String Phone = request.getParameter("phone");
        String Address = request.getParameter("address");

        CandidateDAO candidateDao = new CandidateDAO();
        boolean isUpdated = candidateDao.updateCandidate(ID, IC, Name, Email, Password, Phone, Address);

        if (isUpdated) {
            request.setAttribute("message", "Candidate updated successfully.");
        } else {
            request.setAttribute("message", "Candidate not found or couldn't be updated.");
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/CandidateProfile.jsp");
        dispatcher.forward(request, response);
    }
}
