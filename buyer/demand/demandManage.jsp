<%@ page language="java" import="java.util.*,com.alphaking.constant.*,com.alphaking.model.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>金明同达灯饰</title>
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1"/>
    <link href="<%=request.getContextPath() %>/resources/customer/assets/css/personCenter.css?abee" rel="stylesheet">
	<style>
		a{text-decoration: none;}
		.orderNum {
			display:inline-block;
		    top: -0.1rem;
		    left: 50%;
		    background-color: rgba(255,0,0,0.7);
		    width: .7rem;
		    height: .7rem;
		    text-align: center;
		    line-height: .7rem;
		    border-radius: 50%;
		    color: #fff;
		    font-size: .4rem;
		}
		#title{
		    font-size: 0.7rem;
		    text-align: center;
		    line-height: 1.2rem;
		    height: 1.2rem;
		    background-color: red;
		    color: #ffffff;
		    position: relative;
		    font-family: "微软雅黑";
		}
		.prevPage {
		    position: absolute;
		    left: 0px;
		    display: inline-block;
		    height: 1.2rem;
		    width: 1.2rem;
		    font-size: 0.7rem;
		    padding-left: 1rem;
		    color: #ffffff;
		    -webkit-transform: rotate(180deg);
		    transform: rotate(180deg);
		}
	</style>
</head>
<body class="index">
<c:set var="SALESMAN" value="<%=UserType.SALESMAN%>" />
<c:set var="CUSTOMER" value="<%=UserType.CUSTOMER%>" />
<c:set var="AGENCY" value="<%=UserType.AGENCY%>" />
<c:set var="FACTORY" value="<%=UserType.FACTORY%>" />
<c:set var="DEMAND_FACTORY" value="<%=UserType.DEMAND_FACTORY%>" />
<c:set var="FACILITATOR" value="<%=UserType.FACILITATOR%>" />
<c:set var="AGENT" value="<%=UserType.AGENT %>"/>
<c:set var="RETAIL_SALES" value="<%=UserType.RETAIL_SALES %>"/>
<c:set var="UNAUTHORIZED" value="<%=UserCheckStatus.UNAUTHORIZED%>" />
<c:set var="AUTHORIZING" value="<%=UserCheckStatus.AUTHORIZING%>" />
<c:set var="AUTHENTICATION_FAILURE" value="<%=UserCheckStatus.AUTHENTICATION_FAILURE%>" />
<c:set var="AUTHENTICATION_SUCCESS" value="<%=UserCheckStatus.AUTHENTICATION_SUCCESS%>" />
<c:set var="OBLIGATION" value="<%=OrderStatus.OBLIGATION%>" />
<c:set var="TO_BE_SHIPPED" value="<%=OrderStatus.TO_BE_SHIPPED%>" />
<c:set var="TO_BE_SIGNED" value="<%=OrderStatus.TO_BE_SIGNED%>" />
<c:set var="SIGNED" value="<%=OrderStatus.SIGNED%>" />
<c:set var="FINISHED" value="<%=OrderStatus.FINISHED%>" />
<c:set var="CLOSED" value="<%=OrderStatus.CLOSED%>" />

