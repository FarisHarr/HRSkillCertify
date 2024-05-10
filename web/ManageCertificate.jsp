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
        <link rel="stylesheet" type="text/css" href="CSS/ManageCertificate.css">
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <!--<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet">-->

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

            <!--Popup Register-->
            <div class="popup" id="popup">
                <div class="popup-content">
                    <span class="close" onclick="hidePopup()">&times;</span>
                    <h2>Register Class</h2>
                    <br><br>
                    <form action="RegisterClassServ" method="POST">
                        <label for="cert_Type">Certificate Type :</label>
                        <select id="cert_Type" name="cert_Type" required>
                            <option value="SKM">SKM - Sijil Kemahiran Malaysia</option>
                            <option value="DKM">DKM - Diploma Kemahiran Malaysia</option>
                            <option value="DLKM">DLKM - Diploma Lanjutan Kemahiran Malaysia</option>
                        </select>
                        <br><br>
                        <label for="date">Date :</label>
                        <input type="date" id="date" name="date" required>
                        <br><br>
                        <label for="start_time">Start Time :</label>
                        <input type="time" id="start_time" name="start_time" required>
                        <br><br>
                        <label for="end_Time">End Time :</label>
                        <input type="time" id="end_Time" name="end_Time" required>

                        <br><br>

                        <br><br>
                        <div class="submit-button">
                            <input class="submit" type="submit" value="Save">
                        </div>
                    </form>

                </div>
            </div>


            <div class="info">
                <button class="register-product-button" onclick="showPopup()">Create Class</button>
                <h2>Manage Certificate</h2> <br>
                <div class="certificate-options">
                    <p>Choose the certificate : </p>
                    <select name="certificate">
                        <option value="" disabled selected>Please choose</option>
                        <option value="SKM">SKM - Sijil Kemahiran Malaysia</option>
                        <option value="DKM">DKM - Diploma Kemahiran Malaysia</option>
                        <option value="DLKM">DLKM - Diploma Lanjutan Kemahiran Malaysia</option>
                    </select>
                </div>

                <table>
                    <thead>
                        <tr>
                            <th>Attendance ID</th>
                            <th>Class ID</th>
                            <th>Candidate ID</th>
                            <th>Certificate Type</th>
                            <th>Attendance</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Assuming you have attendance data available in your JSP -->
                        <tr>

                            <td><button>Create</button></td>
                        </tr>
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

            function showPopup() {
                document.getElementById("popup").style.display = "block";
            }

            function hidePopup() {
                document.getElementById("popup").style.display = "none";
            }
        </script>

        <footer>
            <p>&copy; HR SkillCertify 2023</p>
        </footer>

    </body>

</html>