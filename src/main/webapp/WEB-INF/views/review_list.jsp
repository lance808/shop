<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<h2>商品评价
    <c:if test="${not empty avgRating}">
        <span style="color:#fa8c16;font-size:16px;">
            ★ <fmt:formatNumber value="${avgRating}" pattern="#"/> 分
        </span>
        <span style="color:#999;font-size:14px;">（${reviewCount} 条评价）</span>
    </c:if>
</h2>

<a href="${pageContext.request.contextPath}/product/detail/${productId}" class="btn btn-default btn-sm">&larr; 返回商品详情</a>

<c:if test="${empty reviews}">
    <p class="empty-msg">暂无评价，购买后可发表评价</p>
</c:if>

<c:forEach items="${reviews}" var="r">
<div class="review-card">
    <div class="review-header">
        <strong>${r.username}</strong>
        <span class="star-rating">
            <c:forEach begin="1" end="5" var="i">
                <c:choose>
                    <c:when test="${i <= r.rating}">★</c:when>
                    <c:otherwise>☆</c:otherwise>
                </c:choose>
            </c:forEach>
        </span>
        <span class="review-time"><fmt:formatDate value="${r.createTime}" pattern="yyyy-MM-dd HH:mm"/></span>
    </div>
    <div class="review-content">${r.content}</div>
</div>
</c:forEach>

<%@ include file="footer.jsp" %>
