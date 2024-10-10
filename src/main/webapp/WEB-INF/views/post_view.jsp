<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<%@ include file="navbarStyle.jsp" %>
<meta charset="UTF-8">
<title>${board.bd_title} | 털뭉치즈</title>
</head>
<body>
	<div class="content">
		<%@ include file="header.jsp" %>
		
		<div class="container list mt-4">
        <!-- 카테고리 -->
        <nav class="nav">
            <a class="nav-link" href="list.do">전체</a>
            <a class="nav-link ${board.bd_cate == 'f' ? 'active' : ''}" href="list.do?category=f">자유</a>
            <a class="nav-link ${board.bd_cate == 'q' ? 'active' : ''}" href="list.do?category=q">질문</a>
        </nav>

        <!-- 게시글 제목 -->
        <h2>${board.bd_title}</h2>

        <!-- 작성자 정보 및 조회수 -->
        <div class="d-flex align-items-center">
            <img src="/images/profile/${board.bd_writer}" alt="프로필 이미지" class="rounded-circle" width="40" height="40">
            <span class="ms-2">${board.bd_writer}</span> <!-- 작성자 닉네임 -->
            <span class="ms-4 text-muted">조회수: ${board.bd_hit}</span> <!-- 조회수 -->
        </div>

        <!-- 게시글 내용 -->
        <div class="mt-3">
            <p>${board.bd_content}</p>
        </div>

        <!-- 좋아요 및 댓글 수 -->
        <div class="d-flex align-items-center">
            <i class="fas fa-heart"></i> <span class="ms-1">${board.bd_like}</span> <!-- 좋아요 수 -->
            <i class="fas fa-comment ms-3"></i> <span class="ms-1">${comments.size()}</span> <!-- 댓글 수 -->
        </div>

        <hr>

        <!-- 댓글 목록 -->
        <h5>댓글</h5>
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
            <form action="/comment/add" method="post">
                <input type="hidden" name="tb_no" value="${board.bd_no}">
                <div class="d-flex">
                    <textarea name="rp_content" class="form-control" rows="2" placeholder="댓글을 입력하세요"></textarea>
                    <button type="submit" class="btn btn-primary ms-2">등록</button>
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