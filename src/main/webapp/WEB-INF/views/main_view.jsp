<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>털뭉치즈</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* 기본 레이아웃 설정 */
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            margin: 0;
        }

        /* 내용물이 차지할 공간을 유지 */
        .content {
            flex: 1;
        }

        /* footer를 페이지 하단에 고정 */
        footer {
            background-color: #ffffff;
            padding: 20px;
            text-align: center;
            width: 100%;
        }

        /* hr 두께 설정 */
        hr {
            border: 1px solid #d8d8d8;
            width: 100%;
            margin-top: 100px
        }

        .custom-container {
            max-width: 1000px;
            margin: 0 auto;
        }

        .logo-container {
            text-align: center;
        }

        .logo-container img {
            max-width: 100px;
            margin-left: 250px; 
        }

        .slider {
            height: 400px;
            background-color: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
        }
    </style>
</head>
<body>
	<!-- 로그 및 로그인 -->
    <div class="content">
        <div class="custom-container">
            <div class="row align-items-center py-3">
                <div class="col-9 logo-container">
                    <a href="main_view.do">
                        <img src="images/logo.png" alt="로고">
                    </a>
                </div>
				
				<div class="col-3 text-right">
					<%
					//아이디 취득 후 id가 Null인지 확인
					String id = (String)session.getAttribute("userId");
					if (id == null)
					{
					%>
                    	<a href="login.do" class="btn btn-outline-warning">로그인</a>
                    <%}else{%>
                    	<a href="#" class="btn btn-outline-warning">마이페이지</a>
                    	<a href="#" class="btn btn-outline-warning">장바구니</a>
                    <%} %>
                </div>
            </div>
        </div>

        <!-- Navigation Bar -->
        <nav class="navbar navbar-expand-lg navbar-light">
            <div class="custom-container">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#">커뮤니티</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">쇼핑</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">동물병원</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">멍카페</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">캠페인</a>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- 통합검색 창 -->
        <div class="custom-container my-4">
            <form class="form-inline d-flex justify-content-center">
                <input class="form-control mr-sm-2" type="search" placeholder="통합검색" aria-label="Search" style="width: 30%;">
                <button class="btn btn-outline-warning my-2 my-sm-0" type="submit">검색</button>
            </form>
        </div>

        <!-- 슬라이더 -->
		<div id="carouselExampleIndicators"
			class="carousel slide custom-container" data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
				<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
				<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
				<li data-target="#carouselExampleIndicators" data-slide-to="3"></li>
				<li data-target="#carouselExampleIndicators" data-slide-to="4"></li>
			</ol>
			<div class="carousel-inner">
				<div class="carousel-item active">
					<a href="#">
						<img class="d-block w-100" src="images/slider1.png" alt="First slide">
					</a>
				</div>
				<div class="carousel-item">
					<a href="#">
						<img class="d-block w-100" src="images/slider2.png" alt="Second slide">
					</a>
				</div>
				<div class="carousel-item">
					<a href="#">
						<img class="d-block w-100" src="images/slider3.png" alt="Third slide">
					</a>
				</div>
				<div class="carousel-item">
					<a href="#">
						<img class="d-block w-100" src="images/slider4.png" alt="Fourth slide">
					</a>
				</div>
				<div class="carousel-item">
					<a href="#">
						<img class="d-block w-100" src="images/slider5.png" alt="Fifth slide">
					</a>
				</div>
			</div>
			<a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
			 <span class="carousel-control-prev-icon" aria-hidden="true"></span>
			 <span class="sr-only">Previous</span>
			</a>
			 <a class="carousel-control-next" href="#carouselExampleIndicators"role="button" data-slide="next">
			  <span class="carousel-control-next-icon" aria-hidden="true"></span>
			  <span class="sr-only">Next</span>
			</a>
		</div>

		<!-- Divider -->
        <div class="custom-container">
            <hr>
        </div>
    </div>
    
    <!-- FOOTER -->
    <footer class="container">
        <p class="float-end"><strong>털뭉치즈</strong></p>
        <p>COMPANY : 털뭉치즈</p>
    </footer>

    <!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>