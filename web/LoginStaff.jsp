<%-- 
    Document   : LoginStaff
    Created on : 28 Dec 2023, 9:18:30?am
    Author     : FarisHarr
--%>

<%@ page language="java" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="CSS/LoginStaff.css">
        <title>Login</title>
    </head>

    <style>
        body {
            background-color: #d9d9d9;
            background-image: url('IMG/BG.jpg');
            background-size: cover;
            background-position: center;
        }
    </style>

    <body>
        <h1>HR SkillCertify</h1>
        <div class="container">
            <form action="LoginStaffServ" class="form" method="POST">
                <h2>LOGIN</h2>
                <h5>Staff</h5>
                <div class="radio">
                    <input type="radio" id="administrator" name="user-type" value="administrator" required>
                    <label for="administrator">Administrator</label>
                    <input type="radio" id="coordinator" name="user-type" value="coordinator" required>
                    <label for="coordinator">Coordinator</label>
                </div>

                <input type="IC" name="IC" class="box" placeholder="Enter IC Number" oninput="restrictToNumbers(this);" maxlength="12" required>
                <input type="password" name="Password" id="passwordInput" class="box" placeholder="Enter Password" required>
                <i class="fas fa-eye password-toggle" onclick="togglePasswordVisibility()"></i>
                <input type="submit" value="LOG IN" id="submit">

                <%
                    String errorMessage = (String) request.getAttribute("errorMessage");
                    if (errorMessage != null) {
                %>
                <span style='color: red;'><%= errorMessage%></span>
                <%
                    }
                %>


                <%
//                    if (request.getMethod().equals("POST")) {
//                        String IC = request.getParameter("IC");
//                        String Password = request.getParameter("Password");
//                        String userType = request.getParameter("user-type");
//
//                        if (IC != null && Password != null && userType != null) {
//                            try {
//                                Class.forName("com.mysql.jdbc.Driver");
//                                String myURL = "jdbc:mysql://localhost/hrsc";
//                                Connection myConnection = DriverManager.getConnection(myURL, "root", "admin");
//
//                                String sSelectQry = "SELECT * FROM staff WHERE staff_IC = ? AND staff_Pass = ? AND roles = ?";
//                                PreparedStatement myPS = myConnection.prepareStatement(sSelectQry);
//                                myPS.setString(1, IC);
//                                myPS.setString(2, Password);
//                                myPS.setString(3, userType);
//                                ResultSet resultSet = myPS.executeQuery();
//
//                                if (resultSet.next()) {
//                                    // User found, set session and redirect to the appropriate page
//                                    HttpSession loginsession = request.getSession();
//                                    session.setAttribute("staffID", resultSet.getString("staff_ID"));
//
//                                    if (userType.equals("admin") || userType.equals("manager")) {
//                                        response.sendRedirect("StaffDashboard.jsp");
//                                    } else {
//                                        // Handle other user types if needed
//                                    }
//                                } else {
//                                    // User not found, display error message
//                                    out.println("<span style='color: red;'>Invalid IC or password. Please try again.</span>");
//                                }
//
//                                myConnection.close();
//                            } catch (ClassNotFoundException | SQLException e) {
//                                e.printStackTrace();
//                                out.println("<span style='color: red;'>An error occurred. Please try again later.");
//                            }
//                        }
//                    }

                %>
                <br>
                <p class="new"><a href="Login.jsp">Back</a></p>
                <br>
            </form>
        </div>
    </body>

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

    <footer>
        <p>&copy; HR SkillCertify 2023</p>
    </footer>

</html>

