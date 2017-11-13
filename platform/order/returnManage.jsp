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
    <link rel="icon" type="image/x-icon" href="../image/favicon.ico" />

    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/common/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/backStage/css/index.css" />
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/backStage/css/order.css" />
    
</head>
<body>
	<c:set var="OBLIGATION" value="<%=OrderStatus.OBLIGATION%>" />
	<c:set var="TO_BE_SHIPPED" value="<%=OrderStatus.TO_BE_SHIPPED%>" />
	<c:set var="TO_BE_SIGNED" value="<%=OrderStatus.TO_BE_SIGNED%>" />
	<c:set var="SIGNED" value="<%=OrderStatus.SIGNED%>" />
	<c:set var="FINISHED" value="<%=OrderStatus.FINISHED%>" />
	<c:set var="CLOSED" value="<%=OrderStatus.CLOSED%>" />
	<c:set var="NONE_REFUND" value="<%=RefundStatus.NONE_REFUND%>" />
	<c:set var="REFUND_APPLYING" value="<%=RefundStatus.REFUND_APPLYING%>" />
	<c:set var="REFUND_FAILURE" value="<%=RefundStatus.REFUND_FAILURE%>" />
	<c:set var="REFUND_SUCCESS" value="<%=RefundStatus.REFUND_SUCCESS%>" />
	<c:set var="NONE_RETURN" value="<%=ReturnStatus.NONE_RETURN%>" />
	<c:set var="RETURN_APPLYING" value="<%=ReturnStatus.RETURN_APPLYING%>" />
	<c:set var="RETURN_FAILURE" value="<%=ReturnStatus.RETURN_FAILURE%>" />
	<c:set var="RETURN_AGREE" value="<%=ReturnStatus.RETURN_AGREE%>" />
	<c:set var="WAITTING_SELLER_SIGNED" value="<%=ReturnStatus.WAITTING_SELLER_SIGNED%>" />
	<c:set var="RETURN_SUCCESS" value="<%=ReturnStatus.RETURN_SUCCESS%>" />
    <jsp:include page="/jsp/platform/header.jsp"></jsp:include>
	<jsp:include page="/jsp/platform/navigation.jsp"></jsp:include>
	<form action="<%=request.getContextPath()%>/platform/orderList">
    	<input type="hidden" name="orderStatus" value="${orderStatus}">
    	<input type="hidden" name="offset" value="0">
    </form>
    <!-- [[选项卡-->
    <div class="nav-tabs">
        <button class="btn " onclick="toStatus(${TO_BE_SHIPPED})">订单</button>
        <button class="btn " onclick="toStatus(${STOCKED})">待发货</button>
        <button class="btn " onclick="toStatus(${PREPARE_SEND})">今日待发</button>
   		<button class="btn " onclick="toStatus(${TO_BE_SIGNED})">待收货</button>
        <button class="btn " onclick="toStatus(${SIGNED})">已签收</button>
        <button class="btn " onclick="toStatus(${FINISHED})">已完成</button>
        <button class="btn " onclick="toStatus(${CLOSED})">已关闭</button>
        <button class="btn navActive" onclick="window.location.href='<%=request.getContextPath()%>/platform/returnOrderManage'">退款/退货</button>
   		<button class="btn" onclick="window.location.href='<%=request.getContextPath()%>/platform/serviceOrderList'">待服务订单</button>
   		<button class="btn <c:if test='${orderStatus==OBLIGATION }'>navActive</c:if>" onclick="toStatus(${OBLIGATION})">待付款</button>
    </div><!-- 选项卡]] -->
	
	
	 <div class="table-responsive">
    <table class="table table-bordered table-striped table-hover">
        <thead>
        <tr>
            <th>订单号</th>
            <th>退款号</th>
            <th>卖家</th>
            <th>买家</th>
            <th>退款金额</th>
            <th>商品图片</th>
            <th>产品型号</th>
            <th>产品价格</th>   
            <th>数量</th>           
            <th>状态</th>  
            <th>退款时间</th> 
            <th>操作</th>
        </tr>
        </thead>
    	<c:forEach items="${returnPager.list}" var="rol">
    	<tr>
    		<td>${rol.orderNumber}</td>
    		<td>${rol.returnRecord.buyerCapitalFlowId}</td>
    		<td>${rol.seller.shortCompanyName }</td>
    		<td>${rol.buyer.userNickname }</td>
    		<td>${rol.returnRecord.returnInfoMoney}</td>
    		<td><img src="${rol.orderItemModel.product.cover1 }" alt="" style="width:80px;height:80px"/></td>
    		<td>${rol.orderItemModel.product.productCode }</td>
    		<td>${rol.orderItemModel.orderItem.orderItemPrice }</td>
    		<td>${rol.orderItemModel.orderItem.orderItemNumber }</td>
    		<td><c:choose>
						<c:when test="${empty rol.orderItemModel.orderItem.returnId && rol.orderItemModel.orderItem.refundStatus==REFUND_APPLYING}">退款申请中</c:when>
		            	<c:when test="${empty rol.orderItemModel.orderItem.returnId && rol.orderItemModel.orderItem.refundStatus==REFUND_FAILURE}">退款失败</c:when>
		            	<c:when test="${rol.orderItemModel.orderItem.refundStatus==REFUND_SUCCESS}">退款成功</c:when>
		            	<c:when test="${rol.orderItemModel.orderItem.returnStatus==RETURN_APPLYING}">退货申请中</c:when>
		            	<c:when test="${rol.orderItemModel.orderItem.returnStatus==RETURN_FAILURE}">退货失败</c:when>
		            	<c:when test="${rol.orderItemModel.orderItem.returnStatus==RETURN_AGREE}">买家待发货</c:when>
		            	<c:when test="${rol.orderItemModel.orderItem.returnStatus==WAITTING_SELLER_SIGNED}">卖家待收货</c:when>
		            	<c:when test="${rol.orderItemModel.orderItem.returnStatus==RETURN_SUCCESS}">退货成功</c:when>
					</c:choose></td>
			<td>${rol.returnRecord.refundTime }</td>
    		<td><c:if test="${rol.returnRecord.payMoneyStatus==0&&(rol.orderItemModel.orderItem.refundStatus==REFUND_SUCCESS||rol.orderItemModel.orderItem.returnStatus==RETURN_SUCCESS)}">
    		<button onclick="payReturnMoney(${rol.returnRecord.returnInfoId})">打款</button></c:if>
    		<c:if test="${rol.orderItemModel.orderItem.refundStatus==REFUND_APPLYING||rol.orderItemModel.orderItem.returnStatus==RETURN_APPLYING
    		||rol.orderItemModel.orderItem.returnStatus==RETURN_AGREE||rol.orderItemModel.orderItem.returnStatus==WAITTING_SELLER_SIGNED}">
    		<button onclick="<c:if test="${empty rol.orderItemModel.orderItem.returnId}">passRefund(${rol.returnRecord.returnInfoId})</c:if>
    		<c:if test="${!empty rol.orderItemModel.orderItem.returnId}">passReturn(${rol.returnRecord.returnInfoId})</c:if>">退款</button></c:if></td>
    	</tr>
    	</c:forEach>
    </table>
    <!-- 订单列表]] -->
    

    <!-- [[分页-->
    <div class="paging">
        <span class="prev btn btn-primary" onclick="window.location.href='<%=request.getContextPath()%>/platform/returnOrderManage?offset=${returnPager.before}&orderStatus=${orderStatus}'">上一页</span>
        <span>当前第页<fmt:formatNumber value="${((returnPager.after==returnPager.count&&returnPager.after%10!=0)?1:0)+((returnPager.after-returnPager.after%10))/10 }" pattern="#0"/>/共<fmt:formatNumber value="${((returnPager.count-1-(returnPager.count-1)%10))/10+1}" pattern="#0" />页</span>
        <span class="next btn btn-primary" onclick="window.location.href='<%=request.getContextPath()%>/platform/returnOrderManage?offset=${returnPager.after}&orderStatus=${orderStatus}'">下一页</span>
    </div>
    <!-- 分页]]-->

    </div><!-- rightConten右边区域]] -->

    </div><!-- mainBody页面主体]] -->

    <footer>

    </footer>

