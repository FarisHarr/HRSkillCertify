<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Enter OTP</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
        <style>
            body {
                background-color: #f8f9fa;
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            .form-gap {
                padding-top: 70px;
            }

            .container {
                max-width: 400px;
                width: 100%;
                padding: 20px;
                background-color: #fff;
                border: 1px solid #ccc;
                border-radius: 8px;
                box-shadow: 0 0 30px rgba(0, 0, 0, 0.1);
                text-align: center;
            }

            .panel-body {
                padding: 20px;
            }

            .panel-body h2 {
                margin: 20px 0;
                color: #343a40;
            }

            .form-group {
                margin-bottom: 15px;
                text-align: left;
            }

            .input-group {
                display: flex;
                align-items: center;
            }

            .input-group-addon {
                background-color: #eee;
                border: 1px solid #ccc;
                padding: 10px;
                border-radius: 4px 0 0 4px;
            }

            .form-control {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 0 4px 4px 0;
                font-size: 1rem;
                height: 45px;
                box-sizing: border-box;
            }

            .btn {
                width: 100%;
                padding: 10px;
                background-color: #007bff;
                border: none;
                border-radius: 4px;
                color: #fff;
                font-size: 1rem;
                cursor: pointer;
                margin-top: 10px;
            }

            .btn:hover {
                background-color: #0056b3;
            }

            .text-danger {
                color: #dc3545;
                margin-top: 10px;
                display: block;
                text-align: center;
            }
        </style>
    </head>

    <body>
        <div class="container">
            <div class="panel-body">
                <div class="text-center">
                    <h3>
                        <i class="fa fa-lock fa-4x"></i>
                    </h3>
                    <h2 class="text-center">Enter OTP</h2>
                    <% if (request.getAttribute("message") != null) {%>
                    <p class="text-danger ml-1"><%= request.getAttribute("message")%></p>
                    <% }%>
                    <form id="register-form" action="ValidateOtp" role="form" autocomplete="off" class="form" method="POST">
                        <div class="form-group">
                            <div class="input-group">
                                <span class="input-group-addon"><i class="glyphicon glyphicon-envelope color-blue"></i></span>
                                <input id="opt" name="otp" placeholder="Enter OTP" class="form-control" type="text" oninput="restrictToNumbers(this);" required="required">
                            </div>
                        </div>
                        <div class="form-group">
                            <input name="recover-submit" class="btn btn-lg btn-primary btn-block" value="Reset Password" type="submit">
                        </div>
                        <input type="hidden" class="hide" name="token" id="token" value="">
                    </form>
                </div>
            </div>
        </div>

        <script>
            function restrictToNumbers(inputElement) {
                inputElement.value = inputElement.value.replace(/[^0-9]/g, '');
            }
        </script>
    </body>
</html>
