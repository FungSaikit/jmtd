<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>
<html>
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>佐为照明</title>
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/customer/assets/css/personCenter.css?12c1111xx" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
  </head>
  
  <body>
  <div class="distributor">
    <div class="title">设置密码</div>
	  <form action="<%=request.getContextPath() %>/factory/setPassword"  class="form" >
	  	<c:if test="${empty password }">
		  	<div class="form-group">
	            <label>输入密码</label>
	            <input type="text" id="password" name="password" class="form-control"/>
	        </div>
	  	</c:if>
	  	<c:if test="${!empty password }">
	  		<div class="form-group">
	            <label>原密码</label>
	            <input type="text" id="password" class="form-control"/>
	        </div>
	  		<div class="form-group">
	            <label>新密码</label>
	            <input type="text" id="password" name="password" class="form-control"/>
	        </div>
	  	</c:if>
	  	<button type="button" onclick="setPassword()"  class="submit">提交</button>	
	  	</form>
  </div>
  <div class="tip"></div>
  <jsp:include page="/jsp/factory/footer.jsp"></jsp:include>
  </body>
  <c:if test="${!empty password }">
  <script>
  	function setPassword(){
  		var url="<%=request.getContextPath()%>/factory/checkPassword";
		var params={password:$("#password").val()};
		doAjax("GET",url,params,successC,fail,false,false);
  	}
  	
  	function successC(data){
  		if(data.data=="true"){
  			var url="<%=request.getContextPath()%>/factory/setPassword";
  			var params=$("form").serialize();
  			doAjax("GET",url,params,success,fail,true,false);
  		}else{
  			showTip("原密码不正确");
  		}
  	}
  </script>
  </c:if>
  <c:if test="${empty password }">
  <script>
  	function setPassword(){
			var url="<%=request.getContextPath()%>/factory/setPassword";
			var params=$("form").serialize();
			doAjax("GET",url,params,success,fail,true,false);
	}
  </script>
  </c:if>
  <script>
  	function success(data){
  		showTip("设置成功");
  		setTimeout(function(){
  	  		window.location.href="<%=request.getContextPath()%>/factory/personCenter";},1000);
  	}
  	
  	function fail(data){
  		alert("fail");
  	}
  </script>
</html>
