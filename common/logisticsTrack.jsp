<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html class="logisticsHtml">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>佐为照明</title>
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/customer/assets/css/address.css" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
    <style>
    	 .tableInfo table{
			background-color:#fff;
			width:100%;
			color:#000;
			font-size:.5rem;
			border-collapse: collapse;
		}
		.tableInfo table{
			color:#999;
		}
		 .tableInfo table tr{
			width:100%;
		}
		.tableInfo table tr:not(:last-child) td{
			border-bottom:1px solid #f3f3f3;
		}
		.tableInfo table tr td{
			padding:.2rem;
			vertical-align:top;
		}
		.orderDetail .tableInfo table tr td:first-child{
			border-right:1px solid #f3f3f3;
			width:2.5rem;
		}
    </style>
</head>
<body class="logisticsBody">
<div class="logisticsTrack">
    <div class="title">
    	<a href="javascript:history.go(-1);"><i class="iconfont prevPage">&#xe624;</i></a>物流追踪
    </div>
    <%-- <div class="hasInfo" style="display:none">
    	<div class="logistics-msg">
	        <div class="company"><i class="iconfont">&#xe616;</i>物流公司：${logisticsCompanyName }</div>
	        <div class="logistics-num"><i class="iconfont">&#xe664;</i>物流单号：${logisticsCode }</div>
	        <div><i class="iconfont">&#xe609;</i>电话号码：${transportPhoneNumber}</div>
	    </div>
	    <div class="logistics">
	    </div>
    </div>
    <div class="notInfo">
    	<div><i class="iconfont">&#xe616;</i></div>
    	<p>没有查到物流信息,详细情况请联系买家</p>
    </div> --%>
    <c:forEach items="${sendList }" var="send">
    	<img src="${send.sendLogisticsPic}" style="width:100%">
    	<div class="tableInfo">
    	<table>
    		<tbody><tr>
    			<td>物流公司</td>
    			<td>${send.sendLogisticsCompany }</td>
    		</tr>
    		<tr>
    			<td>物流编号</td>
    			<td>${send.transportNumber }</td>
    		</tr>
    		<tr>
    			<td>电话</td>
    			<td>${send.sendPhoneNumber }</td>
    		</tr>
    	</tbody></table>
    	</div>
    </c:forEach>
</div>

<!--[[底部-->
<%-- <c:if test="${user.role==1}">
	<jsp:include page="/jsp/factory/footer.jsp"></jsp:include>
</c:if>
<c:if test="${user.role!=1}">
	<jsp:include page="/jsp/buyer/footer.jsp"></jsp:include>
</c:if> --%>
<!--底部]]-->

<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
<script>
	<%-- $(".notInfo").height($(window).height()-$(".title").height());
	$(function(){
		var urlStr = "<%=request.getContextPath()%>/buyer/consult?type=${logisticsCompanyCode}&postId=${logisticsCode}";
		//alert("Before Call:"+urlStr);
		$.ajax({
    			method: "GET",
    			url: urlStr,
    			success:function(data,status,jqXHR){
    				if(data=="error"){
    					$(".notInfo").show();
    				}else{
    					$(".hasInfo").show();
    					var json = $.parseJSON(data); 
    					
    					var ul=$(".logistics");
    					ul.html("");
    					var li;
    					for(var i=0;i<json.data.length;i++){
    						var info = json.data[i];
    						li='<div class="step '+((i==0)?'active':'')+'">';
    						li+='<div class="address"><span></span><span>'+info.context+'</span></div>';
    						li+='<div class="time">'+info.time+'</div>';
    						li+='</div>';
    						ul.append(li);
    					}
    				}
    			}
		});
		//doAjax(false,false,"GET",url,params,success,fail);
	}) --%>
	
</script>
</body>
