<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
		<style type="text/css">
		</style>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resources/interactive.js"></script>
		<script src="<%=request.getContextPath() %>/resources/common/jweixin-1.0.0.js"></script>
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/customer/font/iconfont.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/customer/assets/css/map.css">
		<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
		<title>地图</title>
	</head>
	<body>
		<div class="search">
			<input type="text" id="keyword" value="${keyword}" placeholder="请输入公司名">
			<input type="submit" id="submit" value="搜索">
		</div>
		<div class="addressList">
			<ul>
					<li class="rank">&nbsp;</li>
					
				</ul>
		</div>
		
		
		<script>
			var urlStr = "<%=request.getContextPath()%>/wechat/signature?url="+location.href.split('#')[0];
			//alert("Before Call:"+urlStr);
			var latitude,longitude;
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
				        jsApiList: ['getLocation','openLocation'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
				    });
				    wx.ready(function(){
				    	wx.getLocation({
				    	    type: 'gcj02', // 默认为wgs84的gps坐标，如果要返回直接给openLocation用的火星坐标，可传入'gcj02'
				    	    success: function (res) {
				    	        latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
				    	        longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
				    	        var speed = res.speed; // 速度，以米/每秒计
				    	        var accuracy = res.accuracy; // 位置精度
				    		    getAgencyList();
				    	    }
				    	});
				    });
				}
			}); // end ajax   
		
			function getAgencyList(){
				var url="<%=request.getContextPath()%>/user/getAgencyList";
				var params={lng:longitude,lat:latitude};
				doAjax("GET",url,params,getSuccess,fail,true,false);
			}
			
			function getSuccess(data){
				var html="";
				var agencyList=data.data;
				for(var i=0;i<agencyList.length;i++){
					html+='<li>';
					html+='<div class="info"><span>'+agencyList[i].shortCompanyName+'</span><span>'+agencyList[i].provinceId+
							agencyList[i].cityId+'</span></div>';
					html+='<div class="distance">'+formatDistance(agencyList[i].companyBrief)+'</div>';
					html+='<div class="navigationDiv" ><span data-lat="'+agencyList[i].latitude+'" data-lng="'
						+agencyList[i].longitude+'" data-company="'+agencyList[i].shortCompanyName+'" data-address="'
						+agencyList[i].provinceId+agencyList[i].cityId+agencyList[i].areaId
						+agencyList[i].companyAddressDetail+'"><i class="iconfont">&#xe608;</i>导航</span></div>';
					html+='</li>';
				}
				$(".addressList ul").append(html);
			}
			
			function formatDistance(distance){
				distance=parseFloat(distance);
				if(distance<0.5){
					return distance*1000+"米";
				}else{
					return distance+"公里";
				}
			}
			
			function fail(data){
				alert(fail)
			}
			
			$(document).on("tap",".navigationDiv span",function(){
				wx.openLocation({
				    latitude: $(this).attr("data-lat"), // 纬度，浮点数，范围为90 ~ -90
				    longitude: $(this).attr("data-lng"), // 经度，浮点数，范围为180 ~ -180。
				    name: $(this).attr("data-company"), // 位置名
				    address: $(this).attr("data-address"), // 地址详情说明
				    scale: 28, // 地图缩放级别,整形值,范围从1~28。默认为最大
				    infoUrl: '' // 在查看位置界面底部显示的超链接,可点击跳转
				});
			});
		</script>
	</body>

</html>