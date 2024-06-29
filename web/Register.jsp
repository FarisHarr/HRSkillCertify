<%@ page import="java.sql.*, com.model.Register" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>Register Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="CSS/Register.css">
    </head>

    <style>
        .box {
            margin-bottom: 10px;
        }
        .password-toggle {
            cursor: pointer;
        }
        .error {
            width: 70%;
            color: red;
        }

    </style>

    <body>
        <div class="container">
            <form action="RegisterServ" class="form" method="post" id="passwordForm">
                <h2>SIGN UP</h2>
                <input type="text" name="IC" id="IC" class="box" placeholder="Enter Your IC Number" oninput="restrictToNumbers(this);" maxlength="12" required>
                <input type="text" name="Name" id="Name" class="box" placeholder="Enter Your Full Name" required>
                <input type="email" name="Email" id="Email" class="box" placeholder="Enter Your Email" required>
                <input type="password" name="Password" id="passwordInput" class="box" placeholder="Enter Password" oninput="validatePassword(this)" required>
                <i class="fas fa-eye password-toggle" onclick="togglePasswordVisibility()"></i>
                <div id="passwordError" class="error"></div>
                <div class="terms">
                    <input type="checkbox" id="checkbox" required>
                    <label for="checkbox">I agree to these <a href="IMG/Akta pembangunan kemahiran kebangsaan Akta652.pdf" target="_blank">Terms & Conditions</a></label>
                </div>
                <br>
                <%
                    String errorMessage = (String) request.getAttribute("errorMessage");
                    if (errorMessage != null) {
                %>
                <span style='color: red;'><%= errorMessage%></span>
                <%
                    }
                %>
                <input type="submit" id="submit" value="REGISTER"> 
                <p class="new"><a href="Login.jsp">Back</a></p>
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

            function togglePasswordVisibility() {
                var passwordInput = document.getElementById("passwordInput");
                if (passwordInput.type === "password") {
                    passwordInput.type = "text";
                } else {
                    passwordInput.type = "password";
                }
            }

            function validatePassword(input) {
                var password = input.value;
                var regex = /^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&()])[A-Za-z\d!@#$%^&*()]{8,}$/;
                var passwordError = document.getElementById("passwordError");

                if (!regex.test(password)) {
                    passwordError.textContent = "Password must be at least 8 characters long, contain an uppercase letter, a numeric character, and a special character.";
                    input.setCustomValidity("Invalid password");
                } else {
                    passwordError.textContent = "";
                    input.setCustomValidity("");
                }
            }

            document.getElementById("passwordForm").addEventListener("submit", function (event) {
                var passwordInput = document.getElementById("passwordInput");
                if (!passwordInput.checkValidity()) {
                    event.preventDefault();
                    validatePassword(passwordInput);
                }
            });

            // Check if the 'redirect' attribute is set
            if ('${requestScope.redirect}' === 'true') {
                // Show loading message
                var loadingElement = document.getElementById('loading');
                loadingElement.style.display = 'block';

                // Redirect after a delay
                setTimeout(function () {
                    // Display alert message and redirect to Login.jsp
                    alert('Register successfully!');
                    window.location.href = 'Login.jsp';
                }, 2000); // Adjust the delay time as needed
            }

        </script>
    </body>
    <footer>
        <p>&copy; 2024 <strong>HR SkillCertify</strong>. All rights reserved </p>
    </footer>
</html>
