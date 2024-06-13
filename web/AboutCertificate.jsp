<%-- 
    Document   : AboutCertificate
    Created on : 19 Jan 2024, 10:07:25 pm
    Author     : FarisHarr
--%>

<%@page import="java.util.Base64"%>
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
        .progress {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            align-items: center;
            width: 80%;
            min-height: 80vh;
            background-color: #DDE6ED;
            flex-direction: column;
            margin: 20px;
            margin-left: 70px;

        }
        .title{
            padding: 30px;
            width: 50%;
            background-color: whitesmoke;
            border: 1px solid #ccc;
            border-radius: 30px;
            box-shadow: 0 0px 10px rgba(0, 0, 0, 0.5);
        }

        .title h2{
            text-align: center;
        }

        .progress-container {
            background-color: #f3f3f3;
            border-radius: 25px;
            margin: 20px 0;
            display: flex;
            justify-content: center; /* Center the progress bar */
        }

        .progress-bar {
            width: 220px; /* Fixed width for the progress bar */
            height: 30px;
            border-radius: 25px;
            text-align: center;
            line-height: 30px;
            color: black;
        }

        .profile-info {
            width: 350px;
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin-bottom: 20px;
            margin-left: 100px;
            /*width: 90%;*/
        }

        .info-item {
            display: flex;
            justify-content: flex-start;
            align-items: center;
            padding: 10px;
            /*border-top: 1px solid #ddd;*/
            border-bottom: 1px solid #ddd;
        }

        .info-item label {
            width: 170px;
            /*border: 1px solid #000;*/
            padding: 5px;
            font-weight: bold;
            color: #333;
            margin-right: 20px; /* Adds spacing between the label and the span */
            font-size: 1.05rem;
        }

        .info-item .status {
            text-align: center;
            width: 150px;
            margin-left: 5px;
            padding: 3px 8px;
            border-radius: 5px;
            font-weight: bold;
            color: green; /* Default color for status */
        }


        .info-item .status.not-completed  {
            color: red; /* Color for not completed status */
            background-color: #f8d7da; /* Optional: Red background for not completed status */

        }
        .info-item .status.not-completed a {
            font-size: 20px;
            font-weight: bold;
            color: red; /* Color for not completed status */
        }

        .info-item .pending,
        .info-item .in-progress {
            color: orange; /* Color for pending and in progress status */
            background-color: #fff3cd; /* Optional: Yellow background for pending and in progress status */
        }

        .info-item .pending a,
        .info-item .in-progress a {
            font-size: 20px;
            font-weight: bold;
            color: orange; /* Color for not completed status */
        }


        /*        .info-item .status.completed {
                    color: green;  Color for completed status 
                    background-color: #d4edda;  Optional: Green background for completed status 
                }*/

        .get-certificate {
            display: block;
            width: fit-content; /* Adjust width to fit the content */
            padding: 10px 30px; /* Adjust padding for better appearance */
            margin: 20px auto 0; /* Center horizontally, 20px top margin */
            border: none;
            background-color: #4CAF50;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        .get-certificate:hover {
            background-color: #45a049;
            transform: scale(1.01); /* Scale the button slightly on hover */
        }


        /*scroll button*/
        #myBtn {
            position: fixed;
            bottom: 20px;
            right: 30px;
            z-index: 99;
            width: 40px;
            border: none;
            background-color: #27374D;
            color: white;
            cursor: pointer;
            padding: 10px;
            border-radius: 5px;
            visibility: hidden; /* Initially hidden */
            opacity: 0; /* Initially invisible */
            transition: visibility 0s, opacity 0.5s, background-color 0.5s, transform 0.5s;
        }

        #myBtn:hover {
            background-color: #27374D;
            color: #9DB2BF;
            transform: scale(1.1);
        }

    </style>

    <body>
        <%
            String candidateID = (String) session.getAttribute("candidateID");

            if (candidateID != null) {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");

                    // Step 1: Fetch candidate details and certificate
                    PreparedStatement ps = con.prepareStatement("SELECT cand_Name, cand_Certificate FROM candidate WHERE cand_ID = ?");
                    ps.setString(1, candidateID);
                    ResultSet rs = ps.executeQuery();

                    String Name = "";
                    String receiptBase64 = "";

                    if (rs.next()) {
                        Name = rs.getString("cand_Name");
                        Blob certificateBlob = rs.getBlob("cand_Certificate");

                        if (certificateBlob != null) {
                            byte[] certificateBytes = certificateBlob.getBytes(1, (int) certificateBlob.length());
                            receiptBase64 = Base64.getEncoder().encodeToString(certificateBytes);
                        } else {
                            // Handle case where certificateBlob is null (no certificate found)
                            // For example, set a default image or display a message
                        }
                    } else {
                        // Handle case where no candidate with candidateID is found
                        // For example, set default values or display an error message
                    }

                    // Step 2: Fetch registration status
                    ps = con.prepareStatement("SELECT cert_Type FROM certificate WHERE cand_ID = ?");
                    ps.setString(1, candidateID);
                    rs = ps.executeQuery();
                    boolean isRegistered = rs.next();

                    // Step 3: Fetch payment status
                    ps = con.prepareStatement("SELECT status FROM payment WHERE cand_ID = ?");
                    ps.setString(1, candidateID);
                    rs = ps.executeQuery();
                    boolean isPaid = false;
                    boolean isPending = false; // Track pending status

                    while (rs.next()) {
                        String paymentStatus = rs.getString("status");
                        if (paymentStatus.equalsIgnoreCase("Approved")) {
                            isPaid = true;
                        } else if (paymentStatus.equalsIgnoreCase("Pending")) {
                            isPending = true;
                        }
                    }

                    // Step 4: Fetch class attendance status
                    ps = con.prepareStatement("SELECT attendance FROM attendance WHERE cand_ID = ?");
                    ps.setString(1, candidateID);
                    rs = ps.executeQuery();

                    int attendanceCount = 0;
                    while (rs.next()) {
                        String attendance = rs.getString("attendance");
                        if ("Present".equalsIgnoreCase(attendance) || "Absent".equalsIgnoreCase(attendance)) {
                            attendanceCount++;
                        }
                    }
                    boolean hasAttendedClass = attendanceCount >= 3;
                    String attendanceStatus = hasAttendedClass ? "Completed" : "In Progress";

                    // Step 5: Fetch certificate issuance status
                    boolean hasCertificate = receiptBase64 != null && !receiptBase64.isEmpty();

                    // Calculate progress percentage
                    int progressCount = 0;
                    if (isRegistered) {
                        progressCount++;
                    }
                    if (isPaid || isPending) {
                        progressCount++;
                    }
                    if (hasAttendedClass) {
                        progressCount++;
                    }
                    if (hasCertificate) {
                        progressCount++;
                    }
                    int progressPercentage = (progressCount * 100) / 4;

                    // Determine progress bar color based on progressPercentage
                    String progressColor;
                    if (progressPercentage <= 25) {
                        progressColor = "#f44336"; // Red
                    } else if (progressPercentage <= 50) {
                        progressColor = "#ff9800"; // Orange
                    } else if (progressPercentage <= 75) {
                        progressColor = "#ffeb3b"; // Yellow
                    } else {
                        progressColor = "#4caf50"; // Green
                    }

                    // Close resources
                    rs.close();
                    ps.close();
                    con.close();
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
                <a href="AboutCertificate.jsp">Status</a>
                <a href="TimeTable.jsp">Time Table</a>
                <a href="Feedback.jsp">Feedback</a>
                <a href="StandardRegistry.jsp">Standard Registry</a>
            </div>

            <div class="progress">
                <div class="title">
                    <h2>Certification Progress</h2>
                    <div class="progress-container">
                        <div class="progress-bar" style="background-color:<%= progressColor%>;"><%= progressPercentage%>%</div>
                    </div>

                    <div class="profile-info">
                        <div class="info-item" style="border-top: 1px solid #ddd; padding-top: 15px">
                            <label>Registration :</label>
                            <span class="status <%= isRegistered ? "" : "not-completed"%>">
                                <% if (isRegistered) { %>
                                Completed
                                <% } else { %>
                                <a href="CertificateForm.jsp">Not Completed</a>
                                <% }%>
                            </span>
                        </div>
                        <div class="info-item">
                            <label>Payment :</label>
                            <span class="status <%= isPaid ? "completed" : (isPending ? "pending" : "not-completed")%>">
                                <% if (isPaid) { %>
                                Completed
                                <% } else if (isPending) { %>
                                <a href="Payment.jsp">Status Pending</a>
                                <% } else { %>
                                <a href="TimeTable.jsp">Not Completed</a>
                                <% }%>
                            </span>
                        </div>
                        <div class="info-item">
                            <label>Class :</label>
                            <span class="status <%= hasAttendedClass ? "" : (attendanceCount < 3 ? "in-progress" : "not-completed")%>">
                                <% if (hasAttendedClass) { %>
                                Completed
                                <% } else if (attendanceCount < 3) { %>
                                <a href="TimeTable.jsp">In Progress</a>
                                <% } else { %>
                                <a href="TimeTable.jsp">Not Completed</a>
                                <% }%>
                            </span>
                        </div>
                        <div class="info-item">
                            <label>Certificate :</label>
                            <span class="status <%= hasCertificate ? "" : "not-completed"%>">
                                <% if (hasCertificate) { %>
                                Completed
                                <% } else { %>
                                <a href="CandidateProfile.jsp">Not Completed</a>
                                <% } %>
                            </span>
                        </div>
                    </div>

                    <% if (hasCertificate) {%>
                    <form action="LargeImage.jsp" method="post" target="_blank" style="margin: 0;">
                        <input type="hidden" name="image" value="<%= receiptBase64%>">
                        <button class="get-certificate" type="submit">Get Certificate</button>
                    </form>
                    <% } %>

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
                window.location.href = 'LogOutServ';
            }

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
                window.scrollTo({
                    top: 1,
                    behavior: "smooth"
                });
            }
        </script>

        <%
                } catch (Exception e) {
                    out.println("Error: " + e);
                }
            } else {
                response.sendRedirect("Login.jsp");
            }
        %>

        <footer>
            <p>&copy; HR SkillCertify 2023</p>
        </footer>

    </body>

</html>