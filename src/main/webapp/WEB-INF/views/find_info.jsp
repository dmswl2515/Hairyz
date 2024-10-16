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
/// 이메일 마스킹 함수
function maskEmail(email) {
    const parts = email.split('@'); // '@'를 기준으로 이메일을 나누기
    const username = parts[0]; // 이메일의 사용자 이름 부분
    const domain = parts[1]; // 이메일의 도메인 부분

    // 사용자 이름 길이가 4글자 이상인 경우 첫 4글자 표시하고 나머지 마스킹
    if (username.length > 4) {
        const visibleLength = 4; // 항상 첫 4글자를 보이도록 설정
        const maskedUsername = username.substring(0, visibleLength) + '*'.repeat(username.length - visibleLength);
        return maskedUsername + '@' + domain;
    } else {
        // 사용자 이름이 4글자 이하인 경우, 첫 1~2글자만 보이고 나머지는 마스킹
        const visibleLength = Math.floor(username.length / 2); // 사용자 이름 절반 정도만 보이도록 설정
        const maskedUsername = username.substring(0, visibleLength) + '*'.repeat(username.length - visibleLength);
        return maskedUsername + '@' + domain;
    }
}


$(document).ready(function() {
	//아이디 찾기
	$('#findIdForm').on('submit', function(e) {
	    e.preventDefault();
	    console.log("아이디 찾기 버튼이 클릭되었습니다.");
	    $.post('/findId', { phone: $('input[name="phone"]').val() })
	        .done(function(data) {
	        	const maskedEmail = maskEmail(data); // 이메일 마스킹 함수 호출
	            alert(maskedEmail + "로 아이디가 전송되었습니다.");
	        })
	        .fail(function() {
	            alert("해당 전화번호로 가입된 회원이 없습니다.");
	        });
	});
	
	// 비밀번호 찾기
	$('#findPwForm').on('submit', function(e) {
	    e.preventDefault();
	    const email = $('input[name="id"]').val();
	    $.post('/findPw', { id: email })
	        .done(function() {
	            const maskedEmail = maskEmail(email);
	            alert(maskedEmail + "로 비밀번호가 전송되었습니다.");
	        })
	        .fail(function() {
	            alert("해당 아이디로 가입된 회원이 없습니다.");
	        });
	});
});
</script>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">	
<style>
.mt_15 { margin-top:15px; }
.container.find { width:100%;max-width:400px;align-self:center;text-align:center; }
.find-wrapper { width:100%;max-width:400px;padding:20px; }
.find-area { margin-bottom:0;text-align:right; }
.find-wrapper button { margin:10px 0 0;width:100%;height:50px;color:#fff;padding:10px 20px; }
.invalid-feedback { margin-top:0;margin-bottom:.25rem;text-align:left; }
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
	<form id="findIdForm">
		<div class="find-wrapper">
		    <input type="text" id="phone" name="phone" class="form-control" placeholder="전화번호 입력 ex) 010-1234-5678" required />
		    <button type="submit" class="btn btn-secondary">아이디 찾기</button>
		</div>
	</form>
	<hr>
	
	<div class="py-3 text-center">
        <h3>비밀번호 찾기</h3>
 	</div>
	<form id="findPwForm">
		<div class="find-wrapper">
		    <input type="text" id="id" name="id" class="form-control" placeholder="아이디 입력 ex) hairyz@example.com" required />
		    <button type="submit" class="btn btn-secondary">비밀번호 찾기</button>
		</div>
	</form>
	
</div>

<%@ include file="kakaoCh.jsp" %>
<%@ include file="footer.jsp" %>

<!-- Bootstrap JS, Popper.js, and jQuery -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
		
</body>
</html>