/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class CandidateDAO {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/hrsc";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "admin";

    public boolean updateCandidate(String id, String ic, String name, String email, String password, String phone, String address) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String updateQuery = "UPDATE candidate SET cand_IC = ?, cand_Name = ?, cand_Email = ?, cand_Pass = ?, cand_Phone = ?, cand_Add = ? WHERE cand_ID = ?";
                try (PreparedStatement st = con.prepareStatement(updateQuery)) {
                    st.setString(1, ic);
                    st.setString(2, name);
                    st.setString(3, email);
                    st.setString(4, password);
                    st.setString(5, phone);
                    st.setString(6, address);
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
}
