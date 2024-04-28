<%-- 
    Document   : HompePage
    Created on : 27 Dec 2023, 3:11:49 pm
    Author     : FarisHarr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>

    <head>
        <title>Home Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="CSS/HomePage.css">
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    </head>
    <style>
        .infoCert {
            margin: 0 auto;
            text-align: center;
            padding: 10px;
            width: 90%;
            background-color: aliceblue;
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }

        .cert {
            background-color: #a4a4a4;
            padding: 50px;
            margin: 40px;
            border-radius: 8px;
            text-align: center;
            display: flex;
            flex-direction: column;
            width: 30%;
            height: 50vh;
            transition: transform 0.5s ease-in-out;
        }

        .cert:hover {
            transform: scale(1.1);
        }

        .cert h2 {
            margin-bottom: 10px;
        }

        .cert button {
            background-color: #fff;
            color: #212121;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            width: 30%;
            cursor: pointer;
            margin-top: 10vh;
            /* Push the button to the bottom */
        }
    </style>

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

            <div class="infoCert">
                <h3>Welcome <%= Name%></h3>
                <div class="cert">
                    <h2>Sijil Kemahiran Malaysia (SKM) Tahap 1, 2 dan 3</h2>
                    <h4> This certificate will improve your diplomas </h4>
                    <a href="AboutCertificate.jsp">
                        <button>Explore</button>
                    </a>                
                </div>

                <div class="cert">
                    <h2>Diploma Kemahiran Malaysia (DKM)/ Tahap 4</h2>
                    <!-- Add content for container 2 -->
                    <a href="AboutCertificate.jsp">
                        <button>Explore</button>
                    </a>
                </div>

                <div class="cert">
                    <h2>Diploma Lanjutan Kemahiran Malaysia (DLKM) / Tahap 5</h2>
                    <!-- Add content for container 3 -->
                    <a href="AboutCertificate.jsp">
                        <button>Explore</button>
                    </a>
                </div>

            </div>
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
            // If the session doesn't exist or customerID is not set, redirect to the login page
            response.sendRedirect("Login.jsp");
        }
    %>

    <footer>
        <p>&copy; HR SkillCertify 2023</p>
    </footer>

</body>

</html>


