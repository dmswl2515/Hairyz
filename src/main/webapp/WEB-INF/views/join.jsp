<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>회원가입</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>

<script src="http://code.jquery.com/jquery.js"></script>

<!-- 우편번호 검색 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style>
.captcha-image {
    border: 1px solid #000; /* 윤곽선 추가 */
    border-radius: .25rem;
}
.btn.captcha { height:52px; }
</style>

<!-- 캡차 새로고침 기능 -->
<script>
function refreshCaptcha() {
	document.getElementById('captchaImg').src = '/captcha/image?' + new Date().getTime();
}
</script>

<script>
var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
var phonePattern = /^010-\d{4}-\d{4}$/;
var isCaptchaVerified = false; // 캡차 인증 상태를 저장하는 변수


//이메일 중복확인 기능
function checkDuplicateEmail() {
	var email = $('#mb_id').val();
	if (!emailPattern.test(email)) {
		alert("유효한 이메일 주소를 입력해주세요.");
		$('#mb_id').focus();
		return;
	}

	$.ajax({
	    url: '/checkDuplicateEmail.do', // 절대 경로로 수정
	    type: 'POST',
	    data: { mb_id: email },
	    success: function(response) {
	        if (response === 'exists') {
	            alert("이미 사용중인 이메일입니다.");
	            $('#mb_id').focus();
	        } else {
	            alert("사용 가능한 이메일입니다.");
	        }
	    },
	    error: function(xhr, status, error) {
         alert("이메일 중복 확인 중 오류가 발생했습니다: " + error);
         console.log("Error details: ", xhr.responseText); // 오류 내용 콘솔에 출력
     }
	});
}

//우편번호 검색 기능
function searchZipcode() {
 new daum.Postcode({
     oncomplete: function(data) {
         // 선택한 주소의 우편번호와 주소를 입력
         document.getElementById('mb_zipcode').value = data.zonecode; // 우편번호
         document.getElementById('mb_addr1').value = data.roadAddress; // 도로명 주소
         document.getElementById('mb_addr2').focus(); // 상세주소 입력으로 포커스 이동
     }
 }).open();
}

function checkCaptcha() {
    var userCaptcha = $('#captchaInput').val(); // 사용자 입력 캡차 값 가져오기
    $.ajax({
        url: '/captcha/verify',
        type: 'POST',
        data: { userCaptcha: userCaptcha },
        success: function(response) {
            if (response === "캡차 인증이 완료되었습니다!") {
            	alert(response); 
				isCaptchaVerified = true; // 캡차 인증 완료 상태로 변경
            } else {
                alert(response); // 캡차 인증 실패 시 알림
				isCaptchaVerified = false; // 캡차 인증 실패 상태로 유지
            }
        },
        error: function() {
            alert("캡차 확인 중 오류가 발생했습니다.");
        }
    });
}

var isSnsMember = false; // 일반 회원은 기본적으로 false
var snsEmail = ''; // SNS 로그인 시 받은 이메일

//만약 SNS 로그인 후 회원가입 페이지로 이동한 경우
function setSnsMember(snsLoginEmail) {
    isSnsMember = true;
    snsEmail = snsLoginEmail;
    $('#mb_id').val(snsLoginEmail);  // SNS에서 받아온 이메일로 입력 필드 설정
    $('#mb_id').prop('readonly', true);  // 이메일 필드를 수정 불가로 설정
}

function form_check(event) {
	event.preventDefault(); // 기본 제출 방지
	event.stopPropagation(); // 이벤트 전파 방지

	var form = document.getElementById('reg_frm');

	if (form.checkValidity() === false) {
		form.classList.add('was-validated');
		return;
	}

	// 이메일 형식 확인
	if (!emailPattern.test($('#mb_id').val())) {
		alert("유효한 이메일 주소를 입력해주세요.");
		$('#mb_id').focus();
		return;
	}

	// 핸드폰 번호 형식 확인
	if (!phonePattern.test($('#mb_phone').val())) {
		alert("핸드폰 번호는 '010-0000-0000' 형식이어야 합니다.");
		$('#mb_phone').focus();
		return;
	}

	// 캡차 인증 상태 확인
	if (!isCaptchaVerified) {
		alert("캡차 인증이 필요합니다.");
		return;
	}

	// 모든 조건이 충족되면 AJAX 호출
	submit_ajax();
}


function submit_ajax() {
	var queryString = $("#reg_frm").serialize();
	
	if (isSnsMember) {
        queryString += "&mb_sns=Y";
    }
	
	$.ajax({
		url: '/joinOk.do',
		type: 'POST',
		data: queryString,
		dataType: 'text',
		success: function(json) {
			console.log(json); 
			var result = JSON.parse(json);
			if (result.code == "success") {
				alert(result.desc);
				window.location.replace("login.do");
			} else {
				alert(result.desc);
			}
		}
	});
}

</script>
</head>
<body>
<div class="content">
	<%@ include file="header.jsp" %>
</div>
	
