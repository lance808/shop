<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<h2>${not empty address.id ? '编辑' : '新增'}收货地址</h2>

<form action="${pageContext.request.contextPath}/address/save" method="post" class="form-container">
    <c:if test="${not empty address.id}">
        <input type="hidden" name="id" value="${address.id}">
    </c:if>
    <div class="form-group">
        <label>收货人姓名</label>
        <input type="text" name="receiverName" value="${address.receiverName}" required>
    </div>
    <div class="form-group">
        <label>联系电话</label>
        <input type="text" name="receiverPhone" value="${address.receiverPhone}" required>
    </div>
    <div class="form-group">
        <label>省份</label>
        <input type="text" name="province" value="${address.province}" placeholder="如：广东省">
    </div>
    <div class="form-group">
        <label>城市</label>
        <input type="text" name="city" value="${address.city}" placeholder="如：广州市">
    </div>
    <div class="form-group">
        <label>区/县</label>
        <input type="text" name="district" value="${address.district}" placeholder="如：天河区">
    </div>
    <div class="form-group">
        <label>详细地址</label>
        <input type="text" name="detail" value="${address.detail}" placeholder="街道/小区/门牌号" required>
    </div>
    <div class="form-group">
        <label>
            <input type="checkbox" name="isDefault" value="1" ${address.isDefault == 1 ? 'checked' : ''}> 设为默认地址
        </label>
    </div>
    <button type="submit" class="btn btn-primary btn-block">保存</button>
</form>

<%@ include file="footer.jsp" %>
