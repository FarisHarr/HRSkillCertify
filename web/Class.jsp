<%--
    Document   : Class
    Created on : 1 May 2024, 3:29:18 pm
    Author     : FarisHarr
--%>

<%@ page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Class Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="CSS/Class.css">
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    </head>
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

        <h2>Time Table</h2>
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
                                PreparedStatement ps = con.prepareStatement("SELECT class_ID, class_Name, date, start_Time, end_Time FROM class WHERE is_archived = FALSE");
                                ResultSet rs = ps.executeQuery();

                                while (rs.next()) {
                                    String classID = rs.getString("class_ID");
                                    String certName = rs.getString("class_Name");
                                    String date = rs.getString("date");
                                    String startTime = rs.getString("start_Time");
                                    String endTime = rs.getString("end_Time");
                        %>
                        <tr>
                            <td><%= certName%></td>
                            <td><%= date%></td>
                            <td><%= startTime%></td>
                            <td><%= endTime%></td>
                            <td>
                                <form action="AttendanceServ" method="post" style="display:inline;">
                                    <input type="hidden" name="class_ID" value="<%= classID%>">
                                    <input type="hidden" name="cand_ID" value="<%= candidateID%>">
                                    <input type="hidden" name="attendance" value="--">
                                    <button type="submit">Join</button>
                                </form>
                            </td>
                        </tr>
                        <%
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
                // Redirect to the logout servlet or your logout logic
                window.location.href = 'LogOutServ'; // Replace 'LogOutServ' with your actual logout servlet
            }
        </script>

        <footer>
            <p>&copy; HR SkillCertify 2023</p>
        </footer>
    </body>
</html>
