package com.web;

import com.model.RegisterCert;
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

@WebServlet("/RegisterCertServ")
public class RegisterCertServ extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(); // Get the session
        String candidateID = (String) session.getAttribute("candidateID"); // Retrieve candidate ID from session

        RegisterCert certificate = new RegisterCert();
        certificate.setCandidateID(candidateID); // Set candidate ID

        certificate.setCertificate(request.getParameter("certificate"));
        certificate.setWorkType(request.getParameter("workType"));
        certificate.setExperience(request.getParameter("experience"));

        try {
            Class.forName("com.mysql.jdbc.Driver");
            String myURL = "jdbc:mysql://localhost/hrsc";

            try (Connection myConnection = DriverManager.getConnection(myURL, "root", "admin"); PreparedStatement checkIfExists = myConnection.prepareStatement("SELECT COUNT(*) FROM certificate WHERE cand_ID = ?"); PreparedStatement insertStatement = myConnection.prepareStatement("INSERT INTO certificate(cand_ID, cert_Type, work_Type, experience) VALUES (?, ?, ?, ?)")) {

                // Check if candidate ID already exists
                checkIfExists.setString(1, certificate.getCandidateID());
                ResultSet resultSet = checkIfExists.executeQuery();
                resultSet.next();
                int count = resultSet.getInt(1);
                resultSet.close();
                
                if (count > 0) {
                    // Show popup message
                    String alertMessage = "Yor are already registered for this certificate.";
                    response.setContentType("text/html");
                    response.getWriter().println("<script>alert('" + alertMessage + "'); window.location.href='AboutCertificate.jsp';</script>");
                    return; // Exit the method
                }

                // If candidate ID does not exist, proceed with insertion
                insertStatement.setString(1, certificate.getCandidateID());
                insertStatement.setString(2, certificate.getCertificate());
                insertStatement.setString(3, certificate.getWorkType());
                insertStatement.setString(4, certificate.getExperience());

                // Execute the SQL statement
                int rowsInserted = insertStatement.executeUpdate();

                // Provide feedback to the user
                if (rowsInserted > 0) {
                    // Redirect to payment.jsp
                    RequestDispatcher dispatcher = request.getRequestDispatcher("Payment.jsp");
                    dispatcher.forward(request, response);
                } else {
                    String errorMessage = "Failed to register certificate. Please try again.";
                    request.setAttribute("errorMessage", errorMessage);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("AboutCertificate.jsp");
                    dispatcher.forward(request, response);
                }
            }
        } catch (Exception e) {
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}




