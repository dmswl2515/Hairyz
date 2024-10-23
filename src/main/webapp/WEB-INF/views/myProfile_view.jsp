<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>    
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
	
}

.custom-container {
	max-width: 1000px;
	margin: 0 auto;
}

.custom-container hr {
	border: 1px solid #d8d8d8;
	width: 100%;
	margin-top: 100px
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

/* 프로필 이미지 스타일 */
.box {
	width: 120px;
	height: 120px;
	border-radius: 50%;
	overflow: hidden;
	margin: 0 auto;
	margin-top: 20px;
	background: #000000;
}

.profile {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.myPage-title {
	text-align: center;
	margin-top: 20px;
	font-weight: bold;
}

/* 이메일, 이름, 닉네임 출력 창 스타일 */
.info-container {
	margin-top: 20px;
	text-align: center;
}

.info-container p {
	margin: 5px 0;
	font-size: 16px;
	font-weight: bold;
}

/* 버튼 스타일 */
.btn-container button {
	margin: 5px 0;
	width: 30%;
	height: 50px;
}

.btn-container {
	text-align: center;
}

/* 세로 메뉴 스타일 */
.sidebar {
	background-color: #f8f9fa;
	padding: 20px;
	width: 200px;
	height: 100%;
	position: absolute;
	left: 0;
	top: 0;
}

.sidebar ul {
	list-style: none;
	padding: 0;
}

.sidebar li {
	margin-bottom: 10px;
}

.sidebar a {
	text-decoration: none;
	color: #333;
	/* font-weight: bold; */
}

.sidebar a:hover {
	text-decoration: underline;
}
</style>
</head>
<body>
	<!-- 로그 및 로그인 -->
    <div class="content">
		<%@ include file="header.jsp" %>
		<!-- 세로 메뉴 -->
		<div class="sidebar">
			<ul>
				<li><a href="${pageContext.request.contextPath}/myProfile_view.do"><b>내 프로필</b></a>
					<ul>
						<li><a href="${pageContext.request.contextPath}/editProfile.do?id=${ profile_view.mb_id }">&nbsp;-회원정보 수정</a></li>
						<li><a href="${pageContext.request.contextPath}/editPassword.do?id=${ profile_view.mb_id }">&nbsp;-비밀번호 변경</a></li>
					</ul>
				</li>
				<li><a href="${pageContext.request.contextPath}/petList.do?id=${ profile_view.mb_id }">반려동물 프로필</a></li>
				<li><a href="${pageContext.request.contextPath}/orderLookup.do?id=${ profile_view.mb_id }">주문 조회</a></li>
				<li><a href="${pageContext.request.contextPath}/returnExchange.do?id=${ profile_view.mb_id }">취소/교환/반품</a></li>
			</ul>
		</div>


		<!-- 내 프로필 페이지 -->
	    <div class="content">
	        <div class="custom-container">
	            <h1 class="myPage-title">내 프로필</h1>
	
	            <!-- 프로필 사진 -->
	            <div class="box">
					<c:choose>
						<c:when test="${not empty profile_view.mb_imgpath}">
							<img class="profile" src="${pageContext.request.contextPath}/upload/${profile_view.mb_orgname}" alt="프로필 사진">
						</c:when>
						<c:otherwise>
							<img class="profile" src="images/logo.png" alt="기본 프로필 사진">
						</c:otherwise>
					</c:choose>
				</div>
	
	            <!-- 이메일, 이름, 닉네임 출력 -->
	            <div class="info-container">
	            	<span>이메일</span>
	                <input disabled value="${profile_view.mb_id}">
	            </div>
	            <div></div>
	            <div class="info-container">
	            	<span>이름</span>
	                <input disabled value="${profile_view.mb_name}">
	            </div>
	            <div></div>
	            <div class="info-container">
	            	<span>닉네임</span>
	                <input disabled value="${profile_view.mb_nickname}">
	            </div>
	
	            <!-- Divider -->
	            <hr>
	
	            <!-- 회원정보 수정, 로그아웃 버튼 -->
	            <div class="btn-container">
	                <button type="button" class="btn btn-warning" onclick="javascript:window.location='${pageContext.request.contextPath}/editProfile.do?id=${ profile_view.mb_id }'">회원정보 수정</button>
	            </div>
	            <div class="btn-container">
	                <button type="button" class="btn btn-warning" onclick="javascript:window.location='${pageContext.request.contextPath}/logout.do'">로그아웃</button>
	            </div>
	        </div>
	    </div>
    <!-- Divider -->
 	   <div class="custom-container">
            <hr>
        </div>
    </div>
    
    <%@ include file="kakaoCh.jsp" %>
    
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