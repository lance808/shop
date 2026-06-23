<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>商城管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="header">
    <div class="container">
        <div class="logo">
            <a href="${pageContext.request.contextPath}/">🛒 商城商品管理系统</a>
        </div>
        <div class="search-bar">
            <form action="${pageContext.request.contextPath}/search" method="get">
                <input type="text" name="keyword" placeholder="搜索商品..." value="${keyword}">
                <button type="submit">搜索</button>
            </form>
        </div>
        <div class="user-nav">
            <c:choose>
                <c:when test="${sessionScope.loginUser != null}">
                    <span>欢迎，${sessionScope.loginUser.realName != null ? sessionScope.loginUser.realName : sessionScope.loginUser.username}</span>
                    <a href="${pageContext.request.contextPath}/cart/list">购物车</a>
                    <a href="${pageContext.request.contextPath}/favorite/list">收藏夹</a>
                    <a href="${pageContext.request.contextPath}/order/list">我的订单</a>
                    <a href="${pageContext.request.contextPath}/address/list">收货地址</a>
                    <a href="${pageContext.request.contextPath}/user/profile">个人中心</a>
                    <c:if test="${sessionScope.loginUser.role == 'admin'}">
                        <a href="${pageContext.request.contextPath}/admin/index">后台管理</a>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/user/logout">退出</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/user/login">登录</a>
                    <a href="${pageContext.request.contextPath}/user/register">注册</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
<div class="main-content container">
