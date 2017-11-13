<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<!DOCTYPE HTML>
<html>
  <head>
    <title>登录</title>
  </head>
  
  <body>
	<form action="<%=request.getContextPath()%>/getAgency/login" onsubmit="return checkForm();">  
  	   	 手机号：<input type="text" name="phoneNumber"/><br/>
  	 	<button>提交</button>
  	</form>
  </body>
  <script>
  	function checkForm(){
  		if(document.getElementsByName("phoneNumber")[0].value==""){
  			alert("请输入手机号");
  			return false;
  		}else{
  			return true;
  		}
  	}
  	
  	
  </script>
</html>
