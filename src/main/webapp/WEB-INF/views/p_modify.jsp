<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 수정</title>
<!-- Bootstrap CSS -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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

        /* footer를 페이지 하단에 고정 */
        footer {
            background-color: #ffffff;
            padding: 20px;
            text-align: center;
            width: 100%;
        }

        /* hr 두께 설정 */
        hr {
            border: 1px solid #d8d8d8;
            width: 100%;
            margin-top: 100px
        }

        .custom-container {
            max-width: 1000px;
            margin: 0 auto;
        }

        .logo-container {
            text-align: center;
        }

        .logo-container img {
            max-width: 100px;
            margin-left: 250px; 
        }

    </style>
</head>
<body>
	<!-- 로그 및 로그인 -->
    <div class="content">
        <div class="custom-container">
            <div class="row align-items-center py-3">
                <div class="col-9 logo-container">
                    <a href="main_view.do">
                        <img src="images/logo.png" alt="로고">
                    </a>
                </div>
				
				<div class="col-3 text-right">
					<%
					//아이디 취득 후 id가 Null인지 확인
					String id = (String)session.getAttribute("id");
					if (id == null)
					{
					%>
                    	<a href="#" class="btn btn-outline-warning">로그인</a>
                    <%}else{%>
                    	<a href="#" class="btn btn-outline-warning">마이페이지</a>
                    	<a href="#" class="btn btn-outline-warning">장바구니</a>
                    <%} %>
                </div>
            </div>
        </div>

        <!-- Navigation Bar -->
        <nav class="navbar navbar-expand-lg navbar-light">
            <div class="custom-container">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#">커뮤니티</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">쇼핑</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">동물병원</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">멍카페</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">캠페인</a>
                    </li>
                </ul>
            </div>
        </nav>
        
<style>
    
    /* 수정& 취소 버튼 넓이 */
    .custom-width {
        width: 200px; /* 원하는 너비로 설정 */
    }
    
    /* text 버튼 넓이 */
    .custom-input-width {
        width: 300px; /* 원하는 너비로 설정 */
        margin: 0 auto; /* 가운데 정렬 */
    }
    
    .image-preview {
    	margin-bottom: 5px; /* 원하는 간격 설정 */
	}
	
	.custom-hr {
	    border: 1px solid #d8d8d8; 
	    width: 100%;
	    margin-top: 30px !important; 
	}
	
	option[selected] {
	    display: none; /* 선택된 옵션 숨기기 */
	}
    
    
