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
    <style>
    	
    </style>
</head>
<body>
<c:set var="CUSTOMER" value="<%=UserType.CUSTOMER%>" />
<c:set var="OBLIGATION" value="<%=OrderStatus.OBLIGATION%>" />
<c:set var="TO_BE_SHIPPED" value="<%=OrderStatus.TO_BE_SHIPPED%>" />
<c:set var="TO_BE_SIGNED" value="<%=OrderStatus.TO_BE_SIGNED%>" />
<c:set var="SIGNED" value="<%=OrderStatus.SIGNED%>" />
<c:set var="FINISHED" value="<%=OrderStatus.FINISHED%>" />
<c:set var="CLOSED" value="<%=OrderStatus.CLOSED%>" />
<c:set var="PENDING_SERVICE" value="<%=OrderServiceStatus.PENDING_SERVICE%>" />
<c:set var="SERVICED" value="<%=OrderServiceStatus.SERVICED%>" />
<div class="myOrder">
    <div class="title"><i class="iconfont prevPage" >&#xe63f;</i>订单</div>
    <div class="searchDiv">
    	<div>
    		<button class="search float-left col-xs-2"><i class="icon iconfont">&#xe610;</i></button>
 	    	<input type="text" id="keyword" value="${keyword}" placeHolder="请输入你要查找的内容" class="form-control float-left col-xs-10"/>
	    </div>
    </div>
    <div class="allStatus">
    	<ul id="statusUl">
	    	<li <c:if test='${orderStatus==OBLIGATION }'>class="active"</c:if>><a href="<%=request.getContextPath()%>/buyer/manageOrderList?orderStatus=${OBLIGATION}&keyword=${keyword}">待付款</a></li>
	    	<li <c:if test='${orderStatus==TO_BE_SHIPPED }'>class="active"</c:if>><a href="<%=request.getContextPath()%>/buyer/manageOrderList?orderStatus=${TO_BE_SHIPPED}&keyword=${keyword}">待发货</a></li>
	    	<li <c:if test='${orderStatus==TO_BE_SIGNED }'>class="active"</c:if>><a href="<%=request.getContextPath()%>/buyer/manageOrderList?orderStatus=${TO_BE_SIGNED}&keyword=${keyword}">待收货</a></li>
	    	<li ><a href="<%=request.getContextPath()%>/buyer/returnOrderManage">退款/货</a></li>
	    	<li id="otherLi"><a >其他</a></li><!-- 
	    	<li id="otherLi"><a >筛选</a></li> -->
	    </ul>
	    <div class="childStatus">
	    	<span class="little"></span>
	    	<ul id="childStatusUl">
	    		<li <c:if test='${orderStatus==SIGNED }'>class="active"</c:if>><a href="<%=request.getContextPath()%>/buyer/manageOrderList?orderStatus=${SIGNED }&keyword=${keyword}">已签收</a></li>
	    		<li <c:if test='${orderStatus==FINISHED }'>class="active"</c:if>><a href="<%=request.getContextPath()%>/buyer/manageOrderList?orderStatus=${FINISHED}&keyword=${keyword}">已完成</a></li>
	    		<li <c:if test='${orderStatus==CLOSED }'>class="active"</c:if>><a href="<%=request.getContextPath()%>/buyer/manageOrderList?orderStatus=${CLOSED}&keyword=${keyword}">已关闭</a></li>
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


<!-- 开始确认框 -->
<div class="confirmDiv" id="delete">
	<div class="confirmTop">
		<span>温馨提醒</span>
		<span id="closeConfirm"><i class="iconfont">&#xe632;</i></span>
	</div>
	<p>确定设为已付款？</p>
	<div class="confirmBottom">
		<span id="cancel">取消</span>
		<span id="confirm">确定</span>
	</div>
