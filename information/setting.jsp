<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">

		<title>设置</title>
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/common/swiper.min.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/customer/font/iconfont.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/customer/assets/css/chat.css">
	</head>
	<body>
		<div class="swiper-container">
		  <div class="swiper-wrapper">
		    <div class="swiper-slide swiper-no-swiping">
				<div class="info">
					<ul>
						<li class="editPhone">
							<a href="javascript:void(0);">
								<p>手机号码</p>
								<div><c:if test="${empty user.informationPhone }"><i class="iconfont icon-shoujihaoma"></i></c:if>
								<c:if test="${!empty user.informationPhone }">${user.informationPhone }</c:if></div>
							</a>
						</li>
						<li class="qrcodeLi <c:if test="${!empty user.qrCodePic }">qrcode</c:if>"><!--上传了图片之后添加qrcode这个类-->
							<a href="javascript:void(0);">
								<p>微信二维码</p>
								<div><c:if test="${empty user.qrCodePic }"><i class="iconfont icon-tupian1"></i></c:if><c:if test="${!empty user.qrCodePic }"><img src="${user.qrCodePic }" alt=""></c:if></div>
							</a>
						</li><!-- 
						<li class="address">
							<a href="javascript:void(0);">
								<p>店铺地址</p>
								<div><i class="iconfont icon-dizhi"></i></div>
							</a>
						</li>
					</ul>
					<p class="addMore"><i class="iconfont icon-tianjia"></i><span>添加分店地址</span></p> -->
				</div>
		    </div>
		    <div class="swiper-slide swiper-no-swiping phoneSlide">
				<div class="backSlider">
					<div id="perv"><i class="iconfont icon-fanhuiicon"></i></div>
					<div class="submit"><button>保存</button></div>
				</div>
			    <div class="phoneNum">
					<form action="<%=request.getContextPath()%>/information/setInformationPhone">
						<div><input id="tel" type="tel" placeholder="请输入手机号码" name="informationPhone"></div>
					</form>
			    </div>
				<div class="formAdd">
					<div><input type="text" placeholder="请输入分店名称"></div>
					<div><input type="text" placeholder="请输入电话号码"></div>
					<div>
						<select name="" id="">
							<option value="">--请选择省--</option>
						</select>
					</div>
					<div>
						<select name="" id="">
							<option value="">--请选择市--</option>
						</select>
					</div>
					<div>
						<select name="" id="">
							<option value="">--请选择区/县--</option>
						</select>
					</div>
					<div><input type="text" placeholder="请输入详细地址"></div>
				</div>
		    </div>
		  </div>
		</div>
		
		<jsp:include page="/jsp/information/chatFooter.jsp"></jsp:include>
		<script>
			window.onload=function(){
				var mySwiper = new Swiper('.swiper-container');

				$(".editPhone").tap(function(){
					mySwiper.slideNext();
					$(".footer").hide();
					$(".backSlider").show();
					$(".phoneNum").show();
					$(".formAdd").hide();
				});

				$("#perv").tap(function(){
					mySwiper.slidePrev();
					$(".footer").show();
					$(".backSlider").hide();
				});

				$(".submit").tap(function(){
					mySwiper.slidePrev();
					$(".footer").show();
					$(".backSlider").hide();
					if($(".phoneNum").css("display")=="block")
						$("form").submit();
				});

				$(".address").tap(function(){
					mySwiper.slideNext();
					$(".footer").hide();
					$(".backSlider").show();
					$(".phoneNum").hide();
					$(".formAdd").show();
				});

				$(".addMore").tap(function(){
					mySwiper.slideNext();
					$(".footer").hide();
					$(".backSlider").show();
					$(".phoneNum").hide();
					$(".formAdd").show();
				});
			}
			
			$(".qrcodeLi").tap(function(e){
				if($(this).find("img").attr("src")!=null){
					if(!$(e.target).closest(".smallImg").length!=0){
						chooseImg(this);
					}
				}else{
					chooseImg(this);
				}
			});
			
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
			   		 	updatePicture(res.serverId);
			   		 },
			  		 fail: function(res) {      			
			  		 
			  		 }
			   	});
			}
			
			function updatePicture(serverId){
				var url="<%=request.getContextPath()%>/user/setQrCodePic";
				var params = {serverId:serverId};
				doAjax("GET",url,params,updateSuccess,fail,true,false);
			}
			
			function updateSuccess(data){
				location.reload();
			}
			
			function fail(data){
				console.log("fail");
			}
		</script>
	</body>
</html>