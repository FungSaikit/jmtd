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
    	<i class="iconfont prevPage">&#xe624;</i>我的报价
    </div>
	<div class="allStatus">
    	<ul id="statusUl">
	    	<li style="width:33.33%;" <c:if test='${status==0}'>class="active"</c:if>><a href="<%=request.getContextPath()%>/demand/myDemandOffer?status=0">已提交</a></li>
	    	<li style="width:33.33%;" <c:if test='${status==1}'>class="active"</c:if>><a href="<%=request.getContextPath()%>/demand/myDemandOffer?status=1">已采用</a></li>
	    	<li style="width:33.33%;" <c:if test='${status==2}'>class="active"</c:if>><a href="<%=request.getContextPath()%>/demand/myDemandOffer?status=2">未采用</a></li>
	    </ul>
	</div>
    <div class="stockInfo">      
   		<div class="loading" style="visibility: visible;"><i class="iconfont">&#xe62c;</i><span id="jiazai">加载中...</span></div> 		
   		
    </div>
</div>
<!-- 开始确认框 -->
<div class="confirmDiv" id="delete">
	<div class="confirmTop">
		<span>联系方式</span>
		<span id="closeConfirm"><i class="iconfont">&#xe632;</i></span>
	</div>
	<p id="legalPerson"></p>
	<p id="phoneNumber"></p>
	<div class="confirmBottom">
		<span id="cancel">取消</span>
		<span id="confirm">确定</span>
	</div>
</div>

<div class="shade"></div>
<!--提现明细--非会员]]-->
<div class="tip"></div>
<!--[[底部-->
<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
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
		var url="<%=request.getContextPath()%>/demand/myDemandOfferList";
		var params={offset:offset,status:${status}};
		doAjax("GET",url,params,loadSuccess,fail,true,false);
	}
	
	var index=1;
	function loadSuccess(data){
		var ofList = data.data.list;
		var html="";
		for(var i=0;i<ofList.length;i++){
			html+='<div class="orderStock" data-id="'+ofList[i].demandOffer.demandId+'" ><div class="orderStockHead">';
			html+='<p class="fl">提交时间：'+showDate(ofList[i].demandOffer.creatTime)+'</p>';
			/* html+='<span class="checkBox getGoods" data-id="'+orderItemList[j].orderItem.orderItemId+'"><i class="iconfont">&#xe611;</i></span>'; */
			html+='</div><div class="orderStockBody">';
			html+='<div class="stock" data-id="1">';
			html+='<div class="stockNum"><div>需求：'+ofList[i].demand.demandName+'</div><div class="imgBox">';
			html+='<img src="'+ofList[i].demand.demandCover1+'" alt="">';
			html+='</div></div>';
			html+='<div class="stockNum"><div><label>报价：</label><div>¥'+ofList[i].demandOffer.demandPrice+'</div><span>('+ofList[i].demandOffer.timeLimit+'天)</span></div></div>';
			
			if(${status==1}){
				/* html+='<td class="contact" style="color:red;" data-phoneNumber="'+ofList[i].demand.demandPhoneNumber+'" data-legalPerson="'+ofList[i].demand.demandLegalPerson+'">联系方式</td>'; */
				html+='<div class="stockNum"><div><label>联系人：'+ofList[i].demand.demandLegalPerson+'</label></div></div>';
				html+='<div class="stockNum"><div><label>联系方式：<a class="phone" href="tel:'+ofList[i].demand.demandPhoneNumber+'">'+ofList[i].demand.demandPhoneNumber+'</a><label></div></div>';
			}
			html+='</div>';
			/* 
			html+='<table><tr>';
			html+='<td class="detail">查看详情</td>';
			html+='<td class="offerDetail" data-id='+ofList[i].demandOffer.demandOfferId+'>报价详情</td>';
			html+='</tr></table>'; */
			html+='</div></div></div>';
		}
		$(html).insertBefore(load);
		load.css("visibility","hidden");
		
		if(parseInt(offset+10)>=data.data.count){
			noDate=true;
		}
		offset=data.data.after;
		canLoad=true;
	}
	
	$(document).on("tap",".contact",function(){
		$("#legalPerson").html("联系人："+$(this).attr("data-legalPerson"));
		$("#phoneNumber").html('电话：<a href="tel:'+$(this).attr("data-phoneNumber")+'">'+$(this).attr("data-phoneNumber")+'</a>');
		$("#delete").show();
		$(".shade").show();
	});
	
	$(".shade,#cancel,#confirm").tap(function(){
		$("#delete").hide();
		$(".shade").hide();
	})
	
	
	$(document).on("tap",".detail",function(){
		window.location.href="<%=request.getContextPath()%>/demand/demandDetail?demandId="+$(this).parents(".orderStock").attr("data-id");
	});
	
	$(document).on("tap",".offer",function(){
		window.location.href="<%=request.getContextPath()%>/demand/demandOfferList?demandId="+$(this).parents(".orderStock").attr("data-id");
	});
	
	$(document).on("tap",".offerDetail",function(){
		window.location.href="<%=request.getContextPath()%>/demand/demandOfferDetail?demandOfferId="+$(this).attr("data-id");
	});
	
	function fail(data){
		console.log("fail");
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
		$(".shade").show();
		$(".waiting").show();
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
			setToBeSend(dataId,sendNumbers);
		}
	});
	
	function setToBeSend(dataId,sendNumbers){
		var url="<%=request.getContextPath()%>/buyer/setToBeSend?orderItemIds="
			+dataId+"&sendNumbers="+sendNumbers;
		var params={};
		doAjax("GET",url,params,successSet,fail,true,false);
	}
	
	function successSet(data){
		location.reload();
	}
	
	function fail(data){
		console.log("fail");
		clicked=false;
	}
	
	$(".prevPage").tap(function(){
		window.location.href="<%=request.getContextPath()%>/demand/demandManage";
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
	
	$(document).on("tap",".stockInfo .orderStock",function(e){
		if(!$(e.target).hasClass("phone")){
			window.location.href="<%=request.getContextPath()%>/demand/demandDetail?demandId="+$(this).attr("data-id");
		}
	})
</script>
</body>
</html>