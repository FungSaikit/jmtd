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
    <link href="<%=request.getContextPath() %>/resources/factory/assets/css/order.css" rel="stylesheet">
    <style>
    	.orderBottom {
		    position: fixed;
		    bottom: 0px;
		    left: 0px;
		    width: 100%;
		    height: 1.5rem;
		    line-height: 1.5rem;
		    box-sizing: border-box;
		    border-top: 1px solid #f3f3f3;
		    background-color: #fff;
		    z-index: 2;
		    font-size: .6rem;
		    font-family: "微软雅黑";
		}
		
		.orderBottom .submit {
		    text-align: center;
		    padding: .1rem;
		    background-color: red;
		    width: 60%;
		    margin: 0 auto;
		    border-radius: .2rem;
		}
    </style>
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
</head>
<body>
<div class="orderStock">
    <div class="title">库存管理</div>
    <div class="stockInfo">
    	<div class="loading" style="visibility: visible;"><i class="iconfont">&#xe62c;</i><span id="jiazai">加载中...</span></div>
    </div>
    <form action="<%=request.getContextPath()%>/factory/inputOrderStation">
    	<input type="hidden" name="idList"/>
	   	<input type="hidden" value="${orderItem.orderItem.orderItemNumber }" name="haveGoodsNums"/>
	   	<input type="hidden" value="1" name="consignmentTimes"/>
	   	<input type="hidden" value="${orderStockStatus}" name="orderStockStatus"/>
    </form>
	<div class="noOrder">
		<span><i class="iconfont">&#xe664;</i></span>
		<p>您还没有相关订单</p>
	</div><!-- 
    <div class="loading" style="visibility: visible;"><i class="iconfont">&#xe62c;</i><span id="jiazai">加载中...</span></div> -->
    <!-- 分页]]-->
</div>
<div class="tip"></div>
<!--[[底部-->
<!--底部]]-->

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
<div class="orderBottom">
	<div class="submit submitOrderItem"><a>发货</a></div>
</div>

<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/swiper.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/jweixin-1.0.0.js"></script>
<script>

	$(document).on("tap",".checkBox",function(){
		if($(this).hasClass("active")){
			$(this).removeClass("active");
		}else{
			$(this).addClass("active");
		}
	});
	$("#statusUl li").tap(function(){
		$("#statusUl li").removeClass("active");
		$(this).addClass("active");
	});
	function showTip(str){
		$(".tip").html(str);
		$(".tip").css("opacity",1);
		setTimeout(function(){
			$(".tip").html("");
			$(".tip").css("opacity",0);
		},1000);
	}
	
	var offset=0;
	function loadOrder(){
		var url="<%=request.getContextPath()%>/buyer/prepareReceiveUserDetailAjax";
		var params={offset:offset,buyerId:${buyerId},sellerId:${sellerId}};
		doAjax("GET",url,params,loadSuccess,fail,true,false);
	}
	
	function loadSuccess(data){
		var ofList = data.data.list;
		var html="";
		for(var i=0;i<ofList.length;i++){
			html+='<div class="orderStock">';
			html+='<div class="orderStockHead">';
			html+='<p>物流公司：'+ofList[i].orderForm.recommendLogistics+'</p>';
			html+='</div><div class="orderStockBody">';
			var orderItemList = ofList[i].orderItemList;
			for(var j=0;j<orderItemList.length;j++){
				html+='<div class="stock">';
				html+='<div class="order">';
				html+='<div class="fl">型号：'+orderItemList[j].product.productCode+'</div>';
				html+='<div class="fr" >'+(orderItemList[j].orderItem.orderItemNumber-
						orderItemList[j].orderItem.perpareSendNumber-orderItemList[j].orderItem.sendNumber-orderItemList[j].orderItem.stockedNumber)+'</div></div>';
				/* html+='<div class="stockNum"><div><label>现货：</label>';
				html+='<div>';
				html+=(orderItemList[j].orderItem.haveGoodsNum==null)?'':orderItemList[j].orderItem.haveGoodsNum;
		   		html+='</div><span>个</span></div>';
		   		html+='</div><div class="stockNum"><div>';
		   		html+='<label>货期：</label><div>';
		   		html+=(orderItemList[j].orderItem.consignmentTime==null)?'':orderItemList[j].orderItem.consignmentTime;
		   		html+='</div>';
		   		html+='<span>天</span></div></div>'; 
		   		html+='<div class="stockNum">';
   				html+='<label>急单：'+((orderItemList[j].orderItem.isRushOrder==null)?'否':'急单')+'</label>';*/
   				html+='';
				html+='</div>';
   				
   				if(j==orderItemList.length-1){
   			   		html+='<div class="stock"><div class="order">';
   			   		html+='<div class="fl">客户名称：'+ofList[i].orderForm.receivePerson+'</div>';
	   				html+='</div></div>';

   			   		html+='<div class="stock"><div class="order">';
   			   		html+='<div class="fl">下单时间：'+showDate(ofList[i].orderForm.payTime)+'</div>';
	   				html+='</div></div>';
	   				
	   				html+='<div class="stock"><div class="order">';
   			   		html+='<div class="fl">业务员：'+ofList[i].service.legalPersonName+'</div>';
   			   		html+='<div class="fr"><div class="checkBox" data-id="'+ofList[i].orderForm.orderNumber+'"><span class="iconfont">&#xe611;</span></div></div>';
	   				html+='</div></div>';
   				}
			}
			
			html+='</div></div>';
		}
		$(html).insertBefore(".loading");
		load.css("visibility","hidden");

		if(parseInt(offset+10)>=data.data.count){
			noDate=true;
		}
		offset=data.data.after;
		canLoad=true;
	}
	
	function fail(data){
		alert("fail");
	}
	
	var canLoad=true;
	var noDate=false;
	var load=$(".loading");
	$(function(){
		var wiwH=$(window).height();
		var time;
		loadOrder();
		$(window).scroll(function(){
			console.log(load.offset().top+","+$(window).scrollTop()+","+wiwH);
			if(load.offset().top - $(window).scrollTop()<wiwH){
				if(canLoad&&!noDate){
    				load.css("visibility","visible");
					canLoad=false;
					loadOrder();
				}
				if(noDate){
    				load.html("暂无更多数据");
    				load.css("visibility","visible");
				}
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
	
	function showDate(str){
		var date = new Date(str);
		return date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate()+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds();
	}
	
	$(document).on("tap",".submitOrderItem",function(){
		var dataId="";
		$(".checkBox").each(function(){
			if($(this).hasClass("active")){		
				dataId+=$(this).attr("data-id")+",";
			}
		});
		dataId=dataId.substring(0, dataId.length-1);
		window.location.href="<%=request.getContextPath()%>/buyer/toSendLogistics?orderNumber="
				+dataId;
	});
	
</script>
</body>
</html>
