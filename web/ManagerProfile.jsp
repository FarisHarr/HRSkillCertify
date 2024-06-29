<%-- 
    Document   : ManagerProfile
    Created on : 5 Jan 2024, 4:43:37 pm
    Author     : FarisHarr
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="CSS/ManagerProfile.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <title>Manager Profile</title>
    </head>

    <style>
        .profile-info {
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin-bottom: 20px;
            /*width: 90%;*/
        }

        .info-item {
            display: flex;
            justify-content: flex-start;
            align-items: center;
            padding: 10px;
            border-bottom: 1px solid #ddd;
            /*font-size: 1.1rem;*/
        }

        .info-item label {
            width: 240px;
            /*border: 1px solid #000;*/
            padding: 5px;
            font-size: 1.1rem;
            font-weight: bold;
            color: #333;
            margin-right: 50px;
            margin-left: 60px; /* Adds spacing between the label and the span */
        }

        .info-item span {
            width: 350px;
            color: #555;
            /*border: 1px solid #000;*/
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
                        String ID = rs.getString("staff_ID");
                        String IC = rs.getString("staff_IC");
                        String Name = rs.getString("staff_Name");
                        String Email = rs.getString("staff_Email");
                        String Password = rs.getString("staff_Pass");
                        String Phone = rs.getString("staff_Phone");
//                        String Role = rs.getString("roles");
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
                        <li><a href="ManagerProfile.jsp">Profile</a></li>
                                            <!--ada error logout kalau letak-->
                        <li><a href="#" onclick="signOut()">Sign Out</a></li>
                    </ul>
                </li>
            </nav>
        </header>

        <div class="co">
            <div class="navbar" id="myNavbar">
                <a href="ManagerProfile.jsp">User Profile</a>
                <a href="ManagePayment.jsp">Manage Payment</a>
                <a href="ManageCertificate.jsp">Manage Attendance</a>
                <a href="ManageCandidate.jsp">Manage Candidate</a>
                <a href="ViewFeedback.jsp">View Feedback</a>
            </div>

            <div class="container">
                <br>
                <div class="title">
                    <h1>User Profile</h1>
                    <br>
                    <div class="profile-info">
                        <div class="info-item">
                            <label>Name :</label>
                            <span><%= Name%></span>
                        </div>
                        <div class="info-item">
                            <label>IC Number :</label>
                            <span><%= IC%></span>
                        </div>
                        <div class="info-item">
                            <label>Email :</label>
                            <span><%= Email%></span>
                        </div>
                        <div class="info-item">
                            <label>Phone Number :</label>
                            <span><%= Phone%></span>
                        </div>
                        <br>
                        <a href="EditStaff.jsp?id=<%= ID%>">
                            <button class="profile-update-button">EDIT</button>
                        </a> 
                    </div>
                    <br>
                </div>
            </div>
        </div>

        <button onclick="topFunction()" id="myBtn" title="top"><i class="fa-solid fa-chevron-up"></i></button>

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
            <p>&copy; 2024 <strong>HR SkillCertify</strong>. All rights reserved </p>
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
        </script>

    </body>

</html>






