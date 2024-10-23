<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<% 
    String pdAnimal = (String) request.getParameter("pd_animal");
    String pdCategory = (String) request.getParameter("pd_category");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 목록</title>
<!-- Bootstrap CSS -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
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
	
	.empty-container {
	    display: flex;
	    justify-content: center;
	    align-items: center;
	    height: 300px; /* 적절한 높이를 설정해서 빈 상태일 때 공간을 유지 */
	    width: 100%;
	}
	
	
	
</style>

	<div class="content">
		<%@ include file="header.jsp" %>
	</div>
      	
		<div class="container">
		    <div class="text-center my-4"> 
		        <button class="category-style" id= 'total' value='' onclick="selectAnimal('');">#전체</button> 
		        <button class="category-style" id= "dog" value="dog" onclick="selectAnimal('dog');">#강아지</button>
		        <button class="category-style" id= "cat" value="cat" onclick="selectAnimal('cat');">#고양이</button>
		    </div>
		    
		   	<div class="text-center my-4"> 
			    <button class="circle-button" id= "all" value="food" onclick="updateSelectedCategory('food');">사료</button> 
			    <button class="circle-button" id= "refreshment" value="refreshment" onclick="updateSelectedCategory('refreshment');">간식</button>
			    <button class="circle-button" id= "product" value="product" onclick="updateSelectedCategory('product');">용품</button>
			    <button class="circle-button" id= "etc" value="etc" onclick="updateSelectedCategory('etc');">리빙</button>
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
				
				let selectedAnimal = ''; // 기본값
			    let selectedCategory = ''; //기본값
			    
				 // 페이지가 로드될 때 쿼리 파라미터를 읽어 선택 상태 설정
			    window.onload = function() {
			       const urlParams = new URLSearchParams(window.location.search);
			       selectedAnimal = urlParams.get('pd_animal') || '';
			       selectedCategory = urlParams.get('pd_category') || '';
			       
			    // 선택된 동물 버튼 스타일 적용
			       const animalButtons = document.querySelectorAll('.category-style');
			       animalButtons.forEach(btn => {
			           if (btn.value === selectedAnimal) {
			               btn.classList.add('selected');
			           }
			       });
			
			       // 선택된 카테고리 버튼 스타일 적용
			       const categoryButtons = document.querySelectorAll('.circle-button');
			       categoryButtons.forEach(btn => {
			           if (btn.value === selectedCategory) {
			               btn.classList.add('selected');
			           }
			       });
			   };
			
				
			    //동물 선택 함수
			    function selectAnimal(animal) {
			        selectedAnimal = animal; // 선택한 동물 업데이트
			        console.log("Selected animal:", selectedAnimal);
			        
			        const animalButtons = document.querySelectorAll('.category-style');
			        animalButtons.forEach(btn => {
			            btn.classList.remove('selected');
			            if (btn.value === animal) {
			                btn.classList.add('selected');
			            }
			        });
			        updateURL(); // 동물 버튼 클릭 시 URL 업데이트
			    }
				
			 	// 카테고리 선택 함수
			    function updateSelectedCategory(category) {
			        selectedCategory = category; // 선택한 카테고리 업데이트
			        console.log("Selected category:", selectedCategory);
			
			        const categoryButtons = document.querySelectorAll('.circle-button');
			        categoryButtons.forEach(btn => {
			            btn.classList.remove('selected');
			            if (btn.value === category) {
			                btn.classList.add('selected');
			            }
			        });
			        updateURL();
			    }
			 	
			 	// 페이지 네비게이션 함수
			    function navigateToPage(page) {
			        const baseURL = "${pageContext.request.contextPath}/s_main"; // 기본 URL
			        const url = baseURL + "?page=" + page + "&pd_animal=" + selectedAnimal + "&pd_category=" + selectedCategory;
			        
			        // URL을 동적으로 업데이트 (페이지 이동)
			        console.log("Generated URL:", url);
			        window.location.href = url; // URL로 이동
			    }
			 	
			 	// URL 업데이트 함수
			    function updateURL() {
			        const baseURL = "${pageContext.request.contextPath}/s_main"; // 기본 URL
			        const page = 1; // 페이지는 1로 고정
			        const url = baseURL + "?page=" + page + "&pd_animal=" + selectedAnimal + "&pd_category=" + selectedCategory;
			
			        // URL을 동적으로 업데이트 (페이지 이동)
			        console.log("Generated URL:", url);
			        
			        window.location.href = url;
			    }
			</script>

			<style>
				/*상품목록 디자인 */
				.product-box {
			            border: 1px solid #ddd;
			            border-radius: 5px;
			            margin: 10px;
			            text-align: center;
			            width: 250px;
			            height: 300px;
			    }
			        .product-img {
			            max-width: 100%;
			            height: auto;
			            object-fit: contain;
			    }
			    .product-text {
			            margin-left: 14px;
			            width:100%; 
			            object-fit:cover;
			            
			    }
			    .product-name {
			        font-size: 0.92em;
			        overflow-wrap: break-word; /*텍스트 길이 줄바꿈*/
			    }
			
			    .product-price {
			        font-size: 0.9em; 
			        color: #ff9800; 
			    }
			    
			    
			</style>
		    
		    <hr class="custom-hr">
		    <div class="container">
		    	<div class="row empty">
		    		<c:if test="${empty ProductItems}">
						<div class="empty-container">
					        <span class="text-center align-middle mt-5 mb-4">등록된 상품이 없습니다.</span>
						</div>
					</c:if>
		    		<c:forEach var="item" items="${ProductItems}">
		    			<!-- pd_selling 값이 'N'이 아닐 때만 노출 -->
           				<c:choose>
    						<c:when test="${fn:contains(item.pd_selling, 'Y')}">
				                <div class="col-md-3 mb-3">
				                    <div class="product-box">
				                    <a href="${pageContext.request.contextPath}/p_details?pdNum=${item.pdNum}" style="color: black;">
				                        <img src="${pageContext.request.contextPath}/upload/${item.pd_chng_fname}" alt="${item.pdName}" class="product-img" style="width:100%; height:100%; object-fit:cover;">
				                    </a>
				                    </div>
				                    
				                    <div class="product-text">
				                    <a href="${pageContext.request.contextPath}/p_details?pdNum=${item.pdNum}" style="color: black;">
				                    	<h6 class="product-name">${item.pdName} ${item.pd_amount == 0 ? '(품절)' : ''}</h6>
				                    </a>    
				                        <p class="product-price">
				                        	<fmt:formatNumber value="${item.pd_price}" pattern="#,##0원" />
				                        </p>
				                    </div>
				                </div>
			                </c:when>
		                </c:choose>  
	                </c:forEach>
		    	</div>
		    </div>
		</div>
       	
       	
       	<!-- 페이지네이션 -->
   	    <c:if test="${not empty ProductItems}">
		<div class="director">
	    <!-- 첫 페이지 -->
	    <c:choose>
	        <c:when test="${currentPage == 1}">
	            <button type="button" class="btn page-button" disabled >&lt;&lt;</button>
	        </c:when>
	        <c:otherwise>
	            <button type="button" class="btn page-button" onclick="navigateToPage(1)">&lt;&lt;</button>
	        </c:otherwise>
	    </c:choose>
	
	    <!-- 이전 페이지 -->
	    <c:choose>
	        <c:when test="${currentPage == 1}">
	            <button type="button" class="btn page-button" disabled>&lt;</button>
	        </c:when>
	        <c:otherwise>
	            <button type="button" class="btn page-button" onclick="navigateToPage(${currentPage - 1})">&lt;</button>
	        </c:otherwise>
	    </c:choose>
	
	    <!-- 개별 페이지 -->
	    <c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
	        <c:choose>
	            <c:when test="${currentPage == i}">
	                <button type="button" class="btn page-button" disabled>${i}</button>
	            </c:when>
	            <c:otherwise>
	                <button type="button" class="btn page-button" onclick="navigateToPage(${i})">${i}</button>
	            </c:otherwise>
	        </c:choose>
	    </c:forEach>
	
	    <!-- 다음 페이지 -->
	    <c:choose>
	        <c:when test="${currentPage == totalPages}">
	            <button type="button" class="btn page-button" disabled>&gt;</button>
	        </c:when>
	        <c:otherwise>
	            <button type="button" class="btn page-button" onclick="navigateToPage(${currentPage + 1})">&gt;</button>
	        </c:otherwise>
	    </c:choose>
	
	    <!-- 끝 페이지 -->
	    <c:choose>
	        <c:when test="${currentPage == totalPages}">
	            <button type="button" class="btn page-button" disabled>&gt;&gt;</button>
	        </c:when>
	        <c:otherwise>
	            <button type="button" class="btn page-button" onclick="navigateToPage(${totalPages})">&gt;&gt;</button>
	        </c:otherwise>
	    </c:choose>
		</div>
		</c:if>
		<!-- 페이지네이션 -->
		
		
		
<style>
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

<%@ include file="kakaoCh.jsp" %>
       	
<%@ include file="footer.jsp" %>

<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>