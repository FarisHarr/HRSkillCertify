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
                        <li><a href="MainPage.jsp" onclick="signOut()">Sign Out</a></li>
                    </ul>
                </li>
            </nav>
        </header>

        <div class="co">
            <div class="navbar" id="myNavbar">
                <a href="ManagerProfile.jsp">User Profile</a>
                <a href="ManagePayment.jsp">Manage Payment</a>
                <a href="ManageCertificate.jsp">Manage Certificate</a>
                <a href="ManageCandidate.jsp">Manage Candidate</a>
                <a href="ViewFeedback.jsp">View Feedback</a>
            </div>

            <div class="container">
                <div class="title">
                    <h1>User Profile</h1>
                    <h3 name="name"> Name : <%= Name%></h3>
                    <h3 name="ic"> IC : <%= IC%></h3>
                    <h3 name="email"> Email : <%= Email%></h3>
                    <!--<h3 name="password"> Password : <%= Password%></h3>-->
                    <h3 name="phone"> Phone : <%= Phone%></h3>
                </div>

                <a href="EditStaff.jsp?id=<%= ID%>">
                    <button class="profile-update-button">EDIT</button>
                </a> 

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






