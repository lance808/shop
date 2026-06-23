<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<h2>收货地址管理</h2>
<a href="${pageContext.request.contextPath}/address/addPage" class="btn btn-primary">添加新地址</a>

<c:if test="${empty addresses}">
    <p class="empty-msg">暂无收货地址，点击上方按钮添加</p>
</c:if>

<c:forEach items="${addresses}" var="addr">
<div class="address-card">
    <div class="address-info">
        <strong>${addr.receiverName}</strong> &nbsp; ${addr.receiverPhone}
        <c:if test="${addr.isDefault == 1}"><span class="badge badge-success">默认</span></c:if>
        <br>
        ${addr.province} ${addr.city} ${addr.district} ${addr.detail}
    </div>
    <div class="address-actions">
        <a href="${pageContext.request.contextPath}/address/editPage/${addr.id}" class="btn btn-sm btn-primary">编辑</a>
        <a href="${pageContext.request.contextPath}/address/delete/${addr.id}" class="btn btn-sm btn-danger" onclick="return confirm('确定删除？')">删除</a>
    </div>
</div>
</c:forEach>

<%@ include file="footer.jsp" %>
