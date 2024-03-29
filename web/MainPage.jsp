<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Main Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="CSS/MainPage.css">
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>
</head>

<body>

    <header>
        <div class="main">
            <img class="logo" src="IMG/HRSCLogo.png" alt="logo">
        </div>
        <!-- <h2>HR SkillCertify</h2> -->
        <nav>
            <li class="dropdown">
                <a class="nav-link" href="Login.jsp"><i class="fa-solid fa-right-to-bracket"></i> SIGN IN </a>
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
        <br>
        <h3 class="title">PROGRAM PENTAULIAHAN PENGALAMAN KETERAMPILAN TERDAHULU</h3>
        <p>Program Persijilan melalui kaedah pengalaman kemahiran untuk dapatkan DIPLOMA secara santai</p>
        <hr>
        <div class="content">
            <div class="left-content">
                <img src="IMG/PPPKT2.png" alt="Left Image">
                <h3>PROSES PERLAKSANAAN PPPKT</h3>
            </div>
            <div class="right-content">
                <img src="IMG/PPPKT.png" alt="Right Image">
                <h3>PENDAFTARAN DEPOSIT YURAN PPPKT ONLINE-TAJAAN 50%</h3>
            </div>
        </div>
    </section>

    <button onclick="topFunction()" id="myBtn" title="top"><i class="fa-solid fa-chevron-up"></i></button>
    <script>
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
            document.body.scrollTop = 0;
            document.documentElement.scrollTop = 0;
        }
        function topFunction() {
            window.scrollTo({
                top: 0,
                behavior: "smooth"
            });
        }

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
        <p class="footer-text">&copy; HR SkillCertify 2023</p>
        <div class="contact-icons">
            <a href="https://www.facebook.com/harris.hussain.58" target="_blank" title="Facebook"><i class="fab fa-facebook"></i> HR Skill Solutions</a>
            <a href="https://pppkt.onpay.my/order/form/pppktonlinetajaan" target="_blank" title="Info"><i class="fas fa-envelope"></i> Information</a>
            <a href="https://api.whatsapp.com/send?phone=60197293275&text=PPKT24" target="_blank" title="WhatsApp">
                <i class="fab fa-whatsapp"></i> Contact Us </a>   
        </div>
    </footer>


</body>

</html>