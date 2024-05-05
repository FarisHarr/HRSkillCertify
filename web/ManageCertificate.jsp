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

    </head>

    <style>
        .infoCert {
            margin: 0 auto;
            text-align: center;
            padding: 10px;
            width: 90%;
            background-color: aliceblue;
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }

        .cert {
            background-color: #a4a4a4;
            padding: 50px;
            margin: 40px;
            border-radius: 8px;
            text-align: center;
            display: flex;
            flex-direction: column;
            width: 30%;
            height: 50vh;
            transition: transform 0.1s ease-in-out;
        }

        .cert:hover {
            transform: scale(1.05);
        }

        .cert h2 {
            margin-bottom: 10px;
        }

        .cert button {
            background-color: #fff;
            color: #212121;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            width: 30%;
            cursor: pointer;
            margin-top: 10vh;
            /* Push the button to the bottom */
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

            <div class="infoCert">
                <div class="cert">
                    <h2>Sijil Kemahiran Malaysia (SKM) Tahap 1, 2 dan 3</h2>
                    <a href="#">
                        <button>Check</button>
                    </a>                
                </div>

                <div class="cert">
                    <h2>Diploma Kemahiran Malaysia (DKM)/ Tahap 4</h2>
                    <!-- Add content for container 2 -->
                    <a href="#">
                        <button>Check</button>
                    </a>
                </div>

                <div class="cert">
                    <h2>Diploma Lanjutan Kemahiran Malaysia (DLKM) / Tahap 5</h2>
                    <!-- Add content for container 3 -->
                    <a href="#">
                        <button>Check</button>
                    </a>
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