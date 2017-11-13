<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>  

<!DOCTYPE HTML>
<html>
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>佐为照明</title>
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/customer/assets/css/personCenter.css" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
  	<style>
  		.serviceDiv label,.delRelation .delRelationDiv label{
			font-weight:normal;
			color:#000;
			width:30%;
			padding:.1rem 0rem;
			display:inline-block;
			background-color:#fff;
			height:1rem;
			line-height:1rem;
			text-align:center;
		}
		.distributor #agentPercent {
		    width: 70%;
		    float: right;
		    height: 1.2rem;
		}
		.distributor input{
		    border: 0;
		    width: 100%;
		    padding: .2rem;
		    box-sizing: border-box;
		    -webkit-appearance: none;
		    resize: none;
		    font-size: .5rem;
		    font-family: "微软雅黑";
		}
		.distributor .serviceDiv{
			margin:0rem 0rem 1.2rem;
		}
		.distributor .form .clear {
		    display: block;
		    width: 60%;
		    margin: .8rem auto;
		    color: #000;
		    background-color:#F1F1F1;
		    border: 1px solid #000;
		    border-radius: 3px;
		    padding: .2rem;
		    font-size: .5rem;
		    -webkit-appearance: none;
		}
  	</style>
  </head>
  
  <body>
  <div class="distributor">
    <div class="title"><i class="iconfont prevPage" >&#xe63f;</i>设置价格</div>
	  <form action="<%=request.getContextPath() %>/buyer/setAgentPercent" class="form" >
  		<div class="serviceDiv">
   			<label>自定义价格</label>
   			<input type="text" id="agentPercent" value="${agentPercent}" placeholder="请输入价格调整比例(如想把价格变成原来两倍则直接填2)">
   		</div>
	  	<button type="button" onclick="setAgencyPercent()"  class="submit">提交</button>	
	  	<button type="button" onclick="clearAgencyPercent()"  class="clear">清空</button>	
	  </form>
  </div>
  <div class="tip"></div>
  <jsp:include page="/jsp/buyer/footer.jsp"></jsp:include>
  </body>
  <script>
  	function setAgencyPercent(){
  		var reg = /^[0-9]+(.[0-9]{1,2})?$/;
  		if (!reg.test($("#agentPercent").val())||$("#agentPercent").val()==0) {
  			showTip("请输入大于零的数字(保留小数点后两位)");
	  		return false;
  		}else{
 			var url="<%=request.getContextPath()%>/buyer/setAgencyPercent";
			var params={agentPercent:$("#agentPercent").val()};
			doAjax("GET",url,params,successC,fail,false,false);
		}
  		<%-- if($("#agentPercent").val().trim()==""||isNaN($("#agentPercent").val())){
  			showTip("请输入有效的点数");
  		}else{
  			if(parseFloat($("#agentPercent").val())<0.0||parseFloat($("#agentPercent").val())>10.0){
  				showTip("输入0到10的数字");
  			}else{
	  			var url="<%=request.getContextPath()%>/buyer/setAgentPercent";
				var params={agentPercent:$("#agentPercent").val()};
				doAjax("GET",url,params,successC,fail,false,false);
  			}
  		} --%>
  	}
  	
  	function clearAgencyPercent(){
  		var url="<%=request.getContextPath()%>/buyer/clearAgencyPercent";
		var params={agentPercent:$("#agentPercent").val()};
		doAjax("GET",url,params,successC,fail,false,false);
  	}
  	
  	function successC(data){
  		if(data.data=="success"){
  			showTip("设置成功");
  		}else{
  			showTip("设置失败");
  		}
  		location.reload();
  	}
  	
  	$(".prevPage").tap(function(){
  		window.location.href="<%=request.getContextPath()%>/buyer/personCenter";
  	})

  </script>
</html>
