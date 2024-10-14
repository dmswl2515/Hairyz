<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>




<!DOCTYPE html>
<html>
<head>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<!-- 우편번호 검색 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 부트페이 -->
<script src="https://js.bootpay.co.kr/bootpay-5.0.1.min.js" type="application/javascript"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="content">
		<%@ include file="header.jsp" %>
	</div>

<style>
	 
	 body {
	     display: flex;
	     margin: 0;
	 }
	 
	 .container1 {
            display: flex; /* 플렉스 컨테이너로 설정 */
            justify-content: center; /* 수평 가운데 정렬 */
            width: 100%; /* 전체 너비 사용 */
            margin-top:20px;
            overflow-y: auto;  /* 세로 스크롤 활성화 */
     }
	
	 .left {
	     padding: 20px;
	     background-color: #fff9c4; /* 배경 색상 */
	 }
	
	 .right {
	     
	     padding: 20px;
	     background-color: #ffe282; /* 배경 색상 */
	 }
	
	 .box {
	     border: 1px solid #ccc; /* 상자 테두리 */
	     border-radius: 1px; /* 상자 모서리 둥글게 */
	     padding: 10px;
	     margin-bottom: 15px; /* 상자 간격 */
	     background-color: white; /* 상자 배경 색상 */
	     display: flex;
	     align-items: center;
	     text-align: center; 
	     
	 }
	 
	 .box img {
	     width: 130px; 
	     height: 130px;
	     margin-left: 15px; 
	     
	 }
	 
	 .box-text {
	 	margin-top: 15px;
	 	margin-left: 20px;
	 	text-align: left;
	 	align-items: center;
	 	 
	 	
	 }
	 
	 .box-text span {
	    display: block; 
	    margin-bottom: 10px; /* 각 줄 사이에 간격 추가 */
	}
	
	.box-text .product-name {
	    font-size: 20px; 
	    font-weight: bold; 
	}
	
	.textbold
	{
		font-size: 20px; 
		font-weight: bold;
	}
	
	.text-content
	{
		font-size: 16px;
	}
	
	.box2 {
	     border: 1px solid #ccc; /* 상자 테두리 */
	     border-radius: 1px; /* 상자 모서리 둥글게 */
	     padding: 15px 20px; 
	     margin-bottom: 15px; /* 상자 간격 */
	     background-color: white; /* 상자 배경 색상 */
	     display: flex;
	     align-items: center;
	     text-align: center; 
	     
	     
	 }
	
	.order-info {
	    display: flex;
	    flex-direction: column;
	    justify-content: flex-start;
	    align-items: flex-start; /* 텍스트를 왼쪽에 정렬 */
	    padding-left: 10px;
	    
	}
	
	.order-info span {
	    margin-bottom: 15px; /* 각 텍스트 사이에 간격 추가 */
	}
	
	.box-button {
		margin-bottom: auto;
	    margin-left: auto; /* 버튼을 오른쪽 끝으로 밀기 */
	    margin-top: 10px;
	}
	
	.btn {
	    padding: 5px 10px;
	    margin-left: 20px; /* 버튼과 텍스트 사이의 간격 */
	}
	
	.order-summary {
	    display: flex;
	    flex-direction: column;
	    justify-content: flex-start;
	    align-items: flex-start; /* 텍스트를 왼쪽에 정렬 */
	    
	}
	
	.order-summary span {
	    margin-bottom: 8px; /* 각 텍스트 사이에 간격 추가 */
	}
	
	.custom-hr {
	    border: 0.5px solid #d8d8d8; 
	    width: 235px;
	}
	
	input[type="text"] {
	    display: inline-block; /* inline-block으로 설정하여 너비 조정 가능 */
	    width: 350px; /* 원하는 너비 설정, 부모 요소의 너비에 맞춤 */
	    height: 35px; /* 높이 설정 */
	    margin-bottom: 10px; /* 아래쪽 여백 추가 */
	    padding: 5px; /* 안쪽 여백 추가 */
	    box-sizing: border-box; /* 패딩과 테두리가 너비에 포함되도록 설정 */
	}
	
	.zcode-button {
	    line-height: 1.5; /* 버튼의 라인 높이 조정 */
	    padding: 0.375rem 0.75rem; /* 버튼 패딩 설정 */
	    display: flex;
	    align-items: center; /* 버튼 내 텍스트 수직 중앙 정렬 */
	}
		
	
