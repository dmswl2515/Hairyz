<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* PC 카카오톡 채널 버튼 위치 */
.kakaoChatPc {
    position: fixed;
    z-index: 999;
    right: 20px; /* 화면 오른쪽으로부터의 거리, 숫자만 입력 */
    bottom: 20px; /* 화면 아래쪽으로부터의 거리, 숫자만 입력 */
}
</style>
</head>
<body>
<!-- PC 카카오톡 상담 버튼 -->
<a href="javascript:void kakaoChatStart()" class="kakaoChatPc hidden-md hidden-sm hidden-xs">
    <img src="https://vendor-cdn.imweb.me/images/kakao-talk-button-default.svg" width="72px" height="72px">
</a>

<!-- 카카오톡 채널 스크립트 -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type='text/javascript'>
    Kakao.init('${kakaoKey}'); // 사용할 앱의 JavaScript키를 입력해 주세요.
    function kakaoChatStart() {
        Kakao.Channel.chat({
            channelPublicId: '_PvBZn' // 카카오톡 채널 홈 URL에 명시된 ID를 입력합니다.(1단계에서 복사한 값)
        });
    }
</script>
</body>
</html>