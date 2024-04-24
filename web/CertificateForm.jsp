<%-- 
    Document   : CertificateForm
    Created on : 19 Apr 2024, 3:27:22 pm
    Author     : FarisHarr
--%>

<%@ page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <title>Certificate Registration</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="CSS/HomePage.css">
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    </head>

    <style>
        .infoCert {
            margin: 0 auto;
            text-align: center;
            padding: 20px;
            width: 90%;
            height: auto;
            background-color: #f0f0f0;
            border: 1px solid #000000;
            display: flex;
        }

        .cert {
            width: 50%;
            height: 90%;
            margin: 30px auto;
            padding: 20px;
            background-color: #f9f9f9;
            text-align: center;
            border-radius: 8px;
            justify-content: center;
            display: flex;
            flex-direction: column;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .cert button {
            width: 30%;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        .cert button:hover {
            background-color: #45a049;
        }

        .cert label {
            display: block;
            margin-top: 10px;
        }

        .cert select,
        .cert input[type="text"],
        .cert input[type="number"],
        .cert textarea {
            width: 50%;
            padding: 10px;
            margin: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        /* Style for displaying amount */
        .amount-display {
            margin: 20px;
            font-size: 18px;
        }

        .back-button {
            width: 5%;
            margin-top: 10px;
            background-color: #45a049;
            color: white;
            border: none;
            border-radius: 4px;
            padding: 5px 10px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
            display: inline-block;
        }

        .back-button:hover {
            background-color: #5f5f5f;
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
        %>
        <header>
            <div class="main">
                <a href="AboutCertificate.jsp">
                    <img class="logo" src="IMG/HRSCLogo.png" alt="logo">
                </a>

                <!-- <nav>
                    <ul class="nav_links">
                        <button class="navbar-toggle" onclick="toggleNavbar()"> ☰ </button>
                    </ul>
                </nav> -->
            </div>
            <nav>
                <li class="dropdown">
                    <a class="nav-link"><%= Name%></a>
                    <ul class="dropdown-content">
                        <!-- <li><a href="CustomerProfile.jsp">Edit Information</a></li> -->
                        <li><a href="CandidateProfile.jsp">User Profile</a></li>
                        <li><a href="MainPage.jsp" onclick="signOut()">Sign Out</a></li>
                    </ul>
                </li>
            </nav>
        </header>
        <!-- 
            <div class="container">
                <div class="navbar">
                    <a href="HomePage.html">Home</a>
                    <a href="CandidateProfile.html">User Profile</a>
                    <a href="AboutCertificate.html">About Certificate</a>
                    <a href="TimeTable.html">Time Table</a>
                    <a href="Feedback.html">Feedback</a>
                </div> -->

        <div class="cert">
            <h2>Certificate Registration</h2><br>
            <form action="RegisterCertServ" method="POST">
                <!-- Add hidden input field for candidateID -->
                <input type="hidden" id="candidateID" name="candidateID" value="<%= candidateID%>">
                <label for="certificate">Certificate:</label>
                <select id="certificate" name="certificate" required>
                    <option value="" disabled selected>Please Choose</option>
                    <option value="SKM (RM2250)">Sijil Kemahiran Malaysia (SKM)</option>
                    <option value="DKM (RM2700)">Diploma Kemahiran Malaysia (DKM)</option>
                    <option value="DLKM (RM3600)">Diploma Lanjutan Kemahiran Malaysia (DLKM)</option>
                </select>

                <label for="workType">Scope of Business:</label>
                <select id="workType" name="workType" required>
                    <option value="" disabled selected>Please Choose</option>
                    <option value="Agriculture, forestry, and fishing">Agriculture, forestry, and fishing</option>
                    <option value="Mining and quarrying">Mining and quarrying</option>
                    <option value="Manufacturing">Manufacturing</option>
                    <option value="Electricity, gas, steam and air conditioning supply">Electricity, gas, steam and air conditioning supply</option>
                    <option value="Water supply; sewerage, waste management and remediation activities">Water supply; sewerage, waste management and remediation activities</option>
                    <option value="Construction">Construction</option>
                    <option value="Wholesale and retail trade; repair of motor vehicles and motorcycles">Wholesale and retail trade; repair of motor vehicles and motorcycles</option>
                    <option value="Transportation and storage">Transportation and storage</option>
                    <option value="Accommodation and food service activities">Accommodation and food service activities</option>
                    <option value="Information and communication">Information and communication</option>
                    <option value="Financial and insurance activities">Financial and insurance activities</option>
                    <option value="Real estate activities">Real estate activities</option>
                    <option value="Professional, scientific and technical activities">Professional, scientific and technical activities</option>
                    <option value="Administrative and support service activities">Administrative and support service activities</option>
                    <option value="Public administration and defence; compulsory social security">Public administration and defence; compulsory social security</option>
                    <option value="Education">Education</option>
                    <option value="Human health and social work activities">Human health and social work activities</option>
                    <option value="Arts entertainment and recreation">Arts entertainment and recreation</option>
                    <option value="Other service activities">Other service activities</option>
                    <option value="Activities of households as employers">Activities of households as employers</option>
                    <option value="Activities of extraterritorial organizations and bodies">Activities of extraterritorial organizations and bodies</option>
                </select>

                <label for="work_experience">Work Experience:</label>
                <input type="text" id="experience" name="experience" placeholder="Example: 2 Years" oninput="restrictToNumbers(this);" required>
<!--                                <span id="placeholder-addon"> Years</span>-->

                <!-- Amount display -->
                <div class="amount-display">
                    Amount : RM <span id="amount"></span>
                </div>

                <button type="submit">Register</button>

            </form>

            <a href="javascript:history.back()" class="back-button">Back</a>
        </div>

        <script>
            // Function to calculate and display amount based on selected certificate
            document.getElementById('certificate').addEventListener('change', function () {
                var certificate = this.value;
                var amountField = document.getElementById('amount');
                var amount = 0;
                switch (certificate) {
                    case 'SKM (RM2250)':
                        amount = 2250;
                        break;
                    case 'DKM (RM2700)':
                        amount = 2700;
                        break;
                    case 'DLKM (RM3600)':
                        amount = 3600;
                        break;
                    default:
                        amount = 0;
                }
                amountField.textContent = amount;
            });

            // Get the input field and the placeholder-addon span
            var workExperienceInput = document.getElementById('work_experience');
            var placeholderAddon = document.getElementById('placeholder-addon');

            // Add an event listener to the input field to update the placeholder text
            workExperienceInput.addEventListener('input', function () {
                // Get the user input value
                var userInput = this.value;
                // Check if the user input is a valid number
                if (!isNaN(userInput) && userInput !== '') {
                    // If it's a valid number, update the placeholder text
                    placeholderAddon.textContent = ' Years';
                } else {
                    // If it's not a valid number or empty, reset the placeholder text
                    placeholderAddon.textContent = '';
                }
            });

            function signOut() {
                // Redirect to the logout servlet or your logout logic
                window.location.href = 'LogOutServ'; // Replace 'LogoutServlet' with your actual logout servlet
            }
        </script>

        <%
                    } else {
                        out.println("Candidate not found.");
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
