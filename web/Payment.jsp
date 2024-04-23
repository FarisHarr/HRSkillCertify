<%-- 
    Document   : Payment
    Created on : 19 Apr 2024, 11:19:13 pm
    Author     : FarisHarr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <title>Payment Page</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="CSS/HomePage.css">
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/icon?family=Material+Icons">
</head>

<style>


.container {
    width: 50%;
    margin: 50px auto;
    padding: 20px;
    background-color: #f9f9f9;
    border-radius: 8px;
    justify-content: center;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

h1 {
    text-align: center;
}

.form-group {
    margin-bottom: 20px;
}

label {
    display: block;
    margin-bottom: 8px;
}

input[type="text"], input[type="file"] {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

button {
    width: 100%;
    padding: 10px 20px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
}

button:hover {
    background-color: #45a049;
}

</style>

<body>
    <header>
        <div class="main">
            <a href="CertificateForm.jsp">
                <img class="logo" src="IMG/HRSCLogo.png" alt="logo">
            </a>
        </div>
        <nav>
            <ul>
                <li class="dropdown">
                    <a href="#" class="nav-link">Candidate</a>
                    <ul class="dropdown-content">
                        <li><a href="CandidateProfile.jsp">User Profile</a></li>
                        <li><a href="MainPage.jsp" onclick="signOut()">Sign Out</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
    </header>

    <div class="container">
        <!-- <h1>Payment Details</h1> -->
        <form action="/process_payment" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="card_number">Card Number:</label>
                <input type="text" id="card_number" name="card_number" required>
            </div>

            <div class="form-group">
                <label for="expiry_date">Expiry Date:</label>
                <input type="text" id="expiry_date" name="expiry_date" placeholder="MM/YY" required>
            </div>

            <div class="form-group">
                <label for="card_holder_name">Card Holder Name:</label>
                <input type="text" id="card_holder_name" name="card_holder_name" required>
            </div>

            <div class="form-group">
                <label for="amount">Amount:</label>
                <input type="text" id="amount" name="amount" required>
            </div>

            <div class="form-group">
                <label for="file">Upload File:</label>
                <input type="file" id="file" name="file" accept=".pdf,.doc,.docx" required>
            </div>

            <a href="AboutCertificate.jsp">
                <button type="button">Pay Now</button>
            </a>
        </form>
    </div>

    <script>
                function signOut() {
            // Redirect to the logout servlet or your logout logic
            window.location.href = 'LogOutServ'; // Replace 'LogoutServlet' with your actual logout servlet
        }
        </script>
    <footer>
        <p>&copy; HR SkillCertify 2023</p>
    </footer>

</body>

</html>

