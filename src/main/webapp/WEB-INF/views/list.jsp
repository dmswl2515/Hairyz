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
.searchWrap * { border-color: #ffc107; }
.board-item {
    display: flex;
    padding: 15px;
    border-bottom: 1px solid #ffc107;
    align-items: center;
}
.boardList .board-item:first-child { border-top: 1px solid #ffc107; }
.board-item h5 { font-size: 1.15rem; }
.board-item .content { flex: 1; }
.board-item img {
    width: 100px;
    height: 100px;
    object-fit: cover;
    margin-left: 15px;
    border-radius: .25rem;
}
.board-body { margin-bottom:.5rem; }
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
    font-size: 0.85rem;
    color: #6c757d!important;
}
.category-btn { margin-right: 5px; border-radius:1.25rem; border-color:#fff; color: #212529; }
.category-btn.selected { background-color: #ffc107; }

</style>
</head>
<body>
	<div class="content">
		<%@ include file="header.jsp" %>
		
		<div class="container list my-4">
			<!-- 게시글 검색 -->
		    <div class="input-group searchWrap mb-4 mx-auto col-md-6">
		        <select class="custom-select" id="searchCondition">
		            <option value="all" selected>전체</option>
		            <option value="title">제목</option>
		            <option value="content">내용</option>
		            <option value="writer">작성자</option>
		        </select>
		        <input type="text" class="form-control" id="searchKeyword" placeholder="검색어 입력">
		        <div class="input-group-append">
		            <button class="btn btn-outline-warning" type="button" onclick="searchPosts()">검색</button>
		        </div>
		    </div>
		
		    <!-- 카테고리 -->
			<div class="mb-4">
			    <button class="btn btn-outline-warning category-btn" data-category="all"># 전체</button>
			    <button class="btn btn-outline-warning category-btn" data-category="f"># 자유</button>
			    <button class="btn btn-outline-warning category-btn" data-category="q"># 질문</button>
			</div>
			
			<script>
			$(document).ready(function() {
			    // URL에서 카테고리 값을 가져오기
			    const urlParams = new URLSearchParams(window.location.search);
			    const category = urlParams.get('category') || 'all'; // 기본값은 'all'
			
			    // 페이지 로드 시 선택된 카테고리에 해당하는 버튼에 'selected' 클래스 추가
			    setCurrentButton(category);
			
			    $('.category-btn').click(function(event) {
			        event.preventDefault(); // 기본 동작 방지
			        
			        // 현재 페이지와 선택된 카테고리를 가져옴
			        const currentPage = urlParams.get('page') || 1; // 현재 페이지 가져오기
			        const category = $(this).data('category'); // 클릭된 버튼의 category 값 가져오기
			
			        // URL 변경
			        changeURL(currentPage, category);
			    });
			
			    function setCurrentButton(category) {
			        // 모든 버튼에서 'selected' 클래스 제거
			        $('.category-btn').removeClass('selected');
			        
			        // URL에서 가져온 카테고리에 해당하는 버튼에 'selected' 클래스 추가
			        $('.category-btn[data-category="' + category + '"]').addClass('selected');
			    }
			
			    function changeURL(page, category) {
			        // URL 변경
			        console.log('Navigating to /list.do?page=' + page + '&category=' + category);
			        
			        // URL 변경
			        window.location.href = '/list.do?page=' + page + '&category=' + category;
			    }
			});
			</script>

		    
		    <!-- 게시글 리스트 -->
		    <div id="boardList" class="boardList">
		        <!-- 반복되는 게시글 항목 -->
		        <c:forEach var="board" items="${boardList}">
		            <div class="board-item">
		                <div class="content">
		                    <h5>
		                    	<a href="/post_view.do/${board.bd_no}" class="text-dark">
			                        ${board.bd_title}
			                    </a>
							</h5>
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
		    <div class="mt-4">
		        <a href="/write.do" class="btn btn-warning">글쓰기</a>
		    </div>
		
		    <!-- 페이징 -->
		    <nav class="mt-4">
		        <nav class="mt-4">
				    <ul class="pagination justify-content-center">
				        <c:if test="${currentPage > 1}">
				            <li class="page-item">
				                <a class="page-link" href="?page=${currentPage - 1}">이전</a>
				            </li>
				        </c:if>
				        <c:forEach var="i" begin="1" end="${totalPages}">
				            <li class="page-item <c:if test='${currentPage == i}'>active</c:if>'">
				                <a class="page-link" href="?page=${i}">${i}</a>
				            </li>
				        </c:forEach>
				        <c:if test="${currentPage < totalPages}">
				            <li class="page-item">
				                <a class="page-link" href="?page=${currentPage + 1}">다음</a>
				            </li>
				        </c:if>
				    </ul>
				</nav>
		    </nav>
		    
		</div>
	</div>
	<script>
	    function searchPosts() {
	        var condition = $('#searchCondition').val();
	        var keyword = $('#searchKeyword').val();
	        var url = '/list.do?condition=' + encodeURIComponent(condition) + '&keyword=' + encodeURIComponent(keyword);
	        window.location.href = url;
	    }
	</script>
					
	<%@ include file="footer.jsp" %>
	<!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>