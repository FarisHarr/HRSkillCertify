package com.web;

import com.model.RegisterCert;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
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
            Connection myConnection = null;
            try {
                // Establish database connection
                Class.forName("com.mysql.jdbc.Driver");
                String myURL = "jdbc:mysql://localhost/hrsc";
                myConnection = DriverManager.getConnection(myURL, "root", "admin");
                
                // Check if cand_ID already exists in certificate table
                boolean candidateAlreadyRegistered = false;
                try (PreparedStatement checkStmt = myConnection.prepareStatement("SELECT cand_ID FROM certificate WHERE cand_ID = ?")) {
                    checkStmt.setString(1, candidateID);
                    ResultSet rs = checkStmt.executeQuery();
                    candidateAlreadyRegistered = rs.next(); // Check if candidate already registered
                }

                if (candidateAlreadyRegistered) {
                    // Candidate already registered for a certificate
                    response.getWriter().println("<script>alert('You have already registered for this certificate!'); window.location='TimeTable.jsp';</script>");
                    return;
                }

                // Prepare statement to insert file data into database
                String insertPaymentSQL = "INSERT INTO payment (cand_ID, cert_Type, price, date, status, receipt) VALUES (?, ?, ?, ?, ?, ?)";
                try (PreparedStatement insertPaymentStatement = myConnection.prepareStatement(insertPaymentSQL, Statement.RETURN_GENERATED_KEYS)) {
                    insertPaymentStatement.setString(1, candidateID);
                    insertPaymentStatement.setString(2, certType);
                    insertPaymentStatement.setString(3, price);
                    insertPaymentStatement.setDate(4, currentDate);
                    insertPaymentStatement.setString(5, status);
                    // Set the file data into the statement
                    insertPaymentStatement.setBlob(6, receipt);
                    // Execute the payment insertion SQL statement
                    int paymentRowsInserted = insertPaymentStatement.executeUpdate();
                    
                    // Retrieve the generated payment ID
                    int payment_ID = -1;
                    ResultSet generatedKeys = insertPaymentStatement.getGeneratedKeys();
                    if (generatedKeys.next()) {
                        payment_ID = generatedKeys.getInt(1);
                    }

                    if (paymentRowsInserted > 0 && payment_ID != -1) {
                        // Proceed with certificate insertion
                        String insertCertSQL = "INSERT INTO certificate(cert_ID, cand_ID, cert_Type, work_Type, experience) VALUES (DEFAULT, ?, ?, ?, ?)";
                        try (PreparedStatement insertCertStatement = myConnection.prepareStatement(insertCertSQL, Statement.RETURN_GENERATED_KEYS)) {
                            insertCertStatement.setString(1, certificate.getCandidateID());
                            insertCertStatement.setString(2, certificate.getCertType());
                            insertCertStatement.setString(3, certificate.getWorkType());
                            insertCertStatement.setString(4, certificate.getExperience());
                            // Execute the certificate insertion SQL statement
                            int certRowsInserted = insertCertStatement.executeUpdate();

                            // Retrieve the generated cert_ID
                            int cert_ID = -1;
                            ResultSet generatedCertKeys = insertCertStatement.getGeneratedKeys();
                            if (generatedCertKeys.next()) {
                                cert_ID = generatedCertKeys.getInt(1); // Retrieve the generated cert_ID
                            }

                            // Update payment with cert_ID
                            String updatePaymentSQL = "UPDATE payment SET cert_ID = ? WHERE payment_ID = ?";
                            try (PreparedStatement updatePaymentStatement = myConnection.prepareStatement(updatePaymentSQL)) {
                                updatePaymentStatement.setInt(1, cert_ID);
                                updatePaymentStatement.setInt(2, payment_ID);

                                int rowsUpdated = updatePaymentStatement.executeUpdate();

                                if (certRowsInserted > 0 && rowsUpdated > 0) {
                                    // Redirect to homepage upon successful registration
                                    String alertMessage = "Register Successfully";
                                    response.setContentType("text/html");
                                    String script = "<script>alert('" + alertMessage + "'); window.location.href='AboutCertificate.jsp';</script>";
                                    response.getWriter().println(script);
                                } else {
                                    String errorMessage = "Failed to add certificate details or update payment. Please try again.";
                                    request.setAttribute("errorMessage", errorMessage);
                                    RequestDispatcher dispatcher = request.getRequestDispatcher("CertificateForm.jsp");
                                    dispatcher.forward(request, response);
                                }
                            }
                        }
                    } else {
                        String errorMessage = "Failed to add payment details. Please try again.";
                        request.setAttribute("errorMessage", errorMessage);
                        RequestDispatcher dispatcher = request.getRequestDispatcher("CertificateForm.jsp");
                        dispatcher.forward(request, response);
                    }
                }
            } catch (Exception e) {
                response.getWriter().println("Error: " + e.getMessage());
            } finally {
                if (myConnection != null) {
                    try {
                        myConnection.close();
                    } catch (Exception e) {
                        response.getWriter().println("Error closing database connection: " + e.getMessage());
                    }
                }
            }
        } else {
            String errorMessage = "Uploaded file is not an image. Please upload an image file.";
            request.setAttribute("errorMessage", errorMessage);
            RequestDispatcher dispatcher = request.getRequestDispatcher("CertificateForm.jsp");
            dispatcher.forward(request, response);
        }
    }
}
