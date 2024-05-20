<%-- 
    Document   : StaffDashboard
    Created on : 3 Jan 2024, 10:25:46 pm
    Author     : FarisHarr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <title>Staff Dashboard</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="CSS/StaffDashboard.css">
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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

            <h2>Attendance Overview</h2>
            <canvas id="attendanceChart" width="400" height="200"></canvas>
            
            <h2>Feedback Summary</h2>
            <canvas id="feedbackChart" width="100" height="100"></canvas>
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

        // Dummy data for the charts
        const attendanceData = {
            labels: ['Class A', 'Class B', 'Class C', 'Class D'],
            datasets: [{
                label: 'Attendance Percentage',
                data: [85, 90, 75, 80],
                backgroundColor: [
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)',
                    'rgba(153, 102, 255, 0.2)'
                ],
                borderColor: [
                    'rgba(75, 192, 192, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(153, 102, 255, 1)'
                ],
                borderWidth: 2
            }]
        };

        const feedbackData = {
            labels: ['Positive', 'Neutral', 'Negative'],
            datasets: [{
                label: 'Feedback Count',
                data: [65, 20, 15],
                backgroundColor: [
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(255, 206, 86, 0.2)',
                    'rgba(255, 99, 132, 0.2)'
                ],
                borderColor: [
                    'rgba(75, 192, 192, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(255, 99, 132, 1)'
                ],
                borderWidth: 1
            }]
        };

        window.onload = function() {
            var ctxAttendance = document.getElementById('attendanceChart').getContext('2d');
            var attendanceChart = new Chart(ctxAttendance, {
                type: 'bar',
                data: attendanceData,
                options: {
                    scales: {
                        y: {
                            beginAtZero: true,
                            max: 100
                        }
                    }
                }
            });

//            var ctxFeedback = document.getElementById('feedbackChart').getContext('2d');
//            var feedbackChart = new Chart(ctxFeedback, {
//                type: 'pie',
//                data: feedbackData
//            });
        };
    </script>

        <footer>
            <p>&copy; HR SkillCertify 2023</p>
        </footer>

    </body>

</html>
