<%-- 
    Document   : DeleteCandidate
    Created on : 17 Jan 2024, 6:41:27 pm
    Author     : FarisHarr
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Delete Candidate</title>

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
        // Retrieve the cand ID from the request parameter
        String candID = request.getParameter("cand_ID");

        // Check if the cand ID is present
        if (candID != null && !candID.isEmpty()) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");
                PreparedStatement pst = con.prepareStatement("SELECT * FROM candidate WHERE cand_ID = ?");
                pst.setString(1, candID);
                ResultSet rs = pst.executeQuery();

                if (rs.next()) {
                    String IC = rs.getString("cand_IC");
                    String name = rs.getString("cand_Name");
                    String email = rs.getString("cand_Email");
                    String phone = rs.getString("cand_Phone");
    %>
    <div class="popup-content">
        <h2>Remove Candidate</h2>
        <p><b>Are you sure you want to delete the following candidate?</b></p>
        <table>
            <tr>
                <td>ID :</td>
                <td><%= candID%></td>
            </tr>
            <tr>
                <td>IC :</td>
                <td><%= IC%></td>
            </tr>
            <tr>
                <td>Name :</td>
                <td><%= name%></td>
            </tr>
            <tr>
                <td>Email :</td>
                <td><%= email%></td>
            </tr>
            <tr>
                <td>Phone :</td>
                <td><%= phone%></td>
            </tr>

        </table>

        <form action="DeleteCandidateServ" method="POST">
            <input type="hidden" name="candID" value="<%= candID%>">
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

