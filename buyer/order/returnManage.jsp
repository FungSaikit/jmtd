<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <meta charset="UTF-8">
    <title>金明同达灯饰</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/customer/assets/css/topbar_orange.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/customer/assets/css/search_bar_white.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/customer/assets/css/order_list.css">
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
    <a href="javascript:window.location.href='<%=request.getContextPath()%>/buyer/personCenter'"><img class="topbar_left" src="<%=request.getContextPath()%>/resources/customer/assets/images/top_bar/back_white.png" alt="返回"></a>
    <span class="topbar_middle">订单列表</span>
    <span class="topbar_right">&nbsp&nbsp&nbsp&nbsp&nbsp</span>
</div>

<div class="placeholder">
</div>

<div class="search">
    <div class="searchframe">
        <img class="search_icon" src="<%=request.getContextPath()%>/resources/customer/assets/images/search_bar/search_black.png" alt="搜索">
        <input class="search_input" type="text" value="${keyword}" placeholder="请输入你要查找的内容">
    </div>
</div>

<div class="selectOrder">
    <ul>
        <li class="select_li"><a class="select_a" get="0" href="<%=request.getContextPath()%>/buyer/orderManage?orderStatus=-1&keyword=${keyword}#selected_a" ${orderStatus==-1?'id="selected_a"':''} onclick="selectFunction(this)">全部</a></li>
        <li class="select_li"><a class="select_a" get="1" href="<%=request.getContextPath()%>/buyer/orderManage?orderStatus=${OBLIGATION}&keyword=${keyword}#selected_a" ${orderStatus==0?'id="selected_a"':''} onclick="selectFunction(this)">待付款</a></li>
        <li class="select_li"><a class="select_a" get="2" href="<%=request.getContextPath()%>/buyer/orderManage?orderStatus=${TO_BE_SHIPPED}&keyword=${keyword}#selected_a" ${orderStatus==1?'id="selected_a"':''} onclick="selectFunction(this)">待发货</a></li>
        <li class="select_li"><a class="select_a" get="3" href="<%=request.getContextPath()%>/buyer/orderManage?orderStatus=${TO_BE_SIGNED}&keyword=${keyword}#selected_a" ${orderStatus==2?'id="selected_a"':''} onclick="selectFunction(this)">待收货</a></li>
        <li class="select_li"><a class="select_a" get="4" href="<%=request.getContextPath()%>/buyer/orderManage?orderStatus=${SIGNED}&keyword=${keyword}#selected_a" ${orderStatus==3?'id="selected_a"':''} onclick="selectFunction(this)">已收货</a></li>
        <li class="select_li"><a class="select_a" get="5" href="<%=request.getContextPath()%>/buyer/orderManage?orderStatus=${FINISHED}&keyword=${keyword}#selected_a" ${orderStatus==4?'id="selected_a"':''} onclick="selectFunction(this)">已完成</a></li>
        <li class="select_li"><a class="select_a" get="6" href="<%=request.getContextPath()%>/buyer/orderManage?orderStatus=${CLOSED}&keyword=${keyword}#selected_a" ${orderStatus==5?'id="selected_a"':''} onclick="selectFunction(this)">已关闭</a></li>
        <li class="select_li"><a class="select_a" get="7" href="<%=request.getContextPath()%>/buyer/returnOrderManage?#selected_a" id="selected_a" onclick="selectFunction(this)">退款/退货</a></li>
    </ul>
</div>

<div class="orderlist">
    
	<div class="loading"></div>
</div>
<div class="noOrder">
	<img src="<%=request.getContextPath() %>/resources/customer/assets/images/noOrder.png"/>
	<p>您还没有相关订单</p>
</div>
</body>

