<%-- 
    Document   : DeleteStaff
    Created on : 7 Jan 2024, 10:56:50 pm
    Author     : FarisHarr
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Delete Staff</title>

<style>
            @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@500&display=swap');

            body {
                background-color: #F3FBF1;
            }

            h2,p{
                text-align: center;
            }

            header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                box-sizing: border-box;
                padding: auto;
                height: 65px;
                background-color: #bbd0bb;
            }

            .popup-content {
                background-color: #fefefe;
                margin: 8% auto;
                padding: 20px;
                border: 1px solid #24252a;
                border-radius: 10px;
                width: 40%;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.9);
                font-size: 22px;
            }

            .popup-content label {
                display: inline-block;
                width: 250px;
            }

            table {
                display: flex;
                justify-content: center;
            }

            form{
                display: flex;
                justify-content: center;
            }

            input {
                display: flex;
                justify-content: center;
                padding: 5px 15px;
                border-radius: 5px;
                border: 1px solid #24252a;
                background-color: #4CAF50;
                cursor: pointer;
                margin: 20px;
            }

            input:hover {
                background-color: #45a049;
                color: white;
                transform: scale(1.01);
            }

        </style>

    </head>
<%
    // Retrieve the staff ID from the request parameter
    String staffID = request.getParameter("staff_ID");

    // Check if the staff ID is present
    if (staffID != null && !staffID.isEmpty()) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");
            PreparedStatement pst = con.prepareStatement("SELECT * FROM staff WHERE staff_ID = ?");
            pst.setString(1, staffID);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                String name = rs.getString("staff_Name");
                String email = rs.getString("staff_Email");
                String phone = rs.getString("staff_Phone");
                String role = rs.getString("roles");
%>
                <div class="popup-content">
                    <h2>Delete Staff</h2>
                    <p><b>Are you sure you want to delete the following staff?</b></p>
                    <table>
                        <tr>
                            <td>ID :</td>
                            <td><%= staffID %></td>
                        </tr>
                        <tr>
                            <td>Name :</td>
                            <td><%= name %></td>
                        </tr>
                        <tr>
                            <td>Email :</td>
                            <td><%= email %></td>
                        </tr>
                        <tr>
                            <td>Phone :</td>
                            <td><%= phone %></td>
                        </tr>
                        <tr>
                            <td>Role :</td>
                            <td><%= role %></td>
                        </tr>
                    </table>

                    <form action="DeleteStaffServ" method="POST">
                        <input type="hidden" name="staffID" value="<%= staffID %>">
                        <input type="submit" name="action" value="Delete">
                        <input type="submit" name="action" value="Cancel">
                    </form>
                </div>
<%
            } else {
                out.println("Staff not found.");
            }

            con.close();
        } catch (Exception e) {
            out.println("Error: " + e);
        }
    } else {
        out.println("Invalid staff ID.");
    }
%>

        

        <script>
            function goBack() {
                // Redirect back to the previous page
                history.go(-1);
            }
        </script>
    </body>
</html>
