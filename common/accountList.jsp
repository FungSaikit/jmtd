<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>
<html>
  <head>
    <title>客户列表</title>
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
		tr>th:nth-child(1),tr>td:nth-child(1){
			width:30%;
		}
		tr>th:nth-child(2),tr>td:nth-child(2){
			width:30%;
		}
		tr>th:nth-child(3),tr>td:nth-child(3){
			width:40%;
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
  </head>
  <body>
  		<table>
  			<tr>
  				<th>客户头像</th>
  				<th>客户昵称</th>
  				<th>输入手机号码</th>
  			</tr>
  			<c:forEach items="${accountList}" var="account">
  			<tr>
  				<td><img src="${account.clientImg }" width="100px" height="100px"/></td>
  				<td>${account.clientName }</td>
  				<td><form action="<%=request.getContextPath() %>/getAgency/inputPhoneNumber">
  				<input type="text" name="phoneNumber" />
  				<input type="hidden" value="${account.clientId }" name="userId"><button>提交</button></form></td>
  			</tr>
  			</c:forEach>
  		</table>
  </body>
</html>
