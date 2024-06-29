<%-- 
    Document   : Certificate
    Created on : 1 Jun 2024, 9:26:59 pm
    Author     : FarisHarr
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Upload Certificate Candidate</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="CSS/Certificate.css">
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>

    <body>
        <%
            //           HttpSession loginsession = request.getSession();
            String staffID = (String) session.getAttribute("staffID");

            if (staffID != null) {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");
                    PreparedStatement ps = con.prepareStatement("SELECT * FROM staff WHERE staff_ID = ? ");
                    ps.setString(1, staffID);
                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) {
                        String Name = rs.getString("staff_Name");

        %>

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
                    <a class="nav-link"><%= Name%></a>
                    <ul class="dropdown-content">
                        <li><a href="ManagerProfile.jsp">User Profile</a></li>
                        <li><a href="MainPage.jsp" onclick="signOut()">Sign Out</a></li>
                    </ul>
                </li>
            </nav>
        </header>

        <%
                    } else {
                        out.println("Coordinator not found.");
                    }

                    rs.close();
                    ps.close();
                    con.close();
                } catch (Exception e) {
                    out.println("Error: " + e);
                }
            } else {
                // If the session doesn't exist or staffID is not set, redirect to the login page
                response.sendRedirect("Login.jsp");
            }

            // Retrieve the cand ID from the request parameter
            String candID = request.getParameter("cand_ID");

            // Check if the cand ID is present
            if (candID != null && !candID.isEmpty()) {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");
                    PreparedStatement pst = con.prepareStatement("SELECT * FROM candidate WHERE cand_ID = ?");
                    pst.setString(1, candID);
                    ResultSet rs = pst.executeQuery();

                    if (rs.next()) {
                        String IC = rs.getString("cand_IC");
                        String name = rs.getString("cand_Name");
                        String email = rs.getString("cand_Email");
//                        String phone = rs.getString("cand_Phone");

                        PreparedStatement certPs = con.prepareStatement("SELECT * FROM certificate WHERE cand_ID = ?");
                        certPs.setString(1, candID);
                        ResultSet certRs = certPs.executeQuery();
                        while (certRs.next()) {
                            String certID = certRs.getString("cert_ID");
                            String certType = certRs.getString("cert_Type");
                            String workType = certRs.getString("work_Type");
//                            String experience = certRs.getString("experience");
        %>

        <div class="container">
            <div class="navbar">
                <a href="ManagerProfile.jsp">User Profile</a>
                <a href="ManagePayment.jsp">Manage Payment</a>
                <a href="ManageCertificate.jsp">Manage Certificate</a>
                <a href="ManageCandidate.jsp">Manage Candidate</a>
                <a href="ViewFeedback.jsp">View Feedback</a>
            </div>

            <div class="popup-content">
                <h2>Upload Certificate</h2><br>
                <table>
                    <tr>
                        <td>Certificate ID :</td>
                        <td><%= certID%></td>
                    </tr>
                    <tr>
                        <td>Name :</td>
                        <td style="font-weight: bold;"><%= name%></td>
                    </tr>
                    <tr>
                        <td>IC Number :</td>
                        <td><%= IC%></td>
                    </tr>
                    <tr>
                        <td>Email :</td>
                        <td><%= email%></td>
                    </tr>
                    <tr>
                        <td>Certificate Type :</td>
                        <td style="font-weight: bold;"><%= certType%></td>
                    </tr>
                    <tr>
                        <td>Work Type :</td>
                        <td><%= workType%></td>
                    </tr>
                </table>


                <div class="upload-section">
                    <h4>Upload Candidate Certificate</h4>
                    <form action="SubmitCertificateServ" method="POST" enctype="multipart/form-data">
                        <input type="hidden" name="candID" value="<%= candID%>">
                        <input type="file" name="certificate" accept="image/*">
                        <button type="submit" name="action" value="Upload">Upload</button>
                        <button type="button" onclick="window.location.href = 'ManageCandidate.jsp'">Cancel</button>
                    </form>
                </div>

            </div>
        </div>

        <button onclick="topFunction()" id="myBtn" title="top"><i class="fa-solid fa-chevron-up"></i></button>
            <%
                            }
                            certRs.close();
                            certPs.close();
                        } else {
                            out.println("Candidate not found.");
                        }

                        rs.close();
                        pst.close();
                        con.close();
                    } catch (Exception e) {
                        out.println("Error: " + e);
                    }
                } else {
                    out.println("Invalid candidate ID.");
                }
            %>

        <script>
            function goBack() {
                // Redirect back to the previous page
                history.go(-1);
            }

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

        <footer>
            <p>&copy; 2024 <strong>HR SkillCertify</strong>. All rights reserved </p>
        </footer>
    </body>
</html>
