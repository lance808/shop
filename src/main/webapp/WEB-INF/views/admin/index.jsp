<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<h2>控制台</h2>
<div class="dashboard">
    <div class="dash-card">
        <h3>商品总数</h3>
        <p class="dash-num">${productCount}</p>
        <a href="${pageContext.request.contextPath}/admin/product/list">管理商品</a>
    </div>
    <div class="dash-card">
        <h3>分类总数</h3>
        <p class="dash-num">${categoryCount}</p>
        <a href="${pageContext.request.contextPath}/admin/category/list">管理分类</a>
    </div>
    <div class="dash-card">
        <h3>订单总数</h3>
        <p class="dash-num">${orderCount}</p>
        <a href="${pageContext.request.contextPath}/admin/order/list">管理订单</a>
    </div>
</div>

<%@ include file="footer.jsp" %>
