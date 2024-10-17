<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>판매 관리</title>
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

</style>
<script>
function updateOrderState(orderno, state) {
	var basePath = '${pageContext.request.contextPath}'; 
    $.ajax({
        url: basePath + '/orderState.do',
        type: 'POST',
        data: { 
        	orderno: orderno, 
            state: state 
        },
        success: function(response) {
            // 서버로부터 응답을 받고 나면 status 갱신
            console.log('Response:', response);
            location.reload();
        },
        error: function(xhr, state, error) {
            console.log('Error: ' + error);
        }
    });
}

</script>
</head>
<body>
	<!-- 로그 및 로그인 -->
    <div class="content">
		<%@ include file="header.jsp" %>
		<!-- 세로 메뉴 -->
		<!-- 추가 예정 -->

		<!-- 판매관리 -->
	    <div class="content">
   			<div style="display: flex;">
   				 <%@ include file="sideMenu.jsp" %>
   				 <div class="content" style="margin-left: 50px;">
			    	<div class="custom-container">
					    <h2 class="text-center my-4">판매 관리</h2>
					    <table class="table table-hover table-striped table-bordered text-center align-middle">
					        <thead class="thead-dark">
					            <tr>
					                <th>상품정보</th>
					                <th>주문일자</th>
					                <th>주문고객</th>
					                <th>주문번호</th>
					                <th>주문금액</th>
					                <th>주문상태</th>
					            </tr>
					        </thead>
					        <tbody>
					            <c:choose>
					                <c:when test="${empty salesManage}">
					                    <tr>
					                        <td colspan="6" class="text-center text-muted py-4">주문 내용이 없습니다.</td>
					                    </tr>
					                </c:when>
					                <c:otherwise>
					                    <c:forEach var="sm" items="${salesManage}">
					                        <tr>
					                            <td><img src="${pageContext.request.contextPath}/upload/${sm.changedfilename}" alt="사진" class="img-thumbnail" style="width: 80px; height: 80px;">&nbsp;${re.orderdate}</td>
					                            <td>${sm.orderdate}</td>
					                            <td>${sm.membername}</td>
					                            <td>${sm.orderno}</td>
					                            <td>${sm.productprice}원</td>
					                            <td>
						                            <c:choose>
													    <c:when test="${sm.state == 1}">
													        <span class="badge badge-success">결제완료</span>
													        <button type="button" class="btn btn-sm btn-outline-warning" style="background-color: #ffc107; color: black;" onclick="updateOrderState(${sm.orderno}, 2)">배송시작</button>
													        <button type="button" class="btn btn-sm btn-outline-warning" style="background-color: #ffc107; color: black;" onclick="updateOrderState(${sm.orderno}, 3)">주문취소</button>
													    </c:when>
													    <c:when test="${sm.state == 2}">
													        <span class="badge badge-success">배송중</span>
													        <button type="button" class="btn btn-sm btn-outline-warning" style="background-color: #ffc107; color: black;" onclick="updateOrderState(${sm.orderno}, 6)">배송완료</button>
													    </c:when>
													    <c:when test="${sm.state == 3}">
													        <span class="badge badge-danger">취소</span>
													    </c:when>
													    <c:when test="${sm.state == 4}">
													        <span class="badge badge-warning">교환</span>
													    </c:when>
													    <c:when test="${sm.state == 5}">
													        <span class="badge badge-secondary">반품</span>
													    </c:when>
													    <c:when test="${sm.state == 6}">
													        <span class="badge badge-success">배송완료</span>
													    </c:when>
													</c:choose>
												</td>
					                        </tr>
					                    </c:forEach>
					                </c:otherwise>
					            </c:choose>
					        </tbody>
					    </table>
					     <!-- 페이징 네비게이션 -->
		                <nav aria-label="Page navigation example">
		                  <ul class="pagination justify-content-center">
		                    <!-- 이전 버튼 -->
							<li class="page-item <c:if test='${currentPage == 1}'>disabled</c:if>">
							    <a class="page-link" href="#" aria-label="Previous" onclick="navigateToPage(${currentPage - 1})">
							        <span aria-hidden="true">&laquo;</span>
							    </a>
							</li>
							
							<!-- 페이지 번호 -->
							<c:forEach var="i" begin="1" end="${totalPages}">
							    <li class="page-item <c:if test='${i == currentPage}'>active</c:if>">
							        <a class="page-link" href="#" onclick="navigateToPage(${i})">${i}</a>
							    </li>
							</c:forEach>
							
							<!-- 다음 버튼 -->
							<li class="page-item <c:if test='${currentPage == totalPages}'>disabled</c:if>">
							    <a class="page-link" href="#" aria-label="Next" onclick="navigateToPage(${currentPage + 1})">
							        <span aria-hidden="true">&raquo;</span>
							    </a>
							</li>
							
							<script>
							function navigateToPage(pageNumber) {
								var basePath = '${pageContext.request.contextPath}'; 
							    if (pageNumber < 1 || pageNumber > ${totalPages}) {
							        return; // 페이지 번호가 범위를 벗어나면 아무 것도 하지 않음
							    }
							    window.location.href = basePath + "salesManagement.do?page=" + pageNumber; // 페이지 이동
							}
							</script>
		
		                  </ul>
		                </nav>
					</div>
				</div>
			</div>
	    </div>
    
    <!-- FOOTER -->
	<%@ include file="footer.jsp" %>
    <!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>