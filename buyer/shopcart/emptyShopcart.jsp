<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 

<!DOCTYPE html>
<html class="html" id="cart">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>金明同达灯饰</title>
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/customer/assets/css/orderCart.css" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
</head>
<body>
<div class="emptyCart">
    <div class="title">购物车列表</div>
    <a href="javascript:history.go(-1);"><i class="iconfont back" >&#xe624;</i></a>
	<div class="empty"><!-- 
	    <i class="iconfont">&#xe605;</i> -->
	    <img src="<%=request.getContextPath() %>/resources/customer/assets/images/emptyShopcart.png" style="height:4rem;width:4rem;"/>
	    <p>购物车里面空空的...</p>
	    <a href="<%=request.getContextPath()%>/buyer/index">前往商城首页</a>
    </div>
</div>
<jsp:include page="/jsp/buyer/footer.jsp"></jsp:include>
</body>
</html>