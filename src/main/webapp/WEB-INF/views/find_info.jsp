<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>아이디/비밀번호 찾기</title>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="http://code.jquery.com/jquery.js"></script>
<script>

</script>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">	
<style>
.mt_15 { margin-top:15px; }
.container.find { width:100%;max-width:400px;align-self:center;text-align:center; }
.find-wrapper { width:100%;max-width:400px;padding:20px; }
.find-area { margin-bottom:0;text-align:right; }
.find-wrapper button { margin:10px 0 0;width:100%;height:50px;color:#fff;padding:10px 20px; }
.invalid-feedback { marin-top:0;margin-bottom:.25rem;text-align:left; }
</style>
</head>
<body>
<div class="content">
	<%@ include file="header.jsp" %>
</div>
<div class="container find mt_15">
	<div class="py-3 text-center">
        <h3>아이디 찾기</h3>
 	</div>
	<form id="findIdForm" method="post" action="/findId">
		<div class="find-wrapper">
		    <input type="text" id="phone" name="phone" class="form-control" placeholder="전화번호 입력 ex) 010-1234-5678" required />
		    <button type="submit" class="btn btn-secondary">아이디 찾기</button>
		</div>
	</form>
	<hr>
	
	<div class="py-3 text-center">
        <h3>비밀번호 찾기</h3>
 	</div>
	<form id="findPwForm" method="post" action="/findPw">
		<div class="find-wrapper">
		    <input type="text" id="phone" name="phone" class="form-control" placeholder="아이디 입력 ex) hairyz@example.com" required />
		    <button type="submit" class="btn btn-secondary">비밀번호 찾기</button>
		</div>
	</form>
	
</div>

<%@ include file="footer.jsp" %>

<!-- Bootstrap JS, Popper.js, and jQuery -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
		
</body>
</html>