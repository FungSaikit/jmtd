<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html>

	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />

		<title>金明同达灯饰</title>
		
		<!-- mobile_desktop icon -->
		<link rel="app-touch-icon" href="<%=path %>/resources/index/image/79灯Logo.jpg" />
		<link rel="icon" href="<%=request.getContextPath() %>/resources/index/image/79icon.jpg">
		<!-- 样式文件 -->
		<link rel="stylesheet" type="text/css" href="<%=path %>/resources/customer/assets/css/subscribe.css" />
	</head>		
	<body>
			<div class="subscribe">
				<div class="title">
				  <i class="iconfont prevPage normalPrev">&#xe624;</i> 订阅列表
				</div>
			<div class="wrapper" id="wrapper">
			<div class="scroll" id="scroll">
		     <div class="swiper-container" class="subscribeList" id="subscribeList">
               	 <div class="swiper-wrapper">
					
                    <!-- 我想买列表-->
                    <div class="swiper-slide swiper-no-swiping">
                    	
                      <li class="more" id="more" onclick="loadMore()">
                         	  更多...
                       </li>
                       <div class="block"></div>
                    </div>
                </div>
		 </div>
		 
	 	<button type="button" class="addList" onclick="toAddSubscribe()">增加订阅</button>
		</div>
	</div>
</div>
		<!--删除面板-->
		<div class="shade full_shade" id="reminder_login" style="display:none">
			<div class="pop_box reminder">
				<header class="reminder_header">
					<span>温馨提示</span><span class="pop_close icon-cross"></span>
				</header>
				<div class="reminder_content">确定删除？</div>
				<div class="reminder_buttons">
					<button id="cancel_reminder">取消</button>
					<button id="delete_reminder">删除</button>
				</div>
			</div>
		</div>

		
		
		<!-- custom -->
		<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
		<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
		<script src="<%=request.getContextPath() %>/resources/customer/assets/js/subscribe.js"></script>
		<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
		<script src="<%=request.getContextPath() %>/resources/common/fx.js"></script>
		<script src="<%=request.getContextPath() %>/resources/common/fx_methods.js"></script>
		<script>
			var id;
			$(document).on("tap",".del",function(){
				$('#reminder_login').fadeIn('fast');
			    id=$(this).parents(".list").attr("data-id");
			})
		   
			$('#delete_reminder').tap(function(){		
			    //ajax的success函数中加如下代码
			    deleteSubscribe(id);
				$('#reminder_login').hide();
			});
		</script>
		
		<script type="text/javascript">
			var pageNo=0;
			loadMore();
			function loadMore(){
				var urlStr = "<%=request.getContextPath()%>/demand/subscribesListAjax?pageNo="+pageNo;
				$.ajax({
					method: "GET",
					url: urlStr,
					success:function(data,status,jqXHR){
						//alert(data);   
						var html="";
						var list = data.data[0].list;
						var list1 = data.data[1];
						console.log(list1)
						for(var i=0;i<list.length;i++){
							html+="<li class='list' data-id='"+list[i].subscribeId+"'><div class='left'><p class='subscribe intwoline'>";	
							for(var j=0;j<list1.length;j++){
								if(list[i].subscribeId==list1[j].subscribeId && list1[j].subscribePropertyValue!='不限'){
									html+=list1[j].subscribePropertyValue;
									if(j!=list1.length-1)
										html+='<span style="color:red">|</span>';
								}
							}
							html+="</p><label class='date'>"+showDate(list[i].attentionTime)+"</label>";
							html+="</div><div class='middle'>";
							if(list[i].messageCount!=0)
								html+="<span class='badge'>"+list[i].messageCount+"</span>";
							html+="</div><div class='right del'><i class='iconfont'>&#xe632;</i></div></li>";
						}
						$(html).insertBefore($("#more"));
						if(list.length<10)
							$("#more").hide();
						if(data.data[0].after==0){
							$('<p class="no_result">您暂时没有订阅信息~</p>').insertBefore($("#more"));
						}
						pageNo=data.data[0].after;
					}	
				});
			}
			
			$(document).on("tap",".left",function(e){
					window.location.href="<%=request.getContextPath()%>/demand/subscirbeDemandList?subscribeId="+$(this).parents(".list").attr("data-id");
			});
			
			function showDate(str){
				var date = new Date(str);
				return date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate()+" "+date.getHours()+":"+date.getMinutes();
			}
			
			var type=0;
			function toAddSubscribe(){
				var url="<%=request.getContextPath()%>/demand/checkSubscribeNumber";
				var params={};
				doAjax("GET",url,params,function(data){
					if(data.code==1){
						window.location.href="<%=request.getContextPath()%>/demand/toAddSubscribe";
					}else{
						alert("订阅的需求不能超过三个");
					}
				},function(data){console.log("false")},false,false);
			}
			
			function deleteSubscribe(subscribeId){
				var urlStr = "<%=request.getContextPath()%>/demand/deleteSubscribe?subscribeId="+subscribeId;
				//alert(urlStr)
				$.ajax({
					method: "GET",
					url: urlStr,
					success:function(data,status,jqXHR){
						//alert(data);
						location.reload();
					}	
				});
			}
			
			$(function(){
				var urlStr = "<%=request.getContextPath()%>/message/getSubscribeTypeNum?type=0";
				//alert("Before Call:"+urlStr);
				$.ajax({
					method: "GET",
					url: urlStr,
					success:function(data,status,jqXHR){
						//alert(data);
						if(data>0){
							$("#productNumber").html(data);
							$("#productNumber").show();
						}
					}	
				}); // end ajax 
				
				var urlStr = "<%=request.getContextPath()%>/message/getSubscribeTypeNum?type=1";
				//alert("Before Call:"+urlStr);
				$.ajax({
					method: "GET",
					url: urlStr,
					success:function(data,status,jqXHR){
						//alert(data);
						if(data>0){
							$("#demandNumber").html(data);
							$("#demandNumber").show();
						}
					}	
				});
				removeLast();
			})
			
			function removeLast(){
				var $p = $(".intwoline");
				for(var i=0;i<$p.length;i++){
					$p.eq(i).children("span").last().remove();
				}
			}
			
			$(".prevPage ").tap(function(){
				history.go(-1);
			});
			
			$('#cancel_reminder').tap(function(e){
				$("#reminder_login").hide();
			});	
		</script>
	</body>
</html>