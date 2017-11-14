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
    <link href="<%=request.getContextPath() %>/resources/customer/assets/css/orderCart.css?22" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
</head>
<body>
<c:set var="OBLIGATION" value="<%=OrderStatus.OBLIGATION%>" />
<c:set var="TO_BE_SHIPPED" value="<%=OrderStatus.TO_BE_SHIPPED%>" />
<c:set var="TO_BE_SIGNED" value="<%=OrderStatus.TO_BE_SIGNED%>" />
<c:set var="SIGNED" value="<%=OrderStatus.SIGNED%>" />
<c:set var="FINISHED" value="<%=OrderStatus.FINISHED%>" />
<c:set var="CLOSED" value="<%=OrderStatus.CLOSED%>" />
<c:set var="AGENCY" value="<%=UserType.AGENCY%>" />
<c:set var="FACILITATOR" value="<%=UserType.FACILITATOR%>" />
<c:set var="WAIT_TAKE_ORDER" value="<%=ServiceOrderStatus.WAIT_TAKE_ORDER%>" />
<c:set var="WAIT_SERVICE" value="<%=ServiceOrderStatus.WAIT_SERVICE%>" />
<c:set var="SERVICED" value="<%=ServiceOrderStatus.SERVICED%>" />
<div class="myOrder">
    <div class="title">客户订单</div>
    <div class="allStatus">
    	<ul id="statusUl">
	    	<li <c:if test='${orderStatus==OBLIGATION }'>class="active"</c:if>><a href="<%=request.getContextPath()%>/buyer/lowUserOrderList?orderStatus=${OBLIGATION}">待付款</a></li>
	    	<li <c:if test='${orderStatus==TO_BE_SHIPPED }'>class="active"</c:if>><a href="<%=request.getContextPath()%>/buyer/lowUserOrderList?orderStatus=${TO_BE_SHIPPED}">待发货</a></li>
	    	<li <c:if test='${orderStatus==TO_BE_SIGNED }'>class="active"</c:if>><a href="<%=request.getContextPath()%>/buyer/lowUserOrderList?orderStatus=${TO_BE_SIGNED}">待收货</a></li>
	    	<li ><a href="<%=request.getContextPath()%>/buyer/lowUserReturnOrderList">退款/货</a></li>
	    	<li id="otherLi"><a href="#">其他</a></li>
	    </ul>
	    <div class="childStatus">
	    	<span class="little"></span>
	    	<ul id="childStatusUl">
	    		<li <c:if test='${orderStatus==SIGNED }'>class="active"</c:if>><a href="<%=request.getContextPath()%>/buyer/lowUserOrderList?orderStatus=${SIGNED }">已签收</a></li>
	    		<li <c:if test='${serviceOrderStatus==WAIT_TAKE_ORDER }'>class="active"</c:if>><a href="<%=request.getContextPath() %>/buyer/serviceOrder?serviceOrderStatus=${WAIT_TAKE_ORDER}">待接单</a></li>
	    		<li <c:if test='${serviceOrderStatus==WAIT_SERVICE }'>class="active"</c:if>><a href="<%=request.getContextPath()%>/buyer/serviceOrder?serviceOrderStatus=${WAIT_SERVICE }">待服务</a></li>
	    		<li <c:if test='${serviceOrderStatus==SERVICED }'>class="active"</c:if>><a href="<%=request.getContextPath()%>/buyer/serviceOrder?serviceOrderStatus=${SERVICED }">已服务</a></li>
	    		<li <c:if test='${orderStatus==FINISHED }'>class="active"</c:if>><a href="<%=request.getContextPath()%>/buyer/lowUserOrderList?orderStatus=${FINISHED}">已完成</a></li>
	    		<li <c:if test='${orderStatus==CLOSED }'>class="active"</c:if>><a href="<%=request.getContextPath()%>/buyer/lowUserOrderList?orderStatus=${CLOSED}">已关闭</a></li>
	    	</ul>
	    </div>
    </div>
    <div class="orderInfo">
    	
   		
    </div>
    <div class="noOrder">
		<span><i class="iconfont">&#xe664;</i></span>
		<p>您还没有相关订单</p>
	</div>
   
    <div class="loading" style="visibility: visible;"><i class="iconfont">&#xe62c;</i><span id="jiazai">加载中...</span></div>
    <!-- 分页]]-->
</div>

