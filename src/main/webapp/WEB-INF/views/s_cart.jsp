<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="content">
		<%@ include file="header.jsp" %>
	</div>

<style>
	   .table {
      border-color: #ffc107; /* 테이블 테두리 색상 */
  }

  .table th{
  	  background-color: #fff9c4;
  }
  
  .table td {
      border-color: #ffc107; /* 테이블 헤더와 셀 테두리 색상 */
  }
  
	.table thead th {
	    border-bottom: 1px solid #ffcc00;
	}
	
	.table-white {
		background-color: #ffffff;
	}
	
	.table-bottom-border {
	    border-bottom: 1px solid #ffc107; /* 원하는 색상과 두께로 테두리 설정 */
	}
	
	.my-custom-table td, .my-custom-table th {
	    line-height: 2; /* 이 테이블에만 적용 */
	}
</style>



	<div class=container>
		<h3 class="text-center mb-4"><strong>장바구니</strong></h3>
		<div class=container1>
		 	<table class="table table-bordered mb-2">
			  <thead>
			    <tr class="table-warning text-center">
			      <th class="text-center align-middle">
	                  <div class="d-flex justify-content-center align-items-center" style="height: 100%;">
	                      <input class="form-check-input" type="checkbox" id="selectAll">
	                  </div>
            	  </th>
			      <th scope="col">상품정보</th>
			      <th scope="col">수량</th>
			      <th scope="col">주문금액</th>
			      <th scope="col">배송비</th> 
			    </tr>
			  </thead>
				<tbody>
				    <c:forEach var="item" items="${products}">
				        <input type="hidden" name="pdNum" value="${item.pdNum}" />
				        <tr>
				            <!-- 체크박스 열 -->
				            <td class="text-center align-middle">
				                <div class="d-flex justify-content-center align-items-center" style="height: 100%;">
				                    <input class="form-check-input" type="checkbox" id="selectAll">
				                </div>
				            </td>
				            <!-- 상품 정보 열 -->
				            <td>
				                <div class="product-box">
				                    <a href="${pageContext.request.contextPath}/p_details?pdNum=${item.pdNum}" style="color: black;">
				                        <img src="${pageContext.request.contextPath}/upload/${item.pd_chng_fname}" alt="${item.pdName}" style="width:100px; height:100px; object-fit:cover;">
				                    </a>
				                    <p>${item.pdName}</p>
				                </div>
				            </td>
				            <!-- 수량 -->
				            <div>
				            	<td class="text-center align-middle">${item.pd_amount}개
				            </div>
				            <div class="btn-group" role="group" aria-label="Default button group">
	                            <button type="button" id="decrease" class="btn btn-outline-secondary">-</button>
	                            <input type="text" id="quantity-input" style="width: 40px; text-align: center;" value="1" />
	                            <button type="button" id="increase" class="btn btn-outline-secondary">+</button>
	                        </div>	
	                        </td>
				            <!-- 주문 금액 -->
				            <td class="text-center align-middle">${item.pd_price}원</td>
				            <!-- 배송비 -->
				            <td class="text-center align-middle">
				                <span>무료</span>        
				            </td>
				        </tr>
				    </c:forEach>
				</tbody>
			</table>
		</div>
	</div>

					
<%@ include file="footer.jsp" %>
<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>