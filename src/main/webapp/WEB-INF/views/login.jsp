<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>로그인</title>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="http://code.jquery.com/jquery.js"></script>
<script src="https://accounts.google.com/gsi/client" async defer></script>
<script src="https://cdn.jsdelivr.net/npm/jwt-decode@3.1.2/build/jwt-decode.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" type="text/javascript" async defer></script>
<script>
function onSignIn() {
	google.accounts.id
			.initialize({
				client_id : "714732093906-kud1iod6kpo8t9m01k6l6dki2mp461hq.apps.googleusercontent.com",
				callback : handleCredentialResponse
			});
	google.accounts.id.prompt();
}

function handleCredentialResponse(response) {
	var profile = jwt_decode(response.credential);
	console.log("ID: " + profile.sub);
	console.log('Name: ' + profile.name);
	console.log("Image URL: " + profile.picture);
	console.log("Email: " + profile.email);
	
	// 이메일로 회원 여부 확인
    snsLogin(profile.email); // snsLogin 함수 호출

}

/* ------------------------------------------------------------------------------------------ */

/* Kakao.init('3fe60097c9ec0969b537421877e8ae54');
   function loginWithKakao() {
     // 로그인 창을 띄웁니다.
     Kakao.Auth.login({
       success: function(authObj) {
         //alert(JSON.stringify(authObj));
         //signIn(authObj);
       	window.location.href = "select_login_view.do";
       },
       fail: function(err) {
         alert(JSON.stringify(err));
       }
     });
   }; */
   
   Kakao.init('3fe60097c9ec0969b537421877e8ae54');
   function loginWithKakao() {
       Kakao.Auth.login({
           success: function(authObj) {
               Kakao.API.request({
                   url: '/v2/user/me',
                   success: function(res) {
                       var id = res.id;
                       var nickname = res.properties.nickname;
                       var email = res.kakao_account.email || ''; // 이메일이 없을 경우 빈 문자열로 설정
               			console.log('Id: ' + id);
               			console.log('Nickname: ' + nickname);
               			console.log('Email: ' + email);
               			
               			if (!email) {
                            alert("이메일이 제공되지 않아 Kakao 로그인을 진행할 수 없습니다.");
                            return;
                        }

                    	// 이메일로 회원 여부 확인
                       snsLogin(email); // snsLogin 함수 호출
                   },
                   fail: function(error) {
                       console.log(error);
                   }
               });
           },
           fail: function(err) {
               alert(JSON.stringify(err));
           }
       });
   }

	/* ------------------------------------------------------------------------------------------ */

	function initNaverLogin() {
	  naverLogin = new naver.LoginWithNaverId({
	    clientId: "YbQ2xy32RJJryAeB2oB8",
	    callbackUrl: "http://localhost:8081/login.do",
	    isPopup: true,
	    onLogin: function() {
	      naverLogin.getLoginStatus(function(response) {
	        if (response.status) {
	          var email = response.email;
	          snsLogin(email); // SNS 로그인 처리
	        }
	      });
	    }
	  });
	}

/* ------------------------------------------------------------------------------------------ */
   
  // Facebook
   window.fbAsyncInit = function() {
	FB.init({
		appId: '535635602529499',
		cookie: true,
		xfbml: true,
		version: 'v20.0'
	});

	FB.getLoginStatus(function(response) {
		console.log(response);
		statusChangeCallback(response);
	});
};

