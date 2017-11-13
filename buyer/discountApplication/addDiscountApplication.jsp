<%@ page language="java" import="java.util.*,com.alphaking.constant.*,com.alphaking.model.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>佐为照明</title>
    <meta name="format-detection" content="telephone=no">
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/common/swiper.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/customer/assets/css/personCenter.css" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
</head>
<body>
<c:set var="CUSTOMER" value="<%=UserType.CUSTOMER%>" />
<c:set var="AGENCY" value="<%=UserType.AGENCY%>" />
<c:set var="FACILITATOR" value="<%=UserType.FACILITATOR%>" />
<div class="distributor" >
 <div class="title"><!-- 
  	<i class="iconfont prevPage normalPrev">&#xe624;</i> -->申请
 </div>
 <form action="<%=request.getContextPath()%>/buyer/addDiscountApplication" class="form" >
	<div class="form-group">
		<label>滚动字幕</label>
         <input type="text" name="discountTitle" class="form-control" placeHolder="建议20字以内"/>
    </div>
	<div class="form-group">
		<label>折扣</label>
         <input type="text" name="welcomeTitle" class="form-control" placeHolder="请输入数字" 
         	 onkeyup="this.value=this.value.replace(/[^\d\.]/g,'')" onblur="this.value=this.value.replace(/[^\d\.]/g,'')"/>
    </div>
	<button type="submit" class="submit">提交</button>	
 </form>
	
 </form>
</div>

<jsp:include page="/jsp/buyer/footer.jsp"></jsp:include>
<!--底部]]-->
<script>
	$(".normalPrev").tap(function(){
		history.go(-1);
	});
</script>
</body>
</html>