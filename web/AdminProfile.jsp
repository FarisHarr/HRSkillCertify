<%-- 
    Document   : AdminProfile
    Created on : 11 Jan 2024, 2:10:44 am
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
        <title>Admin Profile</title>
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
                    <!-- <a class="nav-link">Account</a> -->
                    <a class="nav-link">Admin</a>
                    <ul class="dropdown-content">
                        <!-- <li><a href="CustomerProfile.jsp">Edit Information</a></li> -->
                        <li><a href="AdminProfile.jsp">User Profile</a></li>
                        <li><a href="MainPage.jsp" onclick="signOut()">Sign Out</a></li>
                    </ul>
                </li>
            </nav>
        </header>

        <div class="co">
            <div class="navbar">
                <a href="AdminProfile.jsp">User Profile</a>
                <a href="ManageStaff.jsp">Manage Manager</a>
                <a href="Report.jsp">Report</a>
                <a href="ViewFeedback2.jsp">View Feedback</a>
            </div>
            <div class="container" id="myNavbar">
                <div class="title">
                    <h1>User Profile</h1>
                    <h3 name="name"> Name : <%= Name%></h3>
                    <h3 name="ic"> IC : <%= IC%></h3>
                    <h3 name="email"> Email : <%= Email%></h3>
                    <!--<h3 name="password"> Password : <%= Password%></h3>-->
                    <h3 name="phone"> Phone : <%= Phone%></h3>
                </div>

                <a href="EditAdmin.jsp?id=<%= ID%>">
                    <button class="profile-update-button">EDIT</button>
                </a> 
            </div>
        </div>

        <%
                    } else {
                        out.println("Admin not found.");
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