<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<h2>个人中心</h2>

<c:if test="${not empty msg}">
    <p class="success-msg">${msg}</p>
</c:if>

<div class="form-container">
    <form action="${pageContext.request.contextPath}/user/updateProfile" method="post">
        <div class="form-group">
            <label>用户名</label>
            <input type="text" value="${sessionScope.loginUser.username}" disabled>
        </div>
        <div class="form-group">
            <label>真实姓名</label>
            <input type="text" name="realName" value="${sessionScope.loginUser.realName}">
        </div>
        <div class="form-group">
            <label>手机号</label>
            <input type="text" name="phone" value="${sessionScope.loginUser.phone}">
        </div>
        <div class="form-group">
            <label>邮箱</label>
            <input type="email" name="email" value="${sessionScope.loginUser.email}">
        </div>
        <div class="form-group">
            <button type="submit" class="btn btn-primary">保存修改</button>
        </div>
    </form>
</div>

<%@ include file="footer.jsp" %>
