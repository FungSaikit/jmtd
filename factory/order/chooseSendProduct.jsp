<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib prefix="thumbnail" uri="/WEB-INF/tld/thumbnailTag.tld"%>
<%@ taglib prefix="ppt" uri="/WEB-INF/tld/productPriceTag.tld"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>佐为照明</title>
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/factory/assets/css/order.css" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
</head>
<body>
<c:set var="SALES_SORT" value="<%=ProductSortType.SALES_SORT%>" />
<c:set var="NEW_SORT" value="<%=ProductSortType.NEW_SORT%>" />
<c:set var="PRICE_SORT" value="<%=ProductSortType.PRICE_SORT%>" />
<c:set var="CUSTOMER" value="<%=UserType.CUSTOMER%>" />
<c:set var="AUTHENTICATION_SUCCESS" value="<%=UserCheckStatus.AUTHENTICATION_SUCCESS%>" />
<div class="cart">
    <div class="title"><i class="iconfont prevPage" >&#xe624;</i>购物车</div>
    <div class="allShop">
    	<div class="oneShop">
    		<div class="shopName">
	    		<span class="shopI"><span class="radius "><i class="iconfont">&#xe611;</i></span></span>
	    		<a><i class="iconfont">&#xe606;</i></a>
	    		<i class="iconfont show">&#xe624;</i>
	    	</div>
	    	<c:forEach items="${orderItemList}" var="orderItem">
	    	<c:if test="${empty orderForm.toPlatform }">
	    	<c:if test="${empty orderItem.orderItem.sendFlag||orderItem.orderItem.sendFlag==0||orderItem.orderItem.sendFlag==1 }">
    		<div class="commodity" data-id="${orderItem.orderItem.orderItemId}">
    			<span class="oneI"><span class="radius "><i class="iconfont">&#xe611;</i></span></span>
    			<img src="<thumbnail:date value="${orderItem.product.cover1}"/>"/>
    			<div class="cartLeft">
    				<p><a href="<%=request.getContextPath()%>/product/productDetail?productId=${orderItem.product.productId}">${orderItem.product.productName}</a></p>
    				<div class="numDiv">
    					<span class="change-num reduce">-</span>
							<input class="num" type="tel" value="${orderItem.orderItem.orderItemNumber-orderItem.orderItem.sendNumber}" maxData="${orderItem.orderItem.orderItemNumber-orderItem.orderItem.sendNumber}" />
						<span class="change-num increase">+</span>
    				</div>
    			</div>
    			<div class="cartRight">
    				<h4>￥${orderItem.orderItem.orderItemOriginPrice}</h4>
    			</div>
    		</div>
    		</c:if>
    		</c:if>
    		<c:if test="${!empty orderForm.toPlatform }">
	    	<c:if test="${empty orderItem.orderItem.factorySendFlag||orderItem.orderItem.factorySendFlag==0||orderItem.orderItem.factorySendFlag==1 }">
    		<div class="commodity" data-id="${orderItem.orderItem.orderItemId}">
    			<span class="oneI"><span class="radius "><i class="iconfont">&#xe611;</i></span></span>
    			<img src="<thumbnail:date value="${orderItem.product.cover1}"/>"/>
    			<div class="cartLeft">
    				<p><a href="<%=request.getContextPath()%>/product/productDetail?productId=${orderItem.product.productId}">${orderItem.product.productName}</a></p>
    				<div class="numDiv">
    					<span class="change-num reduce">-</span>
							<input class="num" type="tel" value="${orderItem.orderItem.orderItemNumber-(empty orderItem.orderItem.factorySendNumber?orderItem.orderItem.receiveNumber:orderItem.orderItem.factorySendNumber)}" maxData="${orderItem.orderItem.orderItemNumber-orderItem.orderItem.factorySendNumber}" />
						<span class="change-num increase">+</span>
    				</div>
    			</div>
    			<div class="cartRight">
    				<h4>￥${orderItem.orderItem.orderItemOriginPrice}</h4>
    			</div>
    		</div>
    		</c:if>
    		</c:if>
    		</c:forEach>
    	</div>
    </div>
    <div class="cartBottom">
    	<div class="chooseAll active">
    		<span class="radius"><i class="iconfont">&#xe611;</i></span>
    		<span>全选</span>
    	</div>
    	<div class="payDiv">
    		<span></span>
    		<button class="payButtom">发货</button>
    	</div>
    </div>

