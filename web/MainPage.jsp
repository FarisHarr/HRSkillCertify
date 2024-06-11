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

<style>
    .infoCert {
        text-align: center;
        padding: 20px;
        width: 170%;
        background-color: #DDE6ED;
        display: flex;
        justify-content: space-around; /* Distributes space between the .cert elements */
        flex-wrap: wrap; /* Allows wrapping if there are too many .cert elements */
    }

    .cert {
        background-color: #f9f9f9;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        height: auto;
        padding: 20px;
        margin: 10px;
        max-width: 380px; /* Adjust the maximum width as needed */
        border-radius: 8px;
        text-align: center;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        transition: transform 0.9s ease; /* Add transition for smooth scaling */
    }

    .cert:hover {
        transform: scale(1.02); /* Scale the element on hover */
    }

    .cert h2 {
        margin-bottom: 10px;
        font-size: 1.5em; /* Adjust font size as needed */
    }

    .cert h4 {
        margin: 10px 0;
        font-size: 1.1em; /* Adjust font size as needed */
    }

    .cert button {
        background-color: #004080;
        color: white;
        border: none;
        padding: 8px 16px;
        border-radius: 4px;
        cursor: pointer;
    }

    .cert button:hover {
        background-color: #45a049;
    }

    .cert a {
        text-decoration: none;
    }

    .cert img {
        height: auto; /* Maintain aspect ratio */
        display: block; /* Ensure image behaves as a block element */
        margin-bottom: 10px; /* Add some space below the image */
        border-radius: 5px; /* Add rounded corners to the image */
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Add a subtle shadow to the image */
        border: 1px solid #000000;
    }

    /* Scroll button */
    #myBtn {
        position: fixed;
        bottom: 20px;
        right: 30px;
        z-index: 99;
        width: 40px;
        border: none;
        background-color: #27374D;
        color: white;
        cursor: pointer;
        padding: 10px;
        border-radius: 5px;
        visibility: hidden; /* Initially hidden */
        opacity: 0; /* Initially invisible */
        transition: visibility 0s, opacity 0.5s, background-color 0.5s, transform 0.5s;
    }

    #myBtn:hover {
        background-color: #27374D;
        color: #9DB2BF;
        transform: scale(1.1);
    }
</style>

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
        <div class="infoCert">
            <div class="cert">
                <h2>Sijil Kemahiran Malaysia (SKM) Tahap 1, 2 dan 3</h2><br>
                <img src="IMG/SKMCert.png" alt="SKM Certificate Image">
                <h4>- Skilled in performing a variety of routine and predictable work activities. </h4>
                <h4>- Proficient in various tasks within a predictable scope. </h4>
                <h4>- Limited autonomy, responsibility and engaging in advanced tasks.</h4>
                <br>
                <a href="Login.jsp">
                    <button>Register</button>
                </a>                
            </div>

            <div class="cert">
                <h2>Diploma Kemahiran Malaysia (DKM)/ Tahap 4</h2><br>
                <img src="IMG/DKMCert.png" alt="DKM Certificate Image">
                <h4>- Skilled in performing technical and professional work activities with a wide scope. </h4>
                <h4>- Higher level of responsibility and autonomy compared to SKM. </h4>
                <h4>- May oversee the work of others and manage resources.</h4>
                <br>
                <a href="Login.jsp">
                    <button>Register</button>
                </a>  
            </div>

            <div class="cert">
                <h2>Diploma Lanjutan Kemahiran Malaysia (DLKM) / Tahap 5</h2><br>
                <img src="IMG/DLKMCert.png" alt="DLKM Certificate Image">
                <h4>- Deeply skilled in applying basic principles and complex techniques across a broad and often unexpected scope of work. </h4>
                <h4>- Highest level of responsibility and autonomy among the three qualifications. </h4>
                <h4>- Engages in tasks such as analysis, diagnosis, design, planning, evaluation, and operation. </h4>
                <!--<h4>- Responsible for managing the work of others, allocating resources, and engaging in advanced tasks.</h4>-->
                <br>
                <a href="Login.jsp">
                    <button>Register</button>
                </a>  
            </div>
            <!--<br>-->
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