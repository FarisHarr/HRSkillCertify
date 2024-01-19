<%-- 
    Document   : ManageCandidate
    Created on : 3 Jan 2024, 10:34:44 pm
    Author     : FarisHarr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>

    <head>
        <title>Manage Candidate</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="CSS/ManageCandidate.css">
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/icon?family=Material+Icons">
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
                        <li><a href="MainPage.jsp">Sign Out</a></li>
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

            <div class="info">
                <button onclick="refresh()">Refresh</button>
                <h2>Manage Candidate</h2>

                <!--<button class="register-product-button" onclick="showPopup()">Register Staff</button>-->
                <!--Table-->
                <div class="table">
                    <table id="table">
                        <thead>
                            <tr>
                                <th>Candidate IC</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Phone Number</th>
                                <th>Address</th>
                                <th>Status</th>
                                <th>Delete</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                String searchSCandidateID = request.getParameter("candidateID");
                                String query = "SELECT * FROM candidate";

                                if (searchSCandidateID != null && !searchSCandidateID.isEmpty()) {
                                    query = "SELECT * FROM candidate WHERE cand_ID = " + searchSCandidateID;
                                }

                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");
                                    Statement st = con.createStatement();
                                    ResultSet rs = st.executeQuery(query);

                                    while (rs.next()) {
                                        // Retrieve staff details from the result set
                                        String ID = rs.getString("cand_ID");
                                        String IC = rs.getString("cand_IC");
                                        String Name = rs.getString("cand_Name");
                                        String Email = rs.getString("cand_Email");
                                        String Phone = rs.getString("cand_Phone");
                                        String Address = rs.getString("cand_Add");

                                        // Output staff details in table rows
                                        out.println("<tr>");
                                        out.println("<td>" + IC + "</td>");
                                        out.println("<td>" + Name + "</td>");
                                        out.println("<td>" + Email + "</td>");
                                        out.println("<td>" + Phone + "</td>");
                                        out.println("<td>" + Address + "</td>");
                                        out.println("<td>");
                                        out.println("<a href=\"#?cand_ID=" + ID + "\">"
                                                + "<img src=\"IMG/editicon.png\" alt=\"edit\"></a>");
                                        out.println("</td>");
                                        out.println("<td>");
                                        out.println("<a href=\"DeleteCandidate.jsp?cand_ID=" + ID + "\"><img src=\"IMG/deleteicon.png\" alt=\"delete\"></a>");
//                                        out.println("<a onclick=\"showDeletePopup('" + ID + "')\"><img src=\"IMG/deleteicon.png\" alt=\"delete\"></a>");
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
                    String cand_ID = request.getParameter("cand_ID");

                    // Check if the staff ID is present
                    if (staff_ID != null) {
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");
                            PreparedStatement pst = con.prepareStatement("SELECT * FROM candidate WHERE cand_ID = ?");
                            pst.setString(1, cand_ID);
                            ResultSet rs = pst.executeQuery();

                            if (rs.next()) {
                                String ID = rs.getString("cand_ID");
                                String IC = rs.getString("cand_IC");
                                String Name = rs.getString("cand_Name");
                                String Email = rs.getString("cand_Email");
                                String Phone = rs.getString("cand_Phone");
                %>

                <h2>Delete Candidate</h2>
                <p><b>Are you sure you want to delete the following candidate?</b></p>
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

                </table>

                <form class="deleteform" action="DeleteCandidateServ?candidateID=<%= ID%>" method="POST">
                    <input type="hidden" name="candidateID" value="<%= ID%>">
                    <input type="submit" name="action" value="Delete">
                    <input type="submit" name="action" value="Cancel"> 
                </form>
                <%
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
                        response.sendRedirect("Login.jsp");
                    }
                %>
            </div>
        </div>

        <script>
            function toggleNavbar() {
                var navbar = document.querySelector('.navbar');
                navbar.classList.toggle('minimized');
            }

            function showPopup() {
                document.getElementById("popup").style.display = "block";
            }

            function showDeletePopup() {
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
            // Refresh sales report by reloading the page
            function refresh() {
                location.reload();
            }

        </script>

        <footer>
            <p>&copy; HR SkillCertify 2023</p>
        </footer>
    </body>

</html>
