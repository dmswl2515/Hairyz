<%@ page import="com.study.springboot.dto.QDto" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.DayOfWeek" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<%
    // 현재 날짜와 시간 가져오기
    LocalDateTime now = LocalDateTime.now();
    // 오늘출발 가능 시간을 12:00로 설정
    LocalDateTime deadline = now.withHour(12).withMinute(0).withSecond(0).withNano(0);

    // 평일 체크: 월~금 (1~5)
    boolean isWeekday = (now.getDayOfWeek() != DayOfWeek.SATURDAY && now.getDayOfWeek() != DayOfWeek.SUNDAY);
    boolean isBeforeDeadline = now.isBefore(deadline);

    String message;
    if (isWeekday && isBeforeDeadline) {
        message = "오늘출발 주문가능합니다(평일 12:00시 까지)";
    } else {
        message = "오늘출발 마감되었습니다(평일 12:00시 까지)";
    }
%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 목록</title>
<!-- Bootstrap CSS -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
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
        .custom-container hr {
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
	
	/*상품 상세*/
	
	.product-container {
	    display: flex; /* 수평정렬 */
	    align-items: flex-start; /*상단정렬*/
	    margin-bottom: 10px;
	}
	.product-box {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 20px;
            margin-top: 80px;
            margin-left: 50px;
            margin-right: 50px;
            text-align: center;
            width: 550px;
            height: 600px;
    }
        .product-img {
            max-width: 100%;
            height: auto;
    }
    .product-text {
        margin-top:100px;
        flex-direction: column; /* 텍스트를 세로로 정렬 */
        justify-content: center;   
            
    }
    .product-name {
    	line-height: 2;
        font-size: 1.5em;
        overflow-wrap: break-word; /*텍스트 길이 줄바꿈*/
    }

    .product-price {
        font-size: 1.3em; 
        color: #ff9800;
    }
    
    hr.product-hr {
        border: 0.5px solid #ffc107 !important; 
        width: 100% !important;
        margin-top: 30px !important;
    }

    .highlight-box {
        background-color: #fff9c4; 
        padding: 10px; 
        border-radius: 2px; 
	    flex-direction: column; 
    }
    
    .quantity-container {
    margin-top: 20px; 
	}
	
	.quantity-button {
	    width: 30px;
	    height: 30px;
	    font-size: 1.2em;
	    cursor: pointer;
	}
        
</style>
		    
		<div class=container>
		    <div class="product-container">	
	              <div class="product-box">
	           		<img src="${pageContext.request.contextPath}/upload/${product.pd_chng_fname}" alt="${product.pdName}" style="width:100%; height:100%; margin-right:10px;" object-fit:cover;>
	             
	              </div>
	              <div class="product-text">
		              <span class="product-name">${product.pdName}</span><br>
		              <span class="product-price">
		              	<fmt:formatNumber value="${product.pd_price}" pattern="#,##0원" />
		              </span>
		              <hr class="product-hr">
		              
		              <p>배송방법&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;택배</p>
		              <p>배송비&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;무료</p>
		              <div class="highlight-box">
						    <div style="display: flex; align-items: center;">
						        <i class="fas fa-truck" style="margin: 10px 10px;"></i> <!-- 배달 아이콘 -->
						        <p style="margin: 0;">오늘출발 상품</p>
						    </div>
						    <p style="margin-left: 40px;"><%= message %></p>
					  </div>
					  
		              <hr class="product-hr">
			              <div style="display: flex; align-items: center;">
						     <span style="margin-right: 250px;">수량</span>
	                         <div class="btn-group" role="group" aria-label="Default button group">
	                             <button type="button" id="decrease" class="btn btn-outline-secondary">-</button>
	                             <input type="text" id="quantity-input" style="width: 40px; text-align: center;" value="1" />
	                             <button type="button" id="increase" class="btn btn-outline-secondary">+</button>
	                         </div>
						 </div>
					     
					     
					  <hr class="product-hr">
					  	<div style="display: flex; align-items: center;">
	                        <span style="margin-right: 240px;">총 상품 금액</span>
	                        <span id="total-price">${product.pd_price}원</span>
                    	</div>
<script>
	$(document).ready(function() {
	    let pricePerItem = ${product.pd_price} // 개별 상품 가격
	    let quantity = parseInt($('#quantity-input').val()); // 초기 수량
	
	    function updateTotalPrice() {
	        let totalPrice = pricePerItem * quantity;
	        $('#total-price').text(totalPrice.toLocaleString() + '원');
	    }
	
	    $('#increase').on('click', function() {
	        quantity++;
	        $('#quantity-input').val(quantity);
	        updateTotalPrice();
	    });
	
	    $('#decrease').on('click', function() {
	        if (quantity > 1) {
	            quantity--;
	            $('#quantity-input').val(quantity);
	            updateTotalPrice();
	        }
	    });
	    
	    $('#quantity-input').on('focus', function() {
	    	$(this).val(''); // 입력란 클릭 시 모든 내용 선택
        });
	
	    $('#quantity-input').on('input', function() {
	        // 사용자가 입력한 값을 받아오기
	        let inputValue = $(this).val();
	        // 입력된 값이 숫자인지 확인하고, 숫자가 아닌 경우 1로 설정
	        if ($.isNumeric(inputValue) && parseInt(inputValue) > 0) {
	            quantity = parseInt(inputValue); // 유효한 수량으로 업데이트
	        } else {
	            quantity = 1; // 기본값 1 설정
	        }
	        $(this).val(quantity); // 입력란의 값을 업데이트
	        updateTotalPrice(); // 총 가격 업데이트
	    });
	
	    // 초기 총 가격 업데이트
	    updateTotalPrice();
	});
</script>	              
	              	   <hr class="product-hr">
	              	   		<div>
    							<button id="buy-now" class="btn btn-warning" style="width: 200px; margin-left: 10px;">구매하기</button>
		              	   		<button id="add-to-cart" class="btn btn-outline-warning" style="width: 200px; color: black;">장바구니</button>
		              	   	</div>
	              </div>
              </div> 
		</div>

<script>
    // 장바구니에 담기 버튼 클릭 이벤트
    $('#add-to-cart').on('click', function() {
        alert('상품이 장바구니에 담겼습니다.'); // 실제 장바구니 로직으로 대체
    });
</script>


<style>
    .info-tabs {
        display: flex;
        justify-content: space-around;
        margin: 20px 0;
        max-width: 1000px; /* 최대 너비 설정 */
    	margin: 20px auto;
    }
    
    .info-content {
	    max-width: 1000px; /* 최대 너비 설정 */
	    margin: 0 auto; /* 가운데 정렬 */
	}
    .tab-button {
        flex: 1;
        padding: 10px;
        background-color: #ffffff;
        border: 1px solid #ddd;
        cursor: pointer;
        text-align: center;
        outline: none;
        
        
    }
    
    .tab-button:focus {
    outline: none; /* 포커스 시 아웃라인 제거 */
	}
    
    .active {
     background-color: #fff9c4;
     border-color: #ffc107;
     outline: none;
     
    }
    
    .custom-width {
        width: 150px;
        color: #000000; 
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
	
	.my-custom-table td, .my-custom-table th {
	    line-height: 2; /* 이 테이블에만 적용 */
	}
	
	
    
</style>
		
       	<div class=container>
       		<div class="info-tabs">
			    <button class="tab-button active" id="details-tab">상세정보</button>
			    <button class="tab-button" id="reviews-tab">구매평</button>
			    <button class="tab-button" id="qna-tab">Q&A</button>
			</div>
			
			<div class="info-content">
			    <div id="details-content">
			        <img src="${pageContext.request.contextPath}/upload/${product.pd_chng_fname2}" alt="${product.pdName}" style="width:100%; height:100%; margin-right:10px;" object-fit:cover;>
			        <!-- 데이터베이스에서 불러온 내용 표시 -->
			    </div>
			<hr class="product-hr">
			    <div id="reviews-content">
			        <h3><strong>구매평</strong></h3>
			        <p>상품을 구매하신 분들이 작성한 리뷰입니다.</p>
			    </div>
				    <table class="mb-2 my-custom-table" style="width: 100%;">
						  <thead>
					        <c:forEach var="item" items="${boardPage.content}">
							    <tr class="table-white text-left">
							      <td scope="col" colspan="4">별점</td>
							    </tr>
						  </thead>
						      <tbody>
					            <tr class="table-white text-left">
							      <td scope="col">김*지</td>
							      <td scope="col" colspan="3">2024-09-20</td>
							    </tr>
							    <tr class="table-white text-left">
							      	<td scope="col" colspan="4">
						                <img src="${item.imageUrl}" alt="상품 이미지" style="width:100px; height:auto;">
						            </td>
							    </tr>
					            <tr class="table-white text-left table-bottom-border">
							      <td scope="col" colspan="4">양도 많고 너무 잘먹어요...<br>특히 둘째가 가리는게 많은데 너무 잘 먹어 대만족이에요!</td>
							    </tr>
					        </c:forEach>
					      <thead>
					        <c:forEach var="item" items="${boardPage.content}">
							    <tr class="table-white text-left">
							      <td scope="col" colspan="4">별점</td>
							    </tr>
						  </thead>
						      <tbody>
					            <tr class="table-white text-left">
							      <td scope="col">김*지</td>
							      <td scope="col" colspan="3">2024-09-20</td>
							    </tr>
							    <tr class="table-white text-left">
							      	<td scope="col" colspan="4">
						                <img src="${item.imageUrl}" alt="상품 이미지" style="width:100px; height:auto;">
						            </td>
							    </tr>
					            <tr class="table-white text-left table-bottom-border">
							      <td scope="col" colspan="4">양도 많고 너무 잘먹어요...<br>특히 둘째가 가리는게 많은데 너무 잘 먹어 대만족이에요!</td>
							    </tr>
					        </c:forEach>  
					      </tbody>
						</table>
						
						<!-- 페이지네이션 -->
						 
			    
			<hr class="product-hr">
			    <div id="qna-content" class="">
			        <h3><strong>Q&A</strong></h3>
			        <p>구매하시려는 상품에 대해 궁금한 점이 있으면 문의 주세요.</p>
					<div class="container d-flex justify-content-end">
				        <input type="button" class="btn btn-warning custom-width mb-3" value="Q&A 작성"  onclick=""/>
			       	</div>
			       	<table class="table table-bordered mb-2">
					  <thead>
					    <tr class="table-warning text-center">
					      <th scope="col">답변상태</th>
					      <th scope="col">제목</th>
					      <th scope="col">작성자</th>
					      <th scope="col">작성일</th>
					    </tr>
					  </thead>
				      <tbody>
				      	<c:if test="${not empty qnaList}">
					        <c:forEach var="qDTO" items="${qnaList}">
					            <tr>
					                <td class="text-center align-middle">
						                <c:choose>
									        <c:when test="${qDTO.qna_rstate == 'N'}">
									            미답변
									        </c:when>
									        <c:when test="${qDTO.qna_rstate == 'Y'}">
									            답변완료
									        </c:when>
									    </c:choose>    
					                <td>
					                   <div class="product-container">	
						                    ${qDTO.qna_content}&nbsp;&nbsp;
				                            <c:if test="${qDTO.isNew()}">
											    <span class="badge badge-secondary">New</span>
											</c:if>
											<c:if test="${!qDTO.isNew()}">
											</c:if>
						               </div>     
					                </td>
					                <td class="text-center align-middle">${qDTO.qna_name}</td>
					                <td class="text-center align-middle">
					                	<fmt:formatDate value="${qDTO.qna_date}" pattern="yyyy-MM-dd" />					                </td>
					            </tr>
					        </c:forEach>
				        </c:if>

						<c:if test="${empty qnaList}">
						    <tr>
						        <td colspan="4" class="text-center align-middle">등록된 문의 내용이 없습니다.</td>
						    </tr>
						</c:if>
				      </tbody>
					</table> 		       
			    </div>
			</div>
       	</div>
       	
       
<script>
	document.querySelectorAll('.tab-button').forEach(button => {
	    button.addEventListener('click', function() {
	        // 모든 버튼에서 'active' 클래스 제거
	        document.querySelectorAll('.tab-button').forEach(btn => {
	            btn.classList.remove('active');
	        });
	        
	        // 클릭한 버튼에 'active' 클래스 추가
	        this.classList.add('active');
	        
	     	// 해당 섹션으로 스크롤
            const targetId = this.id.replace('-tab', '-content'); // ID 변환
            const targetElement = document.getElementById(targetId);
            if (targetElement) {
                targetElement.scrollIntoView({ behavior: 'smooth' }); // 부드럽게 스크롤
            }
	    });
	});

</script>
       	
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
