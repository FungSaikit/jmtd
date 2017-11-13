<%@ page language="java" import="java.util.*,com.alphaking.constant.*,com.alphaking.model.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>管理后台</title>
    <link rel="icon" type="image/x-icon" href="../image/favicon.ico" />

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
		<jsp:include page="/jsp/platform/header.jsp"></jsp:include>
		<jsp:include page="/jsp/platform/navigation.jsp"></jsp:include>
       <div class="area">
           已提现:${withdrawMoney }
           <br>
          可支配:${flowMoney }
      <br>
          待结算：${penddingMoney}
       </div><!-- area]] -->
       <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover">
                    <thead>
                    <tr>
                        <th>流水单号</th>
                        <th class="textLeft">类型</th>
                        <th>结算状态</th>
                        <th>金额</th>
                        <th>下单日期</th>
                        <th>结算日期</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${capitalFlowList}" var="cf" varStatus="i">
                    	<tr>
                        	<td><a href="<%=request.getContextPath()%>/platform/seeOrderDetail?capitalFlowId=${cf.capitalFlowId}">${cf.capitalFlowId }</a></td>
                        	<td>
                        		<c:choose>
		                    		<c:when test="${cf.capitalFlowType==WECHAT_CONSUME_GOODS}">微信购买商品</c:when>
		                    		<c:when test="${cf.capitalFlowType==GOODS_MONEY}">货款</c:when>
		                    		<c:when test="${cf.capitalFlowType==COMMISION}">佣金</c:when>
		                    		<c:when test="${cf.capitalFlowType==WITHDRAW_TO_WECHAT}">提现到微信零钱</c:when>
		                    		<c:when test="${cf.capitalFlowType==WITHDRAW_TO_ACCOUNT}">提现到银行卡</c:when>
		                    		<c:when test="${cf.capitalFlowType==WECHAT_ONLINE_GOODS}">微信上线商品</c:when>
		                    		<c:when test="${cf.capitalFlowType==WECHAT_LAPM_RENT}">微信租赁灯位</c:when>
		                    		<c:when test="${cf.capitalFlowType==RETURN}">退货</c:when>
		                    		<c:when test="${cf.capitalFlowType==REFUND}">退款</c:when>	
		                    	</c:choose>
                        	</td>
                        	<td>
	                           	<c:choose>
		                    		<c:when test="${cf.settlementStatus==PENDING_SETTLE}">待结算</c:when>
		                    		<c:when test="${cf.settlementStatus==SETTLE_SUCCESS}">结算成功</c:when>
		                    		<c:when test="${cf.settlementStatus==SETTLE_FAIL}">结算失败</c:when>
		                    	</c:choose>
	                    	</td>
                           <td class="textRight moneyText" <c:choose><c:when test="${cf.capitalFlowType==WITHDRAW_TO_WECHAT}">style="color:green"</c:when></c:choose>><c:choose>
		                    		<c:when test="${cf.capitalFlowType==REFUND||cf.capitalFlowType==REFUND||cf.capitalFlowType==COMMISION}">+</c:when>
		                    		<c:when test="${cf.capitalFlowType==WITHDRAW_TO_WECHAT}">-</c:when>
		                    	</c:choose>${cf.money }</td>
                           <td>${cf.creatTime }</td>
                           <td>${cf.settleTime }</td>
	                   	</tr> 
                    </c:forEach> 
                    </tbody>
                </table>
            </div><!-- 商品列表]] -->

    </div><!-- 页面主体的右边]] -->

    </div><!-- 页面主体]] -->

    <footer>

    </footer>
</body>

<script>
	function submitForm(){
		if($("#salesmanId").val()!=undefined){
			if($("#salesmanId").val()==0)
				alert("请选择对应厂家业务员");
			else
				window.location.href='<%=request.getContextPath()%>/platform/passApplication?applyId=${application.applyId }&salesmanId='+$("#salesmanId").val();
		}else{
			window.location.href='<%=request.getContextPath()%>/platform/passApplication?applyId=${application.applyId }';
		}
	}
</script>
</html>
