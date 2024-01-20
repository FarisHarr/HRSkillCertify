<%-- 
    Document   : CandidateProfile
    Created on : 27 Dec 2023, 3:16:14 pm
    Author     : FarisHarr
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="CSS/User Information.css">
        <title>Candidate Profile</title>
    </head>

    <body>
        
        <%
                //           HttpSession loginsession = request.getSession();
                String candidateID = (String) session.getAttribute("candidateID");

                if (candidateID != null) {
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");
                        PreparedStatement ps = con.prepareStatement("SELECT * FROM candidate WHERE cand_ID = ? ");
                        ps.setString(1, candidateID);
                        ResultSet rs = ps.executeQuery();

                        if (rs.next()) {
                            String ID = rs.getString("cand_ID");
                            String IC = rs.getString("cand_IC");
                            String Name = rs.getString("cand_Name");
                            String Email = rs.getString("cand_Email");
//                            String Password = rs.getString("cand_Pass");
                            String Phone = rs.getString("cand_Phone");
                            String Address = rs.getString("cand_Add");
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

        <div class="co">
            <div class="navbar">
                <a href="HomePage.jsp">Home</a>
                <a href="CandidateProfile.jsp">User Profile</a>
                <a href="AboutCertificate.jsp">About Certificate</a>
                <a href="TimeTable.jsp">Time Table</a>
                <a href="Feedback.jsp">Feedback</a>
            </div>

            <div class="container">
                <div class="title">
                    <h1>User Profile</h1>
                    <h3 name="name"> Name : <%= Name%></h3>
                    <h3 name="ic"> IC : <%= IC%></h3>
                    <h3 name="email"> Email : <%= Email%></h3>
                    <!--<h3 name="password"> Password : < Password%></h3>-->
                    <h3 name="phone"> Phone : <%= Phone%></h3>
                    <h3 name="address"> Address : <%= Address%></h3>
                </div>

                <a href="EditCandidate.jsp?id=<%= ID%>">
                    <button class="profile-update-button">EDIT</button>
                </a> 
            </div>
        </div>

        <%
                    } else {
                        out.println("Customer not found.");
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
        %>


        <footer>
            <p>© HR SkillCertify 2023</p>
        </footer>

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

    </body>

</html>
