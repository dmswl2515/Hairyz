<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>   
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

/* 이미지 섹션 스타일 */
.campaign-section {
    margin-top: 40px;
}

.campaign-title {
    text-align: center;
    font-size: 2rem;
    font-weight: bold;
    color: #333;
    margin-bottom: 20px;
}

.image-wrapper {
    text-align: center; /* 텍스트와 이미지를 중앙에 배치 */
    margin-bottom: 20px;
}

/* 이미지 설명 텍스트 */
.image-caption {
    font-size: 1.2rem;
    font-weight: bold;
    margin-bottom: 10px;
    color: #555;
}

/* 이미지 스타일 수정 */
.image-wrapper img {
    width: 100%; /* 이미지를 가득 채우도록 설정 */
    height: auto;
    display: block;
    margin: 0 auto;
}

/* 이미지가 양 옆에 배치되도록 설정 */
.campaign-image {
    display: flex;
    justify-content: space-between;
    gap: 20px; /* 이미지 간격 조절 */
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
            <div class="campaign-section">
                <div class="campaign-title">유기동물 현황</div>
                <div class="campaign-image">
                    <img src="images/originalgraph.png" alt="유기동물 입양 캠페인">
                    <img src="images/bargraph.png" alt="유기동물 입양 캠페인">
                </div>
            </div>

            <!-- 두 번째 이미지 섹션 -->
            <div class="campaign-section">
                <div class="campaign-title">지자체 유기동물 통계</div>
                
                <!-- 설명 텍스트 추가 -->
				<div class="image-wrapper">
					<div class="image-caption">입양률(%)</div>
					<img src="images/adoptionratesbyregion.png" alt="입양률 그래프">
				</div>

				<!-- 두 번째 이미지 섹션 (안락사율) -->
				<div class="image-wrapper">
					<div class="image-caption">안락사율(%)</div>
					<img src="images/AutonomousRegion.png" alt="안락사율 그래프">
				</div>
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