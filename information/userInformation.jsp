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
<div class="content">
</div>
<button onclick="chooseImg()">图片</button>
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
			        jsApiList: ['startRecord','stopRecord','playVoice','uploadVoice','downloadVoice','chooseImage','uploadImage'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
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
    	        	        addVoice(serverId);
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
			        wx.playVoice({
					    localId: localId // 需要播放的音频的本地ID，由stopRecord接口获得
					});
			    }
			});
		}
		
		function addVoice(mediaId){
			var url="<%=request.getContextPath()%>/information/addVoice";
			var params={mediaId:mediaId,toUserId:"${fromUserId}"};
			doAjax("GET",url,params,addSuccess,fail,true,false);
		}
		
		function addSuccess(data){

			informationList();
		}
		
		informationList();
		setInterval("informationList()",2000);
		
		function informationList(){
			var url="<%=request.getContextPath()%>/information/userInformationAjax"; 
			var params={fromUserId:"${fromUserId}"};
			doAjax("GET",url,params,getSuccess,fail,true,false);
		}
		
		function getSuccess(data){
			var list = data.data;
			var html="";
			for(var i=0;i<list.length;i++){
				if(list[i].fromUserId==${fromUserId})
					html+='<div><img src="${fromUser.userProtraitPic}" style="width:50px;height:50px"/>';
				else
					html+='<div>';
				if(list[i].infoType==0){
					html+=list[i].infoContent;
				}else if(list[i].infoType==1){
					html+='<img src="'+list[i].infoContent+'" style="width:100px;height:100px"/>'
				}else if(list[i].infoType==2){
					if(list[i].mediaId!=null)
						html+='<button onclick="playVoice(\''+list[i].mediaId+'\')">播放</button>';
					else
						html+='<button onclick="playVoice1(\''+list[i].informationId+'\')">播放</button>';	
				}
				if(list[i].fromUserId!=${fromUserId})
					html+='<img src="${toUser.userProtraitPic}" style="width:50px;height:50px"/>'
				html+="</div>";
			}
			$(".content").html(html);
		}
		
		function fail(data){
			alert("fail");
		}
		
		function chooseImg() {
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
	    	        chooseUpload(localIds[0]);
	    	    }
	    	});
		}
		
		
		function chooseUpload(localIds){
			wx.uploadImage({
		   		 localId: localIds, // 需要上传的图片的本地ID，由chooseImage接口获得
		   		 isShowProgressTips: 1, // 默认为1，显示进度提示
		   		 success: function(res) {
		   		 	//返回图片的服务器端ID res.serverId,然后调用wxImgCallback函数进行下载图片操作
		   		 	addImage(res.serverId)
		   		 },
		  		 fail: function(res) {      			
		  		 
		  		 }
		   	});
		}
		
		function addImage(mediaId){
			var url = "<%=request.getContextPath()%>/information/addImage";
			var params={mediaId:mediaId,toUserId:"${fromUserId}"};
			doAjax("GET",url,params,addImageSuccess,fail,true,false);
		}
		
		function addImageSuccess(data){
			
		}
		
		function playVoice1(informationId){
			var url="<%=request.getContextPath()%>/information/playVoice";
			var params={informationId:informationId};
			doAjax("GET",url,params,playSuccess,fail,true,false);
		}
		
		function playSuccess(data){
			wx.downloadVoice({
			    serverId: data.data, // 需要下载的音频的服务器端ID，由uploadVoice接口获得
			    isShowProgressTips: 1, // 默认为1，显示进度提示
			    success: function (res) {
			        var localId = res.localId; // 返回音频的本地ID
			        wx.playVoice({
					    localId: localId // 需要播放的音频的本地ID，由stopRecord接口获得
					});
			    }
			});
		}
  </script>
</body>
</html>