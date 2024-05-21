<%-- 
    Document   : TimeTable
    Created on : 19 Jan 2024, 10:16:58 pm
    Author     : FarisHarr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>

    <head>
        <title>Time Table</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="CSS/TimeTable.css">
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/icon?family=Material+Icons">

    </head>

    <body>
        <%
            String candidateID = (String) session.getAttribute("candidateID");

            if (candidateID != null) {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");

                    // Fetch the status from the payment table
                    PreparedStatement ps = con.prepareStatement("SELECT * FROM payment WHERE cand_ID = ?");
                    ps.setString(1, candidateID);
                    ResultSet rs = ps.executeQuery();

                    String status = "";
                    String certificateType = ""; // Add this variable to store cert_Type
                    if (rs.next()) {
                        status = rs.getString("status");
                        certificateType = rs.getString("cert_Type"); // Store cert_Type in a variable
                    }

                    // Fetch the candidate name from the candidate table
                    ps = con.prepareStatement("SELECT cand_Name FROM candidate WHERE cand_ID = ?");
                    ps.setString(1, candidateID);
                    rs = ps.executeQuery();

                    if (rs.next()) {
                        String Name = rs.getString("cand_Name");
        %>

        <header>
            <div class="main">
                <img class="logo" src="IMG/HRSCLogo.png" alt="logo">
                <nav>
                    <ul class="nav_links">
                        <button class="navbar-toggle" onclick="toggleNavbar()"> ☰ </button>
                    </ul>
                </nav>
            </div>
            <nav>
                <li class="dropdown">
                    <a class="nav-link"><%= Name%></a>
                    <ul class="dropdown-content">
                        <li><a href="CandidateProfile.jsp">Profile</a></li>
                        <li><a href="MainPage.jsp" onclick="signOut()">Sign Out</a></li>
                    </ul>
                </li>
            </nav>
        </header>

        <div class="container">
            <div class="navbar">
                <a href="HomePage.jsp">Home</a>
                <a href="CandidateProfile.jsp">User Profile</a>
                <a href="AboutCertificate.jsp">About Certificate</a>
                <a href="TimeTable.jsp">Time Table</a>
                <a href="Feedback.jsp">Feedback</a>
            </div>

            <!--<div class="infoCert">-->
            <div class="cert">
                <h2>Certificate</h2>
                <br>
                <h3><%= certificateType%></h3> 
                <br>
                <p>Your payment status : <%= status%> </p> 
                <br> 
                <%-- Add conditional check for the Attend button --%>
                <% if (status.equals("Pending") || status.equals("Rejected")) { %>
                <form action="Payment.jsp">
                    <button type="submit">Update Payment</button>
                </form>
                <% } else { %>
                <form action="Class.jsp">
                    <button type="submit">Attend</button>
                </form>
                <% } %>

            </div>

            <div class="container1">
                <h2>Attendance Table</h2>
                <div class="table">
                    <table>
                        <thead>
                            <tr>
                                <th>Class Name</th>
                                <th>Date</th>
                                <th>Start Time</th>
                                <th>End Time</th>
                                <th>Attendance</th>
                            </tr>
                        </thead>
                        <tbody>
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
                                    response.sendRedirect("Login.jsp");
                                }

                                // Java code to fetch and display attendance data from the database
                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");
                                    PreparedStatement ps = con.prepareStatement("SELECT a.class_ID, c.class_Name, c.date, c.start_Time, c.end_Time, a.attendance FROM attendance a JOIN class c ON a.class_ID = c.class_ID WHERE a.cand_ID = ?");
                                    ps.setString(1, candidateID);
                                    ResultSet rs = ps.executeQuery();

                                    while (rs.next()) {
                                        String className = rs.getString("class_Name");
                                        String date = rs.getString("date");
                                        String startTime = rs.getString("start_Time");
                                        String endTime = rs.getString("end_Time");
                                        String attendance = rs.getString("attendance");

                                        out.println("<tr>");
                                        out.println("<td>" + className + "</td>");
                                        out.println("<td>" + date + "</td>");
                                        out.println("<td>" + startTime + "</td>");
                                        out.println("<td>" + endTime + "</td>");
                                        out.println("<td>" + attendance + "</td>");
                                        out.println("</tr>");
                                    }
                                    rs.close();
                                    ps.close();
                                    con.close();
                                } catch (Exception e) {
                                    out.println("Error: " + e.getMessage());
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>



            <script>
                function toggleNavbar() {
                    var navbar = document.querySelector('.navbar');
                    navbar.classList.toggle('minimized');
                }

                function signOut() {
                    // Redirect to the logout servlet or your logout logic
                    window.location.href = 'LogOutServ'; // Replace 'LogoutServlet' with your actual logout servlet
                }
            </script>

            <footer>
                <p>&copy; HR SkillCertify 2023</p>
            </footer>

    </body>

</html>
