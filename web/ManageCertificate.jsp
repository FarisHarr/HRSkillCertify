<%-- 
    Document   : ManageCertificate
    Created on : 19 Jan 2024, 10:27:29 pm
    Author     : FarisHarr
--%>

<%@ page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Manage Certificate</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="CSS/ManageCertificate.css">
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    </head>
    <body>
        <%
            String staffID = (String) session.getAttribute("staffID");

            int currentPage = 1;
            int recordsPerPage = 10;

            if (request.getParameter("page") != null) {
                currentPage = Integer.parseInt(request.getParameter("page"));
            }

            int start = (currentPage - 1) * recordsPerPage;

            if (staffID != null) {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");

                    // Fetch staff name
                    PreparedStatement ps = con.prepareStatement("SELECT * FROM staff WHERE staff_ID = ?");
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

        <div class="container">
            <div class="navbar">
                <a href="ManagerProfile.jsp">User Profile</a>
                <a href="ManagePayment.jsp">Manage Payment</a>
                <a href="ManageCertificate.jsp">Manage Attendance</a>
                <a href="ManageCandidate.jsp">Manage Candidate</a>
                <a href="ViewFeedback.jsp">View Feedback</a>
            </div>

            <!--Popup Register-->
            <div class="popup" id="popup">
                <div class="popup-content">
                    <span class="close" onclick="hidePopup()">&times;</span>
                    <h2>Register Class</h2>
                    <br><br>
                    <form action="RegisterClassServ" method="POST">
                        <label for="class_Name">Class Name :</label>
                        <select id="class_Name" name="class_Name" required>
                            <option value="" disabled selected>Please Choose</option>
                            <option value="Taklimat Sijil">Taklimat Sijil</option>
                            <option value="SKM">Sijil Kemahiran Malaysia</option>
                            <option value="DKM">Diploma Kemahiran Malaysia</option>
                            <option value="DLKM">Diploma Lanjutan Kemahiran Malaysia</option>
                            <option value="Penilaian Sijil">Penilaian Sijil</option>
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
                        <br><br><br>
                        <div class="submit-button">
                            <input class="submit" type="submit" value="Save">
                        </div>
                    </form>
                </div>
            </div>

            <div class="info">
                <button class="register-product-button1" onclick="location.href = 'DeleteClass.jsp'">Manage Class</button>
                <button class="register-product-button" onclick="showPopup()">
                    <i class="fas fa-plus"></i>
                </button>

                <h2>Manage Attendance</h2> <br>

                <table id="attendanceTable">
                    <thead>
                        <tr>
                            <th>Attendance ID</th>
                            <th>Class Name</th>
                            <th>Name</th>
                            <th>Attendance</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            rs.close();
                            ps.close();

                            PreparedStatement ps2 = con.prepareStatement("SELECT a.attendance_ID, cl.class_Name, c.cand_Name, a.attendance "
                                    + "FROM attendance a "
                                    + "JOIN candidate c ON a.cand_ID = c.cand_ID "
                                    + "JOIN class cl ON a.class_ID = cl.class_ID "
                                    + "WHERE cl.is_archived = FALSE "
                                    + "ORDER BY CASE a.attendance WHEN '--' THEN 1 ELSE 2 END, cl.class_Name, c.cand_Name "
                                    + "LIMIT ? OFFSET ?");
                            ps2.setInt(1, recordsPerPage);
                            ps2.setInt(2, start);
                            ResultSet rs2 = ps2.executeQuery();

                            while (rs2.next()) {
                                int attendanceID = rs2.getInt("attendance_ID");
                                String className = rs2.getString("class_Name");
                                String candidateName = rs2.getString("cand_Name");
                                String attendanceStatus = rs2.getString("attendance");
                        %>
                        <tr>
                            <td><%= attendanceID%></td>
                            <td><%= className%></td>
                            <td><%= candidateName%></td>
                            <td>
                                <form onsubmit="updateStatus(this, '<%= attendanceID%>'); return false;">
                                    <select name="attendanceStatus">
                                        <option value="--" <%= attendanceStatus.equals("--") ? "selected" : ""%>>--</option>
                                        <option value="Absent" <%= attendanceStatus.equals("Absent") ? "selected" : ""%>>Absent</option>
                                        <option value="Present" <%= attendanceStatus.equals("Present") ? "selected" : ""%>>Present</option>
                                    </select>
                                    <input type="hidden" name="attendanceID" value="<%= attendanceID%>">
                                    <input type="submit" value="Update" onclick="showSuccessMessage()">
                                </form>
                            </td>
                        </tr>
                        <%
                            }
                            rs2.close();
                            ps2.close();

                            // Count total records for pagination
                            Statement countStmt = con.createStatement();
                            ResultSet countRs = countStmt.executeQuery("SELECT COUNT(*) FROM attendance a "
                                    + "JOIN candidate c ON a.cand_ID = c.cand_ID "
                                    + "JOIN class cl ON a.class_ID = cl.class_ID "
                                    + "WHERE cl.is_archived = FALSE");
                            countRs.next();
                            int totalRecords = countRs.getInt(1);
                            int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);

                            countRs.close();
                            countStmt.close();
                            con.close();
                        %>
                    </tbody>
                </table>
                <div class="pagination">
                    <%
                        if (currentPage > 1) {
                    %>
                    <a href="ManageCertificate.jsp?page=<%= currentPage - 1%>" style="color: #455d5f">&laquo; Previous</a>
                    <%
                        }
                        if (currentPage < totalPages) {
                    %>
                    <a href="ManageCertificate.jsp?page=<%= currentPage + 1%>" style="color: #455d5f">Next &raquo;</a>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>

        <button onclick="topFunction()" id="myBtn" title="top"><i class="fa-solid fa-chevron-up"></i></button>

        <script>
            function updateStatus(form, attendanceID) {
                form.action = "UpdateAttendanceServ";
                form.method = "POST";
                form.submit();
            }

            function toggleNavbar() {
                var navbar = document.querySelector('.navbar');
                navbar.classList.toggle('minimized');
            }

            function signOut() {
                window.location.href = 'LogOutServ';
            }

            function showPopup() {
                document.getElementById("popup").style.display = "block";
            }

            function hidePopup() {
                document.getElementById("popup").style.display = "none";
            }

            function filterAttendance() {
                var selectBox = document.getElementById("certificateSelect");
                var selectedOption = selectBox.options[selectBox.selectedIndex].value;
                var table = document.getElementById("attendanceTable");
                var rows = table.getElementsByTagName("tr");

                for (var i = 0; i < rows.length; i++) {
                    var row = rows[i];
                    var cell = row.getElementsByTagName("td")[3];

                    if (cell) {
                        var status = cell.textContent || cell.innerText;
                        if (selectedOption === '-' || status === selectedOption) {
                            row.style.display = "";
                        } else {
                            row.style.display = "none";
                        }
                    }
                }
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

        <footer>
            <p>&copy; 2024 <strong>HR SkillCertify</strong>. All rights reserved </p>
        </footer>
        <%
                    } else {
                        out.println("Coordinator not found.");
                    }
                } catch (Exception e) {
                    out.println("Error: " + e.getMessage());
                }
            } else {
                response.sendRedirect("Login.jsp");
            }
        %>
    </body>
</html>


