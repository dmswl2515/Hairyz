<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            <form class="form-inline d-flex justify-content-center">
            	 <select class="form-control mr-2" id="searchCondition">
		            <option value="productName">상품명</option>
		            <option value="productNumber">상품 번호</option>
		        </select>
                <input class="form-control mr-sm-2" type="search" placeholder="통합검색" aria-label="Search" style="width: 30%;">
                <button class="btn btn-outline-warning my-2 my-sm-0" type="submit">검색</button>
            </form>
        </div>
        
<style>
    
    /* 수정& 취소 버튼 넓이 */
    .custom-width {
        width: 200px; /* 원하는 너비로 설정 */
    }
</style>     
		<div class="container">
		    <table class="table table-bordered mb-2">
			  <thead>
			    <tr class="table-warning">
			      <th scope="col">상품번호</th>
			      <th scope="col">상품명</th>
			      <th scope="col">재고</th>
			      <th scope="col">상품관리</th>
			    </tr>
			  </thead>
			  <tbody>
		        <c:forEach var="item" items="${boardPage.content}">
		            <tr>
		                <td>${item.pd_num}</td>
		                <td>
		                    <c:forEach begin="1" end="${item.pd_name}">-</c:forEach>
		                        <c:if test="${item.isnew}">
		                            <span class="badge badge-secondary">New</span>
		                    </c:if>
		                </td>
		                <td>${item.pd_amount}</td>
		                <td>
		                	<input type="button" class="btn btn-outline-warning custom-width mb-2" value="판매 중지"/></br>
			      			<input type="button" class="btn btn-outline-warning custom-width" value="상품 수정"  onclick="window.location.href='p_modify';"/>
		                </td>
		            </tr>
		        </c:forEach>
		     </tbody>
			</table>  	    
			
	        <input type="button" class="btn btn-outline-warning custom-width" value="등록하기"  onclick="window.location.href='p_registration';"/>
       	</div>
       	
       	<!-- 페이지네이션 -->
		<div class="director">
	    <!-- 첫 페이지 -->
	    <c:choose>
	        <c:when test="${currentPage == 1}">
	            <button type="button" class="btn btn-outline-light" disabled>&lt;&lt;</button>
	        </c:when>
	        <c:otherwise>
	            <button type="button" class="btn btn-outline-light" onclick="location.href='list?page=1&bType=${bType}'">&lt;&lt;</button>
	        </c:otherwise>
	    </c:choose>
	
	    <!-- 이전 페이지 -->
	    <c:choose>
	        <c:when test="${currentPage == 1}">
	            <button type="button" class="btn btn-outline-light" disabled>&lt;</button>
	        </c:when>
	        <c:otherwise>
	            <button type="button" class="btn btn-outline-light" onclick="location.href='list?page=${currentPage - 1}&bType=${bType}'">&lt;</button>
	        </c:otherwise>
	    </c:choose>
	
	    <!-- 개별 페이지 -->
	    <c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
	        <c:choose>
	            <c:when test="${currentPage == i}">
	                <button type="button" class="btn btn-outline-light" disabled>${i}</button>
	            </c:when>
	            <c:otherwise>
	                <button type="button" class="btn btn-outline-light" onclick="location.href='list?page=${i}&bType=${bType}'">${i}</button>
	            </c:otherwise>
	        </c:choose>
	    </c:forEach>
	
	    <!-- 다음 페이지 -->
	    <c:choose>
	        <c:when test="${currentPage == totalPages}">
	            <button type="button" class="btn btn-outline-light" disabled>&gt;</button>
	        </c:when>
	        <c:otherwise>
	            <button type="button" class="btn btn-outline-light" onclick="location.href='list?page=${currentPage + 1}&bType=${bType}'">&gt;</button>
	        </c:otherwise>
	    </c:choose>
	
	    <!-- 끝 페이지 -->
	    <c:choose>
	        <c:when test="${currentPage == totalPages}">
	            <button type="button" class="btn btn-outline-light" disabled>&gt;&gt;</button>
	        </c:when>
	        <c:otherwise>
	            <button type="button" class="btn btn-outline-light" onclick="location.href='list?page=${totalPages}&bType=${bType}'">&gt;&gt;</button>
	        </c:otherwise>
	    </c:choose>
		</div>
		<!-- 페이지네이션 -->
		</div>
		
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
