<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>


<!DOCTYPE html>
<html>
<head>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<meta charset="UTF-8">
<title>주문완료</title>
</head>
<body>
<style>
   .table {
   	 width:700px;
     border-color: #ffc107; /* 테이블 테두리 색상 */
     border-collapse: collapse;
  }

  .table th{
  	  border: 1px solid black;
  	  background-color: #fff9c4;
  }
  
  .table td {
  	  border: 1px solid black;
      border-color: #ffc107; /* 테이블 헤더와 셀 테두리 색상 */
  }
  
</style>
	<div class="content">
		<%@ include file="header.jsp" %>
	</div>
	
	<h3 class="text-center mt-5"><strong>주문완료</strong></h3>
	<h6 class="text-center mt-4 mb-4"><strong>결제가 완료되었습니다</strong></h6>
	<div class="container d-flex justify-content-center">
		<table class="table">
		    <tbody>
		        <tr>
		            <td class="text-center" style="font-weight: bold; background-color: #fff9c4;">주문 번호</td>
		            	<td>
		            		<div style="margin-left:20px;">
		            			${ordersDto.odNo}
		            		</div>
		            	</td>
		        </tr>
		        <tr>
		            <td class="text-center" style="font-weight: bold; vertical-align: middle; background-color: #fff9c4;">
		            	배송지
		            </td>
		            <td>
		            	<div style="margin-left:20px;"> 
				            <p>${ordersDto.odMname}</p>
				            <p>${ordersDto.odMphone}</p>
				            <p>${ordersDto.odRzcode}</p>
				            <p>${ordersDto.odRaddress}</p>
				            <p>${ordersDto.odRaddress2}</p>
		            	</div>
		            </td>
		        </tr>
		        <tr>
		            <td class="text-center" style="font-weight: bold; background-color: #fff9c4;">배송 방법</td>
		            <td><div style="margin-left:20px;">택배</div></td>
		        </tr>
		    </tbody>
		</table>
	</div>
	
	<%@ include file="kakaoCh.jsp" %>	
					
	<%@ include file="footer.jsp" %>
<!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>