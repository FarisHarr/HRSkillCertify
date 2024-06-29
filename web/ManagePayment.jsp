<%-- 
    Document   : ManagePayment
    Created on : 19 Jan 2024, 10:25:33 pm
    Author     : FarisHarr
--%>

<%@page import="java.util.Base64"%>
<%@ page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Manage Payment</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="CSS/feedback.css">
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>
    <body>
        <%
            String staffID = (String) session.getAttribute("staffID");
            int currentPage = 1;
            int recordsPerPage = 5;
            if (request.getParameter("page") != null) {
                currentPage = Integer.parseInt(request.getParameter("page"));
            }

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
                        <button class="navbar-toggle" onclick="toggleNavbar()">☰</button>
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
            <div class="info">
                <h2>Manage Payment</h2>
                <div class="table">
                    <table id="table">
                        <thead>
                            <tr>
                                <th>Payment ID</th>
                                <th>Name</th>
                                <th>Certificate Type</th>
                                <th>Price</th>
                                <th>Date</th>
                                <th>Receipt</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
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
                                    response.sendRedirect("Login.jsp");
                                }

                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");
                                    int start = (currentPage - 1) * recordsPerPage;
                                    Statement st = con.createStatement();
                                    ResultSet rs = st.executeQuery("SELECT p.payment_ID, c.cand_Name, p.cert_Type, p.price, p.date, p.receipt, p.status "
                                            + "FROM payment p "
                                            + "INNER JOIN candidate c ON p.cand_ID = c.cand_ID "
                                            + "ORDER BY CASE p.status WHEN 'Pending' THEN 1 WHEN 'Rejected' THEN 2 ELSE 3 END, p.date DESC "
                                            + "LIMIT " + start + ", " + recordsPerPage);

                                    while (rs.next()) {
                                        String paymentID = rs.getString("payment_ID");
                                        String candidateName = rs.getString("cand_Name");
                                        String certType = rs.getString("cert_Type");
                                        String price = rs.getString("price");
                                        String date = rs.getString("date");
                                        byte[] receiptBytes = rs.getBytes("receipt");
                                        String receiptBase64 = "";

                                        if (receiptBytes != null) {
                                            receiptBase64 = Base64.getEncoder().encodeToString(receiptBytes);
                                        }

                                        String status = rs.getString("status");
                            %>
                            <tr>
                                <td><%= paymentID%></td>
                                <td><%= candidateName%></td>
                                <td><%= certType%></td>
                                <td><%= price%></td>
                                <td><%= date%></td>
                                <td style="width: 100px; text-align: center;">
                                    <form action="LargeImage.jsp" method="post" target="_blank" style="margin: 0;">
                                        <input type="hidden" name="image" value="<%= receiptBase64%>">
                                        <button type="submit" style="height: 10%; border: none; background: none; cursor: pointer">
                                            <img src="data:image/jpeg;base64,<%= receiptBase64%>" class="image-button" style="width: 75px; height: 75px;">
                                        </button>
                                    </form>
                                </td>
                                <td>
                                    <form class="status" onsubmit="updateStatus(this, '<%= paymentID%>'); return false;">
                                        <select name='newStatus'>
                                            <option class="pending" value='Pending' <%= (status.equals("Pending") ? "selected" : "")%>>Pending</option>
                                            <option class="approved" value='Approved' <%= (status.equals("Approved") ? "selected" : "")%>>Approved</option>
                                            <option class="rejected" value='Rejected' <%= (status.equals("Rejected") ? "selected" : "")%>>Rejected</option>
                                        </select>
                                        <input type="hidden" name="paymentID" value="<%= paymentID%>">
                                        <input type="submit" value="Update" onclick="showSuccessMessage()">
                                    </form>
                                </td>
                            </tr>
                            <%
                                    }

                                    rs.close();
                                    st.close();
                                    con.close();
                                } catch (Exception e) {
                                    out.println("Error: " + e);
                                }
                            %>
                        </tbody>
                    </table>
                </div>

                <%
                    int numberOfRecords = 0;
                    int numberOfPages = 0;

                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");
                        Statement st = con.createStatement();
                        ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM payment");
                        if (rs.next()) {
                            numberOfRecords = rs.getInt(1);
                        }
                        numberOfPages = (int) Math.ceil(numberOfRecords * 1.0 / recordsPerPage);
                        rs.close();
                        st.close();
                        con.close();
                    } catch (Exception e) {
                        out.println("Error: " + e);
                    }
                %>

                <div class="pagination">
                    <%
                        if (currentPage > 1) {
                    %>
                    <a href="ManagePayment.jsp?page=<%= (currentPage - 1)%>" style="color: #455d5f">&laquo; Previous</a>
                    <%
                        }

                        for (int i = 1; i <= numberOfPages; i++) {
                            if (i == currentPage) {

                            } else {
                            }
                        }

                        if (currentPage < numberOfPages) {
                    %>
                    <a href="ManagePayment.jsp?page=<%= (currentPage + 1)%>" style="color: #455d5f">Next &raquo;</a>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
        <button onclick="topFunction()" id="myBtn" title="top"><i class="fa-solid fa-chevron-up"></i></button>

        <script>
            function updateStatus(form, paymentID) {
                form.action = "UpdatePaymentServ";
                form.method = "POST";
                form.submit();
            }

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
                var keyCode = event.which ? event.which : event.keyCode;
                if (keyCode >= 48 && keyCode <= 57 || keyCode === 8 || keyCode === 46 || keyCode === 37 || keyCode === 390) {
                    return true;
                } else {
                    return false;
                }
            }

            function refresh() {
                location.reload();
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


