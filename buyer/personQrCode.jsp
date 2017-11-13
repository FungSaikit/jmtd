<%@ page language="java" import="java.util.*,com.alphaking.constant.*,com.alphaking.model.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>佐为照明</title>
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/customer/assets/css/personCenter.css?12c11" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
	<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
    <script>
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
			    	    title: '<c:if test="${user.role!=2  }">${user.shortCompanyName}——</c:if>繁灯网', // 分享标题
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
			    	    title: '<c:if test="${user.role!=2  }">${user.shortCompanyName}——</c:if>繁灯网', // 分享标题
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
	</script>
</head>
<body>
<div class="distributor">
	
	<div class="qrCodeContent" id="qrCode">
        <img src="${user.personQrCode }" alt="" style="width:100%"/>
    </div>
   
</div>
<!-- 查看大图 -->
<jsp:include page="/jsp/buyer/footer.jsp"></jsp:include>

</body>
</html>
