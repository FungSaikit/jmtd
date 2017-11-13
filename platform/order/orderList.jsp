<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib prefix="date" uri="/WEB-INF/tld/dateTag.tld"%> 
<%@ taglib prefix="thumbnail" uri="/WEB-INF/tld/thumbnailTag.tld"%>
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
    
	<style>
		.table-responsive .plus,.table-responsive .reduce{
			display:inline-block;
			border:1px solid #ccc;
		    width:30px;
			line-height:30px;
			text-align:center;
			width:30px;
			font-size:20px;
			float:left;
			cursor:pointer;
			text-decoration:none;
		}
		
		.oiNumber{
		    height: 32px;
		    text-align: center;
		    width: 40px;
		    border: 1px solid #ccc;
		    border-left: 0px;
		    border-right: 0px;
		    -webkit-appearance: none;
		    float: left;
		}
		
		/*提示框  */
		.tip{
			position:fixed;
			left:50%;
			top:50%;
			background-color:#000;
			color:#fff;
			max-width:50%;
			z-index:11000;
			padding:.2rem;
			border-radius:6px;
			opacity:0;
			font-size:.5rem;
			
			-webkit-transform:translate(-50%);
			-moz-transform:translate(-50%);
			transform:translate(-50%);
			
			-webkit-transition: opacity .5s ease .1s;
		  	transition: opacity .5s ease .1s;
		}
		
		.shade{
			width:100%;
			height:100%;
			background-color:rgba(0,0,0,.5);
			position:fixed;
			left:0;
			top:0;
			z-index:100;
			display:none;
		}
		
		.auto_hidden {
    width:204px;border-top: 1px solid #333;
    border-bottom: 1px solid #333;
    border-left: 1px solid #333;
    border-right: 1px solid #333;
    position:absolute;
    display:none;
}
.auto_show {
    width:204px;
    border-top: 1px solid #333;
    border-bottom: 1px solid #333;
    border-left: 1px solid #333;
    border-right: 1px solid #333;
    position:absolute;
    z-index:9999; /* 设置对象的层叠顺序 */
    display:block;
}
.auto_onmouseover{
    color:#ffffff;
    background-color:highlight;
    width:100%;
}
.auto_onmouseout{
    color:#000000;
    width:100%;
    background-color:#ffffff;
}
	</style>
