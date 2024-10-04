<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>주문 조회</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery 라이브러리 추가 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
/* 기본 레이아웃 설정 */
body {
	display: flex;
	flex-direction: column;
	min-height: 100vh;
	margin: 0;
}

/* 내용물이 차지할 공간을 유지 */
.content {
	flex: 1;
}

.custom-container {
	max-width: 1000px;
	margin: 0 auto;
}

.custom-container hr {
	border: 1px solid #d8d8d8;
	width: 100%;
	margin-top: 100px
}

/* 세로 메뉴 스타일 */
.sidebar {
	background-color: #f8f9fa;
	padding: 20px;
	width: 200px;
	height: 100%;
	position: absolute;
	left: 0;
	top: 0;
}

.sidebar ul {
	list-style: none;
	padding: 0;
}

.sidebar li {
	margin-bottom: 10px;
}

.sidebar a {
	text-decoration: none;
	color: #333;
	/* font-weight: bold; */
}

.sidebar a:hover {
	text-decoration: underline;
}

/* 모덜스타일 */
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
	justify-content: center;
}

.star {
	font-size: 2rem; /* 별의 크기 조정 */
	color: gray; /* 기본 색상 */
}

.star.selected {
	color: red; /* 선택된 별 색상 */
}

/* 미리보기 이미지 컨테이너 스타일 */
.preview-image {
	position: relative;
	display: inline-block;
	margin-right: 10px;
	margin-bottom: 10px;
}

/* 미리보기 이미지 */
.preview-image img {
	width: 100px;
	height: 100px;
	object-fit: cover;
	border: 1px solid #ddd;
	border-radius: 5px;
}

/* X버튼 스타일 */
.remove-image {
	position: absolute;
	top: 0;
	right: 0;
	background-color: red;
	color: white;
	border: none;
	border-radius: 50%;
	width: 20px;
	height: 20px;
	font-size: 12px;
	line-height: 1;
	cursor: pointer;
}

/* 숨겨진 파일 입력 버튼 */
.d-none {
	display: none;
}


/* 미리보기 우측상단 x표 스타일링 */
#previewContainer {
    display: inline-block;
    position: relative;
}

#previewImage {
    max-width: 200px; /* 이미지 최대 너비 설정 */
    max-height: 200px; /* 이미지 최대 높이 설정 */
    border: 1px solid #ddd;
    padding: 5px;
    margin-top: 10px;
}

#removePreview {
    position: absolute;
    top: 5px;
    right: 5px;
    background-color: black;
    color: white;
    border: none;
    border-radius: 50%;
    width: 20px;
    height: 20px;
    cursor: pointer;
    font-size: 14px;
    display: none;
}


</style>
<script>
function updateOrderState(orderno, state) {
    $.ajax({
        url: 'orderState.do',
        type: 'POST',
        data: { 
        	orderno: orderno, 
            state: state 
        },
        success: function(response) {
            // 서버로부터 응답을 받고 나면 status 갱신
            console.log('Response:', response);
            updateStatusBadge(orderno, state);
            location.reload();
        },
        error: function(xhr, state, error) {
            console.log('Error: ' + error);
        }
    });
}

function updateStatusBadge(orderno, state) {
    let badgeText;
    let badgeClass;
    
    console.log(`Order No: ${orderno}, State: ${state}`);
    
    switch(state) {
        case 1:
            badgeText = '결제완료';
            badgeClass = 'badge-success';
            break;
        case 2:
            badgeText = '배송중';
            badgeClass = 'badge-success';
            break;
        case 3:
            badgeText = '취소';
            badgeClass = 'badge-danger';
            break;
        case 4:
            badgeText = '교환';
            badgeClass = 'badge-warning';
            break;
        case 5:
            badgeText = '반품';
            badgeClass = 'badge-secondary';
            break;
    }

    // 해당 주문의 상태 업데이트
    $(`#status-badge-${orderno}`).removeClass().addClass(`badge ${badgeClass}`).text(badgeText);
}
// 별 조절 스크립트
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

