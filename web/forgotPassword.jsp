<!doctype html>
<html>
    <head>
        <meta charset='utf-8'>
        <meta name='viewport' content='width=device-width, initial-scale=1'>
        <title>Forgot Password</title>
        <link href='' rel='stylesheet'>
        <script type='text/javascript'
        src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>

        <style>
            body {
                background-position: center;
                background-color: #999999;
                background-repeat: no-repeat;
                background-size: cover;
                color: #505050;
                font-family: "Rubik", Helvetica, Arial, sans-serif;
                font-size: 14px;
                font-weight: normal;
                line-height: 1.5;
                text-transform: none;
                margin: 0;
                padding: 0;
                display: flex;
                align-items: center;
                justify-content: center;
                min-height: 100vh;
            }

            .container {
                background-color: #fff;
                padding: 20px;
                border: 1px solid black;
                box-shadow: 0 0 30px rgba(0, 0, 0, 0.9);
                width: 80%;
                max-width: 400px;
            }

            .logo {
                position: absolute;
                top: 90px;
                left : 530px;
                height: 135px;
                width: 150px;
                margin-top: 20px;
            }

            .forgot {
                text-align: center;
                margin-bottom: 20px;
            }

            .forgot h2{
                font-size: 2rem;
                margin-left: 140px;
            }

            .list {
                list-style: none;
                padding-left: 0;
            }

            .list li {
                margin-bottom: 10px;
            }

            .label{
                padding:20px;
            }

            .form{
                /*display: flex;*/
                width: 95%;
                flex-direction: column;
                align-items: center;
                border: 2px solid black;
                border-radius: 10px;
                height: 30px;
            }

            .card-footer {
                background-color: #fff;
                text-align: center;
                padding : 20px;
                margin-top: 10px;
            }

            .btn-success{
                background-color: #00000090;
                border: 1px solid black;
                color: rgb(255, 255, 255);
                outline: none;
                border-radius: 10px;
                padding : 5px;
                transition: background-color 0.3s, transform 0.3s;
            }

            .btn-success:hover {
                cursor: pointer;
                background-color: #00ca54;
                transform: scale(1.02);
            }

            .btn-danger{
                font-size: 18px;
                background-color: #00000090;
                border: 1px solid black;
                color: rgb(255, 255, 255);
                text-decoration: none;
                border-radius: 10px;
                padding : 6px;
                margin-left: 10px;
            }

            .btn-danger:hover {
                cursor: pointer;
                background-color: #00ca54;
            }

            .form-control:focus {
                color: #495057;
                background-color: #fff;
                border-color: #76b7e9;
                outline: 0;
                box-shadow: 0 0 0 0px #28a745;
            }

            .form-text:hover {
                color: #c2f000; /* You can change the color or add other styling */
                cursor: pointer; /* Change the cursor on hover to indicate interactivity */
            }

            .new {
                display: flex;
                justify-content: center;
                align-items: center;
                margin: 5px;
            }

            .new a {
                text-decoration: none;
                color: black;
            }

            .new a:hover {
                color: #c2f9ff;
            }



        </style>
    </head>

    <body>
        <div class="container">
            <div class="forgot">
                <h2>Forgot Password</h2>
                <img class="logo" src="IMG/HRSCLogo.png" alt="logo">
                <p>Change your password in three easy steps. This will help you
                    to secure your password!</p>
            </div>
            <form class="card" action="ForgotPassword" method="POST">
                <div class="card-body">
                    <div class="form-group">
                        <label for="emailpass">Enter your registered email address.</label> <input
                            class="form" type="text" name="email" id="email-for-pass" required="">
                        <small class="form-text">The OTP code will be send to your email..</small>
                    </div>
                </div>
                <div class="card-footer">
                    <button class="btn-success" type="submit">Get New Password</button>
                </div>
                <p class="new"><a href="Login.jsp">Back</a></p>
            </form>
            <c:if test="${not empty requestScope.error}">
                <div style="text-align: center; color: red;">
                    <div class="alert alert-danger">${requestScope.error}</div>
                </div>
            </c:if>
        </div>
        <script type='text/javascript'
        src='https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.bundle.min.js'></script>
        <script type='text/javascript' src=''></script>
        <script type='text/javascript' src=''></script>
        <script type='text/Javascript'></script>
    </body>
</html>