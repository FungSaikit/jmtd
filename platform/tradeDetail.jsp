<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>管理后台</title>
    <link rel="icon" type="image/x-icon" href="<%=request.getContextPath() %>/resources/backStage/image/favicon.ico" />

    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/common/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/backStage/css/index.css" />

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
	<c:set var="PENDING_SETTLE" value="<%=CapitalFlowStatus.PENDING_SETTLE%>" />
	<c:set var="SETTLE_SUCCESS" value="<%=CapitalFlowStatus.SETTLE_SUCCESS%>" />
	<c:set var="SETTLE_FAIL" value="<%=CapitalFlowStatus.SETTLE_FAIL%>" />
	<c:set var="SALESMAN" value="<%=UserType.SALESMAN%>" />
	<c:set var="CUSTOMER" value="<%=UserType.CUSTOMER%>" />
	<c:set var="AGENCY" value="<%=UserType.AGENCY%>" />
		<jsp:include page="/jsp/platform/header.jsp"></jsp:include>
		<jsp:include page="/jsp/platform/navigation.jsp"></jsp:include>
            <c:if test="${capitalFlow.capitalFlowType!=WITHDRAW_TO_ACCOUNT&&capitalFlow.capitalFlowType!=WITHDRAW_TO_WECHAT}">
            <!-- [[交易信息<button type="button" class="close tableClose"><span aria-hidden="true">&times;</span></button> -->
            <div class="table-responsive">
                <table class="table table-hover table-bordered table-striped">
                <caption>交易信息</caption>
                <thead>
                    <tr>
                        <th>交易单号</th>
                        <th>类型</th>
                        <th>状态</th>
                        <th>用户</th>
                        <th>交易金额（元）</th>
                        <th>创建时间</th>
                        <th>交易时间</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>${capitalFlow.capitalFlowId }</td>
                        <td>
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
	                    	</c:choose>
	                    </td>
                        <td>	
                        	<c:choose>
	                    		<c:when test="${capitalFlow.settlementStatus==PENDING_SETTLE}">待结算</c:when>
	                    		<c:when test="${capitalFlow.settlementStatus==SETTLE_SUCCESS}">结算成功</c:when>
	                    		<c:when test="${capitalFlow.settlementStatus==SETTLE_FAIL}">结算失败</c:when>
	                    	</c:choose>
	                    </td>
	                    <td>${user.userNickname }</td>
                        <td class="moneyText"> ${capitalFlow.money}</td>
                        <td><fmt:formatDate value="${capitalFlow.creatTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                        <td><fmt:formatDate value="${capitalFlow.settleTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                    </tr>
                </tbody>
            </table>
            </div>
            <!-- 交易信息<button type="button" class="close tableClose"><span aria-hidden="true">&times;</span></button>]] --> 
            </c:if>
			<c:if test="${capitalFlow.capitalFlowType==WITHDRAW_TO_ACCOUNT}">
            <!-- [[ 1.提现到支付宝-->
            <div class="table-responsive">
                <table class="table table-hover table-bordered table-striped">
                <caption>提现详情(银行提现)</caption>
                <thead>
                    <tr>
                        <th>提现编号</th>
                        <th>开户人</th>
                        <th>账号</th>
                        <th>开户银行</th>
                        <th>联系人</th>
                        <th>联系方式</th>
                        <th>用户提现金额</th>
                        <th>打到银行卡的钱</th>
                        <th>状态</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>${capitalFlow.capitalFlowId}</td>
                        <td>${withdraw.accountPerson}</td>
                        <td>${withdraw.account}</td>
                        <td>${withdraw.accountBank }${withdraw.accountBankSubName}</td>
                        <td>${withdraw.contactPerson}</td>
                        <td>${withdraw.contactWay}</td>
                        <td>${withdraw.withdrawMoney}</td>
                        <td>${capitalFlow.money}</td>
                        <td><c:choose>
                        		<c:when test="${capitalFlow.settlementStatus==PENDING_SETTLE}">待结算</c:when>
                        		<c:when test="${capitalFlow.settlementStatus==SETTLE_SUCCESS}">结算成功</c:when>
                        		<c:when test="${capitalFlow.settlementStatus==SETTLE_FAIL}">结算失败</c:when>
                        	</c:choose></td>
                    </tr>
                </tbody>
            </table>
            </div>
            <c:if test="${capitalFlow.settlementStatus==PENDING_SETTLE }">
            	<%-- <c:if test="${empty withdraw.toWechat}"><button onclick="window.location.href='<%=request.getContextPath()%>/platform/withdrawToPlatform?capitalFlowId=${capitalFlow.capitalFlowId}'">提现到管理员微信</button></c:if>
	             --%><button onclick="window.location.href='<%=request.getContextPath()%>/platform/passWithdrawToAccount?capitalFlowId=${capitalFlow.capitalFlowId}'">通过提现申请</button>
	            <button onclick="refuseWithdraw()">不通过提现申请</button>
            </c:if>
            </c:if>
			
			
            <!-- [[提现详情 -->
			<c:if test="${capitalFlow.capitalFlowType==WITHDRAW_TO_WECHAT}">
            <!-- [[ 2.提现到微信-->
            <div class="table-responsive">
                <table class="table table-hover table-bordered table-striped">
                <caption>提现详情(微信提现)</caption>
                <thead>
                    <tr>
                        <th>提现编号</th>
                        <th>微信昵称</th>
                        <th>提现金额</th>
                        <th>提现状态</th>
                    </tr>
                <thead>
                <tbody>
                    <tr>
                        <td>${capitalFlow.capitalFlowId }</td>
                        <td>${user.userNickname }</td>
                        <td>${capitalFlow.money }</td>
                        <td><c:choose>
                    		<c:when test="${capitalFlow.settlementStatus==PENDING_SETTLE}">待结算</c:when>
                    		<c:when test="${capitalFlow.settlementStatus==SETTLE_SUCCESS}">结算成功</c:when>
                    		<c:when test="${capitalFlow.settlementStatus==SETTLE_FAIL}">结算失败</c:when>
                    	</c:choose></td>
                    </tr>
                </tbody>
            </table>
            </div>
            <c:if test="${capitalFlow.settlementStatus==PENDING_SETTLE }">
            <button onclick="passWithdraw()">通过提现申请</button>
            <button onclick="refuseWithdraw()">不通过提现申请</button>
            </c:if>
            </c:if>
            <!-- 提现详情]] -->
            <script>
				function passWithdraw(){
					window.location.href="<%=request.getContextPath()%>/platform/passWithdrawWechat?capitalFlowId=${capitalFlow.capitalFlowId}";
				}
				
				function refuseWithdraw(){
					window.location.href="<%=request.getContextPath()%>/platform/refuseWithdrawWechat?capitalFlowId=${capitalFlow.capitalFlowId}";
				}
			</script>
        </div><!-- rightConten右边区域]] -->

    </div><!-- mainBody页面主体]] -->

    <footer>

    </footer>
</body>

</html>