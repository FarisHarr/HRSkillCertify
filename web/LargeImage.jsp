<%-- 
    Document   : LargeImage
    Created on : 30 Apr 2024, 12:47:08 am
    Author     : FarisHarr
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Receipt</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <div>
        <%-- Retrieve the base64-encoded image data from the request parameter --%>
        <%
            String imageBase64 = request.getParameter("image");
            if (imageBase64 != null && !imageBase64.isEmpty()) {
        %>
            <img src="data:image/jpeg;base64, <%= imageBase64 %>" style="display: block; margin: 0 auto; width: 35%; height: 35%;">

        <%
            } else {
        %>
            <p>No image data available.</p>
        <%
            }
        %>
    </div>
</body>
</html>



