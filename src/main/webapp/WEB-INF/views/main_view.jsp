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
body.main footer hr { margin-top: 50px; }
.main .carousel.slide {  }
.main .carousel-item img { height: 600px; margin: auto; }
.carousel-control { top: 50%; margin-top: -25px; width: 50px; height: 50px; border-radius: 50%; background-color: rgba(0, 0, 0, 0.2); }
.carousel-control-prev { left:50px; }
.carousel-control-next { right: 50px; }
.carousel-item {  }
.carousel-item.item01 { background: #ff65a1; }
.carousel-item.item02 { background: #fdd1db url("images/slider2_bg.png") repeat-x 0 center; background-size: contain; }
.carousel-item.item03 { background: #a7c800 url("images/slider3_bg.png") repeat-x 0 center; background-size: contain; }
.carousel-item.item04 { background: #f0ecea; }
.carousel-item.item05 { background: #fff4dc; }
</style>
</head>
<body class="main">
	<!-- 로그 및 로그인 -->
    <div class="content">
		<%@ include file="header.jsp" %>
        <!-- 통합검색 창 -->
        <div class="custom-container my-4">
            <form action="/searchAll" class="form-inline d-flex justify-content-center" onsubmit="return validateForm();">
                <input class="form-control mr-sm-2" id="searchInput" type="text" name="sKeyword" placeholder="통합검색" aria-label="Search" style="width: 30%;">
                <button class="btn btn-outline-warning my-2 my-sm-0" type="submit">검색</button>
            </form>
        </div>
        
        <script>
		    function validateForm() {
		        const input = document.getElementById('searchInput');
		        if (input.value.trim() === '') {
		            alert('검색어를 입력해주세요');
		            return false; // 폼 제출을 중단합니다.
		        }
		        return true; // 폼을 정상적으로 제출합니다.
		    }
		</script>

        <!-- 슬라이더 -->
		<div id="carouselExampleIndicators"
			class="carousel slide" data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
				<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
				<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
				<li data-target="#carouselExampleIndicators" data-slide-to="3"></li>
				<li data-target="#carouselExampleIndicators" data-slide-to="4"></li>
			</ol>
			<div class="carousel-inner">
				<div class="carousel-item item01 active">
					<a href="${pageContext.request.contextPath}/list.do">
						<img class="d-block" src="images/slider1.png" alt="커뮤니티">
					</a>
				</div>
				<div class="carousel-item item02">
					<a href="${pageContext.request.contextPath}/s_main">
						<img class="d-block" src="images/slider2.png" alt="쇼핑">
					</a>
				</div>
				<div class="carousel-item item03">
					<a href="${pageContext.request.contextPath}/hospitalMap.do">
						<img class="d-block" src="images/slider3.png" alt="동물병원">
					</a>
				</div>
				<div class="carousel-item item04">
					<a href="${pageContext.request.contextPath}/cafeMap.do">
						<img class="d-block" src="images/slider4.png" alt="멍카페">
					</a>
				</div>
				<div class="carousel-item item05">
					<a href="${pageContext.request.contextPath}/petAdoption.do">
						<img class="d-block" src="images/slider5.png" alt="유기동물 현황">
					</a>
				</div>
			</div>
			<a class="carousel-control carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
			 <span class="carousel-control-prev-icon" aria-hidden="true"></span>
			 <span class="sr-only">Previous</span>
			</a>
			 <a class="carousel-control carousel-control-next" href="#carouselExampleIndicators"role="button" data-slide="next">
			  <span class="carousel-control-next-icon" aria-hidden="true"></span>
			  <span class="sr-only">Next</span>
			</a>
		</div>

    </div>
    
    <%@ include file="kakaoCh.jsp" %>
    <%@ include file="footer.jsp" %>

    <!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>