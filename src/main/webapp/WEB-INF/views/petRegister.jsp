<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>반려동물 등록</title>
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

input[type="radio"].btn-check {
	display: none;
}

/* 버튼 스타일 */
.btn-check:checked+label {
	background-color: #ffc107; /* 선택된 버튼의 배경색 */
	color: black; /* 선택된 버튼의 글자색 */
}

.btn-outline-primary {
	border-color: #007bff; /* 기본 버튼 테두리 색상 */
}

.btn-outline-primary:hover {
	background-color: #007bff; /* 버튼 hover 시 배경색 */
	color: white; /* 버튼 hover 시 글자색 */
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
                   	<a href="#" class="btn btn-outline-warning">마이페이지</a>
                   	<a href="#" class="btn btn-outline-warning">장바구니</a>
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

		<!-- 세로 메뉴 -->
		<div class="sidebar">
			<ul>
				<li><a href="myProfile_view.do">내 프로필</a>
					<ul>
						<li><a href="editProfile.do?id=${ petRegister.mb_id }">&nbsp;-회원정보 수정</a></li>
						<li><a href="editPassword.do?id=${ petRegister.mb_id }">&nbsp;-비밀번호 변경</a></li>
					</ul>
				</li>
				<li><a href="#"><b>반려동물 프로필</b></a></li>
				<li><a href="#">주문 조회</a></li>
				<li><a href="#">취소/교환/반품</a></li>
			</ul>
		</div>


		<!-- 회원정보 수정 페이지 -->
	    <div class="content">
	        <div class="custom-container">
	            <h1 class="myPage-title">반려동물 등록</h1>
	
	            <form action="petProfileCreate.do?mb_no=${petRegister.mb_no }" method="post" name="reg_frm" class="was-validated">
		            <!-- 프로필 사진 -->
		            <div class="box">
		                <img class="profile" src="/images/logo.png">
					</div>
					<div class="btn-container text-center mt-3">
						<button type="button" class="btn btn-warning" onclick="#">사진추가</button>
					</div>
					<br>
					<div class="form-group">
		                <div class="input-group">
		                	<input type="text" class="form-control" name="name" id="name" size="20" placeholder="이름"  required>
		                </div>
		            </div>
		            <div class="form-group">
						<input type="text" class="form-control" name="birth" id="birth" size="20" placeholder="생년월일" required>
		            </div>
		            <div class="form-group">
		            	<div class="form-group row">
						    <div class="col-6 text-center">
						        <input type="radio" class="btn-check" name="pettype" id="pettype1" value="강아지" autocomplete="off" checked>
						        <label class="btn btn-outline-warning w-100" for="pettype1">강아지</label>
						    </div>
						    <div class="col-6 text-center">
						        <input type="radio" class="btn-check" name="pettype" id="pettype2" value="고양이" autocomplete="off">
						        <label class="btn btn-outline-warning w-100" for="pettype2">고양이</label>
						    </div>
						</div>
					</div>
		            <div class="form-group">
		                <input type="text" class="form-control" name="breed" id="breed" size="20" placeholder="품종" required>
		            </div>
		            <div class="form-group">
		            	<label for="gender" class="font-weight-bold">성별</label>
					    <div class="form-group row">
					        <div class="col-6 text-center">
					            <input type="radio" name="gender" id="gender1" value="남아" autocomplete="off" checked>
					            <label for="gender1">남아</label>
					        </div>
					        <div class="col-6 text-center">
					            <input type="radio" name="gender" id="gender2" value="여아" autocomplete="off">
					            <label for="gender2">여아</label>
					        </div>
					    </div>
					</div>
					
					<div class="form-group">
					    <!-- 주소 입력창 -->
					    <input type="text" class="form-control" name="weight" id="weight" placeholder="몸무게" required>
					</div>
					
		            <!-- Divider -->
		            <hr>
		
		            <!-- 반려동물 등록, 취소 버튼 -->
		            <div class="btn-container">
		                <button type="submit" class="btn btn-warning">등록</button>
		            </div>
		            <div class="btn-container">
		                <button type="button" class="btn btn-warning" onclick="javascript:window.location='#'">취소</button>
		            </div>
		        </form>
	
	        </div>
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