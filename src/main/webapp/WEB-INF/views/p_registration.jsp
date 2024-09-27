<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 등록</title>
</head>
<body>
    <h1>상품 등록</h1>
    <form action="p_registration" method="post" enctype="multipart/form-data">
        
        <input type="file" name="file" required /><br>
        
        <input type="text" name="pd_name" placeholder="상품명" required /><br>
        
        <select name="pd_animal" required>
            <option value="dog">강아지</option>
            <option value="cat">고양이</option>
        </select><br>
        
        <select name="pd_category" required>
            <option value="food">사료</option>
            <option value="refreshment">간식</option>
            <option value="product">용품</option>
            <option value="etc">기타</option>
        </select><br>
        
        <input type="text" name="pd_price" placeholder="가격" required /><br>
        
        <input type="text" name="pd_amount" placeholder="수량" required /><br>
        
        <input type="file" name="file2" required /><br>
        
        <input type="submit" value="등록하기" />
        <input type="button" value="취소하기" />
    </form>
</body>
</html>