<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
<script type="text/javascript">

    var selectOption = document.getElementsByClassName("select_a");
    var orderList = document.getElementsByClassName("orderlist")[0];
    var loading = document.getElementById("loading");
	
    
    function selectFunction(object) {
        /*切换标签*/
        for (var i = 0; i < selectOption.length; i++) {
            selectOption[i].id = "";
        }
        object.id = "selected_a";
        /*清空列表*/
        order_list.innerHTML = "";
    }
    
    function loadOrder(){
		var url="<%=request.getContextPath()%>/buyer/returnOrderListAjax";
		var params={offset:offset};
		doAjax("GET",url,params,loadSuccess,fail,true,false);
	}
	
	function loadSuccess(data){
		var orderList = data.data.list;
		var orderItemList;
		var html="";
		var productNumber;
		for(var i=0;i<orderList.length;i++){
			orderItemList=orderList[i].orderItemModel;
			html+='<div class="goods" data-id="'+orderList[i].returnRecord.returnInfoId+'">';
			html+='<div class="goodsnumber_div">';
			html+='<span class="goodsnumber">订单号：'+orderItemList.orderItem.orderNumber+'</span>';
			html+='</div>';
			html+='<div class="goodsinfo">';
			html+='<div class="goodspic">';
			html+='<img src="'+changePath(orderItemList.product.cover1)+'" alt="图片">';
			html+='</div>';
			html+='<div class="goodsdetail">';
			html+='<div class="goodstitle">';
			html+='<span class="goodstitle_span">'+orderItemList.product.productName+'</span>';
			html+='</div>';
			html+='<div class="goodsmodel">';
			html+='<span class="goodsmodel_span">型号:'+orderItemList.product.productCode+'</span>';
			html+='</div>';
			html+='<div class="goodsprice">';
			html+='<span class="goodsprice_span">￥'+getPrice(orderItemList.orderItem)+'</span>';
			html+='<span class="goodsnumber_span">数量：'+orderItemList.orderItem.orderItemNumber+'</span>';
			html+='</div>';
			html+='<div class="goodsservice">';
			html+=getStatus(orderList[i].orderItemModel.orderItem);
			html+='</div> </div> </div>';
			html+='<div class="goodsmenu">';
			html+='<a href="<%=request.getContextPath()%>/buyer/returnDetail?returnInfoId='+orderList[i].returnRecord.returnInfoId+'" class="roundbutton">查看详情</a>';
			html+=getButton(orderItemList);
			html+='</div></div>';
		}
		//$(".orderlist").append(html);
		//load.css("visibility","hidden");
		$(html).insertBefore(".loading");
		if((parseInt(offset)+10)>=data.data.count){
			noDate=true;
		}
		
		offset=data.data.after;
		canLoad=true;
		if(data.data.count==0){
			$(".noOrder").show();
		}
	}
	
	var offset=0;
	var canLoad=true;
	var noDate=false;
	$(function(){
		loadOrder();
		//开始加载中
		var wiwH=$(window).height();
		var load=$(".loading");
		var time; 
		$(document).scroll(function(){
			 if(load.offset().top - $(window).scrollTop()<wiwH+10){
				if(canLoad&&!noDate){
	   				load.css("visibility","visible");
					canLoad=false;
					loadOrder();
				}
				if(noDate){/* 
	   				load.html("暂无更多订单"); */
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
	});
	
	//更改图片路径，读取缩略图
    function changePath(path){
		var i=path.lastIndexOf("/");
		return path.substring(0,i+1)+"thumbnailImage/"+path.substring(i+1);
	}
	
    function getPrice(orderItem){
		return (orderItem.orderItemPrice+orderItem.orderItemFreight+orderItem.orderItemCommision+orderItem.orderItemServiceFee+orderItem.woodenFee).toFixed(2);
	}
    
    function getButton(orderItem){
		var btnStr='';
		switch(orderItem.returnStatus){
			case ${RETURN_AGREE}:
				btnStr += '<button class="bgcolorBtn toSend">发货</button>';
				break;
		}
		return btnStr;
	}
    
    function getStatus(orderItem){
		switch(orderItem.returnStatus){
			case ${RETURN_APPLYING}:
				return "退货申请中";
			case ${RETURN_FAILURE}:
				return "退货失败";
			case ${RETURN_AGREE}:
				return "买家待发货";
			case ${SIGNED}:
				return "已收货";
			case ${WAITTING_SELLER_SIGNED}:
				return "卖家待收货";
			case ${RETURN_SUCCESS}:
				return "退货成功";
		}
		
		switch(orderItem.refundStatus){
			case ${REFUND_APPLYING}:
				return "退款申请中";
			case ${REFUND_FAILURE}:
				return "退款失败";
			case ${REFUND_SUCCESS}:
				return "退款成功";
		}
	}
    
    $(".search_icon").click(function(){
    	window.location.href="<%=request.getContextPath()%>/buyer/orderManage?orderStatus=${orderStatus}&keyword="+$(".search_input").val();
    })
    
    function payOrder(orderNumber){
		var url="<%=request.getContextPath()%>/buyer/payOrder?orderNum="+orderNumber;
		var params={};
		doAjax("GET",url,params,payOrderSuccess,fail,false,false);
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
			                	window.location.href="<%=request.getContextPath()%>/buyer/orderManage?orderStatus=<%=OrderStatus.TO_BE_SHIPPED%>";
			                } 
			            }
			        }); 
			    });
			}
		}); // end ajax   
	}
	
	//确认收货
	function toSign(orderNumber){
		var url="<%=request.getContextPath()%>/buyer/toSignAjax";
		var params={orderNum:orderNumber};
		doAjax("GET",url,params,toSignSuccess,fail,true,false);
	}
	
	function toSignSuccess(data){
		window.location.href="<%=request.getContextPath()%>/buyer/orderManage?orderStatus=<%=OrderStatus.SIGNED%>";
	}
	
	function toAfterSale(orderItemId,orderNumber){
		window.location.href="<%=request.getContextPath()%>/buyer/toApplyAfterSale?orderItemId="
				+orderItemId+"&orderNumber="+orderNumber;
	}
	
	function fail(data){
		console.log(data);
	}
	
</script>

</html>