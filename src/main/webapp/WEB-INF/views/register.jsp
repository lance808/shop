<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<div class="form-container">
    <h2>用户注册</h2>
    <c:if test="${not empty error}">
        <p class="error-msg">${error}</p>
    </c:if>
    <form action="${pageContext.request.contextPath}/user/doRegister" method="post">
        <div class="form-group">
            <label>用户名 *</label>
            <input type="text" name="username" required>
        </div>
        <div class="form-group">
            <label>密码 *</label>
            <input type="password" name="password" required>
        </div>
        <div class="form-group">
            <label>真实姓名</label>
            <input type="text" name="realName">
        </div>
        <div class="form-group">
            <label>手机号</label>
            <input type="text" name="phone">
        </div>
        <div class="form-group">
            <label>邮箱</label>
            <input type="email" name="email">
        </div>
        <div class="form-group">
            <button type="submit" class="btn btn-primary btn-block">注册</button>
        </div>
        <p class="form-footer">已有账号？<a href="${pageContext.request.contextPath}/user/login">立即登录</a></p>
    </form>
</div>

<%@ include file="footer.jsp" %>
