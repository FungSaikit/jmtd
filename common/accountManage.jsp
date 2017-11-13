<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>佐为照明</title>
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1"/>
   	<meta name="format-detection" content="telephone=no" />
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/customer/assets/css/personCenter.css?12"/>
</head>
<body>
	<div class="accountManage">
		<div class="title"><i class="iconfont prevPage" >&#xe63f;</i>个人设置</div>
		<div class="infoDiv imgDiv" data-id="userProtraitPic">
			<label class="infoTitle"><span class="icon"><!-- <i class="iconfont">&#xe620;</i> --></span>会员头像</label>
			<span class="iconSpan"><i class="iconfont">&#xe624;</i></span>
			<img src="${user.userProtraitPic}" class="smallImg"/>
			<span class="addImg"><i class="iconfont">&#xe628;</i></span>
		</div>
		<div class="infoDiv" data-id="userNickname">
			<label class="infoTitle"><span class="icon"><!-- <i class="iconfont">&#xe621;</i> --></span>会员昵称</label>
			<span class="iconSpan"><i class="iconfont">&#xe624;</i></span>
			<span class="info">${user.userNickname }</span>
		</div>
		<div style="height:.15rem;width:100%;"></div>
		<div class="infoDiv" data-id="legalPersonName">
			<label class="infoTitle"><span class="icon"><!-- <i class="iconfont">&#xe600;</i> --></span>会员名</label>
			<span class="iconSpan"><i class="iconfont">&#xe624;</i></span>
			<span class="info">${user.legalPersonName}</span>
		</div>
		<div class="infoDiv">
			<label class="infoTitle"><span class="icon"><!-- <i class="iconfont">&#xe60f;</i> --></span>联系电话</label>
			<span class="iconSpan"><i class="iconfont">&#xe624;</i></span>
			<span class="info">${user.phoneNumber}</span>
		</div>
		<div class="infoDiv" data-id="qqNumber">
			<label class="infoTitle"><span class="icon"><!-- <i class="iconfont">&#xe607;</i> --></span>QQ号</label>
			<span class="iconSpan"><i class="iconfont">&#xe624;</i></span>
			<span class="info">${user.qqNumber}</span>
		</div>
		<div class="infoDiv" data-id="wechatNumber">
			<label class="infoTitle"><span class="icon"><!-- <i class="iconfont">&#xe60e;</i> --></span>微信号</label>
			<span class="iconSpan"><i class="iconfont">&#xe624;</i></span>
			<span class="info">${user.wechatNumber}</span>
		</div>
		<%-- <div class="infoDiv imgDiv" data-id="qrCodePic">
			<label class="infoTitle"><span class="icon"><!-- <i class="iconfont">&#xe65d;</i> --></span>微信二维码</label>
			<span class="iconSpan"><i class="iconfont">&#xe624;</i></span>
			<img src="${user.qrCodePic}" class="smallImg" <c:if test="${empty user.qrCodePic}">style="display:none"</c:if>/>
			<span class="addImg" <c:if test="${empty user.qrCodePic}">style="display:block"</c:if>><i class="iconfont">&#xe628;</i></span>
		</div>
		<div class="infoDiv" data-id="email">
			<label class="infoTitle"><span class="icon"><i class="iconfont">&#xe60c;</i></span>邮箱</label>
			<span class="iconSpan"><i class="iconfont">&#xe624;</i></span>
			<span class="info">${user.email}</span>
		</div>
		<c:if test="${user.role==4||user.role==6 }">
		<!-- 经销商才有这个地址设置功能 -->
		<div class="infoDiv address" >
			<label class="infoTitle"><span class="icon"><i class="iconfont">&#xe639;</i></span>设置地址</label>
			<span class="iconSpan"><i class="iconfont">&#xe624;</i></span>
		</div>
		</c:if> --%>
	</div>
	<!-- 图像编辑框 -->
	
	<!-- 文本编辑框 -->
	<div class="changeDiv">
		<div class="changeTop">
			<span>修改<span class="changeTitle"></span></span>
			<span id="closeChangeDiv"><i class="iconfont">&#xe632;</i></span>
		</div>
		<div class="changeInfo">
			<input id="changeValue" autofocus type="text" value=""/>
		</div>
		<div class="changeBottom">
			<span id="cancel">取消</span>
			<span id="change">保存</span>
		</div>
	</div>
	<!-- 查看大图 -->
	<div class="bigImgDiv">
		<img class="bigImg" src=""/>
	</div>
	<form id="userForm">
		 <input type="hidden" value="${user.userProtraitPic }" name="userProtraitPic">
		 <input type="hidden" value="${user.userNickname }" name="userNickname" />
		 <input type="hidden" value="${user.legalPersonName}" name="legalPersonName"/>
		 <input type="hidden" value="${user.contact}" name="contact" />
		 <input type="hidden" value="${user.qqNumber}" name="qqNumber" />
		 <input type="hidden" value="${user.wechatNumber}" name="wechatNumber" />
         <input type="hidden" value="${user.qrCodePic}" name="qrCodePic">
         <input type="hidden" value="${user.email}" name="email">
	</form>
	<c:if test="${user.role!=1 || user.checkStatus!=3}">
		<jsp:include page="/jsp/buyer/footer.jsp"></jsp:include>
	</c:if>
	<c:if test="${user.role==1&&user.checkStatus==3 }">
		<jsp:include page="/jsp/factory/footer.jsp"></jsp:include>		
	</c:if>
