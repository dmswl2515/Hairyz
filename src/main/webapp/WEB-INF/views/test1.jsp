<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<!--  부트페이  -->
<script src="https://js.bootpay.co.kr/bootpay-5.0.1.min.js" type="application/javascript"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="content">
		<%@ include file="header.jsp" %>
	</div>
	
	<div class="container">
	<button id="paymentButton" class="btn btn-primary"> 결제하기 </button>
	</div>
	
	<script>
	document.getElementById('paymentButton').addEventListener('click', function() {
        Bootpay.requestPayment({
            "application_id": "6703330ccc5274a3ac3fc385",
            "price": 1000,
            "order_name": "테스트결제",
            "order_id": "1000000043",
            "pg": "KCP",
            "method": "card",
            "tax_free": 0,
            "user": {
                "id": "dmswl2515@gmail.com",
                "username": "김은지",
                "phone": "01024114682",
                "email": "test@test.com"
            },
            "items": [
                {
                    "id": "item_id",
                    "name": "머리빗",
                    "qty": 1,
                    "price": 1000
                }
            ],
            "extra": {
                "open_type": "iframe",
                "card_quota": "0,2,3",
                "escrow": false
            }
        }).then(function(response) {
            console.log(response);  // 결제 성공 시 처리할 코드
        }).catch(function(error) {
            console.error(error);  // 결제 실패 시 처리할 코드
        });
    });
	</script>
	
					
	<%@ include file="footer.jsp" %>
<!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>