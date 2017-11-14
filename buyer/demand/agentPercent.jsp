<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>  

<!DOCTYPE HTML>
<html>
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>金明同达灯饰</title>
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/customer/assets/css/personCenter.css" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
  </head>
  
  <body>
  <div class="distributor">
    <div class="title">设置自定义佣金</div>
	  <form action="<%=request.getContextPath() %>/buyer/setAgentPercent" class="form" >
	  		<div class="form-group">
	  			<label>输入佣金点数</label>
	            <input type="text" id="agentPercent" value="<fmt:formatNumber value="${agentPercent*100}" pattern="0.##"/>" class="form-control"/>
	        </div>
	  	<button type="button" onclick="setPassword()"  class="submit">提交</button>	
	  	</form>
  </div>
  <div class="tip"></div>
  <jsp:include page="/jsp/buyer/footer.jsp"></jsp:include>
  </body>
  <script>
  	function setPassword(){
  		if($("#agentPercent").val().trim()==""||isNaN($("#agentPercent").val())){
  			showTip("请输入有效的点数");
  		}else{
  			if(parseFloat($("#agentPercent").val())<0.0||parseFloat($("#agentPercent").val())>10.0){
  				showTip("输入0到10的数字");
  			}else{
	  			var url="<%=request.getContextPath()%>/buyer/setAgentPercent";
				var params={agentPercent:$("#agentPercent").val()};
				doAjax("GET",url,params,successC,fail,false,false);
  			}
  		}
  	}
  	
  	function successC(data){
  		if(data.data=="success"){
  			showTip("设置成功");
  		}else{
  			showTip("设置失败");
  		}
  	}

  </script>
</html>
