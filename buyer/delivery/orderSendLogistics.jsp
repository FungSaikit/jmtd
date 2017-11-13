<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html>
<html>
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
	    <title>物流列表</title>
	    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
	    <link href="<%=request.getContextPath() %>/resources/factory/assets/css/order.css" rel="stylesheet">
	    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
	</head>
	<body>
		<div class="title"><i class="iconfont prevPage payPrev" >&#xe63f;</i>物流公司列表</div>
		<div>
			<form action="<%=request.getContextPath() %>/buyer/orderSendLogisticsCompany" class="searchFactory">
				<input type="text" placeholder="请输入物流的名字" name="logisticsCompanyName" value="${logisticsCompanyName}">
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
			$(document).on("tap",".checkBox",function(){
				if($(this).hasClass("active")){
					$(this).removeClass("active");
				}else{
					$(this).addClass("active");
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
				var url="<%=request.getContextPath()%>/buyer/orderSendLogisticsCompanyAjax";
				var params={logisticsCompanyName:"${logisticsCompanyName}"};
				doAjax("GET",url,params,loadSuccess,fail,true,false);
			}
			
			function loadSuccess(data){
				var ofList = data.data;
				var html="";
				for(var i=0;i<ofList.length;i++){
					html+='<li data-id="'+ofList[i]+'"><a >'+(ofList[i]==''?'&nbsp':ofList[i])+'</a></li>';
					/* html+='<div class="orderStock" data-id="'+ofList[i]+'" >';
					html+='<div class="orderStockBody">';
					
					html+='<div class="stock">';
					html+='<div class="order">';
					html+='<div class="fl">'+ofList[i]+'</div>';
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
				window.location.href="<%=request.getContextPath()%>/buyer/orderSendUser?"
						+"logisticsCompanyName="+$(this).attr("data-id");
			});
			/* var canLoad=true;
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
			}); */
			
			function showDate(str){
				var date = new Date(str);
				return date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate()+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds();
			}
			
			$(document).on("tap",".submitOrderItem",function(){
				var dataId="";
				$(".checkBox").each(function(){
					if($(this).hasClass("active")){		
						dataId+=$(this).attr("data-id")+",";
					}
				});
				dataId=dataId.substring(0, dataId.length-1);
				window.location.href="<%=request.getContextPath()%>/buyer/toSendLogistics?orderNumber="
						+dataId;
			});
			$(".prevPage").tap(function(){
				history.go(-1);
			})
		</script>
	</body>
</html>