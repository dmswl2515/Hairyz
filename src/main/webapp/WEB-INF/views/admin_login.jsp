<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>로그인 | 관리자 페이지</title>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="http://code.jquery.com/jquery.js"></script>
<script>
function form_check(event) {
	event.preventDefault(); // Prevent default form submission
	event.stopPropagation(); // Stop propagation of the event

	var form = document.getElementById('login_frm');

	if (form.checkValidity() === false) {
		form.classList.add('was-validated');
		return;
	}
		
	submit_ajax();
}

function submit_ajax() {
	var queryString = $("#login_frm").serialize();
	$.ajax({
		url: '/loginOk_admin.do',
		type: 'POST',
		data: queryString,
		dataType: 'text',
		success: function(json) {
			console.log(json); 
			var result = JSON.parse(json);
			if (result.code == "success") {
				alert(result.desc);
				window.location.replace("memberManagement.do");
			} else {
				alert(result.desc);
			}
		}
	});
}

</script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">	
<style>
/* 기본 레이아웃 설정 */
body {
    display: flex;
    flex-direction: column;
	align-items: center;
    min-height: 100vh;
    margin: 0;
}
/* 내용물이 차지할 공간을 유지 */
.content {
    flex: 1;
}
.mt_15 { margin-top:15px; }
.login-wrapper { width:100%;max-width:400px;align-self:center;text-align:center; }
.login-container { width:100%;max-width:400px;padding:20px;border:1px solid #999;border-radius:.25rem; }
.find-area { margin-bottom:0;text-align:right; }
.find-area  a { color:#333; }
.oauth-buttons button { margin:10px 0 0;width:100%;height:50px;color:#fff;padding:10px 20px; }
.invalid-feedback { marin-top:0;margin-bottom:.25rem;text-align:left; }
</style>
</head>
<body>
<div class="content py-5">

	<div class="container">
		<div class="py-5 text-center">
			<h2>관리자 로그인</h2>
		</div>
	</div>
	<div class="login-wrapper">
		<form id="login_frm" class="needs-validation" novalidate>
			<div class="login-container">
				<input type="text" class="form-control" id="id" name="id" placeholder="아이디" required> 
				<div class="invalid-feedback">아이디를 입력해주세요.</div>
				<input type="password" class="form-control mt_15" id="ow" name="pw" placeholder="비밀번호" required>
				<div class="invalid-feedback">비밀번호를 입력해주세요.</div>
				<div class="oauth-buttons mt_15">
					<button type="button" class="btn btn-dark" onclick="form_check(event)">로그인</button><br>
				</div>
			</div>
		</form>
		<script>
		// Example starter JavaScript for disabling form submissions if there are invalid fields
		(function() {
		  'use strict';
		  window.addEventListener('load', function() {
			// Fetch all the forms we want to apply custom Bootstrap validation styles to
			var forms = document.getElementsByClassName('needs-validation');
			// Loop over them and prevent submission
			var validation = Array.prototype.filter.call(forms, function(form) {
			  form.addEventListener('submit', function(event) {
				if (form.checkValidity() === false) {
				  event.preventDefault();
				  event.stopPropagation();
				}
				form.classList.add('was-validated');
			  }, false);
			});
		  }, false);
		})();
	</script>
	</div>

</div>
<!-- Bootstrap JS, Popper.js, and jQuery -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
		
</body>
</html>