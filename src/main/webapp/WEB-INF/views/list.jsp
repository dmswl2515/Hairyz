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
<title>커뮤니티 | 털뭉치즈</title>
 <style>
    .board-item {
        display: flex;
        padding: 15px;
        border-bottom: 1px solid #eee;
        align-items: center;
    }
    .board-item h5 { font-size: 1.15rem; }
    .board-item .content {
        flex: 1;
    }
    .board-item img {
        width: 100px;
        height: 100px;
        object-fit: cover;
        margin-left: 15px;
    }
    .board-body p { margin-bottom:0 !important; }
    .ellipsis {
        display: -webkit-box;
        -webkit-box-orient: vertical;
        -webkit-line-clamp: 2;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: normal;
    }
    .board-footer {
        font-size: 0.875rem;
        color: #666;
    }
    .category-btn {
        margin-right: 5px;
    }
</style>
</head>
<body>
	<div class="content">
		<%@ include file="header.jsp" %>
		
		<div class="container list my-4">
			<!-- 게시글 검색 -->
		    <div class="input-group mb-4">
		        <select class="custom-select" id="searchCondition">
		            <option value="all">전체</option>
		            <option value="title">제목</option>
		            <option value="content">내용</option>
		            <option value="writer">작성자</option>
		        </select>
		        <input type="text" class="form-control" id="searchKeyword" placeholder="검색어 입력">
		        <div class="input-group-append">
		            <button class="btn btn-outline-secondary" type="button" onclick="searchPosts()">검색</button>
		        </div>
		    </div>
		
		    <!-- 카테고리 -->
		    <div class="mb-4">
		        <button class="btn btn-outline-primary category-btn" onclick="filterCategory('all')">전체</button>
		        <button class="btn btn-outline-primary category-btn" onclick="filterCategory('f')">자유</button>
		        <button class="btn btn-outline-primary category-btn" onclick="filterCategory('q')">질문</button>
		    </div>
		    
		    <hr>
		
		    <!-- 게시글 리스트 -->
		    <div id="boardList" class="boardList">
		        <!-- 반복되는 게시글 항목 -->
		        <c:forEach var="board" items="${boardList}">
		            <div class="board-item">
		                <div class="content">
		                    <h5>${board.bd_title}</h5>
		                    <div class="board-body ellipsis">
							    ${board.bd_content}
							</div>
		                    <div class="board-footer">
		                        <span>${board.bd_writer}</span>&nbsp; | &nbsp;조회수: ${board.bd_hit}&nbsp; | &nbsp;좋아요: ${board.bd_like}
		                    </div>
		                </div>
		                <c:if test="${board.bd_imgpath != null}">
		                    <img src="${board.bd_imgpath}/${board.bd_modname}" alt="썸네일">
		                </c:if>
		            </div>
		        </c:forEach>
		    </div>
		
		    <!-- 글쓰기 버튼 -->
		    <div class="mt-4 text-right">
		        <a href="/board/write" class="btn btn-primary">글쓰기</a>
		    </div>
		
		    <!-- 페이징 -->
		    <nav class="mt-4">
		        <ul class="pagination justify-content-center">
		            <c:forEach var="i" begin="1" end="${totalPages}">
		                <li class="page-item <c:if test='${currentPage == i}'>active</c:if>'">
		                    <a class="page-link" href="?page=${i}">${i}</a>
		                </li>
		            </c:forEach>
		        </ul>
		    </nav>
		    
		</div>
	</div>
	<script>
	    function searchPosts() {
	        var condition = $('#searchCondition').val();
	        var keyword = $('#searchKeyword').val();
	        window.location.href = `/list.do?condition=${condition}&keyword=${keyword}`;
	    }
	
	    function filterCategory(category) {
	        window.location.href = `/list.do?category=${category}`;
	    }
	</script>
					
	<%@ include file="footer.jsp" %>
	<!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>