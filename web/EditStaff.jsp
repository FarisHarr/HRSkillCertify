<%-- 
    Document   : EditStaff
    Created on : 11 Jan 2024, 2:19:03 am
    Author     : FarisHarr
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="CSS/EditCandidate.css">
        <title>Edit Staff</title>
    </head>

    <body>

        <header>
            <div class="main">
                <img class="logo" src="IMG/HRSCLogo.png" alt="logo">
<!--                <nav>
                    <ul class="nav_links">
                        <button class="navbar-toggle" onclick="toggleNavbar()"> ☰ </button>
                    </ul>
                </nav>-->
            </div>
            <nav>
                <li class="dropdown">
                    <a class="nav-link">Manager</a>
                    <ul class="dropdown-content">
                        <li><a href="#">User Info</a></li>
                        <li><a href="MainPage.jsp">Sign Out</a></li>
                    </ul>
                </li>
            </nav>
        </header>

        <!--        <div class="co">
                    <div class="navbar" id="myNavbar">
                        <a href="HomePage.jsp">Home</a>
                        <a href="CandidateProfile.jsp">User Profile</a>
                        <a href="#">About Certificate</a>
                        <a href="#">Time Table</a>
                        <a href="#">Feedback</a>
                    </div>-->

        <%
//                HttpSession loginsession = request.getSession();
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
                        String Role = rs.getString("roles");

        %>

        <div class="popup-content">
            <form action="UpdateStaffServ" method="POST">
                <h2>UPDATE PROFILE</h2>
                <input type="hidden" name="id" value="<%= ID%>">

                <label for="ic">IC Number:</label>
                <input type="text" name="ic" oninput="restrictToNumbers(this);" maxlength="12" value="<%= IC%>">

                <label for="name">Name:</label>
                <input type="text" name="name" value="<%= Name%>">

                <label for="email">Email:</label>
                <input type="email" name="email" value="<%= Email%>">

                <label for="password">Password:</label>
                <input type="text" name="password" value="<%= Password%>">

                <label for="phone">Phone Number:</label>
                <input type="text" name="phone" value="<%= Phone%>" oninput="this.value = this.value.replace(/[^0-9]/g, '')" maxlength="12"
                       placeholder="Enter Phone Number" required>


                <input class="submit" type="submit" value="Update">
                <p class="new"><a href="ManagerProfile.jsp">Back</a></p>
            </form>
        </div>

        <%
                    } else {
                        out.println("Staff not found.");
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

    </div>

    <script>
        function restrictToNumbers(inputElement) {
            inputElement.value = inputElement.value.replace(/[^0-9]/g, '');
        }

        function toggleNavbar() {
            var navbar = document.querySelector('.navbar');
            navbar.classList.toggle('minimized');
        }
    </script>
</body>

<footer>
    <p>© HR SkillCertify 2023</p>
</footer>

</html>