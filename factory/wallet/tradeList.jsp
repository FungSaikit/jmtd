<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 

<!DOCTYPE html>
<html lang="en" class="walletlistHtml">
<head>
    <meta charset="UTF-8">
    <title>金明同达灯饰</title>
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1"/>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/customer/assets/css/capital.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/common/swiper.min.css"/>
</head>

<body class="walletlistbody">
	<c:set var="WECHAT_CONSUME_GOODS" value="<%=CapitalFlowType.WECHAT_CONSUME_GOODS%>" />
	<c:set var="GOODS_MONEY" value="<%=CapitalFlowType.GOODS_MONEY%>" />
	<c:set var="COMMISION" value="<%=CapitalFlowType.COMMISION%>" />
	<c:set var="WITHDRAW_TO_WECHAT" value="<%=CapitalFlowType.WITHDRAW_TO_WECHAT%>" />
	<c:set var="WITHDRAW_TO_ACCOUNT" value="<%=CapitalFlowType.WITHDRAW_TO_ACCOUNT%>" />
	<c:set var="WECHAT_ONLINE_GOODS" value="<%=CapitalFlowType.WECHAT_ONLINE_GOODS%>" />
	<c:set var="WECHAT_LAPM_RENT" value="<%=CapitalFlowType.WECHAT_LAPM_RENT%>" />
	<c:set var="RETURN" value="<%=CapitalFlowType.RETURN%>" />
	<c:set var="REFUND" value="<%=CapitalFlowType.REFUND%>" />
	<c:set var="SERVICE_FEE" value="<%=CapitalFlowType.SERVICE_FEE %>"/>
	<c:set var="PENDING_SETTLE" value="<%=CapitalFlowStatus.PENDING_SETTLE%>" />
	<c:set var="SETTLE_SUCCESS" value="<%=CapitalFlowStatus.SETTLE_SUCCESS%>" />
	<c:set var="SETTLE_FAIL" value="<%=CapitalFlowStatus.SETTLE_FAIL%>" />
	<c:set var="SALESMAN" value="<%=UserType.SALESMAN%>" />
	<c:set var="CUSTOMER" value="<%=UserType.CUSTOMER%>" />
	<c:set var="AGENCY" value="<%=UserType.AGENCY%>" />
	<c:set var="FACILITATOR" value="<%=UserType.FACILITATOR%>" />
	<div class="swiper-container listContainer">
        <div class="swiper-wrapper">
            <div class="swiper-slide swiper-no-swiping listSlider">
            	<div class="wallet walletDetail">
				    <div class="title">
				    	<i class="iconfont back">&#xe624;</i>
				    	钱包明细
				    </div>
				    <ul class="typeTilter">
				    	<li <c:if test="${settlementStatus==PENDING_SETTLE}">class="active"</c:if>>
				    		<a href="<%=request.getContextPath()%>/factory/tradeList?settlementStatus=${PENDING_SETTLE}&capitalFlowType=${capitalFlowType}">待结算</a></li>
				    	<li <c:if test="${settlementStatus==SETTLE_SUCCESS}">class="active"</c:if>><a href="<%=request.getContextPath()%>/factory/tradeList?settlementStatus=${SETTLE_SUCCESS}&capitalFlowType=${capitalFlowType}">结算成功</a></li>
				    	<li <c:if test="${settlementStatus==SETTLE_FAIL}">class="active"</c:if>><a href="<%=request.getContextPath()%>/factory/tradeList?settlementStatus=${SETTLE_FAIL}&capitalFlowType=${capitalFlowType}">结算失败</a></li>
				    	<li id="comeOut"><a href="javascript:void()">筛选</a></li>
				    </ul>
				    <ul class="allType">
				    	<li <c:if test="${capitalFlowType==-1}">class="active"</c:if>><a href="<%=request.getContextPath()%>/factory/tradeList?settlementStatus=${settlementStatus}&capitalFlowType=-1">全部</a></li>
				    	<li <c:if test="${capitalFlowType==WITHDRAW_TO_ACCOUNT}">class="active"</c:if>><a href="<%=request.getContextPath()%>/factory/tradeList?settlementStatus=${settlementStatus}&capitalFlowType=${WITHDRAW_TO_ACCOUNT}">提现到银行卡</a></li>
				    	<li <c:if test="${capitalFlowType==REFUND}">class="active"</c:if>><a href="<%=request.getContextPath()%>/factory/tradeList?settlementStatus=${settlementStatus}&capitalFlowType=${REFUND}">退款</a></li>
				    	<li <c:if test="${capitalFlowType==RETURN}">class="active"</c:if>><a href="<%=request.getContextPath()%>/factory/tradeList?settlementStatus=${settlementStatus}&capitalFlowType=${RETURN}">退货</a></li>
				    	<li <c:if test="${capitalFlowType==GOODS_MONEY}">class="active"</c:if>><a href="<%=request.getContextPath()%>/factory/tradeList?settlementStatus=${settlementStatus}&capitalFlowType=${GOODS_MONEY}">货款</a></li>
				    </ul>
				    <div class="detailDiv">
				    	
				    </div>
				    <div class="noWallet">
						<span><i class="iconfont">&#xe60b;</i></span>
						<p>您还没有相关钱包记录</p >
					 </div>
				    <div class="loading" style="visibility: visible;"><i class="iconfont">&#xe62c;</i><span id="jiazai">加载中...</span></div>
				</div>
            </div>
            <div class="swiper-slide swiper-no-swiping oneSlider">
            	<div class="trade wallet">
					 <div class="title">
				     	<i class="iconfont back prev">&#xe624;</i>
				     	明细
				     </div>
				     <div class="detailWallet">
				     	
				     </div>
				    
				</div>
            </div>
		</div>
	</div>
	
	
	<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
	<script src="<%=request.getContextPath() %>/resources/common/swiper.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
	<script>
		var swiper = new Swiper('.listContainer',{
			noSwiping : true,
		});
		$(".listContainer").css("height",$(window).height());
	
	 	var wid=$(window).width();
	    $(".allType").css("top",$(".title").height()+$(".typeTilter").height());
	   
		$(".allType li").tap(function(){
			$(".allType li").removeClass("active");
			$(this).addClass("active");
			$(".allType").css("width","0px");
			$("#comeOut").removeClass("active");
		});
		$(".typeTilter li").not("#comeOut").tap(function(){
			$(".typeTilter li").removeClass("active");
			$(this).addClass("active");
			$(".allType").css("width","0px");
			$("#comeOut").removeClass("active");
		});
		$("#comeOut").tap(function(){
			if($(".allType").css("width")=="0px"){
				$(".typeTilter li").removeClass("active");
				$(this).addClass("active");
				$(".allType").css("width",wid);
			}else{
				$(this).removeClass("active");
				$(".allType").css("width","0px");
			}
		});
		
		$(document).on("tap",".oneDiv",function(){
			//ajax加载详情页的信息
			swiper.slideNext();
			getCapitalDetail($(this).attr("data-id"));
		});
		$(".prev").tap(function(){
			swiper.slidePrev();
			$(".allType").css("width","0px");
			$("#comeOut").removeClass("active");
		});
		$(".back").tap(function(){
			if(!$(this).hasClass("prev")){
				window.location.href='<%=request.getContextPath()%>/factory/wallet';
			}
		});
	
	var offset=0;
	function loadMore(){
		var url;
		url="<%=request.getContextPath()%>/buyer/tradeListAjax?settlementStatus=${settlementStatus}&capitalFlowType=${capitalFlowType}&offset="+offset;
		
		var data={};
		doAjax("GET",url,data,success,error,true,false);
	}
	
	function success(data){
		var list =data.data.list;
		var html="";
		
		if(list.length==0)
			$(".noWallet").show();
		else
			$(".noWallet").hide();
		
		for(var i=0;i<list.length;i++){
			var type,status,money;
			if(list[i].capitalFlowType==<%=CapitalFlowType.WECHAT_CONSUME_GOODS%>)
				type="微信购买商品";
			if(list[i].capitalFlowType==<%=CapitalFlowType.GOODS_MONEY%>)
				type="货款";
			if(list[i].capitalFlowType==<%=CapitalFlowType.COMMISION%>)
				type="佣金";
			if(list[i].capitalFlowType==<%=CapitalFlowType.WITHDRAW_TO_WECHAT%>)
				type="提现到微信零钱";
			if(list[i].capitalFlowType==<%=CapitalFlowType.WITHDRAW_TO_ACCOUNT%>)
				type="提现到银行卡";
			if(list[i].capitalFlowType==<%=CapitalFlowType.WECHAT_ONLINE_GOODS%>)
				type="微信上线商品";
			if(list[i].capitalFlowType==<%=CapitalFlowType.WECHAT_LAPM_RENT%>)
				type="微信租赁灯位";
			if(list[i].capitalFlowType==<%=CapitalFlowType.RETURN%>)
				type="退货";
			if(list[i].capitalFlowType==<%=CapitalFlowType.REFUND%>)
				type="退款";
			if(list[i].capitalFlowType==<%=CapitalFlowType.SERVICE_FEE%>)
				type="服务费";
			
			if(list[i].settlementStatus==<%=CapitalFlowStatus.PENDING_SETTLE%>)
				status="待结算";
			if(list[i].settlementStatus==<%=CapitalFlowStatus.SETTLE_SUCCESS%>)
				status="结算成功";
			if(list[i].settlementStatus==<%=CapitalFlowStatus.SETTLE_FAIL%>)
				status="结算失败";
			
			if(list[i].capitalFlowType==<%=CapitalFlowType.WECHAT_CONSUME_GOODS%>||
					list[i].capitalFlowType==<%=CapitalFlowType.WITHDRAW_TO_WECHAT%>||
					list[i].capitalFlowType==<%=CapitalFlowType.WITHDRAW_TO_ACCOUNT%>||
					list[i].capitalFlowType==<%=CapitalFlowType.WECHAT_ONLINE_GOODS%>||
					list[i].capitalFlowType==<%=CapitalFlowType.WECHAT_LAPM_RENT%>)
				money='<span class="money"><span class="sign green">-';
			else
				money='<span class="money"><span class="sign red">+';
        	money+=list[i].money+'</span></span><span class="grey"> 元</span>';
			

    		html+='<div class="oneDiv" data-id="'+list[i].capitalFlowId+'">';
    		html+='<div class="inLeft">';
    		html+='<span>'+type+'</span>';
    		html+='<span>'+status+'</span>';
    		html+='<span>'+showDate(list[i].creatTime)+'</span>';
    		html+='</div><div class="inRight">';
    		html+='<span>￥'+list[i].money+'<span>';
    		html+='<span>&nbsp;</span>';
    		html+='</div></div>';
		}
		$(".detailDiv").append(html);
		load.css("visibility","hidden");
		if(parseInt(offset+10)>=data.data.count){
			noDate=true;
		}
		offset=data.data.after;
		canLoad=true;
		
	}
	
	function showDate(str){
		var date = new Date(str);
		return date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate()+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds();
	}
	
	function error(data){
	}
	
	var canLoad=true;
	var noDate=false;
	var load=$(".loading");
	$(function(){
		var wiwH=$(window).height();
		var time;
		loadMore();
		$(".listSlider ").scroll(function(){
			if(load.offset().top - $(window).scrollTop()<wiwH){
				if(canLoad&&!noDate){
    				load.css("visibility","visible");
					canLoad=false;
					loadMore();
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
	
	function getCapitalDetail(capitalFlowId){
		var url="<%=request.getContextPath()%>/factory/tradeDetail";
		var params={capitalFlowId:capitalFlowId};
		doAjax("GET",url,params,getDetailSuccess,error,true,false);
	}
	
	function getDetailSuccess(data){
		var cf = data.data;
		var html="";
		
		var type,status,money;
		if(cf.capitalFlow.capitalFlowType==<%=CapitalFlowType.WECHAT_CONSUME_GOODS%>)
			type="微信购买商品";
		if(cf.capitalFlow.capitalFlowType==<%=CapitalFlowType.GOODS_MONEY%>)
			type="货款";
		if(cf.capitalFlow.capitalFlowType==<%=CapitalFlowType.COMMISION%>)
			type="佣金";
		if(cf.capitalFlow.capitalFlowType==<%=CapitalFlowType.WITHDRAW_TO_WECHAT%>)
			type="提现到微信零钱";
		if(cf.capitalFlow.capitalFlowType==<%=CapitalFlowType.WITHDRAW_TO_ACCOUNT%>)
			type="提现到银行卡";
		if(cf.capitalFlow.capitalFlowType==<%=CapitalFlowType.WECHAT_ONLINE_GOODS%>)
			type="微信上线商品";
		if(cf.capitalFlow.capitalFlowType==<%=CapitalFlowType.WECHAT_LAPM_RENT%>)
			type="微信租赁灯位";
		if(cf.capitalFlow.capitalFlowType==<%=CapitalFlowType.RETURN%>)
			type="退货";
		if(cf.capitalFlow.capitalFlowType==<%=CapitalFlowType.REFUND%>)
			type="退款";
		if(cf.capitalFlow.capitalFlowType==<%=CapitalFlowType.SERVICE_FEE%>)
			type="服务费";
		
		if(cf.capitalFlow.settlementStatus==<%=CapitalFlowStatus.PENDING_SETTLE%>)
			status="待结算";
		if(cf.capitalFlow.settlementStatus==<%=CapitalFlowStatus.SETTLE_SUCCESS%>)
			status="结算成功";
		if(cf.capitalFlow.settlementStatus==<%=CapitalFlowStatus.SETTLE_FAIL%>)
			status="结算失败";
		
		html+='<table>';
		html+='<tr><td>交易单号</td>';
		html+='<td>'+cf.capitalFlow.capitalFlowId+'</td></tr>';
 		html+='<tr><td>状态</td>';
 		html+='<td>'+status+'</td></tr>';
 		html+='<tr><td>类型</td>';
 		html+='<td>'+type+'</td></tr>';
 		html+='<tr><td>交易金额</td>';
 		html+='<td>￥'+cf.capitalFlow.money+'</td></tr>';
 		if(type=="提现到银行卡"){
	 		html+='<tr><td>手续费</td>';
	 		html+='<td>￥'+(cf.withdrawToCreditCard.withdrawMoney-cf.capitalFlow.money).toFixed(2)+'</td></tr>';
		}
 		html+='<tr><td>创建时间</td>';	
 		html+='<td>'+showDate(cf.capitalFlow.creatTime)+'</td></tr>';
 		if(cf.capitalFlow.settleTime!=null){
	 		html+='<tr><td>结算时间</td>';
	 		html+='<td>'+showDate(cf.capitalFlow.settleTime)+'</td></tr>';
 		}	
 		/*if(type=="货款"){
 			html+='<tr><td><a href="<%=request.getContextPath()%>/factory/"><button>查看详情</button></a></td></tr>';
 		}*/
 		html+='</table>';
 		$(".detailWallet").html(html);
	}
	</script>
</body>
</html>