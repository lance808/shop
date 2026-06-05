<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<div class="home-layout">
    <div class="sidebar">
        <h3>商品分类</h3>
        <ul class="category-list">
            <li><a href="${pageContext.request.contextPath}/product/list" class="${empty categoryId ? 'active' : ''}">全部商品</a></li>
            <c:forEach items="${categories}" var="cat">
                <c:if test="${cat.parentId == 0}">
                    <li>
                        <a href="${pageContext.request.contextPath}/product/list?categoryId=${cat.id}" class="${categoryId == cat.id ? 'active' : ''}">${cat.name}</a>
                        <ul class="sub-category">
                            <c:forEach items="${categories}" var="sub">
                                <c:if test="${sub.parentId == cat.id}">
                                    <li><a href="${pageContext.request.contextPath}/product/list?categoryId=${sub.id}" class="${categoryId == sub.id ? 'active' : ''}">${sub.name}</a></li>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </li>
                </c:if>
            </c:forEach>
        </ul>
    </div>
    <div class="content">
        <h2>
            <c:choose>
                <c:when test="${not empty keyword}">搜索"${keyword}"的结果</c:when>
                <c:when test="${not empty categoryId}">分类商品</c:when>
                <c:otherwise>全部商品</c:otherwise>
            </c:choose>
        </h2>
        <div class="product-grid">
            <c:forEach items="${products}" var="product">
                <div class="product-card">
                    <div class="product-img">
                        <c:choose>
                            <c:when test="${not empty product.image}">
                                <img src="${pageContext.request.contextPath}/${product.image}" alt="${product.name}">
                            </c:when>
                            <c:otherwise>
                                <div class="no-image">暂无图片</div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="product-info">
                        <h4><a href="${pageContext.request.contextPath}/product/detail/${product.id}">${product.name}</a></h4>
                        <p class="category-name">${product.categoryName}</p>
                        <p class="price">¥ <fmt:formatNumber value="${product.price}" pattern="#,##0.00"/></p>
                        <p class="sales">已售 ${product.sales} 件</p>
                        <div class="product-actions">
                            <a href="${pageContext.request.contextPath}/product/detail/${product.id}" class="btn btn-primary">查看详情</a>
                            <c:if test="${sessionScope.loginUser != null}">
                                <a href="${pageContext.request.contextPath}/cart/add?productId=${product.id}" class="btn btn-success">加入购物车</a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty products}">
                <p class="empty-msg">暂无商品</p>
            </c:if>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>
