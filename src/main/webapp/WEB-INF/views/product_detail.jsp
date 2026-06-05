<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<div class="product-detail">
    <div class="detail-img">
        <c:choose>
            <c:when test="${not empty product.image}">
                <img src="${pageContext.request.contextPath}/${product.image}" alt="${product.name}">
            </c:when>
            <c:otherwise>
                <div class="no-image large">暂无图片</div>
            </c:otherwise>
        </c:choose>
    </div>
    <div class="detail-info">
        <h2>${product.name}</h2>
        <p class="category-name">分类：${product.categoryName}</p>
        <p class="price-big">¥ <fmt:formatNumber value="${product.price}" pattern="#,##0.00"/></p>
        <p>库存：${product.stock} 件</p>
        <p>已售：${product.sales} 件</p>
        <div class="detail-desc">
            <h4>商品描述</h4>
            <p>${product.description}</p>
        </div>
        <div class="detail-actions">
            <c:if test="${sessionScope.loginUser != null}">
                <form action="${pageContext.request.contextPath}/cart/add" method="get" style="display:inline;">
                    <input type="hidden" name="productId" value="${product.id}">
                    <input type="number" name="quantity" value="1" min="1" max="${product.stock}" style="width:60px;">
                    <button type="submit" class="btn btn-success btn-lg">加入购物车</button>
                </form>
            </c:if>
            <a href="javascript:history.back()" class="btn btn-default btn-lg">返回</a>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>
