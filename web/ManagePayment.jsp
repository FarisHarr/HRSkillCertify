<%-- 
    Document   : ManagePayment
    Created on : 19 Jan 2024, 10:25:33 pm
    Author     : FarisHarr
--%>

<%@ page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <title>Manage Payment</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!--<link rel="stylesheet" type="text/css" href="CSS/ManageCandidate.css">-->
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/icon?family=Material+Icons">

    </head>

    <style>

        body {
            background-color: aliceblue;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-sizing: border-box;
            padding: auto;
            height: 65px;
            background-color: rgb(190, 190, 190);
        }

        .main {
            display: flex;
            align-items: center;
            margin-left: 20px;
        }

        nav.pic {
            text-align: right;
        }

        * {
            margin: 0;
        }

        ul.nav_links {
            padding: 0px;
        }

        li,
        a,
        button {
            font-weight: 300;
            font-size: 16px;
            color: #edf0f1;
            text-decoration: none;
        }

        .logo {
            height: 70px;
            width: 70px;
        }

        .dropdown {
            cursor: pointer;
            position: sticky;
            list-style: none;
            right: auto;
            color: #001b40;
        }

        .nav-link {
            display: inline-block;
            padding: 10px;
            margin-right: 30px;
            text-decoration: none;
            color: #001b40;
        }

        .nav-link:hover {
            color: #ffffff;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            list-style: none;
            background-color: #455d5f;
            padding: 10px;
            border-radius: 5px;
            box-shadow: 0 2px 5px #455d5f;
            width: 70%; /* Set the width as needed */
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }

        .dropdown-content li {
            margin-bottom: 5px;
        }


        .dropdown-content a {
            display: block;
            padding: 5px 0;
            text-decoration: none;
            color: #ffffff;
        }

        .dropdown-content a:hover {
            border-radius: 10px;
            color: black;
            background-color: #455d5f;
        }

        .register-product-button {
            width: 150px;
            height: 35px;
            padding: 5px;
            border-radius: 5px;
            border: none;
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
            margin-left: auto;
            display: block;
        }





        /*fading animation*/
        .fade {
            -webkit-animation-name: fade;
            -webkit-animation-duration: 1.5s;
            animation-name: fade;
            animation-duration: 1.5s;
        }

        @-webkit-keyframes fade {
            from {
                opacity: .4
            }

            to {
                opacity: 1
            }
        }

        @keyframes fade {
            from {
                opacity: .4
            }

            to {
                opacity: 1
            }
        }

        /*on smaller screens, decrease text size*/
        @media only screen and (max-width: 300px) {
            .text {
                font-size: 11px
            }
        }

        .container {
            width: 100%;
            margin: 0 auto;
            display: flex; /* Use flexbox to position children side by side */
        }

        .navbar {
            background-color: #455d5f;
            overflow: hidden;
            width: 190px;
            /* Set a fixed width for the vertical bar */
            height: auto;
            transition: width 0.1s, opacity 0.1s;
            /* Add transition for smooth animation */
        }

        .navbar.minimized {
            width: 0;
            opacity: 0;
        }

        .navbar a {
            display: block;
            text-align: center;
            background-color: #455d5f;
            color: #ffffff;
            padding: 20px 16px;
            text-decoration: none;
            transition: padding 0.9s;
            /* Add transition for smooth animation */
        }

        .navbar.minimized a {
            padding: 0;
            /* Adjust padding for the minimized state */
        }

        .navbar a:hover {
            border: 1px solid #000000;
            background-color: #001b40;
            color: rgb(255, 255, 255);
        }

        .navbar-toggle {
            width: 40px;
            height: 40px;
            border: none;
            border-radius: 30px;
            background-color: rgb(190, 190, 190);
            color: #000000;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s, color 0.3s;
        }

        .navbar-toggle:hover {
            background-color: #455d5f;
            color: #ffffff;
        }

        .info {
            margin: auto;
            text-align: center;
            padding: 20px;
            width: 100%;
            height: auto;
            background-color: #f0f0f0;
        }

        .info h2{
            text-align: center;
            margin-bottom: 10px;
        }

        .info button{
            display: block;
            float : right;
            width: 120px;
            height: 35px;
            padding: 5px;
            border-radius: 5px;
            border: none;
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
        }

        button:hover {
            background-color: #45a049; /* Darker green on hover */
        }


        input[type="text" ] {
            padding: 1px 2px;
            border-radius: 5px;
        }

        input[type="email" ] {
            padding: 1px 2px;
            border-radius: 5px;
        }

        input.submit {
            display: flex;
            justify-content: center;
            width: 80px;
            height: 25px;
            padding: 5px;
            margin-left: 40%;
            border-radius: 5px;
            border: 1px solid #24252a;
            background-color: #4CAF50;
            cursor: pointer;
        }

        .submit-button{
            display: flex;
            float: left;
            justify-content: center;
        }

        input.submit :hover {
            background-color: #f72b2b;
        }

        select {
            border-radius: 5px;
        }

        .close {
            color: #aaaaaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: #000;
            text-decoration: none;
            cursor: pointer;
        }

        div.table {
            background-color: white;
            /*    margin-bottom: 10%;*/
        }

        .table {
            display: grid;
            place-items: center;
            margin: 20px;
        }

        table {
            border-collapse: collapse;
            width: 100%;

        }


        th {
            text-align: left;
            color: white;
            background-color: grey;
        }

        td,
        th {
            border: 1px solid #ddd;
            padding: 8px;
        }

        input[type=number] {
            width: 70px;
        }

        #table th,
        #table td {
            padding: 5px;
            border: 1px solid black;
            text-align: center;
        }

        #table button {
            border: none;
            background-color: transparent;
            padding: 0;
        }

        select {
            width: 50%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            background-color: transparent;
        }

        select:hover {
            background-color: #888888;
        }

        select option.pending {
            background-color: #ffd700;
            color: #333;
            border-bottom: 2px solid #ffcc00; /* Yellow border for pending option */
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Add shadow for depth */
        }

        select option.approved {
            background-color: #32cd32;
            color: #333;
            border-bottom: 2px solid #009900; /* Green border for approved option */
            box-shadow: 0 2px 4px rgba(0, 128, 0, 0.1); /* Add shadow for depth */
        }

        select option.rejected {
            background-color: #ff6347;
            color: #fff;
            border-bottom: 2px solid #cc0000; /* Red border for rejected option */
            box-shadow: 0 2px 4px rgba(255, 0, 0, 0.1); /* Add shadow for depth */
        }

        select option:hover {
            background-color: #ccc;
            color: #000; /* Change text color on hover */
        }




        /* Style for the submit button */
        input[type="submit"] {
            margin-left: 10px;
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        /* Style for the submit button on hover */
        input[type="submit"]:hover {
            background-color: #45a049;
        }


        footer {
            background-color: rgb(190, 190, 190); /* Set background color */
            color: black; /* Set text color */
            text-align: center; /* Center-align text */
            padding: 10px; /* Add padding */
            position: fixed; /* Fixed positioning at the bottom */
            left: 0;
            bottom: 0;
            width: 100%; /* Full width */
        }
    <!--</style>

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
                    <!-- <a class="nav-link">Account</a> -->
                    <a class="nav-link">Manager</a>
                    <ul class="dropdown-content">
                        <!-- <li><a href="CustomerProfile.jsp">Edit Information</a></li> -->
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
                <button onclick="refresh()">Refresh</button>
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
                                            + "INNER JOIN candidate c ON p.cand_ID = c.cand_ID");

                                    while (rs.next()) {
                                        String paymentID = rs.getString("payment_ID");
                                        String candidateName = rs.getString("cand_Name");
                                        String certType = rs.getString("cert_Type");
                                        String price = rs.getString("price");
                                        String date = rs.getString("date");
                                        String receipt = rs.getString("receipt");
                                        String status = rs.getString("status");

                                        out.println("<tr>");
                                        out.println("<td>" + paymentID + "</td>");
                                        out.println("<td>" + candidateName + "</td>");
                                        out.println("<td>" + certType + "</td>");
                                        out.println("<td>" + price + "</td>");
                                        out.println("<td>" + date + "</td>");
                                        out.println("<td>" + receipt + "</td>");

                            %>

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

                function showSuccessMessage() {
                    // Show a popup message
                    alert("Update Success");
                }

            </script>

            <footer>
                <p>&copy; HR SkillCertify 2023</p>
            </footer>
    </body>

</html>

