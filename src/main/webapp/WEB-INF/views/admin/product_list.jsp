<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<h2>商品管理</h2>
<div class="toolbar">
    <form action="${pageContext.request.contextPath}/admin/product/list" method="get" class="filter-form">
        <input type="text" name="name" placeholder="商品名称" value="${name}">
        <select name="categoryId">
            <option value="">全部分类</option>
            <c:forEach items="${categories}" var="cat">
                <option value="${cat.id}" ${categoryId == cat.id ? 'selected' : ''}>${cat.name}</option>
            </c:forEach>
        </select>
        <button type="submit" class="btn btn-primary">查询</button>
    </form>
    <a href="${pageContext.request.contextPath}/admin/product/addPage" class="btn btn-success">添加商品</a>
</div>

<table class="data-table">
    <thead>
        <tr>
            <th>ID</th>
            <th>图片</th>
            <th>名称</th>
            <th>分类</th>
            <th>价格</th>
            <th>库存</th>
            <th>销量</th>
            <th>状态</th>
            <th>操作</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${products}" var="product">
            <tr>
                <td>${product.id}</td>
                <td>
                    <c:choose>
                        <c:when test="${not empty product.image}">
                            <img src="${pageContext.request.contextPath}/${product.image}" width="50" alt="${product.name}">
                        </c:when>
                        <c:otherwise>
                            <span class="no-image-text">无图</span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>${product.name}</td>
                <td>${product.categoryName}</td>
                <td>¥ <fmt:formatNumber value="${product.price}" pattern="#,##0.00"/></td>
                <td>${product.stock}</td>
                <td>${product.sales}</td>
                <td>
                    <c:choose>
                        <c:when test="${product.status == 1}"><span class="badge badge-success">上架</span></c:when>
                        <c:otherwise><span class="badge badge-danger">下架</span></c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/product/editPage/${product.id}" class="btn btn-sm btn-primary">编辑</a>
                    <a href="${pageContext.request.contextPath}/admin/product/delete/${product.id}" class="btn btn-sm btn-danger" onclick="return confirm('确定删除？')">删除</a>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${empty products}">
            <tr><td colspan="9" class="text-center">暂无商品数据</td></tr>
        </c:if>
    </tbody>
</table>

<%@ include file="footer.jsp" %>
