<%-- 
    Document   : AboutCertificate
    Created on : 19 Jan 2024, 10:07:25 pm
    Author     : FarisHarr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>

    <head>
        <title>About Certificate</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="CSS/CandidateSkeleton.css">
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    </head>

    <style>

        .infoCert {
            margin: 0 auto;
            text-align: center;
            padding: 20px;
            width: 85%;
            background-color: #DDE6ED;
            display: flex;
            justify-content: space-around; /* Distributes space between the .cert elements */
            flex-wrap: wrap; /* Allows wrapping if there are too many .cert elements */
        }

        .cert {
            background-color: #f9f9f9;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            height: 500px;
            padding: 20px;
            margin: 20px;
            max-width: 450px; /* Adjust the maximum width as needed */
            border-radius: 8px;
            text-align: center;
            display: flex;
            flex-direction: column;
            /*justify-content: space-between;*/
            position: relative;
            transition: transform 0.9s ease; /* Add transition for smooth scaling */
        }

        .cert:hover {
            transform: scale(1.02); /* Scale the element on hover */
        }


        .cert h2 {
            margin-bottom: 10px;
            font-size: 1.5em; /* Adjust font size as needed */
        }

        .cert h4 {
            margin: 10px 0;
            font-size: 1.1em; /* Adjust font size as needed */
        }

        .cert button {
            background-color: #004080;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            position: absolute;
            bottom: 20px;
            left: 50%;
            transform: translateX(-50%);
        }

        .cert button:hover {
            background-color: #45a049;
        }

        .cert a {
            text-decoration: none;
        }

        /*scroll button*/
        #myBtn {
            position: fixed;
            bottom: 20px;
            right: 30px;
            z-index: 99;
            width : 40px;
            border: none;
            background-color: #27374D;
            color: white;
            cursor: pointer;
            padding: 10px;
            border-radius: 5px;
            transition: background-color 0.5s, transform 0.5s;
        }

        #myBtn:hover {
            background-color: #27374D;
            color: #9DB2BF;
            transform: scale(1.1);
        }

    </style>

    <body>
        <%
            //                HttpSession loginsession = request.getSession();
            String candidateID = (String) session.getAttribute("candidateID");

            if (candidateID != null) {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");
                    PreparedStatement ps = con.prepareStatement("SELECT * FROM candidate WHERE cand_ID = ? ");
                    ps.setString(1, candidateID);
                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) {
                        String Name = rs.getString("cand_Name");

        %>
        <header>
            <div class="main">
                <img class="logo" src="IMG/HRSCLogo.png" alt="logo">
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
                        <!-- <li><a href="CustomerProfile.jsp">Edit Information</a></li> -->
                        <li><a href="CandidateProfile.jsp">Profile</a></li>
                        <li><a href="MainPage.jsp" onclick="signOut()">Sign Out</a></li>
                    </ul>
                </li>
            </nav>
        </header>

        <div class="container">
            <div class="navbar">
                <a href="HomePage.jsp">Home</a>
                <a href="CandidateProfile.jsp">User Profile</a>
                <a href="AboutCertificate.jsp">About Certificate</a>
                <a href="TimeTable.jsp">Time Table</a>
                <a href="Feedback.jsp">Feedback</a>
            </div>

            <div class="infoCert">
                <div class="cert">
                    <h2>Sijil Kemahiran Malaysia (SKM) Tahap 1, 2 dan 3</h2><br>
                    <h4>- Skilled in performing a variety of routine and predictable work activities. </h4>
                    <h4>- Proficient in various tasks within a predictable scope. </h4>
                    <h4>- Limited autonomy and responsibility.</h4>
                    <br>
                    <a href="CertificateForm.jsp">
                        <button>Register</button>
                    </a>                
                </div>

                <div class="cert">
                    <h2>Diploma Kemahiran Malaysia (DKM)/ Tahap 4</h2><br>
                    <h4>- Skilled in performing technical and professional work activities with a wide scope and context. </h4>
                    <h4>- Higher level of responsibility and autonomy compared to SKM. </h4>
                    <h4>- May oversee the work of others and manage resources.</h4>
                    <br>
                    <a href="CertificateForm.jsp">
                        <button>Register</button>
                    </a>  
                </div>

                <div class="cert">
                    <h2>Diploma Lanjutan Kemahiran Malaysia (DLKM) / Tahap 5</h2><br>
                    <h4>- Deeply skilled in applying basic principles and complex techniques across a broad and often unexpected scope of work. </h4>
                    <h4>- Highest level of responsibility and autonomy among the three qualifications. </h4>
                    <h4>- Engages in tasks such as analysis, diagnosis, design, planning, evaluation, and operation. </h4>
                    <h4>- Responsible for managing the work of others, allocating resources, and engaging in advanced tasks.</h4>
                    <br>
                    <a href="CertificateForm.jsp">
                        <button>Register</button>
                    </a>  
                </div>

            </div>
        </div>

        <button onclick="topFunction()" id="myBtn" title="top"><i class="fa-solid fa-chevron-up"></i></button>

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
            <p>&copy; HR SkillCertify 2023</p>
        </footer>

    </body>

</html>
