<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html>
<html class="removeProHtml">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>佐为照明</title>
    <link href="<%=request.getContextPath() %>/resources/customer/assets/css/common.css" rel="stylesheet">
    <style>
    	*{
    		padding:0px;
    		margin:0px;
    	}
    	.removeProHtml{
    		padding-bottom:0px;
    	}
    	.removeProBody{
    		margin-bottom:0px;
    	}
    	.removePro{
    		font-size:.5rem;
    		font-family:"微软雅黑";
    		text-align:center;
    	}
    	.removePro>.iconDiv{
    		margin:30% auto .3rem;
    		width:4rem;
    		height:4rem;
    		border-radius:50%;
    		background-color:#999;
    		color:#fff;
    		line-height:4rem;
    	}
    	.removePro>.iconDiv i{
    		font-size:3rem;
    	}
    	.removePro p{
    		color:#999;
    	}
    	.removePro .aGrounp{
    		margin:1rem auto 0;
    	}
    	.removePro .aGrounp a{
    		display:block;
    		width:33.33%;
    		text-align:center;
    		text-decoration:none;
    		color:#000;	
    		float:left;
    	}
    	.removePro .aGrounp a i{
    		font-size:1.2rem;
    		color:#000;
    	}
    	.removePro .title{
    		font-size: 0.7rem;
		    text-align: center;
		    line-height: 1.2rem;
		    height: 1.2rem;
		    background-color: red;
		    color: #fff;
		    font-family:"微软雅黑";
    	}
    </style>
</head>
<body class="removeProBody">
<div class="removePro">
	<div class="title">商品详情</div>
	<div class="iconDiv"><i class="iconfont">&#xe635;</i></div>
	<p>该商品已下架！</p>
	<div class="aGrounp">
		<a href="#">
			<i class="iconfont">&#xe60a;</i>
			<p>商城首页</p>
		</a>
		<a href="#">
			<i class="iconfont">&#xe625;</i>
			<p>更多商品</p>
		</a>
		<a href="#">
			<i class="iconfont">&#xe62f;</i>
			<p>返回</p>
		</a>
	</div>
</div>
</body>
</html>