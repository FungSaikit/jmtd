<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib prefix="thumbnail" uri="/WEB-INF/tld/thumbnailTag.tld"%>
<%@ taglib prefix="ppt" uri="/WEB-INF/tld/productPriceTag.tld"%>

<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
		<title>聊天室</title>
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/common/swiper.min.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/customer/font/iconfont.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/customer/assets/css/chat.css?11">
    	<link href="<%=request.getContextPath() %>/resources/common/dropload.css" rel="stylesheet">
	</head>
	<body>
		<div class="swiper-container">
		  <div class="swiper-wrapper">
		    <div class="swiper-slide swiper-no-swiping" data-hash="slide1">
		    	<div class="chatList">
		    		<ul>
		    			<li class="loading" style="opacity:0;"></li>
		    		</ul>
		    	</div>
		    </div>
		    <div class="swiper-slide swiper-no-swiping chatSlide" data-hash="slide2">
				<div class="chating">
					<div class="dialog" id="dialogPanel">
						
					</div>
				</div>
		    </div>
		  </div>
		</div>
		
		<div class="backSlider">
			<div id="perv"><i class="iconfont icon-fanhuiicon"></i></div>
			<div class="name">单元格</div>
		</div>
		<div class="footEdit">
			<div class="edit">
				<div id="voice">
					<i class="iconfont icon-yuyin-copy-copy" id="voiceBtn"></i>
					<i class="iconfont icon-keyboard" id="keyboard"></i>
				</div>
				<div id="textInput">
					<textarea id="textarea"></textarea>
					<button id="speak">开始录音</button>
					<button id="sendVoice">发送</button>
				</div>
				<div id="add">
					<i class="iconfont icon-tianjia" id="addBtn"></i>
					<button id="send">发送</button>
				</div>
			</div>
			<div class="panel">
				<ul>
					<li id="uploadImage">
						<a href="javascript:void(0);">
							<div><i class="iconfont icon-tupian"></i></div>
							<p>图片</p>
						</a>
					</li>
					<li id="sendPhoneNumber">
						<a href="javascript:void(0);">
							<div><i class="iconfont icon-shoujihaoma"></i></div>
							<p>手机号码</p>
						</a>
					</li>
					<li id="sendQrCode">
						<a href="javascript:void(0);">
							<div><i class="iconfont icon-erweima"></i></div>
							<p>微信二维码</p>
						</a>
					</li>
					<li id="showAddr">
						<a href="javascript:void(0);">
							<div><i class="iconfont icon-dizhi"></i></div>
							<p>店铺地址</p>
						</a>
					</li>
				</ul>
			</div>
		</div>

		<jsp:include page="/jsp/information/chatFooter.jsp"></jsp:include>

		<div class="addrList">
			<ul>
				<li class="addrLi"><a href="">石家庄分店</a></li>
			</ul>
		</div>

		<div class="bgColor record">
			<div class="recordDiv"><div class="recordDiv1"></div><i class="iconfont icon-record"></i></div>
			<p>点击任意位置取消发送</p>
		</div>

		<div class="bgColor cancel">
			<div><i class="iconfont icon-icon"></i></div>
			<p>松开手指，取消发送</p>
		</div>

		<div class="bigImg"><img src="#" alt=""></div>
		<script src="<%=request.getContextPath() %>/resources/customer/assets/js/chat.js?12"></script>
   		<script src="<%=request.getContextPath() %>/resources/common/dropload.js"></script>
		<script src="<%=request.getContextPath()%>/resources/common/count.js?1c#xx"></script>
   		
		<script>
			//开始加载中
		    var canLoad=true;
			var noDate=false;
			var wiwH=$(window).height();
			var load=$(".loading");
			var time;
			var offset1=0;
		    $(".swiper-slide").scroll(function(){
		    	//获取该元素最近的被定位的父元素的坐标!  
				if(load.offset().top<wiwH){
			    	console.log("true");
					if(canLoad&&!noDate){
						canLoad=false;
						informationList();
					}
				}else{
					window.clearTimeout(time);
					$("#jiazai").html("加载中...");
					load.css("visibility","hidden");
					$(".loading>i").css("animation-play-state","running");
				}
				
		    });
		    //结束加载中
		
			informationList();
			/* var iInterval = setInterval("informationList()",2000); */
			var flag=false;//决定是否滚到底部
			
			function informationList(){
				countNewInfoNumber();
				var url="<%=request.getContextPath()%>/information/informationListAjax";
				var params={offset:offset1};
				doAjax("GET",url,params,getSuccess,fail,true,false);
			}
			
			function getSuccess(data){
				var list = data.data.list;
				var html="";
				for(var i=0;i<list.length;i++){
					html+='<li class="toChat" data-id="'+list[i].user.userId+'">';
					html+='<div class="headImg"><img src="'+list[i].user.userProtraitPic
					+'" alt="">'+(list[i].newInfoNumber>0?'<p class="badge"><span>'+list[i].newInfoNumber+'</span></p>':'')+'</div>';
					html+='<div class="describe">';
					html+='<h4>'+list[i].user.userNickname+(list[i].staffName==null?'':'('+list[i].staffName+')')+'</h4>';
					html+='<p>'+list[i].firstInfo+'</p>';
					html+='</div>';
					html+='<div class="time">'+FormatDate(list[i].infoTime)+'</div>';
					html+='<div class="deadLine">'+deadLine(list[i].user.rentVisitTime)+'</div>';
					html+='</li>';
				}
				$(html).insertBefore(".loading");
				if((parseInt(offset1)+10)>=data.data.count){
					noDate=true;
				}
				if(i>9&&i>=data.data.count){
					noDate=true;
				}
				offset1=data.data.after;
				canLoad=true;
			}
			
			$(document).on("tap",".toUrl",function(){
				window.location.href=$(this).attr("data-url");
			});
			
			function fail(data){
				console.log("fail");
			}
			
			function FormatDate (strTime) {
			    var date = new Date(strTime);
			    if(isToday(date))
			    	return date.Format("hh:mm");
			    else
			    	return date.Format("MM月dd日");
			}
			
			function isToday(date){
			    var today=new Date();
			    return date.getFullYear()==today.getFullYear()
			    	&& date.getMonth()==today.getMonth() && date.getDate()==today.getDate();
			}
			
			function deadLine(visitTime){
				console.log(visitTime)
				if(visitTime==null){
					return "离线";
				}else{
					var time = visitTime+2*24*60*60*1000-new Date().getTime();
					if(time<0)
						return "离线";
					else
						if(${user.role==2})
							return "还有"+Math.round(time/1000.0/60.0/60.0)+"小时后过期";
						else
							return "在线";//+Math.round(time/1000.0/60.0/60.0)+"小时后过期";
				}
			}
			
			var toUserId;
			var toUserHeadImg;
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
				        jsApiList: ['startRecord','stopRecord','playVoice','stopVoice','uploadVoice'
				                    ,'downloadVoice','chooseImage','uploadImage','onVoicePlayEnd','onVoiceRecordEnd'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
				    });
				    wx.ready(function(){
				        // config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
				    	
				        
				    });
				}
			}); // end ajax   
			function startRecord(){
				wx.startRecord();
				wx.onVoiceRecordEnd({
				    // 录音时间超过一分钟没有停止的时候会执行 complete 回调
				    complete: function (res) {
				        var localId = res.localId; 
				        $("#speak").show();
						$("#sendVoice").hide();
						$(".record").hide();
						$(".recordDiv1").removeClass("recording");
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
			
			function doNotRecord(){
				wx.stopRecord({
		    	    success: function (res) {
		    			var localId = res.localId;
		    	    }
		    	});
			}
			
			var voiceId="";
			function playVoice(mediaId){
				if(voiceId!=""){
					wx.stopVoice({
					    localId: voiceId // 需要停止的音频的本地ID，由stopRecord接口获得
					});
				}
				wx.downloadVoice({
				    serverId: mediaId, // 需要下载的音频的服务器端ID，由uploadVoice接口获得
				    isShowProgressTips: 1, // 默认为1，显示进度提示
				    success: function (res) {
				        var localId = res.localId; // 返回音频的本地ID
				        voiceId=localId;
				        wx.playVoice({
						    localId: localId // 需要播放的音频的本地ID，由stopRecord接口获得
						});
				        wx.onVoicePlayEnd({
			        	    success: function (res) {
			        	        var localId = res.localId; // 返回音频的本地ID
			        	        voiceId="";
			        	    	$(".progress").hide();
			        	    	$(".playing").show();
			        	    }
			        	});
				    }
				});
			}
			
			function addVoice(mediaId){
				var url="<%=request.getContextPath()%>/information/addVoice";
				var params={mediaId:mediaId,toUserId:toUserId};
				doAjax("GET",url,params,addSuccess,fail,true,false);
			}
			
			function addSuccess(data){
				html="";
				if(data.data.sendTime-$(".chatTime").last().attr("data-time")>=1200000)
					html+='<div class="chatTime" data-time="'+data.data.sendTime+'">'+formatDate1(data.data.sendTime)+'</div>';
				if(data.data.fromUserId==toUserId)
					html+='<div class="left">';
				else
					html+='<div class="right">';
				html+='<div class="head"><i class="iconfont icon-fanhuiicon triangle"></i><img src="'+(data.data.fromUserId==toUserId?toUserHeadImg:'${user.userProtraitPic}')+'" alt=""></div>';
				if(data.data.infoType==0){
					html+='<div class="text">'+data.data.infoContent+'</div>';
				}else if(data.data.infoType==1){
					html+='<div class="chatImg"><img src="'+changePath(data.data.infoContent)+'" data-image="'+data.data.infoContent+'" alt=""></div>';
				}else if(data.data.infoType==2){
					if(data.data.mediaId!=null)
						html+='<div class="playVoice"><button class="playing" data-mediaId="'+data.data.mediaId+'">点击播放</button><div class="progress"><div></div><div></div><div></div><div></div><div></div></div></div>';
					else
						html+='<div class="playVoice"><button class="playing noMedia" data-mediaId="'+data.data.mediaId+'">点击播放</button><div class="progress"><div></div><div></div><div></div><div></div><div></div></div></div>';
				}
				html+='</div>';
				$(".dialog").append(html);
				if($(".panel").css("display")=="block"){
					$(".dialog").css("margin-bottom",$('.footEdit').height());
					$('.chatSlide')[0].scrollTop = $('#dialogPanel')[0].scrollHeight;
				}else{
					$(".chatSlide ")[0].scrollTop=$(".chatSlide")[0].scrollHeight-51;
				}
				
                var chatLi=$(".toChat[data-id='"+toUserId+"']");
                $(".chatList ul").prepend(chatLi);
            	if(data.data.infoType==0){
            		chatLi.find(".describe p").html(data.data.infoContent);
            	}else if(data.data.infoType==1){
            		chatLi.find(".describe p").html("[图片]");
            	}else if(data.data.infoType==2){
            		chatLi.find(".describe p").html("[语音]");
            	}
            	chatLi.find(".time").html(FormatDate(new Date()));
			}
			
			function addText(){
				var url = "<%=request.getContextPath()%>/information/addText";
				var params={content:$("#textarea").val(),toUserId:toUserId};
				doAjax("GET",url,params,addSuccess,fail,true,false);
				$("#textarea").val("");
			}
			
			function addText1(text){
				var url = "<%=request.getContextPath()%>/information/addText";
				var params={content:text,toUserId:toUserId};
				doAjax("GET",url,params,addSuccess,fail,true,false);
				$("#textarea").val("");
			}
			
			$("#send").tap(function(){
				addText();
				$("#addBtn").show();
				$("#send").hide();
				$("#textarea").focus();
			});
			
			var offset=0;
			var webSocketNum=0;
			function userInformationList(){
				var url="<%=request.getContextPath()%>/information/userInformationAjax"; 
				console.log(offset+webSocketNum)
				var params={fromUserId:toUserId,offset:(offset+webSocketNum)};
				doAjax("GET",url,params,getUInformationSuccess,fail,true,false);
			}
			 
			var canLoad=true;
			function getUInformationSuccess(data){
				var list = data.data.list;
				var html="";
				var result="";
				
				var showTimeIndex=list.length-1;
				for(var i=list.length-1;i>=0;i--){
					html="";
					if(i==list.length-1||(list[i].sendTime-list[showTimeIndex].sendTime)>=1200000){
						html+='<div class="chatTime '+(i==list.length-1?'topDiv':'')+'" data-time="'+list[i].sendTime+'">'+formatDate1(list[i].sendTime)+'</div>';
						showTimeIndex=i;
					}
					if(list[i].fromUserId==toUserId)
						html+='<div class="left">';
					else
						html+='<div class="right">';
					html+='<div class="head"><i class="iconfont icon-fanhuiicon triangle"></i><img src="'+(list[i].fromUserId==toUserId?toUserHeadImg:'${user.userProtraitPic}')+'" alt=""></div>';
					if(list[i].infoType==0){
						html+='<div class="text">'+list[i].infoContent+'</div>';
					}else if(list[i].infoType==1){
						html+='<div class="chatImg"><img src="'+changePath(list[i].infoContent)+'" data-image="'+list[i].infoContent+'" alt=""></div>';
					}else if(list[i].infoType==2){
						if(list[i].mediaId!=null)
							html+='<div class="playVoice"><button class="playing" data-mediaId="'+list[i].mediaId+'">点击播放</button><div class="progress"><div></div><div></div><div></div><div></div><div></div></div></div>';
						else
							html+='<div class="playVoice"><button class="playing noMedia" data-mediaId="'+list[i].mediaId+'">点击播放</button><div class="progress"><div></div><div></div><div></div><div></div><div></div></div></div>';
					}
					html+='</div>';
					result=result+html;
					/* if(list[i].fromUserId==toUserId)
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
					if(list[i].fromUserId!=toUserId)
						html+='<img src="${toUser.userProtraitPic}" style="width:50px;height:50px"/>'
					html+="</div>"; */
				}
				$(".dialog").prepend(result);
				if(flag){
					setTimeout(function(){$(".chatSlide ")[0].scrollTop=$(".chatSlide")[0].scrollHeight-51;},100);
					flag=false;
				}else{
					setTimeout(function(){$(".chatSlide ")[0].scrollTop=$(".topDiv").eq(1)[0].offsetTop-35;},100);
				}
				if((parseInt(offset+webSocketNum)+10)>=data.data.count+webSocketNum){
					canLoad=false;
    			}else{
    			}
				offset=data.data.after;
				
			}
			
			function formatDate1 (strTime) {
			    var date = new Date(strTime);
			    if(isToday(date))
			    	return date.Format("hh:mm");
			    else
				    return date.Format("MM月dd日  hh:mm");
			}
			
			function fail(data){
				console.log("fail");
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
				var params={mediaId:mediaId,toUserId:toUserId};
				doAjax("GET",url,params,addImageSuccess,fail,true,false);
			}
			
			function addImageSuccess(data){
				html="";
				if(data.data.sendTime-$(".chatTime").last().attr("data-time")>=1200000)
					html+='<div class="chatTime" data-time="'+data.data.sendTime+'">'+formatDate1(data.data.sendTime)+'</div>';
				if(data.data.fromUserId==toUserId)
					html+='<div class="left">';
				else
					html+='<div class="right">';
				html+='<div class="head"><i class="iconfont icon-fanhuiicon triangle"></i><img src="'+(data.data.fromUserId==toUserId?toUserHeadImg:'${user.userProtraitPic}')+'" alt=""></div>';
				if(data.data.infoType==0){
					html+='<div class="text">'+data.data.infoContent+'</div>';
				}else if(data.data.infoType==1){
					html+='<div class="chatImg"><img src="'+changePath(data.data.infoContent)+'" data-image="'+data.data.infoContent+'" alt=""></div>';
				}else if(data.data.infoType==2){
					if(data.data.mediaId!=null)
						html+='<div class="playVoice"><button class="playing" data-mediaId="'+data.data.mediaId+'">点击播放</button></div><div class="progress"><div></div><div></div><div></div><div></div><div></div></div></div>';
					else
						html+='<div class="playVoice"><button class="playing noMedia" data-mediaId="'+data.data.informationId+'">点击播放</button></div><div class="progress"><div></div><div></div><div></div><div></div><div></div></div></div>';
				}
				html+='</div>';
				$(".dialog").append(html);
				if($(".panel").css("display")=="block"){
					$(".dialog").css("margin-bottom",$('.footEdit').height());
					$('.chatSlide')[0].scrollTop = $('#dialogPanel')[0].scrollHeight;
				}else{
					$(".chatSlide")[0].scrollTop=$(".chatSlide")[0].scrollHeight-51;
				}
			}
			
			function playVoice1(informationId){
				var url="<%=request.getContextPath()%>/information/playVoice";
				var params={informationId:informationId};
				doAjax("GET",url,params,playSuccess,fail,true,false);
			}
			
			function playSuccess(data){

				if(voiceId!=""){
					wx.stopVoice({
					    localId: voiceId // 需要停止的音频的本地ID，由stopRecord接口获得
					});
				}
				wx.downloadVoice({
				    serverId: data.data, // 需要下载的音频的服务器端ID，由uploadVoice接口获得
				    isShowProgressTips: 1, // 默认为1，显示进度提示
				    success: function (res) {
				        var localId = res.localId; // 返回音频的本地ID
				        voiceId=localId;
				        wx.playVoice({
						    localId: localId // 需要播放的音频的本地ID，由stopRecord接口获得
						});
				        wx.onVoicePlayEnd({
			        	    success: function (res) {
			        	        var localId = res.localId; // 返回音频的本地ID
			        	        voiceId="";
			        	    	$(".progress").hide();
			        	    	$(".playing").show();
			        	    }
			        	});
				    }
				});
			}
			
				initWebSocket();
	          //初始话WebSocket  
	            function initWebSocket() {  
	                if (window.WebSocket) {  
	                    websocket = new WebSocket(encodeURI('ws://lanmao.zhuanlitou.com/message'));  
	                    websocket.onopen = function() {  
	                        //连接成功  
	                        console.log('  (已连接)');  
	                    }  
	                    websocket.onerror = function() {  
	                        //连接失败  
	                         console.log( '  (连接发生错误)');  
	                    }  
	                    websocket.onclose = function() {  
	                        //连接断开  
	                         console.log( '  (已经断开连接)');  
	                    }  
	                    //消息接收  
	                    websocket.onmessage = function(message) {  
	                        console.log(message.data=="{}")
	                        var message1 =  eval("(" + message.data + ")"); 
	                        //接收用户发送的消息  
	                        console.log(message1.infoContent);
	                        console.log(message1.fromUserId==toUserId);
	                        if(message.data!="{}"){
	                        	var chatLi=$(".toChat[data-id='"+message1.fromUserId+"']");
	                        	$(".chatList ul").prepend(chatLi);
	                        	if(chatLi.find(".badge").html()==null){
	                        		chatLi.find(".headImg").append('<p class="badge"><span>1</span></p>');
	                        	}else{
	                        		chatLi.find(".badge").find("span").html(parseInt(chatLi.find(".badge").find("span").html())+1);
	                        	}
	                        	if(message1.infoType==0){
	                        		chatLi.find(".describe p").html(message1.infoContent);
	                        	}else if(message1.infoType==1){
	                        		chatLi.find(".describe p").html("[图片]");
	                        	}else if(message1.infoType==2){
	                        		chatLi.find(".describe p").html("[语音]");
	                        	}
	                        	chatLi.find(".deadLine").html("48小时后过期");
	                        	chatLi.find(".time").html(FormatDate(new Date()));
	                        	
	                        	if(message1.fromUserId==toUserId){
			                        var html="";
			        				if(message1.sendTime-$(".chatTime").last().attr("data-time")>=1200000)
			    						html+='<div class="chatTime" data-time="'+message1.sendTime+'">'+formatDate1(message1.sendTime)+'</div>';
			    					if(message1.fromUserId==toUserId)
			    						html+='<div class="left">';
			    					else
			    						html+='<div class="right">';
			    					html+='<div class="head"><i class="iconfont icon-fanhuiicon triangle"></i><img src="'+(message1.fromUserId==toUserId?toUserHeadImg:'${user.userProtraitPic}')+'" alt=""></div>';
			    					if(message1.infoType==0){
			    						html+='<div class="text">'+message1.infoContent+'</div>';
			    					}else if(message1.infoType==1){
			    						html+='<div class="chatImg"><img src="'+changePath(message1.infoContent)+'" alt="" data-image="'+message1.infoContent+'"></div>';
			    					}else if(message1.infoType==2){
			    						if(message1.mediaId!=null)
			    							html+='<div class="playVoice"><button class="playing" data-mediaId="'+message1.mediaId+'">点击播放</button></div><div class="progress"><div></div><div></div><div></div><div></div><div></div></div></div>';
			    						else
			    							html+='<div class="playVoice"><button class="playing noMedia" data-mediaId="'+message1.informationId+'">点击播放</button></div><div class="progress"><div></div><div></div><div></div><div></div><div></div></div></div>';
			    					}
			    					html+='</div>';
			    					$(".dialog").append(html);
			    					webSocketNum++;
			    					if($(".panel").css("display")=="block"){
			    						$(".dialog").css("margin-bottom",$('.footEdit').height());
			    						$('.chatSlide')[0].scrollTop = $('#dialogPanel')[0].scrollHeight;
			    					}else{
			    						$(".chatSlide ")[0].scrollTop=$(".chatSlide")[0].scrollHeight-51;
			    					}
			    					setReaded(message1.informationId);
			    					chatLi.find(".badge").remove();
	                        	}
	                        }
	                    }
	                }  
	            };  
	            
	            
	         // dropload
	            $(".chating").dropload({
	                scrollArea : $(".chatSlide"),
	                domUp : {
	                    domClass   : 'dropload-up',
	                    domRefresh : '<div class="dropload-refresh"><i class="iconfont">&#xe634;</i>下拉刷新</div>',
	                    domUpdate  : '<div class="dropload-update"><i class="iconfont">&#xe633;</i>释放更新</div>',
	                    domLoad    : '<div class="dropload-load"><span class="iconfont">&#xe62c;</span>加载中...</div>',
	                    domNoData  : '<div class="dropload-noData">已经到顶部了</div>'
	                },
	                domDown : {
	                    domClass   : 'dropload-down',
	                    domRefresh : '',
	                    domLoad    : '',
	                    domNoData  : ''
	                },
	                loadUpFn : function(me){
	                	/* if(parseInt($("#upPageNo").val())>=0)
	                		if(canLoad){
	     		               	loadProductUp(me);
	                		}else{
	                			me.resetload();
	                            me.unlock();
	            				me.noData(true);
	            				showTip("已经到顶部了!");
	                		}
	                	else{
	                		me.resetload();
	                        me.unlock();
	        				me.noData(true);
	        				showTip("已经到顶部了!");
	                	} */
	                	
	                	if(canLoad){
	                		me.resetload();
	                        me.unlock();
	            			me.noData(false);
	                		userInformationList();
	                	}else{
	                		me.resetload();
	                        me.unlock();
	            			me.noData(true);
	            			showTip("已经到顶部了!");
	                	}
	                },
	                loadDownFn : function(me){
	                    me.noData(true);
	                    me.lock('down');
	               	 	me.resetload();
	                },
	                threshold : 50
	            });
	         
	         function setReaded(informationId){
	        	 var url="<%=request.getContextPath()%>/information/setReaded";
	        	 var params={informationId:informationId};
	        	 doAjax("GET",url,params,setReadedSuccess,fail,true,false);
	         }
	         
	         function setReadedSuccess(data){
	        	 
	         }

	        $("#uploadImage").tap(function(){
	        	$(".waiting").show();
	        	$(".shade").show();
	        	chooseImg();
	        });
	        
	        function changePath(path){
        		var i=path.lastIndexOf("/");
        		return path.substring(0,i+1)+"thumbnailImage/"+path.substring(i+1);
        	}
	        
	        Date.prototype.Format = function (fmt) { //author: meizz 
	            var o = {
	                "M+": this.getMonth() + 1, //月份 
	                "d+": this.getDate(), //日 
	                "h+": this.getHours(), //小时 
	                "m+": this.getMinutes(), //分 
	                "s+": this.getSeconds(), //秒 
	                "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
	                "S": this.getMilliseconds() //毫秒 
	            };
	            if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	            for (var k in o)
	            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
	            return fmt;
	        }
	        
	        $("#sendPhoneNumber").tap(function(){
	        	if("${empty user.informationPhone}"=="true")
	        		showTip("电话号码为空，请先设置电话号码！",function(){window.location.href="<%=request.getContextPath()%>/information/setting";})
	        	else
	        		addText1("${user.informationPhone}");
	        });
	        
	        $("#sendQrCode").tap(function(){
	        	if("${empty user.qrCodePic}"=="true")
	        		showTip("二维码为空，请先上传二维码！",function(){window.location.href="<%=request.getContextPath()%>/information/setting";})
		        else{
		        	html="";
					if(new Date().getTime()-$(".chatTime").last().attr("data-time")>=1200000)
						html+='<div class="chatTime" data-time="'+new Date().getTime()+'">'+formatDate1(new Date().getTime())+'</div>';
					
					html+='<div class="right">';
					html+='<div class="head"><i class="iconfont icon-fanhuiicon triangle"></i><img src="${user.userProtraitPic}" alt=""></div>';
					
					html+='<div class="chatImg"><img src="'+changePath("${user.qrCodePic}")+'" data-image="${user.qrCodePic}" alt=""></div>';
					
					html+='</div>';
					$(".dialog").append(html);if($(".panel").css("display")=="block"){
						$(".dialog").css("margin-bottom",$('.footEdit').height());
						$('.chatSlide')[0].scrollTop = $('#dialogPanel')[0].scrollHeight;
					}else{
						$(".chatSlide ")[0].scrollTop=$(".chatSlide")[0].scrollHeight-51;
					}
					addQrCode();
		        }
	        });
	        
	        function addQrCode(){
				var url = "<%=request.getContextPath()%>/information/addQrCode";
				var params={toUserId:toUserId};
				doAjax("GET",url,params,addQrCodeSuccess,fail,true,false);
			}
	        
	        function addQrCodeSuccess(data){
	        	
	        }
	        
	        window.onhashchange=function(){
	        	if(location.hash=="#slide1"){
	    			$(".backSlider").hide();
	    			$(".footEdit").hide();
	    			mySwiper.slidePrev();
	    			$(".footer").show();
	    			toUserId=0;
	    			offset=0;
	    			webSocketNum=0;
	    			canLoad=true;
	    			/* iInterval = setInterval("informationList()",2000); */
		        	mySwiper.slideTo(location.hash.substr(6)-1);
	    		}
	    		if(location.hash=="#slide2"){
	    		}
	    	}
	        
	        $("#showAddr").tap(function(){
	        	addText1("${address}");
	        });
	        
		</script>
	</body>
</html>