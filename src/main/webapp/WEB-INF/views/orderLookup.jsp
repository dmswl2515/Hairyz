<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>반려동물 프로필 목록</title>
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
<script>
function updateOrderState(orderno, state) {
    $.ajax({
        url: 'orderState.do',
        type: 'POST',
        data: { 
        	orderno: orderno, 
            state: state 
        },
        success: function(response) {
            // 서버로부터 응답을 받고 나면 status 갱신
            console.log('Response:', response);
            updateStatusBadge(orderno, state);
            location.reload();
        },
        error: function(xhr, state, error) {
            console.log('Error: ' + error);
        }
    });
}

function updateStatusBadge(orderno, state) {
    let badgeText;
    let badgeClass;
    
    console.log(`Order No: ${orderno}, State: ${state}`);
    
    switch(state) {
        case 1:
            badgeText = '결제완료';
            badgeClass = 'badge-success';
            break;
        case 2:
            badgeText = '배송중';
            badgeClass = 'badge-success';
            break;
        case 3:
            badgeText = '취소';
            badgeClass = 'badge-danger';
            break;
        case 4:
            badgeText = '교환';
            badgeClass = 'badge-warning';
            break;
        case 5:
            badgeText = '반품';
            badgeClass = 'badge-secondary';
            break;
    }

    // 해당 주문의 상태 업데이트
    $(`#status-badge-${orderno}`).removeClass().addClass(`badge ${badgeClass}`).text(badgeText);
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
				<li><a href="myProfile_view.do">내 프로필</a>
					<ul>
						<li><a href="editProfile.do?id=${ member.mb_id }">&nbsp;-회원정보 수정</a></li>
						<li><a href="editPassword.do?id=${ member.mb_id }">&nbsp;-비밀번호 변경</a></li>
					</ul>
				</li>
				<li><a href="petList.do?id=${ member.mb_id }">반려동물 프로필</a></li>
				<li><a href="orderLookup.do?id=${ member.mb_id }"><b>주문 조회</b></a></li>
				<li><a href="#">취소/교환/반품</a></li>
			</ul>
		</div>


		<!-- 주문 조회 -->
	    <div class="content">
	    	<div class="custom-container">
			    <h2 class="text-center my-4">🛒 주문 조회</h2>
			    <table class="table table-hover table-striped table-bordered text-center align-middle">
			        <thead class="thead-dark">
			            <tr>
			                <th>구매 날짜</th>
			                <th>IMAGE</th>
			                <th>상품 이름</th>
			                <th>수량</th>
			                <th>상태</th>
			                <th>기타</th>
			            </tr>
			        </thead>
			        <tbody>
			            <c:choose>
			                <c:when test="${empty orderList}">
			                    <tr>
			                        <td colspan="6" class="text-center text-muted py-4">주문 내용이 없습니다.</td>
			                    </tr>
			                </c:when>
			                <c:otherwise>
			                    <c:forEach var="order" items="${orderList}">
			                        <tr>
			                            <td>${order.orderdate}</td>
			                            <td><img src="${pageContext.request.contextPath}/upload/${order.originalfilename}" alt="사진" class="img-thumbnail" style="width: 80px; height: 80px;"></td>
			                            <td>${order.productname}</td>
			                            <td>${order.orderamount}</td>
			                            <%-- <td><span class="badge badge-success">${order.state}</span></td> --%>
			                            <td>
				                            <c:choose>
											    <c:when test="${order.state == 1}">
											        <span id="status-badge-${order.orderno}" class="badge badge-success">결제완료</span>
											    </c:when>
											    <c:when test="${order.state == 2}">
											        <span id="status-badge-${order.orderno}" class="badge badge-success">배송중</span>
											    </c:when>
											    <c:when test="${order.state == 3}">
											        <span id="status-badge-${order.orderno}" class="badge badge-danger">취소</span>
											    </c:when>
											    <c:when test="${order.state == 4}">
											        <span id="status-badge-${order.orderno}" class="badge badge-warning">교환</span>
											    </c:when>
											    <c:when test="${order.state == 5}">
											        <span id="status-badge-${order.orderno}" class="badge badge-secondary">반품</span>
											    </c:when>
											</c:choose>
										</td>
			                            <td>
			                                <button type="button" class="btn btn-sm btn-outline-danger" onclick="updateOrderState(${order.orderno}, 3)">취소</button>
										    <button type="button" class="btn btn-sm btn-outline-primary" onclick="updateOrderState(${order.orderno}, 4)">교환</button>
										    <button type="button" class="btn btn-sm btn-outline-secondary" onclick="updateOrderState(${order.orderno}, 5)">반품</button>
			                                <button type="button" class="btn btn-sm btn-outline-info">구매평 작성</button>
			                            </td>
			                        </tr>
			                    </c:forEach>
			                </c:otherwise>
			            </c:choose>
			        </tbody>
			    </table>
			</div>
	    </div>
    <!-- Divider -->
 	   <div class="custom-container">
            <hr>
        </div>
    </div>
    
    
    <!-- FOOTER -->
	<%@ include file="footer.jsp" %>
    <!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>