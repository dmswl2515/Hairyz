<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* 비공개 버튼 스타일 */
        .toggle-button {
            border: 1px solid #007bff;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
            display: inline-block;
            transition: background-color 0.3s, color 0.3s;
        }

        .toggle-button.selected {
            background-color: #007bff;
            color: white;
        }
</style>
</head>
<body>

					<div class="container d-flex justify-content-end">
				        <input type="button" class="btn btn-warning custom-width mb-3" value="Q&A 작성"  onclick="openModal()"/>
			       	</div>
			       	<!-- 모달 -->
					<div class="modal fade" id="qnaModal" tabindex="-1" role="dialog" aria-labelledby="qnaModalLabel" aria-hidden="true">
					    <div class="modal-dialog" role="document">
					        <div class="modal-content">
					            <div class="modal-header">
					                <h5 class="modal-title text-center" id="qnaModalLabel">Q&A 작성하기</h5>
					                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					                    <span aria-hidden="true">&times;</span>
					                </button>
					            </div>
					            <div class="modal-body">
					                <form id="qnaForm">
					                    <div class="form-group">
					                        <textarea class="form-control" id="qnaContent" rows="7" required placeholder="문의하실 내용을 입력하세요."></textarea>
					                    </div>
					                    <div class="form-group">
					                        <div class="form-check form-check-inline">
					                            <input class="form-check-input" type="radio" name="visibility" id="public" value="공개" checked>
					                            <label class="form-check-label" for="public">
					                                공개
					                            </label>
					                        </div>
					                        <div class="form-check form-check-inline">
					                            <input class="form-check-input" type="radio" name="visibility" id="private" value="비공개">
					                            <label class="form-check-label" for="private">
					                                비공개
					                            </label>
					                        </div>
					                    </div>
					                </form>
					            </div>
					            <div class="modal-footer">
					                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
					                <button type="button" class="btn btn-warning" onclick="submitQnA()">등록</button>
					            </div>
					        </div>
					    </div>
					</div>
<script>
// 모달 열기
function openModal() {
    $('#qnaModal').modal('show');
}

function openModal() {
    // 회원 ID (예시로 하드코딩된 값입니다. 실제로는 동적으로 할당해야 함)
    const userId = getUserId(); // 실제 회원 ID를 가져오는 방법으로 변경할 것

    // AJAX 요청으로 회원 정보 가져오기
    $.ajax({
        url: `/getMemberInfo/${userId}`, // 회원 정보 가져올 URL (서버에 설정된 경로에 따라 수정)
        type: 'GET',
        success: function(memberInfo) {
            // 성공적으로 데이터를 받아온 경우
            console.log(memberInfo);
            $('#qnaModal').modal('show');
        },
        error: function(error) {
            // 오류 처리
            alert('회원 정보를 가져오는 데 실패했습니다.');
        }
    });
}

// Q&A 제출
function submitQnA() {
    const content = document.getElementById('qnaContent').value;
    const visibility = document.querySelector('input[name="visibility"]:checked').value;

    // 유효성 검사 (여기서 추가적인 검사를 할 수 있습니다)
    if (!content) {
        alert('문의 내용을 입력하세요.');
        return;
    }

    // 서버에 데이터를 전송 (예시: AJAX 사용)
    $.ajax({
        url: '/submitQnA', // Q&A를 제출할 URL
        type: 'POST',
        data: {
            content: content,
            visibility: visibility
        },
        success: function(response) {
            // 성공적으로 등록된 후 처리 (예: 알림, 리스트 갱신 등)
            alert('문의가 등록되었습니다.');
            $('#qnaModal').modal('hide');
            document.getElementById('qnaForm').reset(); // 폼 초기화
            // 추가로 Q&A 리스트 갱신 코드를 작성할 수 있습니다
        },
        error: function(error) {
            // 오류 처리
            alert('문의 등록에 실패했습니다. 다시 시도해 주세요.');
        }
    });
}
</script>

<!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>