<%-- 
    Document   : TimeTable
    Created on : 19 Jan 2024, 10:16:58 pm
    Author     : FarisHarr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>

    <head>
        <title>Time Table</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="CSS/CandidateSkeleton.css">
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/icon?family=Material+Icons">

    </head>

    <style>
        .info {
            margin: 0 auto;
            text-align: center;
            padding: 20px;
            width: 80%;
            height: 100vh;
            background-color: aliceblue;
            display: flex;
        }

        .cert {
            background-color: rgb(199, 199, 199);
            width: 20%;
            padding: 55px;
            margin: 50px;
            border-radius: 8px;
            text-align: center;
            display: flex;
            flex-direction: column;

        }

        .cert button {
            background-color: #fff;
            color: #212121;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            margin-top: auto;
            /* Push the button to the bottom */

        }


        #table img {
            width: 20px;
            height: 20px;
            cursor: pointer;
        }

        .table {
            display:block;
            margin-top: 60px;
            margin-left: 50px;
            place-items: center;
            /* margin: 20px; */
        }

        table {
            border-collapse: collapse;
            width:100%;

        }


        th {
            text-align: left;
            color: white;
            background-color: grey;
        }

        td,
        th {
            border: 1px solid #ddd;
            padding: 8px;
        }

        input[type=number] {
            width: 70px;
        }

        #table th,
        #table td {
            width: 150px;
            padding: 30px;
            border: 1px solid black;
            text-align: center;
        }

        #table button {
            border: none;
            background-color: transparent;
            padding: 0;
        }

        #table img {
            width: 20px;
            height: 20px;
        }


        @media screen and (max-width: 600px) {

            #table th:nth-child(n+6),
            #table td:nth-child(n+6) {
                display: none;
            }
        }
    </style>

    <body>
        <%
            String candidateID = (String) session.getAttribute("candidateID");

            if (candidateID != null) {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hrsc", "root", "admin");

                    // Fetch the status from the payment table
                    PreparedStatement ps = con.prepareStatement("SELECT * FROM payment WHERE cand_ID = ?");
                    ps.setString(1, candidateID);
                    ResultSet rs = ps.executeQuery();

                    String status = "";
                    String certificateType = ""; // Add this variable to store cert_Type
                    if (rs.next()) {
                        status = rs.getString("status");
                        certificateType = rs.getString("cert_Type"); // Store cert_Type in a variable
                    }

                    // Fetch the candidate name from the candidate table
                    ps = con.prepareStatement("SELECT cand_Name FROM candidate WHERE cand_ID = ?");
                    ps.setString(1, candidateID);
                    rs = ps.executeQuery();

                    if (rs.next()) {
                        String Name = rs.getString("cand_Name");
        %>

        <header>
            <div class="main">
                <img class="logo" src="IMG/HRSCLogo.png" alt="logo">
                <nav>
                    <ul class="nav_links">
                        <button class="navbar-toggle" onclick="toggleNavbar()"> ☰ </button>
                    </ul>
                </nav>
            </div>
            <nav>
                <li class="dropdown">
                    <a class="nav-link"><%= Name%></a>
                    <ul class="dropdown-content">
                        <li><a href="CandidateProfile.jsp">Profile</a></li>
                        <li><a href="MainPage.jsp" onclick="signOut()">Sign Out</a></li>
                    </ul>
                </li>
            </nav>
        </header>

        <div class="container">
            <div class="navbar">
                <a href="HomePage.jsp">Home</a>
                <a href="CandidateProfile.jsp">User Profile</a>
                <a href="AboutCertificate.jsp">About Certificate</a>
                <a href="TimeTable.jsp">Time Table</a>
                <a href="Feedback.jsp">Feedback</a>
            </div>

            <div class="info">
                <div class="cert">
                    <h2>Class</h2>
                    <br>
                    <h3><%= certificateType%></h3> 
                    <br>
                    <p>Your payment status : <%= status%> </p> 
                    <br> 
                    <%-- Add conditional check for the Attend button --%>
                    <% if (status.equals("Pending") || status.equals("Rejected")) { %>
                    <form action="Payment.jsp">
                        <button type="submit">Attend</button>
                    </form>
                    <% } else { %>
                    <form action="Attendance.jsp">
                        <button type="submit">Attend</button>
                    </form>
                    <% } %>

                </div>

                <div class="table">
                    <table id="table">
                        <thead>
                            <tr>
                                <th>Certificate Type</th>
                                <th>Class</th>
                                <th>Date</th>
                                <th>Time Slot</th> <!-- Added Time Slot column -->
                            </tr>
                        </thead>

                        <tbody>
                            <!-- Dummy data rows with dropdowns for time selection -->
                            <tr>
                                <td>Certificate  A</td>
                                <td>Class X</td>
                                <td>2024-04-15</td>
                                <td>
                                    <select>
                                        <option value="09:00 AM">09:00 AM</option>
                                        <option value="10:00 AM">10:00 AM</option>
                                        <option value="11:00 AM">11:00 AM</option>
                                        <!-- Add more options as needed -->
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Certificate B</td>
                                <td>Class Y</td>
                                <td>2024-04-16</td>
                                <td>
                                    <select>
                                        <option value="09:00 AM">09:00 AM</option>
                                        <option value="10:00 AM">10:00 AM</option>
                                        <option value="11:00 AM">11:00 AM</option>
                                        <!-- Add more options as needed -->
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Certificate C</td>
                                <td>Class Z</td>
                                <td>2024-04-17</td>
                                <td>
                                    <select>
                                        <option value="09:00 AM">09:00 AM</option>
                                        <option value="10:00 AM">10:00 AM</option>
                                        <option value="11:00 AM">11:00 AM</option>
                                        <!-- Add more options as needed -->
                                    </select>
                                </td>
                            </tr>
                            <!-- End of dummy data rows --> 
                        </tbody>
                    </table>
                </div>
            </div>  
        </div>

        <script>
            function toggleNavbar() {
                var navbar = document.querySelector('.navbar');
                navbar.classList.toggle('minimized');
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
                response.sendRedirect("Login.jsp");
            }
        %>

        <footer>
            <p>&copy; HR SkillCertify 2023</p>
        </footer>

    </body>

</html>
