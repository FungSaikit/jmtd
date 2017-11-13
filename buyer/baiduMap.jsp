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
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=6OqF8pnZwtLqg8qlhwh1wyN4"></script>
	<script type="text/javascript" src="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.js"></script>
	<link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css" />
	<script type="text/javascript" src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resources/interactive.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/customer/assets/css/personCenter.css?12"/>
	<title>百度地图</title>
</head>
<body>
	<div id="allmap">	
	</div>
	<div id="r-result"></div>
</body>
<script type="text/javascript">
	// 百度地图API功能
    var map = new BMap.Map('allmap');
	
    map.addEventListener('touchstart',function(e){element=e.domEvent.srcElement; element.click();});
    var lng,lat;
	var geolocation = new BMap.Geolocation();
	geolocation.getCurrentPosition(function(r){
		if(this.getStatus() == BMAP_STATUS_SUCCESS){
			var mk = new BMap.Marker(r.point);
			//alert('您的位置：'+r.point.lng+','+r.point.lat);
			lng=r.point.lng;
			lat=r.point.lat;

			getUserList();
		}
		else {
			//alert('failed'+this.getStatus());
		}        
	},{enableHighAccuracy: true});
	
	$(function(){
	});
	
	var address;
	function getUserList(){
		var url="<%=request.getContextPath()%>/user/getAgencyList";
		var params={lat:lat,lng:lng};
		doAjax("GET",url,params,success,fail,true,false);
	}
	
	function success(data){
		var userList = data.data;
		for(var i=0;i<userList.length;i++){
		    var poi = new BMap.Point(userList[i].longitude,userList[i].latitude);
		   
		    map.enableScrollWheelZoom();

		    var content = '<div style="margin:0;line-height:20px;padding:2px;">' +
		                  '地址：'+userList[i].provinceId+userList[i].cityId+userList[i].areaId+userList[i].companyAddressDetail+'<br/>电话：<a href="tel:'+userList[i].phoneNumber+'">'+userList[i].phoneNumber+'</a><br/>'+
		                  '<button onclick="toLocation('+userList[i].longitude+','+userList[i].latitude+')">到这里去</button></div>';

		    var marker = new ComplexCustomOverlay(poi, userList[i].shortCompanyName,content);//new BMap.Marker(poi); //创建marker对象

		    //marker.enableDragging(); //marker可拖拽
		    map.addOverlay(marker); //在地图中添加marker
		    addClickHandler(content,userList[i].shortCompanyName,marker);
		}
		poi=new BMap.Point(lng,lat);
		var marker =  new ComplexCustomOverlay2(poi,"我的位置","address"); //创建marker对象
		map.addOverlay(marker); //在地图中添加marker
		marker.addEventListener("click",function(e){
			getPosition(marker);
		});
		map.centerAndZoom(poi,11);
		var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});// 左上角，添加比例尺
		var top_right_navigation = new BMap.NavigationControl({anchor: BMAP_ANCHOR_TOP_RIGHT, type: BMAP_NAVIGATION_CONTROL_SMALL}); //右上角
		map.addControl(top_left_control);        
		map.addControl(top_right_navigation);    
		//address=userList[userList.length-1].companyAddressDetail;
	}
	
	function addClickHandler(content,title,marker){
		var m = new BMap.Marker(marker._point);
		marker.addEventListener("click", function(e){	
			//创建检索信息窗口对象
		    var searchInfoWindow = null;
			searchInfoWindow = new BMapLib.SearchInfoWindow(map, content, {
				title  : title,      //标题
				width  : 290,             //宽度
				height : 105,              //高度
				panel  : "panel",         //检索结果面板
				enableAutoPan : true,     //自动平移
				value : "11",
				searchTypes   :[
				]
			});
			searchInfoWindow.open(m);
			$(".BMapLib_sendToPhone").remove();
		});
	}
	
	
	
	function fail(data){
		alert("fail");
	}
	
	function changePath(path){
		if(path!=null){
			var i=path.lastIndexOf("/");
			return path.substring(0,i+1)+"thumbnailImage/"+path.substring(i+1);
		}else{
			return "#";
		}
	}
	
	var driving;
	function toLocation(longitude,latitude){
		var p1 = new BMap.Point(lng,lat);
		var p2 = new BMap.Point(longitude,latitude);

		driving = new BMap.DrivingRoute(map, {renderOptions:{map: map,panel: "r-result", autoViewport: true}});
		driving.search(p1, p2);
	}
	
	//自定义覆盖物1
	function ComplexCustomOverlay(point, text, mouseoverText){
      this._point = point;
      this._text = text;
      this._overText = mouseoverText;
    }
    ComplexCustomOverlay.prototype = new BMap.Overlay();
    ComplexCustomOverlay.prototype.initialize = function(mp){
      this._map = mp;
      var div = this._div = document.createElement("span");
      div.style.position = "absolute";
      div.style.zIndex = BMap.Overlay.getZIndex(this._point.lat);
      div.style.backgroundColor = "";
      div.style.color = "white";
      div.style.width = "0.6rem";
      div.style.height = "0.7rem";
      div.style.lineHeight = "0.3rem";
      div.style.textAlign = "center";
      div.style.verticalAlign="center";
      div.style.MozUserSelect = "none";
      div.setAttribute("class","iconSpan");
      var span = this._span = document.createElement("i");
      span.style.color="red";
      span.setAttribute("class","icon iconfont");
      div.appendChild(span);
      span.innerHTML="&#xe636;";      
      var that = this;
     
      
       /*
      div.onmouseout = function(){
        this.style.backgroundColor = "#EE5D5B";
        this.style.borderColor = "#BC3B3A";
        this.getElementsByTagName("span")[0].innerHTML = that._text;
        arrow.style.backgroundPosition = "0px 0px";
      } */
      map.getPanes().labelPane.appendChild(div);
      
      return div;
    }
    ComplexCustomOverlay.prototype.draw = function(){
      var mp = this._map;
      var pixel = mp.pointToOverlayPixel(this._point);
      this._div.style.left = pixel.x + "px";
      this._div.style.top  = pixel.y - 30 + "px";
    }
    ComplexCustomOverlay.prototype.addEventListener = function(event,fun){	
        this._div['on'+event] = fun;
    }
    
    //自定义覆盖物2
	function ComplexCustomOverlay2(point, text, mouseoverText){
      this._point = point;
      this._text = text;
      this._overText = mouseoverText;
    }
    ComplexCustomOverlay2.prototype = new BMap.Overlay();
    ComplexCustomOverlay2.prototype.initialize = function(mp){
      this._map = mp;
      var div = this._div = document.createElement("span");
      div.style.position = "absolute";
      div.style.zIndex = BMap.Overlay.getZIndex(this._point.lat);
      div.style.color = "white";
      div.style.width = "0.6rem";
      div.style.height = "0.7rem";
      div.style.lineHeight = "0.3rem";
      div.style.textAlign = "center";
      div.style.verticalAlign="center";
      div.style.MozUserSelect = "none";
      div.setAttribute("class","iconSpan");
      var span = this._span = document.createElement("i");
      span.style.color="blue";
      span.style.fontSize=".9rem";
      span.setAttribute("class","icon iconfont");
      div.appendChild(span);
      span.innerHTML="&#xe637;";      
      var that = this;
     
      
       /*
      div.onmouseout = function(){
        this.style.backgroundColor = "#EE5D5B";
        this.style.borderColor = "#BC3B3A";
        this.getElementsByTagName("span")[0].innerHTML = that._text;
        arrow.style.backgroundPosition = "0px 0px";
      } */
      map.getPanes().labelPane.appendChild(div);
      
      return div;
    }
    ComplexCustomOverlay2.prototype.draw = function(){
      var mp = this._map;
      var pixel = mp.pointToOverlayPixel(this._point);
      this._div.style.left = pixel.x + "px";
      this._div.style.top  = pixel.y - 30 + "px";
    }
    ComplexCustomOverlay2.prototype.addEventListener = function(event,fun){	
   	 
        this._div['on'+event] = fun;
    }
    
    var geoc = new BMap.Geocoder(); 
    function getPosition(obj){
    	var point=obj._point;
    	geoc.getLocation(point,function(rs){
    		var addComp = rs.addressComponents;
			alert(addComp.province + ", " + addComp.city + ", " + addComp.district + ", " + addComp.street + ", " + addComp.streetNumber);
    	});
    }
</script>
</html>