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
	</head>
	<body>
		<div class="title"><i class="iconfont prevPage payPrev" >&#xe63f;</i>厂家列表</div>
		<div>
			<form action="<%=request.getContextPath() %>/buyer/prepareReceiveFactory" class="searchFactory">
				<input type="text" placeholder="请输入厂家的名字" name="sellerName" value="${sellerName}">
				<button>搜索</button>
			</form>
			<div class="factoryList">
				<ul>
				</ul>
			</div>
		</div>
		<div class="tip"></div>
		<!--[[底部-->
		<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/jweixin-1.0.0.js"></script>
		<!--底部]]-->
		<script>
			var offset=0;
			function loadOrder(){
				var url="<%=request.getContextPath()%>/buyer/receiveFactoryAjax";
				var params={offset:offset,sellerName:"${sellerName}"};
				doAjax("GET",url,params,loadSuccess,fail,true,false);
			}
			
			function loadSuccess(data){
				var ofList = data.data;
				var html="";
				for(var i=0;i<ofList.length;i++){
					html+='<li  data-id="'+ofList[i].userId+'" data-str="'+ofList[i].shortCompanyName+'"><a '+(ofList[i].postage==0.0?'style="color:red"':'')+'>'+ofList[i].shortCompanyName+'</a></li>';
					/* html+='<div class="orderStock" data-id="'+ofList[i].userId+'" data-str="'+ofList[i].shortCompanyName+'">';
					html+='<div class="orderStockBody">';
					
					html+='<div class="stock">';
					html+='<div class="order">';
					html+='<div class="fl">'+ofList[i].shortCompanyName+'</div>';
					html+='<div class="fr">一键导航</div></div>';
		  				html+='';
					html+='</div>';
					
					html+='</div></div>'; */
				}
				$(".factoryList ul").html(html);
				load.css("visibility","hidden");
	
				if(parseInt(offset+10)>=data.data.count){
					noDate=true;
				}
				offset=data.data.after;
				canLoad=true;
			}
			
			function fail(data){
				alert("fail");
			}
	
			loadOrder();
			
			$(document).on("tap",".factoryList li",function(){
				window.location.href="<%=request.getContextPath()%>/buyer/receiveList?factoryName="+$(this).attr("data-str")
						+"&sellerId="+$(this).attr("data-id");
			});
			$(".prevPage").tap(function(){
				history.go(-1);
			})
		</script>
	</body>
</html>
