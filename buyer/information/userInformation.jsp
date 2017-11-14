<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib prefix="thumbnail" uri="/WEB-INF/tld/thumbnailTag.tld"%>
<%@ taglib prefix="ppt" uri="/WEB-INF/tld/productPriceTag.tld"%>

<!DOCTYPE html>
<html lang="zh">
<head>
    <meta name="viewport"
          content="width=device-width,height=device-height, user-scalable=no,initial-scale=1, minimum-scale=1, maximum-scale=1">
    <meta charset="UTF-8">
    <title>金明同达灯饰</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/customer/assets/css/fung.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/customer/assets/js/vue.js"></script>
    <style type="text/css">

        .inputbox {
            width: 100%;
            height: 3rem;
            line-height: 3rem;
            position: fixed;
            bottom: 0;
            left: 0;
            background-color: #fff;
            display: flex;
        }

        .inputleft_img {
            vertical-align: middle;
            height: 2rem;
            width: 2rem;
            margin: 0.5rem;
            border: 1px gray solid;
            border-radius: 1.1rem;
        }

        .inputright_img {
            vertical-align: middle;
            height: 2rem;
            width: 2rem;
            margin: 0.5rem;
        }

        .inputbox textarea {
            vertical-align: middle;
            margin: 0.5rem 0;
            height: 2rem;
            flex-grow: 1;
            font-size: 1.2rem;
            border: 1px lightgray solid;
            border-radius: 0.5rem;
        }

        .talkblock {
            display: block;
            text-align: left;
            width: 100%;
            margin-bottom: 1rem;
        }

        .talktime {
            width: 100%;
            text-align: center;
            font-size: 0.8rem;
            color: gray;
        }

        .talk_icon {
            vertical-align: top;
            margin: 0.5rem;
            height: 2.5rem;
            width: 2.5rem;
        }

        .messagecontent {
            vertical-align: top;
            display: inline-block;
            background-color: #fff;
            border: 1px lightgray solid;
            border-radius: 0.5rem;
            width: auto;
            height: auto;
            max-width: 60%;
            min-height: 2rem;
            padding: 0.5rem;
        }

        .chatcontent:after {
            content: "";
            display: block;
            clear: both;
        }

        .corner_left {
            float: left;
            background-color: #fff;
            border-bottom: lightgray 1px solid;
            border-left: lightgray 1px solid;
            display: inline-block;
            width: 0.5rem;
            height: 0.5rem;
            transform: rotate(45deg);
            vertical-align: bottom;
            position: relative;
            top: 1.5rem;
            left: 0.3rem;
        }

        .corner_right {
            float: right;
            background-color: #fff;
            border-top: lightgray 1px solid;
            border-right: lightgray 1px solid;
            display: inline-block;
            width: 0.5rem;
            height: 0.5rem;
            transform: rotate(45deg);
            vertical-align: bottom;
            position: relative;
            top: 1.5rem;
            right: 0.3rem;
        }

        .messagecontent img {
            height: auto;
            width: auto;
            max-height: 100%;
            max-width: 100%;
        }

        .voice_img {
            width: 2rem !important;
            height: 2rem !important;
        }

        .record_button {
            vertical-align: middle;
            margin: 0.5rem 0;
            height: 2rem;
            line-height: 2rem;
            flex-grow: 1;
            font-size: 1rem;
            border: 1px lightgray solid;
            border-radius: 0.5rem;
            text-align: center;
            margin-right: 0.5rem;
            color: dimgray;
        }

        .voicenotice {
            position: fixed;
            margin: auto;
            top: 0;
            bottom: 0;
            left: 0;
            right: 0;
            width: 10rem;
            height: 8rem;
            background-color: rgba(0, 0, 0, 0.8);
            color: #fff;
            text-align: center;
            font-size: 1.5rem;
            border-radius: 0.5rem;
        }

    </style>
</head>
<body>

