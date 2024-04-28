<%-- 
    Document   : ViewFeedback
    Created on : 19 Jan 2024, 10:30:23 pm
    Author     : FarisHarr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <title>View Feedback</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="CSS/ManageCandidate.css">
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/icon?family=Material+Icons">

    </head>
    
    <body>
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
                    <!-- <a class="nav-link">Account</a> -->
                    <a class="nav-link">Manager</a>
                    <ul class="dropdown-content">
                        <!-- <li><a href="CustomerProfile.jsp">Edit Information</a></li> -->
                        <li><a href="ManagerProfile.jsp">User Profile</a></li>
                        <li><a href="MainPage.jsp" onclick="signOut()">Sign Out</a></li>
                    </ul>
                </li>
            </nav>
        </header>

        <div class="container">
            <div class="navbar">
                <a href="ManagerProfile.jsp">User Profile</a>
                <a href="ManagePayment.jsp">Manage Payment</a>
                <a href="ManageCertificate.jsp">Manage Certificate</a>
                <a href="ViewFeedback.jsp">View Feedback</a>
                <a href="ManageCandidate.jsp">Manage Candidate</a>
            </div>

            <div class="info">
            <button onclick="refreshSalesReport()">Refresh</button>
            <h1>View Feedback</h1>
            <!--Table-->
            <div class="table">
                <table id="table">
                    <thead>
                        <tr>
                            <th>Feedback ID</th>
                            <th>Name</th>
                            <th>Message</th>
                        </tr>
                    </thead>
                </table>
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

        <footer>
            <p>&copy; HR SkillCertify 2023</p>
        </footer>

    </body>

</html>