</div>
<!-- 结束确认框 -->
<!--[[底部-->
<jsp:include page="/jsp/buyer/footer.jsp"></jsp:include> 
<!--底部]]-->
<script>
	$(".childStatus").css("top",$(".title").height()+$(".searchDiv").height()+$(".allStatus").height()+5+parseInt($(".childStatus").css("top")));
	
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
			var url="<%=request.getContextPath()%>/buyer/manageOrderListAjax";
			var params={offset:offset,orderStatus:${orderStatus},keyword:"${keyword}"};
			doAjax("GET",url,params,loadSuccess,fail,true,false);
		}
		
		function loadSuccess(data){
			var orderList = data.data.list;
			var orderItemList;
			var html="";
			var productNumber;
			for(var i=0;i<orderList.length;i++){
				html+='<div class="shopOrder" data-id="'+orderList[i].orderForm.orderNumber+'">';
				html+='<div class="shopName">';
				html+='<a>订单号：'+orderList[i].orderForm.orderNumber+'</span></a>';
				html+='<span class="orderStatus">'+getStatus(orderList[i].orderForm)+'</span>';
				html+="</div>";
				html+='<div class="shopName">';
				html+='<a>买家：'+orderList[i].buyer.userNickname+'</span></a>';
				html+='';
				html+="</div>";
				orderItemList=orderList[i].orderItemList;
				productNumber=0;
				for(var j=0;j<orderItemList.length;j++){
					html+='<div class="commodity"><a href="<%=request.getContextPath()%>/product/productDetail?productId='+orderItemList[j].product.productId+'">';
					html+='<img src="'+changePath(orderItemList[j].product.cover1)+'"/></a>';
					html+='<div class="commDiv">';
					html+='<p><a href="<%=request.getContextPath()%>/product/productDetail?productId='+orderItemList[j].product.productId
							+'">'+orderItemList[j].product.productName+'</a></p><h4>￥'+getPrice(orderItemList[j].orderItem)+'</h4>';
					html+='<div class="moneyNum"><span><font>数量：</font>'
							+orderItemList[j].orderItem.orderItemNumber+'</span>';
					html+='</div></div></div>';
					productNumber+=orderItemList[j].orderItem.orderItemNumber;
				}	
				html+='<p class="allP">共<span>'+productNumber+'</span>件商品&nbsp;&nbsp; 合计:<span>'+orderList[i].orderForm.orderMoney+'元</span>　'+((orderList[i].orderForm.orderInstallMoney!=0)?'':'')+'</p>';
				html+='<div class="btnGroup">';
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
			switch(orderForm.orderStatus){
				case ${OBLIGATION}:
					return '<button class="bgcolorBtn payButton">设为已付款</button><button class="closeBtn">关闭订单</button><button class="detailBtn">查看详情</button>';
				case ${TO_BE_SHIPPED}:
					return '<button class="detailBtn">查看详情</button>';
				case ${TO_BE_SIGNED}:
					return '<button class="bgcolorBtn receiveBtn">收货</button>'+
							((orderForm.transportType!=1)?'<button class="logisticsBtn" data-companyCode="'+orderForm.logisticsCompanyCode+
							'" data-logisticsCode="'+orderForm.transportNumber+'" data-phoneNumber="'+orderForm.transportPhoneNumber+'">查看物流</button>':'')+'<button class="detailBtn">查看详情</button>';
				case ${SIGNED}:
					return ((orderForm.transportType!=1)?'<button class="logisticsBtn" data-companyCode="'+orderForm.logisticsCompanyCode+
						'" data-logisticsCode="'+orderForm.transportNumber+'" data-phoneNumber="'+orderForm.transportPhoneNumber+'">查看物流</button>':'')+'<button class="detailBtn">查看详情</button>';
				case ${FINISHED}:
					return ((orderForm.transportType!=1)?'<button class="logisticsBtn" data-companyCode="'+orderForm.logisticsCompanyCode+
							'" data-logisticsCode="'+orderForm.transportNumber+'" data-phoneNumber="'+orderForm.transportPhoneNumber+'">查看物流</button>':'')+'<button class="detailBtn">查看详情</button>';
				case ${CLOSED}:
					return '<button class="detailBtn">查看详情</button>';
			}
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
				case ${PENDING_SERVICE}:
					return "待服务";
				case ${SERVICED}:
					return "已服务";
				case ${FINISHED}:
					return "已完成";
				case ${CLOSED}:
					return "已关闭";
			}
		}
		
		function getPrice(orderItem){
			return (orderItem.orderItemPrice+orderItem.orderItemFreight+orderItem.orderItemCommision+orderItem.orderItemServiceFee+orderItem.woodenFee).toFixed(2);
		}
		
		function changePath(path){
			var i=path.lastIndexOf("/");
			return path.substring(0,i+1)+"thumbnailImage/"+path.substring(i+1);
		}
	});
	
	$(document).on("tap",".detailBtn",function(){
		window.location.href='<%=request.getContextPath()%>/buyer/orderDetail?orderNum='+$(this).parents(".shopOrder").attr("data-id");
	});
	
	$(document).on("tap",".closeBtn",function(){
		closeOrder($(this).parents(".shopOrder").attr("data-id"));
	});
	
	$(document).on("tap",".logisticsBtn",function(){
		window.location.href="<%=request.getContextPath()%>/user/consultLogistics?logisticsCompanyCode="+$(this).attr("data-companyCode")+
		"&logisticsCode="+$(this).attr("data-logisticsCode")+"&transportPhoneNumber="+$(this).attr("data-phoneNumber")+"&orderNum="+$(this).parents(".shopOrder").attr("data-id");
	});
	
	$(document).on("tap",".receiveBtn",function(){
		var url="<%=request.getContextPath()%>/buyer/toSignAjax";
		var params={orderNum:$(this).parents(".shopOrder").attr("data-id")};
		doAjax("GET",url,params,receiveSuccess,fail,true,false);
	});
	
	function receiveSuccess(data){
		<%-- window.location.href="<%=request.getContextPath()%>/buyer/orderManage?orderStatus=${SIGNED}"; --%>
		location.reload();
	}
	
	function closeOrder(orderNumber){
		var url="<%=request.getContextPath()%>/buyer/closeOrderAjax?orderNum="+orderNumber;
		var params={};
		doAjax("GET",url,params,closeSuccess,fail,true,false);
	}
	
	function closeSuccess(data){<%-- 
		window.location.href="<%=request.getContextPath()%>/buyer/orderManage?orderStatus=<%=OrderStatus.CLOSED%>"; --%>
		location.reload();
	}
	
	var orderNumber;
	$(document).on("tap",".payButton",function(){
		$("#delete").show();
		$(".shade").show();
		orderNumber=$(this).parents(".shopOrder").attr("data-id");
		//payOrder($(this).parents(".shopOrder").attr("data-id"));
	});
	
	$("#confirm").tap(function(){
		payOrder(orderNumber);
	})
	
	$("#cancel").tap(function(){
		$("#delete").hide();
		$(".shade").hide();
	})
	
	function payOrder(orderNumber){
		var url="<%=request.getContextPath()%>/buyer/setPayComplete?orderNum="+orderNumber;
		var params={orderNumber:orderNumber};
		doAjax("GET",url,params,function(data){location.reload();},fail,false,false);
	}
	
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
			        		$(".waiting").hide();
			        		$(".shade").hide();
			                // 支付成功后的回调函数
			            	if(res.errMsg=="chxooseWXPay:fail")
			                	alert("fail");
			               /*  if(res.errMsg=="chooseWXPay:cancel")
			                	alert("cancle"); */
			                if(res.errMsg=="chooseWXPay:ok"){
			                	window.location.href="<%=request.getContextPath()%>/buyer/manageOrderList?orderStatus=<%=OrderStatus.TO_BE_SHIPPED%>";
			                } 
			            }
			        }); 
			    });
			}
		}); // end ajax   
	}
	
	function toSign(orderNumber){
		var url="<%=request.getContextPath()%>/buyer/toSignAjax";
		var params={orderNum:orderNumber};
		doAjax("GET",url,params,toSignSuccess,fail,true,false);
	}
	
	function toSignSuccess(data){
		window.location.href="<%=request.getContextPath()%>/buyer/manageOrderList?orderStatus=<%=OrderStatus.SIGNED%>";
	}
	
	$(document).on("tap",".qqI",function(){
		window.location.href="http://wpa.qq.com/msgrd?v=3&uin="+$(this).attr("data-qqNumber")+"&site=qq&menu=yes";
	});
		
	$(document).on("tap",".phoneI",function(){
		window.location.href="tel:"+$(this).attr("data-phone");
	});
	
	$(".search").tap(function(){
		window.location.href="<%=request.getContextPath()%>/buyer/manageOrderList?orderStatus=${orderStatus}&keyword="
				+$("#keyword").val();
	});
	$(".prevPage").tap(function(){
		window.location.href="<%=request.getContextPath()%>/buyer/personCenter";
	});
</script>
</body>
</html>
