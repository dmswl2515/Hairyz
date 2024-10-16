<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 등록</title>
<!-- Bootstrap CSS -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<div class="content">
		<%@ include file="header.jsp" %>
	</div>
        
<style>
    
    /* 등록& 취소 버튼 넓이 */
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
    
    
</style>     

	   	 <h4 class="text-center mt-4">상품 등록</h4>
			<div class="d-flex justify-content-center align-items-center">
			    <form action="p_registration" method="post" enctype="multipart/form-data" class="text-center">
			        <!-- 첫 번째 파일 선택 -->
			        <div style="text-align: center;">
				        <img id="productImagePreview1" src="images/add_photo.png" alt="상품 이미지 1" 
	    					 class="image-preview" style="width: 150px; height: 150px; cursor: pointer; object-fit: cover; border-radius: 15px;" />
			            <input type="file" name="file" id="fileInput" class="form-control-file" required 
			            	   onchange="checkFileSize(event, 'productImagePreview1', 'fileName')" style="display: none;"/><br>
			        	<label for="fileInput" class="btn btn-outline-warning">파일 선택</label><br>
    					<span id="fileName" class="ml-2">선택된 파일이 없습니다.</span>
			        </div>
			
			        
			            <input type="text" name="pdName" class="form-control custom-input-width mt-2" placeholder="상품명" required /><br>
			        
			
			        <div class="d-flex justify-content-center">
			            <select name="pd_animal" class="form-control mr-2" required>
			                <option value="all">전체</option>
			                <option value="dog">강아지</option>
			                <option value="cat">고양이</option>
			            </select>
			        
			
			            <select name="pd_category" class="form-control mb-4" required>
			                <option value="food">사료</option>
			                <option value="refreshment">간식</option>
			                <option value="product">용품</option>
			                <option value="etc">리빙</option>
			            </select><br>
			        </div>
			        
			            <input type="text" name="pd_price" class="form-control custom-input-width" placeholder="가격" required /><br>
			        
			
			            <input type="text" name="pd_amount" class="form-control custom-input-width" placeholder="수량" required /><br>
			       
			
			        <div style="text-align: center;">
			            <img id="productImagePreview2" src="images/add_photo.png" alt="상품 상세 이미지 2" 
     						 class="image-preview" style="width: 150px; height: 150px; cursor: pointer; object-fit: cover; border-radius: 15px;" /><br>
			            
			            <input type="file" name="file2" id="fileInput2" class="form-control-file" required 
					           onchange="checkFileSize(event, 'productImagePreview2', 'fileName2')" style="display: none;"/>
					    <label for="fileInput2" class="btn btn-outline-warning file-input-label">파일 선택</label><br>
					    <span id="fileName2" class="ml-2">선택된 파일이 없습니다.</span>
			        </div>
			        
			        <hr class="custom-hr">
			        
				        <input type="submit" class="btn btn-outline-warning mb-2 custom-width" value="등록하기" /></br>
				        <input type="button" class="btn btn-outline-warning custom-width" value="취소하기" />
			    </form>
			</div>
			
<!-- 이미지 미리보기 -->
<script>
//파일 크기 제한: 10MB (10 * 1024 * 1024 바이트)
const MAX_FILE_SIZE = 10 * 1024 * 1024;

function checkFileSize(event, previewId, fileNameId) {
    const file = event.target.files[0];

    // 파일 크기 검사
    if (file && file.size > MAX_FILE_SIZE) {
        alert("파일 크기가 너무 큽니다. 최대 10MB까지 업로드할 수 있습니다.");
        event.target.value = ""; // 파일 입력 초기화
        return;
    }

    previewImage(event, previewId, fileNameId);
}

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
       
		<!-- Divider -->
        <div class="custom-container">
            <hr>
        </div>
    </div>
   
    <!-- FOOTER -->
    <%@ include file="footer.jsp" %>
    
    
<!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