</style>     

	   	 	<h4 class="text-center mt-4">상품 수정</h4>
			<div class="d-flex justify-content-center align-items-center">
			    <form action="p_update" method="post" enctype="multipart/form-data" class="text-center">
			        <input type="hidden" name="pdNum" value="${product.pdNum}" />
			        <!-- 첫 번째 파일 선택 -->
			        <div style="text-align: center;">
				        <img id="productImagePreview1" 
				        	 src="${pageContext.request.contextPath}/upload/${product.pd_chng_fname}"
				        	 alt="상품 이미지 1" 
	    					 class="image-preview" 
	    					 style="width: 150px; height: 150px; cursor: pointer; object-fit: cover; border-radius: 15px;" />
			            <input type="file" name="file" id="fileInput" class="form-control-file" 
			            	   onchange="previewImage(event, 'productImagePreview1', 'fileName')" style="display: none;"/>
			            <br>
			        	<label for="fileInput" class="btn btn-outline-warning">파일 선택</label><br>
    					<span id="fileName" class="ml-2">${product.pd_ori_fname}</span>
			        </div>
			        
			        <!-- 이미지 미리보기 -->
					<script>
					function previewImage(event, previewId, fileNameId) {
					    const reader = new FileReader();
					    const imagePreview = document.getElementById(previewId);
					    const fileNameSpan = document.getElementById(fileNameId);
					    
					    reader.onload = function() {
					        if (reader.readyState === 2) {
					            imagePreview.src = reader.result; // 선택한 이미지 미리보기
					        }
					    }
					
					    reader.readAsDataURL(event.target.files[0]); // 파일을 읽어 미리보기 설정
					    
					 	// 선택한 파일의 이름을 표시
					    const fileName = event.target.files[0] ? event.target.files[0].name : "선택된 파일이 없습니다.";
					    fileNameSpan.textContent = fileName; // 파일 이름 표시
					}
					</script>
		            
		            <input type="text" name="pdName" class="form-control custom-input-width mt-2" 
		            	   placeholder="상품명" value="${product.pdName}" required /><br>
			        
			
			        <div class="d-flex justify-content-center">
			            <select name="pd_animal" class="form-control mr-2" required>
			                <option value="all" <c:if test="${product.pdAnimal == 'all'}">selected</c:if>>전체</option>
						    <option value="dog" <c:if test="${product.pdAnimal == 'dog'}">selected</c:if>>강아지</option>
						    <option value="cat" <c:if test="${product.pdAnimal == 'cat'}">selected</c:if>>고양이</option>
			            </select>
			        
			
			            <select name="pd_category" class="form-control mb-4" required>
			            	<c:choose>
						        <c:when test="${product.pdCategory == 'food'}">
						            <option value="food" selected>사료</option>
						        </c:when>
						        <c:when test="${product.pdCategory == 'refreshment'}">
						            <option value="refreshment" selected>간식</option>
						        </c:when>
						        <c:when test="${product.pdCategory == 'product'}">
						            <option value="product" selected>용품</option>
						        </c:when>
						        <c:when test="${product.pdCategory == 'etc'}">
						            <option value="etc" selected>리빙</option>
						        </c:when>
						    </c:choose>
						    <option value="food">사료</option>
				            <option value="refreshment">간식</option>
				            <option value="product">용품</option>
				            <option value="etc">리빙</option>
			            </select><br>
			        </div>
			        
			            <input type="text" name="pd_price" class="form-control custom-input-width" 
			            	   placeholder="가격" value="${product.pd_price}" required /><br>
			        
			
			            <input type="text" name="pd_amount" class="form-control custom-input-width" 
			            	   placeholder="수량" value="${product.pd_amount}" required /><br>
			       
			
			        <div style="text-align: center;">
			            <img id="productImagePreview2" 
			            	 src="${pageContext.request.contextPath}/upload/${product.pd_chng_fname2}"
			            	 alt="상품 상세 이미지 2"  
     						 class="image-preview" 
     						 style="width: 150px; height: 150px; cursor: pointer; object-fit: cover; border-radius: 15px;" /><br>
			            
			            <input type="file" name="file2" id="fileInput2" class="form-control-file" 
					           onchange="previewImage(event, 'productImagePreview2', 'fileName2')" style="display: none;"/>
					    <label for="fileInput2" class="btn btn-outline-warning file-input-label">파일 선택</label><br>
					    <span id="fileName2" class="ml-2">${product.pd_ori_fname2}</span>
			        </div>
			        
			        <hr class="custom-hr">
			        
				        <input type="submit" class="btn btn-outline-warning mb-2 custom-width" value="수정하기" onclick="showMessage()"/></br>
				        <input type="button" class="btn btn-outline-warning custom-width" value="취소하기"
				               onclick="window.location.href='/p_manage'"/>
			    </form>
			    
			    <script>
				    function showMessage() {
				    	alert('수정이 완료되었습니다.');
				        
				        // 잠시 후 메시지를 숨김 (2초 후)
				        setTimeout(() => {
				            document.getElementById('message').style.display = 'none';
				        }, 2000);
				    }
			    </script>
			</div>
       
		<!-- Divider -->
        <div class="custom-container">
            <hr>
        </div>
    </div>
    
    <!-- FOOTER -->
    <footer class="container">
        <p class="float-end"><strong>털뭉치즈</strong></p>
        <p>COMPANY : 털뭉치즈</p>
    </footer>
    
    
<!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
