<%-- 
    Document   : CandidateProfile
    Created on : 27 Dec 2023, 3:16:14 pm
    Author     : FarisHarr
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@page import="java.util.Base64"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="CSS/User Information.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <title>Candidate Profile</title>
    </head>

    <style>
        .profile-info {
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin-bottom: 20px;
            /*width: 90%;*/
        }

        .info-item {
            display: flex;
            justify-content: flex-start;
            align-items: center;
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }

        .info-item label {
            width: 160px;
            /*border: 1px solid #000;*/
            padding: 5px;
            font-weight: bold;
            color: #333;
            margin-right: 20px; /* Adds spacing between the label and the span */
            font-size: 1.05rem;
        }

        .info-item span {
            width: 350px;
            color: #555;
            font-size: 1.05rem;
            /*border: 1px solid #eee;*/
        }
    </style>

    <body>

        <%
            //           HttpSession loginsession = request.getSession();
            String candidateID = (String) session.getAttribute("candidateID");

            if (candidateID != null) {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");
                    PreparedStatement ps = con.prepareStatement("SELECT * FROM candidate WHERE cand_ID = ? ");
                    ps.setString(1, candidateID);
                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) {
                        String ID = rs.getString("cand_ID");
                        String IC = rs.getString("cand_IC");
                        String Name = rs.getString("cand_Name");
                        String Email = rs.getString("cand_Email");
//                            String Password = rs.getString("cand_Pass");
                        String Phone = rs.getString("cand_Phone");
                        String Address = rs.getString("cand_Add");
                        byte[] Certificate = rs.getBytes("cand_Certificate");
                        String receiptBase64 = "";

                        if (Certificate != null) {
                            receiptBase64 = Base64.getEncoder().encodeToString(Certificate);
                        } else {
                            // Handle null receipt value, if needed
                            // For example, you can set a default image or display a message
                        }
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
                                            <!--ada error logout kalau letak-->
                        <li><a href="#" onclick="signOut()">Sign Out</a></li>
                    </ul>
                </li>
            </nav>
        </header>

        <div class="co">
            <div class="navbar">
                <a href="HomePage.jsp">Home</a>
                <a href="CandidateProfile.jsp">User Profile</a>
                <a href="AboutCertificate.jsp">Status</a>
                <a href="TimeTable.jsp">Time Table</a>
                <a href="Feedback.jsp">Feedback</a>
                <a href="StandardRegistry.jsp">Standard Registry</a>
            </div>

            <div class="container">
                <br>
                <div class="title">
                    <h1>User Profile</h1>
                    <br>
                    <div class="profile-info">
                        <div class="info-item">
                            <label>Name :</label>
                            <span><%= Name%></span>
                        </div>
                        <div class="info-item">
                            <label>IC Number :</label>
                            <span><%= IC%></span>
                        </div>
                        <div class="info-item">
                            <label>Email :</label>
                            <span><%= Email%></span>
                        </div>
                        <div class="info-item">
                            <label>Phone Number :</label>
                            <span><%= Phone%></span>
                        </div>
                        <div class="info-item">
                            <label>Address :</label>
                            <span><%= Address%></span>
                        </div>
                    </div>

                    <h3 style="text-align: center;">Certificate :</h3>

                    <h3 style="width: auto; text-align: center;">
                        <%
                            if (receiptBase64 != null && !receiptBase64.isEmpty()) {
                        %>
                        <form action="LargeImage.jsp" method="post" target="_blank" style="margin: 0;">
                            <input type="hidden" name="image" value="<%= receiptBase64%>">
                            <button type="submit" style="height: 50%; border: 1px solid black; background: none; cursor: pointer">
                                <img src="data:image/jpeg;base64,<%= receiptBase64%>" class="image-button" style="width: 430px; height: 325px;">
                            </button>
                        </form>
                        <%
                        } else {
                        %>
                        <!-- Placeholder image -->
                        <!--<img src="IMG/White.png" class="image-button" style="width: 400px; height: 250px;; margin: auto;">-->
                        <h4 style="text-align: center;">In Process</h4>


                        <%
                            }
                        %>
                    </h3>
                                    <a href="EditCandidate.jsp?id=<%= ID%>">
                    <button class="profile-update-button">EDIT</button>
                </a> 
                </div>
                    <br>
            </div>
        </div>

        <button onclick="topFunction()" id="myBtn" title="top"><i class="fa-solid fa-chevron-up"></i></button>

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
            <p>&copy; 2024 <strong>HR SkillCertify</strong>. All rights reserved </p>
        </footer>

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

    </body>

</html>
