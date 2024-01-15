<!DOCTYPE html>
<html lang="en">

<head>
    <title>Main Page</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="CSS/MainPage.css">
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/icon?family=Material+Icons">
</head>

<body>

    <header>
        <div class="main">
            <img class="logo" src="IMG/HRSCLogo.png" alt="logo">
        </div>
        <!-- <h2>HR SkillCertify</h2> -->
        <nav>
            <li class="dropdown">
                <a class="nav-link" href="Login.jsp">SIGN IN</a>
            </li>
        </nav>
    </header>

    <section class="hero">
        <div class="background-image" style="background-image: url('IMG/1.jpg')"></div>
        <div class="hero-content-area">
            <h1>HR SkillCertify</h1>
            <h3> Enhance Your Certificate Now !!!</h3>
            <!-- <a href="#" class="btn">Contact Us</a> -->
        </div>

    </section>

    <section class="destinations">
        <h3 class="title">Rest information will testttt here:</h3>
        <p>blah blash blahs blahs blahssdfasfsfsdfdsfsdfsdfsdfdsfdsfds</p>
        <hr>
        <p>blah blash blahs blahs blahssdfasfsfsdfdsfsdfsdfsdfdsfdsfds</p>

    </section>

    <section class="contact">
        <h3 class="title">Join our newsletter</h3>
        <p>Information will go here(if anyfdsfdsfsdfsdfdsfsdfdfdsfdsfsd)</p>
        <hr>
        <p>Information will go here(if anyfdsfdsfsdfsdfdsfsdfdfdsfdsfsd)</p>

    </section>


    <script>
        var slider = document.querySelector('.slider');
        var images = document.querySelectorAll('.slider img');
        var currentIndex = 0;
        var size = images[0].clientWidth;

        function nextSlide() {
            currentIndex = (currentIndex + 1) % images.length;
            updateSlider();
        }

        function prevSlide() {
            currentIndex = (currentIndex - 1 + images.length) % images.length;
            updateSlider();
        }

        function updateSlider() {
            slider.style.transition = "transform 0.5s ease-in-out";
            slider.style.transform = 'translateX(' + (-size * currentIndex) + 'px)';
        }

        // Auto move every 5 seconds
        setInterval(function () {
            nextSlide();
        }, 5000);
    </script>


    <footer>
        <p>&copy; HR SkillCertify 2023</p>
    </footer>

</body>

</html>