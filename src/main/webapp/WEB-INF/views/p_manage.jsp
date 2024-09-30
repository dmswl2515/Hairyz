<%@ page import="com.study.springboot.dto.PDto" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 목록</title>
<!-- Bootstrap CSS -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
            border: 1px solid #d8d8d8;
            width: 100%;
            margin-top: 100px
        }

        .custom-container {
            max-width: 1000px;
            margin: 0 auto;
        }

        .logo-container {
            text-align: center;
        }

        .logo-container img {
            max-width: 100px;
            margin-left: 250px; 
        }

    </style>
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
					<%
					//아이디 취득 후 id가 Null인지 확인
					String id = (String)session.getAttribute("id");
					if (id == null)
					{
					%>
                    	<a href="#" class="btn btn-outline-warning">로그인</a>
                    <%}else{%>
                    	<a href="#" class="btn btn-outline-warning">마이페이지</a>
                    	<a href="#" class="btn btn-outline-warning">장바구니</a>
                    <%} %>
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
        
        <!-- 통합검색 창 -->
        <div class="custom-container my-4">
            <form class="form-inline d-flex justify-content-center" method="get" action="${pageContext.request.contextPath}/p_manage">
            	 <select class="form-control mr-2" id="searchCondition" name="condition">
		            <option value="all" <c:if test="${condition == 'all'}">selected</c:if>>전체</option>
		            <option value="productName" <c:if test="${condition == 'productName'}">selected</c:if>>상품명</option>
		            <option value="productNumber" <c:if test="${condition == 'productNumber'}">selected</c:if>>상품 번호</option>
		        	
		        </select>
                <input class="form-control mr-sm-2" type="search" name="keyword" placeholder="통합검색" aria-label="Search" style="width: 30%;" value="${keyword}">
                <button class="btn btn-outline-warning my-2 my-sm-0" type="submit">검색</button>
            </form>
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
	
	.table {
      border-color: #ffc107; /* 테이블 테두리 색상 */
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
	
	.table-white {
		background-color: #ffffff;
	}
	
	.table-bottom-border {
	    border-bottom: 1px solid #ffc107; /* 원하는 색상과 두께로 테두리 설정 */
	}
	
</style>     
		<div class="container">
		    <table class="table table-bordered mb-2">
		        <thead>
		            <tr class="table-warning text-center">
		                <th scope="col">상품번호</th>
		                <th scope="col">상품명</th>
		                <th scope="col">재고</th>
		                <th scope="col">상품관리</th>
		            </tr>
		        </thead>
		        <tbody>
		            <c:forEach var="item" items="${products}">
		                <tr>
		                    <td class="text-center align-middle">${item.pdNum}</td>
		                    <td>
		                        <div class="product-container">    
		                            <div class="product-box">
		                                 <img src="${pageContext.request.contextPath}/upload/${item.pd_chng_fname}" alt="${item.pdName}" style="width:100%; height:100%; object-fit:cover;">
		                            </div> 
		                            ${item.pdName}
		                            
		                        </div>     
		                    </td>
		                    <td class="text-center align-middle">${item.pd_amount}개</td>
		                    <td class="text-center align-middle">
		                        <input type="button" class="btn btn-outline-warning custom-width mb-2" value="판매 중지"/>
		                        <br>
		                        <input type="button" class="btn btn-outline-warning custom-width" 
		                        value="상품 수정" 
		                        onclick="window.location.href='p_modify?pdNum=${item.pdNum}';"/>
		                    </td>
		                </tr>
		            </c:forEach>
		        </tbody>
		    </table>   	    
		<div class="container d-flex justify-content-end">
	        <input type="button" class="btn btn-outline-warning custom-width" value="등록하기"  onclick="window.location.href='p_registration';"/>
       	</div>
       	</div>
       	
       	<!-- 페이지네이션 -->
       	<div class="director">
		    <!-- 첫 페이지 -->
		    <c:choose>
		        <c:when test="${currentPage == 1}">
		            <button type="button" class="btn btn-outline-warning" disabled>&lt;&lt;</button>
		        </c:when>
		        <c:otherwise>
		            <button type="button" class="btn btn-outline-warning" onclick="location.href='p_manage?page=1&condition=${condition}&keyword=${keyword}'">&lt;&lt;</button>
		        </c:otherwise>
		    </c:choose>
		
		    <!-- 이전 페이지 -->
		    <c:choose>
		        <c:when test="${currentPage == 1}">
		            <button type="button" class="btn btn-outline-warning" disabled>&lt;</button>
		        </c:when>
		        <c:otherwise>
		            <button type="button" class="btn btn-outline-warning" onclick="location.href='p_manage?page=${currentPage - 1}&condition=${condition}&keyword=${keyword}'">&lt;</button>
		        </c:otherwise>
		    </c:choose>
		
		    <!-- 개별 페이지 -->
		    <c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
		        <c:choose>
		            <c:when test="${currentPage == i}">
		                <button type="button" class="btn btn-outline-warning" disabled>${i}</button>
		            </c:when>
		            <c:otherwise>
		                <button type="button" class="btn btn-outline-warning" onclick="location.href='p_manage?page=${i}&condition=${condition}&keyword=${keyword}'">${i}</button>
		            </c:otherwise>
		        </c:choose>
		    </c:forEach>
		
		    <!-- 다음 페이지 -->
		    <c:choose>
		        <c:when test="${currentPage == totalPages}">
		            <button type="button" class="btn btn-outline-warning" disabled>&gt;</button>
		        </c:when>
		        <c:otherwise>
		            <button type="button" class="btn btn-outline-warning" onclick="location.href='p_manage?page=${currentPage + 1}&condition=${condition}&keyword=${keyword}'">&gt;</button>
		        </c:otherwise>
		    </c:choose>
		
		    <!-- 끝 페이지 -->
		    <c:choose>
		        <c:when test="${currentPage == totalPages}">
		            <button type="button" class="btn btn-outline-warning" disabled>&gt;&gt;</button>
		        </c:when>
		        <c:otherwise>
		            <button type="button" class="btn btn-outline-warning" onclick="location.href='p_manage?page=${totalPages}&condition=${condition}&keyword=${keyword}'">&gt;&gt;</button>
		        </c:otherwise>
		    </c:choose>
		</div>
		<!-- 페이지네이션 -->
		
<style>
/* 페이지네이션 */
.director {
    display: flex; /* Flexbox 레이아웃 사용 */
    justify-content: center; /* 수평 가운데 정렬 */
    align-items: center; /* 수직 가운데 정렬 */
    height: 10vh; /* 뷰포트 전체 높이를 기준으로 가운데 정렬 */
}
</style>
       	
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
