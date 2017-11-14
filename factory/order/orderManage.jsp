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
    <link href="<%=request.getContextPath() %>/resources/factory/assets/css/order.css?221" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
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
    <div class="title">订单管理</div>
    <div class="allStatus">
    	<ul id="statusUl">
	    	<li <c:if test='${orderStatus==OBLIGATION }'>class="active"</c:if>><a href="<%=request.getContextPath()%>/factory/orderManage?orderStatus=${OBLIGATION}">待付款</a></li>
	    	<li <c:if test='${orderStatus==TO_BE_SHIPPED }'>class="active"</c:if>><a href="<%=request.getContextPath()%>/factory/orderManage?orderStatus=${TO_BE_SHIPPED}">待发货</a></li>
	    	<li <c:if test='${orderStatus==TO_BE_SIGNED }'>class="active"</c:if>><a href="<%=request.getContextPath()%>/factory/orderManage?orderStatus=${TO_BE_SIGNED}">待收货</a></li>
	    	<li ><a href="<%=request.getContextPath()%>/factory/returnOrderManage">退款/货</a></li>
	    	<li id="otherLi"><a href="#">其他</a></li>
	    </ul>
	    <div class="childStatus">
	    	<span class="little"></span>
	    	<ul id="childStatusUl">
	    		<li <c:if test='${orderStatus==SIGNED }'>class="active"</c:if>><a href="<%=request.getContextPath()%>/factory/orderManage?orderStatus=${SIGNED }">已签收</a></li>
	    		<li ><a href="<%=request.getContextPath()%>/factory/serviceOrderManage?orderServiceStatus=${PENDING_SERVICE }">待服务</a></li>
	    		<li ><a href="<%=request.getContextPath()%>/factory/serviceOrderManage?orderServiceStatus=${SERVICED }">已服务</a></li>
	    		<li <c:if test='${orderStatus==FINISHED }'>class="active"</c:if>><a href="<%=request.getContextPath()%>/factory/orderManage?orderStatus=${FINISHED}">已完成</a></li>
	    		<li <c:if test='${orderStatus==CLOSED }'>class="active"</c:if>><a href="<%=request.getContextPath()%>/factory/orderManage?orderStatus=${CLOSED}">已关闭</a></li>
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
<div class="sendLogistics">
	<!-- <div class="sendTop">
		<div class="sendTopBack">
			<i class="iconfont">&#xe624;</i>
			<span>返回</span>
		</div>
		<button class="otherL otherBtn">其他</button>
	</div>
	<ul id="sendToUl">
	</ul>
	<div id="otherLogistics" class="otherBtn">其他</div> -->
	
	<div class="sendToDiv">
		<div class="sendToDivTop">
			<span>输入物流信息</span>
			<span id="closeSendToDiv"><i class="iconfont">&#xe632;</i></span>
		</div>
		<div class="logisticsInfo">
			<select id="logisticsSelect">
				<c:forEach items="${logisticsList }" var="logistics">
					<option value="${logistics.userLogisticsId}" data-phone="${logistics.logisticsPhoneNumber }">${logistics.logisticsCompanyName}</option>
				</c:forEach>
				<option value="otherLogistics">其他</option>
			</select>
			<input type="text" placeHolder="请输入物流公司的名字" id="otherInput" <c:if test="${logisticsList.size()==0 }">style="display:block"</c:if>/>
			<input type="text" placeHolder="请输入物流公司电话号码" id="transportPhone" <c:if test="${logisticsList.size()!=0 }">value="${logisticsList[0].logisticsPhoneNumber }"</c:if>/>
			<input type="text" placeHolder="请输入物流编号" id="transportNumber"/>
		</div>
		<div class="sendToDivBottom">
			<span id="cancel">取消</span>
			<span id="sendTo">发货</span>
		</div>
	</div>
	<div class="shade"></div>
	<div class="tip"></div>
</div>

