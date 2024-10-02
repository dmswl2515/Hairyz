<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>회원정보 수정</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<!-- 우편번호 검색 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
//우편번호 검색 기능
function searchZipcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 선택한 주소의 우편번호와 주소를 입력
            document.getElementById('zipcode').value = data.zonecode; // 우편번호
            document.getElementById('addr1').value = data.roadAddress; // 도로명 주소
            document.getElementById('addr2').focus(); // 상세주소 입력으로 포커스 이동
        }
    }).open();
}

function previewImage(event) {
	var reader = new FileReader();
	reader.onload = function() {
		var output = document.getElementById('preview-image');
		output.src = reader.result; // 업로드한 파일의 URL을 img 태그에 설정
	};
	reader.readAsDataURL(event.target.files[0]); // 선택된 파일을 읽음
}
</script>
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
						<li><a href="editProfile.do?id=${ editProfile.mb_id }">&nbsp;-<b>회원정보 수정</b></a></li>
						<li><a href="editPassword.do?id=${ editProfile.mb_id }">&nbsp;-비밀번호 변경</a></li>
					</ul>
				</li>
				<li><a href="petList.do?id=${ editProfile.mb_id }">반려동물 프로필</a></li>
				<li><a href="orderLookup.do?id=${ editProfile.mb_id }">주문 조회</a></li>
				<li><a href="returnExchange.do?id=${ editProfile.mb_id }">취소/교환/반품</a></li>
			</ul>
		</div>


		<!-- 회원정보 수정 페이지 -->
	    <div class="content">
	        <div class="custom-container">
	            <h1 class="myPage-title">회원정보 수정</h1>
	
	            <form action="updateProfile.do" method="post" name="reg_frm" class="was-validated" enctype="multipart/form-data">
		            <!-- 프로필 사진 -->
		            <div class="box">
				        <!-- 이미지 미리보기 영역 -->
				        <c:choose>
					        <c:when test="${not empty editProfile.mb_orgname}">
					            <img id="preview-image" class="profile" src="${pageContext.request.contextPath}/upload/${editProfile.mb_orgname}" alt="반려동물 사진">
					        </c:when>
					        <c:otherwise>
					            <img id="preview-image" class="profile" src="images/logo.png" alt="기본 반려동물 사진">
					        </c:otherwise>
					    </c:choose>
				    </div>
				
				    <!-- 파일 업로드 버튼 -->
				    <div class="btn-container text-center mt-3">
					    <!-- 실제 파일 선택 input은 숨김 -->
					    <input type="file" class="form-control-file" name="memberImage" id="memberImage" multiple="true" onchange="previewImage(event)" style="display: none;">
					    
					    <!-- 사용자 정의 버튼 (사진 추가) -->
					    <label for="memberImage" class="btn btn-warning">사진 추가</label>
					    
					    <!-- 미리보기 이미지 업로드 후 파일 이름 숨김 -->
					    <span id="file-name" style="display: none;"></span>
					</div>
					<br>
					<div class="form-group">
		                <div class="input-group">
		                	<input readonly type="text" class="form-control" name="id" id="id" size="20" value="${editProfile.mb_id}" required>
		                </div>
		            </div>
		            <div class="form-group">
						<input readonly type="text" class="form-control" name="name" id="name" size="25" value="${editProfile.mb_name}" required>
		            </div>
		            <div class="form-group">
		                <input type="text" class="form-control" name="nickName" id="nickName" size="40" value="${editProfile.mb_nickname}" required>
		            </div>
		            <div class="form-group">
		                <input type="text" class="form-control" name="phone" id="phone" size="13" value="${editProfile.mb_phone}" required>
		            </div>
		            <div class="form-group">
					    <!-- 우편번호 입력창과 우편번호 검색 버튼 -->
					    <div class="input-group mb-3">
					        <input type="text" class="form-control" name="zipcode" id="zipcode" placeholder="우편번호" size="6" value="${editProfile.mb_zipcode}" required>
					        <div class="input-group-append">
					            <button type="button" class="btn btn-outline-secondary" onclick="searchZipcode()">우편번호 검색</button>
					        </div>
					    </div>
					</div>
					
					<div class="form-group">
					    <!-- 주소 입력창 -->
					    <input type="text" class="form-control" name="addr1" id="addr1" placeholder="주소" value="${editProfile.mb_addr1}" required>
					</div>
					
					<div class="form-group">
					    <!-- 상세 주소 입력창 -->
					    <input type="text" class="form-control" name="addr2" id="addr2" placeholder="상세주소" value="${editProfile.mb_addr2}" required>
					</div>
		            
		            <!-- Divider -->
		            <hr>
		
		            <!-- 회원정보 수정, 로그아웃 버튼 -->
		            <div class="btn-container">
		                <button type="submit" class="btn btn-warning">수정하기</button>
		            </div>
		            <div class="btn-container">
		                <button type="button" class="btn btn-warning" onclick="javascript:window.location='accountDelete.do?id=${ editProfile.mb_id }'">회원탈퇴</button>
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