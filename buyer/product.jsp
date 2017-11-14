<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>金明同达灯饰</title>
    <link href="<%=request.getContextPath() %>/resources/common/bootstrap.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/common/swiper.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/customer/assets/css/orderCart.css" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
    <script src="<%=request.getContextPath() %>/resources/common/require.js" data-main="<%=request.getContextPath() %>/resources/customer/assets/js/orderCart.js"></script>

</head>
<body>
<div class="cart">
<c:forEach items="${productList }" var="product">
    产品：${product.productName }
  <button onclick="addShopcart(${product.productId})">加入购物车</button>
  </c:forEach>
</div>
	<input type="file" id="file1" onchange="upload()"/>
<jsp:include page="/jsp/buyer/footer.jsp"></jsp:include>
<script type="text/javascript">
	function addShopcart(productId){
		var url="<%=request.getContextPath()%>/shopcart/addShopcart?productId="+productId+"&num=1"
		var params={};
		doAjax(false,false,"GET",url,params,success,fail);
	}
	
	function success(data){
		alert("success");
		console.log(data);
	}
	
	function upload(){
		uploadFile($("#file1")[0],"/test",success,fail);
	}
	
	function fail(data){
		alert("fail");
		console.log(data);
	}
</script>
</body>
</html>