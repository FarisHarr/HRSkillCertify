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

<!--        <div class="container">
            <div class="navbar">
                <a href="HomePage.jsp">Home</a>
                <a href="CandidateProfile.jsp">User Profile</a>
                <a href="AboutCertificate.jsp">About Certificate</a>
                <a href="TimeTable.jsp">Time Table</a>
                <a href="Feedback.jsp">Feedback</a>
            </div>-->


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

            <div class="container1">
                <h2>Time Table</h2> <br>
                <div class="table">
                    <table>
                        <thead>
                            <tr>
                                <th>Class ID</th>
                                <th>Start Date</th>
                                <th>End Date</th>
                                <th>Attendance</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Assuming you have class data available in your JSP -->
                            <tr>

                                <td>
                                    
                                    
                                    <select name="attendance">
                                        <option value="attend">Attend</option>
                                        <option value="absent">Absent</option>
                                    </select>
                                </td>
                                <td><button>Submit</button></td>
                            </tr>
                        </tbody>
                    </table>
                </div>

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