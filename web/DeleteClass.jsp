<%-- 
    Document   : DeleteClass
    Created on : 14 May 2024, 11:22:49 pm
    Author     : FarisHarr
--%>

<%@ page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Delete Class</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="CSS/Class.css">
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <!--<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet">-->
    </head>
    <body>
        <header>
            <div class="main">
                <a href="ManageCertificate.jsp">
                    <img class="logo" src="IMG/HRSCLogo.png" alt="logo">
                </a>
            </div>
            <nav>
                <li class="dropdown">
                    <a class="nav-link">Manager</a>
                    <ul class="dropdown-content">
                        <li><a href="ManagerProfile.jsp">User Profile</a></li>
                        <li><a href="MainPage.jsp" onclick="signOut()">Sign Out</a></li>
                    </ul>
                </li>
            </nav>
        </header>
        
        <br><h2>Time Table</h2>
        <div class="container1">
            <div class="table">
                <table>
                    <thead>
                        <tr>
                            <th>Class ID</th>
                            <th>Date</th>
                            <th>Start Time</th>
                            <th>End Time</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");
                                Statement st = con.createStatement();
                                ResultSet rs = st.executeQuery("SELECT class_ID, date, start_Time, end_Time FROM class");

                                while (rs.next()) {
                                    String classID = rs.getString("class_ID");
                                    String date = rs.getString("date");
                                    String startTime = rs.getString("start_Time");
                                    String endTime = rs.getString("end_Time");

                                    out.println("<tr>");
                                    out.println("<td>" + classID + "</td>");
                                    out.println("<td>" + date + "</td>");
                                    out.println("<td>" + startTime + "</td>");
                                    out.println("<td>" + endTime + "</td>");
                                    out.println("<td>");
                                    out.println("<form action='DeleteClassServ' method='post' onsubmit='return confirmDelete();' style='display:inline;'>");
                                    out.println("<input type='hidden' name='classID' value='" + classID + "' />");
                                    out.println("<input type='hidden' name='action' value='Delete' />");
                                    out.println("<button type='submit' class='register-product-button1'>Delete</button>");
                                    out.println("</form>");
                                    out.println("</td>");
                                    out.println("</tr>");
                                }
                            } catch (Exception e) {
                                out.println("Error: " + e.getMessage());
                            }
                        %>
                    </tbody>
                </table>
            </div>

            <a href="javascript:history.back()" class="back-button">Back</a>
        </div>

        <script>
            function signOut() {
                window.location.href = 'LogOutServ';
            }

            function confirmDelete() {
                return confirm("Are you sure you want to delete this class?");
            }

            function showSuccessMessage() {
                alert("Payment submitted successfully!");
            }

            var today = new Date();
            var year = today.getFullYear();
            var month = ('0' + (today.getMonth() + 1)).slice(-2);
            var day = ('0' + today.getDate()).slice(-2);
            var formattedDate = year + '-' + month + '-' + day;

            document.getElementById('date').value = formattedDate;
        </script>

        <footer>
            <p>&copy; HR SkillCertify 2023</p>
        </footer>
    </body>
</html>


