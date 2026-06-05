<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<h2>我的订单</h2>

<c:choose>
    <c:when test="${not empty orders}">
        <table class="data-table">
            <thead>
                <tr>
                    <th>订单编号</th>
                    <th>金额</th>
                    <th>状态</th>
                    <th>收件人</th>
                    <th>创建时间</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${orders}" var="order">
                    <tr>
                        <td><a href="${pageContext.request.contextPath}/order/detail/${order.id}">${order.orderNo}</a></td>
                        <td>¥ <fmt:formatNumber value="${order.totalPrice}" pattern="#,##0.00"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${order.status == 'pending'}"><span class="badge badge-warning">待支付</span></c:when>
                                <c:when test="${order.status == 'paid'}"><span class="badge badge-info">已支付</span></c:when>
                                <c:when test="${order.status == 'shipped'}"><span class="badge badge-primary">已发货</span></c:when>
                                <c:when test="${order.status == 'completed'}"><span class="badge badge-success">已完成</span></c:when>
                                <c:when test="${order.status == 'cancelled'}"><span class="badge badge-danger">已取消</span></c:when>
                            </c:choose>
                        </td>
                        <td>${order.receiverName}</td>
                        <td><fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/order/detail/${order.id}" class="btn btn-sm btn-primary">详情</a>
                            <c:if test="${order.status == 'pending'}">
                                <a href="${pageContext.request.contextPath}/order/pay/${order.id}" class="btn btn-sm btn-success" onclick="return confirm('确认支付？')">支付</a>
                                <a href="${pageContext.request.contextPath}/order/cancel/${order.id}" class="btn btn-sm btn-danger" onclick="return confirm('确认取消？')">取消</a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:when>
    <c:otherwise>
        <p class="empty-msg">暂无订单，<a href="${pageContext.request.contextPath}/">去逛逛</a></p>
    </c:otherwise>
</c:choose>

<%@ include file="footer.jsp" %>