// 사진 스크립트
document.addEventListener('DOMContentLoaded', function() {
    const uploadImageInput = document.getElementById('uploadImage');
    const previewImage = document.getElementById('previewImage');
    const previewContainer = document.getElementById('previewContainer');
    const removePreviewBtn = document.getElementById('removePreview');

    // 이미지 업로드 시 미리보기 출력
    uploadImageInput.addEventListener('change', function(event) {
        const file = event.target.files[0];
        
        if (file && file.type.startsWith('image/')) {
            const reader = new FileReader();

            reader.onload = function(e) {
                previewImage.src = e.target.result;
                previewContainer.style.display = 'inline-block'; // 미리보기 보이게
                removePreviewBtn.style.display = 'inline-block'; // X 버튼 보이게
            };

            reader.readAsDataURL(file); // 파일을 읽고 미리보기에 출력
        } else {
            alert('이미지 파일만 업로드 가능합니다.');
        }
    });

    // X 버튼 클릭 시 미리보기 제거
    removePreviewBtn.addEventListener('click', function() {
        previewImage.src = ''; // 이미지 URL 초기화
        previewContainer.style.display = 'none'; // 미리보기 숨기기
        uploadImageInput.value = ''; // 파일 입력 초기화
        removePreviewBtn.style.display = 'none'; // X 버튼 숨기기
    });
});


document.addEventListener('DOMContentLoaded', function() {
    // 등록 버튼 클릭 이벤트
    const submitButton = document.getElementById('submitReview');
    
    if (submitButton) { // 버튼이 존재하는지 확인
        submitButton.addEventListener('click', function() {
            const rating = document.querySelector('#rating .star.selected') ? document.querySelector('#rating .star.selected').dataset.value : 0; // 별점
            const reviewText = document.getElementById('reviewText').value; // 리뷰 내용
            const uploadImageInput = document.getElementById('uploadImage'); // 파일 입력
            const file = uploadImageInput.files[0]; // 선택한 파일
            const orderNo = this.getAttribute('data-order-no');

            // FormData 객체 생성
            const formData = new FormData();
            formData.append('memberNo', '${member.mb_no}'); // member.mb_no 추가
            formData.append('orderNo', orderNo); // order.orderno 추가
            formData.append('rating', rating);
            formData.append('reviewText', reviewText);
            
            if (file) {
                formData.append('image', file); // 이미지 파일 추가
            }

            // AJAX 요청
            $.ajax({
                url: 'productRevie.do',
                type: 'POST',
                data: formData,
                contentType: false, // 파일 전송을 위한 설정
                processData: false, // jQuery가 데이터를 처리하지 않도록 설정
                success: function(response) {
                    // 성공적으로 리뷰가 등록된 경우
                    console.log('리뷰가 등록되었습니다.', response);
                    // 모달 닫기
                    $('#reviewModal').modal('hide');
                    // 추가 작업 (예: 페이지 새로 고침 또는 알림 표시)
                    location.reload(); // 페이지 새로 고침 (선택 사항)
                },
                error: function(xhr, status, error) {
                    console.error('리뷰 등록 실패:', error);
                    alert('리뷰 등록에 실패했습니다.'); // 에러 메시지
                }
            });
        });
    } else {
        console.error('등록 버튼이 존재하지 않습니다.');
    }
});

