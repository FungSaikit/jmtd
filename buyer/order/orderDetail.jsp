<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib prefix="thumbnail" uri="/WEB-INF/tld/thumbnailTag.tld"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <meta charset="UTF-8">
    <title>东方百泰</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/customer/assets/css/topbar_orange.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/customer/assets/css/order_details.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/customer/assets/css/round_button.css">
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
<div class="topbar">
    <a href="javascript:history.go(-1);"><img class="topbar_left" src="<%=request.getContextPath()%>/resources/customer/assets/images/top_bar/back_white.png" alt="返回"></a>
    <span class="topbar_middle">订单详情</span>
    <span class="topbar_right">&nbsp&nbsp&nbsp&nbsp&nbsp</span>
</div>

<div class="placeholder">
</div>

<div class="customerinfo">
    <div class="customerinfoleft">
        <img src="<%=request.getContextPath()%>/resources/customer/assets/images/cart/location.png">
    </div>
    <div class="customerinforight">
        <div class="customerinfotop">
            <span class="info">收货人:${orderForm.receivePerson }</span>
            <span class="info" style="float: right">${orderForm.receivePhone }</span>
        </div>
        <div class="info address">
            收货地址:${orderForm.receiveProvince}${orderForm.receiveCity}${orderForm.receiveArea}${orderForm.receiveAddress}
        </div>
    </div>
</div>

<div class="goods">
    <div class="goodsnumber_div">
        <span class="goodsnumber">订单号：${orderForm.orderNumber }</span>
    </div>
    <c:forEach items="${orderItemList }" var="orderItem">
    <div class="goodsinfo">
        <div class="goodspic">
            <img src="<thumbnail:date value='${orderItem.product.cover1}'/>" alt="图片">
        </div>
        <div class="goodsdetail">
            <div class="goodstitle">
                <span class="goodstitle_span">${orderItem.product.productName }</span>
            </div>
            <div class="goodsmodel">
                <span class="goodsmodel_span">型号:${orderItem.product.productCode }</span>
            </div>
            <div class="goodsprice">
                <span class="goodsprice_span">￥<fmt:formatNumber value="${orderItem.orderItem.orderItemPrice+orderItem.orderItem.orderItemFreight+orderItem.orderItem.orderItemCommision+orderItem.orderItem.orderItemServiceFee+orderItem.orderItem.woodenFee }" pattern="#0.00"/></span>
                <span class="goodsnumber_span">数量：${orderItem.orderItem.orderItemNumber}</span>
            </div>
            <div class="goodsservice">
            	<c:choose>
	            	<c:when test="${empty orderItem.orderItem.returnId && orderItem.orderItem.refundStatus==REFUND_FAILURE}">退款失败</c:when>
	            	<c:when test="${empty orderItem.orderItem.returnId &&  orderItem.orderItem.refundStatus==REFUND_SUCCESS}">退款成功</c:when>
	            	<c:when test="${orderItem.orderItem.returnStatus==RETURN_FAILURE}">退货失败</c:when>
		            <c:when test="${orderItem.orderItem.returnStatus==RETURN_SUCCESS}">退货成功</c:when>
           		</c:choose>
            	<c:choose>
		            <c:when test="${(empty orderItem.orderItem.refundId || orderItem.orderItem.refundStatus==REFUND_FAILURE
		            		)&& (empty orderItem.orderItem.returnId || orderItem.orderItem.returnStatus==RETURN_FAILURE )
		            		&& empty orderItem.orderItem.penddingAfterSale}">
		            	<button class="roundbutton" onclick="toAfterSale(${orderItem.orderItem.orderItemId},${orderForm.orderNumber })" style="float: right; margin-right: 0.5rem;">申请售后</button>
		            </c:when>
			        <c:when test="${empty orderItem.orderItem.returnId && orderItem.orderItem.refundStatus==REFUND_APPLYING}"><button class="roundbutton" style="float: right; margin-right: 0.5rem;" data-id="${orderItem.orderItem.refundId}">退款申请中</button></c:when>
	            	<c:when test="${orderItem.orderItem.returnStatus==RETURN_APPLYING}"><button class="roundbutton" style="float: right; margin-right: 0.5rem;" data-id="${orderItem.orderItem.returnId}">退货申请中</button></c:when>
	            	<c:when test="${orderItem.orderItem.returnStatus==RETURN_AGREE}"><button class="roundbutton" style="float: right; margin-right: 0.5rem;"  data-id="${orderItem.orderItem.returnId}">买家待发货</button></c:when>
	            	<c:when test="${orderItem.orderItem.returnStatus==WAITTING_SELLER_SIGNED}"><button class="roundbutton" style="float: right; margin-right: 0.5rem;"  data-id="${orderItem.orderItem.returnId}">卖家待收货</button></c:when>
	            	<c:otherwise><button class="roundbutton" style="float: right; margin-right: 0.5rem;"  data-id="${orderItem.orderItem.returnId}">售后处理中</button></c:otherwise>
            	</c:choose>
            </div>
        </div>
    </div>
    </c:forEach>
    <div class="goodsmenu">
        <a class="menubutton" style="float: left;" href="#">联系客服</a>
        <a class="menubutton" style="float: right;" href="tel:${service.phoneNumber}">拨打电话</a>
        <div style="height: 1rem; width: 100%;"></div>
        <div style="height: 1rem; width: 100%; background-color:#e5e5e5;"></div>
    </div>
