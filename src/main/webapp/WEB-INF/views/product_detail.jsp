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
                <a href="${pageContext.request.contextPath}/favorite/add?productId=${product.id}" class="btn btn-default btn-lg">⭐ 收藏</a>
            </c:if>
            <a href="javascript:history.back()" class="btn btn-default btn-lg">返回</a>
        </div>
    </div>
</div>

<div class="review-section">
    <h3>商品评价
        <a href="${pageContext.request.contextPath}/review/list/${product.id}" class="btn btn-sm btn-default">查看全部评价</a>
    </h3>
    <c:if test="${sessionScope.loginUser != null}">
        <form action="${pageContext.request.contextPath}/review/add" method="post" class="review-form">
            <input type="hidden" name="productId" value="${product.id}">
            <div class="form-group">
                <label>评分</label>
                <select name="rating" class="rating-select">
                    <option value="5">★★★★★ 5分</option>
                    <option value="4">★★★★☆ 4分</option>
                    <option value="3">★★★☆☆ 3分</option>
                    <option value="2">★★☆☆☆ 2分</option>
                    <option value="1">★☆☆☆☆ 1分</option>
                </select>
            </div>
            <div class="form-group">
                <label>评价内容</label>
                <textarea name="content" rows="3" placeholder="分享你的使用体验..."></textarea>
            </div>
            <button type="submit" class="btn btn-primary">提交评价</button>
        </form>
    </c:if>
    <c:if test="${sessionScope.loginUser == null}">
        <p style="color:#999;">请<a href="${pageContext.request.contextPath}/user/login">登录</a>后发表评价</p>
    </c:if>
</div>

<%@ include file="footer.jsp" %>