</script>
</head>
<body>
	<!-- 로그 및 로그인 -->
    <div class="content">
		<%@ include file="header.jsp" %>
		<!-- 세로 메뉴 -->
		<div class="sidebar">
			<ul>
				<li><a href="myProfile_view.do">내 프로필</a>
					<ul>
						<li><a href="editProfile.do?id=${ member.mb_id }">&nbsp;-회원정보 수정</a></li>
						<li><a href="editPassword.do?id=${ member.mb_id }">&nbsp;-비밀번호 변경</a></li>
					</ul>
				</li>
				<li><a href="petList.do?id=${ member.mb_id }">반려동물 프로필</a></li>
				<li><a href="orderLookup.do?id=${ member.mb_id }"><b>주문 조회</b></a></li>
				<li><a href="returnExchange.do?id=${ member.mb_id }">취소/교환/반품</a></li>
			</ul>
		</div>


		<!-- 주문 조회 -->
	    <div class="content">
	    	<div class="custom-container">
			    <h2 class="text-center my-4">🛒 주문 조회</h2>
			    <table class="table table-hover table-striped table-bordered text-center align-middle">
			        <thead class="thead-dark">
			            <tr>
			                <th>구매 날짜</th>
			                <th>IMAGE</th>
			                <th>상품 이름</th>
			                <th>수량</th>
			                <th>상태</th>
			                <th>기타</th>
			            </tr>
			        </thead>
			        <tbody>
			            <c:choose>
			                <c:when test="${empty orderList}">
			                    <tr>
			                        <td colspan="6" class="text-center text-muted py-4">주문 내용이 없습니다.</td>
			                    </tr>
			                </c:when>
			                <c:otherwise>
			                    <c:forEach var="order" items="${orderList}">
			                        <tr>
			                            <td>${order.orderdate}</td>
			                            <td><img src="${pageContext.request.contextPath}/upload/${order.originalfilename}" alt="사진" class="img-thumbnail" style="width: 80px; height: 80px;"></td>
			                            <td>${order.productname}</td>
			                            <td>${order.orderamount}</td>
			                            <td>
				                            <c:choose>
											    <c:when test="${order.state == 1}">
											        <span id="status-badge-${order.orderno}" class="badge badge-success">결제완료</span>
											    </c:when>
											    <c:when test="${order.state == 2}">
											        <span id="status-badge-${order.orderno}" class="badge badge-success">배송중</span>
											    </c:when>
											    <c:when test="${order.state == 3}">
											        <span id="status-badge-${order.orderno}" class="badge badge-danger">취소</span>
											    </c:when>
											    <c:when test="${order.state == 4}">
											        <span id="status-badge-${order.orderno}" class="badge badge-warning">교환</span>
											    </c:when>
											    <c:when test="${order.state == 5}">
											        <span id="status-badge-${order.orderno}" class="badge badge-secondary">반품</span>
											    </c:when>
											</c:choose>
										</td>
			                            <td>
			                                <button type="button" class="btn btn-sm btn-outline-danger" onclick="updateOrderState(${order.orderno}, 3)">취소</button>
										    <button type="button" class="btn btn-sm btn-outline-primary" onclick="updateOrderState(${order.orderno}, 4)">교환</button>
										    <button type="button" class="btn btn-sm btn-outline-secondary" onclick="updateOrderState(${order.orderno}, 5)">반품</button>
											<button type="button" class="btn btn-sm btn-outline-info" data-toggle="modal" data-target="#reviewModal">구매평 작성</button>
											
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
														    <div class="d-flex justify-content-center mb-4">
														        <!-- 이미지와 상품 정보 컨테이너 -->
														        <div class="d-flex">
														            <!-- 상품 이미지 -->
														            <img src="${pageContext.request.contextPath}/upload/${order.originalfilename}" alt="상품사진" class="img-thumbnail" style="width: 150px; height: auto;">
														
														            <!-- 상품 정보 -->
														            <div class="ml-3">
														                <!-- 상품 이름 (굵게 표시) -->
														                <h5 class="font-weight-bold">${order.productname}</h5>
														
														                <!-- 구매 수량 -->
														                <p>구매 수량: ${order.orderamount}개</p>
														            </div>
														        </div>
														    </div>
														
														    <!-- 상품 만족도 및 구매평 작성 부분 -->
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
															    <label for="uploadImage" class="btn btn-warning">사진 첨부하기</label>
															    <input type="file" class="form-control-file d-none" id="uploadImage">
															</div>
															<div id="previewContainer" style="position: relative; display: none;">
															    <img id="previewImage" src="" alt="미리보기 이미지" style="max-width: 200px; max-height: 200px;">
															    <!-- X 버튼 -->
															    <button id="removePreview" style="position: absolute; top: 5px; right: 5px; background-color: black; color: white; border: none; cursor: pointer;">X</button>
															</div>
														</div>
										
											            <div class="modal-footer">
											                <button type="button" class="btn btn-warning" data-dismiss="modal">취소</button>
											                <button type="button" class="btn btn-warning" id="submitReview" data-member-no="${member.mb_no}" data-order-no="${order.orderno}">등록</button>
											            </div>
											        </div>
											    </div>
											</div>	
											
			                            </td>
			                        </tr>
			                    </c:forEach>
			                </c:otherwise>
			            </c:choose>
			        </tbody>
			    </table>
			</div>
	    </div>
    
    <!-- FOOTER -->
	<%@ include file="footer.jsp" %>
    <!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>