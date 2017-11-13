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
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/backStage/css/order.css" />
</head>
<body>
	<c:set var="OBLIGATION" value="<%=OrderStatus.OBLIGATION%>" />
	<c:set var="TO_BE_SHIPPED" value="<%=OrderStatus.TO_BE_SHIPPED%>" />
	<c:set var="TO_BE_SIGNED" value="<%=OrderStatus.TO_BE_SIGNED%>" />
	<c:set var="SIGNED" value="<%=OrderStatus.SIGNED%>" />
	<c:set var="FINISHED" value="<%=OrderStatus.FINISHED%>" />
	<c:set var="CLOSED" value="<%=OrderStatus.CLOSED%>" />
    <jsp:include page="/jsp/platform/header.jsp"></jsp:include>
	<jsp:include page="/jsp/platform/navigation.jsp"></jsp:include>
    <!-- [[选项卡-->
    <div class="nav-tabs">
        <button class="btn <c:if test='${orderStatus==OBLIGATION }'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath()%>/platform/orderList?orderStatus=${OBLIGATION}'">待付款</button>
        <button class="btn <c:if test='${orderStatus==TO_BE_SHIPPED }'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath()%>/platform/orderList?orderStatus=${TO_BE_SHIPPED}'">待发货</button>
        <button class="btn <c:if test='${orderStatus==TO_BE_SIGNED }'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath()%>/platform/orderList?orderStatus=${TO_BE_SIGNED}'">待收货</button>
        <button class="btn <c:if test='${orderStatus==SIGNED }'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath()%>/platform/orderList?orderStatus=${SIGNED}'">已签收</button>
        <button class="btn <c:if test='${orderStatus==FINISHED }'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath()%>/platform/orderList?orderStatus=${FINISHED}'">已完成</button>
        <button class="btn <c:if test='${orderStatus==CLOSED }'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath()%>/platform/orderList?orderStatus=${CLOSED}'">已关闭</button>
        <button class="btn" onclick="window.location.href='<%=request.getContextPath()%>/platform/returnOrderManage'">退款/退货</button>
        <button class="btn" onclick="window.location.href='<%=request.getContextPath()%>/platform/serviceOrderList'">待服务订单</button>
    </div><!-- 选项卡]] -->

    <!-- [[订单列表 -->
    <c:forEach items="${orderPager.list}" var="ofm">
    <div class="order">
        <div>
            <div class="order-statue clearfix">
                <div class="company pull-left">企业：${ofm.seller.shortCompanyName }</div>
                <div class="pull-right contact">
                    	联系负责人：${ofm.seller.phoneNumber }
                    <!-- QQ号为要联系的人的qq号 -->
                    <a href="tencent://message/?uin=${ofm.seller.qqNumber }"><img src="<%=request.getContextPath() %>/resources/image/QQ.png" alt="" class="contactImg" /></a>
                </div>
            </div>
            <div class="order-statue clearfix">
                <div class="order-number pull-left"><a href="<%=request.getContextPath() %>/platform/serviceOrderDetail?orderNum=${ofm.orderForm.orderNumber}" class="blueText">订单号：${ofm.orderForm.orderNumber}</a></div>
                <div class="pull-right statue">订单状态：
               		<c:choose>
						<c:when test="${orderStatus==OBLIGATION }">待付款</c:when>
						<c:when test="${orderStatus==TO_BE_SHIPPED }">待发货</c:when>
						<c:when test="${orderStatus==TO_BE_SIGNED }">待签收</c:when>
						<c:when test="${orderStatus==SIGNED }">已签收</c:when>
						<c:when test="${orderStatus==FINISHED }">已完成</c:when>
						<c:when test="${orderStatus==CLOSED }">已关闭</c:when>
					</c:choose>
				</div>
            </div>
            <c:forEach items="${ofm.orderItemList }" var="oim">
            <div class="product clearfix">
                <div class="pull-left col-md-8">
                    <div class="col-md-4">
                        <img src="${oim.product.cover1 }" alt=""/>
                    </div>
                    <div class="col-md-8 text-left">
                        <span class="name">${oim.product.productName }</span><br /><br />
                    </div>
                </div>
                <div class="pull-right width-2 text-right">
                    <span class="price">￥${oim.orderItem.orderItemPrice }</span><br /><br />
                    <span class="number">X ${oim.orderItem.orderItemNumber }</span>
                </div>
            </div>
            </c:forEach>
            <div class="order-total clearfix text-left">
                <div class="product-total">商品合计：￥${ofm.orderForm.orderMoney}（共number件）</div>
                <div class="freight">安装费合计：￥${ofm.orderForm.orderInstallMoney}</div>
            </div>
        </div>
    </div>
    </c:forEach>
    <!-- 订单列表]] -->

    <!-- [[分页-->
    <div class="paging">
        <span class="prev btn btn-primary" onclick="window.location.href='<%=request.getContextPath()%>/platform/orderList?offset=${orderPager.before}&orderStatus=${orderStatus}'">上一页</span>
        <span class="next btn btn-primary" onclick="window.location.href='<%=request.getContextPath()%>/platform/orderList?offset=${orderPager.after}&orderStatus=${orderStatus}'">下一页</span>
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

</script>
</html>