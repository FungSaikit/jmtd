<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<html>
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width,height=device-height, initial-scale=1.0,maximum-scale=1.0, user-scalable=no" />
</head>
<body>
<h2>用户身份确认</h2>
<a href="javascript:authenticate(<%=UserType.CUSTOMER%>)">消费者</a><br>
---------》其他角色《----------<br>
<a href="javascript:authenticate(<%=UserType.FACTORY%>)">厂家</a><br>
<a href="javascript:authenticate(<%=UserType.AGENCY%>)">经销商</a><br>
<a href="javascript:authenticate(<%=UserType.SALESMAN%>)">业务员</a><br>
<script>
	function authenticate(role){
		if(confirm("角色选择后不可更改")){
		    window.location.href="<%=request.getContextPath()%>/user/authenticate?role="+role;
		}
	}
</script>
</body>
</html>
