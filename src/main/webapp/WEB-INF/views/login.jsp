<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>로그인</title>
<script src="http://code.jquery.com/jquery.js"></script>
<script src="https://accounts.google.com/gsi/client" async defer></script>
<script src="https://cdn.jsdelivr.net/npm/jwt-decode@3.1.2/build/jwt-decode.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

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
	
	// 서버로 데이터 전송
	var xhr = new XMLHttpRequest();
	xhr.open("POST", "checkAndRegisterUser.do", true);
	xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
	xhr.onreadystatechange = function() {
		if (xhr.readyState === 4 && xhr.status === 200) {
			var jsonResponse = JSON.parse(xhr.responseText);
			// 로그인 처리
			window.location.href = "select_login_view.do";
		}
	};
	xhr.send(JSON.stringify({
		id: profile.sub,
		nickname: profile.name,
		email: profile.email
	}));

}

/* ------------------------------------------------------------------------------------------ */

/* Kakao.init('2e8d17510ccb320292db80fcce197c79');
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
   
   Kakao.init('2e8d17510ccb320292db80fcce197c79');
   function loginWithKakao() {
       Kakao.Auth.login({
           success: function(authObj) {
               Kakao.API.request({
                   url: '/v2/user/me',
                   success: function(res) {
                       var id = res.id;
                       var nickname = res.properties.nickname;
                       var email = res.kakao_account.email;

                       // 서버로 데이터 전송
                       var xhr = new XMLHttpRequest();
                       xhr.open("POST", "checkAndRegisterUser.do", true);
                       xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
                       xhr.onreadystatechange = function() {
                           if (xhr.readyState === 4 && xhr.status === 200) {
                               var jsonResponse = JSON.parse(xhr.responseText);
                               if (jsonResponse.exists) {
                                   // 로그인 처리
                                   window.location.href = "select_login_view.do";
                               } else {
                                   // 자동 회원 등록 후 로그인 처리
                                   window.location.href = "select_login_view.do";
                               }
                           }
                       };
                       xhr.send(JSON.stringify({ id: id, nickname: nickname, email: email }));
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
   
   window.fbAsyncInit = function() {
	FB.init({
		appId: '1475168373374256',
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
	} 
}

function getFBUserInfo() {
	FB.api('/me', {fields: 'id,name,email'}, function(response) {
		console.log('ID: ' + response.id);
		console.log('Name: ' + response.name);
		console.log('Email: ' + response.email);

		// 서버로 데이터 전송
		var xhr = new XMLHttpRequest();
		xhr.open("POST", "checkAndRegisterUser.do", true);
		xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
		xhr.onreadystatechange = function() {
			if (xhr.readyState === 4 && xhr.status === 200) {
				// 로그인 처리
				window.location.href = "select_login_view.do";
			}
		};
		xhr.send(JSON.stringify({
			id: response.id,
			nickname: response.name,
			email: response.email
		}));
	});
}

function fbLogin() {
	FB.login(function(response) {
		statusChangeCallback(response);
	}, {
		scope: 'public_profile, email'
	});
}

</script>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">	
<style>
.login-wrapper { width:100%;max-width:400px;align-self:center;text-align:center; }
.login-container { width:100%;max-width:400px;padding:20px;border:1px solid #999;border-radius:.25rem; }
.login-container input { margin-bottom:15px; }
.find-area { margin-bottom:0;text-align:right; }
.find-area  a { color:#333; }
.oauth-buttons button { margin:10px 0 0;width:100%;height:50px;color:#fff;padding:10px 20px; }
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
	<form action="login.do" method="post">
		<div class="login-container">
			<input type="text" class="form-control" name="id" placeholder="아이디" required> 
			<input type="password" class="form-control" name="pw" placeholder="비밀번호" required>
			<p class="find-area"><a href="find.do">아이디 / 비밀번호 찾기</a></p>
		</div>
		<div class="oauth-buttons">
			<button type="submit" class="btn btn-dark">로그인</button><br>
			<button type="button" class="btn btn-warning" onclick="loginWithKakao();">Kakao 로그인</button><br>
			<button type="button" class="btn btn-danger" onclick="onSignIn();">Google 로그인</button><br>
			<button type="button" class="btn btn-primary" onclick="fbLogin();">Facebook 로그인</button>
			<button type="button" class="btn btn-secondary" onclick="javascript:window.location='join.do'">회원가입</button><br>
		</div>
	</form>
</div>

<%@ include file="footer.jsp" %>

<!-- Bootstrap JS, Popper.js, and jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
		
</body>
</html>