<div class="navibar">
    <img onclick="history.go('-1');" src="<%=request.getContextPath()%>/resources/customer/assets/images/top_bar/back_white.png" alt="" class="topbar_button">
    <div class="topbarmiddle">${fromUser.userNickname }</div>
    <div style="float: right;" class="topbar_button"></div>
</div>

<div class="placeholder"></div>
<div class="chatcontent" id="chat">

    <div class="talkblock" v-for="item in chatContents" :class="{floatleft: !item.isYou, floatright: item.isYou}">

        <div class="talktime">
            {{getTime(item.time)}}
        </div>

        <img class="talk_icon" v-if="item.isYou" :src="thisImg"
             :class="{floatleft: !item.isYou, floatright: item.isYou}">
        <img class="talk_icon" v-if="!item.isYou" :src="thatImg"
             :class="{floatleft: !item.isYou, floatright: item.isYou}">

        <div :class="{corner_left: !item.isYou, corner_right: item.isYou}"></div>

        <div class="messagecontent" :class="{floatleft: !item.isYou, floatright: item.isYou}" v-if="item.type == 0">
            <!--如果是文字-->
            {{item.content}}
        </div>
        <div class="messagecontent" :class="{floatleft: !item.isYou, floatright: item.isYou}" v-if="item.type == 2">
            <!--如果是音频-->
            <img class="voice_img" v-if="item.isYou" src="<%=request.getContextPath()%>/resources/customer/assets/images/personal_center/sound_from_right.png"
                 :asrc="item.content" alt="语音"
                 onclick="playAudio(this.getAttribute('asrc'),this)" :data-needDown="item.needDownload">
            <img class="voice_img" v-if="!item.isYou" src="<%=request.getContextPath()%>/resources/customer/assets/images/personal_center/sound_from_left.png"
                 :asrc="item.content" alt="语音"
                 onclick="playAudio(this.getAttribute('asrc'),this)" :data-needDown="item.needDownload">
        </div>
        <div class="messagecontent" :class="{floatleft: !item.isYou, floatright: item.isYou}" v-if="item.type == 1">
            <!--如果是图片-->
            <img :src="item.content" alt="图片" onclick="viewPicture(this.getAttribute('src'))">
        </div>

    </div>

</div>

<div class="placeholder"></div>
<div id="bottom"></div>

<div class="inputbox">
    <img class="inputleft_img" src="<%=request.getContextPath()%>/resources/customer/assets/images/personal_center/sound_button.png" onclick="switchToVoice()">
    <textarea type="text"></textarea>
    <img class="inputright_img" src="<%=request.getContextPath()%>/resources/customer/assets/images/personal_center/picture.png" onclick="sendPicture()">
    <img class="inputright_img" src="<%=request.getContextPath()%>/resources/customer/assets/images/personal_center/send.png" onclick="sendMessage()">
</div>

<div id="record_bar" class="inputbox" style="display: none;">
    <img class="inputleft_img" src="<%=request.getContextPath()%>/resources/customer/assets/images/personal_center/keyboard_button.png"
         onclick="switchToType()">
    <div class="record_button">长按此处录音</div>
</div>

<div class="voicenotice" id="voicenotice0" hidden>
    <div style="height: 5rem;line-height: 5rem;">正在录音</div>
    <div style="font-size: 1rem;">手指上划，取消发送</div>
</div>

<div class="voicenotice" id="voicenotice1" hidden>
    <div style="height: 5rem;line-height: 5rem;">即将取消</div>
    <div style="font-size: 1rem;">手指下滑，恢复发送</div>
</div>

