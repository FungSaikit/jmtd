<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>佐为照明</title>
    <link href="<%=request.getContextPath() %>/resources/common/bootstrap.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/common/swiper.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/customer/assets/css/address.css" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
</head>
<body>
<div class="logisticsTrack">
    <div class="title">物流追踪</div>
    <div class="logistics-msg">
        <div class="company">物流公司：${logisticsCompanyName }</div>
        <div class="logistics-num">物流单号：${logisticsCode }</div>
    </div>
    <div class="logistics">
        
        
    </div>
</div>

<!--[[底部-->
<c:if test="${user.role==1}">
	<jsp:include page="/jsp/factory/footer.jsp"></jsp:include>
</c:if>
<c:if test="${user.role!=1}">
	<jsp:include page="/jsp/buyer/footer.jsp"></jsp:include>
</c:if>
<!--底部]]-->
<script>
	$(function(){
		var urlStr = "<%=request.getContextPath()%>/buyer/consult?type=${logisticsCompanyCode}&postId=${logisticsCode}";
		//alert("Before Call:"+urlStr);
		$.ajax({
    			method: "GET",
    			url: urlStr,
    			success:function(data,status,jqXHR){
    				if(data=="error"){
    					$(".logistics").html("");
    					var li="没有对应订单";
    					$(".logistics").append(li);
    				}else{
    					var json = $.parseJSON(data); 
    					
    					var ul=$(".logistics");
    					ul.html("");
    					var li;
    					for(var i=json.data.length-1;i>=0;i--){
    						var info = json.data[i];
    						if(i==0){
    							li="<div class='step clearfix red'>";
    						}else{
    							li="<div class='step clearfix'>";
    						}
    						li+="<div class='time col-xs-5 text-right'>"+info.time+"</div>"+
    			            	"<div class='address col-xs-6'>"+info.context+"</div>"+
    			            	"</div>";
    						ul.append(li);
    					}
    				}
    			}
		});
		//doAjax(false,false,"GET",url,params,success,fail);
	})
	
	function success(data){
		//alert("Success:"+data);				
		if(data=="error"){
			$(".logistics").html("");
			var li="没有对应订单";
			$(".logistics").append(li);
		}else{
			var json = $.parseJSON(data); 
			
			var ul=$(".logistics");
			ul.html("");
			var li;
			for(var i=json.data.length-1;i>=0;i--){
				var info = json.data[i];
				if(i==0){
					li="<div class='step clearfix red'>";
				}else{
					li="<div class='step clearfix'>";
				}
				li+="<div class='time col-xs-5 text-right'>"+info.time+"</div>"+
	            	"<div class='address col-xs-6'>"+info.context+"</div>"+
	            	"</div>";
				ul.append(li);
			}
		}
	}
	
	function fail(data){
		alert("fail");
	}
</script>
</body>
</html>