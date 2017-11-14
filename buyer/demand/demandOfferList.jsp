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
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
    <style>
    	.contact{
    		color:red;
    	}
    </style>
</head>
<body>
<div class="orderStock">
    <div class="title">
    	<i class="iconfont prevPage">&#xe624;</i>报价详情</div>
    <div class="stockInfo">      
   		<div class="loading" style="visibility: visible;"><i class="iconfont">&#xe62c;</i><span id="jiazai">加载中...</span></div> 		
   		<div class="submitDiv">
   			<c:if test="${empty complete}">
   				<div class="submit submitBtn"><a>提　交</a></div>
   			</c:if>
   		</div>
    </div>
</div>
<div class="tip"></div>
<div class="shade"></div>
<!--[[底部-->
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
<form action="<%=request.getContextPath()%>/demand/chooseDemandOffer">
	<input type="hidden" name="demandOfferIds" id="demandOfferIds"/>
</form>
<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/jweixin-1.0.0.js"></script>
<!--底部]]-->
<script>
	$(document).on("tap",".checkBox",function(){
		var index=0;
		$(".checkBox").each(function(){
			if($(this).hasClass("active")){		
				index++;
			}
		});
		
		
		if($(this).hasClass("active")){
			$(this).removeClass("active");
		}else{
			/* $(".checkBox").each(function(){
				$(this).removeClass("active");
			}); */
			if(index<3){
				$(this).addClass("active");
			}else{
				showTip("最多选择三份报价");
			}
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
		var url="<%=request.getContextPath()%>/demand/demandOfferListAjax";
		var params={offset:offset,demandId:${demandId}};
		doAjax("GET",url,params,loadSuccess,fail,true,false);
	}
	
	var index=1;
	function loadSuccess(data){
		var demandList = data.data.list;
		var html="";
		for(var i=0;i<demandList.length;i++){
			html+='<div class="orderStock" data-id="'+demandList[i].demandOfferId+'"><div class="orderStockHead">';
			html+='<p class="fl">提交时间：'+showDate(demandList[i].creatTime)+'</p>';
			if(${empty complete})
				html+='<span class="checkBox getGoods" data-id="'+demandList[i].demandOfferId+'"><i class="iconfont">&#xe611;</i></span>'; 
			html+='</div><div class="orderStockBody">';
			html+='<div class="stock" data-id="1">';
			html+='<div class="stockNum"><div>报价：'+demandList[i].demandPrice+'</div><div class="imgBox">';/* 
			html+='<img src="'+demandList[i].demandPrice+'" alt="">'; */
			html+='</div></div><div class="stockNum"><div><label>交货天数：'+demandList[i].timeLimit+'</label>';
			html+='<div>';
			html+='</div><span>天</span></div></div><table>';
			html+='<tr>';
			html+='<td class="detail">查看详情</td>'
			if(demandList[i].demandOfferStatus==1)
				html+='<td class="contact">联系方式</td>';
			html+='</tr>';
			html+='</table></div></div></div>';
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
		var url="<%=request.getContextPath()%>/demand/getDemandFactoryContactByDemandOfferId";
		var params={demandOfferId:$(this).parents(".orderStock").attr("data-id")};
		doAjax("GET",url,params,getContactSuccess,fail,true,false);
	});
	
	function getContactSuccess(data){
		$("#legalPerson").html("联系人："+data.data[0]);
		$("#phoneNumber").html('电话：<a href="tel:'+data.data[1]+'">'+data.data[1]+'</a>');
		$("#delete").show();
		$(".shade").show();
	}
	
	$(document).on("tap",".detail",function(){
		window.location.href="<%=request.getContextPath()%>/demand/demandOfferDetail?demandOfferId="+$(this).parents(".orderStock").attr("data-id");
	});
	
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
	
	var clicked=false;
	$(document).on("tap",".submit",function(){
		$(".shade").show();
		$(".waiting").show();
		if(clicked==false){
			clicked=true;
			var dataId="";
			$(".checkBox").each(function(){
				if($(this).hasClass("active")){		
					dataId+=$(this).attr("data-id")+",";
				}
			});
			if(dataId==""){
				showTip("请至少选择一份报价");
				clicked=false;
			}else{
				dataId=dataId.substring(0,dataId.length-1);
				$("#demandOfferIds").val(dataId);
				$("form").submit();
			}
		}
	});
	
	
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
	
	$(".shade,#cancel,#confirm,#closeConfirm").tap(function(){
		$("#delete").hide();
		$(".shade").hide();
	})
</script>
</body>
</html>