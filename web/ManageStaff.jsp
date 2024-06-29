<%-- 
    Document   : ManageStaff
    Created on : 5 Jan 2024, 11:12:29 pm
    Author     : FarisHarr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>

    <head>
        <title>Manage Staff</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="CSS/ManageStaff.css">
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
                <a href="AdminDashboard.jsp">
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
                        <li><a href="AdminProfile.jsp">User Profile</a></li>
                        <li><a href="MainPage.jsp" onclick="signOut()">Sign Out</a></li>
                    </ul>
                </li>
            </nav>
        </header>

        <!--Popup Register-->
        <div class="popup" id="popup">
            <div class="popup-content">
                <span class="close" onclick="hidePopup()">&times;</span>
                <h2>Register Staff</h2>
                <br><br>
                <form action="RegisterStaffServ" method="POST">
                    <label for="IC">IC Number :</label>
                    <input type="text" id="IC" name="IC" placeholder="Enter Your IC Number" oninput="restrictToNumbers(this);" maxlength="12" required>
                    <br><br>
                    <label for="Name">Name :</label>
                    <input type="text" id="Name" name="Name" placeholder="Enter Your Name" required>
                    <br><br>
                    <label for="Email">Email :</label>
                    <input type="text" id="Email" name="Email" placeholder="Enter Email" required>
                    <br><br>
                    <label for="Password">Password :</label>
                    <input type="text" id="Password" name="Password" placeholder="Enter Password" required>
                    <br><br>
                    <label for="Phone">Phone Number :</label>
                    <input type="text" name="Phone" size="20" oninput="this.value = this.value.replace(/[^0-9]/g, '')" placeholder="Enter Phone Number" maxlength="12" required><br>
                    <br>
                    <label for="Role">Roles :</label>
                    <select id="Role" name="Role">
                        <option value="Administrator">Administrator</option>
                        <option value="Coordinator">Coordinantor</option>
                    </select>
                    <br><br><br>
                    <div class="submit-button">
                        <input class="submit" type="submit" value="Save">
                    </div>
                </form>
            </div>
        </div>



        <div class="container">
            <div class="navbar">
                <a href="AdminProfile.jsp">User Profile</a>
                <a href="AdminDashboard.jsp">Dashboard</a>
                <a href="ManageStaff.jsp">Manage Staff</a>
                <a href="ViewFeedback2.jsp">View Feedback</a>
            </div>

            <div class="info">
                <button class="register-product-button" onclick="showPopup()">Register Staff</button>
                <h2>Manage Staff</h2>
                <!--Table-->
                <div class="table">
                    <table id="table">
                        <thead>
                            <tr>
                                <th>Staff IC</th>
                                <th>Staff Name</th>
                                <th>Email</th>
                                <th>Phone Number</th>
                                <th>Role</th>
                                <th>Delete</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                        } else {
                                            out.println("Admin not found.");
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

//                                String staffID = (String) session.getAttribute("staffID");
                                String StaffID = request.getParameter("staffID");
                                String query = "SELECT * FROM staff";

                                if (StaffID != null && !StaffID.isEmpty()) {
                                    query = "SELECT * FROM staff WHERE staff_ID = " + StaffID;
                                }

                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");
                                    Statement st = con.createStatement();
                                    ResultSet rs = st.executeQuery(query);

                                    while (rs.next()) {
                                        // Retrieve staff details from the result set
                                        String ID = rs.getString("staff_ID");
                                        String IC = rs.getString("staff_IC");
                                        String Name = rs.getString("staff_Name");
                                        String Email = rs.getString("staff_Email");
                                        String Phone = rs.getString("staff_Phone");
                                        String Role = rs.getString("roles");

                                        // Output staff details in table rows
                                        out.println("<tr>");
//                                        out.println("<td>" + ID + "</td>");
                                        out.println("<td>" + IC + "</td>");
                                        out.println("<td>" + Name + "</td>");
                                        out.println("<td>" + Email + "</td>");
                                        out.println("<td>" + Phone + "</td>");
                                        out.println("<td>" + Role + "</td>");
                                        out.println("</td>");
                                        out.println("<td>");

                                        // ni popup
//                                        out.println("<a onclick=\"showDeletePopup('" + ID + "')\"><img src=\"IMG/deleteicon.png\" alt=\"delete\"></a>");
                                        out.println("<a href=\"DeleteStaff.jsp?staff_ID=" + ID + "\"><img src=\"IMG/deleteicon.png\" alt=\"delete\"></a>");
                                        out.println("</td>");
                                        out.println("</tr>");
                                    }

                                    con.close();
                                } catch (Exception e) {
                                    out.println("Error: " + e);
                                }
                            %>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="popupdelete" id="popupdelete">
            <div class="popup-delete">
                <%
                    String staff_ID = (String) session.getAttribute("staffID");
                    // Retrieve the staff ID from the request parameter
