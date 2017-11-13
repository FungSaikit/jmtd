<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
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
<div class="orderStock">
    <div class="title">
    	<i class="iconfont prevPage payPrev" >&#xe63f;</i>${sellerName}</div>
    <div class="stockInfo">      
   		<div class="loading" style="visibility: visible;"><i class="iconfont">&#xe62c;</i><span id="jiazai">加载中...</span></div> 		
   		<div class="submitDiv">
   			<div class="submit submitBtn"><a>提　交(<span id="receiveNumber">0</span>)</a></div>
   		</div>
    </div>
</div>
<div class="tip"></div>
<!--[[底部-->
<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/jweixin-1.0.0.js"></script>
<!--底部]]-->
<script>
	$(document).on("tap",".checkBox",function(){
		if($(this).hasClass("active")){
			$(this).removeClass("active");
		}else{
			$(this).addClass("active");
		}
		countReceiveNumber();
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
	
	function countReceiveNumber(){
		var number=0;
		$(".checkBox").each(function(){
			if($(this).hasClass("active")){		
				number+=parseInt($(this).parents(".orderStockHead").parent().find("input[name='haveGoodsNum']").val());
			}
		});
		$("#receiveNumber").html(number)
	}
	
	var offset=0;
	function loadOrder(){
		var url="<%=request.getContextPath()%>/buyer/receiveListAjax";
		var params={offset:offset,sellerId:${sellerId}};
		doAjax("GET",url,params,loadSuccess,fail,true,false);
	}
	
	function loadSuccess(data){
		var ofList = data.data.list;
		var html="";
		for(var i=0;i<ofList.length;i++){
			/* html+='<div class="orderStock">';
			html+='<div class="orderStockHead">';
			html+='<p>物流公司：'+ofList[i].orderForm.recommendLogistics+'</p>';
			html+='</div><div class="orderStockBody">'; */
			var orderItemList = ofList[i].orderItemList;
			for(var j=0;j<orderItemList.length;j++){
				/* html+='<div class="stock">';
				html+='<div class="order">';
				html+='<div class="fl">型号：'+orderItemList[j].product.productCode+'</div>';
				html+='<div class="fr" >'+(orderItemList[j].orderItem.orderItemNumber-
						orderItemList[j].orderItem.perpareSendNumber-orderItemList[j].orderItem.sendNumber-orderItemList[j].orderItem.stockedNumber)+'</div></div>';
				 */
				if(orderItemList[j].orderItem.receiveNumber!=null){
					html+='<div class="orderStock"><div class="orderStockHead">';
					html+='	<p class="fl '+(orderItemList[j].orderItem.perpareSendFlag==2?'red':'')+'">下单时间：'+showDate(ofList[i].orderForm.payTime)+'</p>';
					html+='<span class="checkBox getGoods" data-id="'+orderItemList[j].orderItem.orderItemId+'"><i class="iconfont">&#xe611;</i></span>';
					html+='</div><div class="orderStockBody">';
					html+='<div class="stock" data-id="1">';
					html+='<div class="stockNum"><div>型号：'+orderItemList[j].product.productCode+'</div><div class="imgBox">';
					html+='<img src="'+orderItemList[j].product.cover1+'" alt="">';
					html+='</div></div><div class="stockNum"><div><label>现货：</label>';
					html+='<div><a class="reduce">-</a>';
					html+='<input type="text" data-max="'+(
							orderItemList[j].orderItem.receiveNumber-orderItemList[j].orderItem.sendNumber)+'" value="'+(
									orderItemList[j].orderItem.receiveNumber-orderItemList[j].orderItem.sendNumber)+'" name="haveGoodsNum"/>';
					html+='<a class="plus">+</a>';
					html+='</div><span>个</span></div></div><table>';
					html+='<tr><td class="red">'+ofList[i].buyer.userIdenticalCode+'</td>';
					html+='<td>'+ofList[i].orderForm.receivePerson+'</td><td>'+ofList[i].service.legalPersonName+'</td></tr>';
					html+='</table></div></div></div>';
					}
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
   				
   				
   				/* if(j==orderItemList.length-1){
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
   				} */
			}
			/* 
			html+='</div></div>'; */
		}
		$(html).insertBefore(load);
		load.css("visibility","hidden");
		
		if(parseInt(offset+10)>=data.data.count){
			noDate=true;
		}
		offset=data.data.after;
		canLoad=true;
	}
	
	function fail(data){
		alert("fail");
		clicked=false;
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
	
	var clicked=false;
	$(document).on("tap",".submit",function(){
		if(clicked==false){
			clicked=true;
			var dataId="";
			var sendNumbers="";
			$(".checkBox").each(function(){
				if($(this).hasClass("active")){		
					dataId+=$(this).attr("data-id")+",";
					sendNumbers+=$(this).parents(".orderStockHead").parent().find("input[name='haveGoodsNum']").val()+",";
				}
			});
			dataId=dataId.substring(0, dataId.length-1);
			sendNumbers=sendNumbers.substring(0, sendNumbers.length-1);
			cancelToBeSend(dataId,sendNumbers);
		}
	});
	
	function cancelToBeSend(dataId,sendNumbers){
		var url="<%=request.getContextPath()%>/buyer/cancelToBeSend?orderItemIds="
			+dataId+"&sendNumbers="+sendNumbers;
		var params={};
		doAjax("GET",url,params,successSet,fail,true,false);
	}
	
	function successSet(data){
		location.reload();
	}
	
	function fail(data){
		alert("fail");
		clicked=false;
	}
	
	$(".prevPage").tap(function(){
		history.go(-1);
	});
	
	$(document).on("tap",".reduce",function(){
		if($(this).next().val()>1){
			$(this).next().val($(this).next().val()-1);
			countReceiveNumber();
		}else{
			showTip("不能小于1");
		}
	});
	
	$(document).on("tap",".plus",function(){
		if($(this).prev().val()>=$(this).prev().attr("data-max")){
			showTip("不能大于订货量");
		}else{
			$(this).prev().val(parseInt($(this).prev().val())+1);	
			countReceiveNumber();
		}
	});
	
	$(document).on("change","input[name='haveGoodsNum']",function(){
		if($(this).val()<1){
			showTip("不能小于1");
			$(this).val(1);
		}else if(parseInt($(this).val())>parseInt($(this).attr("data-max"))){
			showTip("不能大于订货量");
			$(this).val($(this).attr("data-max"));
		}
		countReceiveNumber();
	});
</script>
</body>
</html>