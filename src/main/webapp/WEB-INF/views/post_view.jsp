<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<%@ include file="navbarStyle.jsp" %>
<meta charset="UTF-8">
<title>${board.bd_title} | 털뭉치즈</title>
<style>
.cate { padding: 0 0 1.5rem; border:solid #ffc107; border-width:0 0 1px; }
.cate .category-btn { margin-right: 5px; border-radius:1.25rem; border-color:#fff; color: #212529; }
.cate .category-btn.selected { background-color: #ffc107; }
.tit_post { font-size:1.3rem; }
.ed_area { font-size:0.9rem; }
.writerInfo { line-height:1.2; }
.writerInfo div { font-size:0.8rem; }
.del_reply { font-size:0.8rem; text-decoration:underline; }
</style>
</head>
<body>
<div class="content">
	<%@ include file="header.jsp" %>
	
	<div class="container list mt-4">
        <!-- 카테고리 -->
        <div class="cate mb-4">
            <a class="btn btn-outline-warning category-btn ${board.bd_cate == 'f' ? 'selected' : ''}" href="/list.do?category=f"># 자유</a>
            <a class="btn btn-outline-warning category-btn ${board.bd_cate == 'q' ? 'selected' : ''}" href="/list.do?category=q"># 질문</a>
        </div>

        <!-- 게시글 제목 -->
        <div class="d-flex justify-content-between align-items-center mb-1">
            <h2 class="tit_post">${board.bd_title}</h2>

            <!-- 히든 필드로 작성자 ID를 저장 -->
            <input type="hidden" id="writerId" value="${board.mb_id}" />
            <c:if test="${userId == board.mb_id}">
                <div class="ed_area">
                    <a href="${pageContext.request.contextPath}/post_edit.do/${board.bd_no}" class="text-muted">수정</a> &nbsp; | &nbsp;
                    <a href="javascript:void(0);" onclick="confirmDelete(${board.bd_no})" class="text-muted">삭제</a>
                </div>
            </c:if>
        </div>
        <script>
		function confirmDelete(bd_no) {
		    if (confirm("이 글을 삭제하시겠습니까?")) {
		        window.location.href = "/delete.do?bd_no=" + bd_no; // 사용자가 '예'를 클릭하면 삭제 요청
		    }
		}
		</script>

        <!-- 작성자 정보 및 조회수 -->
        <div class="d-flex align-items-center mb-3">
	        <c:choose>
		        <c:when test="${not empty profile.mb_imgpath}">
		            <img class="rounded-circle" src="${pageContext.request.contextPath}/upload/${profile.mb_orgname}" alt="프로필 사진" width="40" height="40">
		        </c:when>
		        <c:otherwise>
		            <img class="rounded-circle" src="${pageContext.request.contextPath}/images/logo.png" alt="기본 프로필 사진"  width="40" height="40">
		        </c:otherwise>
		    </c:choose>
            <div class="ml-2 d-flex flex-column writerInfo">
		        <span>${board.bd_writer}</span> <!-- 작성자 닉네임 -->
		        <div class="text-muted">
		            <c:choose>
		                <c:when test="${board.bd_cate == 'f'}">
		                    자유
		                </c:when>
		                <c:when test="${board.bd_cate == 'q'}">
		                    질문
		                </c:when>
		            </c:choose> 
		            &nbsp; | &nbsp; 조회수 ${board.bd_hit} <!-- 카테고리 및 조회수 -->
		        </div>
		    </div>
        </div>

        <!-- 게시글 내용 -->
        <div class="mt-3">
            <p>${board.bd_content}</p>
        </div>

        <hr>

        <!-- 좋아요 및 댓글 수 -->
        <div class="d-flex align-items-center mb-3">
            <i id="likeIcon" class="fas fa-heart" style="color:lightgray;cursor:pointer;"></i>&nbsp;
    		<span id="likeCount" class="ms-1">${likeCount}</span> <!-- 좋아요 수 -->&nbsp;&nbsp;&nbsp;
            <i class="fas fa-comment ms-3"></i>&nbsp;<span id="replyCount" class="ms-1">${replyCount}</span> <!-- 댓글 수 -->
        </div>
        
        <script>
	        $(document).ready(function() {
	            let liked = false; // 기본 상태는 좋아요 안 누름
	            const boardId = ${board.bd_no}; // 게시글 ID 가져오기
	
	            // 좋아요 상태 초기화 AJAX 요청 (선택 사항)
	            $.ajax({
	                url: '/getLikeStatus',
	                type: 'GET',
	                data: { boardId: boardId },
	                success: function(response) {
	                    if (response.liked) {
	                        liked = true;
	                        $('#likeIcon').css('color', 'red'); // 이미 좋아요 상태면 빨간색으로 표시
	                    }
	                },
	                error: function() {
	                    console.error("좋아요 상태 조회 중 오류가 발생했습니다.");
	                }
	            });
	
	            $('#likeIcon').click(function() {
	                // AJAX 요청으로 좋아요 토글
	                $.ajax({
	                    url: '/upLike',
	                    type: 'POST',
	                    data: { boardId: boardId },
	                    success: function(response) {
	                        if (response.success) {
	                            $('#likeCount').text(response.likes); // 좋아요 수 갱신
	                            liked = !liked; // 좋아요 상태 토글
	                            $('#likeIcon').css('color', liked ? 'red' : 'lightgray'); // 아이콘 색상 변경
	                        } else {
	                            alert(response.message); // 로그인 필요 메시지 등 처리
	                        }
	                    },
	                    error: function() {
	                        alert("좋아요 처리 중 오류가 발생했습니다.");
	                    }
	                });
	            });
	        });
		</script>

        <!-- 댓글 목록 -->
        <div id="replyList" class="replyList_area">
		    <c:forEach var="reply" items="${replyList}" varStatus="status">
			    <div class="d-flex mb-1">
			        <c:choose>
			            <c:when test="${not empty replyProfiles[status.index].mb_orgname}">
					        <!-- 로컬 경로를 제거하고 상대 경로로 설정 -->
					        <img class="rounded-circle flex-shrink-0" 
					             src="${pageContext.request.contextPath}/upload/${replyProfiles[status.index].mb_orgname}" 
					             width="40" height="40" />
					    </c:when>
					    <c:otherwise>
					        <img class="rounded-circle flex-shrink-0" 
					             src="${pageContext.request.contextPath}/images/logo.png" 
					             width="40" height="40" />
					    </c:otherwise>
			        </c:choose>
			        <div class="ml-2">
			        	<span>${reply.rp_writer}</span>
				        <span class="text-muted ml-2">
				            <fmt:formatDate value="${reply.rp_date}" pattern="yyyy-MM-dd HH:mm"/>
				        </span>
				        <!-- 댓글 작성자와 로그인한 사용자가 동일할 경우에만 삭제 버튼 노출 -->
		                <c:if test="${userId == reply.mb_id}">
		                    <a href="javascript:void(0);" onclick="confirmReplyDelete(${reply.rp_no}, ${reply.bd_no})" class="text-muted ml-2 del_reply">삭제</a>
		                </c:if>
				        <p>${reply.rp_content}</p>
			        </div>
			    </div>
			</c:forEach>
		</div>
		
		<script>
		function confirmReplyDelete(rp_no, bd_no) {
		    if (confirm("이 댓글을 삭제하시겠습니까?")) {
		        window.location.href = "/deleteReply.do?rp_no=" + rp_no + "&bd_no=" + bd_no; // 댓글 삭제 요청
		    }
		}
		</script>
        
        
        <!-- 댓글 입력창 -->
        <div class="mt-3 replyInput_area">
		    <form id="replyForm">
		        <input type="hidden" name="bd_no" value="${board.bd_no}">
		        <input type="hidden" name="mb_id" value="${board.mb_id}">
		        <div class="d-flex">
		            <textarea name="rp_content" class="form-control" rows="2" placeholder="댓글을 입력하세요" required></textarea>
		            <button type="submit" class="btn btn-warning ms-2" style="width:8%;">등록</button>
		        </div>
		    </form>
		</div>
		
		<script>
		$(document).ready(function() {
		    $('#replyForm').on('submit', function(event) {
		        event.preventDefault(); // 기본 제출 이벤트 방지
		
		        const formData = $(this).serialize(); // 폼 데이터 직렬화
		
		        $.ajax({
		            url: '/addReply', // 댓글 추가 요청을 처리하는 URL
		            type: 'POST',
		            data: formData,
		            success: function(response) {
		                console.log(response); // 응답 확인
		                // 서버에서의 응답 처리
		                if (response.success) {
		                    // 변수 선언
		                    const writerImg = response.writerImg;
		                    const writer = response.writer;
		                    const date = response.date;
		                    const content = response.content;
		
		                    // 댓글 목록 갱신
		                    const newReply = '<div class="d-flex mb-1">' +
		                        '<img src="' + writerImg + '" alt="프로필 이미지" class="rounded-circle flex-shrink-0" width="40" height="40">' +
		                        '<div class="ml-2">' +
		                        '<span>' + writer + '</span>' +
		                        '<span class="text-muted ml-2">' + date + '</span>' +
		                        '<p>' + content + '</p>' +
		                        '</div>' +
		                        '</div>';
		                        
		                    // 댓글 목록 앞에 새로운 댓글 추가
		                    $('.replyList_area').before(newReply);
		                    // 텍스트 에어리어 초기화
		                    $('textarea[name="rp_content"]').val('');
		                    
		                	 // 댓글 수 갱신
		                    const currentReplyCount = parseInt($('#replyCount').text());
		                    $('#replyCount').text(currentReplyCount + 1); // 댓글 수 +1
		                } else {
		                	alert(response.message || '댓글 추가에 실패했습니다. 다시 시도하세요.');
		                }
		            },
		            error: function() {
		                alert("댓글 추가 중 오류가 발생했습니다.");
		            }
		        });
		    });
		});
		</script>

        <!-- 목록으로 돌아가기 버튼 -->
        <div class="mt-4">
		    <c:choose>
		        <c:when test="${not empty searchCondition and not empty searchKeyword}">
		            <a href="/boardSearch?page=${currentPage}&category=${category}&condition=${searchCondition}&keyword=${searchKeyword}" class="btn btn-secondary" style="width:5rem;">목록</a>
		        </c:when>
		        <c:otherwise>
		            <a href="/list.do?page=${currentPage}&category=${category}" class="btn btn-secondary" style="width:5rem;">목록</a>
		        </c:otherwise>
		    </c:choose>
		</div>
        
    </div>
</div>
					
<%@ include file="kakaoCh.jsp" %>
<%@ include file="footer.jsp" %>
<!-- Bootstrap JS, Popper.js, and jQuery -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>