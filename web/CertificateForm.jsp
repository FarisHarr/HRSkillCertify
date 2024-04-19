<%-- 
    Document   : CertificateForm
    Created on : 19 Apr 2024, 3:27:22 pm
    Author     : FarisHarr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <title>About Certificate</title>
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
            background-color: #f9f9f9;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin: 50px auto; /* Auto margin horizontally to center the div */
            width: 60%;
            height: 90%;
            border-radius: 8px;
            text-align: center;
            display: flex;
            flex-direction: column;
            justify-content: center; /* Center content vertically */
            align-items: center; /* Center content horizontally */
        }

        .cert button {
            width: 100%;
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
            display: block; /* Each label on its own line */
            margin-top: 10px; /* Add spacing between labels and inputs */
        }

        .cert select,
        .cert input[type="text"],
        .cert input[type="email"],
        .cert textarea {
            width: 45%;
            padding: 10px;
            margin : 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }


    </style>

    <body>
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
                    <a class="nav-link">Candidate</a>
                    <ul class="dropdown-content">
                        <!-- <li><a href="CustomerProfile.jsp">Edit Information</a></li> -->
                        <li><a href="CandidateProfile.jsp">User Profile</a></li>
                        <li><a href="MainPage.jsp">Sign Out</a></li>
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
            <h2>Test Certificate</h2><br>
            <!-- Form -->
            <!-- <form action="CertificateForm.html" method="post"> -->
            <label for="scope">Scope of Business:</label>
            <select id="scope" name="scope">
                <option value=""disabled selected>Please Choose</option>
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

            <label for="name">Name:</label>
            <input type="text" id="name" name="name">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email">
            <label for="feedback">Feedback:</label>
            <textarea id="feedback" name="feedback" ></textarea><br>
            <a href="Payment.jsp">
                <button>Register</button>
            </a> 
        </form>
    </div>
</div>


<script>
    function toggleNavbar() {
        var navbar = document.querySelector('.navbar');
        navbar.classList.toggle('minimized');
    }
</script>

<footer>
    <p>&copy; HR SkillCertify 2023</p>
</footer>

</body>

</html>
