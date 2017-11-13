<%@ page language="java" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <script src="<%=request.getContextPath() %>/resources/common/jquery.min.js"></script>
   	<title>确认登录</title>
  	<style>
  		.content{
  			width:90%;
  			margin:0 auto;
  			text-align:center;
  			padding-top:40%;
  		}
  		.btn{
  			width:100%;
  			margin-top:10%;
  			height:50px;
  			border-radius:4px;
  		}
  		.confirm{
  			background-color:green;
  			color:#fff;
  			border:none;
  		}
  		.cancel{
  			border:1px solid #ccc;
  		}
  	</style>
  </head>
  <body>
  		<div class="content">
  			${message}
   		</div>
  </body>
</html>
