<%-- 
    Document   : Report
    Created on : 19 Jan 2024, 10:36:24 pm
    Author     : FarisHarr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <title>Report</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="CSS/StaffSkeleton.css">
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/icon?family=Material+Icons">

    </head>

    <body>
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
                    <a class="nav-link">Admin Test</a>
                    <ul class="dropdown-content">
                        <!-- <li><a href="CustomerProfile.jsp">Edit Information</a></li> -->
                        <li><a href="AdminProfile.jsp">User Profile</a></li>
                        <li><a href="MainPage.jsp" onclick="signOut()">Sign Out</a></li>
                    </ul>
                </li>
            </nav>
        </header>

        <div class="container">
            <div class="navbar">
                <a href="AdminProfile.jsp">User Profile</a>
                <a href="ManageStaff.jsp">Manage Manager</a>
                <a href="Report.jsp">Report</a>
                <a href="ViewFeedback2.jsp">View Feedback</a>
            </div>

            <div class="info">
                <img src="IMGDraft/Report.png"> 

            </div>
        </div>

        <script>
            function toggleNavbar() {
                var navbar = document.querySelector('.navbar');
                navbar.classList.toggle('minimized');
            }
            
            function signOut() {
            // Redirect to the logout servlet or your logout logic
            window.location.href = 'LogOutServ'; 
        }
        </script>

        <footer>
            <p>&copy; HR SkillCertify 2023</p>
        </footer>

    </body>

</html>
