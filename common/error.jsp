<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head> 
		<meta charset="UTF-8">
		<title></title>
		<style>
			html, body {
			    width: 100%;
			    height: 100%;
			    overflow: hidden;
			    color: #fff;
			}
			.page{
				height: 100%;
		    background: url(<%=request.getContextPath()%>/resources/customer/assets/images/error.jpg) no-repeat;
		   /*  background-size: 100% 100%;
		    -webkit-background-size: 100% 100%; */
		    background-position: center;
			}
		</style>
	</head>
	<body>
		<div class="page">
		</div>
	</body>
</html>
