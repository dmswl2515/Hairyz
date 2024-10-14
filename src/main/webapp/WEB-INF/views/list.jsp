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
.boardList .no-posts {
    display: flex;
    justify-content: center;
    height: 100%;
    padding: 50px 0;
}
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
		        <c:choose>
				    <c:when test="${empty boardList}">
				        <div class="board-item">
				            <div class="content no-posts">등록된 게시물이 없습니다.</div>
				        </div>
				    </c:when>
				    <c:otherwise>
				        <c:forEach var="board" items="${boardList}">
				         <fmt:formatDate value="${board.bd_date}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSSZ" var="formattedDate"/>
                       	 	<div class="board-item" data-board-time="${formattedDate}">
				                <div class="content">
				                    <h5>
				                        <a href="/post_view.do/${board.bd_no}" class="text-dark">
				                            ${board.bd_title}
				                        </a>
				                        <span class="badge badge-danger new-badge" style="display:none;">new</span>
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
				    </c:otherwise>
				</c:choose>
		    </div>
		    <script>
		 // 현재 시간(ms) 구하기
		    var currentTime = new Date().getTime(); // 현재 시간

		    // 페이지가 로드되면 게시물의 시간과 비교
		    window.onload = function() {
		        var boardItems = document.querySelectorAll('.board-item');

		        boardItems.forEach(function(item) {
		            // 각 게시물의 Date Time을 가져옵니다.
		            var boardTimeString = item.getAttribute('data-board-time');
		            console.log('Raw Board Date String:', boardTimeString); // 값 확인
		            var boardTime = new Date(boardTimeString).getTime(); // 날짜 문자열을 밀리초로 변환

		            // NaN 체크 추가
		            if (isNaN(boardTime)) {
		                console.error('Invalid board time for item:', item);
		                return; // 오류가 발생하면 다음 항목으로 넘어갑니다.
		            }

		            // 시간 차이 계산
		            var timeDiff = currentTime - boardTime;

		            // 새로운 게시물로 판단하여 배지 추가
		            if (timeDiff <= 86400000) { // 24시간 이내
		                item.querySelector('.new-badge').style.display = 'inline';
		            }
		        });
		    };
			</script>
		
		    <!-- 글쓰기 버튼 -->
		    <div class="mt-4">
		        <a href="#" id="writeBtn" class="btn btn-warning">글쓰기</a>
		    </div>
		    <script>
			document.getElementById('writeBtn').addEventListener('click', function(event) {
			    event.preventDefault(); // 기본 링크 동작 방지
			    
			    // 세션에서 사용자 정보 확인
			    var userId = '<c:out value="${sessionScope.userId}" />';
			    var userNickname = '<c:out value="${sessionScope.userNickname}" />';
			    
			    if (!userId || !userNickname) {
			        // 사용자 정보가 없으면 로그인 필요 알림
			        if (confirm('로그인이 필요합니다. 로그인 하시겠습니까?')) {
			            // 로그인 페이지로 이동, 현재 페이지 URL을 파라미터로 넘겨줌
			            var currentUrl = window.location.pathname + window.location.search; // 현재 페이지 URL
			            window.location.href = '/login.do?redirectUrl=' + encodeURIComponent(currentUrl);
			        }
			    } else {
			        // 세션 정보가 있으면 글쓰기 페이지로 이동
			        window.location.href = '/write.do';
			    }
			});
			</script>
		
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