</div>
<!--提示框 -->
<div class="tip"></div>
<!-- 开始确认框 -->
<div class="confirmDiv" id="delete">
	<div class="confirmTop">
		<span>温馨提醒</span>
		<span id="closeConfirm"><i class="iconfont">&#xe632;</i></span>
	</div>
	<p>确定删除？</p>
	<div class="confirmBottom">
		<span id="cancel">取消</span>
		<span id="confirm">确定</span>
	</div>
</div>
<!-- 结束确认框 -->
<!-- 遮罩层 -->
<div class="shade"></div>
<!-- 提示文字 -->
<div class="tip"></div>

<div class="sendLogistics">
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

<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
<script>
$(this).addClass("active");
$(".shopName").addClass("active");
$(".commodity").addClass("active");
	
	//开始选择操作
	$(document).on("tap",".shopI",function(){
		var dot=$(this).parent();
		
		if(dot.hasClass("active")){
			$(".chooseAll").removeClass("active");	
			dot.removeClass("active");
			dot.parent().find(".commodity").removeClass("active");
			
		}else{
			dot.addClass("active");
			dot.parent().find(".commodity").addClass("active");
			
			var flag=true;
			$(".shopName").each(function(){
				if(!$(this).hasClass("active")){
					flag=false;
					return false;
				}
			});
			if(flag){
				$(".chooseAll").addClass("active");
			}
		}
	});
	$(document).on("tap",".oneI",function(){
		var dot=$(this).parent();
		if(dot.hasClass("active")){
			dot.removeClass("active");
			dot.parent().find(".shopName").removeClass("active");
			$(".chooseAll").removeClass("active");
		}else{
			dot.addClass("active");
			var flag=true;
			dot.parent().find(".commodity").each(function(){
				if(!$(this).hasClass("active")){
					flag=false;
					return false;
				}
			});
			if(flag){
				dot.parent().find(".shopName").addClass("active");
				var flag1=true;
				$(".shopName").each(function(){
					if(!$(this).hasClass("active")){
						flag1=false;
						return false;
					}
				});
				if(flag1){
					$(".chooseAll").addClass("active");
				}
			}
		}
	});
	$(".chooseAll").tap(function(){
		if($(this).hasClass("active")){
			$(this).removeClass("active");
			$(".shopName").removeClass("active");
			$(".commodity").removeClass("active");
			$(".allNum").html("0");
			$(".allMoney").html("￥0");
		}else{
			$(this).addClass("active");
			$(".shopName").addClass("active");
			$(".commodity").addClass("active");
		}
	});
	//结束选择操作
	//开始调整数量
	 $(document).on("tap",".reduce",function(){
		 if($(this).next().val()==1){
			 $(".tip").html("数量不能小于1！");
			 $(".tip").css("opacity","0.8");
			 setTimeout(function(){
				 $(".tip").html("");
				$(".tip").css("opacity","0");
			 },1000); 
		 }else{
			 $(this).next().val(parseInt($(this).next().val())-1);
		 }
	 });
	 $(document).on("tap",".increase",function(){
		 if($(this).prev().val()==$(this).prev().attr("maxData")){
			 $(".tip").html("数量不能大于订货量"+$(this).prev().attr("maxData")+"！");
			 $(".tip").css("opacity","0.8");
			 setTimeout(function(){
				$(".tip").html("");
				$(".tip").css("opacity","0");
			 },1000); 
		 }else{ 
			 $(this).prev().val(parseInt($(this).prev().val())+1);
		 }
	 });
	 $(document).on("change",".num",function(){
		 var act=$(this).parent().parent().parent();
		 if(parseInt($(this).val())>parseInt($(this).attr("maxData"))||parseInt($(this).val())<=0){
			 if(parseInt($(this).val())>parseInt($(this).attr("maxData"))){
			 	$(".tip").html("数量不能大于订货量"+$(this).attr("maxData")+"！");
			 	$(this).val($(this).attr("maxData"));
			 }else if(parseInt($(this).val())<=0){
	 			 $(".tip").html("数量不能小于1");
	 			 $(this).val(1);
			 }
			 $(".tip").css("opacity","0.8");
			 setTimeout(function(){
				 $(".tip").html("");
				$(".tip").css("opacity","0");
			 },1000); 
		 }
	 });
	//结束调整数量
	
	$(function(){
		
	});
	
	$(".prevPage").tap(function(){
		history.go(-1);
	});
	
	function getShopcartIdList(){
		var shopcartIdList="";
		var orderItemNumberList="";
		$(".commodity").each(function(){
			if($(this).hasClass("active")){
				shopcartIdList+=$(this).attr("data-id")+",";
				orderItemNumberList+=$(this).find(".num").val()+",";
			}
		});	
		return shopcartIdList.substring(0,shopcartIdList.length-1)+"#$"+orderItemNumberList.substring(0,orderItemNumberList.length-1);
	}
	
	$(".payButtom").tap(function(){
		var shopcartIdList=getShopcartIdList();
		if(shopcartIdList!="#$"){
			if("${orderForm.toPlatform==1}"=="true"){
				sendFactoryOrderItem();
			}else{
				$(".sendLogistics").show();
			}
		}else{
			showTip("至少选择一张订单");
		} 
	});
	
	function showTip(text){
		$(".tip").html(text);
		$(".tip").css("opacity","0.8");
		setTimeout(function(){
			$(".tip").css("opacity","0");
		},1000);
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
			var shopcartIdList=getShopcartIdList();
			var orderItemIds=shopcartIdList.split("#$")[0];
			var sendNumbers=shopcartIdList.split("#$")[1];

			var url="<%=request.getContextPath()%>/factory/sendOrderItem?transportPhoneNumber="+$("#transportPhone").val();
			var params;
			if(logisticsCompanyCode==null)
				params={logisticsCompanyCode:$("#otherInput").val(),logisticsCode:$("#transportNumber").val(),
					orderNumber:"${orderForm.orderNumber}",logisticsSelect:$("#logisticsSelect").val(),orderItemIds:orderItemIds,sendNumbers:sendNumbers};
			else
				params={logisticsCompanyCode:logisticsCompanyCode,logisticsCode:$("#transportNumber").val(),
					orderNumber:"${orderForm.orderNumber}",logisticsSelect:$("#logisticsSelect").val(),orderItemIds:orderItemIds,sendNumbers:sendNumbers};
			doAjax("GET",url,params,sendSuccess,fail,true,false);
		}
	});
	
	function sendSuccess(data){
		window.location.href="<%=request.getContextPath()%>/factory/orderManage?orderStatus=2";
	}
	
	function fail(data){
		alert("fail");
	}
	
	function sendFactoryOrderItem(){
		var shopcartIdList=getShopcartIdList();
		var orderItemIds=shopcartIdList.split("#$")[0];
		var sendNumbers=shopcartIdList.split("#$")[1];
		var url="<%=request.getContextPath()%>/factory/sendFactoryOrderItem";
		var params={orderItemIds:orderItemIds,sendNumbers:sendNumbers,orderNumber:"${orderForm.orderNumber}"};
		doAjax("GET",url,params,sendFactorySuccess,fail,true,false);
	}
	
	function sendFactorySuccess(data){
		window.location.href="<%=request.getContextPath()%>/factory/orderManage?orderStatus=2";
	}
</script>
</body>
</html>