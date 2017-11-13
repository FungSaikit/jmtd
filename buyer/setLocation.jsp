<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<style type="text/css">
	body, html{width: 100%;height: 100%;margin:0;font-family:"微软雅黑";}
	#allmap {height: 100%;width:100%;overflow: hidden;}
	#result {width:100%;font-size:12px;}
	dl,dt,dd,ul,li{
		margin:0;
		padding:0;
		list-style:none;
	}
	dt{
		font-size:14px;
		font-family:"微软雅黑";
		font-weight:bold;
		border-bottom:1px dotted #000;
		padding:5px 0 5px 5px;
		margin:5px 0;
	}
	dd{
		padding:5px 0 0 5px;
	}
	li{
		line-height:28px;
	}
	</style>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/customer/assets/css/personCenter.css?12"/>
	<script type="text/javascript" src="https://api.map.baidu.com/api?v=2.0&ak=6OqF8pnZwtLqg8qlhwh1wyN4"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resources/interactive.js"></script>
	<title>百度地图</title>
</head>
<body>
	<div id="allmap">	
	</div>
	<button onclick="getMyPosition()" style="position: fixed;left:20%;top: 80%;height:50px;width:100px;background-color:red;border-radius:0.5rem">我的位置</button>
	<button onclick="getLocation()" style="position: fixed;left:50%;top: 80%;height:50px;width:100px;background-color:red;border-radius:0.5rem">保存</button>
</body>
<div class="tip"></div>
<script type="text/javascript">
	// 百度地图API功能
    var map = new BMap.Map('allmap');
	
    var lng,lat;
	
	var marker;
	$(function(){
		lng=${lng};//r.point.lng;
		lat=${lat};//r.point.lat;

		var poi = new BMap.Point(lng,lat);
		map.enableScrollWheelZoom();
		map.centerAndZoom(poi,18);
		marker = new BMap.Marker(poi); //创建marker对象
		map.addOverlay(marker); //在地图中添加marker
		marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
		marker.enableDragging();		
		console.log(marker);
		var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});// 左上角，添加比例尺
		var top_right_navigation = new BMap.NavigationControl({anchor: BMAP_ANCHOR_TOP_RIGHT, type: BMAP_NAVIGATION_CONTROL_SMALL}); //右上角
		map.addControl(top_left_control);        
		map.addControl(top_right_navigation);   
	});
	
	function getMyPosition(){
		var geolocation = new BMap.Geolocation();
		geolocation.getCurrentPosition(function(r){
			if(this.getStatus() == BMAP_STATUS_SUCCESS){
				map.clearOverlays();    
				marker=new BMap.Marker(r.point);
				map.centerAndZoom(r.point,18); //创建marker对象
				map.addOverlay(marker); //在地图中添加marker
				marker.enableDragging();	
				//var mk = new BMap.Marker(r.point);
				//alert('您的位置：'+r.point.lng+','+r.point.lat);
				 
			}
			else {
				//alert('failed'+this.getStatus());
			}        
		},{enableHighAccuracy: true});
	}
	
	function getLocation(){
		var point = marker.getPosition();
		var url="<%=request.getContextPath()%>/buyer/setLocation";
		var params={lng:point.lng,lat:point.lat};
		doAjax("GET",url,params,success,fail,true,false);
	}
	
	function success(data){
		showTip("保存成功");
		setTimeout(function(){
			window.location.href="<%=request.getContextPath()%>/user/accountManage";
		},1000);
	}
	
	function fail(data){
		alert("fail")
	}
	
	function showTip(content){
		$(".tip").html(content);
		$(".tip").css("opacity","0.8");
		setTimeout(function(){
			$(".tip").html("");
			$(".tip").css("opacity","0");
		},1000);
	}
</script>
</html>
