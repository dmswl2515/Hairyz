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
            margin-top: 100px;
            margin-bottom: 20px;
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

<style>
	/* 반려종 버튼 디자인 */
	.category-style {
         width: 90px;
		 height: 40px;
		 margin: 20px 20px 0 20px;
         background-color: #ffffff;
         border: none;
         border-radius: 70%;
         color: gray;
	}	  
	
	/* 카테고리 버튼 디자인 */	    
	.circle-button {
		width: 85px;
		height: 85px;
		background-color: #ffe082;
		border: none;
		border-radius: 50%;
		color: gray;
		justify-content: center;
		cursor: pointer;
		margin: 30px;
	}
	
	.circle-button:hover {
        background-color: #ffc107; /* 호버 시 색상 변화 */
    }
    
    .category-style.selected {
	    color: black;
        outline: 1px solid black;
	}
	
	.circle-button.selected {
	    outline: none; /* 포커스 상태에서 테두리 제거 */
        background-color: #ffc107;
	}
		    
   .custom-hr {
		    border: 1px solid #d8d8d8; 
		    width: 100%;
		    margin-top: 30px !important; 
	}
	
</style>
      	
		<div class="container">
		    <div class="text-center my-4"> 
		        <button class="category-style" onclick="selectCategory(this)">#전체</button> 
		        <button class="category-style" onclick="selectCategory(this)">#강아지</button>
		        <button class="category-style" onclick="selectCategory(this)">#고양이</button>
		    </div>
		    
		   	<div class="text-center my-4"> 
			    <button class="circle-button" onclick="selectCircle(this)">사료</button> 
			    <button class="circle-button" onclick="selectCircle(this)">간식</button>
			    <button class="circle-button" onclick="selectCircle(this)">용품</button>
			    <button class="circle-button" onclick="selectCircle(this)">기타</button>
			</div>

<script>
	function selectCategory(button) {
	    // 모든 카테고리 버튼에서 'selected' 클래스를 제거
	    const categoryButtons = document.querySelectorAll('.category-style');
	    categoryButtons.forEach(btn => {
	        btn.classList.remove('selected');
	    });
	    
	    // 클릭한 버튼에 'selected' 클래스 추가
	    button.classList.add('selected');
	}
	
	function selectCircle(button) {
	    // 모든 원 버튼에서 'selected' 클래스를 제거
	    const circleButtons = document.querySelectorAll('.circle-button');
	    circleButtons.forEach(btn => {
	        btn.classList.remove('selected');
	    });
	    
	    // 클릭한 버튼에 'selected' 클래스 추가
	    button.classList.add('selected');
	}
</script>

<style>
	/*상품목록 디자인 */
	.product-box {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 20px;
            margin: 10px;
            text-align: center;
            width: 170px;
            height: 200px;
    }
        .product-img {
            max-width: 100%;
            height: auto;
    }
    .product-text {
            margin-left: 14px;
            width: 170px;
            
    }
    .product-name {
        font-size: 0.8em;
        overflow-wrap: break-word; /*텍스트 길이 줄바꿈*/
    }

    .product-price {
        font-size: 0.8em; 
        color: #ff9800; 
    }
    
    
</style>
		    
		    <hr class="custom-hr">
		    <div class="container">
		    	<div class="row">
		    		<c:forEach var="item" items="${foodItems}">
		                <div class="col-md-2 mb-3">
		                    <div class="product-box">
		                        <img src="${item.imageUrl}" alt="${item.name}" class="product-img">
		                    </div>
		                    
		                    <div class="product-text">
		                        <h6 class="product-name">${item.name}[로얄캐닌]독 미니 릴렉스 케어</h6>
		                        <p class="product-price">${item.price}16,200원</p>
		                    </div>
		                </div>
	            </c:forEach>
	            <c:forEach var="item" items="${foodItems}">
		                <div class="col-md-2 mb-3">
		                    <div class="product-box">
		                        <img src="${item.imageUrl}" alt="${item.name}" class="product-img">
		                    </div>
		                    
		                    <div class="product-text">
		                        <h6 class="product-name">${item.name}[로얄캐닌]독 미니 릴렉스 케어</h6>
		                        <p class="product-price">${item.price}16,200원</p>
		                    </div>
		                </div>
	            </c:forEach>
	            <c:forEach var="item" items="${foodItems}">
		                <div class="col-md-2 mb-3">
		                    <div class="product-box">
		                        <img src="${item.imageUrl}" alt="${item.name}" class="product-img">
		                    </div>
		                    
		                    <div class="product-text">
		                        <h6 class="product-name">${item.name}[로얄캐닌]독 미니 릴렉스 케어</h6>
		                        <p class="product-price">${item.price}16,200원</p>
		                    </div>
		                </div>
	            </c:forEach>
	            <c:forEach var="item" items="${foodItems}">
		                <div class="col-md-2 mb-3">
		                    <div class="product-box">
		                        <img src="${item.imageUrl}" alt="${item.name}" class="product-img">
		                    </div>
		                    
		                    <div class="product-text">
		                        <h6 class="product-name">${item.name}[로얄캐닌]독 미니 릴렉스 케어</h6>
		                        <p class="product-price">${item.price}16,200원</p>
		                    </div>
		                </div>
	            </c:forEach>
	            <c:forEach var="item" items="${foodItems}">
		                <div class="col-md-2 mb-3">
		                    <div class="product-box">
		                        <img src="${item.imageUrl}" alt="${item.name}" class="product-img">
		                    </div>
		                    
		                    <div class="product-text">
		                        <h6 class="product-name">${item.name}[로얄캐닌]독 미니 릴렉스 케어</h6>
		                        <p class="product-price">${item.price}16,200원</p>
		                    </div>
		                </div>
	            </c:forEach>
	            <c:forEach var="item" items="${foodItems}">
		                <div class="col-md-2 mb-3">
		                    <div class="product-box">
		                        <img src="${item.imageUrl}" alt="${item.name}" class="product-img">
		                    </div>
		                    
		                    <div class="product-text">
		                        <h6 class="product-name">${item.name}[로얄캐닌]독 미니 릴렉스 케어</h6>
		                        <p class="product-price">${item.price}16,200원</p>
		                    </div>
		                </div>
	            </c:forEach>
		    	</div>
		    </div>
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