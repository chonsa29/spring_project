<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
    <title>MealPick - 밀키트 쇼핑몰</title>
</head>

<body>
    <div id="appHeader">
        <header class="header">
            <div class="logo-container">
                <div class="logo-contents">
                    <div class="logo">
                        <img src="/img/icon.png" alt="MealPick 로고">
                    </div>
                    <div class="logo2">
                        <img src="/img/MEALPICK.png" alt="MealPick 로고">
                    </div>
                </div>
                <!-- nav를 logo-container 내부에 포함 -->
                <nav class="nav">
                    <a href="#">MENU1</a>
                    <a href="/product.do">PRODUCT</a>
                    <a href="#">BRAND</a>
                    <a href="#">COMMUNITY</a>
                    <a href="#">HELP</a>
                </nav>

                <div class="right-container">
                    <div class="login-container">
                        <a href="javascript:;">LOGIN</a>
                        <a href="/cart.do">CART</a>
                    </div>
                    <div class="search-container">
                        <input type="text" placeholder="Search">
                    </div>
                </div>
            </div>
        
            
        </header>

        <div class="floating-icon">
            <img src="/img/icon.png" alt="아이콘">
        </div>
    </div>
</body>
</html>

<script>
    const appHeader = Vue.createApp({
        data() {
            return {
              
            };
        },
        methods: {
        
        },
        mounted() {
            const floatingIcon = document.querySelector(".floating-icon img");
            if (floatingIcon && floatingIcon.parentElement) { // 요소가 있는지 확인
                floatingIcon.parentElement.addEventListener("mouseover", function () {
                    floatingIcon.src = "/img/icon2.png"; // hover 상태 이미지 경로
                });

                floatingIcon.parentElement.addEventListener("mouseout", function () {
                    floatingIcon.src = "/img/icon.png"; // 기본 상태 이미지 경로
                });
            }
        },
    });

    appHeader.mount('#appHeader');
</script>
