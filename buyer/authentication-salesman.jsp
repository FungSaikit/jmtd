<%@ page language="java" import="java.util.*,com.alphaking.constant.*,com.alphaking.model.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>佐为照明</title>
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/customer/assets/css/personCenter.css?11ccc1" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
</head>
<body>
<c:set var="UNAUTHORIZED" value="<%=UserCheckStatus.UNAUTHORIZED%>" />
<c:set var="AUTHORIZING" value="<%=UserCheckStatus.AUTHORIZING%>" />
<c:set var="AUTHENTICATION_FAILURE" value="<%=UserCheckStatus.AUTHENTICATION_FAILURE%>" />
<c:set var="AUTHENTICATION_SUCCESS" value="<%=UserCheckStatus.AUTHENTICATION_SUCCESS%>" />
<c:set var="AGENCY" value="<%=UserType.AGENCY%>" />
<c:set var="FACILITATOR" value="<%=UserType.FACILITATOR%>" />
<div class="distributor">
    <div class="title">认证申请</div>
	
	<c:if test="${application.checkStatus==AUTHENTICATION_SUCCESS||application.isUpdate==1}">
	<div class="qrCodeContent" id="qrCode">
        <img src="${newQrCode }" alt="" style="width:100%"/>
    </div>
    <div class="changeInfoForm" id="updateBtn">
        <input type="submit" class="changeInfoBtn" value="修改认证信息" onclick="updateInfo()"/>
    </div>
    </c:if>
	
    <form class="form" <c:choose><c:when test="${application.checkStatus==AUTHENTICATION_SUCCESS||application.isUpdate==1 }">action="<%=request.getContextPath()%>/salesman/updateAuthentication"</c:when><c:otherwise>action="<%=request.getContextPath()%>/salesman/authentication"</c:otherwise></c:choose> <c:if test="${application.checkStatus==AUTHENTICATION_SUCCESS||application.isUpdate==1 }">style="display:none"</c:if> onsubmit="return checkForm();">
        <div class="form-group">
            <label>联系人</label>
            <input type="text" id="organization" name="legalPerson"  class="form-control" autofocus <c:if test="${!empty application }">value="${application.legalPerson}"</c:if>/>
        </div>
        <div class="form-group">
            <label>注册手机号</label>
            <input type="text" id="organization" name="contact" class="form-control" <c:if test="${!empty application }">value="${application.contact}"</c:if>/>
        </div>
        
          <div class="imgDiv">
             <div class="imgContent notEmpty">
                <input type="hidden" class="imgUrl" value="${application.lpHandheldIdcardPic}" name="lpHandheldIdcardPic"/>
                <img class="smallImg" src="#" data-src="<c:if test='${!empty application }'>${application.lpHandheldIdcardPic}</c:if>" alt="" <c:if test='${empty application||empty application.lpHandheldIdcardPic }'>style="display: none;"</c:if>/>
                <span class="add" <c:if test='${!empty application &&!empty application.lpHandheldIdcardPic}'>style="display: none;"</c:if>><i class="iconfont">&#xe628;</i></span>
                <span class="cancel" <c:if test='${!(application.checkStatus==AUTHENTICATION_SUCCESS&&!empty application.lpHandheldIdcardPic||application.isUpdate==1)}'>style="display: none;"</c:if>><i class="iconfont">&#xe632;</i></span>
            </div>
            <div class="imgTitle">业务员手持身份证</div>
         </div>
        <div class="imgDiv">
            <div class="imgContent notEmpty">
                <input type="hidden" class="imgUrl" value="${application.lpIdcardFrontPic}" name="lpIdcardFrontPic"/>
                <img class="smallImg" src="#" data-src="<c:if test='${!empty application }'>${application.lpIdcardFrontPic}</c:if>" alt="" <c:if test='${empty application||empty application.lpIdcardFrontPic }'>style="display: none;"</c:if>/>
                <span class="add" <c:if test='${!empty application&&!empty application.lpIdcardFrontPic }'>style="display: none;"</c:if>><i class="iconfont">&#xe628;</i></span>
                <span class="cancel" <c:if test='${!(application.checkStatus==AUTHENTICATION_SUCCESS&&!empty application.lpIdcardFrontPic||application.isUpdate==1)}'>style="display: none;"</c:if>><i class="iconfont">&#xe632;</i></span>
            </div>
            <div class="imgTitle">业务员身份证正面</div>
        </div>
        <div class="imgDiv">
            <div class="imgContent notEmpty">
                <input type="hidden" class="imgUrl" value="${application.lpIdcardBackPic}" name="lpIdcardBackPic"/>
                <img class="smallImg" src="#" data-src="<c:if test='${!empty application }'>${application.lpIdcardBackPic}</c:if>" alt="" <c:if test='${empty application ||empty application.lpIdcardBackPic}'>style="display: none;"</c:if>/>
                <span class="add" <c:if test='${!empty application &&!empty application.lpIdcardBackPic}'>style="display: none;"</c:if>><i class="iconfont">&#xe628;</i></span>
                <span class="cancel" <c:if test='${!(application.checkStatus==AUTHENTICATION_SUCCESS&&!empty application.lpIdcardBackPic||application.isUpdate==1)}'>style="display: none;"</c:if>><i class="iconfont">&#xe632;</i></span>
            </div>
            <div class="imgTitle">业务员身份证反面</div>
        </div>
        <div class="imgDiv">
            <div class="imgContent notEmpty">
                <input type="hidden" class="imgUrl" value="${application.salesmanWorkCertify}" name="salesmanWorkCertify"/>
                <img class="smallImg" src="#" data-src="<c:if test='${!empty application }'>${application.salesmanWorkCertify}</c:if>" alt="" <c:if test='${empty application||empty application.salesmanWorkCertify }'>style="display: none;"</c:if>/>
                <span class="add" <c:if test='${!empty application&&!empty application.salesmanWorkCertify }'>style="display: none;"</c:if>><i class="iconfont">&#xe628;</i></span>
                <span class="cancel" <c:if test='${!(application.checkStatus==AUTHENTICATION_SUCCESS&&!empty application.salesmanWorkCertify||application.isUpdate==1)}'>style="display: none;"</c:if>><i class="iconfont">&#xe632;</i></span>
            </div>
            <div class="imgTitle">业务员证明</div>
        </div>
		
		<c:if test="${empty application||application.checkStatus==AUTHENTICATION_SUCCESS||application.isUpdate==1 }">
        <input type="submit" class="submit" value="提　交"/>
        </c:if>
    </form>
</div>

<div class="tip"></div>
<div class="bigImgDiv">
	<img class="bigImg" src=""/>
</div>
<jsp:include page="/jsp/buyer/footer.jsp"></jsp:include>
<script>

	
	function fail(){
		alert("fail");
	}
	
	$(function(){
		
	})

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
		$(".form-control").each(function(){
			if($(this).val().trim()==""){
				showTip($(this).parents(".form-group").find("label").html()+"不能为空");
				flag=false;
				return false;
			}
		});
		if(flag){
			$(".notEmpty").each(function(){
				if($(this).find(".imgUrl").val().trim()==""){
						showTip($(this).parent().find(".imgTitle").html()+"不能为空");
						flag=false;
						return false;
				}
			});
		}
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
