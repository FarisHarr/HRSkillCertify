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

        .receipt {
            margin: 20px;
            /*            text-decoration: underline;*/
            /*cursor: pointer;*/
            position: relative; /* Set position relative for absolute positioning */
        }

        .receipt:hover::after {
            content: "Image Only";
            position: absolute;
            background-color:  #cccccc;
            color: #ff3333;
            padding: 5px;
            border-radius: 4px;
            top: calc(100% + 5px); /* Position below the element */
            left: 50%; /* Center horizontally */
            transform: translateX(-50%); /* Center horizontally */
            z-index: 999;
        }

        input[type="file"] {
            cursor: pointer;
            border: 1px solid #ccc; /* Add a 1px solid border with color #ccc */
        }



        .amount-display {
            margin: 20px;
            font-size: 18px;
            text-decoration: underline;
            cursor: pointer;
            position: relative; /* Set position relative for absolute positioning */
            font-family: "Courier New", Courier, monospace; /* Use a monospaced font */
            font-weight: bold;
        }


        .amount-display:hover::after {
            content: "QR is here";
            position: absolute;
            background-color: rgba(0, 0, 0, 0.5);
            color: white;
            padding: 5px;
            border-radius: 4px;
            top: calc(100% + 5px); /* Position below the element */
            left: 50%; /* Center horizontally */
            transform: translateX(-50%); /* Center horizontally */
            z-index: 999;
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

        <div class="cert">
            <h2>Certificate Registration</h2><br> 
            <form action="RegisterCertServ" method="POST" enctype="multipart/form-data">

                <!--<form action="RegisterCertServ" method="POST" >--> 

                <!-- Add hidden input field for candidateID -->
                <input type="hidden" id="candidateID" name="candidateID" value="<%= candidateID%>">
                <label for="certType">Certificate:</label>
                <select id="certType" name="certType" required>
                    <option value="" disabled selected>Please Choose</option>
                    <option value="SKM">Sijil Kemahiran Malaysia (SKM)</option>
                    <option value="DKM">Diploma Kemahiran Malaysia (DKM)</option>
                    <option value="DLKM">Diploma Lanjutan Kemahiran Malaysia (DLKM)</option>
                </select>

                <label for="workType">Scope of Business :</label>
                <select id="workType" name="workType" required>
                    <option value="" disabled selected>Please Choose</option>
                    <option value="Agriculture, forestry, and fishing">Agriculture, forestry, and fishing</option>
                    <option value="Mining and quarrying">Mining and quarrying</option>
                    <option value="Manufacturing">Manufacturing</option>
                    <option value="Electricity, gas, steam and air conditioning supply">Electricity, gas, steam and air conditioning supply</option>
                    <option value="Water supply; sewerage, waste management and remediation activities">Water supply, waste management and remediation</option>
                    <option value="Construction">Construction</option>
                    <option value="Wholesale and retail trade; repair of motor vehicles and motorcycles">Repair of motor vehicles and motorcycles</option>
                    <option value="Transportation and storage">Transportation and storage</option>
                    <option value="Accommodation and food service activities">Accommodation and food service activities</option>
                    <option value="Information and communication">Information and communication</option>
                    <option value="Financial and insurance activities">Financial and insurance activities</option>
                    <option value="Real estate activities">Real estate activities</option>
                    <option value="Professional, scientific and technical activities">Professional, scientific and technical activities</option>
                    <option value="Administrative and support service activities">Administrative and support service activities</option>
                    <option value="Public administration and defence; compulsory social security">Public administration and defence</option>
                    <option value="Education">Education</option>
                    <option value="Human health and social work activities">Human health and social work activities</option>
                    <option value="Arts entertainment and recreation">Arts entertainment and recreation</option>
                    <option value="Activities of households as employers">Activities of households as employers</option>
                    <option value="Activities of extraterritorial organizations and bodies">Activities of extraterritorial organizations and bodies</option>
                    <option value="Other service activities">Other service activities</option>
                </select>


                <label for="work_experience">Work Experience: (Years)</label>
                <input type="text" id="experience" name="experience" placeholder="Example: 2 Years" required>

                <!--<span id="placeholder-addon"> Years</span>-->

                <!-- Amount display -->
                <div class="amount-display" onclick="openQRPopup()">
                    Amount : RM <span id="amount">0</span>
                </div>

                <div class="form-group">
                    <label for="price">Price you want to pay :</label>
                    <input type="text" id="price" name="price" value="RM" required>
                </div>

                <div class="form-group">
                    <!-- <label for="payment_date">Payment Date:</label> -->
                    <input type="hidden" id="date" name="date" value="<%= java.time.LocalDate.now()%>">
                </div>

                <input type="hidden" id="status" name="status" value="Pending">

                <!-- File upload input field for receipt -->
                <div class="receipt">
                    <label for="receipt">Upload Receipt :</label><br>
                    <input type="file" id="receipt" name="receipt" accept="image/*" required>
                </div>
                <br>

                <button type="submit" >Pay Now</button>

            </form>

            <a href="javascript:history.back()" class="back-button">Back</a>
        </div>

        <script>
            // Function to open the QR.jsp page in a new small popup window
            function openQRPopup() {
                // Define the URL of the QR.jsp page
                var qrURL = 'QR.jsp';
                // Define the size and position of the popup window
                var windowFeatures = 'width=500,height=500,top=250,left=100';
                // Open a new small popup window with the QR.jsp page
                window.open(qrURL, '_blank', windowFeatures);
            }

            // Get the input element
            var experienceInput = document.getElementById('experience');

// Add event listener for when the input field loses focus
            experienceInput.addEventListener('blur', function () {
                // If the input field is not empty and does not already end with "Years"
                if (experienceInput.value.trim() !== '' && !experienceInput.value.trim().endsWith('Years')) {
                    // Append " Years" to the input field value
                    experienceInput.value += ' Years';
                }
            });




            // Function to calculate and display amount based on selected certificate
            document.getElementById('certType').addEventListener('change', function () {
                var certificate = this.value;
                var amountField = document.getElementById('amount');
                var amount = 0;
                switch (certificate) {
                    case 'SKM':
                        amount = 2250;
                        break;
                    case 'DKM':
                        amount = 2700;
                        break;
                    case 'DLKM':
                        amount = 3600;
                        break;
                    default:
                        amount = 0;
                }
                amountField.textContent = amount; // Update the amount displayed
            });

            // Get the input field and the placeholder-addon span
            var workExperienceInput = document.getElementById('experience');
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

            function restrictToNumbers(inputElement) {
                inputElement.value = inputElement.value.replace(/[^0-9]/g, '');
            }

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
