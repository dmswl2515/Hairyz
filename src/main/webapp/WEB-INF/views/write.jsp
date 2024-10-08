<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>게시글 작성 | 커뮤니티</title>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript" src="/naver-editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">	
<style>
.mt_15 { margin-top:15px; }
.container.find { width:100%;max-width:400px;align-self:center;text-align:center; }
.find-wrapper { width:100%;max-width:400px;padding:20px; }
.find-area { margin-bottom:0;text-align:right; }
.find-wrapper button { margin:10px 0 0;width:100%;height:50px;color:#fff;padding:10px 20px; }
.invalid-feedback { margin-top:0;margin-bottom:.25rem;text-align:left; }
</style>
<script>
function form_check() {
	oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
	
 	//document.write_form.submit();
	submit_ajax();
}

function submit_ajax() {
	var queryString = $("#write_form").serialize();
	$.ajax({
		url: 'write.do',
		type: 'POST',
		data: queryString,
		dataType: 'text',
		success: function(json) {
			var result = JSON.parse(json);
			if (result.code=="success") {
				alert(result.desc)
				window.location.replace("list.do");
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
<div class="container mt_15">
	<table width="800" cellpadding="0" cellspacing="0" border="1">
		<form id="write_form" name="write_form" action="write.do" method="post">
			<tr>
				<td>이름</td>
				<td><input type="text" name="bName" size="50"></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" name="bTitle" size="50"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea name="bContent" id="ir1" rows="10"></textarea></td>
				
				<script type="text/javascript">
				var oEditors = [];
				nhn.husky.EZCreator.createInIFrame({
				    oAppRef: oEditors,
				    elPlaceHolder: "ir1",
				    sSkinURI: "./naver-editor/SmartEditor2Skin.html",
				    fCreator: "createSEditor2"
				});
				</script>
			</tr>
			<tr>
				<td colspan="2">
					<a href="JavaScript:form_check();">입력</a> &nbsp;&nbsp;
					<a href="list.do">목록보기</a>
				</td>
			</tr>
		</form>
	</table>
	
</div>

<%@ include file="footer.jsp" %>

<!-- Bootstrap JS, Popper.js, and jQuery -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
		
</body>
</html>