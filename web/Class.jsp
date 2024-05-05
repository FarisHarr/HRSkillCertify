<%-- 
    Document   : Class
    Created on : 1 May 2024, 3:29:18 pm
    Author     : FarisHarr
--%>

<%@ page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <title>Payment Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="CSS/HomePage.css">
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    </head>

    <style>
        .container {
            width: 50%;
            height: 100%;
            margin: 30px auto;
            padding: 20px;
            background-color: #f9f9f9;
            text-align: center;
            border-radius: 8px;
            justify-content: center;
            display: flex;
            flex-direction: column;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .container select,
        input[type="text"],
        input[type="file"] {
            width: 50%;
            padding: 10px;
            margin: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-top: 10px;
        }

        button {
            width: 30%;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background-color: #45a049;
        }

        .back-button {
            width: 5%;
            margin-top: 10px;
            background-color: #45a049;
            color: white;
            border: none;
            border-radius: 4px;
            padding: 5px 10px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
            display: inline-block;
        }

        .back-button:hover {
            background-color: #5f5f5f;
        }
    </style>

    <body>
        <%
            String candidateID = (String) session.getAttribute("candidateID");
            if (candidateID != null) {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");
                    PreparedStatement ps = con.prepareStatement("SELECT * FROM candidate WHERE cand_ID = ? ");
                    ps.setString(1, candidateID);
                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) {
                        String Name = rs.getString("cand_Name");
        %>

        <header>
            <div class="main">
                <a href="TimeTable.jsp">
                    <img class="logo" src="IMG/HRSCLogo.png" alt="logo">
                </a>
            </div>
            <nav>
                <ul>
                    <li class="dropdown">
                        <a class="nav-link"><%= Name%></a>
                        <ul class="dropdown-content">
                            <li><a href="CandidateProfile.jsp">User Profile</a></li>
                            <li><a href="MainPage.jsp" onclick="signOut()">Sign Out</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
        </header>


        <%
                    } else {
                        out.println("Candidate not found.");
                    }

                    rs.close();
                    ps.close();

                    con.close();
                } catch (Exception e) {
                    out.println("Error: " + e);
                }
            } else {
                // If the session doesn't exist or candidateID is not set, redirect to the login page
                response.sendRedirect("Login.jsp");
            }

        %>

        <div class="container">
            <h2>Time Table</h2> <br>

            
            <a href="javascript:history.back()" class="back-button">Back</a>
        </div>

        <script>

            function signOut() {
                // Redirect to the logout servlet or your logout logic
                window.location.href = 'LogOutServ'; // Replace 'LogoutServlet' with your actual logout servlet
            }

            function showSuccessMessage() {
                // Show a popup message
                alert("Payment submitted successfully!");
            }

            // Get today's date
            var today = new Date();

            // Format date as YYYY-MM-DD
            var year = today.getFullYear();
            var month = ('0' + (today.getMonth() + 1)).slice(-2);
            var day = ('0' + today.getDate()).slice(-2);
            var formattedDate = year + '-' + month + '-' + day;

            // Set the value of the hidden input field
            document.getElementById('date').value = formattedDate;

        </script>

        <footer>
            <p>&copy; HR SkillCertify 2023</p>
        </footer>

    </body>

</html>