<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/jweixin-1.0.0.js"></script>
<script type="text/javascript">
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
		                    ,'downloadVoice','chooseImage','uploadImage','onVoicePlayEnd',
		                    'onVoiceRecordEnd'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
		    });
		    wx.ready(function(){
		        // config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
		    	
		        
		    });
		}
	}); // end ajax   
	
    window.onload = function () {
        window.location.href = "#bottom";
    }

    var recordBar = document.getElementById("record_bar");
    var record_button = document.getElementsByClassName("record_button")[0];
    var textInput = document.getElementsByTagName("textarea")[0];
    var voiceNotice0 = document.getElementById("voicenotice0");
    var voiceNotice1 = document.getElementById("voicenotice1");

    var chat = new Vue({
        el: "#chat",
        data: {
            thisImg: "${toUser.userProtraitPic}",
            thatImg: "${fromUser.userProtraitPic}",
            chatContents: [
                /*
                * 每条内容对象的属性：
                * isYou: true -> 是本人发的, false -> 是对方发的
                * type: 0 -> words, 2 -> audio, 1 -> picture
                * content: 内容或资源地址
                * time: 距离1970年1月1日的时间
                * */
                
            ]
        },
        methods: {
            getTime: function (time) {
                var date = new Date(time);
                return date.getFullYear() + "年" + (date.getMonth() + 1) + "月" + date.getDate() + "日 " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
            }
        }
    });
	
    function playAudio(src,obj) {
        /*使用微信接口播放音频*/
        if(obj.getAttribute("data-needDown")){
        	playVoice1(src,obj);
        }else{
        	playVoice(src,obj);
        }
        if(obj.getAttribute("src").indexOf("png")<0){
        	obj.setAttribute("src",obj.getAttribute("src").replace("gif","png"));
        }else{
        	obj.setAttribute("src",obj.getAttribute("src").replace("png","gif"));
        }
    }

    function viewPicture(src) {
        /*使用微信接口全屏查看图片*/
        /* 
        wx.previewImage({
            current: src, // 当前显示图片的http链接
            urls: [src] // 需要预览的图片http链接列表
        }); */
        WeixinJSBridge.invoke("imagePreview",{
           "urls":[
          		src
           	],
           "current":src
        })
    }

    function sendPicture() {
        /*选择图片发送*/
    	chooseImg();
    }

    function sendMessage() {
        /*发送内容*/
        if (textInput.value != "") {
        	addText(textInput.value);
            
        }
    }

    function switchToVoice() {
        recordBar.style.display = "flex";
    }

    function switchToType() {
        recordBar.style.display = "none";
    }

    var beginY;

    record_button.addEventListener("touchstart", function (event) {
        event.preventDefault();
        /*此处开始录音*/
		startRecord();
        
        beginY = event.touches[0].clientY;

        record_button.style.backgroundColor = "gray";
        record_button.style.color = "white";
        record_button.innerText = "正在录音";
        voiceNotice0.hidden = false;
    });

    record_button.addEventListener("touchmove", function (event) {
        if (beginY - event.touches[0].clientY > 100) {
            voiceNotice0.hidden = true;
            voiceNotice1.hidden = false;
        } else {
            voiceNotice0.hidden = false;
            voiceNotice1.hidden = true;
        }
    });

    record_button.addEventListener("touchend", function (event) {
        /*此处停止录音*/

        if (beginY - event.changedTouches[0].clientY > 100) {
            console.log("取消录音");
            doNotRecord();
        } else {
            console.log("发送录音");
            stopRecord();
            /*此处发送录音*/
        }
        record_button.style.backgroundColor = "white";
        record_button.style.color = "dimgray";
        record_button.innerText = "长按此处录音";
        voiceNotice0.hidden = true;
        voiceNotice1.hidden = true
    });

	
    initWebSocket();
    //初始话WebSocket  
     function initWebSocket() {  
         if (window.WebSocket) {  
             websocket = new WebSocket(encodeURI('ws://pinhao.zhuanlitou.com/message'));  
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
	                 chat.chatContents.push({
						isYou:message1.fromUserId!=toUserId,
						type:message1.infoType,
						content:message1.infoType==2?(message1.mediaId==null?message1.informationId:message1.mediaId):message1.infoContent
						,//如果是语音消息，传mediaId,因为语音消息三天过去，就要更具informationId重新下载了
						time:message1.sendTime,
						needDownload:message1.mediaId==null
					});
	                setReaded(message1.informationId);
	                setTimeout(function(){
		                window.location.href = "#bottom";
	                },10);
                 }
             }
         }  
     };  
     
     $(window).scroll(function(){
    	  if ($(window).scrollTop()<=0){
    		  if(canLoad&&!noDate){
    			  canLoad=false;
	    		  userInformationList();
    		  }
          }
     })
     
    var offset=0;
	var webSocketNum=0;
	var toUserId=${fromUser.userId};
	userInformationList();
	var canLoad=true;
	var noDate=false;
	function userInformationList(){
		var url="<%=request.getContextPath()%>/information/userInformationAjax"; 
		console.log(offset+webSocketNum)
		var params={fromUserId:toUserId,offset:(offset+webSocketNum)};
		doAjax("GET",url,params,getUInformationSuccess,fail,true,false);
	}
	 
	function getUInformationSuccess(data){
		var list = data.data.list;
		var html="";
		var result="";
		$(".talkblock").eq(0).addClass("last");
		var showTimeIndex=list.length-1;
		for(var i=0;i<list.length;i++){
			chat.chatContents.unshift({
				isYou:list[i].fromUserId!=toUserId,
				type:list[i].infoType,
				content:list[i].infoType==2?(list[i].mediaId==null?list[i].informationId:list[i].mediaId):list[i].infoContent
				,//如果是语音消息，传mediaId,因为语音消息三天过去，就要更具informationId重新下载了
				time:list[i].sendTime,
				needDownload:list[i].mediaId==null
			});
		}	
		setTimeout(function(){
			if($(".talkblock").eq(list.length).offset()){	
				window.scrollTo(0,$(".talkblock").eq(list.length).offset().top);
			}
		},10);
		
		if(offset==0){
			setTimeout(function(){
				window.scrollTo(0,$("#bottom").offset().top);
			},10);
		}
		canLoad=true;
		if((parseInt(offset+webSocketNum)+10)>=data.data.count+webSocketNum){
			noDate=true;
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
      
	function addText(text){   //发送文本消息
		var url = "<%=request.getContextPath()%>/information/addText";
		var params={content:text,toUserId:toUserId};
		chat.chatContents.push({isYou: true, type: 0, content: textInput.value, time: new Date().getTime()});
        textInput.value = "";
		doAjax("GET",url,params,function(data){
            window.location.href = "#bottom";
		},fail,true,false);
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
		chat.chatContents.push({isYou: true, type: 1, 
			content: changePath(data.data.infoContent), time: data.data.sendTime});
        window.location.href = "#bottom";
	}
	
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
	
	function addVoice(mediaId){
		var url="<%=request.getContextPath()%>/information/addVoice";
		var params={mediaId:mediaId,toUserId:toUserId};
		doAjax("GET",url,params,addVoiceSuccess,fail,true,false);
	}
	
	function addVoiceSuccess(data){
		chat.chatContents.push({isYou: true, type: 2, 
			content: data.data.mediaId, time: data.data.sendTime,
			needDownload:data.data.mediaId==null});
        window.location.href = "#bottom";
	}
	
	var voiceId="";
	function playVoice(mediaId,obj){
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
	                	obj.setAttribute("src",obj.getAttribute("src").replace("gif","png"));
	        	    }
	        	});
		    }
		});
	}
	
	function playVoice1(informationId,obj){
		var url="<%=request.getContextPath()%>/information/playVoice";
		var params={informationId:informationId};
		doAjax("GET",url,params,function(data){
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
		        	        obj.setAttribute("src",obj.getAttribute("src").replace("gif","png"));
		        	    }
		        	});
			    }
			});
		},fail,true,false);
	}
	
	
	 function setReaded(informationId){   //设置信息为已读状态
    	 var url="<%=request.getContextPath()%>/information/setReaded";
    	 var params={informationId:informationId};
    	 doAjax("GET",url,params,setReadedSuccess,fail,true,false);
     }
     
     function setReadedSuccess(data){
    	 
     }
     
     function changePath(path){
 		var i=path.lastIndexOf("/");
 		return path.substring(0,i+1)+"thumbnailImage/"+path.substring(i+1);
 	}
</script>

</body>
</html>