</div>

<div class="orderstatus">
    <div class="statusinfo">订单编号: ${orderForm.orderNumber}</div>
    <div class="statusinfo">交易状态: 
		<c:choose>
			<c:when test="${orderForm.orderStatus==OBLIGATION }">待付款</c:when>
			<c:when test="${orderForm.orderStatus==TO_BE_SHIPPED }">待发货</c:when>
			<c:when test="${orderForm.orderStatus==TO_BE_SIGNED }">待签收</c:when>
			<c:when test="${orderForm.orderStatus==SIGNED }">已签收</c:when>
			<c:when test="${orderForm.orderStatus==FINISHED }">已完成</c:when>
			<c:when test="${orderForm.orderStatus==CLOSED }">已关闭</c:when>
		</c:choose>
	</div>
    <div class="statusinfo">创建时间:<fmt:formatDate value="${orderForm.orderTime}" pattern="yyyy-MM-dd HH:mm:ss" /></div>
    <div class="statusinfo">付款时间: <c:if test="${!empty orderForm.payTime }"><fmt:formatDate value="${orderForm.payTime}" pattern="yyyy-MM-dd HH:mm:ss" /></c:if>
        			<c:if test="${empty orderForm.payTime }">暂未付款</c:if></div>
    <div class="statusinfo">发货时间: <c:if test="${!empty orderForm.sendTime }"><fmt:formatDate value="${orderForm.sendTime}" pattern="yyyy-MM-dd HH:mm:ss" /></c:if>
        			<c:if test="${empty orderForm.sendTime }">暂未发货</c:if></div>
    <div class="statusinfo">成交时间: <c:if test="${!empty orderForm.receiveTime }"><fmt:formatDate value="${orderForm.receiveTime}" pattern="yyyy-MM-dd HH:mm:ss" /></c:if>
        			<c:if test="${empty orderForm.receiveTime }">暂未收货</c:if></div>
</div>

