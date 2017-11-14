<%@ page language="java" import="java.util.*;" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=2.0, user-scalable=yes" />
		<title>金明同达灯饰</title>
		<meta name="renderer" content="webkit">
		<meta name="description" content="去旧灯网是一个专门为灯具经销商、设计师、地产公司和装饰公司而建立的网站平台，致力于为经销商提供清库存、产品展示等服务。以共享经济和行业社交本地化的模式，共享全国灯具经销商的库存，以存会友，随时随地发现身边的同行，开展业务交流与合作。">
		<meta name="keywords" content="去旧灯网，处理库存灯，库存灯，去旧，去旧灯，灯，灯饰，共享经济，买灯，卖灯，同泰，陕西，西安">
		<link rel="icon" href="<%=request.getContextPath() %>/resources/index/image/79icon.jpg" />
		<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/resources/computer/css/index.css">
		<style>
		body{background-color: #f5f5f5}	</style>
	</head>

	<body>
		<jsp:include page="/jsp/computer/header.jsp"/>		
		<input type="hidden" id="path" value="<%=request.getContextPath()%>/">
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/computer/script/index.js"></script>
		<!--main-->
		<div class="main-gp-head clear">
					<!-- <div class="login bor fl" id="loginContent"> 
							<p>广告招商</p>
					 </div> -->
					<jsp:include page="/jsp/computer/carousel.jsp"/> 
					<%-- <jsp:include page="/WEB-INF/jsp/index/carousel/shopCarousel.jsp"></jsp:include> --%>
				</div>
		
		<div class="main clear">
			<div class="main-body md clear" id="content">
				<c:forEach items="${typeList}" var="l" varStatus="st">
					<c:if test="${l.propertyValue!='其他'}">
						<jsp:include page="/jsp/computer/productColumn.jsp">
						<jsp:param value="${l.propertyValue}" name="type"/>
						<jsp:param value="${l.propertyValueId}" name="typeId"/>
						<jsp:param value="${st.index }" name="index"/>
						</jsp:include>
					</c:if>
				</c:forEach>
			</div>
			<!-- 右側導航欄sidebar -->
		<jsp:include page="/jsp/computer/sidebar.jsp"/>
		</div>
		<jsp:include page="/jsp/computer/footer.jsp"/>
	</body>
	
	<script type="text/javascript">
	/*侧边栏滚动  */
	  $(window).on("scroll load",function(){
			if(document.body.scrollTop>120)
			{
				$(".tool").css("display","block");
			}
			else{
				$(".tool").css("display","none");
			}
		});
		function refresh(){
			document.getElementById("img").src="randomcode.jpg?"+new Date().getTime();
	  		document.getElementById("codeImg").src="randomcode.jpg?"+new Date().getTime();
	  		checkCode($("#code").html());
	  	}
		
		function hideTip(){
			$("#tip").hide();
		}
	  	
	  	function checkCode(obj){
	  		$("#sign").hide();
	  		DWRIdenCodeAccess.checkCode(obj,checkFun);
	  	}
	  	
	  	function checkFun(data){
// 	  		if(data)
// 	  			$("#sign").html("&radic;");
// 	  		else
// 	  			$("#sign").html("X");
	  	}
	  	
	  	function checkForm(){
	  		var _data;
	  	
	        //设置成同步
	        dwr.engine.setAsync(false);
	        //调用Java类Test的getString方法，callBackFun为回调函数
	        DWRIdenCodeAccess.checkCode($("#code").val(),function(data){_data = data;});
	       
	        //重新设置为异步方式
	        dwr.engine.setAsync(true);

	  		if(!_data)
	  		{	
	  			$("#sign").show();
	  			$("#code").val("");
	  			return false;
	  		}else{
	  			return true;
	  		}
	  	
	  	}
	  	
	  	function login(){
	  		if(checkForm()){
	  			//记住密码
	  			if($("#remPWD1").is(":checked")){
	  				$.cookie("password",$("#password").val(), {path: "/", expires: 7});
	  				$.cookie("userName",$("#userName").val(), {path: "/", expires: 7});
	  			}else{
	  				$.cookie("password",null, {path: "/", expires: 7});
	  				$.cookie("userName",null, {path: "/", expires: 7});
	  			}
	  			
		  		 var urlStr = "<%=request.getContextPath() %>/user/login1?userName="+
		  				 $("#userName").val()+"&password="+$("#password").val();
		 		//alert("Before Call:"+urlStr);
		 		$.ajax({
		 			method: "POST",
		 			url: urlStr,
		 			success:function(data,status,jqXHR){
		 				//alert(data)
		 				if(data=="error"){
		 					$("#tip").show();	
		 				}else{
		 					//登陆成功后执行的操作
		 					getCartNum();
			 				$("#loginSpan").hide();
			 				$("#loginStatus").html(data+",您好，欢迎使用<a href='<%=request.getContextPath()%>/'>79deng.com</a>访问79灯网！ <a href='<%=request.getContextPath()%>/user/myShop'>[我的店铺]</a>&nbsp;&nbsp;<a href='<%=request.getContextPath()%>/user/exit'>[退出]</a>");
			 				$("#userName").val("");
			 				$("#password").val("");
			 				$("#code").val("");
			 				showPanel();
			 				loginSuccess();
			 				var html="<table class='loginNote'><tr><td><a href=''><img src='<%=request.getContextPath()%>/resources/upload/portrait/"+res[1]+"'/></a></td><td><p>欢迎，用户<a href='#'>"+res[0]+"</a>！</p></td></tr></table>";
			 				html+="<table class='loginIconList'><tr><td><a href='<%=request.getContextPath()%>/user/myShop' class='loginIcon'><i class='fa fa-institution'></i><p>我的店铺</p></a></td>";
			 				html+="<td><a href='<%=request.getContextPath()%>/user/toUserInformation' class='loginIcon'><i class='fa fa-user'></i><p>个人中心</p></a></td></tr>";
			 				html+="<tr><td><a href='<%=request.getContextPath()%>/subscribe/manageSubscribes' class='loginIcon'><i class='fa fa-rss-square'></i><p>我的订阅</p><span id='subscribeNum' style='display:none'></span></a></td>";
			 				html+="<td><a href='<%=request.getContextPath()%>/product/collection_store' class='loginIcon'><i class='fa fa-eye'></i><p>我的关注</p></a></td></tr></table>";
			 				html+="<div class='btn-gp'><button type='button' onclick='window.location.href=\"<%=request.getContextPath()%>/user/exit\"'>安全退出</button></div>";
			 				$("#loginContent").html(html);
		 				}
		 			}	
		 		}); // end ajax
	  		}
	  	}
	  	
	  	
	  	function showPanel(){
	  		var urlStr = "<%=request.getContextPath() %>/user/isLogin1";
			//alert("Before Call:"+urlStr);
			$.ajax({
				method: "POST",
				url: urlStr,
				success:function(data,status,jqXHR){
					if(data!="null"){
						var res = data.split("@@");
						var html="<table class='loginNote'><tr><td><a href=''><img src='"+res[1]+"'/></a></td><td><p>欢迎，用户<a href='#'>"+res[0]+"</a>！</p></td></tr></table>";
		 				html+="<table class='loginIconList'><tr><td><a href='<%=request.getContextPath()%>/user/myShop' class='loginIcon'><i class='fa fa-institution'></i><p>我的店铺</p></a></td>";
		 				html+="<td><a href='<%=request.getContextPath()%>/user/toUserInformation' class='loginIcon'><i class='fa fa-user'></i><p>个人中心</p></a></td></tr>";
		 				html+="<tr><td><a href='<%=request.getContextPath()%>/subscribe/manageSubscribes' class='loginIcon'><i class='fa fa-rss-square'></i><p>我的订阅</p><span id='subscribeNum' style='display:none'></span></a></td>";
		 				html+="<td><a href='<%=request.getContextPath()%>/product/collection_store' class='loginIcon'><i class='fa fa-eye'></i><p>我的关注</p></a></td></tr></table>";
		 				html+="<div class='btn-gp'><button type='button' onclick='window.location.href=\"<%=request.getContextPath()%>/user/exit\"'>安全退出</button></div>";
		 				$("#loginContent").html(html);
		 				
						var url = "<%=request.getContextPath() %>/message/getUserMessageNum";
						//alert(url);
						$.ajax({
							method: "POST",
							url: url,
							success:function(data,status,jqXHR){
								//alert();
								if(data!=0){
									$("#subscribeNum").html(data);
									$("#subscribeNum").show();
								}
					 		}
						}); // end ajax
					}
				}	
			});	
					
	  	}
	  	
	  	$(function(){
	  		showPanel();
	  		
	  		if($.cookie("userName")){
	  			$(".remPWD").attr("checked","checked");
	  			$("#userName").val($.cookie("userName"));
	  			$("#password").val($.cookie("password"));
	  		}
	  	});
	</script>
</html>