package com.web;

import com.model.RegisterCert;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet("/RegisterCertServ")
@MultipartConfig
public class RegisterCertServ extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(); // Get the session
        String candidateID = (String) session.getAttribute("candidateID"); // Retrieve candidate ID from session

        RegisterCert certificate = new RegisterCert();
        certificate.setCandidateID(candidateID); // Set candidate ID

        certificate.setCertType(request.getParameter("certType"));
        certificate.setWorkType(request.getParameter("workType"));
        certificate.setExperience(request.getParameter("experience"));

        String price = request.getParameter("price");
        java.sql.Date currentDate = new java.sql.Date(System.currentTimeMillis());
        String status = request.getParameter("status");
        String certType = request.getParameter("certType");

        // Handling file upload
        Part filePart = request.getPart("receipt"); // Retrieves <input type="file" name="receipt">
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String contentType = filePart.getContentType();
        // Check if the uploaded file is an image
        if (contentType.startsWith("image/")) {
            // Proceed with storing the image
            InputStream receipt = filePart.getInputStream();
            try {
                // Establish database connection
                Class.forName("com.mysql.jdbc.Driver");
                String myURL = "jdbc:mysql://localhost/hrsc";
                try (Connection myConnection = DriverManager.getConnection(myURL, "root", "admin")) {
                    // Prepare statement to insert file data into database
                    try (PreparedStatement insertPaymentStatement = myConnection.prepareStatement("INSERT INTO payment (cand_ID, cert_Type, price, date, status, receipt) VALUES (?, ?, ?, ?, ?, ?)")) {
                        insertPaymentStatement.setString(1, candidateID);
                        insertPaymentStatement.setString(2, certType);
                        insertPaymentStatement.setString(3, price);
                        insertPaymentStatement.setDate(4, currentDate);
                        insertPaymentStatement.setString(5, status);
                        // Set the file data into the statement
                        insertPaymentStatement.setBlob(6, receipt);
                        // Execute the payment insertion SQL statement
                        int paymentRowsInserted = insertPaymentStatement.executeUpdate();
                        // Provide feedback to the user
                        if (paymentRowsInserted > 0) {
                            // Proceed with certificate insertion
                            try (PreparedStatement insertCertStatement = myConnection.prepareStatement("INSERT INTO certificate(cand_ID, cert_Type, work_Type, experience) VALUES (?, ?, ?, ?)")) {
                                insertCertStatement.setString(1, certificate.getCandidateID());
                                insertCertStatement.setString(2, certificate.getCertType());
                                insertCertStatement.setString(3, certificate.getWorkType());
                                insertCertStatement.setString(4, certificate.getExperience());
                                // Execute the certificate insertion SQL statement
                                int certRowsInserted = insertCertStatement.executeUpdate();
                                // Provide feedback to the user
                                if (certRowsInserted > 0) {
                                    // Redirect to homepage upon successful registration
                                    String alertMessage = "Register Successfully";
                                    response.setContentType("text/html");
                                    String script = "<script>alert('" + alertMessage + "'); window.location.href='HomePage.jsp';</script>";
                                    response.getWriter().println(script);
                                } else {
                                    String errorMessage = "Failed to add certificate details. Please try again.";
                                    request.setAttribute("errorMessage", errorMessage);
                                    RequestDispatcher dispatcher = request.getRequestDispatcher("CandidateProfile.jsp");
                                    dispatcher.forward(request, response);
                                }
                            }
                        } else {
                            String errorMessage = "Failed to add payment details. Please try again.";
                            request.setAttribute("errorMessage", errorMessage);
                            RequestDispatcher dispatcher = request.getRequestDispatcher("CandidateProfile.jsp");
                            dispatcher.forward(request, response);
                        }
                    }
                }
            } catch (Exception e) {
                response.getWriter().println("Error: " + e.getMessage());
            }
        } else {
            String errorMessage = "Uploaded file is not an image. Please upload an image file.";
            request.setAttribute("errorMessage", errorMessage);
            RequestDispatcher dispatcher = request.getRequestDispatcher("AboutCertificate.jsp");
            dispatcher.forward(request, response);
        }
    }
}
