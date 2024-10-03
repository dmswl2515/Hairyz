<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
	 
	 body {
	     display: flex;
	     margin: 0;
	 }
	 
	 .container1 {
            display: flex; /* 플렉스 컨테이너로 설정 */
            width: 100%; /* 전체 너비 사용 */
            margin-top:20px;
     }
	
	 .left {
	     flex: 4; /* 왼쪽 영역의 비율 */
	     padding: 20px;
	     background-color: #fff9c4; /* 배경 색상 */
	 }
	
	 .right {
	     flex: 2; /* 오른쪽 영역의 비율 */
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
	    width: 230px;
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
		<div class=container1>
		    <div class="left">
		        <div class="box" style="height:170px;">
		        	<img src="${pageContext.request.contextPath}/upload/${product.pd_chng_fname}" alt="${product.pdName}">
		        	<div class="box-text">
			        	<span class=product-name>${product.pdName}스윗츄 가수분해 덴탈</span>
			           	<span style="font-size: 13px;">수량 : 1</span>
			            <span style="font-size: 16px; font-weight: bold;">
			              	<fmt:formatNumber value="${product.pd_price}" pattern="#,##0원" />
			              	18,900원
			            </span>
			        </div>
		        </div>
		        
		        <div class="box2">
		        	<div class="order-info">
			        	<span class="textbold">주문자 정보</span>    
        
				        <span id="name-content" class="text-content">김은지</span>
				        <input type="text" id="name-input" class="text-content" style="display: none;"/>
				        
				        <span id="phone-content" class="text-content">01024114682</span>
				        <input type="text" id="phone-input" class="text-content" style="display: none; value="01024114682" />
				        
				        <span id="email-content" class="text-content">dmswl2515@gmail.com</span>
				        <input type="text" id="email-input" class="text-content" style="display: none;" value="dmswl2515@gmail.com" />   
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
			    
			    		<span id="recipient-name" class="text-content">김은지</span>
					    <input id="recipient-input" type="text" class="text-content" style="display:none;" value="김은지"/>
					
						<span id="recipient-phone" class="text-content">01024114682</span>
						<input id="rphone-input" type="text" style="display:none;" value="01024114682"/>					    
					    
					    <div style="display: flex; align-items: center; gap: 10px;">
						    <span id="zcode-content" class="text-content">2321</span>
						    <input id="zcode-input" type="text" class="text-content" style="display:none; width:175px;" value="2321"/>
						    <button id="zcode-button" class="btn btn-secondary zcode-button" style="display:none; width:175px;">우편번호 확인</button>
						</div>
						
					    <span id="recipient-address" class="text-content">서울 성동구 서울숲길 17(성수동1가, 성수파크빌)</span>
						<input id="raddress-input" type="text" style="display:none;" value="서울 성동구 서울숲길 17(성수동1가, 성수파크빌)"/>
						
						<span id="recipient-detail-address" class="text-content">915동 113호</span>
						<input id="rdaddress-input" type="text" style="display:none;" value="915동 113호"/>
														        	
		        	 	<span class="textbold" style="margin-top:10px; margin-bottom:10px;">배송 메모</span>    
			       		<div id="memo-select-container">
						    <select id="memo-select" name="memo" style="width:430px; height:35px; margin-bottom:10px;" required>
						        <option value="memo1">배송 전 미리 연락바랍니다.</option>
						        <option value="memo2">부재시 경비실에 맡겨주세요.</option>
						        <option value="memo3">부재시 전화나 문자를 남겨주세요.</option>
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
    const rdaddressInput = document.getElementById('rdaddress-input');

    
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
		        
		    
		    </div>
		    <div class="right">
		        <div class="box2">
		        	<div class="order-summary">
			        	<span class="textbold">주문 요약</span>    
			       
			        	<span class="text-content">상품 가격
				        	<span class="text-content"style="margin-left:100px;">
					        		<fmt:formatNumber value="${product.pd_price}" pattern="#,##0원" />
					              	18,900원
				        	</span>
			        	</span>
			        	
			        	<span class="text-content">배송비
			        		<span class="text-content" style="margin-left:158px;">
					        		<fmt:formatNumber value="${product.pd_price}" pattern="#,##0원" />
					              	0원
				        	</span>
			        	</span>
			        	
			        	<hr class="custom-hr">
			        	    
			        	<span class="text-content" style="font-weight: bold;">총 주문 금액
			        		<span class="text-content"style="margin-left:70px;">
					        		<fmt:formatNumber value="${product.pd_price}" pattern="#,##0원" />
					              	18,900원
				        	</span>
			        	</span>
			        </div>
		        </div>
		        
		        
		        <div class="box2">
		        	<div class="order-summary">
			        	<span class="textbold">결제 수단</span>    
			       		<div class="form-group">
						    <div class="form-check">
						        <input class="form-check-input" type="radio" name="paymentMethod" id="creditCard" value="신용카드">
						        <label class="form-check-label" for="creditCard">
						            신용카드
						        </label>
						    </div>
						    <div class="form-check">
						        <input class="form-check-input" type="radio" name="paymentMethod" id="payco" value="PAYCO">
						        <label class="form-check-label" for="payco">
						            PAYCO
						        </label>
						    </div>
						</div>	       					        	
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
		    		<span class="textbold" style="display: inline-block; width: 100%;">결제하기</span>
		    	</div>
		    </div>
		    
		</div>
	</div>

					
<%@ include file="footer.jsp" %>
<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>