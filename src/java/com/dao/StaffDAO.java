/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author FarisHarr
 */
public class StaffDAO {
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/hrsc";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "admin";

    public boolean updateStaff(String id, String ic, String name, String email, String password, String phone, String roles) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String updateQuery = "UPDATE staff SET staff_IC = ?, staff_Name = ?, staff_Email = ?, staff_Pass = ?, staff_Phone = ? WHERE staff_ID = ?";
                try (PreparedStatement st = con.prepareStatement(updateQuery)) {
                    st.setString(1, ic);
                    st.setString(2, name);
                    st.setString(3, email);
                    st.setString(4, password);
                    st.setString(5, phone);
                    st.setString(6, id);

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