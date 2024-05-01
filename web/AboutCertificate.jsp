<%-- 
    Document   : AboutCertificate
    Created on : 19 Jan 2024, 10:07:25 pm
    Author     : FarisHarr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>

    <head>
        <title>About Certificate</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="CSS/CandidateSkeleton.css">
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/icon?family=Material+Icons">

    </head>

    <style>
        .infoCert {
            margin: 0 auto;
            text-align: center;
            padding: 20px;
            width: 90%;
            height: 100vh;
            background-color: aliceblue;
            display: flex;
        }

        .cert {
            background-color: #f9f9f9;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            padding: 65px;
            margin: 40px;
            width: 20%;
            border-radius: 8px;
            text-align: center;
            display: flex;
            flex-direction: column;

        }

        .cert button {
            background-color: #007bff;
            color: #ffffff;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 10vh;
            /* Push the button to the bottom */
        }

        .cert button:hover {
            background-color: #45a049;
        }
    </style>

    <body>
        <%
            //                HttpSession loginsession = request.getSession();
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
                        <!-- <li><a href="CustomerProfile.jsp">Edit Information</a></li> -->
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
                <div class="cert">
                    <h2>Sijil Kemahiran Malaysia (SKM)</h2>
                    <!-- Add content for container 1 -->
                    <a href="CertificateForm.jsp">
                        <button>Register</button>
                    </a>                
                </div>

                <div class="cert">
                    <h2>Diploma Kemahiran Malaysia (DKM)</h2>
                    <!-- Add content for container 2 -->
                    <a href="CertificateForm.jsp">
                        <button>Register</button>
                    </a>  
                </div>

                <div class="cert">
                    <h2>Diploma Lanjutan Kemahiran Malaysia (DLKM)</h2>
                    <!-- Add content for container 3 -->
                    <a href="CertificateForm.jsp">
                        <button>Register</button>
                    </a>  
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
            <p>&copy; HR SkillCertify 2023</p>
        </footer>

    </body>

</html>
