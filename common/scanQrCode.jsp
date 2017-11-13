<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML>
<html>
  <head>
    <title>佐为照明</title>
    
	<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
 	<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
  </head>
  
  <body>
  
  </body>
  <script>
  	$(function(){
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
			        jsApiList: ['scanQRCode'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
			    });
			    wx.ready(function(){
			        // config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
			        wx.scanQRCode({
			        	needResult: 0, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
		        	    scanType: ["qrCode"], // 可以指定扫二维码还是一维码，默认二者都有
		        	    success: function (res) {
		        	    	var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
		        	    }
			        }); 
			    });
			}
		}); // end ajax   
  	})
  </script>
</html>
