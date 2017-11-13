<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>My JSP 'loginPanel.jsp' starting page</title>
  	<script src="<%=request.getContextPath() %>/dwr/engine.js"></script>
	<script src="<%=request.getContextPath() %>/dwr/util.js"></script>
	<script src="<%=request.getContextPath() %>/dwr/interface/DWRIdenCodeAccess.js"></script>
	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/computer/css/phdpz.css" />
  </head>

	<script type="text/javascript">
		$(window).on('load', function() {
		  	/*弹出框*/
		  
		  $(document).on("click",'a[class^=loginA]',function(){
			  var bh = document.body.scrollHeight;
				var bw = window.screen.width;
				$("#fullBg").css({
					height: bh,
					width: bw,
					display: "block"
				});
				$('#loginDialog').slideDown();
			});
			
			$('#loginClose').click(function() {
				$('#fullBg,#loginDialog').slideUp();
			});
			
			isLogin();

			$('#close1').click(function() {
				$('#dialog1').slideUp();
			});
	  		
	  		if($.cookie("userName")){
	  			$(".remPWD").attr("checked","checked");
	  			$("#userName1").val($.cookie("userName"));
	  			$("#password1").val($.cookie("password"));
	  		}
	  	});
		
		function loginSuccess(){
			var bh = document.body.scrollHeight;
			var bw = window.screen.width;
			
			$('#dialog1').slideDown();
			setTimeout(function(){
				$('#dialog1').slideUp()},1000);
		}
		
		//判断用户是否已经登录,如果登陆了就修改网页对应信息		
		  function isLogin(){
				var urlStr = "<%=request.getContextPath() %>/user/isLogin";
				//alert("Before Call:"+urlStr);
				$.ajax({
					method: "POST",
					url: urlStr,
					success:function(data,status,jqXHR){
					
						if(data!="null"){
							$("#loginSpan").hide();
							$("#loginStatus").html(data+",您好，<a href='<%=request.getContextPath()%>/'></a>欢迎访问繁灯网！<a >[扫码手机逛商城]</a>&nbsp;&nbsp;<a href='<%=request.getContextPath()%>/user/exit'>[退出]</a>");
						}	
					}	
				}); // end ajax
			}
		
		function refresh1(){
			if(document.getElementById("img")!=null){
	  			document.getElementById("img").src="<%=request.getContextPath()%>/randomcode.jpg?"+new Date().getTime();
			}
	  		document.getElementById("codeImg").src="<%=request.getContextPath()%>/randomcode.jpg?"+new Date().getTime();
	  		checkCode1($("#code1").html());
	  	}
		
		function checkCode1(obj){
	  		$("#sign1").hide();
	  		DWRIdenCodeAccess.checkCode(obj,checkFun1);
	  	}
		
		function checkFun1(){
			
		}
		
		function hideTip1(){
			$("#tip1").hide();
		}
		
		function checkForm1(){
	  		var _data;
	  	
	        //设置成同步
	        dwr.engine.setAsync(false);
	        //调用Java类Test的getString方法，callBackFun为回调函数
	        DWRIdenCodeAccess.checkCode($("#code1").val(),function(data){_data = data;});
	       
	        //重新设置为异步方式
	        dwr.engine.setAsync(true);

	  		if(!_data)
	  		{	
	  			$("#sign1").show();
	  			$("#code1").val("");
	  			return false;
	  		}else{
	  			return true;
	  		}
	  	
	  	}
	  	
	  	function login1(){
	  		if(checkForm1()){
	  			//记住密码
	  			if($("#remPWD2").is(":checked")){
	  				$.cookie("password",$("#password1").val(), {path: "/", expires: 7});
	  				$.cookie("userName",$("#userName1").val(), {path: "/", expires: 7});
	  			}else{
	  				$.cookie("password",null, {path: "/", expires: 7});
	  				$.cookie("userName",null, {path: "/", expires: 7});
	  			}
	  			
		  		 var urlStr = "<%=request.getContextPath() %>/user/login1?userName="+
		  				 $("#userName1").val()+"&password="+$("#password1").val();
		 		//alert("Before Call:"+urlStr);
		 		
		 		$.ajax({
		 			method: "POST",
		 			url: urlStr,
		 			success:function(data,status,jqXHR){
		 				if(data=="error"){
		 					
		 					$("#tip1").show();	
		 				}else{
		 					getCartNum();
			 				$("#loginSpan").hide();
			 				$("#loginStatus").html(data+",您好，欢迎使用<a href='<%=request.getContextPath()%>/'>79deng.com</a>访问79灯网！<a href='<%=request.getContextPath()%>/user/myShop'>[我的店铺]</a>&nbsp;&nbsp;<a href='<%=request.getContextPath()%>/user/exit'>[退出]</a>");
			 				$('#fullBg,#loginDialog').slideUp();
			 				loginSuccess();
			 				forward();
			 				if($("#loginContent").html()!=undefined){
			 					showPanel();
			 				}	
		 				}
		 			}	
		 		}); // end ajax
	  		}
	  	}
	  	
	  
	  	
	  //判断用户是否登陆，否则弹出登陆面板
	  	function loginOrNot(){
	  		var urlStr = "<%=request.getContextPath() %>/user/isLogin";
			//alert("Before Call:"+urlStr);
			var flag=true;
			$.ajax({
				method: "POST",
				url: urlStr,
				async: false,
				success:function(data,status,jqXHR){
					var bh = document.body.scrollHeight;
					var bw = window.screen.width;					
					if(data=="null"){
						$("#fullBg").css({
							height: bh,
							width: bw,
							display: "block"
						});
						$('#loginDialog').slideDown();
						flag=false;
					}	
				}	
			}); // end ajax 
			return flag;
	  	}
	  	
	  
	  	//某些跳转的地方加上判断用户是否登陆，登陆才可以跳
	  	function skip(url){	
  			if(loginOrNot()){	
  				window.location.href="<%=request.getContextPath()%>/"+url;
  			}else{
  				$("#url").val(url);
  			}
  		}
	  	
	  	//针对上传产品的跳转
	  	function skip1(url){	
  			if(loginOrNot()){	
  				getRole(url);
  			}else{
  				$("#url").val(url);
  			}
  		}
	 
	  	
	  	function getRole(url){
	  		
	  		var urlStr = "<%=request.getContextPath() %>/user/getRole";
			//alert("Before Call:"+urlStr);
			var flag=true;
			$.ajax({
				method: "POST",
				url: urlStr,
				success:function(data,status,jqXHR){
					
					if(data==0){
						window.location.href="<%=request.getContextPath()%>/"+url;
					}else{
						alert("设计师不可以上传产品");
					}
					
				}	
			}); // end ajax 
	  	}
	  	
	  	function forward(){
	  		if($("#url").val()!=""){
	  			if($("#url").val().indexOf("product/goProductAdd")>=0)
	  				getRole($("#url").val());
	  			else
	  				window.location.href="<%=request.getContextPath()%>/"+$("#url").val();
	  		}	
	  	}
	</script>
	<%
		String cart = (String)request.getParameter("cartNum");
		if(cart!=null && cart.equals("0")){ %>
		<script type="text/javascript">
			function getCartNum(){
				
			}
		</script>		
	<%} %>
  <body>
  	<input type="hidden" id="url"/>
    <div id="fullBg"></div>
		<!--登录弹出框-->
		<div  id="loginDialog" class="dialog">
			<div class="login bor fl">
					<p>已有79灯网帐号，登录</p>
					<div class="input-gp">
						<span>手机号</span>
						<input type="text" name="userName" id="userName1"/>
					</div>
					<div class="input-gp">
						<span>密 码</span>
						<input type="password" name="password" id="password1" oninput="hideTip1()"/>
						<b id="tip1" style="display:none">密码输入错误，请重新输入。</b>
					</div>
					<div class="code-gp input-gp">
						<span>验证码</span>
						<input type="text" id="code1" oninput="checkCode1(this.value)" onkeydown="if(event.keyCode==13)login1();">
						<i>
							<input type="hidden" value="<%=request.getParameter("url")%>" name="url"/>
							<img src="<%=request.getContextPath()%>/randomcode.jpg" onclick="refresh1()" id="codeImg" alt="看不清? 点击图片刷新"/>
						</i>
						<b id="sign1" style="display:none">验证码错误。</b>
					</div>
					<div class="forgot clear">
						<!-- <b class="fl" id="sign1" style="display:none">验证码错误。</b> -->
						<label class="fl"><input type="checkbox" class="remPWD" id="remPWD2"/>记住密码</label>
						<a href="<%=request.getContextPath() %>/user/findPassword" class="fr">忘记密码?</a>
					</div>
					<div class="btn-gp">
						<button type="submit" onclick="login1()">登录</button>
						<button type="button" onclick="window.location.href='<%=request.getContextPath()%>/user/toRegister'">注册</button>
					</div>
				</div>
				<span type="button" id="loginClose" class="close fa fa-close"></span>
		</div>
		
		<div id="fullBg1"></div>
		<!--登录弹出框-->
		<div  id="dialog1">
			<div class="login_succe">
				<h2 style="color:#f90">登陆成功</h2>
				<span type="button" id="close1" class="close">X</span>		
			</div>
		</div>
  </body>
</html>
