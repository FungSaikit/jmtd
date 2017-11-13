<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>佐为照明</title>
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/factory/assets/css/order.css" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
</head>
<body>
<div class="orderStock">
    <div class="title">
    	<i class="iconfont prevPage">&#xe624;</i>发货</div>
    <div class="tableInfo">
      </div>
      <div class="sendForm">
        <form action="#">
          <select id="logisticsSelect" name="logisticsSelect">
			<option value="otherLogistics">其他</option>
       		<c:forEach items="${logisticsList }" var="logistics">
			<option value="${logistics.userLogisticsId}" data-phone="${logistics.logisticsPhoneNumber}"
			 data-park="${logistics.logisticsPark }" <c:if test="${logistics.logisticsCompanyName==logisticsCompanyName }">selected</c:if>>${logistics.logisticsCompanyName}</option>
			</c:forEach>
          </select>
          <input type="text" placeholder="请输入物流公司" id="otherInput" name="logisticsCompanyCode" <c:if test="${flag}">style="display:none" </c:if><c:if test="${!flag}">value="${logisticsCompanyName }"</c:if>/>
          <input type="text" placeholder="请输入物流园"  id="logisticsPark" name="logisticsPark" <c:if test="${flag}">value="${logisticsPark }"</c:if>/>
          <input type="text" placeholder="请输入物流物流公司电话" id="transportPhone" name="transportPhoneNumber" <c:if test="${flag}">value="${transportPhoneNumber }"</c:if>/>
          <input type="text" placeholder="请输入物流物流单号" id="transportNumber" name="logisticsCode"/>
          
          <button type="button" class="add">点击上传物流单</button>
          <input type="hidden" class="imgUrl" name="logisticsPic"/>
          <img src="" alt="">
        </form>
      </div>
   		<div class="submit" id="sendTo"><a>提　交</a></div>
    </div>
