<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
.nav.cate { border:solid #d8d8d8; border-width:1px 0; }
.nav.cate .nav-link { color: #333; }
.tit_post { font-size:1.3rem; }
.ed_area { font-size:0.9rem; }
.writerInfo { line-height:1.2; }
.writerInfo div { font-size:0.8rem; }
</style>
</head>
<body>
	<div class="content">
		<%@ include file="header.jsp" %>
		
		<div class="container list mt-4">
        <!-- 카테고리 -->
        <nav class="nav cate mb-4">
            <a class="nav-link" href="list.do"># 전체</a>
            <a class="nav-link ${board.bd_cate == 'f' ? 'active' : ''}" href="list.do?category=f"># 자유</a>
            <a class="nav-link ${board.bd_cate == 'q' ? 'active' : ''}" href="list.do?category=q"># 질문</a>
        </nav>

        <!-- 게시글 제목 -->
        <div class="d-flex justify-content-between align-items-center mb-1">
            <h2 class="tit_post">${board.bd_title}</h2>

            <!-- 히든 필드로 작성자 ID를 저장 -->
            <input type="hidden" id="writerId" value="${board.mb_id}" />
            <c:if test="${userId == board.mb_id}">
                <div class="ed_area">
                    <a href="edit.do?bd_no=${board.bd_no}" class="text-muted">수정</a> &nbsp; | &nbsp;
                    <a href="delete.do?bd_no=${board.bd_no}" class="text-muted">삭제</a>
                </div>
            </c:if>
        </div>

        <!-- 작성자 정보 및 조회수 -->
        <div class="d-flex align-items-center">
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
        <div class="d-flex align-items-center">
            <i id="likeIcon" class="fas fa-heart" style="color:lightgray;cursor:pointer;"></i>&nbsp;
    		<span id="likeCount" class="ms-1">${likeCount}</span> <!-- 좋아요 수 -->&nbsp;&nbsp;&nbsp;
            <i class="fas fa-comment ms-3"></i>&nbsp;<span class="ms-1">${reply.size()}</span> <!-- 댓글 수 -->
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
        <c:forEach var="reply" items="${replies}">
            <div class="d-flex mb-3">
                <img src="/images/profile/${reply.rp_writer}" alt="프로필 이미지" class="rounded-circle" width="40" height="40">
                <div class="ms-2">
                    <strong>${reply.rp_writer}</strong> <!-- 댓글 작성자 닉네임 -->
                    <p>${reply.rp_content}</p> <!-- 댓글 내용 -->
                    <small class="text-muted">${reply.rp_date}</small> <!-- 댓글 작성 날짜 -->
                </div>
            </div>
        </c:forEach>

        <!-- 댓글 입력창 -->
        <div class="mt-3">
            <form action="/addReply" method="post">
                <input type="hidden" name="tb_no" value="${board.bd_no}">
                <div class="d-flex">
                    <textarea name="rp_content" class="form-control" rows="2" placeholder="댓글을 입력하세요"></textarea>
                    <button type="submit" class="btn btn-primary ms-2" style="width:8%;">등록</button>
                </div>
            </form>
        </div>

        <!-- 목록으로 돌아가기 버튼 -->
        <div class="mt-4">
            <a href="/board/list" class="btn btn-secondary">목록</a>
        </div>
    </div>
	</div>
					
	<%@ include file="footer.jsp" %>
	<!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>