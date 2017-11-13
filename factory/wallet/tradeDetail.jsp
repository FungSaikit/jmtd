<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>佐为照明</title>
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1"/>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/factory/assets/css/capital.css"/>
    <link href="<%=request.getContextPath() %>/resources/common/bootstrap.min.css" rel="stylesheet">
</head>
<c:set var="WECHAT_CONSUME_GOODS" value="<%=CapitalFlowType.WECHAT_CONSUME_GOODS%>" />
<c:set var="GOODS_MONEY" value="<%=CapitalFlowType.GOODS_MONEY%>" />
<c:set var="COMMISION" value="<%=CapitalFlowType.COMMISION%>" />
<c:set var="WITHDRAW_TO_WECHAT" value="<%=CapitalFlowType.WITHDRAW_TO_WECHAT%>" />
<c:set var="WITHDRAW_TO_ACCOUNT" value="<%=CapitalFlowType.WITHDRAW_TO_ACCOUNT%>" />
<c:set var="WECHAT_ONLINE_GOODS" value="<%=CapitalFlowType.WECHAT_ONLINE_GOODS%>" />
<c:set var="WECHAT_LAPM_RENT" value="<%=CapitalFlowType.WECHAT_LAPM_RENT%>" />
<c:set var="RETURN" value="<%=CapitalFlowType.RETURN%>" />
<c:set var="REFUND" value="<%=CapitalFlowType.REFUND%>" />
<c:set var="PENDING_SETTLE" value="<%=CapitalFlowStatus.PENDING_SETTLE%>" />
<c:set var="SETTLE_SUCCESS" value="<%=CapitalFlowStatus.SETTLE_SUCCESS%>" />
<c:set var="SETTLE_FAIL" value="<%=CapitalFlowStatus.SETTLE_FAIL%>" />
<c:set var="OBLIGATION" value="<%=OrderStatus.OBLIGATION%>" />
<c:set var="TO_BE_SHIPPED" value="<%=OrderStatus.TO_BE_SHIPPED%>" />
<c:set var="TO_BE_SIGNED" value="<%=OrderStatus.TO_BE_SIGNED%>" />
<c:set var="SIGNED" value="<%=OrderStatus.SIGNED%>" />
<c:set var="FINISHED" value="<%=OrderStatus.FINISHED%>" />
<c:set var="CLOSED" value="<%=OrderStatus.CLOSED%>" />
<body class="trade">
<div class="title">交易详情</div>
<!--[[提现明细--会员-->
<div class="trade">
    <div class="trace-msg">
        <div class="clearfix">
            <label class="widthPer-4 text-right">交易单号：</label>
            <span class="widthPer-8">${capitalFlow.capitalFlowId }</span>
        </div>
        <div class="clearfix">
            <label class="widthPer-4 text-right">状态：</label>
            <span class="widthPer-8">
				<c:choose>
               		<c:when test="${capitalFlow.capitalFlowType==GOODS_MONEY}">货款</c:when>
               		<c:when test="${capitalFlow.capitalFlowType==WITHDRAW_TO_ACCOUNT}">提现到银行卡</c:when>
               		<c:when test="${capitalFlow.capitalFlowType==WECHAT_ONLINE_GOODS}">微信上线商品</c:when>
               		<c:when test="${capitalFlow.capitalFlowType==WECHAT_LAPM_RENT}">微信租赁灯位</c:when>
               		<c:when test="${capitalFlow.capitalFlowType==RETURN}">退货</c:when>
               		<c:when test="${capitalFlow.capitalFlowType==REFUND}">退款</c:when>
               	</c:choose>
			</span>
        </div>
        <div class="clearfix">
            <label class="widthPer-4 text-right">交易金额：</label>
            <span class="widthPer-8">￥${capitalFlow.money}</span>
        </div>
        <div class="clearfix">
            <label class="widthPer-4 text-right">创建时间：</label>
            <span class="widthPer-8"><fmt:formatDate value="${capitalFlow.creatTime}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
        </div>
        <c:if test="${!empty capitalFlow.settleTime }">
        <div class="clearfix">
            <label class="widthPer-4 text-right">结算时间：</label>
            <span class="widthPer-8"><fmt:formatDate value="${capitalFlow.settleTime}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
        </div>
        </c:if>
        <div class="clearfix">
            <label class="widthPer-4 text-right">类型：</label>
            <span class="widthPer-8">
            	<c:choose>
               		<c:when test="${capitalFlow.settlementStatus==PENDING_SETTLE}">待结算</c:when>
               		<c:when test="${capitalFlow.settlementStatus==SETTLE_SUCCESS}">结算成功</c:when>
               		<c:when test="${capitalFlow.settlementStatus==SETTLE_FAIL}">结算失败</c:when>
               	</c:choose>
            </span>
        </div>
    </div>

   <!--  <div class="clearfix text-center operation">
        <button class="btn btn-primary">提现到银行卡</button>
        <button class="btn btn-primary" style="display: none">提现到微信</button>
        <button class="btn btn-primary" style="display: none">退款</button>
        <button class="btn btn-primary" style="display: none">退货</button>
        <button class="btn btn-primary" style="display: none">佣金</button>
        <button class="btn btn-primary" style="display: none">商品贷款</button>
        <button class="btn btn-primary" style="display: none">微信消费</button>
    </div> -->
	
	
	<c:if test="${capitalFlow.capitalFlowType==WITHDRAW_TO_ACCOUNT}">
	<!-- [[提现到银行卡-->
    <div class="bankCard">
        <div class="clearfix">
            <label class="widthPer-4 text-right">提现编号：</label>
            <span class="widthPer-8">${capitalFlow.capitalFlowId }</span>
        </div>
        <div class="clearfix">
            <label class="widthPer-4 text-right">开户账号：</label>
            <span class="widthPer-8">${withdrawToCreditCard.account }</span>
        </div>
        <div class="clearfix">
            <label class="widthPer-4 text-right">开户人：</label>
            <span class="widthPer-8">${withdrawToCreditCard.accountPerson }</span>
        </div>
        <div class="clearfix">
            <label class="widthPer-4 text-right">开户银行：</label>
            <span class="widthPer-8">${withdrawToCreditCard.accountBank}</span>
        </div>
        <!-- <div class="clearfix">
            <label class="widthPer-4 text-right">所属支行：</label>
            <span class="widthPer-8">广东省广州市天河区华南农业大学支</span>
        </div> -->
        <div class="clearfix">
            <label class="widthPer-4 text-right">联系人：</label>
            <span class="widthPer-8">${withdrawToCreditCard.contactPerson }</span>
        </div>
        <div class="clearfix">
            <label class="widthPer-4 text-right">联系方式：</label>
            <span class="widthPer-8">${withdrawToCreditCard.contactWay }</span>
        </div>
    </div>
    <!-- 提现到银行卡]]-->
    </c:if>
	
	<c:if test="${capitalFlow.capitalFlowType==GOODS_MONEY}">
	<!-- [[商品贷款-->
    <div class="product">
        <div class="clearfix">
            <label class="widthPer-4 text-right">商品贷款编号：</label>
            <span class="widthPer-8">${capitalFlow.capitalFlowId }</span>
        </div>
        <div class="clearfix">
            <label class="widthPer-4 text-right">订单编号：</label>
            <span class="widthPer-8">${orderForm.orderNumber }</span>
        </div>
        <div class="clearfix">
            <label class="widthPer-4 text-right">消费用户：</label>
            <span class="widthPer-8">${user.userNickname }</span>
        </div>
        <div class="clearfix">
            <label class="widthPer-4 text-right">商品金额：</label>
            <span class="widthPer-8">￥${orderForm.orderMoney }</span>
        </div>
    </div>
    <!-- 商品贷款]]-->
    </c:if>
    
    <c:if test="${capitalFlow.capitalFlowType==WECHAT_ONLINE_GOODS}">
     <!-- [[微信消费-->
    <div class="wechatCost clearfix">
        <div class="clearfix">
            <label class="widthPer-4 text-right">消费编号：</label>
            <span class="widthPer-8">${capitalFlow.capitalFlowId }</span>
        </div>
        <div class="clearfix">
            <label class="widthPer-4 text-right">消费用户：</label>
            <span class="widthPer-8">${user.userNickname }</span>
        </div>
       
    </div>
    <!-- 微信消费]]-->
    </c:if>
    
     <c:if test="${capitalFlow.capitalFlowType==WECHAT_LAPM_RENT}">
     <!-- [[微信消费-->
    <div class="wechatCost clearfix">
        <div class="clearfix">
            <label class="widthPer-4 text-right">消费编号：</label>
            <span class="widthPer-8">${capitalFlow.capitalFlowId }</span>
        </div>
        <div class="clearfix">
            <label class="widthPer-4 text-right">消费用户：</label>
            <span class="widthPer-8">呵呵哒</span>
        </div>
    </div>
    <!-- 微信消费]]-->
    </c:if>
</div>
<!--提现明细--会员]]-->

<!--[[通用尾部-->
<jsp:include page="/jsp/factory/footer.jsp"></jsp:include>
<!--通用尾部]]-->
<!-- [[通用遮罩层-->
<div class="shadow" style="display: none"></div>

</body>
</html>