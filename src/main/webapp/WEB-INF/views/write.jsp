<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>게시글 작성 | 커뮤니티</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">	
<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/lang/summernote-ko-KR.js"></script>


<style>
.mt_15 { margin-top:15px; }
body { font-family: 'Roboto', sans-serif; }
.container.write { max-width: 600px; margin: 50px auto 10px; padding: 20px; background-color: white; 
				   border-radius: 12px; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); border: 1px solid #ffc107; }
.write-title { text-align: center; font-weight: 500; font-size: 24px; margin-bottom: 30px; }
</style>
<script>
$(document).ready(function() {
	$('#ir1').summernote({
		height: 400,                 // set editor height
		lang: 'ko-KR',
		placeholder: '내용을 입력해주세요.',
		callbacks: {
			onImageUpload: function(files) {
                if (files && files.length > 0) {
                    uploadFile(files[0]);
                } else {
                    alert("이미지를 선택해 주세요.");
                }
            }
		}
	});
});

// 이미지 업로드 함수
function uploadFile(file) {
	var formData = new FormData();
	formData.append("file", file);

	var basePath = '${pageContext.request.contextPath}';
	$.ajax({
		url: basePath + '/uploadFile',  // 서버 파일 업로드 처리 경로
		type: 'POST',
		data: formData,
		contentType: false,
		processData: false,
		success: function(response) {
			if (response.success) {
				$('#ir1').summernote('insertImage', response.fileLink);  // 이미지 삽입
				// 성공한 파일 정보를 전역 변수에 저장
				window.uploadedFile = {
					originalFileName: response.originalFileName,
					systemFileName: response.systemFileName,
					fileLink: response.fileLink
				};
			} else {
				alert(response.message);
			}
		},
		error: function() {
			alert("파일 업로드 중 오류가 발생했습니다.");
		}
	});
}

// 작성 완료 버튼 이벤트
function submitPost() {
    var content = $('#ir1').val();

    // 필수 항목 검증
	if ($('#bd_cate').val() === null) {
		alert("카테고리를 선택해주세요.");
		$('#bd_cate').focus();
		return;
	}
    if ($('#bd_title').val().trim() === "") {
        alert("제목을 입력해주세요.");
        $('#bd_title').focus();
        return;
    }
    if (content.trim() === "") {
        alert("내용을 입력해주세요.");
        return;
    }

    // FormData 객체 생성
    $('#ir1').val($('#ir1').summernote('code'));
    var formData = new FormData($('#write_form')[0]);

    
 	// 업로드된 파일 정보를 추가
    if (window.uploadedFile) {
        formData.append("success", true);  // 파일 업로드 성공 여부
        formData.append("originalFileName", window.uploadedFile.originalFileName);
        formData.append("systemFileName", window.uploadedFile.systemFileName);
        formData.append("fileLink", window.uploadedFile.fileLink);
    }
    
    // 데이터 확인
    for (var pair of formData.entries()) {
	    console.log(pair[0]+ ': ' + pair[1]);
	}

    var basePath = '${pageContext.request.contextPath}';
    console.log(basePath);
    // Ajax 요청으로 게시글 데이터 전송
    $.ajax({
        url: basePath + '/writeOk.do',  // 게시글 저장을 위한 서버 경로
        type: 'POST',
        data: formData, 
        dataType: 'json', // FormData 객체로 데이터 전송
        contentType: false,
        processData: false,
        success: function(response) {
            console.log("응답 데이터:", response);
            if (response.result === "success") {  // response.code -> response.result
                alert("게시글 작성이 완료되었습니다.");
                window.location.href = basePath + response.redirectUrl;  // 게시글 목록으로 이동
            } else {
                alert(response.message || "알 수 없는 오류가 발생했습니다.");  // response.message가 없을 경우 대비
            }
        },
        error: function(xhr) {
            console.error("AJAX 오류:", xhr);
            alert("게시글 작성 중 오류가 발생했습니다.");
        }
    });
}
</script>
</head>
<body>
<div class="content">
	<%@ include file="header.jsp" %>
</div>
<div class="container write">
	<form id="write_form" name="write_form" method="post" enctype="multipart/form-data">
		<div class="form-group">
			<select name="bd_cate" id="bd_cate" class="form-control">
				<option value="" disabled selected>카테고리 선택</option>
				<option value="f">자유</option>
				<option value="q">질문</option>
			</select>
		</div>

		<!-- 작성자 필드는 hidden으로 처리 -->
		<input type="hidden" name="mb_id" id="mb_id" value="<%= (String)session.getAttribute("userId") %>">
		<input type="hidden" name="bd_writer" id="bd_writer" value="<%= (String)session.getAttribute("userNickname") %>">
		<!-- 
		<script>
		    console.log("작성자 닉네임: " + document.getElementById('bd_writer').value);
		</script>
		 -->

		<div class="form-group">
			<input type="text" name="bd_title" id="bd_title" class="form-control" placeholder="제목">
		</div>

		<div class="form-group">
			<textarea name="bd_content" id="ir1" class="form-control" rows="10" placeholder="내용을 입력하세요"></textarea>
		</div>

		<div class="form-group text-center">
			<button type="button" class="btn btn-primary" onclick="submitPost()">작성 완료</button>
			<a href="${pageContext.request.contextPath}/list.do" class="btn btn-secondary">목록 보기</a>
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