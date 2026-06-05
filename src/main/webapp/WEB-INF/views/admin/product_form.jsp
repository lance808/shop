<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<h2>${empty product ? '添加商品' : '编辑商品'}</h2>

<div class="form-container">
    <form action="${pageContext.request.contextPath}/admin/product/save" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${product.id}">

        <div class="form-group">
            <label>商品名称 *</label>
            <input type="text" name="name" value="${product.name}" required>
        </div>
        <div class="form-group">
            <label>所属分类 *</label>
            <select name="categoryId" required>
                <option value="">请选择分类</option>
                <c:forEach items="${categories}" var="cat">
                    <option value="${cat.id}" ${product.categoryId == cat.id ? 'selected' : ''}>${cat.name}</option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group">
            <label>商品描述</label>
            <textarea name="description" rows="5">${product.description}</textarea>
        </div>
        <div class="form-group">
            <label>价格 *</label>
            <input type="number" step="0.01" name="price" value="${product.price}" required>
        </div>
        <div class="form-group">
            <label>库存 *</label>
            <input type="number" name="stock" value="${product.stock}" required>
        </div>
        <div class="form-group">
            <label>商品图片</label>
            <c:if test="${not empty product.image}">
                <div>
                    <img src="${pageContext.request.contextPath}/${product.image}" width="100" alt="${product.name}">
                    <p>当前图片</p>
                </div>
            </c:if>
            <input type="file" name="imageFile" accept="image/*">
        </div>
        <div class="form-group">
            <label>状态</label>
            <select name="status">
                <option value="1" ${product.status == 1 ? 'selected' : ''}>上架</option>
                <option value="0" ${product.status == 0 ? 'selected' : ''}>下架</option>
            </select>
        </div>
        <div class="form-group">
            <button type="submit" class="btn btn-primary">保存</button>
            <a href="${pageContext.request.contextPath}/admin/product/list" class="btn btn-default">返回</a>
        </div>
    </form>
</div>

<%@ include file="footer.jsp" %>
