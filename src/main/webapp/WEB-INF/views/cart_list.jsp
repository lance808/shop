<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<h2>我的购物车</h2>
<c:if test="${not empty msg}">
    <p class="success-msg">${msg}</p>
</c:if>

<c:choose>
    <c:when test="${not empty carts}">
        <form action="${pageContext.request.contextPath}/order/confirm" method="get" id="cartForm">
            <table class="data-table">
                <thead>
                    <tr>
                        <th><input type="checkbox" id="selectAll"> 全选</th>
                        <th>商品图片</th>
                        <th>商品名称</th>
                        <th>单价</th>
                        <th>数量</th>
                        <th>小计</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="total" value="0"/>
                    <c:forEach items="${carts}" var="cart" varStatus="status">
                        <tr>
                            <td><input type="checkbox" name="cartIds" value="${cart.id}" class="cart-checkbox"></td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty cart.productImage}">
                                        <img src="${pageContext.request.contextPath}/${cart.productImage}" width="60" alt="${cart.productName}">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="no-image small">无图</div>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${cart.productName}</td>
                            <td>¥ <fmt:formatNumber value="${cart.productPrice}" pattern="#,##0.00"/></td>
                            <td>
                                <input type="number" value="${cart.quantity}" min="1" style="width:50px;"
                                       onchange="updateQuantity(${cart.id}, this.value)">
                            </td>
                            <td>¥ <fmt:formatNumber value="${cart.productPrice * cart.quantity}" pattern="#,##0.00"/></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/cart/delete/${cart.id}" class="btn btn-danger btn-sm" onclick="return confirm('确定删除？')">删除</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="cart-footer">
                <button type="submit" class="btn btn-primary btn-lg">结算</button>
            </div>
        </form>
    </c:when>
    <c:otherwise>
        <p class="empty-msg">购物车是空的，<a href="${pageContext.request.contextPath}/">去逛逛</a></p>
    </c:otherwise>
</c:choose>

<script>
document.getElementById('selectAll').addEventListener('change', function() {
    var checkboxes = document.getElementsByClassName('cart-checkbox');
    for (var i = 0; i < checkboxes.length; i++) {
        checkboxes[i].checked = this.checked;
    }
});

function updateQuantity(cartId, quantity) {
    window.location.href = '${pageContext.request.contextPath}/cart/update/' + cartId + '?quantity=' + quantity;
}
</script>

<%@ include file="footer.jsp" %>
