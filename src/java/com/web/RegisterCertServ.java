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

        // Check if the candidate already has a certificate
        // Inside the doPost method
        if (candidateAlreadyHasCertificate(candidateID)) {
            // Create JavaScript alert message
            String alertMessage = "You have already applied for a certificate.";
            // Set content type to HTML
            response.setContentType("text/html");
            // Write JavaScript to response
            response.getWriter().println("<script>alert('" + alertMessage + "'); window.location.href='AboutCertificate.jsp';</script>");
            return; // Exit the method
        }

        RegisterCert certificate = new RegisterCert();
        certificate.setCandidateID(candidateID); // Set candidate ID

        certificate.setCertificate(request.getParameter("certificate"));
        certificate.setWorkType(request.getParameter("workType"));
        certificate.setExperience(request.getParameter("experience"));

        try {
            Class.forName("com.mysql.jdbc.Driver");
            String myURL = "jdbc:mysql://localhost/hrsc";

            try (Connection myConnection = DriverManager.getConnection(myURL, "root", "admin"); PreparedStatement ps = myConnection.prepareStatement("INSERT INTO certificate(cand_ID, cert_Type, work_Type, experience) VALUES (?, ?, ?, ?)")) {

                ps.setString(1, certificate.getCandidateID());
                ps.setString(2, certificate.getCertificate());
                ps.setString(3, certificate.getWorkType());
                ps.setString(4, certificate.getExperience());

                // Execute the SQL statement
                int rowsInserted = ps.executeUpdate();

                // Close resources
                ps.close();

                // Provide feedback to the user
                if (rowsInserted > 0) {
                    // Redirect to payment.jsp
                    RequestDispatcher dispatcher = request.getRequestDispatcher("Payment.jsp");
                    dispatcher.forward(request, response);
                } else {
                    response.getWriter().println("Failed to register certificate. Please try again.");
                }
            }
        } catch (Exception e) {
            response.getWriter().println("Error: " + e.getMessage());
        }
    }

    // Method to check if the candidate already has a certificate
    private boolean candidateAlreadyHasCertificate(String candidateID) {
        boolean hasCertificate = false;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            String myURL = "jdbc:mysql://localhost/hrsc";

            try (Connection myConnection = DriverManager.getConnection(myURL, "root", "admin"); PreparedStatement ps = myConnection.prepareStatement("SELECT * FROM certificate WHERE cand_ID = ?")) {

                // Set candidate ID in the prepared statement
                ps.setString(1, candidateID);

                // Execute the SQL query
                ResultSet rs = ps.executeQuery();

                // Check if the result set contains any rows
                if (rs.next()) {
                    hasCertificate = true; // Candidate already has a certificate
                }

                // Close resources
                rs.close();
                ps.close();
            }
        } catch (Exception e) {
            // Handle exceptions
        }

        return hasCertificate;
    }
}
