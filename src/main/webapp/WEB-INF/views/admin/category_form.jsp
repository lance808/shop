<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<h2>${empty category ? '添加分类' : '编辑分类'}</h2>

<div class="form-container">
    <form action="${pageContext.request.contextPath}/admin/category/save" method="post">
        <input type="hidden" name="id" value="${category.id}">

        <div class="form-group">
            <label>分类名称 *</label>
            <input type="text" name="name" value="${category.name}" required>
        </div>
        <div class="form-group">
            <label>父级分类</label>
            <select name="parentId">
                <option value="0">顶级分类</option>
                <c:forEach items="${categories}" var="cat">
                    <c:if test="${cat.parentId == 0}">
                        <option value="${cat.id}" ${category.parentId == cat.id ? 'selected' : ''}>${cat.name}</option>
                    </c:if>
                </c:forEach>
            </select>
        </div>
        <div class="form-group">
            <label>排序</label>
            <input type="number" name="sortOrder" value="${category.sortOrder != null ? category.sortOrder : 0}">
        </div>
        <div class="form-group">
            <button type="submit" class="btn btn-primary">保存</button>
            <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-default">返回</a>
        </div>
    </form>
</div>

<%@ include file="footer.jsp" %>
