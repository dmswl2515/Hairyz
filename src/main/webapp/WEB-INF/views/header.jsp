<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	    footer hr {
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

     <div class="custom-container">
         <div class="row align-items-center py-3">
             <div class="col-9 logo-container">
                 <a href="${pageContext.request.contextPath}/main_view.do">
                 	 <img src="${pageContext.request.contextPath}/images/logo.png" alt="로고">
                 </a>
             </div>
	
			<div class="col-3 text-right">
				<%
				//아이디 취득 후 id가 Null인지 확인
				String id = (String)session.getAttribute("userId");
				if (id == null)
				{
				%>
                 	<a href="${pageContext.request.contextPath}/login.do" class="btn btn-outline-warning">로그인</a>
                 <%}else{%>
                 	<a href="#" class="btn btn-outline-warning">마이페이지</a>
                 	<a href="s_cart" class="btn btn-outline-warning">장바구니</a>
                 <%} %>
             </div>
         </div>
     </div>

     <!-- Navigation Bar -->
     <nav class="navbar navbar-expand-lg navbar-light">
         <div class="custom-container">
             <ul class="navbar-nav mr-auto">
                 <li class="nav-item">
                     <a class="nav-link" href="list.do">커뮤니티</a>
                 </li>
                 <li class="nav-item">
                     <a class="nav-link" href="s_main">쇼핑</a>
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
