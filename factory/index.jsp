<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>佐为照明</title>
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/factory/assets/css/index.css" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>

</head>
<body>
<div class="index">
    <div class="title">主页</div>
    <div class="indexContent">
    	<img class="indexImg" src="<%=request.getContextPath() %>/resources/factory/assets/images/logoPNG.png"/>
		<p>选灯位系统正在开发中</p>
    </div>
</div>
<jsp:include page="/jsp/factory/footer.jsp"></jsp:include>
</body>
</html>