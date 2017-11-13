<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>管理后台</title>
    <link rel="icon" type="image/x-icon" href="<%=request.getContextPath() %>/resources/image/favicon.ico" />

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
        <!-- [[订单详情-->
       <div class="order">
        <div class="order-statue clearfix">
            <div class="order-statue clearfix">
                <div class="order-number pull-left">订单号：${orderForm.orderNumber }</div>
                <div class="pull-right statue"><c:choose>
					<c:when test="${orderForm.orderStatus==OBLIGATION }">待付款</c:when>
					<c:when test="${orderForm.orderStatus==TO_BE_SHIPPED }">待发货</c:when>
					<c:when test="${orderForm.orderStatus==TO_BE_SIGNED }">待签收</c:when>
					<c:when test="${orderForm.orderStatus==SIGNED }">已签收</c:when>
					<c:when test="${orderForm.orderStatus==FINISHED }">已完成</c:when>
					<c:when test="${orderForm.orderStatus==CLOSED }">已关闭</c:when></c:choose>
				</div>
            </div>
            <div class="receive-message text-left">
                <div class="receive-title">收货人信息</div>
                <div class="name">${orderForm.receivePerson }</div>
                <div class="phone">${orderForm.receivePhone }</div>
                <div class="address">${orderForm.receiveProvince}${orderForm.receiveCity}${orderForm.receiveArea}${orderForm.receiveAddress}</div>
            </div>
            <c:forEach items="${orderItemList }" var="orderItem">
            <div class="product clearfix">
                <div class="pull-left col-md-8">
                    <div class="col-md-4" onclick="window.location.href='<%=request.getContextPath()%>/product/productDetail?productId=${orderItem.product.productId}'">
                        <img src="${orderItem.product.cover1}" alt=""/>
                    </div>
                    <div class="col-md-8 text-left" onclick="window.location.href='<%=request.getContextPath()%>/product/productDetail?productId=${orderItem.product.productId}'">
                        <span class="name">${orderItem.product.productName }</span><br /><br />
                        <span class="specific">规格：${orderItem.product.productCode }</span><br />
                    </div>
                </div>
                <div class="pull-right width-2 text-right">
                    <span class="price">￥<fmt:formatNumber value="${orderItem.orderItem.orderItemPrice+orderItem.orderItem.orderItemFreight+orderItem.orderItem.orderItemCommision+orderItem.orderItem.orderItemServiceFee }" pattern="#0.00"/></span><br /><br />
                    <span class="number">X ${orderItem.orderItem.orderItemNumber}</span>
                    <c:choose>
		            	<c:when test="${empty orderItem.orderItem.returnId && orderItem.orderItem.refundStatus==REFUND_APPLYING}">退款申请中</c:when>
		            	<c:when test="${empty orderItem.orderItem.returnId && orderItem.orderItem.refundStatus==REFUND_FAILURE}">退款失败</c:when>
		            	<c:when test="${empty orderItem.orderItem.returnId &&  orderItem.orderItem.refundStatus==REFUND_SUCCESS}">退款成功</c:when>
		            	<c:when test="${orderItem.orderItem.returnStatus==RETURN_APPLYING}">退货申请中</c:when>
		            	<c:when test="${orderItem.orderItem.returnStatus==RETURN_FAILURE}">退货失败</c:when>
		            	<c:when test="${orderItem.orderItem.returnStatus==RETURN_AGREE}">买家待发货</c:when>
		            	<c:when test="${orderItem.orderItem.returnStatus==WAITTING_SELLER_SIGNED}">卖家待收货</c:when>
			            <c:when test="${ rol.orderItemModel.orderItem.returnStatus==RETURN_SUCCESS}">退货成功</c:when>
		            </c:choose>
                </div>
            </div>
            </c:forEach>
            <div class="order-total clearfix text-left">
                <div class="pull-left">
                    <div class="product-total">商品合计：￥${orderForm.orderMoney}（共productCount件）</div>
                    <%-- <div class="freight">运费合计：￥${orderForm.orderFreight}</div> --%>
                </div>
                <div class="pull-right">
                   <!--  <button class="btn btn-warning" >同意退款</button> -->
                </div>
            </div>
            <div class="order-time text-left">
                <div class="placeOrder">下单时间：<fmt:formatDate value="${orderForm.orderTime}" pattern="yyyy-MM-dd HH:mm:ss" /></div>
                <div class="payOrder">付款时间：<c:if test="${!empty orderForm.payTime }"><fmt:formatDate value="${orderForm.payTime}" pattern="yyyy-MM-dd HH:mm:ss" /></c:if>
        						<c:if test="${empty orderForm.payTime }">暂未付款</c:if></div>
                <div class="sendOrder">发货时间：<c:if test="${!empty orderForm.sendTime }"><fmt:formatDate value="${orderForm.sendTime}" pattern="yyyy-MM-dd HH:mm:ss" /></c:if>
        						<c:if test="${empty orderForm.sendTime }">暂未发货</c:if></div>
            </div>
            <div class="logisticsTrace clearfix">
            	<c:if test="${orderForm.orderStatus==TO_BE_SIGNED||orderForm.orderStatus==SIGNED||orderForm.orderStatus==FINISHED}"> 
                <a href="javascript:consultLogistics()">
                    <button class="btn btn-primary">物流追踪</button>
                </a>
                </c:if>
            </div>
             <div class="logisticsTrace clearfix">
            <c:if test="${orderForm.orderServiceStatus==1}">
            <form action="<%=request.getContextPath() %>/platform/updateServiceOrder">
            	<input type="hidden" name="orderNumber" value="${orderForm.orderNumber }"/>
            	安装人员名字:<input type="text" name="orderInstallPerson" value="${orderForm.orderInstallPerson }"/>
            	安装人员联系电话：<input type="text" name="orderInstallPersonContact" value="${orderForm.orderInstallPersonContact }"/>
            	<br/>
            	<button>提交</button>
            	</form>
            </c:if>
             <c:if test="${orderForm.orderServiceStatus!=1}">
             	安装人员名字:${orderForm.orderInstallPerson }<br>
             	安装人员联系电话:${orderForm.orderInstallPersonContact }
             </c:if>
            </div>
            
            
        </div>
    </div>
        <!-- 订单详情]]-->

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
		var numbers=0;
		$(".product").each(function(){
			numbers = numbers+parseInt($(this).find(".number").html().match(/\d+(\.\d+)?/g));
		});
		$(".product-total").html($(".product-total").html().replace("productCount",numbers));
	}
	
	//查询物流
	function consultLogistics(){
		window.location.href="<%=request.getContextPath()%>/buyer/consultLogistics?logisticsCompanyCode=${orderForm.logisticsCompanyCode}"+
				"&logisticsCode=${orderForm.transportNumber}";
	}
</script>
</html>
