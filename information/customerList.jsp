<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="deadLine" uri="/WEB-INF/tld/deadLineTag.tld"%>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
		<title>金明同达灯饰</title>
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/customer/font/iconfont.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/customer/assets/css/chat.css?11">
	</head>
	<body>
		<div class="search">
			<input type="text" id="keyword" value="${keyword}" placeholder="请输入客户微信昵称">
			<input type="submit" id="submit" value="搜索">
			<input type="button" value="按${empty orderBy?'字母':'时间'}排序" style="background-color:red;color:white;" class="orderBy">
		</div>
		<div class="customerList">
			<c:if test="${!empty orderBy }">
				<c:forEach items="${customerMap}" var="map">
				<c:if test="${map.value.size()>0 }">
				<ul>
					<li class="rank">${map.key }</li>
					<c:forEach items="${map.value }" var="customer">
					<li>
						<a href="javascript:setSessionStorage(${customer.userId},'${customer.userProtraitPic}','${customer.userNickname }')">
							<img src="${customer.userProtraitPic}" alt="">
							<p>${customer.userNickname }</p>
						</a>
					</li>
					</c:forEach>
				</ul>
				</c:if>
				</c:forEach>
			</c:if>
			<c:if test="${empty orderBy }">
				<ul>
					<li class="rank">&nbsp;</li>
					<c:forEach items="${userList}" var="customer">
					<li>
						<a href="javascript:setSessionStorage(${customer.userId},'${customer.userProtraitPic}','${customer.userNickname }')">
							<img src="${customer.userProtraitPic}" alt="">
							<p>${customer.userNickname }</p>
							<span><deadLine:date value="${customer.rentVisitTime}" role="${user.role }"/></span>
						</a>
					</li>
					</c:forEach>
				</ul>
			</c:if>
		</div>
		
		<jsp:include page="/jsp/information/chatFooter.jsp"></jsp:include>
		<script src="<%=request.getContextPath()%>/resources/common/count.js?1c#xx"></script>
		<script>
		countNewInfoNumber();
		setInterval("countNewInfoNumber()",5000);
		
		function countNewInfoNumber(){
			var url="<%=request.getContextPath()%>/information/countNewInfoNumber";
			var params = {};
			doAjax("GET",url,params,countSuccess,fail,true,false);
		}
		
		function countSuccess(data){
			if(data.data>0){
				$(".badge span").html(data.data);
				$(".badge span").show();
			}else{
				$(".badge span").hide();
			}
		}
		
		function fail(data){
			console.log("fail");
		}
		
		$("#submit").tap(function(){
			window.location.href="<%=request.getContextPath()%>/information/lowUserList?keyword="+$("#keyword").val();
		});
		
		function setSessionStorage(value,img,username){
			sessionStorage.setItem("chatUser",value);
			sessionStorage.setItem("chatUserImg",img);
			sessionStorage.setItem("chatUsername",username);
			window.location.href="<%=request.getContextPath()%>/information/informationList";
		}
		
		$(".orderBy").tap(function(){
			<c:if test="${!empty orderBy }">
				window.location.href="<%=request.getContextPath()%>/information/lowUserList?keyword="+$("#keyword").val();
			</c:if>
			<c:if test="${empty orderBy }">
				window.location.href="<%=request.getContextPath()%>/information/lowUserList?keyword="+$("#keyword").val()+"&orderBy=0";
			</c:if>
		});
		</script>
	</body>
</html>