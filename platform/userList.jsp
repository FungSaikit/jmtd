<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>
<html>
  <head>
    <title>客户绑定关系查询</title>
    <style>
    	*{
			padding:0;
			margin:0;
			font-family:"微软雅黑";
		}
		table{
			width:800px;
			margin:50px auto;border-collapse: collapse;
		}
		img{
			width:100px;
			height:100px;
		}
		tr>th,tr>td{
			padding:10px;
			border:1px solid #ccc;
			box-sizing:border-box;
		}
		
		td{
			text-align:center;
		}
		tr>td:not(:last-child),tr>th:not(:last-child){
			border-right:1px solid #ccc;
		}
		td>form>input[type="text"]{
			width:70%;
			display:inline-block;
		}
		
    </style>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/common/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/backStage/css/index.css" />
  </head>
  <body>
  <jsp:include page="/jsp/platform/header.jsp"></jsp:include>
  <jsp:include page="/jsp/platform/navigation.jsp"></jsp:include>
  <div style="text-align:center">
  		<form action="<%=request.getContextPath()%>/getAgency/getUserList">
  		<input type="text" name="keyword" value="${keyword }" placeHolder="请输入用户昵称"/><button>搜索</button>
  		</form>
  		<a href="<%=request.getContextPath() %>/getAgency/getUserList?keyword=${keyword}&sort=1"><button>按下级数排序</button></a>
  		</div>
  		<table>
  			<tr>
  				<th>客户头像</th>
  				<th>客户昵称</th>
  				<th>上级</th>
  				<th>上上级</th>
  				<th>角色</th>
  				<th>下级数</th>
  				<c:if test="${!empty keyword }"><th>购买量</th></c:if>
  			</tr>
  			<c:forEach items="${userList}" varStatus="i" var="user">
  			<tr>
  				<td><img src="${user.userProtraitPic }" width="100px" height="100px"/></td>
  				<td>${user.userNickname }</td>
  				<td>${user.companyAddressDetail}</td>
  				<td>${user.legalPersonName}</td>
  				<td><c:choose><c:when test="${user.role==5 }">消费者</c:when>
  					<c:otherwise>经销商</c:otherwise></c:choose></td>
  				<td>${user.salesmanId}</td>
  				<c:if test="${!empty keyword }"><td>${user.withdrawMoney}</td></c:if>
  			</tr>
  			</c:forEach>
  		</table>
  	</div>
  	</div>
  </body>
</html>
