<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${empty noZepto}">
<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
</c:if>
<script src="<%=request.getContextPath() %>/resources/common/swiper.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/jweixin-1.0.0.js"></script>
<!--[[底部-->
<style>
	.footerBtn{
		position:fixed;
		bottom:0px;
		left:0px;
		width:100%;
	}
	.footerBtn button{
		width:50%;
		border:0px;
		float:left;
		height:44px;
		font-size:.5rem
	}
	.uploadDemand{
		background-color:red;
		color:#fff;
	}
	.demandManage{
		background-color:#FFB03F;
		color:#FFF;
	}
</style><%-- 
<footer class="clearfix text-center">
  <a href="javascript:void();" data-href="<%=request.getContextPath()%>/demand/indexDemand" class="fa footerA width-2 <c:if test='${fActive==0 }'>active</c:if>">
	 <i class="icon iconfont">&#xe60a;</i>
	 <p>首页</p>
  </a>
  <a href="javascript:void();"  class="footerA width-2 <c:if test='${fActive==1 }'>active</c:if> filterA classifyA">
    <i class="icon iconfont">&#xe622;</i>
    <p>需求</p>
  </a>
  <a href="javascript:void();"  class="footerA width-2 filterProduct">
    <i class="icon iconfont">&#xe63c;</i>
    <p>订阅</p>
  </a>
  <a href="javascript:toDemandOffer()"  class="footerA width-2">
    <i class="icon iconfont">&#xe610;</i>
    <p>报价</p>
  </a>
  <a href="<%=request.getContextPath() %>/buyer/index"  class="footerA width-2">
	<i class="icon iconfont">&#xe6b5;</i>
    <p>繁灯网</p>
  </a>
</footer> --%>
<!--底部]]--><%-- 
<!-- 等待加载 -->
<div class="waiting"><i class="iconfont">&#xe62c;</i></div>
<div class="shade"></div>
<!-- 等待加载 -->
<!-- 产品订阅弹出面板 -->
<div class="subscribePanel">
	<img src="<%=request.getContextPath() %>/resources/customer/assets/images/kefu.jpg" alt="">
	<span>
		<a href="#" id="gpsA"><i class="iconfont">&#xe608;</i></a>
		<a href="#" id="phoneA"><i class="iconfont">&#xe609;</i></a>
		<a href="javascript:closeWindow();" id="phoneA"><i class="iconfont">&#xe60e;</i></a>
	</span>
</div>
<jsp:include page="/jsp/buyer/filterPanel.jsp"></jsp:include> --%>
<div class="footerBtn">
	<button class="uploadDemand">发布需求</button>
	<button class="demandManage">我</button>
</div>
<div class="shade"></div>
<!-- 开始确认框 -->
<div class="confirmDiv" id="delete">
	<div class="confirmTop">
		<span>注意</span>
		<span id="closeConfirm"><i class="iconfont">&#xe632;</i></span>
	</div>
	<p id="phoneNumber">您还没注册，无法提供报价，请选择一个身份注册(注册经销商需要联系客服人员)</p>
	<div class="confirmBottom">
		<span id="agency">经销商</span>
		<span id="factory">厂家</span>
	</div>
</div>
<!--[[底部-->
<script>
	$(".subscribePanel").on("touchend",function(){
	    $(this).off('touchstart','touchmove');    
		$("body").removeClass("body");
	}); 
	
	$(".demandManage").tap(function(){
		window.location.href="<%=request.getContextPath()%>/demand/demandManage";
	})
	
	$(".uploadDemand").tap(function(){
		if(${sessionScope.openId=="notFollow"}){
			alert("请先关注繁灯网");
		}else
			window.location.href="<%=request.getContextPath()%>/demand/toUploadDemand";
	});
	
	$(".subscribePanel").on("touchmove",function(ev){
		console.log(ev);
		$("body").addClass("body");
        $(this).css({
            top:ev.targetTouches[0].clientY + "px" 
        });  
     });

	$(".fa").tap(function(){
		window.location.href=$(this).attr("data-href");
	});
	
	$(".filterProduct").tap(function(){
		if(${user.role==5||empty user}){
			showRegister();
		}else{
			window.location.href="<%=request.getContextPath()%>/demand/allDemandList";
		}
	});
	
	$("#closeConfirm,.shade").tap(function(){
		$("#delete").hide();
		$(".shade").hide();
	})
	
	function getQrCode(){
		$(".waiting").show();
		$(".shade").show();

		var url=location.href.split('#')[0].replace(/&/g,"-");
  		var urlStr = "<%=request.getContextPath()%>/wechat/signature?url="+url;
  		console.log(urlStr);
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
			        jsApiList: ['scanQRCode'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
			    });
			    wx.ready(function(){
			        // config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
			        wx.scanQRCode({
			        	needResult: 0, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
		        	    scanType: ["qrCode"], // 可以指定扫二维码还是一维码，默认二者都有
		        	    success: function (res) {
		        	    	var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果

		        			$(".waiting").hide();
		        			$(".shade").hide();
		        	    }
			        }); 
			    });
			}
		}); // end ajax   
	}
	countShopcart();
	function countShopcart(){
		var url="<%=request.getContextPath()%>/shopcart/countShopCartNum";
		doAjax("GET",url,{},countSuccess,fail,true,false);
	}
			
	function countSuccess(data){
		if(data.data>0){
			$(".fooCartNum").html(data.data);
			$(".fooCartNum").show();
		}
	}
	
	
	function fail(data){
		
	}
	
	function showTip(content){
		$(".tip").html(content);
		$(".tip").css("opacity","0.8");
		setTimeout(function(){
			$(".tip").html("");
			$(".tip").css("opacity","0");
		},1000);
	}
	
	function closeWindow() {
		var url=location.href.split('#')[0].replace(/&/g,"-");
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
			        jsApiList: ['closeWindow'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
			    });
			    wx.error(function(res){
			           
			    });
			    wx.ready(function(){
					url="<%=request.getContextPath()%>/buyer/sendWarnMessage";
					var params={};
					doAjax("GET",url,params,function(data){},function(data){console.log(fail);},true,false);
					wx.closeWindow();
			    });
			}
		}); // end ajax
	}

	$(".classifyA").tap(function(){
		window.location.href="<%=request.getContextPath()%>/demand/demandList";
	})
	
	function showRegister(){
		$("#delete").show();
		$(".shade").show();
	}
	
	$("#agency").tap(function(){
		window.location.href="tel:13610092487";
	})
	
	$("#factory").tap(function(){
		window.location.href="<%=request.getContextPath()%>/user/toAuthenticationFactory";
	})
	
	function toDemandOffer(){
		if(${user.role==5||empty user}){
			showRegister();
		}else{
			window.location.href="<%=request.getContextPath() %>/demand/myDemandOffer";
		}
	}
</script><!-- 
<script>
//订阅提示弹出面板
$('.subscribePanel').click(function(e){
	$subscribePanel = $('.subscribePanel');
	if( $subscribePanel.css('right') == '-140px' ){
		$subscribePanel.animate({right:'0'},150);
	}else {
		$subscribePanel.animate({right:'-140px'},100);
	}
	e.stopPropagation();
});

//隐藏筛选面板
document.addEventListener('touchmove',function(){
	$('.subscribePanel').animate({right:'-140px'},100);
});
</script> -->
<input type="hidden" id="lujing" value="<%=request.getContextPath()%>">
<script src="<%=request.getContextPath()%>/resources/common/count.js?2"></script>