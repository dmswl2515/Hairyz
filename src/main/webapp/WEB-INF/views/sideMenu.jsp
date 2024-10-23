<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
</style>
<%
    // 현재 요청된 페이지의 URI를 가져옴
    String currentURI = request.getRequestURI();
%>
<div class="d-flex flex-column flex-shrink-0 p-3 bg-light" style="width: 200px; height: 100vh; position: fixed;">
    <ul class="nav nav-pills flex-column mb-auto">
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/memberManagement.do" class="nav-link text-dark">
                회원관리
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/p_manage" class="nav-link text-dark">
                상품관리
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/salesManagement.do" class="nav-link text-dark">
                판매관리
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin_qna.do" class="nav-link text-dark">
                QnA관리
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/reviewManager.do" class="nav-link text-dark">
                후기관리
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin_community.do" class="nav-link text-dark">
                커뮤니티관리
            </a>
        </li>
    </ul>
    <hr>
</div>
