<%@ page language="java" import="java.util.*,com.alphaking.constant.*,com.alphaking.model.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>金明同达灯饰</title>
    <link href="<%=request.getContextPath() %>/resources/common/bootstrap.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/customer/assets/css/personCenter.css" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
</head>
<body>
<c:set var="UNAUTHORIZED" value="<%=UserCheckStatus.UNAUTHORIZED%>" />
<c:set var="AUTHORIZING" value="<%=UserCheckStatus.AUTHORIZING%>" />
<c:set var="AUTHENTICATION_FAILURE" value="<%=UserCheckStatus.AUTHENTICATION_FAILURE%>" />
<c:set var="AUTHENTICATION_SUCCESS" value="<%=UserCheckStatus.AUTHENTICATION_SUCCESS%>" />
<c:set var="AGENCY" value="<%=UserType.AGENCY%>" />
<c:set var="FACILITATOR" value="<%=UserType.FACILITATOR%>" />
<div class="distributor">
    <div class="title">认证申请</div>
	
	<div class="img-content" id="qrCode">
        <img src="${newQrCode}" alt="" style="width:100%"/>
    </div>
</div>

<jsp:include page="/jsp/buyer/footer.jsp"></jsp:include>
</body>
</html>
