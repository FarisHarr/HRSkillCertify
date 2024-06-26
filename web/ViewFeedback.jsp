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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

        <style>
            /* Center the submit button */
            .submit-button {
                width: 100%; /* Make sure the container spans the full width */
                display: flex;
                justify-content: center; /* Center the button horizontally */
                margin-top: 20px;
            }

            /* Submit button styling */
            input.submit {
                width: 100px;
                height: 40px;
                border-radius: 5px;
                border: none;
                color: white;
                background-color: #4CAF50;
                cursor: pointer;
                text-align: center;
            }

            input.submit:hover {
                background-color: #45a049;
            }
        </style>

    </head>

    <body>
        <%
            String staffID = (String) session.getAttribute("staffID");
            int currentPage = 1;
            int recordsPerPage = 9;

            if (request.getParameter("page") != null) {
                currentPage = Integer.parseInt(request.getParameter("page"));
            }

            if (staffID != null) {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");
                    PreparedStatement ps = con.prepareStatement("SELECT * FROM staff WHERE staff_ID = ? ");
                    ps.setString(1, staffID);
                    ResultSet staffRs = ps.executeQuery();

                    if (staffRs.next()) {
                        String Name = staffRs.getString("staff_Name");
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
                    <a class="nav-link"><%= Name %></a>
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
                <button onclick="refresh()">Refresh</button>
                <h2>View Feedback</h2>
                <div class="table">
                    <table id="table">
                        <thead>
                            <tr>
                                <!--<th>Feedback ID</th>-->
                                <th>Date</th>
                                <th>Name</th>
                                <th>Message</th>
                                <th>Response</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                staffRs.close();
                                ps.close();
                                String searchFeedbackID = request.getParameter("feedback_ID");

                                String query = "SELECT feedback.feedback_ID, candidate.cand_ID, candidate.cand_Name, feedback.message, feedback.response, feedback.feedback_Date "
                                        + "FROM feedback "
                                        + "INNER JOIN candidate ON feedback.cand_ID = candidate.cand_ID";

                                if (searchFeedbackID != null && !searchFeedbackID.isEmpty()) {
                                    query += " WHERE feedback.feedback_ID = " + searchFeedbackID;
                                }

                                // Add pagination and order by date descending
                                query += " ORDER BY feedback.feedback_Date DESC LIMIT " + recordsPerPage + " OFFSET " + (currentPage - 1) * recordsPerPage;

                                Statement st = con.createStatement();
                                ResultSet feedbackRs = st.executeQuery(query);

                                while (feedbackRs.next()) {
                                    String feedbackID = feedbackRs.getString("feedback_ID");
                                    String candidateID = feedbackRs.getString("cand_ID");
                                    String candidateName = feedbackRs.getString("cand_Name");
                                    String message = feedbackRs.getString("message");
                                    String reply = feedbackRs.getString("response");
                                    String date = feedbackRs.getString("feedback_Date");
                            %>
                            <tr>
                                <td><%= date %></td>
                                <td><%= candidateName %></td>
                                <td><%= message %></td>
                                <td><%= reply %></td>
                                <td>
                                    <span onclick="showPopup('<%= candidateID %>', '<%= feedbackID %>', '<%= message.replaceAll("'", "\\\\'") %>', '<%= (reply != null ? reply.replaceAll("'", "\\\\'") : "") %>')" style="cursor:pointer;">
                                        <img src="IMG/editicon.png" alt="response" title="Reply">
                                    </span>
                                </td>
                            </tr>
                            <%
                                }
                                feedbackRs.close();
                                st.close();
                            %>
                        </tbody>
                    </table>

                    
                </div>
                        
                <!-- Pagination -->
                <div class="pagination">
                    <%
                        // Calculate total pages
                        Statement countStmt = con.createStatement();
                        ResultSet countRs = countStmt.executeQuery("SELECT COUNT(*) FROM feedback");

                        countRs.next();
                        int totalRecords = countRs.getInt(1);
                        int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);

                        countRs.close();
                        countStmt.close();

                        if (currentPage > 1) {
                    %>
                    <a href="ViewFeedback.jsp?page=<%= currentPage - 1 %>" style="color: #455d5f">&laquo; Previous</a>
                    <%
                        }
                        if (currentPage < totalPages) {
                    %>
                    <a href="ViewFeedback.jsp?page=<%= currentPage + 1 %>" style="color: #455d5f">Next &raquo;</a>
                    <%
                        }
                    %>
                </div>

                <!--Popup Reply-->
                <div class="popup" id="popup">
                    <div class="popup-content">
                        <span class="close" onclick="hidePopup()">&times;</span>
                        <h2>Response</h2>
                        <form action="UpdateFeedbackServ" method="POST">
                            <input type="hidden" id="popupCandidateID" name="candidateID">
                            <input type="hidden" id="popupFeedbackID" name="feedbackID">
                            <div class="form-group">
                                <label for="popupMessage">Message :</label>
                                <p id="popupMessage"></p>
                            </div>
                            <br>
                            <div class="form-group">
                                <label for="popupReply">Reply :</label>
                                <textarea id="popupReply" name="reply"></textarea>
                            </div>
                            <br><br>
                            <div class="submit-button">
                                <input class="submit" type="submit" value="Submit">
                            </div>
                        </form>
                    </div>
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

            function refresh() {
                location.reload();
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

            function showPopup(candidateID, feedbackID, message, reply) {
                document.getElementById("popup").style.display = "block";
                document.getElementById("popupCandidateID").value = candidateID;
                document.getElementById("popupFeedbackID").value = feedbackID;
                document.getElementById("popupMessage").innerText = message;
                document.getElementById("popupReply").value = reply;
            }

            function hidePopup() {
                document.getElementById("popup").style.display = "none";
            }
        </script>

        <footer>
            <p>&copy; HR SkillCertify 2023</p>
        </footer>
        <%
                    } else {
                        out.println("Coordinator not found.");
                    }
                } catch (Exception e) {
                    out.println("Error: " + e.getMessage());
                }
            } else {
                response.sendRedirect("Login.jsp");
            }
        %>
    </body>

</html>
