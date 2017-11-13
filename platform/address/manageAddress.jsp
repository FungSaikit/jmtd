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
    	<table border="1px">
    		<tr><td>联系人</td>
    			<td>电话</td>
    			<td>地址</td>
    			<td>操作</td>
    		</tr>
    		<c:forEach items="${addressList }" var="address">
    		<tr>
    			<td>${address.receiveAddress.receivePerson }</td>
    			<td>${address.receiveAddress.contactNumber }</td>
    			<td>${address.province}${address.city}${address.area}${address.receiveAddress.addressDetail}</td>
    			<td><a href="javascript:deleteAddress(${address.receiveAddress.receiveAddressId })">删除</a></td>
    		</tr>
    		</c:forEach>
    	</table>
    </div>
 </body>
 
 <script src="<%=request.getContextPath()%>/resources/backStage/script/product.js"></script>
 <script>
 	function deleteAddress(receiveAddressId){
		var url="<%=request.getContextPath()%>/address/deleteAddress";
		var params={receiveAddressId:receiveAddressId};
		doAjax("GET",url,params,deleteSuccess,fail,true,false);
	}
	
	function deleteSuccess(){
		location.reload();
	}
	
	function fail(data){
		alert("fail");
	}
</script>
</html>