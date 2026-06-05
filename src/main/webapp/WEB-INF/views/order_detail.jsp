<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<h2>订单详情</h2>

<div class="order-detail">
    <div class="order-info">
        <p><strong>订单编号：</strong>${order.orderNo}</p>
        <p><strong>订单状态：</strong>
            <c:choose>
                <c:when test="${order.status == 'pending'}">待支付</c:when>
                <c:when test="${order.status == 'paid'}">已支付</c:when>
                <c:when test="${order.status == 'shipped'}">已发货</c:when>
                <c:when test="${order.status == 'completed'}">已完成</c:when>
                <c:when test="${order.status == 'cancelled'}">已取消</c:when>
            </c:choose>
        </p>
        <p><strong>收货人：</strong>${order.receiverName}</p>
        <p><strong>手机号：</strong>${order.receiverPhone}</p>
        <p><strong>收货地址：</strong>${order.receiverAddress}</p>
        <p><strong>创建时间：</strong><fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
        <c:if test="${not empty order.payTime}">
            <p><strong>支付时间：</strong><fmt:formatDate value="${order.payTime}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
        </c:if>
    </div>

    <h3>商品明细</h3>
    <table class="data-table">
        <thead>
            <tr>
                <th>商品名称</th>
                <th>单价</th>
                <th>数量</th>
                <th>小计</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${order.items}" var="item">
                <tr>
                    <td>${item.productName}</td>
                    <td>¥ <fmt:formatNumber value="${item.productPrice}" pattern="#,##0.00"/></td>
                    <td>${item.quantity}</td>
                    <td>¥ <fmt:formatNumber value="${item.totalPrice}" pattern="#,##0.00"/></td>
                </tr>
            </c:forEach>
        </tbody>
        <tfoot>
            <tr>
                <td colspan="3" class="text-right"><strong>合计：</strong></td>
                <td><strong>¥ <fmt:formatNumber value="${order.totalPrice}" pattern="#,##0.00"/></strong></td>
            </tr>
        </tfoot>
    </table>

    <div class="form-actions" style="margin-top:20px;">
        <c:if test="${order.status == 'pending'}">
            <a href="${pageContext.request.contextPath}/order/pay/${order.id}" class="btn btn-success" onclick="return confirm('确认支付？')">去支付</a>
            <a href="${pageContext.request.contextPath}/order/cancel/${order.id}" class="btn btn-danger" onclick="return confirm('确认取消？')">取消订单</a>
        </c:if>
        <a href="${pageContext.request.contextPath}/order/list" class="btn btn-default">返回订单列表</a>
    </div>
</div>

<%@ include file="footer.jsp" %>
