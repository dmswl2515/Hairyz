<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/lang/summernote-ko-KR.js"></script>
<%@ include file="navbarStyle.jsp" %>
<meta charset="UTF-8">
<title>${board.bd_title} | 털뭉치즈</title>
<style>
.mt_15 { margin-top:15px; }
body { font-family: 'Roboto', sans-serif; }
.container.write { max-width: 600px; margin: 50px auto 10px; padding: 20px; background-color: white; 
				   border-radius: 12px; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); border: 1px solid #ffc107; }
</style>
<script>
$(document).ready(function() {
	$('#ir1').summernote({
		height: 400,
		lang: 'ko-KR',
		placeholder: '내용을 입력해주세요.',
		callbacks: {
			onImageUpload: function(files) {
                if (files && files.length > 0) {
                    uploadFile(files[0]);
                } else {
                    alert("이미지를 선택해 주세요.");
                }
            },
            onMediaDelete: function(target) {  // 이미지 삭제 콜백 추가
                deleteFile(target[0].src);  // 삭제된 이미지 경로를 서버로 전달
            }
		}
	});
    $('#ir1').summernote('code', '${board.bd_content}'); // 기존 내용 설정
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

// 수정 완료 버튼 이벤트
function submitEdit() {
    var content = $('#ir1').summernote('code'); // 썸머노트 내용 가져오기

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

 	// 기존 bd_content 필드가 있는지 확인하고, 추가로 덮어쓰지 않음
    var formData = new FormData($('#edit_form')[0]);
    if (!formData.has("bd_content")) {
        formData.append("bd_content", content); // 썸머노트 내용 추가
    }

    
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
    // Ajax 요청으로 수정된 데이터 전송
    $.ajax({
        url: basePath + '/editOk.do',  // 수정 처리 서버 경로
        type: 'POST',
        data: formData, 
        dataType: 'json',
        contentType: false,
        processData: false,
        success: function(response) {
            console.log("응답 데이터:", response);
            if (response.result === "success") {  // response.code -> response.result
                alert("게시글 수정이 완료되었습니다.");
                window.location.href = response.redirectUrl;  // 성공시 게시글 상세보기 페이지로 이동
            } else {
                alert(response.message || "알 수 없는 오류가 발생했습니다.");  // response.message가 없을 경우 대비
            }
        },
        error: function(xhr) {
            console.error("AJAX 오류:", xhr);
            if (xhr.status === 403) {
                alert("로그인이 필요합니다.");
            } else {
                alert("게시글 수정 중 오류가 발생했습니다.");
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
<div class="container write">
	<form id="edit_form" name="edit_form" method="post" enctype="multipart/form-data">
        <input type="hidden" name="bd_no" id="bd_no" value="${board.bd_no}"> <!-- 게시글 번호 -->
		<input type="hidden" name="mb_id" value="${board.mb_id}" />
        
		<div class="form-group">
			<select name="bd_cate" id="bd_cate" class="form-control">
                <option value="" disabled>카테고리 선택</option>
                <option value="f" ${board.bd_cate == 'f' ? 'selected' : ''}>자유</option>
                <option value="q" ${board.bd_cate == 'q' ? 'selected' : ''}>질문</option>
            </select>
		</div>
		

		<div class="form-group">
			<input type="text" name="bd_title" id="bd_title" class="form-control" placeholder="제목" value="${board.bd_title}">
		</div>

		<div class="form-group">
			<textarea name="bd_content" id="ir1" class="form-control" rows="10" placeholder="내용을 입력하세요"></textarea>
		</div>

		<div class="form-group text-center">
			<button type="button" class="btn btn-primary" onclick="submitEdit()">수정 완료</button>
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