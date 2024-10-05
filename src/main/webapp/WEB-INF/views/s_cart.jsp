<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
	
	.table-white {
		background-color: #ffffff;
	}
	
	.table-bottom-border {
	    border-bottom: 1px solid #ffc107; /* 원하는 색상과 두께로 테두리 설정 */
	}
	
	.my-custom-table td, .my-custom-table th {
	    line-height: 2; /* 이 테이블에만 적용 */
	}
	
	img {
		margin-left:10px;
		margin-top:10px;
		width:100px; 
		height:100px; 
		object-fit:cover;
	}
	
	.removeBtn {
		margin-top:10px;
		margin-right:10px;
		width: 200px; 
		color: black;
		background-color: #ffe282;
	}
	
	.tableDeco {
		border-top: 3px solid #ffc107;
		border-bottom: 3px solid #ffc107;
	}
	
	.orderBtn {
	    font-size: 1.2em;
	    font-weight: bold;
	    font-color: gray;
		width: 300px;
		height: 50px; 
		color: black;
		background-color: #ffe282;
	}
	
	.centered-container {
	    margin-top: 20px;
	    display: flex;
	    flex-direction: column;
	    justify-content: center;
	    align-items: center;
	}
	
	.gray-link {
	    color: gray;                
	    text-decoration: underline; /* 밑줄 추가 */
	}
	
	.gray-link:hover {
	    color: black;               /* 마우스 오버 시 글씨 색상을 검은색으로 변경 */
	    text-decoration: underline; /* 밑줄 유지 */
	}
	
</style>



	<div class=container>
		<h3 class="text-center mt-5 mb-3"><strong>장바구니</strong></h3>
		<div class=container1>
		 	<table class="table table-bordered mb-2">
			  <thead>
			    <tr class="table-warning text-center">
			      <th class="text-center align-middle" >
	                  <div class="d-flex justify-content-center align-items-center" style="height: 100%; margin-left:10px;">
	                      <input class="form-check-input" type="checkbox" id="selectAll">
	                  </div>
            	  </th>
			      <th scope="col">상품정보</th>
			      <th scope="col">수량</th>
			      <th scope="col">주문금액</th>
			      <th scope="col" style="background-color:#ffe282;">배송비</th> 
			    </tr>
			  </thead>
				<tbody>
				    <c:forEach var="item" items="${products}">
				        <input type="hidden" name="pdNum" value="${item.pdNum}" />
				        <tr>
				            <!-- 체크박스 열 -->
				            <td class="text-center align-middle">
				                <div class="d-flex justify-content-center align-items-center" style="height: 100%; margin-left:10px;">
				                    <input class="form-check-input selectEach" type="checkbox">
				                </div>
<script>
  // 'selectAll' 체크박스 이벤트 리스너 추가
  document.getElementById('selectAll').addEventListener('change', function() {
    // 모든 개별 체크박스를 선택하거나 해제
    const isChecked = this.checked;
    const checkboxes = document.querySelectorAll('.selectEach');
    
    checkboxes.forEach(function(checkbox) {
      checkbox.checked = isChecked;
    });
  });
</script>

<script>
    $(document).ready(function() {
        console.log('Products:', ${products}); // products 변수 출력
    });
