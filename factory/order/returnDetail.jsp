<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>金明同达灯饰</title>
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/customer/assets/css/orderCart.css" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
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
 
<div class="orderDetail">
    <div class="title"><i class="iconfont prevPage" >&#xe624;</i>退款详情</div>
    <c:if test="${!empty returnRecord.receivePerson }">
    <div class="tableInfo contactInfo">
    	<div class="grayTitle">卖家收货信息</div>
		<table>
    		<tr>
    			<td>联系人</td>
    			<td>${returnRecord.receivePerson }</td>
    		</tr>
    		<tr>
    			<td>联系电话</td>
    			<td>${returnRecord.receivePhone }</td>
    		</tr>
    		<tr>
    			<td>联系地址</td>
    			<td>${returnRecord.receiveProvince}${returnRecord.receiveCity}${returnRecord.receiveArea}${returnRecord.receiveAddress}</td>
    		</tr>
    	</table>
    </div>
    </c:if>
    <div class="goodsInfo">
    	<div class="grayTitle">商品信息</div>
    	<div class="shopOrder">
	   		<div class="shopName">
	    		<a href="<%=request.getContextPath()%>/product/shopProductList?shopId=${seller.userId}"><span><i class="iconfont">&#xe600;</i>${buyer.userNickname }</span></a>
	    		<c:if test="${!empty buyer.phoneNumber }"><a href="tel:${buyer.phoneNumber }"><i class="iconfont contactI phoneI">&#xe609;</i></a></c:if>
	    		<c:if test="${!empty buyer.qqNumber }"><a href="http://wpa.qq.com/msgrd?v=3&uin=${buyer.qqNumber }&site=qq&menu=yes" target="_blank"><i class="iconfont contactI qqI">&#xe607;</i></a></c:if>
	    	</div>
	    	
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
	   			<a href="<%=request.getContextPath()%>/product/productDetail?productId=${orderItem.product.productId}"><img src="${orderItem.product.cover1}"/></a>
	   			<div class="commDiv">
	   				<p <%-- <c:if test="${(!empty isBuyer&&((orderForm.orderStatus==TO_BE_SHIPPED
	   						&&orderItem.orderItem.refundStatus==NONE_REFUND)||
	   						(orderItem.orderItem.refundStatus!=REFUND_SUCCESS&&
	   						orderForm.orderStatus==SIGNED&&orderItem.orderItem.returnStatus==
	   						NONE_REFUND)))||!empty orderItem.orderItem.returnId||!empty orderItem.orderItem.refundId}">class="refundP"</c:if> --%>>
	   					<a href="<%=request.getContextPath()%>/product/productDetail?productId=${orderItem.product.productId}">${orderItem.product.productName }</a>
	   					<%-- <c:choose>
			            	<c:when test="${empty orderItem.orderItem.returnId && orderItem.orderItem.refundStatus==REFUND_APPLYING}"><button>退款申请中</button></c:when>
			            	<c:when test="${orderItem.orderItem.returnStatus==RETURN_APPLYING}"><button>退货申请中</button></c:when>
			            	<c:when test="${orderItem.orderItem.returnStatus==RETURN_AGREE}"><button>买家待发货</button></c:when>
			            	<c:when test="${orderItem.orderItem.returnStatus==WAITTING_SELLER_SIGNED}"><button>卖家待收货</button></c:when>
			            </c:choose> --%>
	   				</p>
	    			<div class="moneyNum">
	    				<h4>￥<fmt:formatNumber value="${orderItem.orderItem.orderItemPrice+orderItem.orderItem.orderItemFreight+orderItem.orderItem.orderItemCommision+orderItem.orderItem.orderItemServiceFee }" pattern="#0.00"/></h4>
	    				<span><font>X</font>${orderItem.orderItem.orderItemNumber}</span>
	    			</div>
	   			</div>
	   		</div>
   		</div>
   		<p class="allP">共<span>${orderItem.orderItem.orderItemNumber}</span>件商品，合计<span>￥<fmt:formatNumber value="${(orderItem.orderItem.orderItemPrice+orderItem.orderItem.orderItemFreight+orderItem.orderItem.orderItemCommision+orderItem.orderItem.orderItemServiceFee )*orderItem.orderItem.orderItemNumber}" pattern="#0.00"/></span></p>
    </div>
    <c:if test="${!empty returnRecord.logisticsCompanyCode }">
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
    	</table>
    </div>
    </c:if>
    <div class="orderInfo tableInfo">
    	<div class="grayTitle">退款信息</div>
    	<table>
    		<tr>
    			<td>订单号</td>
    			<td>${returnRecord.returnInfoId}</td>
    		</tr>
    		<tr>
    			<td>订单状态</td>
    			<td>
    				<c:choose>
		            	<c:when test="${empty orderItem.orderItem.returnId && orderItem.orderItem.refundStatus==REFUND_APPLYING}">退款申请中</c:when>
		            	<c:when test="${empty orderItem.orderItem.returnId && orderItem.orderItem.refundStatus==REFUND_FAILURE}">退款失败</c:when>
		            	<c:when test="${empty orderItem.orderItem.returnId &&  orderItem.orderItem.refundStatus==REFUND_SUCCESS}">退款成功</c:when>
		            	<c:when test="${orderItem.orderItem.returnStatus==RETURN_APPLYING}">退货申请中</c:when>
		            	<c:when test="${orderItem.orderItem.returnStatus==RETURN_FAILURE}">退货失败</c:when>
		            	<c:when test="${orderItem.orderItem.returnStatus==RETURN_AGREE}">买家待发货</c:when>
		            	<c:when test="${orderItem.orderItem.returnStatus==WAITTING_SELLER_SIGNED}">卖家待收货</c:when>
			            <c:when test="${orderItem.orderItem.returnStatus==RETURN_SUCCESS}">退货成功</c:when>
		            </c:choose>
				</td>
    		</tr>
    		<%-- <tr>
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
    		</tr> --%>
    	</table>
    </div>
    <div class="handle">
    	<div class="btnGroup">
    	<c:if test="${orderItem.orderItem.refundStatus==REFUND_APPLYING
    		||orderItem.orderItem.returnStatus==RETURN_APPLYING}">
    		<button id="approveBtn">同意</button>
    		<button id="disapproveBtn">不同意</button>
    	</c:if>
    	<c:if test="${orderItem.orderItem.returnStatus==WAITTING_SELLER_SIGNED }">
        	<button id="logisticsBtn" data-logisticsCode="${returnRecord.transportNumber }"
        		data-logisticsCompanyCode="${rol.returnRecord.logisticsCompanyCode }">查看物流</button>
        	<button id="receiveBtn">收货</button>
	    </c:if>
    	</div>
    </div>
    