<!--[[底部-->
<jsp:include page="/jsp/buyer/footer.jsp"></jsp:include>
<!--底部]]-->
<script>
	$(".childStatus").css("top",$(".title").height()+$(".allStatus").height()+5+parseInt($(".childStatus").css("top")));
	
	$("#otherLi").tap(function(){
		$("#statusUl li").removeClass("active");
		$(this).addClass("active");
		$(".childStatus").toggle();
	});
	
	$("#statusUl li:not(#otherLi)").tap(function(){
		$("#statusUl li").removeClass("active");
		$(this).addClass("active");
		$(".childStatus").hide();
		$("#childStatusUl li").removeClass("active");
	});
	
	$("#childStatusUl li").tap(function(){
		$("#childStatusUl li").removeClass("active");
		$(this).addClass("active");
	});

	var offset=0;
	var canLoad=true;
	var noDate=false;
	$(function(){
		loadOrder();
		var wiwH=$(window).height();
		//开始加载中
		 var wiwH=$(window).height();
		var load=$(".loading");
		var time; 
	   
		$(document).scroll(function(){
			 if(load.offset().top - $(window).scrollTop()<wiwH){
				if(canLoad&&!noDate){
    				load.css("visibility","visible");
					canLoad=false;
					loadOrder();
				}
				if(noDate){
    				load.html("暂无更多订单");
    				load.css("visibility","visible");
				}
				//ajax加载数据
				//加载成功
				//load.css("visibility","hidden");
				//加载失败
				//$("#jiazai").html("系统繁忙，请稍候再试！");load.css("animation-play-state","paused");
				time=setTimeout(function(){
					$("#jiazai").html("系统繁忙，请稍候再试！");
					$(".loading>i").css({
						"animation-play-state":"paused",
						"-webkit-animation-play-state":"paused"
					});
				},8000);
			}else{
				window.clearTimeout(time);
				$("#jiazai").html("加载中...");
				load.css("visibility","hidden");
				$(".loading>i").css({
						"animation-play-state":"running",
					"-webkit-animation-play-state":"running"
				});
			} 
		});
		
		function loadOrder(){
			var url="<%=request.getContextPath()%>/buyer/serviceOrderAjax";
			var params={offset:offset,serviceOrderStatus:${serviceOrderStatus}};
			doAjax("GET",url,params,loadSuccess,fail,true,false);
		}
		
		function loadSuccess(data){
			var orderList = data.data.list;
			var orderItemList;
			var html="";
			var productNumber;
			for(var i=0;i<orderList.length;i++){
				html+='<div class="shopOrder" data-id="'+orderList[i].serviceOrder.serviceOrderId+'"><div class="shopName">';
				html+='<a href="javascript:void();"><span><i class="iconfont">&#xe600;</i>'+orderList[i].buyer.userNickname+'</span></a>';
				html+=((orderList[i].buyer.phoneNumber!=null)?'<i class="iconfont contactI phoneI" data-phone="'+orderList[i].buyer.phoneNumber+'">&#xe609;</i>':'');
				html+=((orderList[i].buyer.qqNumber!=null)?'<i class="iconfont contactI qqI" data-qqNumber="'+orderList[i].buyer.qqNumber+'">&#xe607;</i>':'');
				html+="</div>";
				orderItemList=orderList[i].orderItemList;
				productNumber=0;
				for(var j=0;j<orderItemList.length;j++){
					html+='<div class="commodity"><a href="<%=request.getContextPath()%>/product/productDetail?productId='+orderItemList[j].product.productId+'">';
					html+='<img src="'+changePath(orderItemList[j].product.cover1)+'"/></a>';
					html+='<div class="commDiv">';
					html+='<p><a href="<%=request.getContextPath()%>/product/productDetail?productId='+orderItemList[j].product.productId
							+'">'+orderItemList[j].product.productName+'</a></p>';
					html+='<div class="moneyNum"><h4>￥'+getPrice(orderItemList[j].orderItem)+'</h4><span><font>X</font>'
							+orderItemList[j].orderItem.orderItemNumber+'</span>';
					html+='</div></div></div>';
					productNumber+=orderItemList[j].orderItem.orderItemNumber;
				}	
				html+='<p class="allP">商品合计:<span>￥'+orderList[i].orderForm.orderMoney+'</span>(共<span>'+productNumber+'</span>件)　服务费合计:<span>￥'+orderList[i].orderForm.orderServiceMoney+'</span></p>';
				html+='<div class="btnGroup">';
				html+='<span class="orderStatus">'+getStatus(orderList[i].orderForm)+'</span>';
				html+=getButton(orderList[i].orderForm);
				html+='</div></div>';
			}
			$(".orderInfo").append(html);
			load.css("visibility","hidden");
			if((parseInt(offset)+10)>=data.data.count){
				noDate=true;
			}
			
			offset=data.data.after;
			canLoad=true;
			
			if(data.data.count==0){
				$(".noOrder").show();
			}
		}
		
		function fail(data){
			alert(data);
		}
		
		function getButton(orderForm){
			var btnStr='';
			if(orderForm.orderServiceStatus==1){
				btnStr+="<button class='bgcolorBtn serviceBtn'>接单</button>"
			}
			btnStr+='<button class="detailBtn">查看详情</button>';
			return btnStr;
		}
		
		function getStatus(orderForm){
			switch(orderForm.orderStatus){
				case ${OBLIGATION}:
					return "待付款";
				case ${TO_BE_SHIPPED}:
					return "待发货";
				case ${TO_BE_SIGNED}:
					return "待收货";
				case ${SIGNED}:
					return "已收货";
				case ${FINISHED}:
					return "已完成";
				case ${CLOSED}:
					return "已关闭";
			}
		}
		
		function getPrice(orderItem){
			return (orderItem.orderItemPrice+orderItem.orderItemFreight+orderItem.orderItemCommision+orderItem.orderItemServiceFee).toFixed(2);
		}
		
		function changePath(path){
			var i=path.lastIndexOf("/");
			return path.substring(0,i+1)+"thumbnailImage/"+path.substring(i+1);
		}
	});
	
	$(document).on("tap",".detailBtn",function(){
		window.location.href='<%=request.getContextPath()%>/buyer/serviceOrderDetail?serviceOrderId='+$(this).parents(".shopOrder").attr("data-id");
	});
	
	$(document).on("tap",".serviceBtn",function(){
		var url="<%=request.getContextPath()%>/buyer/takeServiceOrder";
		var params={serviceOrderId:$(this).parents(".shopOrder").attr("data-id")};
		doAjax("GET",url,params,success,fail,true,false);
	});
	
	function success(data){
		window.location.href="<%=request.getContextPath()%>/buyer/serviceOrder?serviceOrderStatus=1";
	}
	
	function fail(data){
		alert("fail");
	}
	
	$(document).on("tap",".qqI",function(){
		window.location.href="http://wpa.qq.com/msgrd?v=3&uin="+$(this).attr("data-qqNumber")+"&site=qq&menu=yes";
	});
	
	$(document).on("tap",".phoneI",function(){
		window.location.href="tel:"+$(this).attr("data-phone");
	});
</script>
</body>
</html>
