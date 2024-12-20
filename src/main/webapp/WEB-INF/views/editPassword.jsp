<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>   
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>비밀번호 수정</title>
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
<script>
	
	function infoConfirm() {
		
		if (document.reg_frm.newPassword.value.length == 0) {
			alert("비밀번호는 필수사항입니다.");
			reg_frm.pw.focus();
			return;
		}
		
		if (document.reg_frm.newPassword.value != document.reg_frm.newPw_check.value) {
			alert("새 비밀번호가 일치하지 않습니다.");
			reg_frm.newPassword.focus();
			return;
		}

		document.reg_frm.submit();

	}
	
</script>
</head>
<body>
	<!-- 로그 및 로그인 -->
    <div class="content">
		<%@ include file="header.jsp" %>
		<!-- 세로 메뉴 -->
		<div class="sidebar">
			<ul>
				<li><a href="${pageContext.request.contextPath}/myProfile_view.do">내 프로필</a>
					<ul>
						<li><a href="${pageContext.request.contextPath}/editProfile.do?id=${ editPassword }">&nbsp;-회원정보 수정</a></li>
						<li><a href="${pageContext.request.contextPath}/editPassword.do?id=${ editPassword }">&nbsp;-<b>비밀번호 변경</b></a></li>
					</ul>
				</li>
				<li><a href="${pageContext.request.contextPath}/petList.do?id=${ editPassword }">반려동물 프로필</a></li>
				<li><a href="${pageContext.request.contextPath}/orderLookup.do?id=${ editPassword }">주문 조회</a></li>
				<li><a href="${pageContext.request.contextPath}/returnExchange.do?id=${ editPassword }">취소/교환/반품</a></li>
			</ul>
		</div>


		<!-- 회원정보 수정 페이지 -->
	    <div class="content">
	        <div class="custom-container">
	            <h1 class="myPage-title">비밀번호 변경</h1>
	
	            <form action="${pageContext.request.contextPath}/updatePassword.do?id=${ editPassword }" method="post" name="reg_frm" class="was-validated" novalidate>
					<div class="form-group">
		                <div class="input-group">
		                	<input type="password" class="form-control" name="password" id="password" size="15" placeholder="기존 비밀번호" required>
		                </div>
		            </div>
		            <div class="form-group">
						<input type="password" class="form-control" name="newPassword" id="newPassword" size="15" placeholder="새 비밀번호"  required>
		            </div>
		            <div class="form-group">
		                <input type="password" class="form-control" name="newPw_check" id="newPw_check" size="15" placeholder="새 비밀번호 확인" required>
		            </div>
		            
		            <!-- Divider -->
		            <hr>
		
		            <!-- 비밀번호 수정, 취소 버튼 -->
		            <div class="btn-container">
		                <button type="button" class="btn btn-warning" onclick="infoConfirm()">수정하기</button>
		            </div>
		            <div class="btn-container">
		                <button type="button" class="btn btn-warning" onclick="javascript:window.location='${pageContext.request.contextPath}/myProfile_view.do'">취소</button>
		            </div>
		        </form>
	
	        </div>
	    </div>
    <!-- Divider -->
 	   <div class="custom-container">
            <hr>
        </div>
    </div>
    
    <!-- 1:1문의 -->
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