</div>
<!--[[底部-->
<%-- <jsp:include page="/jsp/buyer/footer.jsp"></jsp:include> --%>
<!--底部]]-->
<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
<script>
	$("#receiveBtn").tap(function(){
		toSign();
	});
	
	function toSign(){
		var url="<%=request.getContextPath()%>/factory/toSign";
		var params={returnInfoId:${returnRecord.returnInfoId}};
		doAjax("GET",url,params,signSuccess,fail,true,false);
	}
	
	function signSuccess(data){
		location.reload();
	}
	
	function fail(data){
		alert("fail");
	}
	
	$("#logisticsBtn").tap(function(){
		window.location.href="<%=request.getContextPath()%>/user/consultLogistics?logisticsCompanyCode=${returnRecord.logisticsCompanyCode}"+
				"&logisticsCode=${returnRecord.transportNumber}";
	});
	
	$("#approveBtn").tap(function(){
		var url;
		if(${empty orderItem.orderItem.returnId})
			url="<%=request.getContextPath()%>/factory/approveRefund";
		else
			url="<%=request.getContextPath()%>/factory/approveReturn";
		var params={returnInfoId:${returnRecord.returnInfoId}};
		doAjax("GET",url,params,approveSuccess,fail,true,false);
	});
	
	function approveSuccess(data){
		location.reload();
	}
	
	$("#disapproveBtn").tap(function(){
		var url;
		if(${empty orderItem.orderItem.returnId})
			url="<%=request.getContextPath()%>/factory/refuseRefund";
		else
			url="<%=request.getContextPath()%>/factory/refuseReturn";
		var params={returnInfoId:${returnRecord.returnInfoId}};
		doAjax("GET",url,params,refuseSuccess,fail,true,false);
	});
	
	function refuseSuccess(data){
		location.reload();
	}
	
	//开始物流信息
	$(".toSend").tap(function(){
		$(".sendLogistics").show();
	});
	$("#closeSendToDiv,#cancel,.shade").on("tap",function(){
		$(".sendToDiv").hide();
		$(".shade").hide();
	});
	
	$("#sendToUl li:not(.firstWord)").tap(function(){
		$("#sendToUl li").removeClass("active");
		$("#otherLogistics").removeClass("active");
		$(this).addClass("active");
		$(".sendToDiv").show();
		$(".shade").show();
		$("#logisticsCompany").html($(this).html());
		$("#otherInput").hide();
		$("#companySpan").show();
	});
	
	$("#otherLogistics").tap(function(){
		$(".sendToDiv").show();
		$(".shade").show();
		$("#otherInput").show();
		$("#companySpan").hide();
		$("#sendToUl li").removeClass("active");
		$("#otherLogistics").addClass("active");
	});
	
	$(".sendTop").tap(function(){
		$(".sendLogistics").hide();
	});
	
	$(".prevPage").tap(function(){
		history.go(-1);
	});
</script>
</body>
</html>