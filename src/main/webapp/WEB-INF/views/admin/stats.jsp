<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<h2>数据统计</h2>

<div class="stats-cards">
    <div class="stat-card">
        <div class="stat-number">${pendingOrders + paidOrders + shippedOrders + completedOrders}</div>
        <div class="stat-label">总订单数</div>
    </div>
    <div class="stat-card">
        <div class="stat-number">¥ <fmt:formatNumber value="${orderTotal}" pattern="#,##0.00"/></div>
        <div class="stat-label">销售额</div>
    </div>
    <div class="stat-card">
        <div class="stat-number">${productCount}</div>
        <div class="stat-label">上架商品</div>
    </div>
    <div class="stat-card">
        <div class="stat-number">${userCount}</div>
        <div class="stat-label">注册用户</div>
    </div>
</div>

<h3 style="margin: 25px 0 15px;">订单状态分布</h3>
<div class="stats-cards">
    <div class="stat-card stat-pending">
        <div class="stat-number">${pendingOrders}</div>
        <div class="stat-label">待支付</div>
    </div>
    <div class="stat-card stat-paid">
        <div class="stat-number">${paidOrders}</div>
        <div class="stat-label">已支付</div>
    </div>
    <div class="stat-card stat-shipped">
        <div class="stat-number">${shippedOrders}</div>
        <div class="stat-label">已发货</div>
    </div>
    <div class="stat-card stat-completed">
        <div class="stat-number">${completedOrders}</div>
        <div class="stat-label">已完成</div>
    </div>
</div>

<h3 style="margin: 25px 0 15px;">商品信息</h3>
<div class="stats-cards">
    <div class="stat-card">
        <div class="stat-number">${totalSales}</div>
        <div class="stat-label">总销量（件）</div>
    </div>
    <div class="stat-card">
        <div class="stat-number">${totalStock}</div>
        <div class="stat-label">总库存（件）</div>
    </div>
    <div class="stat-card">
        <div class="stat-number">${productCount}</div>
        <div class="stat-label">上架商品</div>
    </div>
    <div class="stat-card">
        <div class="stat-number">${offProductCount}</div>
        <div class="stat-label">下架商品</div>
    </div>
</div>

<h3 style="margin: 25px 0 15px;">热销商品 TOP10</h3>
<table class="data-table">
    <thead>
        <tr>
            <th>排名</th><th>名称</th><th>分类</th><th>价格</th><th>销量</th><th>库存</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${topProducts}" var="p" varStatus="s">
            <tr>
                <td>${s.index + 1}</td>
                <td>${p.name}</td>
                <td>${p.categoryName}</td>
                <td>¥ <fmt:formatNumber value="${p.price}" pattern="#,##0.00"/></td>
                <td>${p.sales}</td>
                <td>${p.stock}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<%@ include file="footer.jsp" %>
