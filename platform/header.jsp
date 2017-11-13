<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 
<!-- <div class="line1"></div>
<div class="line2"></div>
<div class="line3"></div>-->
<!-- [[头部 -->
<header class="header container-fluid">
    <div class="row">
        <div class="col-xs-6">
            <img src="<%=request.getContextPath() %>/resources/backStage/image/logo.jpg" alt="一内购" class="logo">
            <button class="btn navBtn glyphicon glyphicon-list"></button>
            <h1 class="websiteName">管理后台</h1>
        </div>
        <div class="col-xs-6 text-right">
            <button class="btnExit fr" type="button" onclick="window.location.href='<%=request.getContextPath()%>/platform/exit'"><span class="glyphicon glyphicon-user"></span> ${sessionScope.adminName}</button>
        </div>
    </div>
</header><!-- 头部]] -->