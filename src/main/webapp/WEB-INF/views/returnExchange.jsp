<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>취소/교환/반품</title>
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
}

/* 내용물이 차지할 공간을 유지 */
.content {
	flex: 1;
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
				<li><a href="${pageContext.request.contextPath}/myProfile_view.do">내 프로필</a>
					<ul>
						<li><a href="${pageContext.request.contextPath}/editProfile.do?id=${ member.mb_id }">&nbsp;-회원정보 수정</a></li>
						<li><a href="${pageContext.request.contextPath}/editPassword.do?id=${ member.mb_id }">&nbsp;-비밀번호 변경</a></li>
					</ul>
				</li>
				<li><a href="${pageContext.request.contextPath}/petList.do?id=${ member.mb_id }">반려동물 프로필</a></li>
				<li><a href="${pageContext.request.contextPath}/orderLookup.do?id=${ member.mb_id }">주문 조회</a></li>
				<li><a href="${pageContext.request.contextPath}/returnExchange.do?id=${ member.mb_id }"><b>취소/교환/반품</b></a></li>
			</ul>
		</div>


		<!-- 주문 조회 -->
	    <div class="content">
	    	<div class="custom-container">
			    <h2 class="text-center my-4">취소/교환/반품</h2>
			    <table class="table table-hover table-striped table-bordered text-center align-middle">
			        <thead class="thead-dark">
			            <tr>
			                <th>날짜</th>
			                <th>IMAGE</th>
			                <th>상품이름</th>
			                <th>수량</th>
			                <th>상태</th>
			            </tr>
			        </thead>
			        <tbody>
			            <c:choose>
			                <c:when test="${empty returnExchange}">
			                    <tr>
			                        <td colspan="6" class="text-center text-muted py-4">취소/교환/반품 없습니다.</td>
			                    </tr>
			                </c:when>
			                <c:otherwise>
			                    <c:forEach var="re" items="${returnExchange}">
			                        <tr>
			                            <td>${re.orderdate}</td>
			                            <td><img src="${pageContext.request.contextPath}/upload/${re.changedfilename}" alt="사진" class="img-thumbnail" style="width: 80px; height: 80px;"></td>
			                            <td>${re.productname}</td>
			                            <td>${re.orderamount}</td>
			                            <td>
				                            <c:choose>
											    <c:when test="${re.state == 3}">
											        <span class="badge badge-danger">취소</span>
											    </c:when>
											    <c:when test="${re.state == 4}">
											        <span class="badge badge-warning">교환</span>
											    </c:when>
											    <c:when test="${re.state == 5}">
											        <span class="badge badge-secondary">반품</span>
											    </c:when>
											</c:choose>
										</td>
			                        </tr>
			                    </c:forEach>
			                </c:otherwise>
			            </c:choose>
			        </tbody>
			    </table>
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