//                    String staff_ID = request.getParameter("staff_ID");

                    // Check if the staff ID is present
                    if (staff_ID != null) {
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");
                            PreparedStatement pst = con.prepareStatement("SELECT * FROM staff WHERE staff_ID = ?");
                            pst.setString(1, staff_ID);
                            ResultSet rs = pst.executeQuery();

                            if (rs.next()) {
                                String ID = rs.getString("staff_ID");
                                String IC = rs.getString("staff_IC");
                                String Name = rs.getString("staff_Name");
                                String Email = rs.getString("staff_Email");
                                String Phone = rs.getString("staff_Phone");
                                String Role = rs.getString("roles");
                %>

                <h2>Delete Staff</h2>
                <p><b>Are you sure you want to delete the following staff?</b></p>
                <table>
                    <tr>
                        <td>ID :</td>
                        <td>
                            <%= ID%>
                        </td>
                    </tr>
                    <tr>
                        <td>IC :</td>
                        <td>
                            <%= IC%>
                        </td>
                    </tr>
                    <tr>
                        <td>Name :</td>
                        <td>
                            <%= Name%>
                        </td>
                    </tr>
                    <tr>
                        <td>Email :</td>
                        <td>
                            <%= Email%>
                        </td>
                    </tr>
                    <tr>
                        <td>Phone :</td>
                        <td>
                            <%= Phone%>
                        </td>
                    </tr>
                    <tr>
                        <td>Role :</td>
                        <td>
                            <%= Role%>
                        </td>
                    </tr>
                </table>

                <form class="deleteform" action="DeleteStaffServ?staffID=<%= ID%>" method="POST">
                    <input type="hidden" name="staffID" value="<%= ID%>">
                    <input type="submit" name="action" value="Delete">
                    <input type="submit" name="action" value="Cancel"> 
                </form>
                <%
                            } else {
                                out.println("Staff not found.");
                            }

                            rs.close();
                            pst.close();
                            con.close();
                        } catch (Exception e) {
                            out.println("Error: " + e);
                        }
                    } else {
                        response.sendRedirect("Login.jsp");
                    }
                %>
            </div>
        </div>

        <button onclick="topFunction()" id="myBtn" title="top"><i class="fa-solid fa-chevron-up"></i></button>

        <script>
            function toggleNavbar() {
                var navbar = document.querySelector('.navbar');
                navbar.classList.toggle('minimized');
            }

            function showPopup() {
                document.getElementById("popup").style.display = "block";
            }

            function showDeletePopup() {
                // Display the delete staff popup
                document.getElementById("popupdelete").style.display = "block";
            }

            function hidePopup() {
                document.getElementById("popup").style.display = "none";
            }

            function restrictToNumbers(inputElement) {
                inputElement.value = inputElement.value.replace(/[^0-9]/g, '');
            }

            function hideDeletePopup() {
                document.getElementById("popupdelete").style.display = "none";
            }
            function validateNumber(event) {
                // Get the key code of the pressed key
                var keyCode = event.which ? event.which : event.keyCode;

                // Allow only numbers (0-9) and special keys like backspace, delete, etc.
                if (keyCode >= 48 && keyCode <= 57 || keyCode === 8 || keyCode === 46 || keyCode === 37 || keyCode === 390) {
                    return true;
                } else {
                    return false;
                }
            }

            function signOut() {
                // Redirect to the logout servlet or your logout logic
                window.location.href = 'LogOutServ';
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