</body>
<script>
	$(function(){
		calculate();
	})
	
	function calculate(){
		$(".order").each(function(){
			var numbers=0;
			var moneys=0;
			$(this).find(".product").each(function(){
				numbers = numbers+parseInt($(this).find(".number").html().match(/\d+(\.\d+)?/g));
			});
			$(this).find(".product-total").html($(this).find(".product-total").html().replace("number",numbers));
		});
	}

	function payReturnMoney(returnInfoId){
		var url="<%=request.getContextPath()%>/platform/payReturnMoney";
		var params={"returnInfoId":returnInfoId};
		doAjax("GET",url,params,paySuccess,fail,true,false);
	}
	
	function passRefund(returnInfoId){
		var url="<%=request.getContextPath()%>/platform/passRefund";
		var params={returnInfoId:returnInfoId};
		doAjax("GET",url,params,passRefundSuccess,fail,true,false);
	}
	
	function passRefundSuccess(data){
		location.reload();
	}
	
	function passReturn(returnInfoId){
		var url="<%=request.getContextPath()%>/platform/passReturn";
		var params={returnInfoId:returnInfoId};
		doAjax("GET",url,params,passReturnSuccess,fail,true,false);
	}
	
	function passReturnSuccess(data){
		location.reload();
	}
	
	function paySuccess(data){
		location.reload();
	}
	
	function fail(data){
		alert("fail");
	}
	
	function toStatus(s){
		$("input[name='orderStatus']").val(s);
		$("input[name='offset']").val(0);
		$("form").submit();
	}
</script>
</html>