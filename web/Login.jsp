<%-- 
    Document   : Login
    Created on : 25 Dec 2023, 8:30:14?pm
    Author     : FarisHarr
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>

<%@ page language="java" %>
<%@ page import="java.sql.*" %> 


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
        <link rel="stylesheet" href="CSS/Login.css" />
        <!--<link rel="stylesheet" href="CSS/bootstrap.min.css" />-->
        <title>Login</title>
    </head>

    <body>
        <h1>Enhance Your Certificate Now !!</h1>
        <div class="container">
            <!--<form action="LoginController.jsp" class="form" method="POST">-->
            <form action="LoginServ" class="form" method="POST">
                <a href="MainPage.jsp">
                    <img class="logo" src="IMG/HRSCLogo.png" alt="logo">
                </a>
                <h2>LOGIN </h2>
                <input type="text" name="IC" id="IC" class="box" placeholder="Enter IC Number" oninput="restrictToNumbers(this);" maxlength="12" required>
                <input type="password" name="Password" id="passwordInput" class="box" placeholder="Enter Password" required>
                <i class="fas fa-eye password-toggle" onclick="togglePasswordVisibility()"></i>
                <a href="forgotPassword.jsp" class="pass">Forgot Password?</a>
                <input type="submit" value="LOG IN" id="submit"> 
                <!--<a href="#" id="submit">LOGIN</a>-->

                <%
                    String errorMessage = (String) request.getAttribute("errorMessage");
                    if (errorMessage != null) {
                %>
                <span style='color: red;'><%= errorMessage%></span>
                <%
                    }
                %>

                <br>
                <p class="new">New to HR SkillCertify? Register <a href="Register.jsp">HERE</a></p>
                <br>
                <p class="new"><a href="LoginStaff.jsp">Staff</a></p>
                <br>
            </form>
            <div id="loading" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%);
                 background: rgba(255, 255, 255, 0.8); padding: 15px; border-radius: 5px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); text-align: center;">
                <div style="margin-top: 10px;">
                    <img src="IMG/loading.gif" alt="Loading Spinner" style="width: 50px; height: 50px;">
                </div>
            </div>
        </div>


        <script>

            function restrictToNumbers(inputElement) {
                inputElement.value = inputElement.value.replace(/[^0-9]/g, '');
            }

            function togglePasswordVisibility() {
                var passwordInput = document.getElementById("passwordInput");
                if (passwordInput.type === "password") {
                    passwordInput.type = "text";
                } else {
                    passwordInput.type = "password";
                }
            }

            if ('${sessionScope.redirect}' === 'true') {
                // Show loading message
                var loadingElement = document.getElementById('loading');
                loadingElement.style.display = 'block';

                // Redirect after a delay
                setTimeout(function () {
                    window.location.href = 'HomePage.jsp';
                }, 500); // Adjust the delay time as needed
            }
        </script>
    </body>

    <footer>
        <p>&copy; 2024 <strong>HR SkillCertify</strong>. All rights reserved </p>
    </footer>
</html>