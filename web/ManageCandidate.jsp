<%-- 
    Document   : ManageCandidate
    Created on : 3 Jan 2024, 10:34:44 pm
    Author     : FarisHarr
--%>

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
                <a href="ManageCertificate.jsp">Manage Certificate</a>
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

                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");
                                Statement st = con.createStatement();
                                ResultSet rs = st.executeQuery(query);

                                while (rs.next()) {
                                    String ID = rs.getString("cand_ID");
                                    String IC = rs.getString("cand_IC");
                                    String Name = rs.getString("cand_Name");
                                    String Email = rs.getString("cand_Email");
                                    String Phone = rs.getString("cand_Phone");
                                    String Address = rs.getString("cand_Add");

                                    // Check if the candidate has an associated certificate
                                    PreparedStatement psCert = con.prepareStatement("SELECT * FROM certificate WHERE cand_ID = ?");
                                    psCert.setString(1, ID);
                                    ResultSet rsCert = psCert.executeQuery();

                                    CandidateDAO candidateDao = new CandidateDAO();
                                    String certificate = candidateDao.getCertificate(ID); // Fetch the certificate value from the database

                                    out.println("<tr>");
                                    out.println("<td>" + IC + "</td>");
                                    out.println("<td>" + Name + "</td>");
                                    out.println("<td>" + Email + "</td>");
                                    out.println("<td>" + Phone + "</td>");
                                    out.println("<td>" + Address + "</td>");

                                    // Debugging information
//                                    out.println("<!-- Certificate Value: " + certificate + " -->");
                                    if (certificate != null && !certificate.isEmpty() && !certificate.equalsIgnoreCase("no certificate")) {
                                        // Certificate exists and is not "no certificate"
                                        out.println("<td>");
                                        out.println("<a href=\"EditCertificate.jsp?cand_ID=" + ID + "\"><img src=\"IMG/check.png\" alt=\"certificate\" title=\"View Certificate\"></a>");
                                        out.println("</td>");
                                    } else if (candidateDao.hasCertificateType(ID, "desired_cert_type")) {
                                        // Candidate has a certificate of the specified type
                                        out.println("<td>");
                                        out.println("<img src=\"IMG/cross.png\" alt=\"certificate\" title=\"Not Enroll Certificate\"></a>");
                                        out.println("</td>");
                                    } else {
                                        // Certificate is null or empty
                                        out.println("<td>");
                                        out.println("<a href=\"Certificate.jsp?cand_ID=" + ID + "\"><img src=\"IMG/editicon.png\" alt=\"certificate\" title=\"Update Certificate\"></a>");
                                        out.println("</td>");
                                    }

                                    out.println("<td>");
                                    out.println("<a href=\"DeleteCandidate.jsp?cand_ID=" + ID + "\"><img src=\"IMG/deleteicon.png\" alt=\"delete\"></a>");
                                    out.println("</td>");
                                    out.println("</tr>");

                                    rsCert.close();
                                    psCert.close();
                                }

                                con.close();
                            } catch (Exception e) {
                                out.println("Error: " + e);
                            }
                        %>
                    </tbody>
                </table>
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
            <p>&copy; HR SkillCertify 2023</p>
        </footer>
    </body>
</html>


