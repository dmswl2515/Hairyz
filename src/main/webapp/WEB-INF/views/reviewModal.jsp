<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>털뭉치즈</title>
<!-- Bootstrap CSS -->
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<style>
.modal-content {
	border-radius: 10px;
	border: 1px solid #007bff;
}

.modal-header {
	background-color: #ffff00;
	color: black;
	border-top-left-radius: 10px;
	border-top-right-radius: 10px;
}

.modal-title {
	font-size: 1.5rem;
}

.btn-primary {
	background-color: #007bff;
	border: none;
}

.btn-secondary {
	background-color: #6c757d;
	border: none;
}

.form-control, .form-control-file {
	border-radius: 5px;
}

.form-group label {
	font-weight: bold;
}

.text-muted {
	font-size: 0.9rem;
}

.star-rating {
	display: flex;
	cursor: pointer;
}

.star {
	font-size: 2rem; /* 별의 크기 조정 */
	color: gray; /* 기본 색상 */
}

.star.selected {
	color: red; /* 선택된 별 색상 */
}
</style>
<script>
	$(document).ready(function() {
		$('.star').on('click', function() {
			const rating = $(this).data('value');

			// 별의 색상 업데이트
			$('.star').removeClass('selected');
			for (let i = 1; i <= rating; i++) {
				$('.star[data-value="' + i + '"]').addClass('selected');
			}
		});
	});
</script>
</head>
<body>
	
<!-- 모달 -->
	<div class="modal fade" id="reviewModal" tabindex="-1" role="dialog" aria-labelledby="reviewModalLabel" aria-hidden="true">
	    <div class="modal-dialog modal-lg" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title" id="reviewModalLabel">구매평 작성</h5>
	                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	                    <span aria-hidden="true">&times;</span>
	                </button>
	            </div>
	            <div class="modal-body">
	                <div class="text-center mb-4">
	                    <img src="images/logo.png" alt="상품사진" class="img-thumbnail" style="width: 150px; height: auto;">
	                </div>
	                <div class="form-group">
	                    <label for="rating">상품은 만족하셨나요?</label>
	                    <div class="star-rating" id="rating">
                            <span class="star" data-value="1">★</span>
                            <span class="star" data-value="2">★</span>
                            <span class="star" data-value="3">★</span>
                            <span class="star" data-value="4">★</span>
                            <span class="star" data-value="5">★</span>
                        </div>
	                </div>
	                <div class="form-group">
	                    <label for="reviewText">구매평</label>
	                    <textarea class="form-control" id="reviewText" rows="3" maxlength="500" placeholder="10자 이상 입력해주세요."></textarea>
	                    <small id="reviewTextCount" class="form-text text-muted">0/500</small>
	                </div>
	                <div class="form-group">
	                    <label for="uploadImage">사진 첨부하기</label>
	                    <input type="file" class="form-control-file" id="uploadImage" multiple>
	                </div>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	                <button type="button" class="btn btn-primary" id="submitReview">등록</button>
	            </div>
	        </div>
	    </div>
	</div>	
	
    <!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>