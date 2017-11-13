<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>佐为照明</title>
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1"/>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/customer/assets/css/capital.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/customer/assets/font/iconfont.css"/>
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
<c:set var="SERVICE_FEE" value="<%=CapitalFlowType.SERVICE_FEE%>" />
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
               		<c:when test="${capitalFlow.settlementStatus==PENDING_SETTLE}">待结算</c:when>
               		<c:when test="${capitalFlow.settlementStatus==SETTLE_SUCCESS}">结算成功</c:when>
               		<c:when test="${capitalFlow.settlementStatus==SETTLE_FAIL}">结算失败</c:when>
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
               		<c:when test="${capitalFlow.capitalFlowType==WECHAT_CONSUME_GOODS}">微信购买商品</c:when>
               		<c:when test="${capitalFlow.capitalFlowType==GOODS_MONEY}">货款</c:when>
               		<c:when test="${capitalFlow.capitalFlowType==COMMISION}">佣金</c:when>
               		<c:when test="${capitalFlow.capitalFlowType==WITHDRAW_TO_WECHAT}">提现到微信零钱</c:when>
               		<c:when test="${capitalFlow.capitalFlowType==WITHDRAW_TO_ACCOUNT}">提现到银行卡</c:when>
               		<c:when test="${capitalFlow.capitalFlowType==WECHAT_ONLINE_GOODS}">微信上线商品</c:when>
               		<c:when test="${capitalFlow.capitalFlowType==WECHAT_LAPM_RENT}">微信租赁灯位</c:when>
               		<c:when test="${capitalFlow.capitalFlowType==RETURN}">退货</c:when>
               		<c:when test="${capitalFlow.capitalFlowType==REFUND}">退款</c:when>
               		<c:when test="${capitalFlow.capitalFlowType==SERVICE_FEE}">服务费</c:when>
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

    
	<c:if test="${capitalFlow.capitalFlowType==WITHDRAW_TO_WECHAT}">
    <!-- [[提现到微信-->
    <div class="wechat">
        <div class="clearfix">
            <label class="widthPer-4 text-right">提现编号：</label>
            <span class="widthPer-8">${capitalFlow.capitalFlowId }</span>
        </div>
        <div class="clearfix">
            <label class="widthPer-4 text-right">微信昵称：</label>
            <span class="widthPer-8">${user.userNickname }</span>
        </div>
    </div>
    <!-- 提现到微信]]-->
    </c:if>
	
	<c:if test="${capitalFlow.capitalFlowType==REFUND}">
    <!-- [[退款-->
    <div class="withdraw">
        <div class="clearfix">
            <label class="widthPer-4 text-right">退款编号：</label>
            <span class="widthPer-8">${capitalFlow.capitalFlowId }</span>
        </div>
        <div class="clearfix">
            <label class="widthPer-4 text-right">订单编号：</label>
            <span class="widthPer-8">${orderItem.orderNumber }</span>
        </div>
    </div>
    <!-- 退款]]-->
    </c:if>

	<c:if test="${capitalFlow.capitalFlowType==RETURN}">
    <!-- [[退货-->
    <div class="withdraw">
        <div class="clearfix">
            <label class="widthPer-4 text-right">退货编号：</label>
            <span class="widthPer-8">${capitalFlow.capitalFlowId }</span>
        </div>
        <div class="clearfix">
            <label class="widthPer-4 text-right">订单编号：</label>
            <span class="widthPer-8">${orderItem.orderNumber }</span>
        </div>
    </div>
    <!-- 退货]]-->
    </c:if>
	
	<c:if test="${capitalFlow.capitalFlowType==RETURN}">
    <!-- [[佣金-->
    <div class="commiss">
        <div class="clearfix">
            <label class="widthPer-4 text-right">佣金编号：</label>
            <span class="widthPer-8">${capitalFlow.capitalFlowId }</span>
        </div>
        <div class="clearfix">
            <label class="widthPer-4 text-right">订单编号：</label>
            <span class="widthPer-8">${commision.orderNumber }</span>
        </div>
        <div class="clearfix">
            <label class="widthPer-4 text-right">消费用户：</label>
            <span class="widthPer-8">${user.userNickname }</span>
        </div>
        <div class="clearfix">
            <label class="widthPer-4 text-right">商品金额：</label>
            <span class="widthPer-8">￥${orderForm.orderMoney }</span>
        </div>
        <div class="clearfix">
            <label class="widthPer-4 text-right">安装费：</label>
            <span class="widthPer-8">￥${orderForm.orderInstallMoney }</span>
        </div>
        <div class="clearfix">
            <label class="widthPer-4 text-right">订单状态：</label>
            <span class="widthPer-8">
            	<c:choose>
					<c:when test="${ofm.orderForm.orderStatus==OBLIGATION }">待付款</c:when>
					<c:when test="${ofm.orderForm.orderStatus==TO_BE_SHIPPED }">待发货</c:when>
					<c:when test="${ofm.orderForm.orderStatus==TO_BE_SIGNED }">待签收</c:when>
					<c:when test="${ofm.orderForm.orderStatus==SIGNED }">已签收</c:when>
					<c:when test="${ofm.orderForm.orderStatus==FINISHED }">已完成</c:when>
					<c:when test="${ofm.orderForm.orderStatus==CLOSED }">已关闭</c:when>
				</c:choose>
			</span>
        </div>
    </div>
    <!-- 佣金]]-->
    </c:if>
	
	<c:if test="${capitalFlow.capitalFlowType==WECHAT_CONSUME_GOODS}">
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
        <div class="clearfix">
            <label class="widthPer-4 text-right">订单编号：</label>
            <span class="widthPer-8">${orderForm.orderNumber }</span>
        </div>
    </div>
    <!-- 微信消费]]-->
    </c:if>
</div>
<!--提现明细--会员]]-->

<!--[[通用尾部-->
<jsp:include page="/jsp/buyer/footer.jsp"></jsp:include>
<!--通用尾部]]-->
<!-- [[通用遮罩层-->
<div class="shadow" style="display: none"></div>

</body>
</html>