<div class="container">
	<div class="py-5 text-center">
        <h2>회원 정보 입력</h2>
		<p><code>*</code> 필수 입력 항목입니다</p>
     	</div>
     	<div class="row justify-content-md-center pb-5">
		<div class="col-lg-6 col-md-8">
			<form id="reg_frm" class="needs-validation" novalidate>
				<div class="mb-3">
					<label for="mb_id">아이디(이메일) <code>*</code></label> 
					<div class="input-group">
						<input type="email" id="mb_id" name="mb_id" class="form-control" size="20" placeholder="you@example.com" required>
						<button type="button" class="btn btn-outline-secondary ml-1" onclick="checkDuplicateEmail()">중복확인</button>
					</div>
					<div class="invalid-feedback">이메일은 필수 항목입니다.</div>
				</div>
				<div class="mb-3">
					<label for="mb_pw">비밀번호 <code>*</code></label>
					<input type="password" id="mb_pw" name="mb_pw" class="form-control" size="20" placeholder="" required>
					<div class="invalid-feedback">비밀번호는 필수 항목입니다.</div>
				</div>
				<div class="mb-3">
					<label for="pw_check">비밀번호 확인 <code>*</code></label>
					<input type="password" id="pw_check" name="pw_check" class="form-control" size="20" placeholder="" required>
					<!-- <div class="invalid-feedback">비밀번호 확인은 필수 항목입니다.</div> -->
					<div class="invalid-feedback feedback-message" style="display: none;"></div> <!-- 초기에는 숨김 -->

					<script>
					    // 비밀번호 확인 일치 여부를 체크하는 함수
					    function checkPasswordMatch() {
					        const password = $('#mb_pw').val();
					        const passwordCheck = $('#pw_check').val();
					        const feedbackElement = $('.feedback-message'); // 피드백 메시지 요소 선택
					
					        if (password !== passwordCheck) {
					            $('#pw_check').addClass('is-invalid'); // 입력란에 invalid 클래스 추가
					            feedbackElement.text("비밀번호가 일치하지 않습니다."); // 메시지 표시
					            feedbackElement.css('color', '#dc3545'); // 빨간색
					            feedbackElement.show(); // 메시지 표시
					        } else {
					            $('#pw_check').removeClass('is-invalid'); // 입력란에서 invalid 클래스 제거
					            feedbackElement.text("비밀번호가 일치합니다."); // 메시지 표시
					            feedbackElement.css('color', '#28a745'); // 녹색
					            feedbackElement.show(); // 메시지 표시
					        }
					    }
					
					    // pw와 pw_check 입력 시 실시간 체크
					    $('#mb_pw, #pw_check').on('keyup', checkPasswordMatch);
					</script>
					
					<style>
					    /* invalid 클래스가 적용되었을 때 테두리 색상 변경 */
					    .is-invalid {
					        border-color: #dc3545 !important; /* 빨간색 테두리 */
					    }
					    /* 포커스 상태일 때도 빨간색 테두리 */
					    .is-invalid:focus {
					        border-color: #dc3545 !important; /* 빨간색 테두리 */
					        box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25); /* 빨간색 그림자 */
					    }
					</style>
				</div>
				<div class="mb-3">
					<label for="mb_name">이름 <code>*</code></label>
					<input type="text" id="mb_name" name="mb_name" class="form-control" required>
					<div class="invalid-feedback">이름은 필수 항목입니다.</div>
				</div>
				<div class="mb-3">
					<label for="mb_nickname">닉네임 <code>*</code></label>
					<input type="text" id="mb_nickname" name="mb_nickname" class="form-control" required>
					<div class="invalid-feedback">닉네임은 필수 항목입니다.</div>
				</div>
				<div class="mb-3">
					<label for="mb_phone">핸드폰 번호 <code>*</code></label>
					<input type="text" id="mb_phone" name="mb_phone" class="form-control" placeholder="010-0000-0000" required>
					<div class="invalid-feedback">핸드폰 번호는 필수 항목입니다.</div>
				</div>
				<div class="mb-3">
					<label for="mb_zipcode">우편번호 <code></code></label>
					<div class="input-group">
						<input type="text" id="mb_zipcode" name="mb_zipcode" class="form-control">
						<button type="button" class="btn btn-outline-secondary ml-1" onclick="searchZipcode()">우편번호 검색</button>
					</div>
				</div>
				<div class="mb-3">
					<label for="mb_addr1">주소 <code></code></label>
					<input type="text" id="mb_addr1" name="mb_addr1" class="form-control">
				</div>
				<div class="mb-3">
					<label for="mb_addr2">상세주소 <code></code></label>
					<input type="text" id="mb_addr2" name="mb_addr2" class="form-control">
				</div>
				<div class="mb-3">
				    <label for="captchaInput">캡차 <code>*</code></label><br>
				    <img id="captchaImg" src="/captcha/image" alt="캡차 이미지" class="captcha-image" />
				    <button type="button" class="btn btn-outline-secondary captcha" onclick="refreshCaptcha()">새로 고침</button>
					<div class="input-group mt-2">
					    <input type="text" id="captchaInput" name="captchaInput" class="form-control" required>
					    <button type="button" class="btn btn-outline-success ml-1" onclick="checkCaptcha()">캡차 확인</button>
					    <div class="invalid-feedback">캡차는 필수 항목입니다.</div>
					</div>
				</div>
				<hr class="mb-4">
				<input type="button" class="btn btn-primary btn-lg btn-block" value="회원가입" onclick="form_check(event)"> 
				<input type="button" class="btn btn-outline-secondary btn-lg btn-block" value="로그인" onclick="window.location='login.do'">
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
</div>


<%@ include file="footer.jsp" %>

<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

</body>
</html>