<div class="bottombar">
	<c:if test="${!empty isBuyer || user.userId==orderForm.upUserId || !empty user.manageRole}">
	    <c:if test="${!empty isBuyer}">
    	<c:if test="${orderForm.orderStatus==OBLIGATION }"> 
    		<button class="roundbutton closeOrder">关闭订单</button>
    		<button class="roundbutton roundbuttonActive toPay">去付款</button>
    	</c:if>
    	<c:if test="${orderForm.orderStatus==TO_BE_SIGNED }"> 
    		<button class="roundbutton roundbuttonActive receiveBtn">确认收货</button>
    	</c:if>
    	 <c:if test="${orderForm.orderStatus==SIGENED }"> 
    		<button class="roundbutton serviceBtn">确认已服务</button>
    	 </c:if>
    	 </c:if>
    	 <c:if test="${orderForm.transportType!=1&&!empty orderForm.logisticsCompanyCode }">
    				<button class="roundbutton logisticsBtn">查看物流</button></c:if>
    </c:if>
</div>

<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
<script>
	function toAfterSale(orderItemId,orderNumber){
		window.location.href="<%=request.getContextPath()%>/buyer/toApplyAfterSale?orderItemId="
				+orderItemId+"&orderNumber="+orderNumber;
	}
	
	//关闭订单
	$(".closeOrder").tap(function(){
		window.location.href="<%=request.getContextPath()%>/buyer/closeOrder?orderNum=${orderForm.orderNumber}";
	});
	
	//查询物流
	$(".logisticsBtn").tap(function(){
		window.location.href="<%=request.getContextPath()%>/user/consultLogistics?logisticsCompanyCode=${orderForm.logisticsCompanyCode}"+
			"&logisticsCode=${orderForm.transportNumber}&transportPhoneNumber=${orderForm.transportPhoneNumber}&orderNum=${orderForm.orderNumber}";
	});
	
	//确认收货
	$(".receiveBtn").tap(function(){
		window.location.href="<%=request.getContextPath()%>/buyer/toSign?orderNum=${orderForm.orderNumber}";
	});
	
	$(".toPay").tap(function(){
		var url="<%=request.getContextPath()%>/buyer/payOrder?orderNum=${orderForm.orderNumber}";
		var params={};
		doAjax("GET",url,params,payOrderSuccess,fail,false,false);
	});
	
	function payOrderSuccess(data){
		var urlStr = "<%=request.getContextPath()%>/wechat/signature?url="+location.href.split('#')[0];
		//alert("Before Call:"+urlStr);
		$.ajax({
			method: "GET",
			url: urlStr,
			success:function(result,status,jqXHR){
				var appId=result.appId;
				var signature = result.signature;
				var timeStamp = result.timeStamp;
			    var nonceStr = result.nonceStr;		 
			    wx.config({
			        debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
			        appId: appId, // 必填，公众号的唯一标识
			        timestamp:timeStamp , // 必填，生成签名的时间戳
			        nonceStr: nonceStr, // 必填，生成签名的随机串
			        signature: signature,// 必填，签名，见附录1
			        jsApiList: ['chooseWXPay'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
			    });
			    wx.ready(function(){
			        // config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
			        wx.chooseWXPay({
			            timestamp: data.timestamp, // 支付签名时间戳，注意微信jssdk中的所有使用timestamp字段均为小写。但最新版的支付后台生成签名使用的timeStamp字段名需大写其中的S字符
			            nonceStr:data.nonceStr, // 支付签名随机串，不长于 32 位
			            package: data.Package, // 统一支付接口返回的prepay_id参数值，提交格式如：prepay_id=***）
			            signType: "MD5", // 签名方式，默认为'SHA1'，使用新版支付需传入'MD5'
			            paySign: data.paySign, // 支付签名
			            complete: function (res) {
			                // 支付成功后的回调函数
			            	if(res.errMsg=="chxooseWXPay:fail")
			                	alert("fail");
			                if(res.errMsg=="chooseWXPay:cancel")
			                	alert("cancle");
			                if(res.errMsg=="chooseWXPay:ok"){
			                	location.reload();
			                } 
			            }
			        }); 
			    });
			}
		}); // end ajax   
	}
	
	function fail(data){
		alert("fail");
	} 
</script>
</body>
</html>