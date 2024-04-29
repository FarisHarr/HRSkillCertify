<%-- 
    Document   : ViewFeedback
    Created on : 19 Jan 2024, 10:30:23 pm
    Author     : FarisHarr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>

    <head>
        <title>View Feedback</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="CSS/feedback.css">
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/icon?family=Material+Icons">

    </head>

    <body>
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
                    <a class="nav-link">Manager</a>
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
                <a href="ViewFeedback.jsp">View Feedback</a>
                <a href="ManageCandidate.jsp">Manage Candidate</a>
            </div>

            <div class="info">
                <button onclick="refresh()">Refresh</button>
                <h1>View Feedback</h1>
                <!--Table-->
                <div class="table">
                    <table id="table">
                        <thead>
                            <tr>
                                <th>Feedback ID</th>
                                <!--<th>Candidate ID</th>-->
                                <th>Name</th>
                                <th>Message</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                String searchFeedbackID = request.getParameter("feedback_ID");
                                String query = "SELECT feedback.feedback_ID, candidate.cand_ID, candidate.cand_Name, feedback.message "
                                        + "FROM feedback "
                                        + "INNER JOIN candidate ON feedback.cand_ID = candidate.cand_ID";

                                if (searchFeedbackID != null && !searchFeedbackID.isEmpty()) {
                                    query += " WHERE feedback.feedback_ID = " + searchFeedbackID;
                                }

                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");
                                    Statement st = con.createStatement();
                                    ResultSet rs = st.executeQuery(query);

                                    while (rs.next()) {
                                        // Retrieve feedback details from the result set
                                        String feedbackID = rs.getString("feedback_ID");
                                        String candidateID = rs.getString("cand_ID");
                                        String candidateName = rs.getString("cand_Name");
                                        String message = rs.getString("message");

                                        // Output feedback details in table rows
                                        out.println("<tr>");
                                        out.println("<td>" + feedbackID + "</td>");
//                                        out.println("<td>" + candidateID + "</td>");
                                        out.println("<td>" + candidateName + "</td>");
                                        out.println("<td>" + message + "</td>");
                                        out.println("</tr>");
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

            <script>
                function toggleNavbar() {
                    var navbar = document.querySelector('.navbar');
                    navbar.classList.toggle('minimized');
                }

                function signOut() {
                    // Redirect to the logout servlet or your logout logic
                    window.location.href = 'LogOutServ'; // Replace 'LogoutServlet' with your actual logout servlet
                }

                // Refresh sales report by reloading the page
                function refresh() {
                    location.reload();
                }
            </script>

            <footer>
                <p>&copy; HR SkillCertify 2023</p>
            </footer>

    </body>

</html>
