<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html>
<head>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

<meta charset="UTF-8">
<title>관리자_Q&A 관리</title>
</head>
<body>
	<div class="content">
		<%@ include file="header.jsp" %>
	</div>
	<div style="float: left;">
		<%@ include file="sideMenu.jsp" %>
	</div>	
<style>

  
  .product-container {
	  display: flex; /* 수평정렬 */
	  align-items: flex-start; /*상단정렬*/
	  white-space: nowrap; /* 줄바꿈 방지*/ 
	  width: 260px;
  }

	/* 페이지네이션 */
	.director {
	    display: flex; /* Flexbox 레이아웃 사용 */
	    justify-content: center; /* 수평 가운데 정렬 */
	    align-items: center; /* 수직 가운데 정렬 */
	    height: 10vh; /* 뷰포트 전체 높이를 기준으로 가운데 정렬 */
	}
	
	.page-button {
			background-color: #ffffff;
			border: 1px solid #d3d3d3;
			color: #000000;
			justify-content: center;
			cursor: pointer;
		}
		
	.page-button:hover {
	        background-color: #0d6efd; /* 호버 시 색상 변화 */
	        color: #000000;
	    }
</style>
	
	<div class="container">
		<h3 class="text-center mt-5 mb-4"><strong>Q&A 관리</strong></h3>
		<table class="table table-hover table-striped table-bordered text-center align-middle mb-2">
			  <thead class="thead-dark">
			    <tr>
			      <th scope="col">번호</th>
			      <th scope="col">상품번호</th>
			      <th scope="col">날짜</th>
			      <th scope="col">작성자</th>
			      <th scope="col">내용</th>
			      <th scope="col">답변 상태</th>
			    </tr>
			  </thead>
		      <tbody>
	        	<c:if test="${empty qnaList}">
				    <tr>
				        <td colspan="5" class="text-center align-middle">등록된 문의 내용이 없습니다.</td>
				    </tr>
				</c:if>
				
				<c:if test="${not empty qnaList}">
		        	<c:forEach var="qList" items="${qnaList}" varStatus="status">
			            <tr>
			                <td class="text-center align-middle">
			                	<span>${(currentPage - 1) * pageSize + status.index + 1}</span> <!-- 순서대로 숫자 표시 -->
				                <input type="hidden" value="${qList.qna_no}">
							</td>
			                <td class="text-center align-middle">
			                	<a href="${pageContext.request.contextPath}/p_details?pdNum=${qList.qna_pnum}" style="color: black;">
			                		${qList.qna_pnum}
			                	</a>	
			                </td>
							<td class="text-center align-middle">
	                            <fmt:formatDate value="${qList.qna_date}" pattern="yyyy-MM-dd" />        
	                        </td>        
	                        <td class="text-center align-middle">${qList.qna_name}</td>
	                        <td onclick="window.open('qnaReply.do?qnaNo=${qList.qna_no}&number=${(currentPage - 1) * pageSize + status.index + 1}&qnaDate=${qList.qna_date}&qnaName=${qList.qna_name}&qnaContent=${qList.qna_content}', '_blank', 'width=700, height=600, top=50, left=50, scrollbars=yes')" style="cursor: pointer;">
	                            <div class="product-container">    
                                    <c:choose>
								        <c:when test="${fn:length(qList.qna_content) > 23}">
								            ${fn:substring(qList.qna_content, 0, 23)}... <!-- 글자 수가 10을 초과하면 자르고 "..."을 추가 -->
								        </c:when>
								        <c:otherwise>
								            ${qList.qna_content} <!-- 글자 수가 10 이하인 경우 그대로 출력 -->
								        </c:otherwise>
								    </c:choose>
								    
								    &nbsp;&nbsp;			                                    
	                                <div style="display: inline-block; vertical-align: middle; margin-top: 1px;">
	                                    <c:if test="${qList.qna_qstate == '비공개'}">
	                                        <i class="fas fa-lock"></i>&nbsp;&nbsp;
	                                    </c:if>
	                                    
	                                    <c:if test="${qList.isNew()}">
	                                        <span class="badge badge-secondary" style="vertical-align: middle;">New</span>
	                                    </c:if>
	                                </div>
	                            </div>     
	                        </td>
	                        
	                        <td class="text-center align-middle">
				                <c:choose>
							        <c:when test="${qList.qna_rstate == 'N'}">
							            미답변
							        </c:when>
							        <c:when test="${qList.qna_rstate == 'Y'}">
							            답변 완료
							        </c:when>
							    </c:choose>
							</td>
	                    </tr>
	              	</c:forEach>
	          	</c:if>    
	     	</tbody>
		</table> 
	</div>
	
	<!-- 페이지네이션 -->
		<div class="director">
	    <!-- 첫 페이지 -->
	    <c:choose>
	        <c:when test="${currentPage == 1}">
	            <button type="button" class="btn page-button" style="color:gray;" disabled>&lt;&lt;</button>
	        </c:when>
	        <c:otherwise>
	            <button type="button" class="btn page-button" style="color:gray;" onclick="location.href='${pageContext.request.contextPath}/admin_qna.do?page=1&pageSize=${pageSize}'">&lt;&lt;</button>
	        </c:otherwise>
	    </c:choose>
	
	    <!-- 이전 페이지 -->
	    <c:choose>
	        <c:when test="${currentPage == 1}">
	            <button type="button" class="btn page-button" style="color:gray;" disabled>&lt;</button>
	        </c:when>
	        <c:otherwise>
	            <button type="button" class="btn page-button" style="color:gray;" onclick="location.href='${pageContext.request.contextPath}/admin_qna.do?page=${currentPage - 1}&pageSize=${pageSize}'">&lt;</button>
	        </c:otherwise>
	    </c:choose>
	
	    <!-- 개별 페이지 -->
	    <c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
	        <c:choose>
	            <c:when test="${currentPage == i}">
	                <button type="button" class="btn page-button" style="color:gray;" disabled>${i}</button>
	            </c:when>
	            <c:otherwise>
	                <button type="button" class="btn page-button" style="color:gray;" onclick="location.href='${pageContext.request.contextPath}/admin_qna.do?page=${i}&pageSize=${pageSize}'">${i}</button>
	            </c:otherwise>
	        </c:choose>
	    </c:forEach>
	
	    <!-- 다음 페이지 -->
	    <c:choose>
	        <c:when test="${currentPage == totalPages}">
	            <button type="button" class="btn page-button" style="color:gray;" disabled>&gt;</button>
	        </c:when>
	        <c:otherwise>
	            <button type="button" class="btn page-button" style="color:gray;" onclick="location.href='${pageContext.request.contextPath}/admin_qna.do?page=${currentPage + 1}&pageSize=${pageSize}'">&gt;</button>
	        </c:otherwise>
	    </c:choose>
	
	    <!-- 끝 페이지 -->
	    <c:choose>
	        <c:when test="${currentPage == totalPages}">
	            <button type="button" class="btn page-button" style="color:gray;" disabled>&gt;&gt;</button>
	        </c:when>
	        <c:otherwise>
	            <button type="button" class="btn page-button" style="color:gray;" onclick="location.href='${pageContext.request.contextPath}/admin_qna.do?page=${totalPages}&pageSize=${pageSize}'">&gt;&gt;</button>
	        </c:otherwise>
	    </c:choose>
		</div>
		<!-- 페이지네이션 -->
					
	<%@ include file="footer.jsp" %>
<!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>