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
    <style>
    	#addStaff{
    		float: left;
		    text-align: center;
		    padding: 0.2rem;
		    box-sizing: border-box;
		    font-size: .5rem;
		    list-style-type:none;
		    width:100%;
		    background-color:#F00;
		    color:#FFF;
		    position:fixed;
		    bottom:0;
    	}
    </style>
</head>
<body>
<div class="orderStock">
    <div class="title">
    	<i class="iconfont prevPage">&#xe624;</i>我的需求
    </div>
	<div class="allStatus">
    	<ul id="statusUl">
    		<li style="width:25%;" <c:if test='${demandStatus==-1}'>class="active"</c:if>><a href="<%=request.getContextPath()%>/demand/demandList?demandStatus=-1">待审核</a></li>
	    	<li style="width:25%;" <c:if test='${demandStatus==0}'>class="active"</c:if>><a href="<%=request.getContextPath()%>/demand/demandList?demandStatus=0">已发布</a></li>
	    	<li style="width:25%;" <c:if test='${demandStatus==1}'>class="active"</c:if>><a href="<%=request.getContextPath()%>/demand/demandList?demandStatus=1">已完成</a></li>
	    	<li style="width:25%;" <c:if test='${demandStatus==4}'>class="active"</c:if>><a href="<%=request.getContextPath()%>/demand/demandList?demandStatus=4">不通过</a></li>
	    </ul>
	</div>
    <div class="stockInfo">      
   		<div class="loading" style="visibility: visible;"><i class="iconfont">&#xe62c;</i><span id="jiazai">加载中...</span></div> 		
   		
    </div>
    <li style="" id="addStaff"><span>上传需求</span></li>
</div>
<div class="tip"></div>
<div class="shade"></div>
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
		var url="<%=request.getContextPath()%>/demand/demandListAjax";
		var params={offset:offset,demandStatus:${demandStatus}};
		doAjax("GET",url,params,loadSuccess,fail,true,false);
	}
	
	var index=1;
	function loadSuccess(data){
		var ofList = data.data.list;
		console.log(ofList);
		var html="";
		for(var i=0;i<ofList.length;i++){
			html+='<div class="orderStock" data-id="'+ofList[i].demandId+'"><div class="orderStockHead">';
			html+='<p class="fl">发布时间：'+showDate(ofList[i].releaseTime==null?ofList[i].applyTime:ofList[i].releaseTime)+'</p>';
			/* html+='<span class="checkBox getGoods" data-id="'+orderItemList[j].orderItem.orderItemId+'"><i class="iconfont">&#xe611;</i></span>'; */
			html+='</div><div class="orderStockBody">';
			html+='<div class="stock" data-id="1">';
			html+='<div class="stockNum"><div>需求：'+ofList[i].demandName+'</div><div class="imgBox">';
			html+='<img src="'+ofList[i].demandCover1+'" alt="">';
			html+='</div></div><div class="stockNum"><div><label>报价数：'+ofList[i].demandOfferNumber+'</label>';
			html+='<div>';
			html+='</div><span>个</span>'+(ofList[i].newOfferNumber>0?'<span style="color:red">('+ofList[i].newOfferNumber+'份新报价)</span>':'')+'</div></div>';
			/* html+='<table><tr><td  class="detail">详情</td>';
			html+='<td class="offer">报价列表</td>';
			if(ofList[i].demandStatus!=1){
				html+='';
			}
			html+='</tr></table>'; */
			html+='<table><tr><td><td class="delete">删除</td></td></tr></table>'
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
	
	$(document).on("tap",".stockInfo .orderStock",function(e){
		if(!$(e.target).hasClass("delete"))
			window.location.href="<%=request.getContextPath()%>/demand/demandDetail?demandId="+$(this).attr("data-id");
	});
	
	function deleteDeamnd(demandId){
		var url="<%=request.getContextPath()%>/demand/deleteDemand";
		var params={demandId:demandId};
		doAjax("GET",url,params,function(data){location.reload();},fail,true,false);
	}
	
	$("#addStaff").tap(function(){
		window.location.href="<%=request.getContextPath()%>/demand/toUploadDemand";
	})
	
	$(document).on("tap",".detail",function(){
		window.location.href="<%=request.getContextPath()%>/demand/demandDetail?demandId="+$(this).parents(".orderStock").attr("data-id");
	});
	
	$(document).on("tap",".offer",function(){
		window.location.href="<%=request.getContextPath()%>/demand/demandOfferList?demandId="+$(this).parents(".orderStock").attr("data-id");
	});
	
	$(document).on("tap",".delete",function(){
		deleteDeamnd($(this).parents(".orderStock").attr('data-id'));
	});
	
	function fail(data){
		console.log("fail");
	}
	
	$(document).on("tap","td",function(){
		$(this).attr("style","color:red");
	})
	
	$(document).on("tap",".contact",function(){
		var url="<%=request.getContextPath()%>/demand/getDemandFactoryContact";
		var params={demandId:$(this).parents(".orderStock").attr("data-id")};
		doAjax("GET",url,params,getContactSuccess,fail,true,false);
	});
		
	function getContactSuccess(data){
		$("#legalPerson").html("联系人："+data.data[0]);
		$("#phoneNumber").html('电话：<a href="tel:'+data.data[1]+'">'+data.data[1]+'</a>');
		$("#delete").show();
		$(".shade").show();
	}
	
	$(".shade,#cancel,#confirm").tap(function(){
		$("#delete").hide();
		$(".shade").hide();
	})
	
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
		window.location.href="<%=request.getContextPath()%>/demand/indexDemand";
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