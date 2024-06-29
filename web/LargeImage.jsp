<%-- 
    Document   : LargeImage
    Created on : 30 Apr 2024, 12:47:08 am
    Author     : FarisHarr
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Receipt</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body {
                font-family: Arial, sans-serif;
                padding: 20px;
            }
            h1 {
                text-align: center;
            }
            .chart-container {
                margin: 20px auto;
                text-align: center;
            }
            .button-container {
                text-align: center;
                margin-top: 20px;
            }
            .button-container button {
                display: inline-block;
                padding: 10px 20px;
                margin: 10px;
                font-size: 16px;
                color: #fff;
                background-color: #007BFF;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            .button-container button:hover {
                background-color: #0056b3;
            }
            .button-container button:active {
                background-color: #00408d;
            }
            .button-container button:focus {
                outline: none;
                box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.5);
            }
            .button-container a {
                text-decoration: none;
            }

            @media print {
                body * {
                    visibility: hidden;
                }
                .chart-container, .chart-container * {
                    visibility: visible;
                }
                .button-container, .button-container * {
                    display: none;
                }
                .chart-container {
                    position: absolute;
                    left: 0;
                    top: 0;
                    width: 100%;
                    height: 100%;
                    margin: 0 ;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }
                .chart-container img {
                    width: 100%;
                    height: auto;
                }
            }
        </style>
    </head>

    <body>
        <div>
            <%-- Retrieve the base64-encoded image data from the request parameter --%>
            <%
                String imageBase64 = request.getParameter("image");
                if (imageBase64 != null && !imageBase64.isEmpty()) {
            %>
            <div class="chart-container">
                <img src="data:image/jpeg;base64, <%= imageBase64 %>" style="display: block; border: 1px solid black; margin: 0 auto; width: 45%; height: 45%;">
                <div class="button-container">
                    <button onclick="window.print()">Print</button>
                    <a href="data:image/jpeg;base64,<%= imageBase64 %>" download="certificate_overview.png">
                        <button>Download</button>
                    </a>
                </div>
            </div>
            <%
                } else {
            %>
            <p>No data available.</p>
            <%
                }
            %>
        </div>
    </body>
</html>


