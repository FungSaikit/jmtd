<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>佐为照明</title>
    <link href="<%=request.getContextPath() %>/resources/common/swiper.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/factory/assets/css/order.css" rel="stylesheet">
</head>
<body>
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
<c:set var="PENDING_ORDER" value="<%=OrderServiceStatus.PENDING_ORDER%>" />
 
<div class="orderDetail">
    <div class="title"><i class="iconfont prevPage" >&#xe624;</i>订单详情</div>
    <div class="tableInfo contactInfo">
    	<div class="grayTitle">收货信息</div>
		<table>
    		<tr>
    			<td>联系人</td>
    			<td>${orderForm.receivePerson }</td>
    		</tr>
    		<tr>
    			<td>联系电话</td>
    			<td>${orderForm.receivePhone }</td>
    		</tr>
    		<tr>
    			<td>联系地址</td>
    			<td>${orderForm.receiveProvince}${orderForm.receiveCity}${orderForm.receiveArea}${orderForm.receiveAddress}</td>
    		</tr>
    	</table>
    </div>
    <div class="goodsInfo">
    	<div class="grayTitle">商品信息</div>
    	<div class="shopOrder">
	   		<div class="shopName">
	    		<a><span><i class="iconfont">&#xe600;</i>${buyer.userNickname}</span></a>
	    		<c:if test="${!empty buyer.phoneNumber }"><a href="tel:${buyer.phoneNumber }"><i class="iconfont contactI phoneI">&#xe609;</i></a></c:if>
	    		<c:if test="${!empty buyer.qqNumber }"><a href="http://wpa.qq.com/msgrd?v=3&uin=${buyer.qqNumber }&site=qq&menu=yes" target="_blank"><i class="iconfont contactI qqI">&#xe607;</i></a></c:if>
	    	</div>
	    	<c:forEach items="${orderItemList }" var="orderItem">
	   		<div class="commodity">
	   			<c:if test="${(empty orderItem.orderItem.returnId && orderItem.orderItem.refundStatus==REFUND_FAILURE)||
	   						(empty orderItem.orderItem.returnId &&  orderItem.orderItem.refundStatus==REFUND_SUCCESS) ||
	   						orderItem.orderItem.returnStatus==RETURN_FAILURE||orderItem.orderItem.returnStatus==RETURN_SUCCESS}">
	   			<div class="tipInfo"> 
					<c:choose>
		            	<c:when test="${empty orderItem.orderItem.returnId && orderItem.orderItem.refundStatus==REFUND_FAILURE}">退款失败</c:when>
		            	<c:when test="${empty orderItem.orderItem.returnId &&  orderItem.orderItem.refundStatus==REFUND_SUCCESS}">退款成功</c:when>
		            	<c:when test="${orderItem.orderItem.returnStatus==RETURN_FAILURE}">退货失败</c:when>
			            <c:when test="${orderItem.orderItem.returnStatus==RETURN_SUCCESS}">退货成功</c:when>
            		</c:choose>
            	</div>
            	</c:if>
	   			<img src="${orderItem.product.cover1}"/>
	   			<div class="commDiv">
	   				<p <c:if test="${(!empty isBuyer&&((orderForm.orderStatus==TO_BE_SHIPPED
	   						&&orderItem.orderItem.refundStatus==NONE_REFUND)||
	   						(orderItem.orderItem.refundStatus!=REFUND_SUCCESS&&
	   						orderForm.orderStatus==SIGNED&&orderItem.orderItem.returnStatus==
	   						NONE_REFUND)))||!empty orderItem.orderItem.returnId||!empty orderItem.orderItem.refundId}">class="refundP"</c:if>>
	   					<a href="#">${orderItem.product.productName }</a>
	   					<c:choose>
			            	<c:when test="${empty orderItem.orderItem.returnId && orderItem.orderItem.refundStatus==REFUND_APPLYING}"><button class="rdBtn" data-id="${orderItem.orderItem.refundId}">退款申请中</button></c:when>
			            	<c:when test="${orderItem.orderItem.returnStatus==RETURN_APPLYING}"><button class="rdBtn" data-id="${orderItem.orderItem.returnId}">退货申请中</button></c:when>
			            	<c:when test="${orderItem.orderItem.returnStatus==RETURN_AGREE}"><button class="rdBtn" data-id="${orderItem.orderItem.returnId}">买家待发货</button></c:when>
			            	<c:when test="${orderItem.orderItem.returnStatus==WAITTING_SELLER_SIGNED}"><button class="rdBtn" data-id="${orderItem.orderItem.returnId}">卖家待收货</button></c:when>
			            </c:choose>
	   				</p>
	    			<div class="moneyNum">
	    				<h4>￥<fmt:formatNumber value="${orderItem.orderItem.orderItemPrice+orderItem.orderItem.orderItemFreight+orderItem.orderItem.orderItemCommision+orderItem.orderItem.orderItemServiceFee }" pattern="#0.00"/></h4>
	    				<span><font>X</font>${orderItem.orderItem.orderItemNumber}</span>
	    			</div>
	   			</div>
	   		</div>
	   		</c:forEach>
   		</div>
   		<p class="allP">共<span></span>件商品，合计<span>￥${orderForm.orderMoney+orderForm.orderInstallMoney}</span>，安装费合计：<span>￥${orderForm.orderServiceMoney}</span></p>
    </div>
    <c:if test="${!empty installer }">
    <div class="tableInfo servicePerson">
    	<div class="grayTitle">售后服务</div>
    	<table>
    		<tr>
    			<td>联系人</td>
    			<td>${installer.legalPersonName}</td>
    		</tr>
    		<tr>
    			<td>联系电话</td>
    			<td>${installer.phoneNumber }</td>
    		</tr>
    	</table>
    </div>
    </c:if>
    <c:if test="${orderForm.transportType!=1&&!empty orderForm.logisticsCompanyCode }">
    <div class="tableInfo logisticsInfo">
    	<div class="grayTitle">物流信息</div>
    	<table>
    		<tr>
    			<td>物流公司</td>
    			<td>${logisticsCompany.logisticsCompanyName}</td>
    		</tr>
    		<tr>
    			<td>物流编号</td>
    			<td>${logisticsCompany.logisticsCompanyCode }</td>
    		</tr>
    		<tr>
    			<td>电话</td>
    			<td>${orderForm.transportPhoneNumber }</td>
    		</tr>
    	</table>
    </div>
    </c:if>
    <div class="orderInfo tableInfo">
    	<div class="grayTitle">订单信息</div>
    	<table>
    		<tr>
    			<td>订单号</td>
    			<td>${orderForm.orderNumber}</td>
    		</tr>
    		<tr>
    			<td>订单状态</td>
    			<td>
    				<c:choose>
						<c:when test="${orderForm.orderStatus==OBLIGATION }">待付款</c:when>
						<c:when test="${orderForm.orderStatus==TO_BE_SHIPPED }">待发货</c:when>
						<c:when test="${orderForm.orderStatus==TO_BE_SIGNED }">待签收</c:when>
						<c:when test="${orderForm.orderStatus==SIGNED }">已签收</c:when>
						<c:when test="${orderForm.orderStatus==FINISHED }">已完成</c:when>
						<c:when test="${orderForm.orderStatus==CLOSED }">已关闭</c:when>
					</c:choose>
				</td>
    		</tr>
    		<tr>
    			<td>下单时间</td>
    			<td><fmt:formatDate value="${orderForm.orderTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
    		</tr>
    		<tr>
    			<td>付款时间</td>
    			<td>
    				<c:if test="${!empty orderForm.payTime }"><fmt:formatDate value="${orderForm.payTime}" pattern="yyyy-MM-dd HH:mm:ss" /></c:if>
        			<c:if test="${empty orderForm.payTime }">暂未付款</c:if>
        		</td>
    		</tr>
    		<tr>
    			<td>发货时间</td>
    			<td>
    				<c:if test="${!empty orderForm.sendTime }"><fmt:formatDate value="${orderForm.sendTime}" pattern="yyyy-MM-dd HH:mm:ss" /></c:if>
        			<c:if test="${empty orderForm.sendTime }">暂未发货</c:if>
				</td>
    		</tr>
    		<tr>
    			<td>收货时间</td>
    			<td>
    				<c:if test="${!empty orderForm.receiveTime }"><fmt:formatDate value="${orderForm.receiveTime}" pattern="yyyy-MM-dd HH:mm:ss" /></c:if>
        			<c:if test="${empty orderForm.receiveTime }">暂未收货</c:if>
				</td>
    		</tr>
    	</table>
    </div>
    <div class="handle">
    	<div class="btnGroup">
    	<c:if test="${orderForm.orderServiceStatus==PENDING_ORDER}"> 
    		<button class="bgcolorBtn serviceBtn" onclick="takeServiceOrder()">接单</button> 
        </c:if> 
    </div>
    
