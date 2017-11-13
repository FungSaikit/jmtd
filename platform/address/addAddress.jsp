<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>管理后台</title>
    <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/resources/backStage/image/favicon.ico" />

    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/common/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/backStage/css/index.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/backStage/css/product.css" />
	
	<%-- <script src="<%=request.getContextPath()%>/resources/common/jquery.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/common/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/interactive.js"></script>
    <script src="<%=request.getContextPath() %>/resources/common/require.js" data-main="<%=request.getContextPath() %>/resources/backStage/script/main.js" defer async="true"></script>
	 --%>
</head>
<body>
     <!-- [[头部 -->
     <jsp:include page="/jsp/platform/header.jsp"></jsp:include>
     <!-- [[页面主体 -->
	 <jsp:include page="/jsp/platform/navigation.jsp"></jsp:include>
	<button onclick="window.location.href='<%=request.getContextPath()%>/platform/addAddress.html'">添加地址</button>
    <!-- [[商品详情操作区 -->
    <div class="area productDetail">
    	<form action="<%=request.getContextPath()%>/platform/addAddress">
			<input type="hidden" name="userId" value="1"/>
			<input type="hidden" value="0" name="defaultFlag"/>
			<table class="formTable">
				<tr>
					<td>联系人</td>
					<td><input id="contactName" name="receivePerson" type="text" value="" data-name="联系人"/></td>
				</tr>
				<tr>
					<td>联系电话</td>
					<td><input type="text" name="contactNumber" value="" data-name="联系电话"/></td>
				</tr>
				<tr>
					<td>选择省份</td>
					<td>
						<select name="provinceId" onchange="queryCity(this.value)" data-name="省份">
							<option>--请选择省份--</option>
							<c:forEach items="${provinceList}" var="province">
								<option value="${province.addressId }">${province.addressName}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td>选择市区</td>
					<td>
						<select name="cityId" onchange="queryArea(this.value)" data-name="市区"> 
							<option>--请选择市区--</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>选择区/县</td>
					<td>
						<select name="areaId" data-name="区/县">
							<option>--请选择区/县--</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>详细地址</td>
					<td><input type="text" name="addressDetail" value="" data-name="详细地址"/></td>
				</tr>
			</table>
			<button>添加</button>
		</form>
    </div>
    
    <script src="<%=request.getContextPath()%>/resources/backStage/script/product.js"></script>
 </body>
 <script>
 	function queryCity(addressId){
		var url="<%=request.getContextPath()%>/address/queryAddress";
		var params={upAddressId:addressId};
		doAjax("GET",url,params,queryCitySuccess,fail,false,false);
	}
	
	function queryCitySuccess(data){
		var option="";
		for(var i=0;i<data.length;i++){
			option+="<option value='"+data[i].addressId+"'>"+data[i].addressName+"</option>";
		}
		$("select[name='cityId']").html(option);
		queryArea(data[0].addressId);
	}
	
	function queryArea(addressId){
		var url="<%=request.getContextPath()%>/address/queryAddress";
		var params={upAddressId:addressId};
		doAjax("GET",url,params,queryAreaSuccess,fail,false,false);
	}
	
	function queryAreaSuccess(data){
		var option="";
		for(var i=0;i<data.length;i++){
			option+="<option value='"+data[i].addressId+"'>"+data[i].addressName+"</option>";
		}
		$("select[name='areaId']").html(option);
	}
	
	function fail(data){
		alert("fail");
	}
</script>
</html>