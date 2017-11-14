<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>金明同达灯饰</title>
    <link href="<%=request.getContextPath() %>/resources/common/bootstrap.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/common/swiper.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/customer/assets/css/orderCart.css" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
</head>
<body>

<div class="myOrder">
    <div class="title">购物订单</div>
    <div class="order-type clearfix">
        <span class="tab-type" onclick="window.location.href='<%=request.getContextPath()%>/buyer/orderManage?orderStatus=${OBLIGATION}'">待付款</span>
        <span class="tab-type" onclick="window.location.href='<%=request.getContextPath()%>/buyer/orderManage?orderStatus=${TO_BE_SHIPPED}'">待发货</span>
        <span class="tab-type" onclick="window.location.href='<%=request.getContextPath()%>/buyer/orderManage?orderStatus=${TO_BE_SIGNED}'">待收货</span>
        <span class="tab-type" onclick="window.location.href='<%=request.getContextPath()%>/buyer/orderManage?orderStatus=${SIGNED}'">已签收</span>
        <span class="tab-type" onclick="window.location.href='<%=request.getContextPath()%>/buyer/orderManage?orderStatus=${FINISHED}'">已完成</span>
        <span class="tab-type">退款中</span>
        <span class="tab-type" onclick="window.location.href='<%=request.getContextPath()%>/buyer/orderManage?orderStatus=${CLOSED}'">已关闭</span>
    </div>
    <!-- [[订单-->
    <c:forEach items="${orderItemPager.list }" var="orderItem">
    <div class="order clearfix">
        <div class="order-statue clearfix">
           <div class="contact-c clearfix">
            <div class="pull-left">
                <div class="img-content">
                    <img src="${rol.seller.userProtraitPic }" alt=""/>
                </div>
                <span class="company-name">${rol.seller.companyName }</span>
            </div>
            <div class="pull-right">
                <a href="http://wpa.qq.com/msgrd?v=3&uin=${rol.seller.qqNumber }&site=qq&menu=yes" target="_blank">
                    <i class="icon iconfont">&#xe607;</i>
                </a>
                <i class="icon iconfont">&#xe609;</i>
            </div>
        </div>
        </div>
        <div class="product clearfix">
            <div class="pull-left col-xs-8">
                <div class="col-xs-4">
                    <img src="${orderItem.product.cover1 }" alt=""/>
                </div>
                <div class="col-xs-8">
                    <span class="name">${orderItem.product.productName }</span><br />
                </div>
            </div>
            <div class="pull-right width-2 text-right">
                <span class="price red">￥${orderItem.orderItem.orderItemPrice }</span><br /><br />
                <span class="number">X ${orderItem.orderItem.orderItemNumber }</span>
            </div>
        </div>
    </div>
    <div class="order-total clearfix">
        	<button class="btn btn-primary" onclick="inputLogistics(${rol.returnRecord.returnInfoId })">评价</button>
    </div>
    </c:forEach>
    <!-- 订单]]-->
    <!-- [[分页-->
    <div class="paging text-center">
        <button class="btn btn-primary" onclick="window.location.href='<%=request.getContextPath()%>/buyer/waitEvaluateList?offset=${returnPager.before }'">上一页</button>
        <button class="btn btn-primary" onclick="window.location.href='<%=request.getContextPath()%>/buyer/waitEvaluateList?offset=${returnPager.after }'">下一页</button>
    </div>
    <!-- 分页]]-->
</div>

<!--[[底部-->
<jsp:include page="/jsp/buyer/footer.jsp"></jsp:include>
<!--底部]]-->
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
			$(this).find(".product-total .red").html($(this).find(".product-total .red").html().replace("number",numbers));
		});
	}
	
	function fail(){
		alert("fail");
	}
	
	function inputLogistics(returnInfoId){
		var logisticsCompanyCode=prompt("选择物流公司","");
		var logisticsCode=prompt("输入物流单号","");
		window.location.href="<%=request.getContextPath()%>/buyer/delivery?returnInfoId="+returnInfoId+
				"&logisticsCompanyCode="+logisticsCompanyCode+"&logisticsCode="+logisticsCode+
				"&offset=${offset}";
	}
</script>
</body>
</html>