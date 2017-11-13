<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>

<html>
	<meta name="baidu-site-verification" content="20qCwkjPCH" />
	<head>
		<meta charset="utf-8"/>
		<title>欢迎进入繁灯网</title>
		<style>
			body{
				text-align:center;
			}
			h2{
				width:600px;
				margin:0 auto;
				margin-top:10%;
			}
		</style>
	</head>
	<body>
		<h2>欢迎进入繁灯网，该网站是基于微信公众号的开发，请用微信扫描下方的二维码，关注繁灯网微

		信公众号后点击菜单项“繁灯网”访问网站</h2>
		<img src="<%=request.getContextPath()%>/resources/customer/assets/images/qrcode.jpg"/>
	</body>
</html>