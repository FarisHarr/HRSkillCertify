<%-- 
    Document   : EditCandidate
    Created on : 27 Dec 2023, 4:15:24 pm
    Author     : FarisHarr
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="CSS/EditCandidate.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <title>Candidate Profile</title>
    </head>

    <body>

        <header>
            <div class="main">
                <img class="logo" src="IMG/HRSCLogo.png" alt="logo">
                <nav>
                    <ul class="nav_links">
                        <button class="navbar-toggle" onclick="toggleNavbar()"> ☰ </button>
                    </ul>
                </nav>
            </div>
        </header>

        <div class="co">

            <%
//                HttpSession loginsession = request.getSession();
                String candidateID = (String) session.getAttribute("candidateID");

                if (candidateID != null) {
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");
                        PreparedStatement ps = con.prepareStatement("SELECT * FROM candidate WHERE cand_ID = ? ");
                        ps.setString(1, candidateID);
                        ResultSet rs = ps.executeQuery();

                        if (rs.next()) {
                            String ID = rs.getString("cand_ID");
                            String IC = rs.getString("cand_IC");
                            String Name = rs.getString("cand_Name");
                            String Email = rs.getString("cand_Email");
                            String Password = rs.getString("cand_Pass");
                            String Phone = rs.getString("cand_Phone");
                            String Address = rs.getString("cand_Add");
            %>

            <div class="popup-content">
                <form action="UpdateCandidateServ" method="POST">
                    <h2>UPDATE PROFILE</h2>
                    <input type="hidden" name="id" value="<%= ID%>">

                    <label for="ic">IC Number :</label>
                    <input type="text" name="ic" value="<%= IC%>">

                    <label for="name">Name :</label>
                    <input type="text" name="name" value="<%= Name%>">

                    <label for="email">Email :</label>
                    <input type="email" name="email" value="<%= Email%>">

                    <label for="password">Password :</label>
                    <input type="text" name="password" value="<%= Password%>">

                    <label for="phone">Phone Number :</label>
                    <input type="text" name="phone" value="<%= Phone%>" oninput="this.value = this.value.replace(/[^0-9]/g, '')" maxlength="12" 
                           placeholder="Enter Phone Number" required>

                    <label for="address">Address :</label>
                    <input type="text" name="address" value="<%= Address%>">

                    <input class="submit" type="submit" value="Update">
                    <p class="new"><a href="CandidateProfile.jsp">Back</a></p>
                </form>
            </div>

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

        </div>
            
            <button onclick="topFunction()" id="myBtn" title="top"><i class="fa-solid fa-chevron-up"></i></button>

        <script>
            function restrictToNumbers(inputElement) {
                inputElement.value = inputElement.value.replace(/[^0-9]/g, '');
            }

            function toggleNavbar() {
                var navbar = document.querySelector('.navbar');
                navbar.classList.toggle('minimized');
            }
            
            function signOut() {
            // Redirect to the logout servlet or your logout logic
            window.location.href = 'LogOutServ'; // Replace 'LogoutServlet' with your actual logout servlet
        }
        
        //scroll function
            var mybutton = document.getElementById("myBtn");

            window.onscroll = function () {
                scrollFunction();
            };

            function scrollFunction() {
                if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
                    mybutton.style.visibility = "visible";
                    mybutton.style.opacity = "1";
                } else {
                    mybutton.style.visibility = "hidden";
                    mybutton.style.opacity = "0";
                }
            }

            function topFunction() {
                document.body.scrollTop = 1;
                document.documentElement.scrollTop = 1;
            }
            function topFunction() {
                window.scrollTo({
                    top: 1,
                    behavior: "smooth"
                });
            }
            
        </script>
    </body>

    <footer>
        <p>© HR SkillCertify 2023</p>
    </footer>

</html>

