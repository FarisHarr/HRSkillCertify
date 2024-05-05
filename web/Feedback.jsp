<%-- 
    Document   : Feedback
    Created on : 19 Jan 2024, 10:20:09 pm
    Author     : FarisHarr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>

    <head>
        <title>Feedback</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="CSS/CandidateSkeleton.css">
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    </head>

    <style>
        .info {
            margin: 0 auto;
            text-align: center;
            padding: 20px;
            width: 80%;
            height: 100vh;
            background-color: #f0f0f0;
            border: 1px solid #000000;
            display: flex;
        }

        .cert1 {
            background-color: rgb(199, 199, 199);
            ;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 50px;
            margin: 30px;
            margin-left: 100px;
            width: 500px;
            border-radius: 8px;
            text-align: center;
            display: flex;
            flex-direction: column;

        }

        .cert2 {
            background-color: rgb(199, 199, 199);
            ;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 50px;
            margin: 30px;
            width: 300px;
            border-radius: 8px;
            text-align: center;
            display: flex;
            flex-direction: column;

        }

        /* Basic form styling */
        #feedbackForm {
            margin-top: 20px;
        }

        /* Style for form labels */
        #feedbackForm label {
            display: block;
            margin-top: 10px;
        }

        /* Style for form inputs */
        #feedbackForm input[type="text"],
        #feedbackForm input[type="email"],
        #feedbackForm textarea {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        /* Style for submit button */
        #feedbackForm button[type="submit"] {
            background-color: #ffffff;
            color: rgb(0, 0, 0);
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 20px;
        }

        #feedbackForm button[type="submit"]:hover {
            background-color: #4CAF50;
        }

        #contactus button[type="submit"] {
            background-color: #ffffff;
            color: rgb(0, 0, 0);
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 20px;
        }

        #contactus button[type="submit"]:hover {
            background-color: #4CAF50;
        }

        .contact-icons {
            display: flex;
        }

        
        .contact-icons a {
            color: #333; /* Icon color */
            font-size: 20px;
            margin-left: 5px; /* Adjust the distance between icons */
            text-decoration: none;
            transition: background-color 0.1s, transform 0.1s;
        }

        .contact-icons a:hover {
            color: #007bff; /* Change color on hover */
            transform: scale(1.05);
        }



    </style>

    <body>
        <%
            String candidateID = (String) session.getAttribute("candidateID");
            // Set the candidateID attribute to the session
            session.setAttribute("candidateID", candidateID);

            if (candidateID != null) {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");
                    PreparedStatement ps = con.prepareStatement("SELECT * FROM candidate WHERE cand_ID = ? ");
                    ps.setString(1, candidateID);
                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) {
                        String Name = rs.getString("cand_Name");
                        String Email = rs.getString("cand_Email");

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

            <div class="cert1">
                <h2>Feedback</h2>
                <form id="feedbackForm" action="FeedbackServ" method="POST">
                    <label for="name">Name:</label><br>
                    <input type="text" id="name" name="name" value="<%= Name%>" readonly ><br>
                    <label for="email">Email:</label><br>
                    <input type="email" id="email" name="email" value="<%= Email%>" readonly><br>
                    <label for="message" >Feedback:</label><br>
                    <textarea id="message" name="message" required></textarea><br>
                    <button type="submit">Submit Feedback</button>
                </form>
            </div>

            <div class="cert2">
                <h2>Contact Us</h2>
                <form id="contactus">
                    <label for="contactus"></label><br>
                    <div class="contact-icons">
                        <a href="https://www.facebook.com/harris.hussain.58" target="_blank" title="Facebook"><i class="fab fa-facebook"></i><br> HR Skill Solutions</a>
                        <a href="https://pppkt.onpay.my/order/form/pppktonlinetajaan" target="_blank" title="Info"><i class="fas fa-envelope"></i><br> Information</a>
                        <a href="https://api.whatsapp.com/send?phone=60197293275&text=PPKT24" target="_blank" title="WhatsApp">
                            <i class="fab fa-whatsapp"></i> <br> Contact Us </a>   
                    </div>
                </form>
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

