<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

<meta charset="UTF-8">
<title>통합검색</title>
</head>
<body>
	<div class="content">
		<%@ include file="header.jsp" %>
	</div>
	
<style>

	.contents {
		margin-left : 20px;
		margin-right : 20px;
	}
	
	.container {
		width: 40%;
	}
	
	.black-link {
	    color: black;
	    text-decoration: none !important;
	}
	
	.black-link:hover {
	    color: gray; 
	    outline: none; 
	}
	
	.none-search
	{
		display:flex; 
		justify-content: center; 
		align-items: center; 
		height: 100px; 
		margin-bottom: 50px;
	}
	

</style>
	
	<div class="container" style="width:100%;">
		<!-- 통합검색 창 -->
        <div class="custom-container my-4">
            <form action="/searchAll" class="form-inline d-flex justify-content-center" onsubmit="return validateForm();">
                <input class="form-control mr-sm-2" id="searchInput" type="text" name="sKeyword" placeholder="통합검색" aria-label="Search" style="width: 30%;">
                <button class="btn btn-outline-warning my-2 my-sm-0" type="submit">검색</button>
            </form>
        </div>
   </div>
        <script>
		    function validateForm() {
		        const input = document.getElementById('searchInput');
		        if (input.value.trim() === '') {
		            alert('검색어를 입력해주세요');
		            return false; // 폼 제출을 중단합니다.
		        }
		        return true; // 폼을 정상적으로 제출합니다.
		    }
		</script>
		
		
	<div class="container">
		<div style="display: flex; justify-content: flex-end; align-items: center;">
        <span>검색결과 : ${totalCount}건</span>
    	</div>
		<hr style="border-color: #ffc107; border-width: 5px;">
		<div class="contents" id="board-content">
		    <div>
		    	<h5 style="display: flex; justify-content: space-between; align-items: center;">
		    		<strong>커뮤니티</strong>
		    		<a href="list.do" style="font-size: smaller; font-weight: normal; margin-left: auto; color:gray;">더보기 +</a>
		    	</h5>
		    </div>
		    <hr style="border-color: #ffc107; margin-left:-20px; margin-right:-20px;">
			<c:if test="${empty boardList}">
				<div class="none-search">
			        <span class="text-center align-middle mt-5 mb-4">검색결과가 없습니다.</span>
				</div>
			</c:if>
	        <c:forEach var="bList" items="${boardList}">
			    <div style="display: flex; align-items: flex-start;">    
			        <div class="content" style="display: flex; flex-direction: column;">
			            <a href="post_view.do/${bList.bd_no}" class="black-link">
			            <h5>
			                <span style="font-weight: bold;">
			                    ${bList.bd_title}
			                </span>
			            </h5>
			            <div class="mt-2 mb-4">
			                <span>${bList.bd_content_delimg}</span>
			            </div>
			            <div>
			                <span style="font-weight:bold; margin-right:15px;">${bList.bd_writer}</span>
			                <span><fmt:formatDate value="${bList.bd_date}" pattern="yyyy-MM-dd" /></span>
			            </div>
			            
			        </div>
					<c:set var="imageUrl" value="${bList.extractImageUrl()}" />
					<c:if test="${not empty imageUrl}">
					    <img src="${imageUrl}" alt="썸네일" style="width:100px; height:100px; object-fit:cover; margin-left:15px; border-radius: .25rem;" >
					</c:if>
			        </a>
			    </div>
			    <hr style="border-color: #ffc107;" >
			</c:forEach>
		</div>
		
		<hr style="border-color: #ffc107; border-width: 5px;">
		<div class="contents" id="shop-content">
		    <h5 style="display: flex; justify-content: space-between; align-items: center;">
		    	<strong>쇼핑</strong>
		    		<a href="s_main" style="font-size: smaller; font-weight: normal; margin-left: auto; color:gray;">더보기 +</a>
		    </h5>
		    <hr style="border-color: #ffc107; margin-left:-20px; margin-right:-20px;">
			
			<c:if test="${empty productList}">
				<div style="display:flex; justify-content: center; align-items: center;">
			        <span class="text-center align-middle mt-5 mb-4">검색결과가 없습니다.</span>
				</div>
			</c:if>
			
			<c:if test="${not empty productList}">
	        <c:forEach var="pList" items="${productList}">
			    <div style="display: flex; align-items: flex-start;">    
			        <div class="content" style="display: flex; flex-direction: column;">
			            <a href="p_details?pdNum=${pList.pdNum}" class="black-link">
			            <h5>
			                <span style="font-weight: bold;">
			                    ${pList.pdName}
			                </span>
			            </h5>
			            <div class="mt-5";>
			                <fmt:formatNumber value="${pList.pd_price}" type="number" groupingUsed="true" />원
			            </div>
			        </div>
			        <c:if test="${not empty pList.pd_chng_fname}">
			        	
				            <img src="${pageContext.request.contextPath}/upload/${pList.pd_chng_fname}" 
				                 alt="상품 이미지" 
				                 style="width:100px; height:100px; object-fit:cover; margin-left:15px; border-radius: .25rem;">
			          </a>
			        </c:if>   
			    </div>
			    <hr style="border-color: #ffc107; margin-left:-20px; margin-right:-20px;">
			</c:forEach>
			</c:if>
		</div>
		<hr style="border-color: #ffc107; border-width: 5px;">
	</div>
	
	<%@ include file="kakaoCh.jsp" %>
					
	<%@ include file="footer.jsp" %>
<!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>