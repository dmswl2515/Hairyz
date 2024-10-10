<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>캠페인</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery 라이브러리 추가 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
/* 기본 레이아웃 설정 */
body {
	display: flex;
	flex-direction: column;
	min-height: 100vh;
	margin: 0;
	font-family: 'Arial', sans-serif;
	background-color: #f9f9f9;
}

.content {
	flex: 1;
}

/* 컨테이너 설정 */
.custom-container {
	max-width: 1000px;
	margin: 0 auto;
	padding: 20px;
	text-align: center;
}

/* 이미지 위에 텍스트를 배치하는 스타일 */
.campaign-text {
    text-align: center;
    font-size: 3rem;
    font-weight: bold;
    color: #333;
    margin-bottom: 20px; /* 이미지와 텍스트 사이에 여백 추가 */
}

/* 이미지 스타일 */
.campaign-image img {
    width: 100%;
    height: auto;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

/* 기타 스타일 */
hr {
	border: 1px solid #d8d8d8;
	width: 100%;
	margin-top: 50px;
}
</style>
</head>
<body>
    <!-- 헤더 -->
    <div class="content">
        <%@ include file="header.jsp" %>
        <hr>

        <!-- 캠페인 이미지 섹션 -->
        <div class="custom-container">
        	 <!-- 텍스트를 이미지 위쪽에 배치 -->
			<div class="campaign-text">유기동물에게 새 삶을!</div>

			<div class="campaign-image">
                <img src="images/petAdoption.png" alt="유기동물 입양 캠페인">
            </div>
        </div>
    </div>

    <!-- 1:1문의 -->
    <%@ include file="kakaoCh.jsp" %>
    <!-- FOOTER -->
	<%@ include file="footer.jsp" %>
    <!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>