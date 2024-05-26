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
                    <a class="nav-link">Manager</a>
                    <ul class="dropdown-content">
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
                <h2>Certificate Overview</h2>
                <canvas id="paymentChart" width="400" height="200"></canvas>
                <button class="button" onclick="printPage()">Print Page</button>

            </div>
        </div>
        <script>
            function toggleNavbar() {
                var navbar = document.querySelector('.navbar');
                navbar.classList.toggle('minimized');
            }

            function signOut() {
                window.location.href = 'LogOutServ';
            }

            window.onload = function () {
                fetch('PaymentDataServ')
                        .then(response => response.json())
                        .then(data => {
                            const labels = data.map(item => item.cert_Type);
                            const counts = data.map(item => item.count);
                            const paymentData = {
                                labels: labels,
                                datasets: [{
                                        label: 'Certificate Count',
                                        data: counts,
                                        backgroundColor: [
                                            'rgba(75, 192, 192, 0.5)',
                                            'rgba(54, 162, 235, 0.5)',
                                            'rgba(255, 206, 86, 0.5)',
                                            'rgba(153, 102, 255, 0.5)',
                                            'rgba(255, 159, 64, 0.5)'
                                        ],
                                        borderColor: [
                                            'rgba(75, 192, 192, 1)',
                                            'rgba(54, 162, 235, 1)',
                                            'rgba(255, 206, 86, 1)',
                                            'rgba(153, 102, 255, 1)',
                                            'rgba(255, 159, 64, 1)'
                                        ],
                                        borderWidth: 1.5
                                    }]
                            };
                            var ctxPayment = document.getElementById('paymentChart').getContext('2d');
                            var paymentChart = new Chart(ctxPayment, {
                                type: 'bar',
                                data: paymentData,
                                options: {
                                    scales: {
                                        y: {
                                            beginAtZero: true
                                        }
                                    }
                                }
                            });
                        });
            };

            function printPage() {
                // Retrieve the canvas element containing the graph
                var canvas = document.getElementById('paymentChart');

                // Open a new window
                var printWindow = window.open('', '_report');

                // Write the HTML content to the new window
                printWindow.document.write('<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"><title>Staff Dashboard Report</title><style>body {font-family: Arial, sans-serif;padding: 20px;}h1 {text-align: center;}.chart-container {margin: 20px auto;text-align: center;}</style></head><body>');

                // Add title to the report
                printWindow.document.write('<h1>Staff Dashboard Report</h1>');

                // Add some report content
                printWindow.document.write('<p>This report provides an overview of certificates issued.</p>');

                // Append the canvas element to the new window
                printWindow.document.write('<div class="chart-container"><h2>Certificate Overview</h2><img src="' + canvas.toDataURL() + '"></div>');

                // Add buttons for printing and downloading
                printWindow.document.write('<div style="text-align:center;margin-top:20px;">');
                printWindow.document.write('<button onclick="window.print()">Print</button>');
                printWindow.document.write('<a href="' + canvas.toDataURL() + '" download="certificate_overview.png"><button>Download</button></a>');
                printWindow.document.write('</div>');

                // Close the HTML content
                printWindow.document.write('</body></html>');

                // Close the document for IE compatibility
                printWindow.document.close();
            }
        </script>
        <footer>
            <p>&copy; HR SkillCertify 2023</p>
        </footer>
    </body>
</html>




