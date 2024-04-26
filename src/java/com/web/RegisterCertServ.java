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
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet("/RegisterCertServ")
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
//    Part filePart = request.getPart("receipt"); // Retrieves <input type="file" name="receipt">
//    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
//    String contentType = filePart.getContentType();

    // Check if the uploaded file is an image
//    if (contentType.startsWith("image/")) {
//        // Proceed with storing the image
//        InputStream fileContent = filePart.getInputStream();


        try {
            // Establish database connection
            Class.forName("com.mysql.jdbc.Driver");
            String myURL = "jdbc:mysql://localhost/hrsc";
            try (Connection myConnection = DriverManager.getConnection(myURL, "root", "admin")) {

////                 Check if candidate ID already exists
//                int count;
//                try (PreparedStatement checkIfExists = myConnection.prepareStatement("SELECT COUNT(*) FROM certificate WHERE cand_ID = ?")) {
//                    checkIfExists.setString(1, certificate.getCandidateID());
//                    ResultSet resultSet = checkIfExists.executeQuery();
//                    resultSet.next();
//                    count = resultSet.getInt(1);
//                }
//
//                // check if candidate dah register certificate
//                if (count > 0) {
//                    // Show popup message for certificate registration
//                    String alertMessage = "You are already registered for this certificate.";
//                    response.setContentType("text/html");
//                    response.getWriter().println("<script>alert('" + alertMessage + "'); window.location.href='AboutCertificate.jsp';</script>");
//                    return; // Exit the method
//                }
                
                // If candidate ID does not exist, proceed with certificate insertion
                try (PreparedStatement insertCertStatement = myConnection.prepareStatement("INSERT INTO certificate(cand_ID, cert_Type, work_Type, experience) VALUES (?, ?, ?, ?)")) {
                    insertCertStatement.setString(1, certificate.getCandidateID());
                    insertCertStatement.setString(2, certificate.getCertType());
                    insertCertStatement.setString(3, certificate.getWorkType());
                    insertCertStatement.setString(4, certificate.getExperience());

                    // Execute the certificate insertion SQL statement
                    int certRowsInserted = insertCertStatement.executeUpdate();

                    if (certRowsInserted > 0) {
                        // Proceed with payment insertion
                        try (PreparedStatement insertPaymentStatement = myConnection.prepareStatement("INSERT INTO payment (cand_ID, cert_Type, price, date, status) VALUES (?, ?, ?, ?, ?)")) {
                            insertPaymentStatement.setString(1, candidateID);
                            insertPaymentStatement.setString(2, certType);
                            insertPaymentStatement.setString(3, price);
                            insertPaymentStatement.setDate(4, currentDate);
                            insertPaymentStatement.setString(5, status);

//                            try (PreparedStatement insertPaymentStatement = myConnection.prepareStatement("INSERT INTO payment (cand_ID, price, date, status, receipt) VALUES (?, ?, ?, ?, ?)")) {
//                                insertPaymentStatement.setString(1, candidateID);
//                                insertPaymentStatement.setString(2, price);
//                                insertPaymentStatement.setDate(3, currentDate);
//                                insertPaymentStatement.setString(4, status);
////                                insertPaymentStatement.setBlob(5, receipt);
//
//// Set the file data into the statement
//                            insertPaymentStatement.setBlob(5, fileContent);

                            // Execute the payment insertion SQL statement
                            int paymentRowsInserted = insertPaymentStatement.executeUpdate();

                            // Provide feedback to the user
                            if (paymentRowsInserted > 0) {
                                // Redirect to homepage upon successful payment
                                response.sendRedirect("HomePage.jsp");
                            } else {
                                String errorMessage = "Failed to add payment details. Please try again.";
                                request.setAttribute("errorMessage", errorMessage);
                                RequestDispatcher dispatcher = request.getRequestDispatcher("CandidateProfile.jsp");
                                dispatcher.forward(request, response);
                            }
                        }
                    } else {
                        String errorMessage = "Failed to register certificate. Please try again.";
                        request.setAttribute("errorMessage", errorMessage);
                        RequestDispatcher dispatcher = request.getRequestDispatcher("AboutCertificate.jsp");
                        dispatcher.forward(request, response);
                    }
                }
            }
        } catch (Exception e) {
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}

