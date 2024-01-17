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
                <a href="HTML/ForgotPassword.html" class="pass">Forgot Password?</a>
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
                <p class="new">New to HR SkillCertify? <a href="Register.jsp">Register Here</a></p>
                <br>
                <p class="new"><a href="LoginStaff.jsp">Staff</a></p>
                <br>
            </form>
        </div>

          <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
<!--        <script src="JS/jquery-3.3.1.slim.min.js"></script>
        <script src="JS/popper.min.js"></script>
        <script src="JS/bootstrap.min.js"></script>
        <script src="JS/jquery-3.3.1.min.js"></script>      -->
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
        </script>
    </body>

    <footer>
        <p>&copy; HR SkillCertify 2023</p>
    </footer>
</html>