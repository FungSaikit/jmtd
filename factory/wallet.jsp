<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html class="walletHtml">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>佐为照明</title>
    <link href="<%=request.getContextPath() %>/resources/factory/assets/css/capital.css" rel="stylesheet">
    
</head>
<body>
<c:set var="WECHAT_CONSUME_GOODS" value="<%=CapitalFlowType.WECHAT_CONSUME_GOODS%>" />
<c:set var="GOODS_MONEY" value="<%=CapitalFlowType.GOODS_MONEY%>" />
<c:set var="COMMISION" value="<%=CapitalFlowType.COMMISION%>" />
<c:set var="WITHDRAW_TO_WECHAT" value="<%=CapitalFlowType.WITHDRAW_TO_WECHAT%>" />
<c:set var="WITHDRAW_TO_ACCOUNT" value="<%=CapitalFlowType.WITHDRAW_TO_ACCOUNT%>" />
<c:set var="WECHAT_ONLINE_GOODS" value="<%=CapitalFlowType.WECHAT_ONLINE_GOODS%>" />
<c:set var="WECHAT_LAPM_RENT" value="<%=CapitalFlowType.WECHAT_LAPM_RENT%>" />
<c:set var="RETURN" value="<%=CapitalFlowType.RETURN%>" />
<c:set var="REFUND" value="<%=CapitalFlowType.REFUND%>" />
<c:set var="SERVICE_FEE" value="<%=CapitalFlowType.SERVICE_FEE %>"/>
<c:set var="PENDING_SETTLE" value="<%=CapitalFlowStatus.PENDING_SETTLE%>" />
<c:set var="SETTLE_SUCCESS" value="<%=CapitalFlowStatus.SETTLE_SUCCESS%>" />
<c:set var="SETTLE_FAIL" value="<%=CapitalFlowStatus.SETTLE_FAIL%>" />
<c:set var="SALESMAN" value="<%=UserType.SALESMAN%>" />
<c:set var="CUSTOMER" value="<%=UserType.CUSTOMER%>" />
<c:set var="AGENCY" value="<%=UserType.AGENCY%>" />
<c:set var="FACILITATOR" value="<%=UserType.FACILITATOR%>" />
<div class="wallet">
     <div class="title">
     	<i class="iconfont back" onclick="window.location.href='<%=request.getContextPath()%>/factory/personCenter'">&#xe624;</i>
     	我的钱包
     	<i class="iconfont detail" onclick="window.location.href='<%=request.getContextPath()%>/factory/tradeList'">&#xe62d;</i>
     </div>
     <div class="money">
     	<div class="usable">
     		<i class="iconfont">&#xe60b;</i>
     		<span>可支配</span>
     		<h4>￥${user.flowMoney}</h4>
     	</div>
     	<div class="unusable">
     		<i class="iconfont">&#xe61c;</i>
     		<span>待结算</span>
     		<h4>￥${user.pendingMoney}</h4></div>
    	 </div>
     <button class="toWithdraw" onclick="window.location.href='<%=request.getContextPath()%>/factory/toWithdraw'">提　现</button>
</div>

<!--[[底部-->
<%--  <jsp:include page="/jsp/factory/footer.jsp"></jsp:include>  --%>
<!--底部]]-->
</body>
<script>
</script>
</html>