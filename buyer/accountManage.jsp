<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>佐为照明</title>
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1"/>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/customer/assets/css/personCenter.css"/>
</head>
<body class="personCenter">
    <div class="title"><i class="iconfont prevPage" >&#xe63f;</i>账号管理</div>
<form action="<%=request.getContextPath() %>/buyer/updateAccountInfo">
<!--[[个人中心--会员-->
<div class="person-member">
    <div class="clearfix">
        <a href="javascript:void()">
            <div class="pull-left"><!-- <i class="icon iconfont yellow">&#xe61f; </i> -->头像</div>
            <div class="pull-right img">
                <img src="${user.userProtraitPic }" alt=""/>
            </div>
        </a>
    </div>
    <div class="clearfix line">
        <a href="#">
            <div class="pull-left"><!-- <i class="icon iconfont pink">&#xe621; </i> -->昵称</div>
            <div class="pull-right">${user.userNickname }</div>
        </a>
    </div>
    <div class="clearfix">
        <a href="#">
            <div class="pull-left"><i class="icon iconfont green">&#xe600; </i>联系人</div>
            <div class="pull-right"><input type="text" value="${user.legalPersonName}" name="legalPersonName"/></div>
        </a>
    </div>
    <div class="clearfix">
        <a href="#">
            <div class="pull-left"><i class="icon iconfont green">&#xe612; </i>联系电话</div>
            <div class="pull-right"><input type="text" value="${user.phoneNumber}" name="phoneNumber"/></div>
        </a>
    </div>
    <div class="clearfix">
        <a href="#">
            <div class="pull-left"><i class="icon iconfont green">&#xe609; </i>固定电话</div>
            <div class="pull-right"><input type="text" value="${user.contact}" name="contact"/></div>
        </a>
    </div>
    <div class="clearfix">
        <a href="#">
            <div class="pull-left"><i class="icon iconfont green">&#xe607; </i>qq号</div>
            <div class="pull-right"><input type="text" value="${user.qqNumber}" name="qqNumber"/></div>
        </a>
    </div>
    <div class="clearfix">
        <a href="#">
            <div class="pull-left"><i class="icon iconfont green">&#xe60e; </i>微信</div>
            <div class="pull-right"><input type="text" value="${user.wechatNumber}" name="wechatNumber"/></div>
        </a>
    </div>
    <div class="clearfix wechat_code">
        <a >
            <div class="pull-left mycode"><i class="icon iconfont icon-erweima green"> </i>微信二维码</div>
             <div class="pull-right img" id="inimg">
                <img src="${user.qrCodePic}" alt="" class="qrCodePic"/>
                <input type="hidden" value="${user.qrCodePic}" name="qrCodePic">
            </div>
        </a>
    </div>
    <div class="clearfix shCodepic_box" style="display: none;">
        	<img src="${user.qrCodePic}"  style="margin: 0 auto;  width: 100%;" class="qrCodePic shCodepic" />  	
    </div>
    <div class="clearfix">
        <a href="#">
            <div class="pull-left"><i class="icon iconfont green">&#xe60c; </i>邮箱</div>
            <div class="pull-right"><input type="text" value="${user.email}" name="email"/></div>
        </a>
    </div>
    
    <input type="submit" class="btn btn-info submit_btn" value="保　存"/>
</div>

    </form>
<!--个人中心--会员]]-->

<!--[[通用尾部-->
<jsp:include page="/jsp/buyer/footer.jsp"></jsp:include>
<!--通用尾部]]-->
<!-- [[通用遮罩层-->
<div class="shadow" style="display: none"></div>
<!-- 通用遮罩层]]-->
</body>
<script>
	
	$(".qrCodePic").tap(function(){
		chooseImg(this);
	})
	
	$("#inimg").tap(function(){
//		chooseImg(this);
		chooseImg($("#inimg img").eq(0));
	})
	
	$(".mycode").tap(function(){
		$(".shCodepic_box").toggle(); 
//		if($(".shCodepic_box").eq(0).css("display")=="block" && $(".shCodepic").eq(0).attr("src")!=$(".qrCodePic").eq(0).attr("src")){
//			$(".shCodepic").eq(0).attr("src",$(".qrCodePic").eq(0).attr("src"))
//		}
//		
	})
	
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
			    	$("#load_shade").hide();
			        // config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行
					//。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
			    	wx.chooseImage({
			    	    count: 1, // 默认9
			    	    sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
			    	    sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
			    	    success: function (res) {
			    	        localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
			    	        chooseUpload(obj,localIds[0]);
	
			    			$(obj).attr("src",localIds);
			    			$(".shCodepic").eq(0).attr("src",localIds);
			    			$(".shCodepic_box").toggle(); 
			    	    }
			    	});
			    });
			}
		}); // end ajax
	}
	
	function chooseUpload(obj,localIds){
		wx.uploadImage({
	   		 localId: localIds, // 需要上传的图片的本地ID，由chooseImage接口获得
	   		 isShowProgressTips: 1, // 默认为1，显示进度提示
	   		 success: function(res) {
	   		 	//返回图片的服务器端ID res.serverId,然后调用wxImgCallback函数进行下载图片操作
	   			$("input[name='qrCodePic']").val(res.serverId);
	   		 	
	   		 },
	  		 fail: function(res) {      			
	  		 
	  		 }
	   	});
	}
	
	function getImageWidth(obj,objUrl){
		var img = new Image();
		img.src = objUrl;
		
		// 如果图片被缓存，则直接返回缓存数据
		if(img.complete){
		    realImg(obj,objUrl,img.width, img.height);
	
		}else{
	            // 完全加载完毕的事件
		    img.onload = function(){
			 realImg(obj,objUrl,img.width, img.height);
		    }
	       }
	}
	
	function realImg(obj,objUrl,width,height){
		var imgWidth=width;
		var imgHeight=height;
		
		if(imgHeight>imgWidth){
			obj.css("width","150px");
			var realHeight=parseFloat(imgHeight)*150/parseFloat(imgWidth);
			var clipless=(realHeight-150)/2;
			var clipmore=clipless+150;
			obj.css("height",realHeight+"px");
			obj.attr("src",objUrl);
			obj.css("clip","rect("+clipless+"px 150px "+clipmore+"px 0px)");
			obj.css("top","-"+clipless+"px");
			obj.css("left","0px");
		}
		else{
			obj.css("height","150px");
			var realWidth=parseFloat(imgWidth)*150/parseFloat(imgHeight);
			var clipless=(realWidth-150)/2;
			var clipmore=clipless+150;
			obj.css("width",realWidth+"px");
			obj.attr("src",objUrl);
			obj.css("clip","rect(0px "+clipmore+"px 150px "+clipless+"px)");
			obj.css("top","0px");
			obj.css("left","-"+clipless+"px");
		}
		obj.siblings(".closeStyle").css("display", "inline-block");
		_warn_img.hide();
	}
	$(".prevPage").tap(function(){
		window.location.href="<%=request.getContextPath()%>/buyer/personCenter";
	})
</script>
</html>