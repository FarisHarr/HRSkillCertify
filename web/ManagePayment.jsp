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
                <a class="nav-link">Coordinator</a>
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
            <a href="ManageCertificate.jsp">Manage Certificate</a>
            <a href="ViewFeedback.jsp">View Feedback</a>
            <a href="ManageCandidate.jsp">Manage Candidate</a>
        </div>

        <div class="info">
            <h2>Manage Payment</h2>
            <div class="table">
                <table id="table">
                    <thead>
                        <tr>
                            <th>Payment ID</th>
                            <th>Candidate Name</th>
                            <th>Certificate Type</th>
                            <th>Price</th>
                            <th>Date</th>
                            <th>Receipt</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");
                                Statement st = con.createStatement();
                                ResultSet rs = st.executeQuery("SELECT p.payment_ID, c.cand_Name, p.cert_Type, p.price, p.date, p.receipt, p.status "
                                        + "FROM payment p "
                                        + "INNER JOIN candidate c ON p.cand_ID = c.cand_ID "
                                        + "ORDER BY CASE p.status WHEN 'Pending' THEN 1 WHEN 'Rejected' THEN 2 ELSE 3 END, p.date");

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
                                    } else {
                                        // Handle null receipt value, if needed
                                        // For example, you can set a default image or display a message
                                    }

                                    String status = rs.getString("status");

                                    out.println("<tr>");
                                    out.println("<td>" + paymentID + "</td>");
                                    out.println("<td>" + candidateName + "</td>");
                                    out.println("<td>" + certType + "</td>");
                                    out.println("<td>" + price + "</td>");
                                    out.println("<td>" + date + "</td>");
                        %>

                        <td style="width: 100px; text-align: center;">
                            <form action="LargeImage.jsp" method="post" target="_blank" style="margin: 0;">
                                <input type="hidden" name="image" value="<%= receiptBase64%>">
                                <button type="submit" style="height: 10%; border: none; background: none;">
                                    <img src="data:image/jpeg;base64,<%= receiptBase64%>" class="image-button" style="width: 75px; height: 75px;">
                                </button>
                            </form>
                        </td>

                        <td>
                            <form onsubmit="updateStatus(this, '<%= paymentID%>'); return false;">
                                <select name='newStatus'>
                                    <option class="pending" value='Pending' <%= (status.equals("Pending") ? "selected" : "")%>>Pending</option>
                                    <option class="approved" value='Approved' <%= (status.equals("Approved") ? "selected" : "")%>>Approved</option>
                                    <option class="rejected" value='Rejected' <%= (status.equals("Rejected") ? "selected" : "")%>>Rejected</option>
                                </select>

                                <input type="hidden" name="paymentID" value="<%= paymentID%>">
                                <input type="submit" value="Update" onclick="showSuccessMessage()">
                            </form>
                        </td>
                        <%
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

            function signOut() {
                // Redirect to the logout servlet or your logout logic
                window.location.href = 'LogOutServ'; // Replace 'LogoutServlet' with your actual logout servlet
            }

//            function showSuccessMessage() {
//                // Show a popup message
//                alert("Update Successful");
//            }
        </script>

        <footer>
            <p>&copy; HR SkillCertify 2023</p>
        </footer>
</body>

</html>

