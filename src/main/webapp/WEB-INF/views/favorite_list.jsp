<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<h2>我的收藏</h2>

<c:if test="${empty favorites}">
    <p class="empty-msg">暂无收藏商品，快去逛逛吧！</p>
</c:if>

<div class="product-grid">
    <c:forEach items="${favorites}" var="fav">
        <div class="product-card">
            <div class="product-img">
                <c:choose>
                    <c:when test="${not empty fav.productImage}">
                        <img src="${pageContext.request.contextPath}/${fav.productImage}" alt="${fav.productName}">
                    </c:when>
                    <c:otherwise>
                        <div class="no-image">暂无图片</div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="product-info">
                <h4><a href="${pageContext.request.contextPath}/product/detail/${fav.productId}">${fav.productName}</a></h4>
                <p class="price">¥ <fmt:formatNumber value="${fav.productPrice}" pattern="#,##0.00"/></p>
                <div class="product-actions">
                    <a href="${pageContext.request.contextPath}/product/detail/${fav.productId}" class="btn btn-primary btn-sm">查看</a>
                    <a href="${pageContext.request.contextPath}/favorite/remove?productId=${fav.productId}" class="btn btn-danger btn-sm">取消收藏</a>
                </div>
            </div>
        </div>
    </c:forEach>
</div>

<%@ include file="footer.jsp" %>
