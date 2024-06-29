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

    .cert ul {
        color: black;
        text-align: left; /* Align text to the left for better readability */
        padding-left: 10px; /* Add some padding to the left */
        margin: 5px;
        font-size: 18px;
        list-style-type: none; /* Remove bullet points */
    }

    .cert li {
        margin-bottom: 15px;
    }

    .cert button {
        background-color: #004080;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 4px;
        cursor: pointer;
        margin-top: 20px;
        transition: background-color 0.3s ease;
    }

    .cert button:hover {
        background-color: #45a049;
    }

    .cert a {
        text-decoration: none;
    }

    .cert img {
        max-width: 100%; /* Ensure image fits within the container */
        height: auto;
        display: block;
        margin: 10px auto;
        border-radius: 5px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        border: 1px solid #000;
    }

    table {
        width: 100%;
        margin: 20px 0;
        border-collapse: collapse;
        background-color: #f9f9f9;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    table, th, td {
        border: 1px solid #ddd;
    }

    th, td {
        padding: 12px;
        text-align: center;
    }

    th {
        background-color: #004080;
        color: white;
    }

    tr:nth-child(even) {
        background-color: #f2f2f2;
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
            <!--<a href="#" class="btn">Contact Us</a>--> 
        </div>

    </section>

    <section class="destinations">
        <br>
        <h3 class="title">PROGRAM PENTAULIAHAN PENGALAMAN KETERAMPILAN TERDAHULU</h3>
        <!--<p>The Certification Program through the skill experience method to obtain a DIPLOMA in a relaxed manner.!</p>-->
        <hr>
        <div class="infoCert">
            <div class="cert">
                <br><h2>Sijil Kemahiran Malaysia (SKM) Tahap 1, 2 dan 3</h2><br>
                <img src="IMG/SKMCert.png" alt="SKM Certificate Image">
                <ul>
                    <li><strong>Basic Skill Certification :</strong> Recognizes foundational skills in a specific trade.</li>
                    <li><strong>Employment Opportunities :</strong> Increases employability in technical and vocational fields.</li>
                    <li><strong>Career Advancement :</strong> Provides a pathway to higher qualifications like DKM and DLKM.</li>
                    <li><strong>Hands-on Experience :</strong> Focuses on practical skills and on-the-job training.</li>
                </ul>

                <a href="Login.jsp">
                    <button>Register</button>
                </a>                
            </div>

            <div class="cert">
                <br><h2>Diploma Kemahiran Malaysia (DKM) / Tahap 4</h2><br>
                <img src="IMG/DKMCert.png" alt="DKM Certificate Image">
                <ul>
                    <li><strong>Advanced Skills :</strong> Offers more in-depth training and higher-level skills compared to SKM.</li>
                    <li><strong>Higher Employability :</strong> Enhances job prospects in more specialized and technical roles.</li>
                    <li><strong>Professional Recognition :</strong> Provides recognition and credibility in the chosen field.</li>
                    <li><strong>Further Education :</strong> Acts as a bridge to higher qualifications, including DLKM and potentially university degrees.</li>
                </ul>

                <a href="Login.jsp">
                    <button>Register</button>
                </a>  
            </div>

            <div class="cert">
                <h2>Diploma Lanjutan Kemahiran Malaysia (DLKM) / Tahap 5</h2><br>
                <img src="IMG/DLKMCert.png" alt="DLKM Certificate Image">
                <ul>
                    <li><strong>Expert-Level Training :</strong> Delivers advanced and specialized skills for professional mastery.</li>
                    <li><strong>Leadership Opportunities :</strong> Prepares individuals for supervisory or managerial roles.</li>
                    <li><strong>Industry Recognition :</strong> Offers high professional credibility and acceptance in the industry.</li>
                    <li><strong>Pathway to Degree Programs :</strong> Facilitates entry into university programs and higher education.</li>
                </ul>

                <a href="Login.jsp">
                    <button>Register</button>
                </a>  
            </div>


            <hr>


            <h2><br>Comparison Table: SKM vs DKM vs DLKM</h2>
            <table>
                <thead>
                    <tr>
                        <th>Feature/Criteria</th>
                        <th>SKM (Sijil Kemahiran Malaysia)</th>
                        <th>DKM (Diploma Kemahiran Malaysia)</th>
                        <th>DLKM (Diploma Lanjutan Kemahiran Malaysia)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><strong>Level</strong></td>
                        <td>Basic Certification</td>
                        <td>Intermediate Diploma</td>
                        <td>Advanced Diploma</td>
                    </tr>
                    <tr>
                        <td><strong>Focus</strong></td>
                        <td>Foundational skills</td>
                        <td>In-depth technical and vocational skills</td>
                        <td>Specialized and advanced skills</td>
                    </tr>
                    <tr>
                        <td><strong>Typical Duration</strong></td>
                        <td>1-2 years</td>
                        <td>2-3 years</td>
                        <td>1-2 years post-DKM</td>
                    </tr>
                    <tr>
                        <td><strong>Career Opportunities</strong></td>
                        <td>Entry-level positions</td>
                        <td>Skilled technician roles</td>
                        <td>Supervisory/managerial positions</td>
                    </tr>
                    <tr>
                        <td><strong>Educational Pathway</strong></td>
                        <td>Leads to DKM</td>
                        <td>Leads to DLKM</td>
                        <td>Leads to degree programs</td>
                    </tr>
                    <tr>
                        <td><strong>Recognition</strong></td>
                        <td>Industry entry-level certification</td>
                        <td>Professional recognition</td>
                        <td>High professional credibility</td>
                    </tr>
                    <tr>
                        <td><strong>Practical Training</strong></td>
                        <td>Extensive hands-on experience</td>
                        <td>Combination of theory and practical</td>
                        <td>Advanced practical and theoretical training</td>
                    </tr>
                    <tr>
                        <td><strong>Prerequisites</strong></td>
                        <td>None or basic education</td>
                        <td>SKM or equivalent</td>
                        <td>DKM or equivalent</td>
                    </tr>
                </tbody>
            </table>

            <hr>

            <div class="content1">
                <h2>PROGRAM PPPKT ANJURAN HR SKILLS SOLUTION</h2>
                <div class="content">
                    <div class="left-content1">
                        <a href="Login.jsp">
                            <img src="IMG/HRSCP1.jpg" alt="Left Image">
                        </a>
                    </div>
                    <div class="right-content1">
                        <a href="Login.jsp">
                            <img src="IMG/HRSCP2.jpg" alt="Right Image">
                        </a>
                    </div>
                </div>
            </div>

            <hr>

            <div class="content">
                <div class="left-content">
                    <img src="IMG/PPPKT2.png" alt="Left Image">
                    <h3>PROSES PERLAKSANAAN PPPKT</h3><br>
                </div>
            </div>

            <hr>

            <div class="contentFeedback">
                
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
        <p class="footer-text">&copy; 2024 <strong>HR SkillCertify</strong>. All rights reserved </p>
        <div class="contact-icons">
            <a href="https://www.facebook.com/harris.hussain.58" target="_blank" title="Facebook"><i class="fab fa-facebook"></i> HR Skill Solutions</a>
            <a href="https://pppkt.onpay.my/order/form/pppktonlinetajaan" target="_blank" title="Info"><i class="fas fa-envelope"></i> Information</a>
            <a href="https://api.whatsapp.com/send?phone=60197293275&text=PPKT24" target="_blank" title="WhatsApp">
                <i class="fab fa-whatsapp"></i> Contact Us </a>   
        </div>
    </footer>


</body>

</html>