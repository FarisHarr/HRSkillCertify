<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>New Password</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">
        <style>
            body {
                background-color: aliceblue;
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            .container {
                background-color: #fff;
                border: 1px solid #ccc;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                max-width: 500px;
                width: 100%;
                padding: 20px;
                box-sizing: border-box;
            }

            h1 {
                font-size: 2rem;
                color: #343a40;
                text-align: center;
            }

            h5 {
                color: #343a40;
                text-align: center;
            }

            .text-danger {
                color: #dc3545;
            }

            .form-group {
                margin-bottom: 15px;
            }

            .form-group input {
                width:300px;
                height: 45px;
                padding: 10px;
                margin: 0 auto;
                display: block;
                border: 1px solid #17a2b8;
                border-radius: 4px;
                font-size: 1rem;
            }

            .form-group input.placeicon::placeholder {
                font-family: 'FontAwesome', 'Helvetica';
                color: #ced4da;
            }

            .btn-info {
                width: calc(100% - 20px);
                height: 45px;
                margin: 0 auto;
                display: block;
                background-color: #17a2b8;
                border: none;
                border-radius: 4px;
                color: #fff;
                font-size: 1rem;
                cursor: pointer;
                text-align: center;
            }

            .btn-info:hover {
                background-color: #138496;
            }

            .bg-light {
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                margin-top: 20px;
                text-align: center;
            }

            .form-horizontal {
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            hr {
                border: 0;
                border-top: 1px solid #ccc;
                width: calc(100% - 40px);
                margin: 20px auto;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <!-- Main Heading -->
            <h1>
                <strong>Reset Password</strong>
            </h1>

            <form class="form-horizontal" action="NewPassword" method="POST">
                <!-- User Name Input -->
                <div class="form-group">
                    <input type="text" name="IC" oninput="restrictToNumbers(this);" maxlength="12"
                           placeholder="&#xf084; &nbsp; IC" class="placeicon" required>
                </div>

                <!-- Password Input -->
                <div class="form-group">
                    <input type="password" name="Password"
                           placeholder="&#xf084; &nbsp; New Password"
                           class="placeicon" required>
                </div>

                <!-- Reset Button -->
                <div class="form-group">
                    <input type="submit" value="Reset" class="btn-info">
                </div>
            </form>

            <!-- Alternative Login -->
            <div class="bg-light">
                <!-- Horizontal Line -->
                <hr>

                <!-- Register Now -->
                <h5>
                    Don't have an Account? <a href="Register.jsp" class="text-danger">Register Now!</a>
                </h5>
            </div>
        </div>

        <script>
            function restrictToNumbers(inputElement) {
                inputElement.value = inputElement.value.replace(/[^0-9]/g, '');
            }
        </script>
    </body>
</html>
