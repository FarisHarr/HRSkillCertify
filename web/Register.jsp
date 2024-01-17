<%@ page import="java.sql.*, com.model.Register" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>Register Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="CSS/Register.css">
    </head>
    <body>
        <div class="container">
            <form action="RegisterServ" class="form" method="post">
                <h2>SIGN UP</h2>
                <input type="text" name="IC" id="IC" class="box" placeholder="Enter Your IC Number" oninput="restrictToNumbers(this);" maxlength="12" required>
                <input type="text" name="Name" id="Name" class="box" placeholder="Enter Your Name" required>
                <input type="email" name="Email" id="Email" class="box" placeholder="Enter Your Email" required>
                <input type="text" name="Password" id="Password" class="box" placeholder="Enter Password" required>
                <!--                <input type="text" name="Phone" id="Phone" class="box" placeholder="Enter Phone Number" onkeypress="return validateNumber(event)" required>
                                <input type="text" name="Address" id="Address" class="box" placeholder="Enter Address" required>-->
                <div class="terms">
                    <input type="checkbox" id="checkbox" required>
                    <label for="checkbox">I agree to these <a href="https://acrobat.adobe.com/id/urn:aaid:sc:AP:90eee9d7-8512-4a6f-8d1f-f21ff5372a31" target="_blank">Terms & Conditions</a></label>
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
        </script>
    </body>
    <footer>
        <p>&copy; HR SkillCertify 2023</p>
    </footer>
</html>
