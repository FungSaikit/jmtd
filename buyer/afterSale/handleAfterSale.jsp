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
</head>
<body>
<div class="distributor">
	<div class="title">处理售后</div>
    <form class="form" action="<%=request.getContextPath()%>/buyer/handleAfterSale" onsubmit="return checkForm();">
    	<input type="hidden" name="afterSaleId" value="${afterSaleId }"/>
        <div class="form-group">
            <label>解决方式</label>
            <input type="text" id="organization" name="afterSaleHandleDescription" class="form-control"/>
        </div>
        <div class="form-group">
            <label>花费金额</label>
            <input type="text" id="organization" name="afterSaleMoney" class="form-control"/>
        </div>
        <div class="form-group">
            <label>建议打木架</label>
            <input type="checkbox" id="organization" name="suggestWooden" class="form-control radio"/>
        </div>
        
        
         <div class="imgDiv">
             <div class="imgContent">
                <input type="hidden" class="imgUrl" value="" name="fileStr"/>
                <img class="smallImg" src="#" data-src="" alt="" style="display: none;"/>
                <span class="add" ><i class="iconfont">&#xe628;</i></span>
                <span class="cancel" style="display: none;"><i class="iconfont">&#xe632;</i></span>
            </div>
             <div class="imgTitle">说明图片</div>
         </div><!-- 
          <div class="imgDiv">
             <div class="imgContent">
                <input type="hidden" class="imgUrl" value="" name="fileStr"/>
                <img class="smallImg" src="#" data-src="" alt="" style="display: none;"/>
                <span class="add" ><i class="iconfont">&#xe628;</i></span>
                <span class="cancel" style="display: none;"><i class="iconfont">&#xe632;</i></span>
            </div>
             <div class="imgTitle">说明图片</div>
         </div>
        <div class="imgDiv">
            <div class="imgContent notEmpty">
                <input type="hidden" class="imgUrl" value="" name="fileStr"/>
                <img class="smallImg" src="#" data-src="" alt="" style="display: none;"/>
                <span class="add"><i class="iconfont">&#xe628;</i></span>
                <span class="cancel" style="display: none;"><i class="iconfont">&#xe632;</i></span>
            </div>
             <div class="imgTitle">说明图片</div>
        </div> -->
		
        <input type="submit" class="submit" value="提　交"/>
    </form>
</div>
<div class="tip"></div>
<div class="bigImgDiv">
	<img class="bigImg" src=""/>
</div>
<!-- 查看大图 -->
<jsp:include page="/jsp/buyer/footer.jsp"></jsp:include>
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


	function queryCity(addressId){
		var url="<%=request.getContextPath()%>/address/queryAddress";
		var params={upAddressId:addressId};
		doAjax("GET",url,params,queryCitySuccess,fail,false,false);
	}
	
	function queryCitySuccess(data){
		var option="";
		for(var i=0;i<data.length;i++){
			option+="<option value='"+data[i].addressId+"'>"+data[i].addressName+"</option>";
		}
		$("#city").html(option);
		queryArea(data[0].addressId);
	}
	
	function queryArea(addressId){
		var url="<%=request.getContextPath()%>/address/queryAddress";
		var params={upAddressId:addressId};
		doAjax("GET",url,params,queryAreaSuccess,fail,false,false);
	}
	
	function queryAreaSuccess(data){
		var option="";
		for(var i=0;i<data.length;i++){
			option+="<option value='"+data[i].addressId+"'>"+data[i].addressName+"</option>";
		}
		$("#area").html(option);
	}
	
	function fail(){
		alert("fail");
	}
	
	$(function(){
		queryCity(${application.provinceId});
		queryArea(${application.cityId});
		$("#province").val(${application.provinceId});
		$("#city").val(${application.cityId});
		$("#area").val(${application.areaId});
	})

	$(".add").tap(function(){
		$(".waiting").show();
		$(".shade").show();
		chooseImg($(this).parents(".imgContent")[0]);
	});
	
	function chooseImg(obj) {
		var urlStr = "<%=request.getContextPath()%>/wechat/signature?url="+url;
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
	
	function updateInfo(){
		$("#qrCode").hide();
		$("#updateBtn").hide();
		$(".form").show();
		$(".smallImg").each(function(){
			if($(this).attr("data-src")!=""){
				var img = new Image();
				img.src=$(this).attr("data-src");
				if(img.complete){
					console.log(123);
					changeImgDisplay(img,$(this));
				}else{
					var $that=$(this);
					img.onload=function(){
						changeImgDisplay(img,$that);
					}
				}
			}
		});
	}
	
	function checkForm(){
		var flag=true;
		
		return flag;
	}
	
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
<c:if test="${!(application.checkStatus==AUTHENTICATION_SUCCESS||application.isUpdate==1) }">	
<script>
	$(".smallImg").each(function(){
	if($(this).attr("data-src")!=""){
		var img = new Image();
		img.src=$(this).attr("data-src");
		if(img.complete){
			console.log(123);
			changeImgDisplay(img,$(this));
		}else{
			var $that=$(this);
			img.onload=function(){
				changeImgDisplay(img,$that);
			}
		}
		}
	});
</script>
</c:if>
</body>
</html>
