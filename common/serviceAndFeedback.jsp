<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>佐为照明</title>
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/customer/assets/css/personCenter.css?121dd" rel="stylesheet">
</head>
<body>
<c:set var="SALESMAN" value="<%=UserType.SALESMAN%>" />
<c:set var="FACTORY" value="<%=UserType.FACTORY%>" />
<c:set var="AGENCY" value="<%=UserType.AGENCY%>" />
<c:set var="CUSTOMER" value="<%=UserType.CUSTOMER%>" />
<c:set var="DEMAND_FACTORY" value="<%=UserType.DEMAND_FACTORY%>" />
<c:set var="UNAUTHORIZED" value="<%=UserCheckStatus.UNAUTHORIZED%>" />
<c:set var="AUTHENTICATION_FAILURE" value="<%=UserCheckStatus.AUTHENTICATION_FAILURE%>" />
<div class="serviceAndFeedback">
    <div class="title"><i class="iconfont prevPage" >&#xe63f;</i>服务反馈 
    	<c:if test="${!(user.role!=5&&user.upperUserId==1) }"><a href="javascript:nextPage()"><i class="iconfont">&#xe618;</i></a></c:if>
    </div>
    <div class="feedBackDiv">
    	<form action="">
    		<div class="serviceDiv"><!-- 
    			<label>请在下方输入您对我们平台的建议</label> -->
    			<textarea id="opinion" placeHolder="请输入遇到的问题或建议"></textarea>
    		</div>
    		<div class="serviceDiv">
    			<label>联系电话</label>
    			<input type="text" id="way" placeHolder="选填，便于我们联系你"/>
    		</div>
    		<a href="javascript:submit()"><input type="button" class="submit" value="提　交"/></a>
    	</form>
    </div>
</div> 
<div class="chooseRole" style="display:none">
	<div class="title">选择认证身份
    	<a href="javascript:prevPage()"><i class="iconfont leftI">&#xe63f;</i></a>
    	<c:if test="${user.upperUserId!=1 }"><a href="javascript:toDelRelation()"><i class="iconfont rightI">&#xe603;</i></a></c:if>
    </div>
    <div class="chooseRoleDiv">
   	 	<%-- <a href="<%=request.getContextPath()%>/user/authenticate?role=${DEMAND_FACTORY}&userId=${user.userId}">成为厂家</a>
    	<c:if test="${sessionScope.openId=='oQO-Qwu4DMV2DEOeacxdIKS6cVRQ'}">
    	<a href="<%=request.getContextPath()%>/user/authenticate?role=${FACTORY}&userId=${user.userId}">成为厂家供应</a>
    	</c:if> --%>
    	<a href="<%=request.getContextPath()%>/user/authenticate?role=${AGENCY}&userId=${user.userId}">注册经销商</a> 
    	<a href="<%=request.getContextPath()%>/user/authenticate?role=${SALESMAN}&userId=${user.userId}">注册业务员</a>
    </div>
</div>
<div class="delRelation" style="display:none">
	<div class="title">解除绑定
    	<a href="javascript:prevPage1()"><i class="iconfont">&#xe63f;</i></a>
    </div>
    <div class="delRelationDiv">
    	<form action="<%=request.getContextPath()%>/buyer/unbunding" id="unbundForm">
   			<label style="width:100%;">您当前的客服是：${upperUser.userNickname}</label>
   			<textarea placeHolder="请输入解绑理由" name="unbundingReason" style="margin-top:.2rem;"></textarea>
	   		<a href="javascript:unbund()"><input type="button" class="submit" value="解 除 绑 定"/></a>
	   	</form>
    </div>
</div> 
<!--[[底部-->

<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/jweixin-1.0.0.js"></script>
<script>
	function nextPage(){
		<c:if test="${user.role==5}">
			$(".chooseRole").show();
			$(".serviceAndFeedback").hide();
			$(".delRelation").hide();
		</c:if>
		<c:if test="${user.role!=5&&user.upperUserId!=1}">
			$(".chooseRole").hide();
			$(".serviceAndFeedback").hide();
			$(".delRelation").show();
		</c:if>
	}
	
	function prevPage(){
		$(".serviceAndFeedback").show();
		$(".chooseRole").hide();
		$(".delRelation").hide();
	}
	
	function toDelRelation(){
		$(".serviceAndFeedback").hide();
		$(".chooseRole").hide();
		$(".delRelation").show();
	}
	
	function prevPage1(){
		<c:choose>
			<c:when test="${user.role==5&&user.upperUserId!=1}">
				$(".serviceAndFeedback").hide();
				$(".chooseRole").show();
				$(".delRelation").hide();
			</c:when>
			<c:otherwise>
				$(".serviceAndFeedback").show();
				$(".chooseRole").hide();
				$(".delRelation").hide();
			</c:otherwise>
		</c:choose>
	}
	
	function submit(){
	  	if($("#way").val()==""||$("#opinion").val()==""){
	  		showTip("必须填写");
	  	}else{
	  		$.ajax({
				type:"post",
				url:"<%=request.getContextPath()%>/cors/freeback",
				async:false,
				data:{"contactWay":$("#way").val(),"opinion":$("#opinion").val()},
				success:function(data){
					console.log(window.innerHeight/2-parseInt($(".submit-tips").eq(0).css("top"))/2+"px")
					showTip(data.retMsg);
					if(data.code=="1"){
						$("#opinion").val("");
						$("#way").val("");
					}
				},
				error:function(data){
					console.log(data);
				}
			});
	    }
	}
	
	function showTip(content){
		$(".tip").html(content);
		$(".tip").css("opacity","0.8");
		setTimeout(function(){
			$(".tip").css("opacity","0");
		},1000);
	}
	
	function unbund(){
		var url = "<%=request.getContextPath()%>/buyer/unbunding";
		var params = $("#unbundForm").serialize();
		doAjax("GET",url,params,success,fail,true,false);
	}
	
	function success(data){
		showTip("解绑申请提交成功");
	}
	
	function fail(){
		alert("失败");
	}
	
	$(".prevPage").tap(function(){
		window.location.href="<%=request.getContextPath()%>/buyer/personCenter";
	});
</script>
</body>
</html>