/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.*;

public class CandidateDAO {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/hrsc";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "admin";

    // Update candidate information including the certificate
    public boolean updateCandidate(String id, String ic, String name, String email, String password, String phone, String address, String certificate) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String updateQuery = "UPDATE candidate SET cand_IC = ?, cand_Name = ?, cand_Email = ?, cand_Pass = ?, cand_Phone = ?, cand_Add = ?  WHERE cand_ID = ?";
                try (PreparedStatement st = con.prepareStatement(updateQuery)) {
                    st.setString(1, ic);
                    st.setString(2, name);
                    st.setString(3, email);
                    st.setString(4, password);
                    st.setString(5, phone);
                    st.setString(6, address);
//                    st.setString(7, certificate);
                    st.setString(7, id);

                    int rowsUpdated = st.executeUpdate();
                    return rowsUpdated > 0;
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Fetch the certificate value
    public String getCertificate(String candID) {
        String certificate = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String query = "SELECT cand_Certificate FROM candidate WHERE cand_ID = ?";
                try (PreparedStatement st = con.prepareStatement(query)) {
                    st.setString(1, candID);
                    try (ResultSet rs = st.executeQuery()) {
                        if (rs.next()) {
                            certificate = rs.getString("cand_Certificate");
                        }
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return certificate;
    }
    
    public boolean hasCertificateType(String candID, String certType) {
    try {
        Class.forName("com.mysql.jdbc.Driver");
        try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String query = "SELECT cand_Certificate FROM candidate WHERE cand_ID = ?";
            try (PreparedStatement statement = con.prepareStatement(query)) {
                statement.setString(1, candID);
                ResultSet rs = statement.executeQuery();
                if (rs.next()) {
                    String certificate = rs.getString("cand_Certificate");
                    // Check if the candidate's certificate is null in the candidate table
                    if (certificate == null || certificate.isEmpty()) {
                        // Check if the candidate ID does not have an entry in the certificate table
                        String certificateQuery = "SELECT * FROM certificate WHERE cand_ID = ?";
                        try (PreparedStatement certStatement = con.prepareStatement(certificateQuery)) {
                            certStatement.setString(1, candID);
                            ResultSet certRS = certStatement.executeQuery();
                            return !certRS.next(); // Return true if no entry found in the certificate table
                        }
                    }
                }
            }
        }
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
    }
    return false;
}


    // Update certificate only
    public boolean updateCertificate(String candID, String certificate) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String updateQuery = "UPDATE candidate SET cand_Certificate = ? WHERE cand_ID = ?";
                try (PreparedStatement st = con.prepareStatement(updateQuery)) {
                    st.setString(1, certificate);
                    st.setString(2, candID);

                    int rowsUpdated = st.executeUpdate();
                    return rowsUpdated > 0;
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
