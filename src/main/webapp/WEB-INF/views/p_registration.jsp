<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
    out.println("상품 등록");
%>

<form action="upload" method="post" enctype="multipart/form-data"></br>
    <img src="images/sample.jpg" alt="Sample Image" /><br>
    <input type="file" name="file" id="fileUpload" /></br>
    <input type="text" id="textBox" name="textBox" value="상품명" /><br>
    
    <select id="pets" name="pets">
            <option value="dog">개</option>
            <option value="cat">고양이</option>
    </select>
    
    <select id="pets" name="pets">
            <option value="food">사료</option>
            <option value="refreshment">간식</option>
            <option value="product">용품</option>
            <option value="etc">기타</option>
            
    </select><br>
    
    
    <input type="text" id="textBox" name="textBox" value="가격" /><br>
    <input type="text" id="textBox" name="textBox" value="수량" /><br>
    
    <textarea id="description" name="description" rows="10" cols="50"></textarea>
    
    <hr>
    <input type="submit" value="등록하기" />
</form>
    <input type="submit" value="취소하기" />
</body>
</html>