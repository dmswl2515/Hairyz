<%@ page import="com.study.springboot.dto.PDto" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 > 상품 관리</title>
<!-- Bootstrap CSS -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<div class="content">
		<%@ include file="header.jsp" %>
	</div>
    <div style="float: left;">
		<%@ include file="sideMenu.jsp" %>
	</div>    
	<style>
	    
	    /* 수정& 취소 버튼 넓이 */
	    .custom-width {
	        width: 100px; /* 원하는 너비로 설정 */
	    }
	    
	    .product-container {
		    display: flex; /* Flexbox를 사용하여 내부 요소를 수평으로 배치 */
		    align-items: center; /* 수직 가운데 정렬 */
		    margin-bottom: 10px; /* 요소 간 간격 조정 */
		}
	    
	    .product-box {
            border: 1px solid #ddd;
            border-radius: 5px;
            margin: 10px;
            text-align: center;
            width: 130px;
            height: 150px;
	            
	    }
	    
	    .align-middle {
		    vertical-align: middle !important; /* 모든 테이블 셀의 내용을 세로로 가운데 정렬 */
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
	
	  .custom-container {
           max-width: 1000px;
           margin: 0 auto;
      }    
	</style>
			
		<div class="custom-container my-4">
			<h3 class="text-center mt-1 mb-4"><strong>상품 관리</strong></h3>
			<!-- 통합검색 창 -->
            <form class="form-inline d-flex justify-content-center" method="get" action="${pageContext.request.contextPath}/p_manage">
                 <select class="form-control mr-2" id="searchCondition" name="condition">
                    <!-- <option value="all" <c:if test="${condition == 'all'}">selected</c:if>>전체</option> -->
                    <option value="productName" <c:if test="${condition == 'productName'}">selected</c:if>>상품명</option>
                    <option value="productNumber" <c:if test="${condition == 'productNumber'}">selected</c:if>>상품 번호</option>
                    
                </select>
                <input class="form-control mr-sm-2" type="search" name="keyword" placeholder="통합검색" aria-label="Search" style="width: 300px;" value="${keyword}">
                <button class="btn btn-warning my-2 my-sm-0" type="submit">검색</button>
            </form>
        </div>     
	
		<div class="container">
		    <table class="table table-hover table-striped table-bordered text-center align-middle mb-2">
		        <thead class="thead-dark">
		            <tr>
		                <th scope="col">상품번호</th>
		                <th scope="col">상품명</th>
		                <th scope="col">재고</th>
		                <th scope="col">상품관리</th>
		            </tr>
		        </thead>
		        <tbody>
		            <c:forEach var="item" items="${products}">
		            	<input type="hidden" name="pdNum" value="${item.pdNum}" />
		                <tr>
		                    <td class="text-center align-middle">${item.pdNum}</td>
		                    <td>
		                        <div class="product-container">    
		                            <div class="product-box">
		                            <a href="${pageContext.request.contextPath}/p_details?pdNum=${item.pdNum}" style="color: black;">
		                                 <img src="${pageContext.request.contextPath}/upload/${item.pd_chng_fname}" alt="${item.pdName}" style="width:100%; height:100%; object-fit:cover;">
		                            </a>
		                            </div>
		                            <a href="${pageContext.request.contextPath}/p_details?pdNum=${item.pdNum}" style="color: black;"> 
		                            	<span>
		                            		${item.pdName}
		                            	</span>
		                            </a>
		                            
		                        </div>     
		                    </td>
		                    <td class="text-center align-middle">${item.pd_amount}개</td>
		                    <td class="text-center align-middle">
		                        <form method="post" action="/updateSellingStatus" id="sellingForm" onsubmit="return submit_form();">
								    <input type="hidden" name="pdNum" value="${item.pdNum}" />
								    <c:choose>
									    <c:when test="${fn:contains(item.pd_selling, 'Y')}">
									        <input type="button" id="toggleSellingButton" class="btn btn-danger custom-width mb-2"
									               value="판매 중지" onclick="submit_form('${item.pdNum}', 'Y')"/>
									    </c:when>
									    <c:when test="${fn:contains(item.pd_selling, 'N')}">
									        
									        <input type="button" id="toggleSellingButton" class="btn btn-warning custom-width mb-2"
									               value="판매 재시작" style="text-align: center; padding-right: 95px;" onclick="submit_form('${item.pdNum}', 'N')"/>
									    </c:when>
									</c:choose>
									<script>
								        function submit_form(pdNum, action) {
								        	
								        	var sellStatus = action === 'Y' ? 'N' : 'Y';
								        	
								            // AJAX 요청을 여기에 추가
								            console.log("pdNum: " + pdNum + ", Action: " + action);
								            console.log(sellStatus)
								            
								            $.ajax({
								    			url:'/updateSellingStatus',
								    			type:'POST',
								    			data:{pdNum : pdNum, sellStatus : sellStatus},
								    			dataType: 'json',
								    			success: function(result) {
								                    console.log(result); // 응답 확인
								                    if (result.status === "success") {
								                        alert(result.message);
								                        location.reload();
								                    } else {
								                        alert("Error: " + result.message);
								                    }
								                },
								                error: function(xhr, status, error) {
								                    console.error("AJAX Error: " + status + " - " + error);
								                    alert("AJAX Error: " + status + " - " + error);
								                }
								            });
								        }
								    </script>
								</form>
		                        <br>
		                        
		                        <input type="button" class="btn btn-warning custom-width" 
		                        value="상품 수정" 
		                        onclick="window.location.href='p_modify?page=${currentPage}&pdNum=${item.pdNum}';"/>
		                    </td>
		                </tr>
		            </c:forEach>
		        </tbody>
		    </table>   	    
		<div class="container d-flex justify-content-end">
	        <input type="button" class="btn btn-secondary custom-width" value="등록하기"  onclick="window.location.href='p_registration';"/>
       	</div>
       	</div>
		
       	<!-- 페이지네이션 -->
		<div class="director">
	    <!-- 첫 페이지 -->
	    <c:choose>
	        <c:when test="${currentPage == 1}">
	            <button type="button" class="btn page-button" style="color:gray;" disabled>&lt;&lt;</button>
	        </c:when>
	        <c:otherwise>
	            <button type="button" class="btn page-button" style="color:gray;" onclick="location.href='p_manage?page=1&condition=${condition}&keyword=${keyword}'">&lt;&lt;</button>
	        </c:otherwise>
	    </c:choose>
	
	    <!-- 이전 페이지 -->
	    <c:choose>
	        <c:when test="${currentPage == 1}">
	            <button type="button" class="btn page-button" style="color:gray;" disabled>&lt;</button>
	        </c:when>
	        <c:otherwise>
	            <button type="button" class="btn page-button" style="color:gray;" onclick="location.href='p_manage?page=${currentPage - 1}&condition=${condition}&keyword=${keyword}'">&lt;</button>
	        </c:otherwise>
	    </c:choose>
	
	    <!-- 개별 페이지 -->
	    <c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
	        <c:choose>
	            <c:when test="${currentPage == i}">
	                <button type="button" class="btn page-button" style="color:gray;" disabled>${i}</button>
	            </c:when>
	            <c:otherwise>
	                <button type="button" class="btn page-button" style="color:gray;" onclick="location.href='p_manage?page=${i}&condition=${condition}&keyword=${keyword}'">${i}</button>
	            </c:otherwise>
	        </c:choose>
	    </c:forEach>
	
	    <!-- 다음 페이지 -->
	    <c:choose>
	        <c:when test="${currentPage == totalPages}">
	            <button type="button" class="btn page-button" style="color:gray;" disabled>&gt;</button>
	        </c:when>
	        <c:otherwise>
	            <button type="button" class="btn page-button" style="color:gray;" onclick="location.href='p_manage?page=${currentPage + 1}&condition=${condition}&keyword=${keyword}'">&gt;</button>
	        </c:otherwise>
	    </c:choose>
	
	    <!-- 끝 페이지 -->
	    <c:choose>
	        <c:when test="${currentPage == totalPages}">
	            <button type="button" class="btn page-button" style="color:gray;" disabled>&gt;&gt;</button>
	        </c:when>
	        <c:otherwise>
	            <button type="button" class="btn page-button" style="color:gray;" onclick="location.href='p_manage?page=${totalPages}&condition=${condition}&keyword=${keyword}'">&gt;&gt;</button>
	        </c:otherwise>
	    </c:choose>
		</div>
		<!-- 페이지네이션 -->
		
		<!-- Divider -->
        <div class="custom-container">
            <hr>
        </div>
    
    
    <!-- FOOTER -->
    <footer class="container">
        <p class="float-end"><strong>털뭉치즈</strong></p>
        <p>COMPANY : 털뭉치즈</p>
    </footer>
    
    
<!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