</div>

<!--[[底部-->
<%-- <jsp:include page="/jsp/buyer/footer.jsp"></jsp:include> --%>
<!--底部]]-->
<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
<script>
	$(".serviceBtn").tap(function(){
		var url="<%=request.getContextPath()%>/buyer/takeServiceOrder";
		var params={serviceOrderId:${serviceOrder.serviceOrderId}};
		doAjax("GET",url,params,success,fail,true,false);
	});
	
	function success(data){
		location.reload();
	}
	
	function fail(data){
		alert("fail");
	}
	
	//查询物流
	$(".logisticsBtn").tap(function(){
		window.location.href="<%=request.getContextPath()%>/user/consultLogistics?logisticsCompanyCode=${orderForm.logisticsCompanyCode}"+
				"&logisticsCode=${orderForm.transportNumber}&transportPhoneNumber=${orderForm.transportPhoneNumber}";
	});
	
	function fail(data){
		alert("fail");
	} 
	
	$(function(){
		calculate();
	})
	
	function calculate(){
		var numbers=0;
		$(".commodity").each(function(){
			numbers = numbers+parseInt($(this).find(".moneyNum span").html().match(/\d+(\.\d+)?/g));
		});
		$(".allP span").eq(0).html(numbers);
	}
	
	$(".prevPage").tap(function(){
		history.go(-1);
	});
</script>
</body>
</html>