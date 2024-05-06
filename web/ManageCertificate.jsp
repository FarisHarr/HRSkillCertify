<%-- 
    Document   : ManageCertificate
    Created on : 19 Jan 2024, 10:27:29 pm
    Author     : FarisHarr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <title>Manage Certificate</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="CSS/StaffSkeleton.css">
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <!--<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet">-->

    </head>

    <style>
        .info {
            margin: 0 auto;
            text-align: center;
            padding: 20px;
            width: 80%;
            height: 100vh;
            background-color: aliceblue;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .certificate-options {
            display: flex;
            align-items: center;
        }


        select {
            height: 25px;
            width: 140px;
            /* Adjust the width as needed */
            margin-left: 10px;
            /* Other styles */


        }


        .table {
            width: 100%;
            margin-top: 20px;
            overflow-x: auto;
        }

        table {
            border-collapse: collapse;
            width: 100%;
        }

        th {
            text-align: center;
            color: white;
            background-color: grey;
            padding: 10px;
        }

        td,
        th {
            border: 1px solid black;
            padding: 8px;
        }

        td {
            background-color: whitesmoke;
            text-align: center;
            vertical-align: middle;
        }

        input[type="date"],
        input[type="time"] {
            padding: 8px;
            border-radius: 5px;
            background-color: #e3e3e3;
            border: 1px solid #ccc;
            width: 80%;
        }

        button {
            padding: 5px 20px;
            background-color: #4CAF50;
            cursor: pointer;
            border-radius: 5px;
        }

        @media screen and (max-width: 600px) {
            .info {
                width: 100%;
            }
        }

        footer {
            background-color: rgb(190, 190, 190); /* Set background color */
            color: black; /* Set text color */
            text-align: center; /* Center-align text */
            padding: 10px; /* Add padding */
            position: fixed; /* Fixed positioning at the bottom */
            left: 0;
            bottom: 0;
            width: 100%; /* Full width */
            height: 20px;
        }
    </style>

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
                <div class="certificate-options">
                    <p>Choose the certificate : </p>
                    <select name="certificate">
                        <option value="" disabled selected>Please choose</option>
                        <option value="SKM">SKM - Sijil Kemahiran Malaysia</option>
                        <option value="DKM">DKM - Diploma Kemahiran Malaysia</option>
                        <option value="DLKM">DLKM - Diploma Lanjutan Kemahiran Malaysia</option>
                    </select>
                </div>

                <h2>Choose Your Class for Attendance</h2>

                <div class="table">
                    <table>
                        <thead>
                            <tr>
                                <th>Certificate Type</th>
                                <th>Class</th>
                                <th>Date</th>
                                <th>Time Slot</th>
                                <th>Action</th>
                            </tr>
                        </thead>

                        <tbody>
                            <!-- Dummy data rows with input fields for date and time selection -->
                            <tr>
                                <td>Certificate A</td>
                                <td>Class X</td>
                                <td><input type="date"></td>
                                <td><input type="time"></td>
                                <td><button>Attend</button></td>
                            </tr>
                            <tr>
                                <td>Certificate B</td>
                                <td>Class Y</td>
                                <td><input type="date"></td>
                                <td><input type="time"></td>
                                <td><button>Attend</button></td>
                            </tr>
                            <tr>
                                <td>Certificate C</td>
                                <td>Class Z</td>
                                <td><input type="date"></td>
                                <td><input type="time"></td>
                                <td><button>Attend</button></td>
                            </tr>
                            <!-- End of dummy data rows -->
                        </tbody>
                    </table>
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