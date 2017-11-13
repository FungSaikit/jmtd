<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <meta charset="UTF-8">
    <title>佐为照明</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/customer/assets/css/swiper-3.4.2.min.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/common/swiper-3.4.2.min.js"></script>
    <style type="text/css">

        * {
            margin: 0;
            padding: 0;
            font-family: '黑体';
        }

        body {
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }

        .card_div {
            background-color: #eb9c01;
            height: 10rem;
            vertical-align: middle;
            text-align: center;
            color: #fff;
            white-space: nowrap;
            overflow: auto;
            border-bottom: 1px #fff solid;
            position: fixed;
            width: 100%;
            top: 0;
            left: 0;
            z-index: 10;
        }

        .topbar_button {
            width: 1.5rem;
            height: 1.5rem;
            vertical-align: middle;
            padding: 0.5rem;
            position: fixed;
            top: 0;
            left: 0;
        }

        .page {
            color: #fff;
            height: 1rem;
            line-height: 1rem;
            width: 100%;
            background-color: #eb9c01;
            text-align: center;
        }

        .bottom {
            flex-grow: 1;
            position: relative;
            padding: 1rem;
            overflow: scroll;
            margin-top: 13rem;
        }

        .details {
            border-bottom: 1px #efefef solid;
        }

        .detailstop {
            height: 2rem;
        }

        .detailsbottom {
            height: 2rem;
        }

        .price {
            line-height: 2rem;
            float: left;
            font-size: 1rem;
        }

        .status {
            line-height: 2rem;
            float: right;
            color: #027e02;
        }

        .status_error {
            line-height: 2rem;
            float: right;
            color: #f00;
        }

        .status_waiting {
            line-height: 2rem;
            float: right;
            color: #f38200;
        }

        .type {
            line-height: 2rem;
            float: left;
            color: #999;
            font-size: 0.9rem;
        }

        .date {
            line-height: 2rem;
            float: right;
            color: #999;
            font-size: 0.9rem;
        }

        .head {
            text-align: center;
            color: #999;
            font-size: 0.9rem;
        }

        .end {
            text-align: center;
            color: #999;
            font-size: 0.9rem;
        }

        .nolist {
            width: 10rem;
            height: 2rem;
            position: fixed;
            top: 0;
            bottom: 0;
            left: 0;
            right: 0;
            margin: auto;
            text-align: center;
        }

        ul {
            list-style: none;
            height: 3rem;
            background-color: #eb9c01;
            z-index: 10;
            position: fixed;
            top: 10rem;
            width: 100%;
            border-top: 1px #fff solid;
        }

        .option {
            float: left;
            width: 25%;
            text-align: center;
            line-height: 3rem;
            text-decoration: none;
            color: #fff;
            font-weight: lighter;
        }

        #selected {
            font-size: 1.2rem;
            font-weight: bold;
        }

        .swiper-container {
            width: 80%;
            height: 6rem;
            position: relative;
            top: 2.5rem;
        }

        .line1 {
            color: #fff;
            font-size: 1.2rem;
        }

        .moneynumber{
            font-size: 1.8rem;
        }

        .line2 {
            color: #fff;
        }

        .line2_img {
            height: 1.2rem;
            width: 1.2rem;
            vertical-align: bottom;
        }

        .line2_span {
            vertical-align: bottom;
            border-bottom: 1px #fff solid;
        }

        .line3 {
            margin-top: 0.5rem;
            font-size: 0.8rem;
        }

    </style>
</head>
<body>
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
<div class="card_div">
    <img src="<%=request.getContextPath()%>/resources/customer/assets/images/top_bar/back_white.png" 
    	class="topbar_button" onclick="window.location.href='<%=request.getContextPath()%>/buyer/personCenter'">

    <div class="swiper-container">
        <div class="swiper-wrapper">
            <div class="swiper-slide">
                <div class="line1">
                    ¥ <span class="moneynumber">${user.flowMoney }</span>
                </div>
                <div class="line2">
                    <img class="line2_img" src="<%=request.getContextPath()%>/resources/customer/assets/images/personal_center/money_out.png" alt="">
                    <span class="line2_span">可提现货款</span>
                </div>
                <div class="line3">
                    点击提现
                </div>
            </div>
            <div class="swiper-slide">
                <div class="line1" style="margin-top: 0.5rem">
                    ¥ <span class="moneynumber">${user.pendingMoney }</span>
                </div>
                <div class="line2">
                    <img src="<%=request.getContextPath()%>/resources/customer/assets/images/personal_center/money_waiting.png" alt="" class="line2_img">
                    <span class="line2_span">待结金额</span>
                </div>
            </div>
        </div>
        <div class="swiper-button-prev swiper-button-white"></div>
        <div class="swiper-button-next swiper-button-white"></div>
    </div>

