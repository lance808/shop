<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<div class="form-container">
    <h2>用户登录</h2>
    <c:if test="${not empty error}">
        <p class="error-msg">${error}</p>
    </c:if>
    <c:if test="${not empty msg}">
        <p class="success-msg">${msg}</p>
    </c:if>
    <form action="${pageContext.request.contextPath}/user/doLogin" method="post">
        <div class="form-group">
            <label>用户名</label>
            <input type="text" name="username" value="${username}" required>
        </div>
        <div class="form-group">
            <label>密码</label>
            <input type="password" name="password" required>
        </div>
        <div class="form-group">
            <button type="submit" class="btn btn-primary btn-block">登录</button>
        </div>
        <p class="form-footer">还没有账号？<a href="${pageContext.request.contextPath}/user/register">立即注册</a></p>
    </form>
</div>

<%@ include file="footer.jsp" %>
