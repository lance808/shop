<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${totalPages > 0}">
<div class="pagination">
    <%-- 首页 --%>
    <c:choose>
        <c:when test="${page > 1}">
            <a href="?page=1<c:if test="${not empty categoryId}">&categoryId=${categoryId}</c:if><c:if test="${not empty keyword}">&keyword=${keyword}</c:if>">首页</a>
        </c:when>
        <c:otherwise>
            <span class="disabled">首页</span>
        </c:otherwise>
    </c:choose>

    <%-- 上一页 --%>
    <c:choose>
        <c:when test="${page > 1}">
            <a href="?page=${page - 1}<c:if test="${not empty categoryId}">&categoryId=${categoryId}</c:if><c:if test="${not empty keyword}">&keyword=${keyword}</c:if>">上一页</a>
        </c:when>
        <c:otherwise>
            <span class="disabled">上一页</span>
        </c:otherwise>
    </c:choose>

    <%-- 第1页 --%>
    <c:choose>
        <c:when test="${page == 1}">
            <span class="active">1</span>
        </c:when>
        <c:otherwise>
            <a href="?page=1<c:if test="${not empty categoryId}">&categoryId=${categoryId}</c:if><c:if test="${not empty keyword}">&keyword=${keyword}</c:if>">1</a>
        </c:otherwise>
    </c:choose>

    <%-- 左边省略号 --%>
    <c:if test="${page > 4}">
        <span class="info">...</span>
    </c:if>

    <%-- 中间页码 --%>
    <c:forEach begin="${page - 2 > 2 ? page - 2 : 2}" end="${page + 2 < totalPages - 1 ? page + 2 : totalPages - 1}" var="p">
        <c:choose>
            <c:when test="${p == page}">
                <span class="active">${p}</span>
            </c:when>
            <c:otherwise>
                <a href="?page=${p}<c:if test="${not empty categoryId}">&categoryId=${categoryId}</c:if><c:if test="${not empty keyword}">&keyword=${keyword}</c:if>">${p}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <%-- 右边省略号 --%>
    <c:if test="${page < totalPages - 3}">
        <span class="info">...</span>
    </c:if>

    <%-- 最后一页（总页数 > 1 时显示） --%>
    <c:if test="${totalPages > 1}">
        <c:choose>
            <c:when test="${page == totalPages}">
                <span class="active">${totalPages}</span>
            </c:when>
            <c:otherwise>
                <a href="?page=${totalPages}<c:if test="${not empty categoryId}">&categoryId=${categoryId}</c:if><c:if test="${not empty keyword}">&keyword=${keyword}</c:if>">${totalPages}</a>
            </c:otherwise>
        </c:choose>
    </c:if>

    <%-- 下一页 --%>
    <c:choose>
        <c:when test="${page < totalPages}">
            <a href="?page=${page + 1}<c:if test="${not empty categoryId}">&categoryId=${categoryId}</c:if><c:if test="${not empty keyword}">&keyword=${keyword}</c:if>">下一页</a>
        </c:when>
        <c:otherwise>
            <span class="disabled">下一页</span>
        </c:otherwise>
    </c:choose>

    <%-- 末页 --%>
    <c:choose>
        <c:when test="${page < totalPages}">
            <a href="?page=${totalPages}<c:if test="${not empty categoryId}">&categoryId=${categoryId}</c:if><c:if test="${not empty keyword}">&keyword=${keyword}</c:if>">末页</a>
        </c:when>
        <c:otherwise>
            <span class="disabled">末页</span>
        </c:otherwise>
    </c:choose>

    <span class="info">共 ${total} 件商品 / ${totalPages} 页</span>
</div>
</c:if>
