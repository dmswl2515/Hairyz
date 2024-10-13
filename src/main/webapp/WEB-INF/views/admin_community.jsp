<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

<meta charset="UTF-8">
<title>관리자_커뮤니티 관리</title>
</head>
<body>
	<div class="content">
		<%@ include file="header.jsp" %>
	</div>
	
<style>
	.table {
     border-color: #ffc107; /* 테이블 테두리 색상 */
     border-collapse: collapse;
  }

  .table th{
  	  background-color: #fff9c4;
  }
  
  .table td {
      border-color: #ffc107; /* 테이블 헤더와 셀 테두리 색상 */
  }
  
  .table thead th {
      border-bottom: 1px solid #ffcc00;
  }
  
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
			background-color: #ffe082;
			border: 1px solid #ffc107;
			color: gray;
			justify-content: center;
			cursor: pointer;
		}
		
	.page-button:hover {
	        background-color: #ffc107; /* 호버 시 색상 변화 */
	    }
</style>
	
	<div class="container">
		<h3 class="text-center mt-5 mb-4"><strong>커뮤니티 관리</strong></h3>
		<table class="table table-bordered mb-2">
			  <thead>
			    <tr class="table-warning text-center">
			      <th class="text-center align-middle">
			      	<div class="d-flex justify-content-center align-items-center" style="height: 100%; margin-left:10px;">
	                      <input class="form-check-input" type="checkbox" id="selectAll">
	                  </div>
			      </th>	
			      <th scope="col">번호</th>
			      <th scope="col">카테고리</th>
			      <th scope="col">제목</th>
			      <th scope="col">작성자</th>
			      <th scope="col">날짜</th>
			    </tr>
			  </thead>
		      <tbody>
	        	<c:if test="${empty communityList}">
				    <tr>
				        <td colspan="5" class="text-center align-middle">등록된 게시글이 없습니다.</td>
				    </tr>
				</c:if>
				
				<c:if test="${not empty communityList}">
		        	<c:forEach var="cList" items="${communityList}" varStatus="status">
			            <tr>
			            	<td class="text-center align-middle">
				                <div class="d-flex justify-content-center align-items-center" style="height: 100%; margin-left:10px;">
				                    <input class="form-check-input selectEach" type="checkbox" name="eachCheckBox" value="${cList.bd_no}">
				                </div>
								<script>
								  // 'selectAll' 체크박스를 통해 개별 체크박스를 모두 선택하거나 해제
								  document.getElementById('selectAll').addEventListener('change', function() {
								    const isChecked = this.checked;
								    const checkboxes = document.querySelectorAll('.selectEach');
								    
								    checkboxes.forEach(function(checkbox) {
								      checkbox.checked = isChecked;
								      
								    });
								  });
								</script>
							</td>
			                <td class="text-center align-middle">
			                	<span>${(currentPage - 1) * pageSize + status.index + 1}</span> <!-- 순서대로 숫자 표시 -->
				                <input type="hidden" value="${cList.bd_no}">
							</td>
							<td class="text-center align-middle">
			                	<span>
			                		<c:choose>
								        <c:when test="${cList.bd_cate == 'f'}">자유</c:when>
								        <c:when test="${cList.bd_cate == 'q'}">질문</c:when>
							        </c:choose>
			                	</span>
			                </td>
			                <td class="text-center align-middle">
			                	<a href="post_view.do/${cList.bd_no}" style="color: black;">
			                		${cList.bd_title}
			                	</a>	
			                </td>
			                <td class="text-center align-middle">${cList.bd_writer}</td>
							<td class="text-center align-middle">
	                            <fmt:formatDate value="${cList.bd_date}" pattern="yyyy-MM-dd" />        
	                        </td>
	                    </tr>
	              	</c:forEach>
	          	</c:if>    
	     	</tbody>
		</table> 
	</div>
	
	<div class="container d-flex justify-content-end">
	        <input type="button" class="btn btn-outline-warning custom-width page-button" value="선택항목 숨기기"/>
    </div>
    
    <script>
	 	// "선택항목 숨기기" 버튼 클릭 시 체크된 항목을 서버로 전송
	    document.querySelector(".btn.btn-outline-warning.custom-width.page-button").addEventListener("click", function() {
	        const selectedItems = [];
	
	        const checkboxes = document.querySelectorAll(".selectEach:checked");
	       	console.log("checkboxes : " + checkboxes);
	
	        checkboxes.forEach(checkbox => {
	            selectedItems.push(parseInt(checkbox.value)); // 체크된 bd_no를 배열에 추가
	        });
	
	        if (selectedItems.length > 0) {
	            // AJAX 요청으로 서버에 숨길 항목들 전달
	            fetch('/hideCommunityPosts', {
	                method: 'POST',
	                headers: {
	                    'Content-Type': 'application/json',
	                },
	                body: JSON.stringify({ bdNos: selectedItems }), // 체크된 bd_no 전달
	            })
	            .then(response => response.json())
	            .then(data => {
	                if (data.success) {
	                    alert('선택된 항목이 숨겨졌습니다.');
	                    location.reload(); // 페이지 새로고침
	                } else {
	                    alert('항목 숨기기에 실패했습니다.');
	                }
	            })
	            .catch(error => {
	                console.error('Error:', error);
	            });
	        } else {
	            alert('숨길 항목을 선택하세요.');
	        }
	    });
    </script>
	
	<!-- 페이지네이션 -->
		<div class="director">
	    <!-- 첫 페이지 -->
	    <c:choose>
	        <c:when test="${currentPage == 1}">
	            <button type="button" class="btn page-button" style="color:gray;" disabled>&lt;&lt;</button>
	        </c:when>
	        <c:otherwise>
	            <button type="button" class="btn page-button" style="color:gray;" onclick="location.href='admin_community.do?page=1&pageSize=${pageSize}'">&lt;&lt;</button>
	        </c:otherwise>
	    </c:choose>
	
	    <!-- 이전 페이지 -->
	    <c:choose>
	        <c:when test="${currentPage == 1}">
	            <button type="button" class="btn page-button" style="color:gray;" disabled>&lt;</button>
	        </c:when>
	        <c:otherwise>
	            <button type="button" class="btn page-button" style="color:gray;" onclick="location.href='admin_community.do?page=${currentPage - 1}&pageSize=${pageSize}'">&lt;</button>
	        </c:otherwise>
	    </c:choose>
	
	    <!-- 개별 페이지 -->
	    <c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
	        <c:choose>
	            <c:when test="${currentPage == i}">
	                <button type="button" class="btn page-button" style="color:gray;" disabled>${i}</button>
	            </c:when>
	            <c:otherwise>
	                <button type="button" class="btn page-button" style="color:gray;" onclick="location.href='admin_community.do?page=${i}&pageSize=${pageSize}'">${i}</button>
	            </c:otherwise>
	        </c:choose>
	    </c:forEach>
	
	    <!-- 다음 페이지 -->
	    <c:choose>
	        <c:when test="${currentPage == totalPages}">
	            <button type="button" class="btn page-button" style="color:gray;" disabled>&gt;</button>
	        </c:when>
	        <c:otherwise>
	            <button type="button" class="btn page-button" style="color:gray;" onclick="location.href='admin_community.do?page=${currentPage + 1}&pageSize=${pageSize}'">&gt;</button>
	        </c:otherwise>
	    </c:choose>
	
	    <!-- 끝 페이지 -->
	    <c:choose>
	        <c:when test="${currentPage == totalPages}">
	            <button type="button" class="btn page-button" style="color:gray;" disabled>&gt;&gt;</button>
	        </c:when>
	        <c:otherwise>
	            <button type="button" class="btn page-button" style="color:gray;" onclick="location.href='admin_community.do?page=${totalPages}&pageSize=${pageSize}'">&gt;&gt;</button>
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