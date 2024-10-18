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
	
	.picture {
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
	
	.out-of-stock {
	    background-color: #f0f0f0; /* 연한 회색 */
	    color: #b0b0b0; /* 글씨 색상도 회색으로 변경 */
	}
	
	.empty-container {
	    justify-content: center;
	    align-items: center;
	    text-align: center;
	    line-height: 500px;
	    width: 100%;
	}
	
	
</style>



	<div class=container>
		<h3 class="text-center mt-5 mb-3"><strong>장바구니</strong></h3>
		<div class=container1>
			<c:if test="${empty products}">
				<div class="empty-container">
					<span class="text-center align-middle mt-5 mb-4">장바구니에 담긴 상품이 없습니다.</span>
				</div>
			</c:if>
			<c:if test="${not empty products}">	
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
				        <input type="hidden" id="pdNum" name="productNum" value="${item.pdNum}" />
				        <tr class="${item.pdAmount == 0 ? 'out-of-stock' : ''}">
				            <!-- 체크박스 열 -->
				            <td class="text-center align-middle">
				                <div class="d-flex justify-content-center align-items-center" style="height: 100%; margin-left:10px;">
				                    <input class="form-check-input selectEach" type="checkbox" name="eachCheckBox" 
				                    	   value="${item.pdNum}" ${item.pdAmount == 0 ? 'disabled' : ''}
				                    	   data-amount="${item.pdAmount}">
				                </div>
								<script>
								  
				                document.addEventListener('DOMContentLoaded', function() {
				                    // 'selectAll' 체크박스를 통해 개별 체크박스를 모두 선택하거나 해제
				                    document.getElementById('selectAll').addEventListener('change', function() {
				                        const isChecked = this.checked;
				                        const checkboxes = document.querySelectorAll('.selectEach');
				                        
				                        checkboxes.forEach(function(checkbox) {
				                            // 품절된 상품일 경우 체크 해제
				                            if (checkbox.dataset.amount !== "0") { // 품절 상품이 아닐 때만 체크
				                                checkbox.checked = isChecked;
				                            } else {
				                                checkbox.checked = false; // 품절 상품은 항상 체크 해제
				                            }
				                        });
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
				                        <img src="${pageContext.request.contextPath}/upload/${item.pdChngFname}" class="picture" id="productImg-${item.pdNum}" alt="${item.pdName}">
				                    </a>
				                    <p id="productName-${item.pdNum}" style="margin-left: 15px; margin-top: 15px;">${item.pdName}</p>
				                    <input type="hidden" name="productName" value="${item.pdName}">
				                </div>
				            </td>
				            <!-- 수량 -->
				            <td class="text-center align-middle">
					            <div>
					                <span id="quantity-text-${item.pdNum}" data-pdnum="${item.pdNum}">
					                ${item.pdAmount == 0 ? 0 : item.sbagAmount}개</span>
					            </div>
					            <br>
					            <div class="btn-group" role="group" aria-label="Default button group">
	                             <button type="button" class="btn btn-outline-secondary decrease" 
	                             		 data-pdnum="${item.pdNum}" ${item.pdAmount == 0 ? 'disabled' : ''}>-</button>
        						 <button type="button" class="btn btn-outline-secondary increase" 
        						 		 data-pdnum="${item.pdNum}" ${item.pdAmount == 0 ? 'disabled' : ''}>+</button>
	                            </div>	
					        </td>
				            <!-- 주문 금액 -->
				            <td class="text-center align-middle" id="price-${item.pdNum}">
				            	<span id="total-price-${item.pdNum}">
				            	${item.pdAmount == 0 ? 0 : item.sbagPrice}원</span>
				            </td>
				            
				            <script>
					            document.addEventListener("DOMContentLoaded", function() {
					                // 수량 증가 버튼 클릭 이벤트
					                document.querySelectorAll('.increase').forEach(button => {
					                	
					                	// 각 버튼에 대해 클릭 이벤트 리스너 추가
					                    button.addEventListener('click', handleIncrease);
					                });
					                
					             	// 수량 감소 버튼 클릭 이벤트
					                document.querySelectorAll('.decrease').forEach(button => {
					                    // 각 버튼에 대해 클릭 이벤트 리스너 추가
					                    button.addEventListener('click', handleDecrease);
					                });
					            });
					            
					            function handleIncrease() {
					                const pdNum = this.getAttribute('data-pdnum');
					                updateQuantity(pdNum, 1);
					            }

					            function handleDecrease() {
					                const pdNum = this.getAttribute('data-pdnum');
					                updateQuantity(pdNum, -1);
					            }
					            
					            function updateQuantity(pdNum, change) {
					                const quantityTextId = `quantity-text-` + pdNum;
					                const totalPriceId = `price-` + pdNum ;
					                const quantityText = document.getElementById(quantityTextId);
					                const totalPriceElement = document.getElementById(totalPriceId);

					                if (!quantityText || !totalPriceElement) return; // Exit if elements not found

					                let currentQuantity = parseInt(quantityText.textContent);
					                const pricePerItem = parseInt(totalPriceElement.textContent) / currentQuantity;

					                currentQuantity += change;
					                if (currentQuantity < 1) return; // Prevent quantity from going below 1

					                quantityText.textContent = currentQuantity + '개'; // Update displayed quantity
					                totalPriceElement.textContent = (pricePerItem * currentQuantity) + '원'; // Update total price

					                calculateTotalPrice(); // Recalculate overall total price
					            }
				            </script>
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
				
				<script>
					//"선택상품 삭제" 버튼 클릭 시 체크된 항목을 서버로 전송
					document.getElementById("remove-selected").addEventListener("click", function() {
					    const selectedItems = [];
					    
					    // 전체 선택 체크박스의 상태
					    const isSelectAllChecked = document.getElementById("selectAll") ? document.getElementById("selectAll").checked : false;
					    const checkboxes = document.querySelectorAll(".selectEach:checked");
					    console.log(isSelectAllChecked);
					    console.log(checkboxes);
					    
					    checkboxes.forEach(checkbox => {
					        selectedItems.push(parseInt(checkbox.value)); // 체크된 상품 번호를 배열에 추가
					    });
					    
					 	// 개별 체크박스가 하나라도 선택된 경우
					    const eachCheckBox = selectedItems.length > 0; 
						
					 	
					    if (selectedItems.length > 0) {
					        // AJAX 요청으로 서버에 삭제할 상품들 전달
					        fetch('/DeleteCart', {
					            method: 'POST',
					            headers: {
					                'Content-Type': 'application/json',
					            },
					            body: JSON.stringify({ pdNums: selectedItems, eachCheckBox: eachCheckBox }), // 체크박스 상태 추가
					        })
					        .then(response => response.json())
					        .then(data => {
					            if (data.success) {
					                alert('선택된 상품이 삭제되었습니다.');
					                location.reload(); // 페이지 새로고침
					            } else {
					                alert('상품 삭제에 실패했습니다.');
					            }
					        })
					        .catch(error => {
					            console.error('Error:', error);
					        });
					    } else {
					        alert('삭제할 상품을 선택하세요.');
					    }
					});
				</script>
	   	   		<button id="remove-soldout" class="btn btn-outline-warning removeBtn">
	   	   			품절상품 삭제
	   	   		</button>
	   	   		<script>
			   	   	document.getElementById('remove-soldout').addEventListener('click', function() {
			   	     const soldOutItems = [];
			   	     const checkboxes = document.querySelectorAll('.selectEach');
		
				   	  checkboxes.forEach(checkbox => {
				          if (checkbox.dataset.amount === "0") { // 품절 상품
				              soldOutItems.push(checkbox.value); // pdNum 추가
				          }
				      });
						
				   	 console.log('품절 상품 목록:', soldOutItems);
				   	
			   	     if (soldOutItems.length > 0) {
			   	         // Ajax 요청으로 서버에 삭제 요청
			   	         fetch('/remove-soldout', { // 삭제를 처리할 서버 URL
			   	             method: 'POST',
			   	             headers: {
			   	                 'Content-Type': 'application/json'
			   	             },
			   	             body: JSON.stringify(soldOutItems)
			   	         })
			   	         .then(response => {
			   	        	if (!response.ok) {
			   	                throw new Error('Network response was not ok.');
			   	            }
			   	            return response.json(); // JSON 응답 처리
			   	         })
			   	         .then(data => {
			   	             alert(data.message); // 성공 메시지
			   	             location.reload(); // 페이지 새로고침 (장바구니 갱신)
			   	         })
			   	         .catch(error => {
			   	             console.error('Error:', error); // 오류 처리
			   	             alert('품절 상품 삭제 중 오류가 발생했습니다.');
			   	         });
			   	     } else {
			   	         alert('삭제할 품절 상품이 없습니다.');
			   	     }
			   	 });

	   	   		</script>
       	   	</div>

		 	<table class="table table-bordered mt-5 mb-2 tableDeco" style="border-left: none; border-right: none;">
		  	    <thead>
		    	  <tr class="table-warning text-center">
		     		  <th class="text-center align-middle" style="background-color:white; border-left: none; border-right: none;">
		                  <div class="d-flex justify-content-center align-items-center">
		                  	  <c:set var="itemCount" value="0" />
								<c:forEach var="product" items="${products}">
								    <c:if test="${product.pdAmount != 0}">
								        <c:set var="itemCount" value="${itemCount + 1}" />
								    </c:if>
								</c:forEach>
		                      <span>총 주문상품 ${itemCount}개</span>
		                  </div>
	            	  </th>
			      </tr>
			    </thead>
				<tbody>
				   <tr>  
		              <td class="text-center align-middle" style="height:250px; border-left: none; border-right: none;">
	                     <div style="display: block; margin-bottom: 15px; font-size: 1.7em;">
						     <span id="total-price2">0원</span>
						     <span style="margin-left: 100px;"> + </span>
						     <span style="margin-right: 100px; margin-left: 10px;">0원</span>
						     <span style="font-weight: bold;"> = </span>
						     <span id="total-price3" style="margin-left: 10px; font-weight: bold;">0원</span>
						 </div>
						 <div style="display: block; color:grey;">
						    <span style="margin-right:30px;">상품금액</span>
						    <span style="margin-right: 90px; margin-left: 100px;">배송비</span>
						    <span>총 주문금액</span>
						 </div>
		              </td>
				   </tr>
				</tbody>
			</table>
			
			<script>
			// 가격 합계 계산 함수
			function calculateTotalPrice() {
			    let totalPrice = 0;
			    const checkboxes = document.querySelectorAll('.selectEach:checked'); // 선택된 체크박스들

			    checkboxes.forEach(function(checkbox) {
			        const pdNum = checkbox.value; // 각 상품의 pdNum을 가져옴
			        const priceElement = document.getElementById(`price-` + pdNum); // 해당 상품의 가격을 가져옴
			        
			    	 // priceElement가 null인지 확인
			        if (!priceElement) {
			            console.error(`Element with id price-${pdNum} not found`);
			            return; 
			        }
			        
			        const priceText = priceElement.textContent; // 텍스트 내용을 가져옴
			        const price = parseInt(priceText.replace(/[^0-9]/g, '')); // 숫자만 추출하여 정수로 변환
			        totalPrice += price; // 가격 합산
			        
			     	// 로그를 추가하여 총합이 정상적으로 계산되는지 확인
			        console.log("최종 총합: " + totalPrice);
			        
			        console.log("checkboxes : " + checkboxes)
			        console.log("pdNum : " + pdNum)
			        console.log("priceText : " + priceText)
			        console.log("price : " + price)
			        console.log("totalPrice : " + totalPrice)
			        
			    });

			    // 계산된 가격을 아래 테이블에 반영
			    const totalPrice2Element = document.getElementById('total-price2');
			    const totalPrice3Element = document.getElementById('total-price3');
			    
			    if (totalPrice2Element) {
			        totalPrice2Element.textContent = totalPrice.toLocaleString() + '원';
			    } else {
			        console.error("total-price2 요소를 찾을 수 없습니다.");
			    }

			    if (totalPrice3Element) {
			        totalPrice3Element.textContent = (totalPrice + 0).toLocaleString() + '원'; // 배송비 추가
			    } else {
			        console.error("total-price3 요소를 찾을 수 없습니다.");
			    }
			}
	
				// 'selectAll' 체크박스를 통해 개별 체크박스를 모두 선택하거나 해제
				document.getElementById('selectAll').addEventListener('change', function() {
				    const isChecked = this.checked;
				    const checkboxes = document.querySelectorAll('.selectEach');
				    
				    checkboxes.forEach(function(checkbox) {
				        checkbox.checked = isChecked;
				    });
	
				    // 모든 체크박스 상태 변경 후 가격 계산
				    calculateTotalPrice();
				});
	
				// 개별 체크박스가 선택될 때마다 가격 계산
				document.querySelectorAll('.selectEach').forEach(function(checkbox) {
				    checkbox.addEventListener('change', function() {
				        calculateTotalPrice();
				    });
				});
			</script>
			
			<div class="centered-container">
       	   		<button onclick="goToPurchase()" id="purchaseBtn" class="btn btn-outline-warning orderBtn mb-3">
					주문하기
				</button>
				<a href="s_main" class="gray-link">계속 쇼핑하기</a>
       	   	</div>
		</div>
	</div>
	</c:if>
<%@ include file="kakaoCh.jsp" %>
					
<%@ include file="footer.jsp" %>
<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<script>
	//구매버튼 클릭 이벤트
	function goToPurchase() {
		// 상품 정보들을 저장할 배열
		let productInfoList = []; 
		
		// 선택된 상품 체크박스
		const selectedProducts = document.querySelectorAll('.selectEach:checked'); 
		
		// 선택된 상품이 없을 경우 알림창 표시
		if (selectedProducts.length < 1) {
			alert("주문하실 상품을 선택해주세요.");
			return; 
		}
		
		//총 주문금액
		let totalPrice = document.getElementById('total-price3').textContent.replace(/[^0-9]/g, '');
		 
		selectedProducts.forEach(function(productCheckbox) {
	    let productNum = productCheckbox.value; // 체크된 상품의 pdNum 값
	    let productName = document.getElementById('productName-' + productNum).innerText;
	    let productImage = document.getElementById('productImg-' + productNum).src; // 이미지의 src 속성 값
	    let productQuantityElement = document.getElementById('quantity-text-' + productNum );
	    let productQuantity = productQuantityElement ? parseInt(productQuantityElement.innerText) : 0; // 숫자 변환
	    let productPrice = document.getElementById('price-' + productNum ).textContent.replace(/[^0-9]/g, ''); // 숫자만 가져오기
	    
	    
	    productInfoList.push({
	    	productNum: productNum,
            productName: productName,
            productImage: productImage,
            productQuantity: productQuantity,
            productPrice: productPrice
        });
	    
	    
	 	// 각 상품 정보 로그 출력 (디버깅용)
        console.log("ProductNum:" + productNum);
        console.log("ProductName:" + productName);
        console.log("ProductImage:" + productImage);
        console.log("ProductQuantity:" + productQuantity);
        console.log("ProductPrice:" + productPrice);
        console.log("totalPrice:" + totalPrice);
        
		});
	    
     	// URL 생성 (상품 배열을 처리하여 URL로 인코딩)
        let url = '/s_purchase?';
        productInfoList.forEach(function(product, index) {
        	url += 'productNum=' + encodeURIComponent(product.productNum) +
		           '&productName=' + encodeURIComponent(product.productName) +
		           '&productImage=' + encodeURIComponent(product.productImage) +
		           '&productQuantity=' + encodeURIComponent(product.productQuantity) +
		           '&productPrice=' + encodeURIComponent(product.productPrice) + '&';
        });
        
        url += 'totalPrice=' + encodeURIComponent(totalPrice);
	    
	    console.log(url)
	    
	    window.location.href = url;
	}
	</script>
</body>
</html>