(function(d, s, id) {
	var js, fjs = d.getElementsByTagName(s)[0];
	if (d.getElementById(id)) return;
	js = d.createElement(s);
	js.id = id;
	js.src = "https://connect.facebook.net/en_US/sdk.js";
	fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

function statusChangeCallback(response) {
	if (response.status === 'connected') {
		getFBUserInfo();
	} else {
		console.log('User not authenticated');
	}
}

function getFBUserInfo() {
	FB.api('/me', {fields: 'id,name,email'}, function(response) {
		console.log('ID: ' + response.id);
		console.log('Name: ' + response.name);
		console.log('Email: ' + response.email);
		
		// 여기에서 snsLogin을 호출하여 이메일로 회원 여부 확인
        snsLogin(response.email); // snsLogin 함수 호출
	});
}

//Facebook 로그인 버튼 클릭 시 실행될 함수
function fbLogin() {
	FB.login(function(response) {
		statusChangeCallback(response);
	}, {
		scope: 'public_profile, email'
	});
}

function snsLogin(snsEmail) {
    $.ajax({
        url: '/checkSnsLoginEmail.do',
        type: 'POST',
        contentType: 'application/json', // Content-Type 설정
        data: JSON.stringify({ email: snsEmail }), // JSON.stringify 사용
        success: function(response) {
            if (response.code === 'exists') {
                alert(response.desc);
                // 기존 회원이므로 바로 로그인 처리
                window.location.href = '/main_view.do';  // 로그인 후 메인 페이지로 이동
            } else if (response.code === 'not_found') {
                alert(response.desc);
                // 새 회원이므로 회원가입 페이지로 이동
                window.location.href = '/join.do?snsEmail=' + encodeURIComponent(snsEmail);
            }
        },
        error: function(xhr, status, error) {
            alert("SNS 로그인 이메일 확인 중 오류가 발생했습니다: " + error);
        }
    });
}


/* ------------------------------------------------------------------------------------------ */
// 일반회원 로그인
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
		url: '/loginOk.do',
		type: 'POST',
		data: queryString,
		dataType: 'text',
		success: function(json) {
			console.log(json); 
			var result = JSON.parse(json);
			if (result.code == "success") {
				alert(result.desc);
				window.location.replace("main_view.do");
			} else {
				alert(result.desc);
			}
		}
	});
}

</script>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">	
<style>
.mt_15 { margin-top:15px; }
.login-wrapper { width:100%;max-width:400px;align-self:center;text-align:center; }
.login-container { width:100%;max-width:400px;padding:20px;border:1px solid #999;border-radius:.25rem; }
.find-area { margin-bottom:0;text-align:right; }
.find-area  a { color:#333; }
.oauth-buttons button { margin:10px 0 0;width:100%;height:50px;color:#fff;padding:10px 20px; }
.invalid-feedback { margin-top:0;margin-bottom:.25rem;text-align:left; }
</style>
</head>
<body>
<div class="content">
	<%@ include file="header.jsp" %>
</div>
<div class="container">
	<div class="py-5 text-center">
        <h2>로그인</h2>
     	</div>
    </div>
<div class="login-wrapper">
	<form id="login_frm" class="needs-validation" novalidate>
		<div class="login-container">
			<input type="text" class="form-control" id="id" name="id" placeholder="아이디" required 
							 		value="${sessionScope.joinId != null ? sessionScope.joinId : ''}"> 
			<div class="invalid-feedback">아이디를 입력해주세요.</div>
			<input type="password" class="form-control mt_15" id="pw" name="pw" placeholder="비밀번호" required>
			<div class="invalid-feedback">비밀번호를 입력해주세요.</div>
			<p class="find-area mt_15"><a href="findInfo.do">아이디 / 비밀번호 찾기</a></p>
		</div>
		<div class="oauth-buttons">
			<button type="button" class="btn btn-dark" onclick="form_check(event)">로그인</button><br>
			<button type="button" class="btn btn-danger" onclick="onSignIn();">Google 로그인</button><br>
			<button type="button" class="btn btn-primary" onclick="fbLogin();">Facebook 로그인</button>
			<button type="button" class="btn btn-warning" onclick="loginWithKakao();">Kakao 로그인</button><br>
			<button type="button" class="btn btn-success" id="naverLoginButton">Naver 로그인</button><br>
			<button type="button" class="btn btn-secondary" onclick="javascript:window.location='join.do'">회원가입</button><br>
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

<%@ include file="footer.jsp" %>

<!-- Bootstrap JS, Popper.js, and jQuery -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
		
</body>
</html>