<div class="personCenter">
<!--[[个人中心--会员-->
<div class="person-member">
	<div id="title">
		<i class="iconfont prevPage payPrev" >&#xe624;</i>
		管理
	</div>
	<%-- <div class="person-msg clearfix">
	    <a href="javascript:history.go(-1);" class="prePage"><i class="iconfont">&#xe624;</i></a>
    	<img src="${user.userProtraitPic }" alt=""/>
    	<p><i class="iconfont changjia">&#xe61a;</i>${user.userNickname}</p>
    </div> --%><!-- 
    <div class="link" style="text-align:center;height:1rem;line-height:1rem;"><h3>需求管理</h3></div> -->
    <c:if test="${!empty user && user.role!=5 }">
    	<!-- <div class="link" style="text-align:center;height:1rem;line-height:1rem;"><h3>报价管理</h3></div>
	    --> <div class="clearfix">
	        <a href="<%=request.getContextPath() %>/demand/manageSubscribes" class="clearfix">
	            <div class="pull-left"><span class="iconSpan" id="color6"><i class="icon iconfont">&#xe63c;</i></span>我的关注</div>
	            <div class="pull-right"> <i class="iconfont" style="font-size:18px;">&#xe624;</i></div>
	        </a>
	    </div>
    </c:if>
    <div class="clearfix link">
    	<c:if test="${sessionScope.openId=='notFollow'}"><a href="javascript:alert('请先关注繁灯网')" class="clearfix"></c:if>
    	<c:if test="${sessionScope.openId!='notFollow' }"><a href="<%=request.getContextPath() %>/demand/demandList" class="clearfix"></c:if>
            <div class="pull-left"><span class="iconSpan" id="color1"><i class="icon iconfont big">&#xe622;</i></span>我的需求
            	<span class="orderNum" id="demandOfferNumber" style="display:none"></span>
            </div>
            <div class="pull-right"><i class="iconfont" style="font-size:18px;">&#xe624;</i></div>
        </a>
    </div>
    <%-- <c:if test="${!empty user && user.role!=5 }"> 
    <div class="clearfix">
        <a href="<%=request.getContextPath() %>/demand/toUploadDemand" class="clearfix">
            <div class="pull-left"><span class="iconSpan" id="color3"><i class="icon iconfont big">&#xe667;</i></span>上传需求</div>
            <div class="pull-right"><i class="iconfont" style="font-size:18px;">&#xe624;</i></div>
        </a>
    </div>
    </c:if> --%>
    
   
	    <div class="clearfix link">
	    <c:if test="${sessionScope.openId=='notFollow'}"><a href="javascript:alert('请先关注繁灯网')" class="clearfix"></c:if>
        <c:if test="${sessionScope.openId!='notFollow'}"><a href="<%=request.getContextPath() %>/demand/myDemandOffer" class="clearfix"></c:if>
            <div class="pull-left"><span class="iconSpan" id="color4"><i class="icon iconfont">&#xe62d;</i></span>我的报价</div>
            <div class="pull-right"> <i class="iconfont" style="font-size:18px;">&#xe624;</i></div>
        </a>
        </div>
</div>
<div class="tip"></div>
<!--个人中心--会员]]-->
</div>
<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/jweixin-1.0.0.js"></script>

</body>
<script>
	$(".mOrder .orderNum").each(function(){
		loadOrderNum($(this));
	});
	
	$(".lowUserOrder .orderNum").each(function(){
		loadLowUserOrderNum($(this));
	});
	
	function loadOrderNum($obj){
		var status=$obj.attr("data-status");
		var url="";
		if(status=="return")
			url="<%=request.getContextPath()%>/user/countReturnNum?isBuyer=true";
		else
			url="<%=request.getContextPath()%>/user/countOrderNum?orderStatus="+status
				+"&isBuyer=true";
		$.ajax({
			type: "get",
			url: url,
			success:function(data) {
				if(data.data>0){
	   		 		$obj.html(data.data);
					$obj.show();
				}
	   		},
	  		error: function(data) {      			
	  		
	  		}
		});
	}
	
	function loadLowUserOrderNum($obj){
		var status=$obj.attr("data-status");
		var url="";
		if(status=="return")
			url="<%=request.getContextPath()%>/user/countLowUserListReturnNum";
		else
			url="<%=request.getContextPath()%>/user/countLowUserOrderNum?orderStatus="+status;
		$.ajax({
			type: "get",
			url: url,
			success:function(data) {
				if(data.data>0){
	   		 		$obj.html(data.data);
					$obj.show();
				}
	   		},
	  		error: function(data) {      			
	  		
	  		}
		});
	}
	
	getDemandOfferNumber();
	
	function getDemandOfferNumber(){
		var url="<%=request.getContextPath()%>/demand/countNewDemandOfferNumber";
		var params={};
		doAjax("GET",url,params,function(data){
			if(data.data!=0){
				$("#demandOfferNumber").html(data.data);
				$("#demandOfferNumber").show();
			}
		},function(data){console.log("fail"),true,false})
	}
	
	$(".prevPage ").tap(function(){
		window.location.href="<%=request.getContextPath()%>/demand/indexDemand";
	});
</script>
</html>
