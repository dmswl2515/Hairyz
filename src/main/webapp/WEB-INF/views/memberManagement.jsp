<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>회원 관리</title>
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

</style>
<script>
//전체 선택 및 해제
function toggleAllCheckboxes(source) {
    checkboxes = document.getElementsByName('memberCheckbox');
    for(var i=0, n=checkboxes.length;i<n;i++) {
        checkboxes[i].checked = source.checked;
    }
}

// 선택된 회원에 대해 강제탈퇴 또는 회원정지 처리
function updateMemberState(action) {
	let selectedMembers = [];
    $('input[name="memberCheckbox"]:checked').each(function() {
        selectedMembers.push($(this).val());
    });

    if (selectedMembers.length === 0) {
        alert('선택된 회원이 없습니다.');
        return;
    }

    // 선택된 회원들에 대해 AJAX로 상태 업데이트
    $.ajax({
        url: 'updateMemberState.do',
        type: 'POST',
        traditional: true,  // 배열 전송
        data: { 
        	memberList: selectedMembers,
            action: action 
        },
        traditional: true,
        success: function(response) {
            alert('처리되었습니다.');
            location.reload();
        },
        error: function(xhr, status, error) {
            console.log('Error: ' + error);
        }
    });
}

//검색 폼 제출
function searchMembers() {
    var searchCategory = $('#searchCategory').val();
    var searchKeyword = $('#searchKeyword').val();
    
    if (searchKeyword.trim() === "") {
        alert("검색어를 입력하세요.");
        return;
    }

    // 검색어와 카테고리를 포함하여 검색 요청 전송
    window.location.href = "keywordMemberManagement.do?category=" + searchCategory + "&keyword=" + encodeURIComponent(searchKeyword);
}

</script>
</head>
<body>
	<!-- 로그 및 로그인 -->
    <div class="content">
		<%@ include file="header.jsp" %>
		<!-- 판매관리 -->
	    <div class="content">
		<!-- 세로 메뉴 -->
   			<div style="display: flex;">
   				 <%@ include file="sideMenu.jsp" %>
   				 <div class="content" style="margin-left: 50px;">
			    	<div class="custom-container">
					    <h2 class="text-center my-4">회원관리</h2>
					    <!-- 검색 창 -->
					    <div class="mb-4">
					        <div class="form-inline justify-content-center">
					            <select id="searchCategory" class="form-control mr-2">
					                <option value="all">전체</option>
					                <option value="nickname">닉네임</option>
					                <option value="id">아이디</option>
					                <option value="phone">전화번호</option>
					                <option value="status">상태</option>
					            </select>
					            <input type="text" id="searchKeyword" class="form-control mr-2" placeholder="검색어를 입력하세요">
					            <button type="button" class="btn btn-warning" onclick="searchMembers()">검색</button>
					        </div>
					    </div>
					    <table class="table table-hover table-striped table-bordered text-center align-middle">
					        <thead class="thead-dark">
					            <tr>
					            	<th><input type="checkbox" onclick="toggleAllCheckboxes(this)"></th> <!-- 전체 선택 체크박스 -->
					                <th>번호</th>
					                <th>이메일</th>
					                <th>이름</th>
					                <th>닉네임</th>
					                <th>핸드폰번호</th>
					                <th>주소</th>
					                <th>상태</th>
					            </tr>
					        </thead>
					        <tbody>
					            <c:choose>
					                <c:when test="${empty memberManage}">
					                    <tr>
					                        <td colspan="8" class="text-center text-muted py-4">등록된 회원이 없습니다.</td>
					                    </tr>
					                </c:when>
					                <c:otherwise>
					                    <c:forEach var="mm" items="${memberManage}">
					                        <tr>
					                        	<td><input type="checkbox" name="memberCheckbox" value="${mm.mb_no}"></td> <!-- 개별 선택 체크박스 -->
					                            <td>${mm.mb_no}</td>
					                            <td>${mm.mb_id}</td>
					                            <td>${mm.mb_name}</td>
					                            <td>${mm.mb_nickname}</td>
					                            <td>${mm.mb_phone}</td>
					                            <td>${mm.mb_addr1}${mm.mb_addr2}</td>
					                            <td>
						                            <c:choose>
													    <c:when test="${mm.mb_state == 1}">
													        <span class="badge badge-success">정상</span>
													    </c:when>
													    <c:when test="${mm.mb_state == 2}">
													        <span class="badge badge-warning">탈퇴</span>
													    </c:when>
													    <c:when test="${mm.mb_state == 3}">
													        <span class="badge badge-danger">강퇴</span>
													    </c:when>
													    <c:when test="${mm.mb_state == 4}">
													        <span class="badge badge-secondary">정지</span>
													    </c:when>
													</c:choose>
												</td>
					                        </tr>
					                    </c:forEach>
					                </c:otherwise>
					            </c:choose>
					        </tbody>
					    </table>
					    <div class="text-right mb-3">
                            <button type="button" class="btn btn-danger" onclick="updateMemberState('expel')">강제탈퇴</button>
                            <button type="button" class="btn btn-secondary" onclick="updateMemberState('suspend')">회원정지</button>
                        </div>
					     <!-- 페이징 네비게이션 -->
		                <nav aria-label="Page navigation example">
		                  <ul class="pagination justify-content-center">
		                    <!-- 이전 버튼 -->
							<li class="page-item <c:if test='${currentPage == 1}'>disabled</c:if>">
							    <a class="page-link" href="#" aria-label="Previous" onclick="navigateToPage(${currentPage - 1})">
							        <span aria-hidden="true">&laquo;</span>
							    </a>
							</li>
							
							<!-- 페이지 번호 -->
							<c:forEach var="i" begin="1" end="${totalPages}">
							    <li class="page-item <c:if test='${i == currentPage}'>active</c:if>">
							        <a class="page-link" href="#" onclick="navigateToPage(${i})">${i}</a>
							    </li>
							</c:forEach>
							
							<!-- 다음 버튼 -->
							<li class="page-item <c:if test='${currentPage == totalPages}'>disabled</c:if>">
							    <a class="page-link" href="#" aria-label="Next" onclick="navigateToPage(${currentPage + 1})">
							        <span aria-hidden="true">&raquo;</span>
							    </a>
							</li>
							
							<script>
							function navigateToPage(pageNumber) {
							    if (pageNumber < 1 || pageNumber > ${totalPages}) {
							        return; // 페이지 번호가 범위를 벗어나면 아무 것도 하지 않음
							    }
							    window.location.href = "memberManagement.do?page=" + pageNumber; // 페이지 이동
							}
							</script>
		
				                  </ul>
				                </nav>
							</div>
						</div>
					</div>
			    </div>
    
    <!-- FOOTER -->
	<%@ include file="footer.jsp" %>
    <!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>