</style>



	<div class=container>
		<h3 class="text-center mt-5"><strong>결제하기</strong></h3>
		<form method="POST" action="s_completeBuy">
			<input type="hidden" id="odNo" name="odNo" value="${orderNumber}">
				<div class=container1>
				    <div class="left">
			        	<c:forEach var="product" items="${productDetails}">
				        	<div class="box" style="height:170px;">
								 <input type="hidden" id="odNum-${product.productNum}" name="odNum" value="${product.productNum}">
								 <input type="hidden" id="productName-${product.productNum}" name="productName" value="${product.productName}">
								 <input type="hidden" id="odAmount-${product.productNum}" name="odAmount" value="${product.productQuantity}">
								 <input type="hidden" id="productPrice-${product.productNum}" name="productPrice" value="${product.productPrice}">
								 <input type="hidden" id="totalPrice" name="totalPrice" value="${totalPrice}">	
					        	 <img src="${product.productImage}" alt="${product.productName}">
					        	<div class="box-text">
						        	<span class=product-name>${product.productName}</span>
						           	<span style="font-size: 13px;">수량 : ${product.productQuantity}</span>
						            <span style="font-size: 16px; font-weight: bold;">
						              	<fmt:formatNumber value="${product.productPrice}" pattern="#,##0원" />
						            </span>
						        </div>
				        	</div>
				        </c:forEach>
			
				        
	        <div class="box2">
	        	<div class="order-info">
		        	<span class="textbold">주문자 정보</span>
		        	<input type="hidden" id="odMno" name="odMno" value="${memberList.mb_no}"/>
		        	<input type="hidden" id="memberId" name="memberId" value="${memberList.mb_id}"/>
		        	
			        <input type="hidden" id="odMname" name="odMname"/>
			        <span id="name-content" class="text-content">${memberList.mb_name}</span>
			        <input type="text" id="name-input" class="text-content" 
			               style="display: none;" value="${memberList.mb_name}" placeholder="이름" required />
			        
			        <span id="phone-content" class="text-content">${memberList.mb_phone}</span>
			        <input type="hidden" id="odMphone" name="odMphone"/>
			        <input type="text" id="phone-input" class="text-content" 
			               style="display: none;" value="${memberList.mb_phone}" placeholder="핸드폰 번호" required/>
			        
			        <span id="email-content" class="text-content">${memberList.mb_id}</span>
			        <input type="hidden" id="odMemail" name="odMemail"/>
			        <input type="text" id="email-input" class="text-content" 
			               style="display: none;" value="${memberList.mb_id}" placeholder="이메일" required />   
	        	</div>
	        	<div class="box-button">
			        <button type="button" class="btn btn-outline-warning" onclick="toggleEdit()">수정</button>
			    </div>
	        </div>
    	

			<script>
			function toggleEdit() {
			    // 주문자 정보의 내용과 입력 필드를 가져옵니다.
			    const nameContent = document.getElementById('name-content');
			    const nameInput = document.getElementById('name-input');
			
			    const phoneContent = document.getElementById('phone-content');
			    const phoneInput = document.getElementById('phone-input');
			
			    const emailContent = document.getElementById('email-content');
			    const emailInput = document.getElementById('email-input');
			
			    // 텍스트와 입력 필드의 표시 상태를 토글합니다.
			    if (nameContent.style.display === 'none') {
			        // 입력된 값을 텍스트로 업데이트합니다.
			        nameContent.textContent = nameInput.value;
			        nameContent.style.display = 'inline';
			        nameInput.style.display = 'none';
			
			        phoneContent.textContent = phoneInput.value;
			        phoneContent.style.display = 'inline';
			        phoneInput.style.display = 'none';
			
			        emailContent.textContent = emailInput.value;
			        emailContent.style.display = 'inline';
			        emailInput.style.display = 'none';
			    } else {
			        nameContent.style.display = 'none';
			        nameInput.style.display = 'inline';
			        nameInput.focus();
			
			        phoneContent.style.display = 'none';
			        phoneInput.style.display = 'inline';
			        phoneInput.focus();
			
			        emailContent.style.display = 'none';
			        emailInput.style.display = 'inline';
			        emailInput.focus();
			    }
			}
			</script>
  	
	    	<div class="box2">
	        	<div class="order-info">
		        	<span class="textbold">배송 정보</span>    
		    
		    		<span id="recipient-name" class="text-content">${memberList.mb_name}</span>
				    <input type="hidden" id="odRecipient" name="odRecipient"/>
				    <input id="recipient-input" type="text" class="text-content" 
				           style="display:none;" placeholder="이름" required />
				
					<span id="recipient-phone" class="text-content">${memberList.mb_phone}</span>
					<input type="hidden" id="odRphone" name="odRphone"/>
					<input id="rphone-input" type="text" style="display:none;" placeholder="핸드폰 번호" required />					    
				    
				    <div style="display: flex; align-items: center; gap: 10px;">
					    <span id="zcode-content" class="text-content">${memberList.mb_zipcode}</span>
					    <input type="hidden" id="odRzcode" name="odRzcode"/>
					    <input id="zcode-input" type="text" class="text-content" 
					           style="display:none; width:170px;" placeholder="우편번호" required />
					    <button type="button" onclick="searchZipcode()" id="zcode-button" 
					            class="btn btn-secondary zcode-button" 
					            style="display:none; width:170px; margin-top:-10px; margin-left:-1px;">우편번호 확인</button>
					</div>
					
				    <span id="recipient-address" class="text-content">${memberList.mb_addr1}</span>
					<input type="hidden" id="odRaddress" name="odRaddress"/>
					<input id="raddress-input" type="text" style="display:none;" placeholder="주소" required />
					
					<span id="recipient-detail-address" class="text-content">${memberList.mb_addr2}</span>
					<input type="hidden" id="odRaddress2" name="odRaddress2"/>
					<input id="raddress-input2" type="text" style="display:none;" placeholder="상세 주소"/>
													        	
	        	 	<span class="textbold" style="margin-top:10px; margin-bottom:10px;">배송 메모</span>    
		       		<div id="memo-select-container">
					    <select id="memo-select" name="odMemo" style="width:430px; height:35px; margin-bottom:10px;" required>
					        <option value="배송 전 미리 연락바랍니다.">배송 전 미리 연락바랍니다.</option>
					        <option value="부재시 경비실에 맡겨주세요.">부재시 경비실에 맡겨주세요.</option>
					        <option value="부재시 전화나 문자를 남겨주세요.">부재시 전화나 문자를 남겨주세요.</option>
					        <option value="direct-input">직접입력</option>
					    </select>
					</div>
		        </div>   
	            <div class="box-button">
				    <button type="button" class="btn btn-outline-warning" onclick="toggleEdit2()">변경</button>
				</div>    	
	        </div>	

			<script>
			function toggleEdit2() {
				
			 	// 수신자 이름
			    const recipientNameContent = document.getElementById('recipient-name');
			    const recipientNameInput = document.getElementById('recipient-input');
			
			    // 전화번호
			    const recipientPhoneContent = document.getElementById('recipient-phone');
			    const rphoneInput = document.getElementById('rphone-input');
			
			    // 우편번호
			    const zcodeContent = document.getElementById('zcode-content');
			    const zcodeInput = document.getElementById('zcode-input');
			    const zcodeButton = document.getElementById('zcode-button');
			
			    // 주소
			    const recipientAddressContent = document.getElementById('recipient-address');
			    const raddressInput = document.getElementById('raddress-input');
			
			    // 상세주소
			    const recipientDetailAddressContent = document.getElementById('recipient-detail-address');
			    const rdaddressInput = document.getElementById('raddress-input2');
			
			    
			    if (recipientNameContent.style.display === 'none') {
			        // 입력된 값을 텍스트로 업데이트합니다.
			        recipientNameContent.textContent = recipientNameInput.value;
			        recipientNameContent.style.display = 'inline';
			        recipientNameInput.style.display = 'none';
			
			        recipientPhoneContent.textContent = rphoneInput.value;
			        recipientPhoneContent.style.display = 'inline';
			        rphoneInput.style.display = 'none';
			
			        zcodeContent.textContent = zcodeInput.value;
			        zcodeContent.style.display = 'inline';
			        zcodeInput.style.display = 'none';
			        zcodeButton.style.display = 'none';
			
			        recipientAddressContent.textContent = raddressInput.value;
			        recipientAddressContent.style.display = 'inline';
			        raddressInput.style.display = 'none';
			
			        recipientDetailAddressContent.textContent = rdaddressInput.value;
			        recipientDetailAddressContent.style.display = 'inline';
			        rdaddressInput.style.display = 'none';
			    } else {
			        recipientNameContent.style.display = 'none';
			        recipientNameInput.style.display = 'inline';
			        recipientNameInput.focus();
			
			        recipientPhoneContent.style.display = 'none';
			        rphoneInput.style.display = 'inline';
			        rphoneInput.focus();
			
			        zcodeContent.style.display = 'none';
			        zcodeInput.style.display = 'inline';
			        zcodeInput.focus();
			        zcodeButton.style.display = 'inline';
			
			        recipientAddressContent.style.display = 'none';
			        raddressInput.style.display = 'inline';
			        raddressInput.focus();
			
			        recipientDetailAddressContent.style.display = 'none';
			        rdaddressInput.style.display = 'inline';
			        rdaddressInput.focus();
			    }
			    
			}
			</script>
			
			<script>
				//배송메모
				document.getElementById('memo-select').addEventListener('change', function() {
				    const selectedOption = this.value;
				
				    // "직접입력"이 선택되었을 때 input 필드로 전환
				    if (selectedOption === 'direct-input') {
				        const memoInput = document.createElement('input');
				        memoInput.type = 'text';
				        memoInput.name = 'memo';
				        memoInput.style.width = '430px';
				        memoInput.style.height = '35px';
				        memoInput.style.marginBottom = '10px';
				        memoInput.required = true;
				        memoInput.maxLength = 50; //글자수 제
				        memoInput.placeholder = '직접입력해주세요';
				        
				        const charCount = document.createElement('span');
				        charCount.style.fontSize = '12px';
				        charCount.style.color = 'gray';
				        charCount.style.position = 'absolute'; // 포지션을 절대값으로
			            charCount.style.marginTop = '10px'; // input의 위쪽에서 떨어진 위치 조정
			            charCount.style.marginLeft = '-35px'; // input의 왼쪽에서 떨어진 위치 조정
				        charCount.textContent = '0/50';
				
				        // 기존 select 요소를 input 필드로 교체
				        const memoSelectContainer = document.getElementById('memo-select-container');
				        memoSelectContainer.innerHTML = '';
				        memoSelectContainer.appendChild(memoInput); //input 추가
				        memoSelectContainer.appendChild(charCount); // 글자 수 표시
				        memoInput.focus();
				        
				     	 // 입력할 때마다 글자 수 업데이트
				        memoInput.addEventListener('input', function() {
				            const currentLength = memoInput.value.length;
				            charCount.textContent = `${currentLength}/50`;
				        });
				    }
				});
			</script>
			
			<script>
			function searchZipcode() {
			 new daum.Postcode({
			     oncomplete: function(data) {
			         // 선택한 주소의 우편번호와 주소를 입력
			         document.getElementById('zcode-input').value = data.zonecode; // 우편번호
			         document.getElementById('raddress-input').value = data.roadAddress; // 도로명 주소
			         document.getElementById('raddress-input2').focus(); // 상세주소 입력으로 포커스 이동
			     }
			 }).open();
			}
			</script>
		    </div>
		    
		    
		    <div class="right">
		        <div class="box2">
		        	<div class="order-summary">
			        	<span class="textbold">주문 요약</span>    
			       
			        	<span class="text-content">상품 가격
				        	<span class="text-content"style="margin-left:100px;">
					        		<fmt:formatNumber value="${totalPrice}" pattern="#,##0원" />
				        	</span>
			        	</span>
			        	
			        	<span class="text-content">배송비
			        		<span class="text-content" style="margin-left:138px;">
					        		<fmt:formatNumber value="${product.pd_fee}" pattern="#,##0원" />
				        				0원
				        	</span>
			        	</span>
			        	
			        	<hr class="custom-hr">
			        	    
			        	<span class="text-content" style="font-weight: bold;">총 주문 금액
			        		<span class="text-content"style="margin-left:75px;">
					        		<fmt:formatNumber value="${totalPrice}" pattern="#,##0원" />
				        	</span>
			        	</span>
			        </div>
		        </div>
		        
		        <div class="box2" style="margin-bottom:0px;">
		        	<div class="order-summary">
			        	<div class="form-group" style="text-align:left;">
						    <div class="form-check" style="margin-bottom:10px;">
						        <input class="form-check-input" type="checkbox" id="agreeAll">
						        <label class="form-check-label" for="agreeAll">
						            <span class="textbold">전체 동의</span>
						        </label>
						    </div>
						    <div class="ml-4"> <!-- indent 추가 -->
						        <i class="fas fa-angle-right"></i>
						        <span style="font-size: 14px;">구매조건 확인 및 결제진행에 동의</span>
						    </div>
						</div>
		        	</div>
		        </div>
		    	<div class="box2">
		    		<button type="button" class="textbold text-center" id="paymentButton"
		    				style="display: inline-block; width: 100%; background-color: transparent; border: none; text-align: left; cursor: pointer;">
					    결제하기
					</button>
					<script> 
						//부트페이
						document.getElementById('paymentButton').addEventListener('click', function() {
					        
							if (!validateForm()) {
					            alert('모든 정보를 입력해주세요.');
					            return;  
					        }
							
							// 체크박스 체크 여부 확인
					        const agreeAll = document.getElementById('agreeAll');
					        if (!agreeAll.checked) {
					            alert('전체 동의를 선택해주세요.');
					            return;  // 체크박스가 체크되지 않은 경우 결제 진행하지 않음
					        }
							
							//HTML에서 값 가져오기
							//var totalPrice = document.getElementById('totalPrice').value;
							var orderNumber = document.getElementById('odNo').value;
							var customerId = document.getElementById('memberId').value;
							var customerName = document.getElementById('odMname').value;
							var customerPhone = document.getElementById('odMphone').value;
							var customerEmail = document.getElementById('odMemail').value;
							
							
							//console.log("totalPrice: "  + totalPrice)
							console.log("orderNumber: "  + orderNumber)
							console.log("customerId: "  + customerId)
							console.log("customerName: "  + customerName)
							console.log("customerPhone: "  + customerPhone)
							console.log("customerEmail: "  + customerEmail)
							
							let totalPrice = 0; //금액 초기화
							
							// 상품 정보를 가져오는 부분
							const items = Array.from(document.querySelectorAll('[id^="odNum-"]')).map(input => {
						    const productNum = input.value;
						    const qty = parseInt(document.getElementById(`odAmount-` + productNum).value) || 0; // 수량
						    const price = parseInt(document.getElementById(`productPrice-` + productNum).value.replace(/[^0-9]/g, '')) || 0; // 가격
						
						    // 유효성 검사: 수량과 가격이 유효한지 확인
						    if (qty > 0 && price > 0) {
						        totalPrice += price; // 가격을 총 금액에 추가
						    }
							
							    
							
							    console.log("productNum : " + productNum);
							    console.log("qty : " + qty);
							    console.log("price : " + price);
							    console.log("totalPrice : " + totalPrice);
							    
							    
							    return {
							        "id": productNum,
							        "name": document.getElementById(`productName-` + productNum).value,
							        "qty": qty,
							        "price": price
							    };
							});
							
							// 최종적으로 계산된 총 금액을 사용
							console.log("Calculated totalPrice: " + totalPrice);
							
							Bootpay.requestPayment({
					            "application_id": "6703330ccc5274a3ac3fc385",
					            "price": totalPrice,
					            "order_name": "주문 결제",
					            "order_id": orderNumber,
					            "pg": "",
					            "method": "card",
					            "tax_free": 0,
					            "user": {
					                "id": customerId,
					                "username": customerName,
					                "phone": customerPhone,
					                "email": customerEmail
					            },
					            "items": items,
					            "extra": {
					                "open_type": "iframe",
					                "card_quota": "0,2,3",
					                "escrow": false
					            }
					        }).then(function(response) {
					            console.log(response);  // 결제 성공 시 처리할 코드
					            alert('결제가 성공적으로 처리되었습니다!');
					            document.querySelector('form').submit();
					        }).catch(function(error) {
					            console.error(error);  // 결제 실패 시 처리할 코드
					            alert("결제에 실패했습니다. 다시 시도해주세요.");
					        });
					    });
						
							function validateForm() {
						        const requiredFields = [
						        	document.getElementById('name-input'),
						        	document.getElementById('phone-input'),
						        	document.getElementById('email-input'),
						        	document.getElementById('recipient-input'),
						        	document.getElementById('rphone-input'),
						        	document.getElementById('zcode-input'),
						        	document.getElementById('raddress-input'),
						        	document.getElementById('memo-select') 
						        ];

						        for (const field of requiredFields) {
						        	if (field.type === 'text' && field.style.display === 'none') {
						                continue;  // 필드가 보이지 않으면 검사하지 않음
						            }
						        	
						        	if (!field.value) {
						                return false; // 필드가 비어있으면 false 반환
						            }
						        }
						        return true; // 모든 필드가 채워졌으면 true 반환
						    }
						</script>
		    	</div>
		    </div>		    
	   </div>
	   </form>
	</div>	
	
<script> 
// 회원정보가 담긴 span의 텍스트를 가져와서 숨겨진 입력 필드에 설정		
document.getElementById('odMname').value = document.getElementById('name-content').innerText; 

document.getElementById('odMphone').value = document.getElementById('phone-content').innerText; 

document.getElementById('odMemail').value = document.getElementById('email-content').innerText; 

document.getElementById('odRecipient').value = document.getElementById('recipient-name').innerText; 

document.getElementById('odRphone').value = document.getElementById('recipient-phone').innerText; 

document.getElementById('odRzcode').value = document.getElementById('zcode-content').innerText; 

document.getElementById('odRaddress').value = document.getElementById('recipient-address').innerText; 

document.getElementById('odRaddress2').value = document.getElementById('recipient-detail-address').innerText; 

</script>

<%@ include file="kakaoCh.jsp" %>
					
<%@ include file="footer.jsp" %>
<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>