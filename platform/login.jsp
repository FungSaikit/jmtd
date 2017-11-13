<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title>管理后台</title>
    <script src="<%=request.getContextPath() %>/resources/common/jquery.min.js"></script>
	
    <style>
/* #container {
	width:960px;
	margin:0 auto;
	color: #5E3219;
}

#container .logo {
	width: 400px;
	margin:0 auto;
}

#container .logo img{
	width: 400px;
}

#container #box {
 clear:both;
 float:none;
 width:70%;
 margin:50px auto 0;
}

p.main label {
 float:left;
 padding:5px;
 display:inline;
 margin-left:40px;
 font-size:13px;
 color:#5E3219;
 margin-right:10px;
}

#box p {
 clear:both;
 float:none;
 width:100%;
}

p.main INPUT {
 background:url('../assets/input.png') 0 0 repeat-x;
 border:1px solid #d3d3d3;
 color:#555;
 padding:5px;
 float:left;
 width:200px;
}*/

input.login {
/*float: right;*/
padding: 3px 10px 3px 10px;
color: #fff;
font-size: 12px;
text-decoration: none;
/*border: 1px solid #555;*/
/*background: url('../assets/rep1.png') 50% 50% repeat-x;*/
/*display: inline;*/
margin-right: 5px;
display: block;
margin: 0 auto;
border: 1px solid #5E3219;
/*color: #5E3219;*/
background: linear-gradient(to top,#5E3219,#83614D);
border-radius: 5px;
}
/* 
span {
 font-size:13px;
 color:#666;
}

.space {
 padding-top:15px;
}

span input {
 margin-left:125px;
 margin-right:5px;
 border:1px solid #111;
 background:#444;
 color:#fff;
}  */
	.container{
		text-align:center;
		margin-top:100px;
	}
  </style>
  </head>
  <body>
    	 <%-- <div id="container">
		<div class="logo">
			<a href="#"><img src="http://lanmao.zhuanlitou.com:8080/findeng/picture/logo.png" alt="" /></a>
		</div>
		<div id="box">
			<form action="<%=request.getContextPath() %>/platform/login" method="POST">
			<p class="main">
				<label>账号: </label>
				<input type="text" name="userName" id="userName" autocomplete="off"/>
				<label>密码: </label>
				<input type="password" name="password" id="password" oninput="hideTip()" autocomplete="off"/>
				<input type="hidden" value="<%=request.getParameter("url")%>" name="url"/>
				<b id="tip" style="display:none">密码输入错误，请重新输入。</b>	
			</p>

			<p class="space">
				<input type="submit" value="登陆" class="login" />
			</p>
			</form>
		</div> 
	</div> --%>
	 <div class="container">
	 	<img src="<%=request.getContextPath() %>/platform/qrCode/${uuid}"/>
	 	<div id="show" style="display:none">已扫描二维码，请在手机上确认登陆</div>
	 </div>
      <script>
        var s=0;
      	function checkStatus(status){
      		$.ajax({
      			method:"GET",
      			url:"<%=request.getContextPath()%>/platform/checkQrLoginStatus?uuid=${uuid}&status="+status,
      			timeout: 19000,
      			success:function(data,status,jqXHR){
					console.log(data);
					if(data==0){
						checkStatus(0);
					}
					if(data==1){
						$("#show").show();
						s=1;
						checkStatus(s);
					}
					if(data==2){
						window.location.href="<%=request.getContextPath()%>/platform/orderList";
						s=2;
					}
					if(data==4){
						$("#show").show();
						$("#show").html("二维码已失效,请刷新页面重新获取");
						s=4;
					}
      			},
      			error: function (data, status, jqXHR) {
                    if (status == "timeout") { // 请求超时
                    	checkStatus(s); // 递归调用
                        
                    // 其他错误，如网络错误等
                    } else { 
                    	checkStatus(s);
                    }
                }
      		});
      	}
      	
      	$(function(){
      		checkStatus(s);
      	})
      </script>
  </body>
</html>
