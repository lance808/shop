<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<h2>分类管理</h2>
<div class="toolbar">
    <a href="${pageContext.request.contextPath}/admin/category/addPage" class="btn btn-success">添加分类</a>
</div>

<table class="data-table">
    <thead>
        <tr>
            <th>ID</th>
            <th>名称</th>
            <th>父级分类</th>
            <th>排序</th>
            <th>创建时间</th>
            <th>操作</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${categories}" var="cat">
            <tr>
                <td>${cat.id}</td>
                <td>${cat.name}</td>
                <td>
                    <c:choose>
                        <c:when test="${cat.parentId == 0}">顶级分类</c:when>
                        <c:otherwise>
                            <c:forEach items="${categories}" var="pc">
                                <c:if test="${pc.id == cat.parentId}">${pc.name}</c:if>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>${cat.sortOrder}</td>
                <td><fmt:formatDate value="${cat.createTime}" pattern="yyyy-MM-dd"/></td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/category/editPage/${cat.id}" class="btn btn-sm btn-primary">编辑</a>
                    <a href="${pageContext.request.contextPath}/admin/category/delete/${cat.id}" class="btn btn-sm btn-danger" onclick="return confirm('确定删除？子分类也会受影响！')">删除</a>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${empty categories}">
            <tr><td colspan="6" class="text-center">暂无分类数据</td></tr>
        </c:if>
    </tbody>
</table>

<%@ include file="footer.jsp" %>
