<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
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
	<c:set var="SERVICE_FEE" value="<%=CapitalFlowType.SERVICE_FEE%>" />
	<c:set var="PENDING_SETTLE" value="<%=CapitalFlowStatus.PENDING_SETTLE%>" />
	<c:set var="SETTLE_SUCCESS" value="<%=CapitalFlowStatus.SETTLE_SUCCESS%>" />
	<c:set var="SETTLE_FAIL" value="<%=CapitalFlowStatus.SETTLE_FAIL%>" />
	<!-- [[头部 -->
    <jsp:include page="/jsp/platform/header.jsp"></jsp:include>
    <!-- [[页面主体 -->
	<jsp:include page="/jsp/platform/navigation.jsp"></jsp:include>
           <div class="area">
               <!-- [[筛选区 -->
               <form class="form-inline marginTB textL">
                   <div class="form-group">
                       <label for="code">用户</label>
                       <select name="userId" id="code" class="form-control bindSelect">
                           <option value="">全部</option>
                           <option value="1" <c:if test="${user.userId==1 }">selected</c:if>>平台</option>
                           <option value="inputCode" <c:if test="${user.userId!=1 }">selected</c:if>>输入编号</option>
                       </select>
                       <input type="text" value="${user.userId }" class="form-control beBind  <c:if test="${user.userId==1 || empty user.userId }">hide</c:if>"  placeholder="请输入用户编号"  id="codeInput" onkeyup="onlyNum(this)" onafterpaste="onlyNum(this)">
                   </div>
                   <div class="form-group">
                       <label for="type">交易类型</label>
                       <select name="" id="type" class="form-control" onchange="changeType(this.value)">
                            <option <c:if test="${capitalFlowType==-1} ">selected</c:if> value="-1">全部</option>
			                <option <c:if test="${capitalFlowType==WITHDRAW_TO_ACCOUNT}">selected</c:if> value="${WITHDRAW_TO_ACCOUNT }">提现到银行卡</option>
			                <option <c:if test="${capitalFlowType==WITHDRAW_TO_WECHAT}">selected</c:if> value="${WITHDRAW_TO_WECHAT }">提现到微信</option>
			                <option <c:if test="${capitalFlowType==REFUND}">selected</c:if> value="${REFUND }">退款</option>
			                <option <c:if test="${capitalFlowType==RETURN}">selected</c:if> value="${RETURN }">退货</option>
			                <option <c:if test="${capitalFlowType==COMMISION}">selected</c:if> value="${COMMISION }">佣金</option>
			                <option <c:if test="${capitalFlowType==GOODS_MONEY}">selected</c:if> value="${GOODS_MONEY }">货款</option>
			                <option <c:if test="${capitalFlowType==WECHAT_CONSUME_GOODS}">selected</c:if> value="${WECHAT_CONSUME_GOODS }">微信消费</option>
			                <option <c:if test="${capitalFlowType==WECHAT_ONLINE_GOODS}">selected</c:if> value="${WECHAT_ONLINE_GOODS }">微信上线产品</option>
			                <option <c:if test="${capitalFlowType==WECHAT_LAPM_RENT}">selected</c:if> value="${WECHAT_LAPM_RENT }">微信租赁灯位</option>
                       		<option <c:if test="${capitalFlowType==SERVICE_FEE }">selected</c:if> value="${SERVICE_FEE }">服务费</option>
                       </select>
                   </div>
                   <div class="form-group">
                       <label for="type">交易状态</label>
                       <select name="" id="status" class="form-control" onchange="changeStatus(this.value)">
                           <option <c:if test="${settlementStatus==-1}">selected</c:if> value="-1">全部</option>
                           <option <c:if test="${settlementStatus==PENDING_SETTLE}">selected</c:if> value="${PENDING_SETTLE }">待结算</option>
                           <option <c:if test="${settlementStatus==SETTLE_SUCCESS}">selected</c:if> value="${SETTLE_SUCCESS }">成功</option>
                           <option <c:if test="${settlementStatus==SETTLE_FAIL}">selected</c:if> value="${SETTLE_FAIL }">失败</option>
                       </select>
                   </div>
                   <button type="button" class="btn navActive" id="searchTypeBtn" onclick="submitForm()">确定</button>
               </form>
               <button onclick="generateWithdrawAccount()">生成提现excel</button>
               <!-- 筛选区]] -->

               <!--  [[没有找到相关交易提示
               <div class="alert alert-warning" role="alert">
                   <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                   <strong>Sorry！</strong>没有找到相关交易
               </div>没有找到相关交易提示]] -->

               <!-- [[交易信息 -->
               <div class="table-responsive">
                   <table class="table table-bordered table-striped">
                       <caption>交易信息</caption>
                       <thead>
                           <tr>
                               <th>交易单号</th>
                               <th>类型</th>
                               <th>状态</th>
                               <th class="textLeft">交易用户</th>
                               <th class="textRight">实交易金额（元）</th>
                               <th>创建时间</th>
                               <th>交易时间</th>
                               <th>操作</th>
                           </tr>
                       </thead>
                       <tbody>
                       <c:forEach items="${tradeList.list}" var="trade">
                       <tr>
                           <td>${trade.capitalFlow.capitalFlowId }</td>
                           <td>
	                           	<c:choose>
		                    		<c:when test="${trade.capitalFlow.capitalFlowType==WECHAT_CONSUME_GOODS}">微信购买商品</c:when>
		                    		<c:when test="${trade.capitalFlow.capitalFlowType==GOODS_MONEY}">货款</c:when>
		                    		<c:when test="${trade.capitalFlow.capitalFlowType==COMMISION}">佣金</c:when>
		                    		<c:when test="${trade.capitalFlow.capitalFlowType==WITHDRAW_TO_WECHAT}">提现到微信零钱</c:when>
		                    		<c:when test="${trade.capitalFlow.capitalFlowType==WITHDRAW_TO_ACCOUNT}">提现到银行卡</c:when>
		                    		<c:when test="${trade.capitalFlow.capitalFlowType==WECHAT_ONLINE_GOODS}">微信上线商品</c:when>
		                    		<c:when test="${trade.capitalFlow.capitalFlowType==WECHAT_LAPM_RENT}">微信租赁灯位</c:when>
		                    		<c:when test="${trade.capitalFlow.capitalFlowType==RETURN}">退货</c:when>
		                    		<c:when test="${trade.capitalFlow.capitalFlowType==REFUND}">退款</c:when>	
		                    	</c:choose>
                    		</td>
                           <td>
                           	<c:choose>
	                    		<c:when test="${trade.capitalFlow.settlementStatus==PENDING_SETTLE}">待结算</c:when>
	                    		<c:when test="${trade.capitalFlow.settlementStatus==SETTLE_SUCCESS}">结算成功</c:when>
	                    		<c:when test="${trade.capitalFlow.settlementStatus==SETTLE_FAIL}">结算失败</c:when>
	                    	</c:choose>
	                    	</td>
                           <td class="textLeft"><c:if test="${trade.capitalFlow.capitalFlowType==WITHDRAW_TO_ACCOUNT}">${trade.user.shortCompanyName}</c:if>
                           						<c:if test="${trade.capitalFlow.capitalFlowType!=WITHDRAW_TO_ACCOUNT}">${trade.user.userNickname }</c:if></td>
                           <td class="textRight moneyText">${trade.capitalFlow.money }</td>
                           <td>${trade.capitalFlow.creatTime }</td>
                           <td>${trade.capitalFlow.settleTime }</td>
                           <td><a href="<%=request.getContextPath()%>/platform/tradeDetail?capitalFlowId=${trade.capitalFlow.capitalFlowId}">查看详情</a></td>
                       </tr>
                       </c:forEach>
                       </tbody>
                   </table>
               </div>
               <!-- 交易信息]] -->

               <!-- [[分页-->
               <div class="paging">
                   <span class="prev btn btn-primary" onclick="window.location.href='<%=request.getContextPath()%>/platform/tradeManage?offset=${tradeList.before }&settlementStatus=${settlementStatus}&capitalFlowType=${capitalFlowType }&userId=${user.userId}'">上一页</span>
                   <span class="next btn btn-primary" onclick="window.location.href='<%=request.getContextPath()%>/platform/tradeManage?offset=${tradeList.after }&settlementStatus=${settlementStatus}&capitalFlowType=${capitalFlowType }&userId=${user.userId}'">下一页</span>
               </div>
               <!-- 分页]]-->
               
           </div>

       </div><!-- rightConten右边区域]] -->

   </div><!-- mainBody页面主体]] -->

   <footer>

   </footer>
	
	<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
</body>
<script>
	function changeType(type){
		window.location.href="<%=request.getContextPath()%>/platform/tradeManage?settlementStatus=${settlementStatus}&capitalFlowType="+type+"&userId=${user.userId}";
	}
	
	function changeStatus(status){
		window.location.href="<%=request.getContextPath()%>/platform/tradeManage?capitalFlowType=${capitalFlowType}&settlementStatus="+status+"&userId=${user.userId}";
	}
	
	function submitForm(){
		var userId;
		if($("#code").val()!="inputCode")
			userId=$("#code").val();
		else
			userId=$("#codeInput").val()
		window.location.href="<%=request.getContextPath()%>/platform/tradeManage?capitalFlowType="+
				$("#type").val()+"&settlementStatus="+$("#status").val()+"&userId="+userId;
	}
	
	function generateWithdrawAccount(){
		var url = "<%=request.getContextPath()%>/platform/generateWithdrawAccount";
		var param={};
		doAjax("GET",url,param,getSuccess,fail,true,false);
	}
	
	function getSuccess(data){
		window.location.href=data.data;
	}
	
	function fail(data){
		alert("fail");
	}
</script>
</html>