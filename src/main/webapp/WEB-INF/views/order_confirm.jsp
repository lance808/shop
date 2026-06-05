<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<h2>确认订单</h2>

<div class="order-confirm">
    <h3>订单商品</h3>
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
            <c:forEach items="${carts}" var="cart">
                <tr>
                    <td>${cart.productName}</td>
                    <td>¥ <fmt:formatNumber value="${cart.productPrice}" pattern="#,##0.00"/></td>
                    <td>${cart.quantity}</td>
                    <td>¥ <fmt:formatNumber value="${cart.productPrice * cart.quantity}" pattern="#,##0.00"/></td>
                </tr>
            </c:forEach>
        </tbody>
        <tfoot>
            <tr>
                <td colspan="3" class="text-right"><strong>合计：</strong></td>
                <td><strong>¥ <fmt:formatNumber value="${total}" pattern="#,##0.00"/></strong></td>
            </tr>
        </tfoot>
    </table>

    <h3>收货信息</h3>
    <form action="${pageContext.request.contextPath}/order/create" method="post">
        <input type="hidden" name="cartIds" value="${cartIds}">
        <div class="form-group">
            <label>收货人 *</label>
            <input type="text" name="receiverName" value="${sessionScope.loginUser.realName}" required>
        </div>
        <div class="form-group">
            <label>手机号 *</label>
            <input type="text" name="receiverPhone" value="${sessionScope.loginUser.phone}" required>
        </div>
        <div class="form-group">
            <label>收货地址 *</label>
            <textarea name="receiverAddress" rows="3" required></textarea>
        </div>
        <div class="form-group">
            <button type="submit" class="btn btn-primary btn-lg">提交订单</button>
            <a href="${pageContext.request.contextPath}/cart/list" class="btn btn-default">返回购物车</a>
        </div>
    </form>
</div>

<%@ include file="footer.jsp" %>