</script>
				            </td>
				            <!-- 상품 정보 열 -->
				            <td>
				                <div style="display: flex; align-items: center;">
				                    <a href="${pageContext.request.contextPath}/p_details?pdNum=${item.pdNum}" style="color: black;">
				                        <img src="${pageContext.request.contextPath}/upload/${item.pdChngFname}" alt="${item.pdName}">
				                    </a>
				                    <p style="margin-left: 15px; margin-top: 15px;">${item.pdName}</p>
				                </div>
				            </td>
				            <!-- 수량 -->
				            <td class="text-center align-middle">
					            <div>
					                <span id="quantity-text">${item.sbagAmount}개</span>
					            </div>
					            <br>
					            <div class="btn-group" role="group" aria-label="Default button group">
	                             <button type="button" id="decrease" class="btn btn-outline-secondary">-</button>
	                             <button type="button" id="increase" class="btn btn-outline-secondary">+</button>
	                         </div>	
					        </td>
				            <!-- 주문 금액 -->
				            <td class="text-center align-middle" id="price-${item.pdNum}">
				            	<span id="total-price">${item.sbagPrice}원</span>
				            </td>
				            <!-- 배송비 -->
				            <td class="text-center align-middle" style="background-color:#ffe282;">
				                <span>무료</span>        
				            </td>
				        </tr>
				     </c:forEach>
				</tbody>
			</table>
			<div>
				<button id="remove-selected" class="btn btn-outline-warning removeBtn">
					선택상품 삭제
				</button>
	   	   		<button id="remove-soldout" class="btn btn-outline-warning removeBtn">
	   	   			품절상품 삭제
	   	   		</button>
       	   	</div>

		 	<table class="table table-bordered mt-5 mb-2 tableDeco" style="border-left: none; border-right: none;">
		  	    <thead>
		    	  <tr class="table-warning text-center">
		     		  <th class="text-center align-middle" style="background-color:white; border-left: none; border-right: none;">
		                  <div class="d-flex justify-content-center align-items-center">
		                  	  <c:set var="itemCount" value="${fn:length(products)}" />
		                      <span>총 주문상품 ${itemCount}개</span>
		                  </div>
	            	  </th>
			      </tr>
			    </thead>
				<tbody>
				   <tr>  
		              <td class="text-center align-middle" style="height:250px; border-left: none; border-right: none;">
	                     <div style="display: block; margin-bottom: 15px; font-size: 1.7em;">
						     <span id="total-price2">${item.sbagPrice}원</span>
						     <span style="margin-left: 100px;"> + </span>
						     <span style="margin-right: 100px; margin-left: 10px;">0원</span>
						     <span style="font-weight: bold;"> = </span>
						     <span id="total-price3" style="margin-left: 10px; font-weight: bold;">${item.sbagPrice}원</span>
						 </div>
						 <div style="display: block; color:grey;">
						    <span>상품금액</span>
						    <span style="margin-right: 100px; margin-left: 100px;">배송비</span>
						    <span>총 주문금액</span>
						 </div>
		              </td>
				   </tr>
				</tbody>
			</table>
			<div class="centered-container">
       	   		<button id="purchaseBtn" class="btn btn-outline-warning orderBtn mb-3">
					주문하기
				</button>
				<a href="s_main" class="gray-link">계속 쇼핑하기</a>
       	   	</div>
		</div>
	</div>
	
<script>
$(document).ready(function() {
	let pricePerItem = parseInt(document.getElementById('total-price').textContent.replace(/[^0-9]/g, ''));
	let quantity = parseInt(document.getElementById('quantity-text').textContent.replace(/[^0-9]/g, ''));
    
    // 초기 값 확인
    console.log("초기 개별 가격:", pricePerItem);
    console.log("초기 수량:", quantity);
    console.log("초기 item.pdNum:", ${item.pdNum});

    function updateTotalPrice() {
        let totalPrice = pricePerItem * quantity;
        $('#total-price').text(totalPrice.toLocaleString() + '원');
        $('#total-price2').text(totalPrice.toLocaleString() + '원');
        $('#total-price3').text(totalPrice.toLocaleString() + '원');
        $('#quantity-text').text(quantity + '개');
        console.log("업데이트된 총 가격:", totalPrice);
        console.log("업데이트된 수량:", quantity);
    }

    // 동적으로 생성된 버튼과 입력 필드에 이벤트 바인딩
    $(document).on('click', '#increase', function() {
        console.log("increase 버튼 클릭됨");
        quantity++;
        $('#quantity-text').val(quantity);
        updateTotalPrice();
    });

    $(document).on('click', '#decrease', function() {
        if (quantity > 1) {
            console.log("decrease 버튼 클릭됨");
            quantity--;
            $('#quantity-text').val(quantity);
            updateTotalPrice();
        }
    });

    // 입력 필드에 값 변경 감지
    $(document).on('input', '#quantity-text', function() {
        let inputValue = $(this).val();
        console.log("입력값 변경됨:", inputValue);
        if ($.isNumeric(inputValue) && parseInt(inputValue) > 0) {
            quantity = parseInt(inputValue);
        } else {
            quantity = 1;
        }
        $(this).val(quantity);
        updateTotalPrice();
    });

    // 초기 총 가격 업데이트
    updateTotalPrice();
});

</script>


					
<%@ include file="footer.jsp" %>
<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>