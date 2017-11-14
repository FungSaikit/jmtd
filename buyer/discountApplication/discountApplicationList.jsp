<%@ page language="java" import="java.util.*,com.alphaking.constant.*,com.alphaking.model.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>金明同达灯饰</title>
    <meta name="format-detection" content="telephone=no">
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/common/swiper.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/customer/assets/css/classify.css?88" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
</head>
<body>
<c:set var="CUSTOMER" value="<%=UserType.CUSTOMER%>"/>
<c:set var="AGENCY" value="<%=UserType.AGENCY%>" />
<c:set var="FACILITATOR" value="<%=UserType.FACILITATOR%>" />
<div class="spreadMember">
	<div class="swiper-container memContainer">
        <div class="swiper-wrapper">
            <div class="swiper-slide swiper-no-swiping memSlider">
			    <div class="title">
			    	折扣
			    </div>
				
				<div class="searchDiv">
					<input type="text" class="searchInput" placeholder="请输入客户昵称" value="${keyword}"/>
					<i class="iconfont" id="clear">&#xe628;</i>
				</div>
				<div class="hasClient">
					<div class="memList">
						<c:forEach items="${discountList}" var="da" varStatus="i">
		            		<div class="member" data-id="${da.discountApplicationId }">
		            			<div class="leftDiv">
		            				<span class="memName">
		            					<span>${da.discountTitle}</span><i class="iconfont sale"></i>
		            				</span>
		            			</div>
		            			<div class="rightDiv">
		            				<c:choose>
		            					<c:when test="${da.discountStatus==0}">待审核</c:when>
		            					<c:when test="${da.discountStatus==1}">通过</c:when>
		            					<c:when test="${da.discountStatus==2}">失败</c:when>
		            				</c:choose>
		            			</div>
		            			<!-- <span class="toSpan"><i class="iconfont goToDetail"></i></span>
		            			<div class="rightDiv">
		            				<span class="memNum">0/0</span><span class="memScore" style="display:none">【0】</span>
		            			</div> -->
		            		</div>
	            		</c:forEach>
					</div>
					<!--<p class="allMem">共<span id="allNum"></span>个客户</p>
					 <div class="loading" style="visibility: visible;"><i class="iconfont">&#xe62c;</i><span id="jiazai">加载中...</span></div>        		 -->
				</div>
				<ul class="memFilter" style="margin-top:10px;"><!-- 
					<li><a href="javascript:sortByScore();">分数</a></li>
					<li><a href="javascript:sortByTradeTimes();">交易次数</a></li>
					<li><a href="javascript:sortByTradeMoney();">交易量</a></li> --> 
					<!--对搜索结果去除i标签，写上关键字-->
					<%-- 
					<li class="search"><c:choose><c:when test="${empty keyword }"><i class='iconfont'>&#xe610;</i></c:when>
								<c:otherwise>${keyword }</c:otherwise></c:choose></li> --%>
					<li style="width:100%;background-color:#F00;color:#FFF;" id="addStaff"><span>申请</span></li>
				</ul>
	           <div class="noClient">
	            	<span><i class="iconfont">&#xe600;</i></span>
	            	<p id="spreadTipP">您还没有自己的客户哦！继续加油吧！</p>
	            	<!-- <p id="spreadTipP">没有符合条件的客户</p> -->
	            </div>
			</div>
         </div>
    </div>
</div>
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
<jsp:include page="/jsp/buyer/footer.jsp"></jsp:include>
<!--底部]]-->
<script>
	$("#addStaff").tap(function(){
		window.location.href="<%=request.getContextPath()%>/buyer/toAddDiscountApplication";
	});
	
	$(document).on("longTap",".member",function(){
		$("#delete").show();
		$(".shade").show();
		data_id=$(this).attr("data-id");
	});
	
	$("#confirm").tap(function(){
		if($("#delete").find("p").html()=="确定删除？"){
			/* 用ajax将此数据变为不可见 */
			deleteDiscountApplication();
			$("#allNum").html(parseInt($("#allNum").html())-1);
		}else{
			/* 用ajax将此数据变为可见 */
			showClientInfo();
			$("#allNum").html(parseInt($("#allNum").html())+1);
		}
		$(".member[data-id='"+data_id+"']").remove();
		$("#delete").hide();
		$(".shade").hide();
	});
	
	$(".shade").tap(function(){
		$("#delete").hide();
		$(this).hide();
	});
	$("#closeConfirm").tap(function(){
		$("#delete").hide();
		$(".shade").hide();
	});
	$("#cancel").tap(function(){
		$("#delete").hide();
		$(".shade").hide();
	});
	
	var data_id=0;
	function deleteDiscountApplication(){
		var url="<%=request.getContextPath()%>/buyer/deleteDiscountApplication";
		var params={discountApplicationId:data_id};
		doAjax("GET",url,params,deleteSuccess,function(data){console.log("fail");},true,false);
	}
	
	function deleteSuccess(data){
		var ci=data.data;
	}
</script>
</body>
</html>