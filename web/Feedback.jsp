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
            background-color: #f9f9f9;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            padding: 40px;
/*            margin: 30px;
            margin-left: 40px;*/
            margin: auto;
            width: 40%;
            border-radius: 8px;
            text-align: center;
            display: flex;
            flex-direction: column;

        }

        .cert2 {
            background-color: #f9f9f9;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            padding: 20px;
            padding-right: 40px;
            padding-left: 40px;
            margin: auto;
            width: 400px;
            border-radius: 8px;
            text-align: center;
            display: flex;
            flex-direction: column;

        }

        .container {
            width: 100%;
            height: 100vh;
            margin: 0 auto;
            display: flex; /* Use flexbox to position children side by side */
        }

        /* Basic form styling */
        #feedbackForm {
            margin-top: 20px;
        }

        /* Style for form labels */
        #feedbackForm label {
            display: block;
            margin-bottom: 10px;
            margin-top: 25px;
        }

        /* Style for form inputs */
        #feedbackForm input[type="text"],
        #feedbackForm input[type="email"],
        #feedbackForm textarea {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #526D82;
            border-radius: 4px;
            box-sizing: border-box;
            resize: none;
        }
        
        #feedbackForm textarea {
            height: 80px;
        }


        /* Style for submit button */
        #feedbackForm button[type="submit"] {
            background-color: #004080;
            color: white;
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

        form{
            margin-top: auto;
        }

        .contact-icons {
            display: flex;
        }

        .contact-icons a {
            color: #666666; /* Icon color */
            font-size: 20px;
            margin: 10px;
            /*margin-left: 5px;  Adjust the distance between icons */
            text-decoration: none;
            transition: background-color 0.1s, transform 0.1s;
        }

        .contact-icons a:hover {
            color:#004080;
            transform: scale(1.05);
        }

        .review {
            width: 100%;
            height: 60vh;
            background-color: whitesmoke;
            /*box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);*/
            position: relative; /* Ensure relative positioning for the iframe */
        }

        .review iframe {
            width: 100%;
            height: 100%;
            border: 2px solid #ccc;
            /*box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);*/
            border-radius: 4px;
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
                    <label for="name">Name:</label>
                    <input type="text" id="name" name="name" value="<%= Name%>" readonly ><br>
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" value="<%= Email%>" readonly><br>
                    <label for="message" >Feedback:</label>
                    <textarea id="message" name="message" required></textarea><br>
                    <button type="submit">Submit Feedback</button>
                </form>
            </div>

            <div class="cert2">
                <h2>Contact Us</h2><br>
                <div class="review">
                    <!-- Embedded Google Map -->
                    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d7958.560217539045!2d100.52152113677145!3d5.503182003707448!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x304b002bb55aa7ff%3A0x3b7aefb6a76b91b3!2s1336%2C%20Jalan%20Serai%20Wangi%2013%2F6%2C%2009010%20Padang%20Serai%2C%20Kedah%2C%20Malaysia!5e0!3m2!1sen!2smy!4v1684642959811!5m2!1sen!2smy" allowfullscreen="" loading="lazy"></iframe>
                </div>
                <form id="contactus">
                    <label for="contactus"></label><br>
                    <div class="contact-icons">
                        <a href="https://www.facebook.com/harris.hussain.58" target="_blank" title="Facebook"><i class="fab fa-facebook"></i><br> HR Skill Solutions</a>
                        <a href="https://pppkt.onpay.my/order/form/pppktonlinetajaan" target="_blank" title="Info"><i class="fas fa-envelope"></i><br> Information</a>
                        <a href="https://api.whatsapp.com/send?phone=60197293275&text=PPKT24" target="_blank" title="WhatsApp">
                            <i class="fab fa-whatsapp"></i> <br> WhatsApp </a>   
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