</div>

<ul>
    <li><a class="option" onclick="select(this)" data-status="-1" ${settlementStatus==-1?'id="selected"':'' } href="javascript: void(0)">全部</a></li>
    <li><a class="option" onclick="select(this)" data-status="${SETTLE_SUCCESS}" ${settlementStatus==SETTLE_SUCCESS?'id="selected"':'' } href="javascript: void(0)">成功</a></li>
    <li><a class="option" onclick="select(this)" data-status="${SETTLE_FAIL}" ${settlementStatus==SETTLE_FAIL?'id="selected"':'' } href="javascript: void(0)">失败</a></li>
    <li><a class="option" onclick="select(this)" data-status="${PENDING_SETTLE}" ${settlementStatus==PENDING_SETTLE?'id="selected"':'' } href="javascript: void(0)">待结算</a></li>
</ul>

<div class="bottom">
    <div class="head">———— 结算明细 ————</div>
    <hr>



    <br>
    <div class="end">———— 没有更多啦 ————</div>

    <div class="nolist">
        没有本类结算哦
    </div>

</div>

<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
<script type="text/javascript">
    var mySwiper = new Swiper ('.swiper-container', {
        loop: true,
        pagination: '.swiper-pagination',
        nextButton: '.swiper-button-next',
        prevButton: '.swiper-button-prev',
    })
</script>
</body>

<script type="text/javascript">

    var body = document.getElementsByTagName("body")[0];
    var options = document.getElementsByClassName("option");

    var listLength = document.getElementsByClassName("details").length;

    document.getElementsByClassName("nolist")[0].hidden = listLength;
    document.getElementsByClassName("end")[0].hidden = !listLength;

    body.style.height = window.screen.height + "px";

    function select(object) {
        for (var i = 0; i < options.length; i++) {
            options[i].id = "";
        }
        object.id = "selected";
        window.location.href="<%=request.getContextPath()%>/buyer/wallet?settlementStatus="+object.getAttribute("data-status");
    }
    
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
				status="<span class='status_waiting'>待结算</span>";
			if(list[i].settlementStatus==<%=CapitalFlowStatus.SETTLE_SUCCESS%>)
				status="<span class='status'>成功</span>";
			if(list[i].settlementStatus==<%=CapitalFlowStatus.SETTLE_FAIL%>)
				status="<span class='status_error'>失败</span>";
			
			if(list[i].capitalFlowType==<%=CapitalFlowType.WECHAT_CONSUME_GOODS%>||
					list[i].capitalFlowType==<%=CapitalFlowType.WITHDRAW_TO_WECHAT%>||
					list[i].capitalFlowType==<%=CapitalFlowType.WITHDRAW_TO_ACCOUNT%>||
					list[i].capitalFlowType==<%=CapitalFlowType.WECHAT_ONLINE_GOODS%>||
					list[i].capitalFlowType==<%=CapitalFlowType.WECHAT_LAPM_RENT%>)
				money='<span class="money"><span class="sign green">-';
			else
				money='<span class="money"><span class="sign red">+';
        	money+=list[i].money+'</span></span><span class="grey"> 元</span>';
			
        	html+='<div class="details" data-id="'+list[i].capitalFlowId+'">';
        	html+='<div class="detailstop">';
        	html+='<span class="price">￥'+list[i].money+'</span>';
        	html+='<span class="status">'+status+'</span>';
        	html+='</div>';
        	html+='<div class="detailsbottom">';
        	html+='<span class="type">'+type+'</span>';
        	html+='<span class="date">'+showDate(list[i].creatTime)+'</span>';
        	html+='</div>';
        	html+='</div>';
		}
		$(html).insertBefore(".bottom br");/* 
		load.css("visibility","hidden"); */

	    var listLength = document.getElementsByClassName("details").length;

	    document.getElementsByClassName("nolist")[0].hidden = listLength;
	    document.getElementsByClassName("end")[0].hidden = !listLength;
		
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
	
	var canLoad=true;
	var noDate=false;
	var load=$(".end");
	$(function(){
		var wiwH=$(window).height();
		var time;
		loadMore();
		$(".bottom").scroll(function(){
			console.log(load.offset().top+","+$(window).scrollTop()+","+wiwH)
			if(load.offset().top - $(window).scrollTop()<wiwH){
				if(canLoad&&!noDate){
					canLoad=false;
					loadMore();
				}
				if(noDate){
				}
			}else{
				window.clearTimeout(time);
			}
		});
	});
	

	function error(data){
		console.log("fail");
	}
</script>
</html></html>