</head>
<body>
	<c:set var="OBLIGATION" value="<%=OrderStatus.OBLIGATION%>" />
	<c:set var="TO_BE_SHIPPED" value="<%=OrderStatus.TO_BE_SHIPPED%>" />
	<c:set var="TO_BE_SIGNED" value="<%=OrderStatus.TO_BE_SIGNED%>" />
	<c:set var="SIGNED" value="<%=OrderStatus.SIGNED%>" />
	<c:set var="FINISHED" value="<%=OrderStatus.FINISHED%>" />
	<c:set var="CLOSED" value="<%=OrderStatus.CLOSED%>" />
	<c:set var="PREPARE_SEND" value="<%=OrderStatus.PREPARE_SEND%>" />
	<c:set var="STOCKED" value="<%=OrderStatus.STOCKED%>" />
    <jsp:include page="/jsp/platform/header.jsp"></jsp:include>
	<jsp:include page="/jsp/platform/navigation.jsp"></jsp:include>
    <!-- [[选项卡-->
    <form action="<%=request.getContextPath()%>/platform/orderList">
    	<input type="date" name="from" value="${from}">
    	<input type="date" name="to" value="${to}">
    	<input type="text" name="keyword" value="${keyword}" placeHolder="输入订单号"><%-- 
    	<input type="text" name="sellerName" value="${sellerName}" placeHolder="输入卖家名字">
    	<input type="text" name="buyerName" value="${buyerName}" placeHolder="输入买家名字">
    	<input type="text" name="serviceName" value="${serviceName}" placeHolder="输入客服"> --%>
    	
    	<input placeHolder="输入厂家名字" type="text" style="width:300px;height:20px;" id="seller" name="sellerName" 
    		onkeyup="autoCompleteS.start(event,true)" onclick="autoCompleteS.start(event,false)" value="${sellerName}" autocomplete="off">
   		<div class="auto_hidden" id="autoSeller"><!--自动完成 DIV--></div>
    	<input placeHolder="输入买家名字" type="text" style="width:300px;height:20px;" id="buyer" name="buyerName" 
    		onkeyup="autoComplete.start(event,true)" onclick="autoComplete.start(event,false)" value="${buyerName}" autocomplete="off">
   		<div class="auto_hidden" id="autoBuyer"><!--自动完成 DIV--></div>
    	<input placeHolder="输入客服名字" type="text" style="width:300px;height:20px;" id="service" name="serviceName" 
    		onkeyup="autoCompleteSe.start(event,true)" onclick="autoCompleteSe.start(event,false)" value="${serviceName}" autocomplete="off">
   		<div class="auto_hidden" id="autoService"><!--自动完成 DIV--></div>
    	<input placeHolder="输入物流名字" type="text" style="width:300px;height:20px;" id="logistics" name="logisticsCompany" 
    		onkeyup="autoCompleteL.start(event,true)" onclick="autoCompleteL.start(event,false)" value="${logisticsCompany}" autocomplete="off">
   		<div class="auto_hidden" id="autoLogistics"><!--自动完成 DIV--></div>
   		<input placeHolder="输入物流园名字" type="text" style="width:300px;height:20px;" id="logisticsPark" name="logisticsPark" 
    		onkeyup="autoCompleteLp.start(event,true)" onclick="autoCompleteLp.start(event,false)" value="${logisticsPark}" autocomplete="off">
   		<div class="auto_hidden" id="autoLogisticsPark"><!--自动完成 DIV--></div>
    	<input type="text" name="productName" value="${productName}" placeHolder="输入产品名">
    	<input type="hidden" name="orderStatus" value="${orderStatus}">
    	<input type="hidden" name="offset" value="0">
    	<button>搜索</button>
    </form>
    <div class="nav-tabs">
        <button class="btn <c:if test='${orderStatus==TO_BE_SHIPPED }'>navActive</c:if>" onclick="toStatus(${TO_BE_SHIPPED})">订单</button>
        <button class="btn <c:if test='${orderStatus==STOCKED }'>navActive</c:if>" onclick="toStatus(${STOCKED})">待发货</button>
        <button class="btn <c:if test='${orderStatus==PREPARE_SEND}'>navActive</c:if>" onclick="toStatus(${PREPARE_SEND})">今日待发</button>
   		<button class="btn <c:if test='${orderStatus==TO_BE_SIGNED }'>navActive</c:if>" onclick="toStatus(${TO_BE_SIGNED})">待收货</button>
        <button class="btn <c:if test='${orderStatus==SIGNED }'>navActive</c:if>" onclick="toStatus(${SIGNED})">已签收</button>
        <button class="btn <c:if test='${orderStatus==FINISHED }'>navActive</c:if>" onclick="toStatus(${FINISHED})">已完成</button>
        <button class="btn <c:if test='${orderStatus==CLOSED }'>navActive</c:if>" onclick="toStatus(${CLOSED})">已关闭</button>
        <button class="btn" onclick="window.location.href='<%=request.getContextPath()%>/platform/returnOrderManage'">退款/退货</button><%-- 
   		<button class="btn" onclick="window.location.href='<%=request.getContextPath()%>/platform/serviceOrderList'">待服务订单</button> --%>
   		<button class="btn <c:if test='${orderStatus==OBLIGATION }'>navActive</c:if>" onclick="toStatus(${OBLIGATION})">待付款</button>
        
   		<c:if test='${orderStatus==TO_BE_SHIPPED}'><button onclick="setStocked()">设为待发货</button></c:if>
   		<c:if test='${orderStatus==7}'>
   			<button onclick="cancelPrepareSend()">取消今日待发</button>
   			<button onclick="generateExcel()">excel</button>
   		</c:if>
   		<c:if test='${orderStatus==8}'>
   			<button onclick="setPerpareSend()">设为今日待发</button>
   			<button onclick="cancelStocked()">取消待发货</button>
   		</c:if>
    </div><!-- 选项卡]] -->

    <!-- [[订单列表 -->
    <div class="table-responsive">
    <table class="table table-bordered table-striped table-hover">
        <thead>
        <tr>
            <th>订单号</th>
            <th class="textLeft">卖家</th>
            <th>买家</th>
            <th>编号</th>
            <th>客服</th>
            <th>订单总金额</th>
            <th>下单时间</th>
            <c:if test='${orderStatus==TO_BE_SIGNED||orderStatus==SIGNED||orderStatus==FINISHED||orderStatus==SERVED }'>
            <th>发货时间</th>
            </c:if>
            <c:if test='${orderStatus==TO_BE_SHIPPED||orderStatus==7||orderStatus==8 }'><th>操作</th></c:if>
            <th>产品名</th>
            <th>产品图片</th>
            <th>数量</th>
            <c:if test="${orderStatus==TO_BE_SHIPPED||orderStatus==7||orderStatus==8 }">
            <th>已收货数量</th>
            <th>急单</th>
            <th>现货数</th>
            <th>备货数</th>
            <th>交货期</th>
            <th>交货日期</th>
            <th>备注</th>
            </c:if>
            <th>单价</th>
        </tr>
        </thead>
    <c:forEach items="${orderPager.list}" var="ofm">
    	<tr <%-- <c:if test="${!empty ofm.orderItemList[0].orderItem.haveGoodsNum && ofm.orderItemList[0].orderItem.haveGoodsNum!=ofm.orderItemList[0].orderItem.orderItemNumber}">style="color:red"</c:if> --%>>
    		<td <c:if test="${(orderStatus==1||orderStatus==7||orderStatus==8)&&ofm.orderForm.stockedComplete==1}">style="color:red"</c:if> rowspan="${ofm.orderItemList.size() }"><a href="<%=request.getContextPath() %>/platform/orderDetail?orderNum=${ofm.orderForm.orderNumber}" class="blueText">${ofm.orderForm.orderNumber}</a></td>
    		<td <c:if test="${(orderStatus==1||orderStatus==7||orderStatus==8)&&ofm.orderForm.stockedComplete==1}">style="color:red"</c:if> rowspan="${ofm.orderItemList.size() }">${ofm.seller.shortCompanyName}</td>
    		<td <c:if test="${(orderStatus==1||orderStatus==7||orderStatus==8)&&ofm.orderForm.stockedComplete==1}">style="color:red"</c:if> rowspan="${ofm.orderItemList.size() }">${ofm.buyer.userNickname}</td>
    		<td <c:if test="${(orderStatus==1||orderStatus==7||orderStatus==8)&&ofm.orderForm.stockedComplete==1}">style="color:red"</c:if> rowspan="${ofm.orderItemList.size() }">${ofm.buyer.userIdenticalCode}</td>
    		<td <c:if test="${(orderStatus==1||orderStatus==7||orderStatus==8)&&ofm.orderForm.stockedComplete==1}">style="color:red"</c:if> rowspan="${ofm.orderItemList.size() }">${ofm.service.legalPersonName }</td>
    		<td <c:if test="${(orderStatus==1||orderStatus==7||orderStatus==8)&&ofm.orderForm.stockedComplete==1}">style="color:red"</c:if> rowspan="${ofm.orderItemList.size() }">${ofm.orderForm.orderMoney}</td>
    		<td <c:if test="${(orderStatus==1||orderStatus==7||orderStatus==8)&&ofm.orderForm.stockedComplete==1}">style="color:red"</c:if> rowspan="${ofm.orderItemList.size() }"><fmt:formatDate value="${ofm.orderForm.payTime}"  pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <c:if test='${orderStatus==TO_BE_SIGNED||orderStatus==SIGNED||orderStatus==FINISHED||orderStatus==SERVED }'>
            	<td <c:if test="${(orderStatus==1||orderStatus==7||orderStatus==8)&&ofm.orderForm.stockedComplete==1}">style="color:red"</c:if> rowspan="${ofm.orderItemList.size() }"><fmt:formatDate value="${ofm.orderForm.sendTime}"  pattern="yyyy-MM-dd HH:mm:ss"/></td>
            </c:if>
            <c:if test='${orderStatus==TO_BE_SHIPPED ||orderStatus==7||orderStatus==8}'><td  class="selectTr"><input type="checkBox" name="prepareSend" data-id="${ofm.orderItemList[0].orderItem.orderItemId }"/></td></c:if>
    		<td>${ofm.orderItemList[0].product.productName}</td>
    		<td><img src="<thumbnail:date value="${ofm.orderItemList[0].product.cover1}"/>" style="width:80px;height:80px"/></td>
    		<td><c:choose><c:when test="${orderStatus==TO_BE_SHIPPED ||orderStatus==7||orderStatus==8}"><a class="reduce">-</a>
    				<c:if test="${orderStatus==TO_BE_SHIPPED}"><input class="oiNumber" type="text" value="${ofm.orderItemList[0].orderItem.orderItemNumber-ofm.orderItemList[0].orderItem.perpareSendNumber-ofm.orderItemList[0].orderItem.sendNumber-ofm.orderItemList[0].orderItem.stockedNumber}" data-max="${ofm.orderItemList[0].orderItem.orderItemNumber-ofm.orderItemList[0].orderItem.perpareSendNumber-ofm.orderItemList[0].orderItem.sendNumber-ofm.orderItemList[0].orderItem.stockedNumber}"/></c:if>
    				<c:if test="${orderStatus==7}"><input class="oiNumber" type="text" value="${ofm.orderItemList[0].orderItem.perpareSendNumber}" data-max="${ofm.orderItemList[0].orderItem.perpareSendNumber}"/></c:if>
    				<c:if test="${orderStatus==8}"><input class="oiNumber" type="text" value="${ofm.orderItemList[0].orderItem.stockedNumber}" data-max="${ofm.orderItemList[0].orderItem.stockedNumber}"/></c:if>
    				<a class="plus">+</a>
    			</c:when>
    			<c:when test="${orderStatus==TO_BE_SIGNED }">${ofm.orderItemList[0].orderItem.sendNumber }</c:when>
    			<c:otherwise>${ofm.orderItemList[0].orderItem.orderItemNumber}</c:otherwise>
    			</c:choose>
    		</td>
            <c:if test="${orderStatus==TO_BE_SHIPPED||orderStatus==7||orderStatus==8 }">
                <td>${ofm.orderItemList[0].orderItem.receiveNumber}</td>
                <td>${!empty  ofm.orderItemList[0].orderItem.isRushOrder?'急单':'无'}</td>
                <td>${ofm.orderItemList[0].orderItem.spotGoodsNum}</td>
    			<td>
	   				${empty ofm.orderItemList[0].orderItem.haveGoodsNum?'':ofm.orderItemList[0].orderItem.haveGoodsNum}
				</td>
	    		<td>
					${empty ofm.orderItemList[0].orderItem.consignmentTime?'':ofm.orderItemList[0].orderItem.consignmentTime }
				</td>
				<td class=""><c:if test="${!empty ofm.orderItemList[0].orderItem.consignmentTime }"><date:date value="${ofm.orderForm.payTime}" dateNumber="${ofm.orderItemList[0].orderItem.consignmentTime}"></date:date></c:if></td>          
    	 		<td><input class="orderItemRemark" data-id="${ofm.orderItemList[0].orderItem.orderItemId }" value="${ofm.orderItemList[0].orderItem.orderItemRemark}"/></td>
    	 	</c:if><td>${ofm.orderItemList[0].orderItem.orderItemPrice}</td>
    	 </tr>
    	 <c:forEach items="${ofm.orderItemList }" var="oim" begin="1">
    	 <tr <c:if test="${!empty oim.orderItem.haveGoodsNum && oim.orderItem.haveGoodsNum!=oim.orderItem.orderItemNumber}">style="color:red"</c:if>>
    	 <c:if test='${orderStatus==TO_BE_SHIPPED ||orderStatus==7||orderStatus==8}'><td  class="selectTr"><input type="checkBox" name="prepareSend" data-id="${oim.orderItem.orderItemId }"/></td></c:if>
    	 	<td>${oim.product.productName}</td>
    		<td><img src="<thumbnail:date value="${oim.product.cover1}"/>" style="width:80px;height:80px"/></td>
    		<td><c:choose><c:when test="${orderStatus==TO_BE_SHIPPED ||orderStatus==7||orderStatus==8}"><a class="reduce">-</a>
    				<c:if test="${orderStatus==TO_BE_SHIPPED}"><input class="oiNumber" type="text" value="${oim.orderItem.orderItemNumber-oim.orderItem.perpareSendNumber-oim.orderItem.sendNumber-oim.orderItem.stockedNumber}" data-max="${oim.orderItem.orderItemNumber-oim.orderItem.perpareSendNumber-oim.orderItem.sendNumber-oim.orderItem.stockedNumber}"/></c:if>
    				<c:if test="${orderStatus==7}"><input class="oiNumber" type="text" value="${oim.orderItem.perpareSendNumber}" data-max="${oim.orderItem.perpareSendNumber}"/></c:if>
    				<c:if test="${orderStatus==8}"><input class="oiNumber" type="text" value="${oim.orderItem.stockedNumber}" data-max="${oim.orderItem.stockedNumber}"/></c:if>
    				<a class="plus">+</a>
    			</c:when>
    			<c:when test="${orderStatus==TO_BE_SIGNED }">${oim.orderItem.sendNumber}</c:when>
    			<c:otherwise>${oim.orderItem.orderItemNumber }</c:otherwise>
    			</c:choose>
    		</td>
    		<c:if test="${orderStatus==TO_BE_SHIPPED||orderStatus==7||orderStatus==8}">
                <td>${oim.orderItem.receiveNumber}</td>
                <td>${!empty  oim.orderItem.isRushOrder?'急单':'无'}</td>
                <td>${oim.orderItem.spotGoodsNum}</td>
                <td>
	   				${empty oim.orderItem.haveGoodsNum?'':oim.orderItem.haveGoodsNum}
				</td>
	    		<td>
					${empty oim.orderItem.consignmentTime?'':oim.orderItem.consignmentTime }
				</td>
				<td class=""><c:if test="${!empty oim.orderItem.consignmentTime }"><date:date value="${ofm.orderForm.payTime}" dateNumber="${oim.orderItem.consignmentTime}"></date:date></c:if></td>          
    	 		<td><input class="orderItemRemark" data-id="${oim.orderItem.orderItemId }" value="${oim.orderItem.orderItemRemark}"/></td>
    	 		
    	 	</c:if><td>${oim.orderItem.orderItemPrice}</td>
    	</tr>
    	 </c:forEach>
    </c:forEach>
    </table>
    <!-- 订单列表]] -->

    <!-- [[分页-->
    <div class="paging">
        <span class="prev btn btn-primary" onclick="toPage(${orderPager.before})">上一页</span>
        <span>当前第页<fmt:formatNumber value="${((orderPager.after==orderPager.count&&orderPager.after%10!=0)?1:0)+((orderPager.after-orderPager.after%10))/10 }" pattern="#0"/>/共<fmt:formatNumber value="${((orderPager.count-1-(orderPager.count-1)%10))/10+1}" pattern="#0" />页</span>
        <span class="next btn btn-primary" onclick="toPage(${orderPager.after})">下一页</span>
    </div>
    <!-- 分页]]-->

    </div><!-- rightConten右边区域]] -->

    </div><!-- mainBody页面主体]] -->

    <footer>

    </footer>
    <div class="tip"></div>
    <div class="shade"></div>
    <script src="<%=request.getContextPath() %>/resources/autoComplete.js"></script>
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
	
	function toPage(offset){
		$("input[name='offset']").val(offset);
		$("form").submit();
	}
	
	function toStatus(s){
		$("input[name='orderStatus']").val(s);
		$("input[name='offset']").val(0);
		$("form").submit();
	}
	
	function setPerpareSend(){
		if(clicked==false){
			clicked=true;
			var orderNumbers="";
			var orderItemCount="";
			$("input[name='prepareSend']").each(function(){
				if($(this).prop("checked")){
					orderNumbers+=$(this).attr("data-id")+",";
					orderItemCount+=$(this).parents("tr").find(".oiNumber").val()+",";
				}
			});
			orderNumbers = orderNumbers.substring(0,orderNumbers.length-1);
			orderItemCount = orderItemCount.substring(0,orderItemCount.length-1);
			var url="<%=request.getContextPath()%>/platform/setTodayPreSend?orderItemIds="+orderNumbers+"&sendNumbers="+orderItemCount;
			var params={};
			doAjax("GET",url,params,setPrepareSendSuccess,fail,true,false);
		}
	}
	
	function setPrepareSendSuccess(data){
		location.reload();
	}
	
	var clicked=false;
	function cancelPrepareSend(){
		if(clicked==false){
			clicked=true;
			var orderNumbers="";var orderItemCount="";
			$("input[name='prepareSend']").each(function(){
				if($(this).prop("checked")){
					orderNumbers+=$(this).attr("data-id")+",";
					orderItemCount+=$(this).parents("tr").find(".oiNumber").val()+",";
				}
			});
			orderNumbers = orderNumbers.substring(0,orderNumbers.length-1);
			orderItemCount = orderItemCount.substring(0,orderItemCount.length-1);
			var url="<%=request.getContextPath()%>/platform/cancelTodayPreSend?orderItemIds="+orderNumbers+"&sendNumbers="+orderItemCount;
			var params={};
			doAjax("GET",url,params,cancelPrepareSendSuccess,fail,true,false);
		}
	}
	
	function cancelPrepareSendSuccess(data){
		location.reload();
	}
	
	function fail(data){
		alert("fail");
		clicked=false;
	}
	
	$(".selectTr").click(function(e){
		if($(e.target).html()!=""){
			if($(this).find("input[type='checkBox']").prop("checked"))
				$(this).find("input[type='checkBox']").prop("checked",false);
			else
				$(this).find("input[type='checkBox']").prop("checked",true);
		}
	});
	
	function generateExcel(){
		var url="<%=request.getContextPath()%>/platform/generateOrderExcel";
		var params=$("form").serialize();
		doAjax("GET",url,params,excelSuccess,fail,true,false);
	}
	
	function excelSuccess(data){
		window.location.href=data.data;
	}
	
	//开始调整数量
	 $(document).on("click",".reduce",function(){
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
	
	 $(document).on("click",".plus",function(){
		 if($(this).prev().val()==$(this).prev().attr("data-max")){
			 $(".tip").html("数量不能大于订货量"+$(this).prev().attr("data-max")+"！");
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
	
	function showTip(text){
		$(".tip").html(text);
		$(".tip").css("opacity","0.8");
		setTimeout(function(){
			$(".tip").css("opacity","0");
		},1000);
	}
	
	function setStocked(){
		if(clicked==false){
			clicked=true;
			var orderNumbers="";
			var orderItemCount="";
			$("input[name='prepareSend']").each(function(){
				if($(this).prop("checked")){
					orderNumbers+=$(this).attr("data-id")+",";
					orderItemCount+=$(this).parents("tr").find(".oiNumber").val()+",";
				}
			});
			orderNumbers = orderNumbers.substring(0,orderNumbers.length-1);
			orderItemCount = orderItemCount.substring(0,orderItemCount.length-1);
			var url="<%=request.getContextPath()%>/platform/setToBeSend?orderItemIds="+orderNumbers+"&sendNumbers="+orderItemCount;
			var params={};
			doAjax("GET",url,params,setToBeSendSuccess,fail,true,false);
		}
	}
	
	function setToBeSendSuccess(data){
		location.reload();
	}
	
	function cancelStocked(){
		if(clicked==false){
			clicked=true;
			var orderNumbers="";var orderItemCount="";
			$("input[name='prepareSend']").each(function(){
				if($(this).prop("checked")){
					orderNumbers+=$(this).attr("data-id")+",";
					orderItemCount+=$(this).parents("tr").find(".oiNumber").val()+",";
				}
			});
			orderNumbers = orderNumbers.substring(0,orderNumbers.length-1);
			orderItemCount = orderItemCount.substring(0,orderItemCount.length-1);
			var url="<%=request.getContextPath()%>/platform/cancelStocked?orderItemIds="+orderNumbers+"&sendNumbers="+orderItemCount;
			var params={};
			doAjax("GET",url,params,cancelStockedSuccess,fail,true,false);
		}
	}
	
	function cancelStockedSuccess(data){
		location.reload();
	}
	
	$(document).on("change",".orderItemRemark",function(){
		var url="<%=request.getContextPath()%>/platform/changeOrderItemRemark";
		var params={orderItemId:$(this).attr("data-id"),
				orderItemRemark:$(this).val()};
		doAjax("GET",url,params,changeSuccess,fail,true,false);
	});
	
	function changeSuccess(data){
		
	}
	
	var autoComplete=new AutoComplete('buyer','autoBuyer',${buyerStr});
	var autoCompleteS=new AutoComplete('seller','autoSeller',${sellerStr});
	var autoCompleteSe=new AutoComplete('service','autoService',${serviceStr});
	var autoCompleteL=new AutoComplete('logistics','autoLogistics',${logisticsStr});
	var autoCompleteLp=new AutoComplete('logisticsPark','autoLogisticsPark',${logisticsParkStr});
	document.onclick=function(e){
		if(e.target.getAttribute("id")=='buyer'||e.target.parentNode.getAttribute("id")=='autoBuyer'){
			autoCompleteL.deleteDIV();
			autoCompleteSe.deleteDIV();
			autoCompleteS.deleteDIV();
			autoCompleteLp.deleteDIV();
		}else if(e.target.getAttribute("id")=='seller'||e.target.parentNode.getAttribute("id")=='autoSeller'){
			autoComplete.deleteDIV();
			autoCompleteSe.deleteDIV();
			autoCompleteL.deleteDIV();
			autoCompleteLp.deleteDIV();
		}else if(e.target.getAttribute("id")=='service'||e.target.parentNode.getAttribute("id")=='autoService'){
			autoComplete.deleteDIV();
			autoCompleteS.deleteDIV();
			autoCompleteL.deleteDIV();
			autoCompleteLp.deleteDIV();
		}else if(e.target.getAttribute("id")=='logistics'||e.target.parentNode.getAttribute("id")=='autoLogistics'){
			autoComplete.deleteDIV();
			autoCompleteSe.deleteDIV();
			autoCompleteS.deleteDIV();
			autoCompleteLp.deleteDIV();
		}else if(e.target.getAttribute("id")=='logisticsPark'||e.target.parentNode.getAttribute("id")=='autoLogisticsPark'){
			autoComplete.deleteDIV();
			autoCompleteSe.deleteDIV();
			autoCompleteS.deleteDIV();
			autoCompleteL.deleteDIV();
		}else{
			autoComplete.deleteDIV();
			autoCompleteS.deleteDIV();
			autoCompleteSe.deleteDIV();
			autoCompleteL.deleteDIV();
			autoCompleteLp.deleteDIV();
		}
	}
	
</script>
</html>