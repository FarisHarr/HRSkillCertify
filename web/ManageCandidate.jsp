<%-- 
    Document   : ManageCandidate
    Created on : 3 Jan 2024, 10:34:44 pm
    Author     : FarisHarr
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.dao.CandidateDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Manage Candidate</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="CSS/ManageCandidate.css">
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>
    <body>
        <%
            String staffID = (String) session.getAttribute("staffID");
            int currentPage = 1;
            int recordsPerPage = 5;

            if (request.getParameter("page") != null) {
                currentPage = Integer.parseInt(request.getParameter("page"));
            }

            int start = (currentPage - 1) * recordsPerPage;

            if (staffID != null) {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");
                    PreparedStatement ps = con.prepareStatement("SELECT * FROM staff WHERE staff_ID = ? ");
                    ps.setString(1, staffID);
                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) {
                        String Name = rs.getString("staff_Name");
        %>
        <header>
            <div class="main">
                <a href="StaffDashboard.jsp">
                    <img class="logo" src="IMG/HRSCLogo.png" alt="logo">
                </a>
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
                        <li><a href="ManagerProfile.jsp">User Profile</a></li>
                        <li><a href="MainPage.jsp" onclick="signOut()">Sign Out</a></li>
                    </ul>
                </li>
            </nav>
        </header>

        <div class="container">
            <div class="navbar">
                <a href="ManagerProfile.jsp">User Profile</a>
                <a href="ManagePayment.jsp">Manage Payment</a>
                <a href="ManageCertificate.jsp">Manage Attendance</a>
                <a href="ManageCandidate.jsp">Manage Candidate</a>
                <a href="ViewFeedback.jsp">View Feedback</a>
            </div>

            <div class="info">
                <h2>Manage Candidate</h2>

                <!-- Search Section -->
                <div class="search-section">
                    <form action="ManageCandidate.jsp" method="GET">
                        <input type="text" name="searchName" placeholder="Search by Name">
                        <button type="submit">Search</button>
                    </form>
                </div>

                <!-- Table -->
                <table id="table">
                    <thead>
                        <tr>
                            <th>IC Number</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone Number</th>
                            <th>Address</th>
                            <th>Status</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                                    } else {
                                        out.println("Coordinator not found.");
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

                            // Get search parameter from URL
                            String searchName = request.getParameter("searchName");
                            String query = "SELECT * FROM candidate";

                            if (searchName != null && !searchName.isEmpty()) {
                                query = "SELECT * FROM candidate WHERE cand_Name LIKE '%" + searchName + "%'";
                            }

                            // Count total records for pagination
                            String countQuery = "SELECT COUNT(*) FROM candidate";
                            if (searchName != null && !searchName.isEmpty()) {
                                countQuery = "SELECT COUNT(*) FROM candidate WHERE cand_Name LIKE '%" + searchName + "%'";
                            }

                            int totalRecords = 0;
                            int totalPages = 0;

                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");
                                
                                Statement countStmt = con.createStatement();
                                ResultSet countRs = countStmt.executeQuery(countQuery);
                                if (countRs.next()) {
                                    totalRecords = countRs.getInt(1);
                                }
                                totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
                                countRs.close();
                                countStmt.close();

                                query += " LIMIT ? OFFSET ?";
                                PreparedStatement ps = con.prepareStatement(query);
                                ps.setInt(1, recordsPerPage);
                                ps.setInt(2, start);
                                ResultSet rs = ps.executeQuery();

                                List<String> notEnrollCandidates = new ArrayList<>();
                                List<String> otherCandidates = new ArrayList<>();

                                while (rs.next()) {
                                    String ID = rs.getString("cand_ID");
                                    String IC = rs.getString("cand_IC");
                                    String Name = rs.getString("cand_Name");
                                    String Email = rs.getString("cand_Email");
                                    String Phone = rs.getString("cand_Phone");
                                    String Address = rs.getString("cand_Add");

                                    CandidateDAO candidateDao = new CandidateDAO();
                                    String certificate = candidateDao.getCertificate(ID); // Fetch the certificate value from the database

                                    StringBuilder row = new StringBuilder();
                                    row.append("<tr>");
                                    row.append("<td>").append(IC).append("</td>");
                                    row.append("<td>").append(Name).append("</td>");
                                    row.append("<td>").append(Email).append("</td>");
                                    row.append("<td>").append(Phone).append("</td>");
                                    row.append("<td>").append(Address).append("</td>");

                                    if (certificate != null && !certificate.isEmpty() && !certificate.equalsIgnoreCase("no certificate")) {
                                        // Certificate exists and is not "no certificate"
                                        row.append("<td>");
                                        row.append("<a href=\"EditCertificate.jsp?cand_ID=").append(ID).append("\"><img src=\"IMG/check.png\" alt=\"certificate\" title=\"View Certificate\"></a>");
                                        row.append("</td>");
                                    } else if (candidateDao.hasCertificateType(ID, "desired_cert_type")) {
                                        // Candidate has a certificate of the specified type
                                        row.append("<td>");
                                        row.append("<img src=\"IMG/cross.png\" alt=\"certificate\" title=\"Not Enroll Certificate\"></a>");
                                        row.append("</td>");
                                    } else {
                                        // Certificate is null or empty
                                        row.append("<td>");
                                        row.append("<a href=\"Certificate.jsp?cand_ID=").append(ID).append("\"><img src=\"IMG/editicon.png\" alt=\"certificate\" title=\"Update Certificate\"></a>");
                                        row.append("</td>");
                                    }

                                    row.append("<td>");
                                    row.append("<a href=\"DeleteCandidate.jsp?cand_ID=").append(ID).append("\"><img src=\"IMG/deleteicon.png\" alt=\"delete\"></a>");
                                    row.append("</td>");
                                    row.append("</tr>");

                                    if (certificate == null || certificate.isEmpty() || certificate.equalsIgnoreCase("no certificate")) {
                                        notEnrollCandidates.add(row.toString());
                                    } else {
                                        otherCandidates.add(row.toString());
                                    }
                                }

                                // Print the not enrolled candidates first
                                for (String row : notEnrollCandidates) {
                                    out.println(row);
                                }

                                // Then print the other candidates
                                for (String row : otherCandidates) {
                                    out.println(row);
                                }

                                rs.close();
                                ps.close();
                                con.close();
                            } catch (Exception e) {
                                out.println("Error: " + e);
                            }
                        %>
                    </tbody>
                </table>

                    <div class="pagination"><br>
                    <%
                        if (currentPage > 1) {
                    %>
                    <a href="ManageCandidate.jsp?page=<%= currentPage - 1 %>" style="color: #455d5f">&laquo; Previous</a>
                    <%
                        }
                        if (currentPage < totalPages) {
                    %>
                    <a href="ManageCandidate.jsp?page=<%= currentPage + 1 %>" style="color: #455d5f">Next &raquo;</a>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
        <button onclick="topFunction()" id="myBtn" title="top"><i class="fa-solid fa-chevron-up"></i></button>

        <script>
            function toggleNavbar() {
                var navbar = document.querySelector('.navbar');
                navbar.classList.toggle('minimized');
            }

            function signOut() {
                window.location.href = 'LogOutServ';
            }

            var mybutton = document.getElementById("myBtn");

            window.onscroll = function () {
                scrollFunction();
            };

            function scrollFunction() {
                if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
                    mybutton.style.visibility = "visible";
                    mybutton.style.opacity = "1";
                } else {
                    mybutton.style.visibility = "hidden";
                    mybutton.style.opacity = "0";
                }
            }

            function topFunction() {
                window.scrollTo({
                    top: 1,
                    behavior: "smooth"
                });
            }
        </script>

        <footer>
            <p>&copy; 2024 <strong>HR SkillCertify</strong>. All rights reserved </p>
        </footer>
    </body>
</html>