</body>
<script>
    var data_id;
	//开始修改信息
	$(".infoDiv:not(.imgDiv):not(.address)").tap(function(){
		$(".changeTitle").html($(this).find(".infoTitle").html().split("</span>")[1]);console.log($(this).find(".info").html())
		$("#changeValue").val($(this).find(".info").text());
		$(".changeDiv").show();
		$(".shade").show();
		data_id=$(this).attr("data-id");
	});
	
	$(".address").tap(function(){
		window.location.href="<%=request.getContextPath()%>/buyer/toSetLocation";
	});
	
	$("#closeChangeDiv,#cancel,.shade").on("tap",function(){
		$(".shade").hide();
		$(".changeDiv").hide();
		$(".bigImgDiv").hide();
		
	});
	$("#change").tap(function(){
		//ajax修改信息,success函数中用下面两句代码
		$("input[name='"+data_id+"']").val($("#changeValue").val());
		$(".infoDiv[data-id='"+data_id+"'] .info").html($("#changeValue").val());
		updateAccount();
		$(".changeDiv").hide();
		$(".shade").hide();
	});
	$(".smallImg").tap(function(){
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
	$(".imgDiv").tap(function(e){
		if($(this).find("img").attr("src")!=null){
			if(!$(e.target).closest(".smallImg").length!=0){
				chooseImg(this);
			}
		}else{
			chooseImg(this);
		}
	});
	
	function updateAccount(){
		var url="<%=request.getContextPath()%>/user/updateAccountInfo";
		var params=$("#userForm").serialize();
		doAjax("GET",url,params,updateSuccess,fail,true,false);
	}
	
	function updateSuccess(data){
		$("input[name='userProtraitPic']").val(data.data[0]);
		$("input[name='qrCodePic']").val(data.data[1]);
	}
	
	function fail(){
		alert("fail");
	}
	
	function chooseImg(obj) {
		$(".waiting").show();
		$(".shade").show();
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
			    			$(obj).find("img").show();
			    			$(obj).find(".addImg").hide();
//			    			$(".shCodepic_box").toggle(); 
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
				//$("input[name='qrCodePic']").val(res.serverId);
	   		 	$("input[name='"+$(obj).attr("data-id")+"']").val(res.serverId);
	   		 	updateAccount();
	   		 },
	  		 fail: function(res) {      			
	  		 
	  		 }
	   	});
	}

	$(".prevPage").tap(function(){
		window.location.href="<%=request.getContextPath()%>/buyer/personCenter";
	})
</script>
</html>
