<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>  

<!DOCTYPE HTML>
<html>
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>佐为照明</title>
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/customer/assets/css/personCenter.css" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
    <style>
    	.prevPage {
		    position: absolute;
		    left: 0px;
		    display: inline-block;
		    height: 1.2rem;
		    width: 1.2rem;
		    font-size: 0.7rem;
		    padding-left: 1rem;
		    color: #ffffff;
		    -webkit-transform: rotate(180deg);
		    transform: rotate(180deg);
		}
    </style>
  </head>
  
  <body>
  <div class="distributor">
 	<i class="iconfont prevPage">&#xe624;</i>
    <div class="title">产品报价</div>
	  <form action="<%=request.getContextPath() %>/demand/addDemandOffer" class="form">
	  		<div class="form-group">
	  			<label>金额:</label>
	           	￥${demandOffer.demandPrice }
	        </div>
	  		<div class="form-group">
	  			<label>交货期:</label>
	  			${demandOffer.timeLimit }
	        </div>
	  		<div class="form-group" style="height:auto;">
	  			<label>备注:</label>
	  			${demandOffer.demandOfferDescription }
	        </div>
	        <c:if test="${!empty user }">
		  		<div class="form-group" >
		  			<label>联系人:</label>
		  			${user.legalPersonName}
		        </div>
		  		<div class="form-group" >
		  			<label>联系电话:</label>
		  			<a href="tel:${user.phoneNumber}">${user.phoneNumber}</a>
		        </div>
	        </c:if>
	        <c:if test="${!empty demandOffer.demandOfferImage1 }">
	         <div class="imgDiv" style="width:90%">
	             <div class="imgContent notEmpty">
	                 <input type="hidden" class="imgUrl" value="${demandOffer.demandOfferImage1 }" name="demandOfferImage1"/>
	                 <img  class="smallImg" src="${demandOffer.demandOfferImage1 }" data-src="${demandOffer.demandOfferImage1 }" alt="" />
	             </div>
	             <div class="imgTitle">说明图片</div>
	         </div>
	         </c:if>
	         
	        <c:if test="${!empty demandOffer.demandOfferImage2 }">
             <div class="imgDiv" style="width:90%">
	             <div class="imgContent notEmpty">
	                 <input type="hidden" class="imgUrl" value="${demandOffer.demandOfferImage2 }" name="demandOfferImage2"/>
	                 <img  class="smallImg" src="${demandOffer.demandOfferImage2}" data-src="${demandOffer.demandOfferImage2}" alt="" />
	             </div>
	             <div class="imgTitle">说明图片</div>
             </div>
             </c:if>
	  	</form>
  </div>
 <div class="tip"></div>
 <div class="bigImgDiv">
	<img class="bigImg" src=""/>
 </div>
  
	<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
  </body>
  <script>
		$(".prevPage").tap(function(){
			history.go(-1);
		});
		
		$(document).on("tap",".smallImg",function(){
			var img = new Image();
			img.src=$(this).attr("src");
			
			$(".bigImg").removeAttr("style");
			if(img.complete){
				changeImg(img);
			}else{
				img.onload=function(){
					changeImg(img);
				}
			}
			$(".bigImgDiv").show();
			$(".shade").show();
		});
		$(".bigImgDiv").tap(function(){
			$(".bigImgDiv").hide();
			$(".shade").hide();
		});
		function changeImg(img){
			var wid=img.width;
			var hgt=img.height;
			var width=$(window).width();
			var height=$(window).height();
			var rat=parseFloat(wid)/parseFloat(hgt);
			var ratio=parseFloat(width)/parseFloat(height);
			if(rat>=ratio&&wid>=parseInt(width)){
				$(".bigImg").width(width);
			}else if(rat<ratio&&hgt>=parseInt(height)){
				$(".bigImg").height(height);
			}
			$(".bigImg").attr("src",img.src);
		}
  </script>
</html>
