<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib prefix="thumbnail" uri="/WEB-INF/tld/thumbnailTag.tld"%>
<%@ taglib prefix="ppt" uri="/WEB-INF/tld/productPriceTag.tld"%>

<!DOCTYPE html>
<html class="balanceHtml">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>佐为照明</title>
    <link href="<%=request.getContextPath() %>/resources/common/swiper.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/customer/assets/css/orderCart.css?11111" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
</head>
<body class="balanceBody">
<c:forEach items="${infoList}" var="info"><div>${info.informationId}</div>
	<c:if test="${info.infoType==0}">${info.infoContent}</c:if>
	<c:if test="${info.infoType==1}"><img src="${info.infoContent}" style="width:100px;height:100px"/></c:if>
	<c:if test="${info.infoType==2}"><button onclick="playVoice('${info.mediaId}')">播放</button></c:if>
</c:forEach>
<button onclick="startRecord()">录音</button>
<button onclick="stopRecord()">停止</button>
<!--[[遮罩层-->
<div class="shadow" style="display: none;"></div>
<!--遮罩层]]-->
<!-- 开始确认框 -->
<div class="confirmDiv" id="delete">
	<div class="confirmTop">
		<span>温馨提醒</span>
		<span id="closeConfirm">X</span>
	</div>
	<p>确定删除？</p>
	<div class="confirmBottom">
		<span id="cancel">取消</span>
		<span id="confirm">确定</span>
	</div>
</div>
<!-- 结束确认框 -->
<!--[[地址选择-->
<!-- <div class="balance-address">
   
</div> -->
<!--地址选择]]-->

<!--[[底部-->
<%-- <jsp:include page="/jsp/buyer/footer.jsp"></jsp:include> --%>
<!--底部]]-->
<!-- 等待加载 -->
<div class="waiting"><i class="iconfont">&#xe62c;</i></div>
<div class="shade"></div>
<div class="tip"></div>
<!-- 等待加载 -->
<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/swiper.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/jweixin-1.0.0.js"></script>
<script>
		var urlStr = "<%=request.getContextPath()%>/wechat/signature?url="+location.href.split('#')[0];
		//alert("Before Call:"+urlStr);
		$.ajax({
			method: "GET",
			url: urlStr,
			success:function(result,status,jqXHR){
				var appId=result.appId;
				var signature = result.signature;
				var timeStamp = result.timeStamp;
			    var nonceStr = result.nonceStr;		 
			    wx.config({
			        debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
			        appId: appId, // 必填，公众号的唯一标识
			        timestamp:timeStamp , // 必填，生成签名的时间戳
			        nonceStr: nonceStr, // 必填，生成签名的随机串
			        signature: signature,// 必填，签名，见附录1
			        jsApiList: ['startRecord','stopRecord','playVoice','uploadVoice','downloadVoice'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
			    });
			    wx.ready(function(){
			        // config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
			    	
			        
			    });
			}
		}); // end ajax   
		function startRecord(){
			wx.startRecord();
		}
		
		function stopRecord(){
			wx.stopRecord({
	    	    success: function (res) {
	    			var localId = res.localId;
	    	         wx.uploadVoice({
    	        	    localId: localId, // 需要上传的音频的本地ID，由stopRecord接口获得
    	        	    isShowProgressTips: 1, // 默认为1，显示进度提示
    	        	        success: function (res) {
    	        	        var serverId = res.serverId; // 返回音频的服务器端ID
    	        	        addInformation(serverId);
    	        	    }
    	        	});
	    	    }
	    	});
		}
		
		function playVoice(mediaId){
			wx.downloadVoice({
			    serverId: mediaId, // 需要下载的音频的服务器端ID，由uploadVoice接口获得
			    isShowProgressTips: 1, // 默认为1，显示进度提示
			    success: function (res) {
			        var localId = res.localId; // 返回音频的本地ID
			        alert(localId)
			        wx.playVoice({
					    localId: localId // 需要播放的音频的本地ID，由stopRecord接口获得
					});
			    }
			});
		}
		
		function addInformation(mediaId){
			var url="<%=request.getContextPath()%>/information/addInformation";
			var params={mediaId:mediaId};
			doAjax("GET",url,params,addSuccess,fail,true,false);
		}
		
		function addSuccess(data){
			
		}
		
		function fail(data){
			alert("fail");
		}
  </script>
</body>
</html>