<!--[[底部-->
<jsp:include page="/jsp/factory/footer.jsp"></jsp:include>
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
			var url="<%=request.getContextPath()%>/factory/orderListAjax";
			var params={offset:offset,orderStatus:${orderStatus}};
			doAjax("GET",url,params,loadSuccess,fail,true,false);
		}
		
		function loadSuccess(data){
			var orderList = data.data.list;
			var orderItemList;
			var html="";
			var productNumber;
			var orderMoney;
			for(var i=0;i<orderList.length;i++){
				html+='<div class="shopOrder" data-id="'+orderList[i].orderForm.orderNumber+'"><div class="shopName">';
				if(orderList[i].orderForm.toPlatform==null||orderList[i].orderForm.toPlatform==0){
					html+='<a><span><i class="iconfont">&#xe600;</i>'+orderList[i].buyer.userNickname+'</span></a>';
					html+=((orderList[i].buyer.phoneNumber!=null)?'<i class="iconfont contactI phoneI" data-phone="'+orderList[i].buyer.phoneNumber+'">&#xe609;</i>':'');
					html+=((orderList[i].buyer.qqNumber!=null)?'<i class="iconfont contactI qqI" data-qqNumber="'+orderList[i].buyer.qqNumber+'">&#xe607;</i>':'');
				}else{
					html+='<a><span><i class="iconfont">&#xe600;</i>尚帅</span></a>';
				}
				html+="</div>";
				orderItemList=orderList[i].orderItemList;
				productNumber=0;orderMoney=0;
				for(var j=0;j<orderItemList.length;j++){
					if(${orderStatus}==1&&(((orderList[i].orderForm.toPlatform==null||orderList[i].orderForm.toPlatform==0)&&
							(orderItemList[j].orderItem.sendFlag==null||orderItemList[j].orderItem.sendFlag==0||orderItemList[j].orderItem.sendFlag==1))
							||(orderList[i].orderForm.toPlatform!=null&&(orderItemList[j].orderItem.factorySendFlag==null||orderItemList[j].orderItem.factorySendFlag==0||orderItemList[j].orderItem.factorySendFlag==1)&&
									(orderItemList[j].orderItem.receiveFlag==null||orderItemList[j].orderItem.receiveFlag==0||orderItemList[j].orderItem.receiveFlag==1)))){
						html+='<div class="commodity"><a href="javascript:void()">';
						html+='<img src="'+changePath(orderItemList[j].product.cover1)+'"/></a>';
						html+='<div class="commDiv">';
						html+='<p><a href="javascript:void()'
								+'">'+orderItemList[j].orderItem.productName+'</a></p>';
						html+='<div class="moneyNum"><h4>￥'+getPrice(orderItemList[j].orderItem,orderList[i].orderForm)+'</h4><span><font>X</font>'
								+(orderItemList[j].orderItem.orderItemNumber-(orderList[i].orderForm.toPlatform!=null?(orderItemList[j].orderItem.factorySendNumber==null?orderItemList[j].orderItem.receiveNumber:parseInt(orderItemList[j].orderItem.factorySendNumber)):(orderItemList[j].orderItem.receiveNumber==null?0:parseInt(orderItemList[j].orderItem.receiveNumber))))+'</span>';
						html+='</div></div></div>';
						productNumber+=orderItemList[j].orderItem.orderItemNumber;
						orderMoney+=parseFloat(getPrice(orderItemList[j].orderItem,orderList[i].orderForm))*orderItemList[j].orderItem.orderItemNumber;
					}else{
						if(${orderStatus}==2&&((
								(orderItemList[j].orderItem.sendFlag==1||orderItemList[j].orderItem.sendFlag==2))||
								(orderItemList[j].orderItem.factorySendFlag==1||orderItemList[j].orderItem.factorySendFlag==2)||
								(orderItemList[j].orderItem.receiveFlag==1||orderItemList[j].orderItem.receiveFlag==2))){
							
							html+='<div class="commodity"><a href="javascript:void()">';
							html+='<img src="'+changePath(orderItemList[j].product.cover1)+'"/></a>';
							html+='<div class="commDiv">';
							html+='<p><a href="javascript:void()'
									+'">'+orderItemList[j].orderItem.productName+'</a></p>';
							html+='<div class="moneyNum"><h4>￥'+getPrice(orderItemList[j].orderItem,orderList[i].orderForm)+'</h4><span><font>X</font>'
									+(orderList[i].orderForm.toPlatform!=null?(orderItemList[j].orderItem.factorySendNumber==null?(orderItemList[j].orderItem.receiveNumber==null?orderItemList[j].orderItem.sendNumber:orderItemList[j].orderItem.receiveNumber):orderItemList[j].orderItem.factorySendNumber):(orderItemList[j].orderItem.receiveNumber==null?orderItemList[j].orderItem.sendNumber:orderItemList[j].orderItem.receiveNumber))+'</span>';
							html+='</div></div></div>';
							productNumber+=orderItemList[j].orderItem.orderItemNumber;
							orderMoney+=parseFloat(getPrice(orderItemList[j].orderItem,orderList[i].orderForm))*orderItemList[j].orderItem.orderItemNumber;
						}else{
							if(${orderStatus}!=1&&${orderStatus}!=2){
								html+='<div class="commodity"><a href="javascript:void()">';
								html+='<img src="'+changePath(orderItemList[j].product.cover1)+'"/></a>';
								html+='<div class="commDiv">';
								html+='<p><a href="javascript:void()'
										+'">'+orderItemList[j].orderItem.productName+'</a></p>';
								html+='<div class="moneyNum"><h4>￥'+getPrice(orderItemList[j].orderItem,orderList[i].orderForm)+'</h4><span><font>X</font>'
										+orderItemList[j].orderItem.orderItemNumber+'</span>';
								html+='</div></div></div>';
								productNumber+=orderItemList[j].orderItem.orderItemNumber;
								orderMoney+=parseFloat(getPrice(orderItemList[j].orderItem,orderList[i].orderForm))*orderItemList[j].orderItem.orderItemNumber;
							}
						}
					}
				}	
				html+='<p class="allP">商品合计:<span>￥'+orderMoney.toFixed(2)+'</span>(共<span>'+productNumber+'</span>件)　安装费合计:<span>￥</span></p>';
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
			switch(orderForm.orderStatus){
				case ${TO_BE_SHIPPED}:
					if((orderForm.toPlatform==null||orderForm.toPlatform==0)&&orderForm.refundReturnPendingNum==0){
						btnStr+='<button class="bgcolorBtn toSend" data-tranType="'+orderForm.transportType+'">发货</button>';
					}else{
						if(orderForm.refundReturnPendingNum==0&&(orderForm.factorySendFlag==0||orderForm.factorySendFlag==1))
							btnStr+='<button class="bgcolorBtn factorySend" data-tranType="'+orderForm.transportType+'">发货</button>';
					}
					break;
				case ${TO_BE_SIGNED}:
					if(orderForm.toPlatform==null||orderForm.toPlatform==0){
						btnStr+=((orderForm.transportType!=1)?'<button class="logisticsBtn" data-companyCode="'+orderForm.logisticsCompanyCode+
								'" data-logisticsCode="'+orderForm.transportNumber+'" data-phoneNumber="'+orderForm.transportPhoneNumber+'">查看物流</button>':'');
					}
					break;
				case ${SIGNED}:
					if(orderForm.toPlatform==null||orderForm.toPlatform==0){
						btnStr+=((orderForm.transportType!=1)?'<button class="logisticsBtn" data-companyCode="'+orderForm.logisticsCompanyCode+
							'" data-logisticsCode="'+orderForm.transportNumber+'" data-phoneNumber="'+orderForm.transportPhoneNumber+'">查看物流</button>':'');
					}
					break;
				case ${FINISHED}:
					if(orderForm.toPlatform==null||orderForm.toPlatform==0){
						btnStr+=((orderForm.transportType!=1)?'<button class="logisticsBtn" data-companyCode="'+orderForm.logisticsCompanyCode+
							'" data-logisticsCode="'+orderForm.transportNumber+'" data-phoneNumber="'+orderForm.transportPhoneNumber+'">查看物流</button>':'');
					}
					break;
			}
			btnStr+='<button class="detailBtn">查看详情</button>';
			return btnStr;
		}
		
		$(document).on("tap",".logisticsBtn",function(){
			window.location.href="<%=request.getContextPath()%>/user/consultLogistics?logisticsCompanyCode="+$(this).attr("data-companyCode")+
			"&logisticsCode="+$(this).attr("data-logisticsCode")+"&transportPhoneNumber="+$(this).attr("data-phoneNumber");
		});
		
		function getStatus(orderForm){
			switch(orderForm.orderStatus){
				case ${OBLIGATION}:
					return "待付款";
				case ${TO_BE_SHIPPED}:
					if(orderForm.factorySendFlag==0)
						return "待发货";
					else
						return "待收货";
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
		
		function getPrice(orderItem,orderForm){
			if(orderForm.toPlatform==null||orderForm.toPlatform==0){
				if(orderItem.orderItemOriginPrice==null)
					return (orderItem.orderItemPrice+orderItem.orderItemFreight).toFixed(2);
				else
					return (orderItem.orderItemOriginPrice+orderItem.orderItemFreight).toFixed(2);
			}else{
				if(orderItem.orderItemOriginPrice==null)
					return (orderItem.orderItemPrice).toFixed(2);
				else
					return (orderItem.orderItemOriginPrice).toFixed(2);
			}
		}
		
		function changePath(path){
			var i=path.lastIndexOf("/");
			return path.substring(0,i+1)+"thumbnailImage/"+path.substring(i+1);
		}
	});
	
	$(document).on("tap",".toSend",function(){
		orderNum=$(this).parents(".shopOrder").attr("data-id");
		window.location.href="<%=request.getContextPath()%>/factory/chooseSendProduct?orderNumber="+orderNum;
		/*if($(this).attr("data-trantype")=="1"){
			var url="<%=request.getContextPath()%>/factory/deliveryAjax";
			var params={orderNum:orderNum};
			doAjax("GET",url,params,sendSuccess,fail,true,false);
		}else{
			$(".sendLogistics").show();
			//getLogisticsCompanyList();
		} */
		
	});
	
	<%--//开始物流信息
	$(".toSend").tap(function(){
		if(${orderForm.transportType!=1})
			$(".sendLogistics").show();
		else
			window.location.href="<%=request.getContextPath()%>/factory/delivery?orderNum=${orderForm.orderNumber}";
	}); --%>
	//发货
	var orderNum;
	var logisticsCompanyCode;
	$("#sendTo").tap(function(){
		if($("#logisticsSelect").val()=="otherLogistics"){
			if($("#otherInput").val().trim()==""){
				showTip("请输入物流公司名称！");
			}
		}
		if($("#transportPhone").val().trim()==""){
			showTip("请输入物流公司电话！");
		}else if($("#transportNumber").val().trim()==""){
			showTip("请输入物流编号！");
		}else{
			var url="<%=request.getContextPath()%>/factory/deliveryAjax?transportPhoneNumber="+$("#transportPhone").val();
			var params;
			if(logisticsCompanyCode==null)
				params={logisticsCompanyCode:$("#otherInput").val(),logisticsCode:$("#transportNumber").val(),
					orderNum:orderNum,logisticsSelect:$("#logisticsSelect").val()};
			else
				params={logisticsCompanyCode:logisticsCompanyCode,logisticsCode:$("#transportNumber").val(),
					orderNum:orderNum,logisticsSelect:$("#logisticsSelect").val()};
			doAjax("GET",url,params,sendSuccess,fail,true,false);
		}
	});

	function showTip(str){
		$(".tip").html(str);
		$(".tip").css("opacity",1);
		setTimeout(function(){
			$(".tip").html("");
			$(".tip").css("opacity",0);
		},1000);
	}
	
	function sendSuccess(data){
		window.location.href="<%=request.getContextPath()%>/factory/orderManage?orderStatus=${TO_BE_SIGNED}";
	}
	
	$("#closeSendToDiv,#cancel,.shade").on("tap",function(){
		$(".sendLogistics").hide();
	});
	$("#logisticsSelect").change(function(){
		if($(this).val()=="otherLogistics"){
			$("#otherInput").css("display","block");
			$("#transportPhone").val("");
		}else{
			$("#otherInput").css("display","none");
			$("#transportPhone").val($('#logisticsSelect').find('option').not(function(){ return !this.selected }).attr("data-phone"));
		}
	});
	/*$(document).on("tap","#sendToUl li:not(.firstWord)",function(){
		$("#sendToUl li").removeClass("active");
		$("#otherLogistics").removeClass("active");
		$(this).addClass("active");
		$(".sendToDiv").show();
		$(".shade").show();
		$("#logisticsCompany").html($(this).html().split("【")[0]);
		$("#transportPhone").val($(this).html().split("【")[1].split("】")[0]);
		$("#otherInput").hide();
		$("#companySpan").show();
		logisticsCompanyCode=$(this).attr("data-code");
	});
	
	$(document).on("tap",".otherBtn",function(){
		$(".sendToDiv").show();
		$(".shade").show();
		$("#otherInput").show();
		$("#companySpan").hide();
		$("#sendToUl li").removeClass("active");
		$("#otherLogistics").addClass("active");
		logisticsCompanyCode=null;
	});
	
	$(".sendTopBack").tap(function(){
		$(".sendLogistics").hide();
		$("footer").show();
	});*/
	
	
	$(document).on("tap",".detailBtn",function(){
		window.location.href='<%=request.getContextPath()%>/factory/orderDetail?orderNum='+$(this).parents(".shopOrder").attr("data-id");
	});
	
	//查询物流公司
	/*function getLogisticsCompanyList(){
		var url="<%=request.getContextPath()%>/user/getLogisticsCompanyList";
		var params={};
		doAjax("GET",url,params,getSuccess,fail,true,false);
	}
	
	function getSuccess(data){
		var lcList=data.data;
		var prevChar="0";
		var html="";
		for(var i=0;i<lcList.length;i++){
			if(prevChar!=lcList[i].logisticsFirstChar){
				html+='<li class="firstWord">'+lcList[i].logisticsFirstChar+'</li>';
				prevChar=lcList[i].logisticsFirstChar;
			}
			html+='<li data-code="'+lcList[i].logisticsCompanyCode+'"><span>'+lcList[i].logisticsCompanyName+'</span><span>'
					+(lcList[i].logisticsPhoneNumber!=null?'【'+lcList[i].logisticsPhoneNumber+'】':'')+'</span></li>';
		}
		$("#sendToUl").html(html);
	}*/
	
	function fail(){
		alert("fail");
	}
	
	$(document).on("tap",".qqI",function(){
		window.location.href="http://wpa.qq.com/msgrd?v=3&uin="+$(this).attr("data-qqNumber")+"&site=qq&menu=yes";
	});
	
	$(document).on("tap",".phoneI",function(){
		window.location.href="tel:"+$(this).attr("data-phone");
	});
	
	$(document).on("tap",".factorySend",function(){
		orderNum=$(this).parents(".shopOrder").attr("data-id");
		/*var url="<%=request.getContextPath()%>/factory/factorySend";
		var params={orderNumber:orderNum};
		doAjax("GET",url,params,factorySendSuccess,fail,true,false);*/
		window.location.href="<%=request.getContextPath()%>/factory/chooseSendProduct?orderNumber="+orderNum
	});
	
	function factorySendSuccess(data){
		location.reload();
	}
</script>
</body>
</html>