</div>
<div class="tip"></div>
<!--[[底部-->
<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/jweixin-1.0.0.js"></script>
<!--底部]]--><script>
	var logisticsCompanyCode;
	$("#sendTo").tap(function(){
		if($("#logisticsSelect").val()=="otherLogistics"){
			if($("#otherInput").val().trim()==""){
				showTip("请输入物流公司名称！");
			}
		}
		if($("#transportPhone").val().trim()==""){
			showTip("请输入物流公司电话！");
		}else if($("#transportNumber").val().trim()==""){
			showTip("请输入物流编号！");
		}else{
			var url="";
			if(logisticsCompanyCode==null)
				url="<%=request.getContextPath()%>/buyer/sendLogistics?logisticsCompanyCode="+$("#otherInput").val()+
				"&logisticsCode="+$("#transportNumber").val()+"&orderNumber=${orderNumber}&transportPhoneNumber="+$("#transportPhone").val()
				+"&logisticsSelect="+$("#logisticsSelect").val()+"&logisticsPark="+$("#logisticsPark").val()+"&logisticsPic="+$("input[name='logisticsPic']").val();
			else	
				url="<%=request.getContextPath()%>/buyer/sendLogistics?logisticsCompanyCode="+logisticsCompanyCode+
				   "&logisticsCode="+$("#transportNumber").val()+"&orderNumber=${orderNumber}&transportPhoneNumber="+$("#transportPhone").val()
				   +"&logisticsSelect="+$("#logisticsSelect").val()+"&logisticsPark="+$("#logisticsPark").val()+"&logisticsPic="+$("input[name='logisticsPic']").val();
			doAjax("GET",url,{},successGet,fail,true,false);
		}
	});
	
	function successGet(data){
		window.location.href="<%=request.getContextPath()%>/buyer/orderSendUser?logisticsCompanyName=${sessionScope.logisticsCompanyName1}";
	}
	

	function showTip(str){
		$(".tip").html(str);
		$(".tip").css("opacity",1);
		setTimeout(function(){
			$(".tip").html("");
			$(".tip").css("opacity",0);
		},1000);
	}
	
	function fail(data){
		alert("fail");
	} 
	
	$(function(){
		calculate();
	})
	
	function calculate(){
		var numbers=0;
		var money=0;
		$(".commodity").each(function(){
			numbers = numbers+parseInt($(this).find(".moneyNum span").html().match(/\d+(\.\d+)?/g));
			money = money+(parseFloat($(this).find(".moneyNum h4").html().match(/\d+(\.\d+)?/g))*parseInt($(this).find(".moneyNum span").html().match(/\d+(\.\d+)?/g)));
		});
		$(".allP span").eq(0).html(numbers);
		$(".allP span").eq(1).html("￥"+money.toFixed(2));
	}
	
	$("#closeSendToDiv,#cancel,.shade").on("tap",function(){
		$(".sendLogistics").hide();
	});
	$("#logisticsSelect").change(function(){
		if($(this).val()=="otherLogistics"){
			$("#otherInput").css("display","block");
			$("#transportPhone").val("");
		}else{
			$("#otherInput").css("display","none");
			$("#transportPhone").val($('#logisticsSelect').find('option').not(function(){ return !this.selected }).attr("data-phone"));
			$("#logisticsPark").val($('#logisticsSelect').find('option').not(function(){ return !this.selected }).attr("data-park"));
		}
	});
	
	$(".rdBtn").tap(function(){
		window.location.href="<%=request.getContextPath()%>/buyer/returnDetail?returnInfoId="+$(this).attr("data-id");
	});
	
	$(".prevPage").tap(function(){
		history.go(-1);
	});
	
	var url=location.href.split('#')[0].replace(new RegExp('&','gm'),'-');
	var urlStr = "http://lanmao.zhuanlitou.com/wechat/signature?url="+url;
	//alert("Before Call:"+urlStr);
	$.ajax({
		method: "GET",
		url: urlStr,
		success:function(data,status,jqXHR){
			//alert(data.appId+","+data.signature+","+data.timeStamp+","+data.nonceStr);
			var result=data;
			var appId=result.appId;
			var signature = result.signature;
			var timeStamp = result.timeStamp;
		    var nonceStr = result.nonceStr;		 
		    
		    wx.config({
		        debug: false,// 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
		        appId: appId, // 必填，公众号的唯一标识
		        timestamp:timeStamp , // 必填，生成签名的时间戳
		        nonceStr: nonceStr, // 必填，生成签名的随机串
		        signature: signature,// 必填，签名，见附录1
		        jsApiList: ['onMenuShareTimeline','onMenuShareAppMessage','onMenuShareQQ','chooseImage','uploadImage'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
		    });
		    wx.error(function(res){
		           
		    });
		    wx.ready(function(){
		        // config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行
				//。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
		    	wx.onMenuShareAppMessage({
		    	    title: '<c:if test="${!empty application }">${application.shortCompanyName}</c:if>——繁灯网', // 分享标题
					link: location.href.split('#')[0], // 分享链接
					imgUrl: '${user.userProtraitPic}', // 分享图标
					success: function () { 
						// 用户确认分享后执行的回调函数
					},
					cancel: function () { 
						// 用户取消分享后执行的回调函数
					}
		    	});
		    	wx.onMenuShareTimeline({
		    	    title: '<c:if test="${!empty application }">${application.shortCompanyName}</c:if>——繁灯网', // 分享标题
					link: location.href.split('#')[0], // 分享链接
					imgUrl: '${user.userProtraitPic}', // 分享图标
					success: function () { 
						// 用户确认分享后执行的回调函数
					},
					cancel: function () { 
						// 用户取消分享后执行的回调函数
					}
		    	});
		    });
		}
	}); // end ajax
	
	$(".add").tap(function(){
		$(".waiting").show();
		$(".shade").show();
		chooseImg(this);
	});
	
	function chooseImg(obj) {
		var urlStr = "<%=request.getContextPath()%>/wechat/signature?url="+location.href.split('#')[0];
		//alert("Before Call:"+urlStr);
		$.ajax({
			method: "GET",
			url: urlStr,
			success:function(data,status,jqXHR){
				//alert(data.appId+","+data.signature+","+data.timeStamp+","+data.nonceStr);
				var result=data;
				var appId=result.appId;
				var signature = result.signature;
				var timeStamp = result.timeStamp;
			    var nonceStr = result.nonceStr;		 
			    
			    wx.config({
			        debug: false,// 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
			        appId: appId, // 必填，公众号的唯一标识
			        timestamp:timeStamp , // 必填，生成签名的时间戳
			        nonceStr: nonceStr, // 必填，生成签名的随机串
			        signature: signature,// 必填，签名，见附录1
			        jsApiList: ['chooseImage','uploadImage'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
			    });
			    wx.error(function(res){
			           
			    });
			    wx.ready(function(){
					$(".waiting").hide();
					$(".shade").hide();
			        // config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行
					//。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
			    	wx.chooseImage({
			    	    count: 1, // 默认9
			    	    sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
			    	    sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
			    	    success: function (res) {
			    	        localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
			    	        chooseUpload(obj,localIds[0]);
			    			$(obj).next().next().attr("src",localIds);
			    			
			    			var img = new Image();
			    			img.src=localIds;
			    			if(img.complete){
			    				console.log(123);
			    				changeImgDisplay(img,$(obj).find("img"));
			    			}else{
			    				var $that=$(this);
			    				img.onload=function(){
			    					changeImgDisplay(img,$(obj).find("img"));
			    				}
			    			}
			    	    }
			    	});
			    });
			}
		}); // end ajax
	}
	

	
	function changeImgDisplay(img,obj){
		var wid=img.width;
		var hgt=img.height;
		var width=$(".imgContent").width();
		var height=$(".imgContent").height();
		var rat=parseFloat(wid)/parseFloat(hgt);
		var ratio=parseFloat(width)/parseFloat(height);
		if(wid>=hgt&&wid>=parseFloat(width)&&hgt>=parseFloat(height)){
			obj.height(height);
		}else if(wid<hgt&&hgt>=parseFloat(height)&&wid>=parseFloat(width)){
			obj.width(width);
		}
		obj.attr("src",img.src);
	}
	
	function chooseUpload(obj,localIds){
		wx.uploadImage({
	   		 localId: localIds, // 需要上传的图片的本地ID，由chooseImage接口获得
	   		 isShowProgressTips: 1, // 默认为1，显示进度提示
	   		 success: function(res) {
	   		 	//返回图片的服务器端ID res.serverId,然后调用wxImgCallback函数进行下载图片操作
	   			$(obj).next().val(res.serverId);
	   		 },
	  		 fail: function(res) {      			
	  		 
	  		 }
	   	});
	}
	
	$(document).on("tap",".cancel",function(){
		var imgContent=$(this).parents(".imgContent");
		imgContent.find("img").attr("src","");
	  	imgContent.find("input[class='imgUrl']").val("");
	  	imgContent.find(".add").show();
	  	imgContent.find(".cancel").hide();
	  	imgContent.find("img").hide();
	});
</script>
</body>
</html>


<%-- <%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>佐为照明</title>
    <link href="<%=request.getContextPath() %>/resources/common/swiper.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/factory/assets/css/order.css?1" rel="stylesheet">
    <style>
   		.distributor *{
		    font-family:"微软雅黑";
		    font-size:.5rem;
		}
		.distributor .title{
			font-size: 0.7rem;
		    text-align: center;
		    line-height: 1.2rem;
		    height: 1.2rem;
		    background-color: red;
		    color: #ffffff;
		}
		.distributor .form{
			background-color:#fff;
			overflow:hidden;
			margin-bottom:1.3rem;
			padding-bottom:.5rem;
		}
		.distributor .form .form-group{
			height:1.4rem;
			line-height:1.4rem;
			border-bottom:1px solid #f3f3f3;
			overflow:hidden;
			padding:0 5%;
			box-sizing:border-box;
		}
		.distributor .form .form-group input:not(.submit),.distributor .form .form-group select{
			width:100%;
			height:1rem;
			border:1px solid #ccc;
			outline:none;
			padding:0 .2rem;
			box-sizing:border-box;
			border-radius:3px;
			-webkit-appearance:none;
		}
		.distributor .form .imgDiv{
			width:90%;
			margin:5%; 
			float:left;
		}
		.distributor .form .imgDiv .imgContent{
			border:1px solid #ccc;
			width:100%;
			padding-bottom:100%;
			text-align:center;
			position:relative;
			overflow:hidden;
		}
		.distributor .form .imgDiv .imgContent img{
			position:absolute;
			top:50%;
			left:50%;
			transform:translate(-50%,-50%);
			-webkit-transform:translate(-50%,-50%);
		}
		.distributor .form .imgDiv .imgContent .add{
			display:block;
			position:absolute;
			width:80%;
			height:80%;
			left:10%;
			top:10%;
			overflow:hidden;
			line-height:normal;
		}
		.distributor .form .imgDiv .imgContent .add i{
			font-size:2.5rem;
			color:red;
			display:block;
			position:absolute;
			left:50%;
			top:50%;
			transform:translate(-50%,-50%);
			-webkit-transform:translate(-50%,-50%);
		}
		.distributor .form .imgDiv .imgContent .cancel{
			display:block;
			position:absolute;
			width:.8rem;
			height:.8rem;
			right:.1rem;
			top:.1rem;
			line-height:.8rem;
			border-radius:50%;
			background-color:rgba(0,0,0,.4);
		}
		.distributor .form .imgDiv .imgContent .cancel i{
			font-size:.6rem;
			color:#fff;
		}
		.distributor .form .imgDiv .imgTitle{
			text-align:center;
			padding:.2rem 0;
		}
		.distributor .form .submit{
			display:block;
			width:60%;
			margin:0 auto;
			color:#fff;
			border:1px solid red;
			background-color:red;
			border-radius:3px;
			padding:.2rem;
			font-size:.5rem;
			-webkit-appearance:none;
		}
		.distributor>.imgContent>img{
			width:100%;
		}
   </style>
</head>
<body>
<div class="distributor" style="display:block">
	<div class="title">输入物流信息</div>
	<form action="<%=request.getContextPath()%>/buyer/sendLogistics" class="form">
	<input type="hidden" value="${orderNumber }" name="orderNumber"/>
		<div class="form-group">
			<select id="logisticsSelect" name="logisticsSelect">
				<c:forEach items="${logisticsList }" var="logistics">
					<option value="${logistics.userLogisticsId}" data-phone="${logistics.logisticsPhoneNumber }"
					 data-park="${logistics.logisticsPark }">${logistics.logisticsCompanyName}</option>
				</c:forEach>
				<option value="otherLogistics">其他</option>
			</select>
		</div>
		<div class="form-group">
			<input type="text" placeHolder="请输入物流公司的名字" id="otherInput" name="logisticsCompanyCode" <c:if test="${logisticsList.size()!=0 }">style="display:none"</c:if>/>
		</div>
		<div class="form-group">
			<input type="text" placeHolder="请输入物流公司电话号码" id="transportPhone" name="transportPhoneNumber" <c:if test="${logisticsList.size()!=0 }">value="${logisticsList[0].logisticsPhoneNumber }"</c:if>/>
		</div>
		<div class="form-group">
			<input type="text" placeHolder="请输入物流园" id="logisticsPark" name="logisticsPark" <c:if test="${logisticsList.size()!=0 }">value="${logisticsList[0].logisticsPark }"</c:if>/>
		</div>
		<div class="form-group">
			<input type="text" placeHolder="请输入物流编号" id="transportNumber" name="logisticsCode"/>
		</div>
		<div class="imgDiv">
            <div class="imgContent">
                <input type="hidden" class="imgUrl" name="logisticsPic"/>
                <img class="smallImg" src="#"/>
                <span class="add"><i class="iconfont">&#xe628;</i></span>
                <span class="cancel"><i class="iconfont">&#xe632;</i></span>
            </div>
            <div class="imgTitle">物流单</div>
        </div>
		<input type="submit" class="submit" id="sendTo" value="发　货"/>
	</form>
</div>
<div class="tip"></div>
<div class="shade"></div>
<div class="waiting"></div>
<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/jweixin-1.0.0.js"></script>
<script>
	var logisticsCompanyCode;
	$("#sendTo").tap(function(){
		if($("#logisticsSelect").val()=="otherLogistics"){
			if($("#otherInput").val().trim()==""){
				showTip("请输入物流公司名称！");
			}
		}
		if($("#transportPhone").val().trim()==""){
			showTip("请输入物流公司电话！");
		}else if($("#transportNumber").val().trim()==""){
			showTip("请输入物流编号！");
		}else{
			if(logisticsCompanyCode==null)
				window.location.href="<%=request.getContextPath()%>/buyer/sendLogistics?logisticsCompanyCode="+$("#otherInput").val()+
				"&logisticsCode="+$("#transportNumber").val()+"&orderNumber=${orderNumber}&transportPhoneNumber="+$("#transportPhone").val()
				+"&logisticsSelect="+$("#logisticsSelect").val()+"&logisticsPark="+$("#logisticsPark").val();
			else	
				window.location.href="<%=request.getContextPath()%>/buyer/sendLogistics?logisticsCompanyCode="+logisticsCompanyCode+
				   "&logisticsCode="+$("#transportNumber").val()+"&orderNumber=${orderNumber}&transportPhoneNumber="+$("#transportPhone").val()
				   +"&logisticsSelect="+$("#logisticsSelect").val()+"&logisticsPark="+$("#logisticsPark").val();
		}
	});

	function showTip(str){
		$(".tip").html(str);
		$(".tip").css("opacity",1);
		setTimeout(function(){
			$(".tip").html("");
			$(".tip").css("opacity",0);
		},1000);
	}
	
	function fail(data){
		alert("fail");
	} 
	
	$(function(){
		calculate();
	})
	
	function calculate(){
		var numbers=0;
		var money=0;
		$(".commodity").each(function(){
			numbers = numbers+parseInt($(this).find(".moneyNum span").html().match(/\d+(\.\d+)?/g));
			money = money+(parseFloat($(this).find(".moneyNum h4").html().match(/\d+(\.\d+)?/g))*parseInt($(this).find(".moneyNum span").html().match(/\d+(\.\d+)?/g)));
		});
		$(".allP span").eq(0).html(numbers);
		$(".allP span").eq(1).html("￥"+money.toFixed(2));
	}
	
	$("#closeSendToDiv,#cancel,.shade").on("tap",function(){
		$(".sendLogistics").hide();
	});
	$("#logisticsSelect").change(function(){
		if($(this).val()=="otherLogistics"){
			$("#otherInput").css("display","block");
			$("#transportPhone").val("");
		}else{
			$("#otherInput").css("display","none");
			$("#transportPhone").val($('#logisticsSelect').find('option').not(function(){ return !this.selected }).attr("data-phone"));
			$("#logisticsPark").val($('#logisticsSelect').find('option').not(function(){ return !this.selected }).attr("data-park"));
		}
	});
	
	$(".rdBtn").tap(function(){
		window.location.href="<%=request.getContextPath()%>/buyer/returnDetail?returnInfoId="+$(this).attr("data-id");
	});
	
	$(".prevPage").tap(function(){
		history.go(-1);
	});
	
	var url=location.href.split('#')[0].replace(new RegExp('&','gm'),'-');
	var urlStr = "http://lanmao.zhuanlitou.com/wechat/signature?url="+url;
	//alert("Before Call:"+urlStr);
	$.ajax({
		method: "GET",
		url: urlStr,
		success:function(data,status,jqXHR){
			//alert(data.appId+","+data.signature+","+data.timeStamp+","+data.nonceStr);
			var result=data;
			var appId=result.appId;
			var signature = result.signature;
			var timeStamp = result.timeStamp;
		    var nonceStr = result.nonceStr;		 
		    
		    wx.config({
		        debug: false,// 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
		        appId: appId, // 必填，公众号的唯一标识
		        timestamp:timeStamp , // 必填，生成签名的时间戳
		        nonceStr: nonceStr, // 必填，生成签名的随机串
		        signature: signature,// 必填，签名，见附录1
		        jsApiList: ['onMenuShareTimeline','onMenuShareAppMessage','onMenuShareQQ'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
		    });
		    wx.error(function(res){
		           
		    });
		    wx.ready(function(){
		        // config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行
				//。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
		    	wx.onMenuShareAppMessage({
		    	    title: '<c:if test="${!empty application }">${application.shortCompanyName}</c:if>——繁灯网', // 分享标题
					link: location.href.split('#')[0], // 分享链接
					imgUrl: '${user.userProtraitPic}', // 分享图标
					success: function () { 
						// 用户确认分享后执行的回调函数
					},
					cancel: function () { 
						// 用户取消分享后执行的回调函数
					}
		    	});
		    	wx.onMenuShareTimeline({
		    	    title: '<c:if test="${!empty application }">${application.shortCompanyName}</c:if>——繁灯网', // 分享标题
					link: location.href.split('#')[0], // 分享链接
					imgUrl: '${user.userProtraitPic}', // 分享图标
					success: function () { 
						// 用户确认分享后执行的回调函数
					},
					cancel: function () { 
						// 用户取消分享后执行的回调函数
					}
		    	});
		    });
		}
	}); // end ajax
	
	$(".add").tap(function(){
		$(".waiting").show();
		$(".shade").show();
		chooseImg($(this).parents(".imgContent")[0]);
	});
	
	function chooseImg(obj) {
		var urlStr = "<%=request.getContextPath()%>/wechat/signature?url="+location.href.split('#')[0];
		//alert("Before Call:"+urlStr);
		$.ajax({
			method: "GET",
			url: urlStr,
			success:function(data,status,jqXHR){
				//alert(data.appId+","+data.signature+","+data.timeStamp+","+data.nonceStr);
				var result=data;
				var appId=result.appId;
				var signature = result.signature;
				var timeStamp = result.timeStamp;
			    var nonceStr = result.nonceStr;		 
			    
			    wx.config({
			        debug: false,// 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
			        appId: appId, // 必填，公众号的唯一标识
			        timestamp:timeStamp , // 必填，生成签名的时间戳
			        nonceStr: nonceStr, // 必填，生成签名的随机串
			        signature: signature,// 必填，签名，见附录1
			        jsApiList: ['chooseImage','uploadImage'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
			    });
			    wx.error(function(res){
			           
			    });
			    wx.ready(function(){
					$(".waiting").hide();
					$(".shade").hide();
			        // config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行
					//。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
			    	wx.chooseImage({
			    	    count: 1, // 默认9
			    	    sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
			    	    sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
			    	    success: function (res) {
			    	        localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
			    	        chooseUpload(obj,localIds[0]);
			    			$(obj).find("img").attr("src",localIds);
			    			
			    			var img = new Image();
			    			img.src=localIds;
			    			if(img.complete){
			    				console.log(123);
			    				changeImgDisplay(img,$(obj).find("img"));
			    			}else{
			    				var $that=$(this);
			    				img.onload=function(){
			    					changeImgDisplay(img,$(obj).find("img"));
			    				}
			    			}
			    	    }
			    	});
			    });
			}
		}); // end ajax
	}
	

	
	function changeImgDisplay(img,obj){
		var wid=img.width;
		var hgt=img.height;
		var width=$(".imgContent").width();
		var height=$(".imgContent").height();
		var rat=parseFloat(wid)/parseFloat(hgt);
		var ratio=parseFloat(width)/parseFloat(height);
		if(wid>=hgt&&wid>=parseFloat(width)&&hgt>=parseFloat(height)){
			obj.height(height);
		}else if(wid<hgt&&hgt>=parseFloat(height)&&wid>=parseFloat(width)){
			obj.width(width);
		}
		obj.attr("src",img.src);
	}
	
	function chooseUpload(obj,localIds){
		wx.uploadImage({
	   		 localId: localIds, // 需要上传的图片的本地ID，由chooseImage接口获得
	   		 isShowProgressTips: 1, // 默认为1，显示进度提示
	   		 success: function(res) {
	   		 	//返回图片的服务器端ID res.serverId,然后调用wxImgCallback函数进行下载图片操作
	   			$(obj).find("input[class='imgUrl']").val(res.serverId);
	   			$(obj).find("input[class='file']").remove();
	   			$(obj).find(".add").hide();
	   			$(obj).find(".cancel").show();
	   			$(obj).find("img").show();
	   		 },
	  		 fail: function(res) {      			
	  		 
	  		 }
	   	});
	}
	
	$(document).on("tap",".cancel",function(){
		var imgContent=$(this).parents(".imgContent");
		imgContent.find("img").attr("src","");
	  	imgContent.find("input[class='imgUrl']").val("");
	  	imgContent.find(".add").show();
	  	imgContent.find(".cancel").hide();
	  	imgContent.find("img").hide();
	});
</script>
</body>
</html> --%>