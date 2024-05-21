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
                            <th>Class Name</th>
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
                                ResultSet rs = st.executeQuery("SELECT class_ID, class_Name, date, start_Time, end_Time FROM class WHERE is_archived = FALSE");

                                while (rs.next()) {
                                    String classID = rs.getString("class_ID");
                                    String className = rs.getString("class_Name");
                                    String date = rs.getString("date");
                                    String startTime = rs.getString("start_Time");
                                    String endTime = rs.getString("end_Time");

                                    out.println("<tr>");
//                                    out.println("<td>" + classID + "</td>");
                                    out.println("<td>" + className + "</td>");
                                    out.println("<td>" + date + "</td>");
                                    out.println("<td>" + startTime + "</td>");
                                    out.println("<td>" + endTime + "</td>");
                                    out.println("<td>");
                                    out.println("<form action='DeleteClassServ' method='post' onsubmit='return confirmDelete();' style='display:inline;'>");
                                    out.println("<input type='hidden' name='classID' value='" + classID + "' />");
                                    out.println("<input type='hidden' name='action' value='Delete' />");
                                    out.println("<button type='submit' class='register-product-button1'>Archive</button>");
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
                return confirm("Are you sure you want to archive this class?");
            }
        </script>

        <footer>
            <p>&copy; HR SkillCertify 2023</p>
        </footer>
    </body>
</html>



