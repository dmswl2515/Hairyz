<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="content">
		<%@ include file="header.jsp" %>
	</div>
	
	<div class="container">
		<!-- 통합검색 창 -->
        <div class="custom-container my-4">
            <form action="/searchAll" class="form-inline d-flex justify-content-center" onsubmit="return validateForm();">
                <input class="form-control mr-sm-2" id="searchInput" type="text" name="sKeyword" placeholder="통합검색" aria-label="Search" style="width: 30%;">
                <button class="btn btn-outline-warning my-2 my-sm-0" type="submit">검색</button>
            </form>
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
		
		검색결과 : 건
		
		<div id="board-content">
		    <h5><strong>커뮤니티</strong></h5>
		    <hr style="border-color: #ffc107;">
		</div>
			<c:if test="${empty boardList}">
				<div style="display:flex; justify-content: center; align-items: center;">
			        <span class="text-center align-middle mt-5 mb-4">검색결과가 없습니다.</span>
				</div>
			</c:if>
	        <c:forEach var="bList" items="${boardList}">
			    <div style="display: flex; align-items: flex-start;">    
			        <div class="content" style="display: flex; flex-direction: column;">
			            <h5>
			                <span style="font-weight: bold;">
			                    ${bList.bd_title}
			                </span>
			            </h5>
			            <div>
			                ${bList.bd_content}
			            </div>
			            <div>
			                <span style="font-weight:bold; margin-right:15px;">${bList.bd_writer}</span>
			            </div>
			            <div>
			                <span>
			                   ${bList.bd_date}"
			                </span>
			            </div>
			            
			        </div>
			
			        <c:if test="${not empty bList.bd_modname}">
			            <img src="${pageContext.request.contextPath}/upload/${bList.bd_modname}" 
			                 alt="상품 이미지" 
			                 style="width:100px; height:100px; object-fit:cover; margin-left:15px; border-radius: .25rem;">
			        </c:if>
			    </div>
			    <hr style="border-color: #ffc107;">
			</c:forEach>
		
		<div id="shop-content">
		    <h5><strong>쇼핑</strong></h5>
		    <hr style="border-color: #ffc107;">
		</div>
			<c:if test="${empty productList}">
				<div style="display:flex; justify-content: center; align-items: center;">
			        <span class="text-center align-middle mt-5 mb-4">검색결과가 없습니다.</span>
				</div>
			</c:if>
	        <c:forEach var="pList" items="${productList}">
			    <div style="display: flex; align-items: flex-start;">    
			        <div class="content" style="display: flex; flex-direction: column;">
			            <h5>
			                <span style="font-weight: bold;">
			                    ${pList.pdName}
			                </span>
			            </h5>
			            <div>
			                ${pList.pd_price}
			            </div>
			        </div>
			        <p>전체 객체: ${pList}</p> <!-- 객체 내용을 출력해보기 -->
			
			        <c:if test="${not empty pList.pd_chng_fname}">
			            <img src="${pageContext.request.contextPath}/upload/${pList.pd_chng_fname}" 
			                 alt="상품 이미지" 
			                 style="width:100px; height:100px; object-fit:cover; margin-left:15px; border-radius: .25rem;">
			        </c:if>
			    </div>
			    <hr style="border-color: #ffc107;">
			</c:forEach>
	</div>
	
	<%@ include file="kakaoCh.jsp" %>
					
	<%@ include file="footer.jsp" %>
<!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>