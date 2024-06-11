<%-- 
    Document   : ViewFeedback2
    Created on : 19 Jan 2024, 10:37:57 pm
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

    </head>
    
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

    <body>

        <%
            //           HttpSession loginsession = request.getSession();
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
                <a href="AdminDashboard.jsp">
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
                        <li><a href="AdminProfile.jsp">User Profile</a></li>
                        <li><a href="MainPage.jsp" onclick="signOut()">Sign Out</a></li>
                    </ul>
                </li>
            </nav>
        </header>

        <div class="container">
            <div class="navbar">
                <a href="AdminProfile.jsp">User Profile</a>
                <a href="AdminDashboard.jsp">Dashboard</a>
                <a href="ManageStaff.jsp">Manage Staff</a>
                <a href="ViewFeedback2.jsp">View Feedback</a>
            </div>

            <div class="info">
                <button onclick="refresh()">Refresh</button>
                <h2>View Feedback</h2>
                <div class="table">
                    <table id="table">
                        <thead>
                            <tr>
                                <!--<th>Feedback ID</th>-->
                                <th>Name</th>
                                <th>Message</th>
                                <th>Response</th>
                                <!--<th>Action</th>-->
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
                                    // If the session doesn't exist or customerID is not set, redirect to the login page
                                    response.sendRedirect("Login.jsp");
                                }

                                String searchFeedbackID = request.getParameter("feedback_ID");
                                String query = "SELECT feedback.feedback_ID, candidate.cand_ID, candidate.cand_Name, feedback.message, feedback.response "
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
                                        String reply = rs.getString("response");

                                        // Output feedback details in table rows
                                        out.println("<tr>");
//                                        out.println("<td>" + feedbackID + "</td>");
//                                        out.println("<td>" + candidateID + "</td>");
                                        out.println("<td>" + candidateName + "</td>");
                                        out.println("<td>" + message + "</td>");
                                        out.println("<td>" + reply + "</td>");
//                                        out.println("<td>");
//                                        out.println("<span onclick=\"showPopup('" + candidateID + "', '" + feedbackID + "', '" + message.replaceAll("'", "\\\\'") + "', '" + (reply != null ? reply.replaceAll("'", "\\\\'") : "") + "')\" style=\"cursor:pointer;\"><img src=\"IMG/editicon.png\" alt=\"response\" title=\"Reply\"></span>");
//                                        out.println("</td>");
                                        out.println("</tr>");
                                    }

                            %>


                        </tbody>
                    </table>
                </div>
            </div>

            <!--Popup Reply-->
            <div class="popup" id="popup">
                <div class="popup-content">
                    <span class="close" onclick="hidePopup()">&times;</span>
                    <h2>Response</h2>
                    <form action="UpdateFeedbackServ " method="POST">
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

        <%                                    con.close();
            } catch (Exception e) {
                out.println("Error: " + e);
            }
        %>

        <button onclick="topFunction()" id="myBtn" title="top"><i class="fa-solid fa-chevron-up"></i></button>

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

            //scroll function
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
                document.body.scrollTop = 1;
                document.documentElement.scrollTop = 1;
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

    </body>

</html>
