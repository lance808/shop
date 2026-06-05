<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>后台管理 - 商城管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
<div class="admin-layout">
    <div class="admin-sidebar">
        <div class="admin-logo">
            <a href="${pageContext.request.contextPath}/admin/index">后台管理</a>
        </div>
        <ul class="admin-nav">
            <li><a href="${pageContext.request.contextPath}/admin/index">控制台</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/product/list">商品管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/category/list">分类管理</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/order/list">订单管理</a></li>
            <li><a href="${pageContext.request.contextPath}/">返回前台</a></li>
        </ul>
    </div>
    <div class="admin-main">
        <div class="admin-header">
            <span>欢迎，${sessionScope.loginUser.username}</span>
            <a href="${pageContext.request.contextPath}/user/logout">退出</a>
        </div>
        <div class="admin-content">
