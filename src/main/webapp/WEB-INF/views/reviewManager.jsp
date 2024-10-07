<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>구매평 관리</title>
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

.ellipsis {
    white-space: nowrap;   /* 텍스트를 한 줄로 표시 */
    overflow: hidden;      /* 넘치는 텍스트 숨김 */
    text-overflow: ellipsis; /* 넘치는 텍스트에 ... 표시 */
    max-width: 200px;      /* 원하는 최대 너비 설정 */
    /* display: inline-block; */ /* 요소의 너비를 제한하려면 inline-block 사용 */
}

</style>
</head>
<body>
	<!-- 로그 및 로그인 -->
    <div class="content">
		<%@ include file="header.jsp" %>
		<!-- 세로 메뉴 -->
		<!-- 추가 예정 -->

		<!-- 구매평 관리 -->
	    <div class="content">
	    	<div class="custom-container">
			    <h2 class="text-center my-4">판매 관리</h2>
			    <table class="table table-hover table-striped table-bordered text-center align-middle">
			        <thead class="thead-dark">
			            <tr>
			                <th>번호</th>
			                <th>날짜</th>
			                <th>작성자</th>
			                <th>내용</th>
			                <th>답변 상태</th>
			            </tr>
			        </thead>
			        <tbody>
			            <c:choose>
			                <c:when test="${empty reviewManager}">
			                    <tr>
			                        <td colspan="6" class="text-center text-muted py-4">등록된 구매 평이 없습니다.</td>
			                    </tr>
			                </c:when>
			                <c:otherwise>
			                    <c:forEach var="rm" items="${reviewManager}" varStatus="status">
			                    	 <c:if test="${rm.pr_visibility == 'Y'}">
				                        <tr style="cursor: pointer;" onclick="window.open('reviewReply.do?reviewId=${rm.pr_reviewId}&reviewDate=${rm.pr_reviewDate}&mbName=${rm.pr_MbNnme}&reviewText=${rm.pr_reviewText}', '_blank', 'width=700, height=600, top=50, left=50, scrollbars=yes')">
				                            <td>${rm.pr_reviewId}</td>
				                            <td>${rm.pr_reviewDate}</td>
				                            <td>${rm.pr_MbNnme}</td>
				                            <td class="ellipsis">${rm.pr_reviewText}</td>
				                            <td>
					                            <c:choose>
												    <c:when test="${rm.pr_hasReply == 'Y'}">
												        <span class="badge badge-success">답변 완료</span>
												    </c:when>
												    <c:when test="${rm.pr_hasReply == 'N'}">
												        <span class="badge badge-warning">미답변</span>
												    </c:when>
												</c:choose>
											</td>
				                        </tr>
			                        </c:if>
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
					    if (pageNumber < 1 || pageNumber > ${totalPages}) {
					        return; // 페이지 번호가 범위를 벗어나면 아무 것도 하지 않음
					    }
					    window.location.href = "reviewManager.do?page=" + pageNumber; // 페이지 이동
					}
					</script>

                  </ul>
                </nav>
			</div>
	    </div>
    
    <!-- FOOTER -->
	<%@ include file="footer.jsp" %>
    <!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>