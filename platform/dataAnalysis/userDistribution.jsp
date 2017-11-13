<%@ page language="java" import="java.util.*,com.alphaking.constant.*,com.alphaking.model.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!doctype html>
<html lang="en">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport"
	          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
	    <title>管理后台</title>
	    <link rel="icon" type="image/x-icon" href="<%=request.getContextPath() %>/resources/backStage/image/favicon.ico" />
	
	    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/common/bootstrap.min.css" />
	    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/backStage/css/index.css" />
	    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/common/bootstrap-table.min.css" />
		
	    
	</head>
	<body>
		<jsp:include page="/jsp/platform/header.jsp"></jsp:include>
		<jsp:include page="/jsp/platform/navigation.jsp"></jsp:include>
		 <div>
			 <select id="userSelection" onchange="getUserData(this.value)">
			 	<option value="0">全国经销商</option>
			 	<option value="1">购买终端机的客户</option>
			 </select>
		 </div>
    	 <div id="allmap" style="height:800px;"></div>
    </div><!-- 页面主体的右边]] -->

    </div><!-- 页面主体]] -->
 
 	
    <footer>

    </footer>
	<script type="text/javascript" src="https://api.map.baidu.com/api?v=2.0&ak=6OqF8pnZwtLqg8qlhwh1wyN4"></script>
	<script type="text/javascript">
	
    	var mp = new BMap.Map("allmap");
    	var point = new BMap.Point(116.404, 39.915);
    	
    	mp.centerAndZoom(point, 6);
    	mp.enableScrollWheelZoom();
    	mp.enableInertialDragging();

    	mp.enableContinuousZoom();

    	var size = new BMap.Size(10, 20);
    	
    	mp.addControl(new BMap.CityListControl({
    	    anchor: BMAP_ANCHOR_TOP_LEFT,
    	    offset: size,
    	    
    	    // 切换城市之间事件
    	    // onChangeBefore: function(){
    	    //    alert('before');
    	    // },
    	    // 切换城市之后事件
    	    // onChangeAfter:function(){
    	    //   alert('after');
    	    // }
    	}));		
    	
    	var marker;
    	var myIcon = new BMap.Icon("http://api.map.baidu.com/img/markers.png", new BMap.Size(23, 25), {  
            offset: new BMap.Size(10, 25), // 指定定位位置  
            imageOffset: new BMap.Size(0, 0 - 10 * 25)
    	 }); 
    	<c:forEach items="${userList}" var="user">
    		<c:if test="${user.lampSelectionLogin!=1}">
    			marker = new BMap.Marker(new BMap.Point(${user.longitude},${user.latitude}));
    		</c:if>
    		<c:if test="${user.lampSelectionLogin==1}">
				marker = new BMap.Marker(new BMap.Point(${user.longitude},${user.latitude}),{icon:myIcon});
    		</c:if>
    		mp.addOverlay(marker);
    		marker.addEventListener("click",showInformation.bind(this,"${user.shortCompanyName}","${user.legalPersonName}","${user.phoneNumber}"));
    	</c:forEach>
   		
    	function showInformation(shortCompanyName,legalPersonName,phoneNumber){
    		alert("店铺名："+shortCompanyName+"\n联系人："+legalPersonName+"\n联系电话："+phoneNumber);
    	}
    	
   		function FormatDate (strTime) {
		    var date = new Date(strTime);
		    return date.Format("yyyy-MM-dd");
		}
    
   		function getData(){
   			var url="<%=request.getContextPath()%>/platform/userMapData";
   			doAjax("GET",url,{sortBy:sortBy,from:$("input[name='from']").val(),to:$("input[name='to']").val()},success,fail,true,false)
   		} 
   		
   	 	Date.prototype.Format = function (fmt) { //author: meizz 
         var o = {
             "M+": this.getMonth() + 1, //月份 
             "d+": this.getDate(), //日 
             "h+": this.getHours(), //小时 
             "m+": this.getMinutes(), //分 
             "s+": this.getSeconds(), //秒 
             "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
             "S": this.getMilliseconds() //毫秒 
         };
         if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
         for (var k in o)
         if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
         return fmt;
     }
   	 	
   	 	function getUserData(type){
   	 		var url="<%=request.getContextPath()%>/platform/userDistributionAjax";
   	 		var params={type:type};
			doAjax("GET",url,params,function(data){
				mp.clearOverlays(); 
				var userList = data.data;
				for(var i=0;i<userList.length;i++){
					if(userList[i].lampSelectionLogin!=1)
						marker = new BMap.Marker(new BMap.Point(userList[i].longitude,userList[i].latitude));
					else
						marker = new BMap.Marker(new BMap.Point(userList[i].longitude,userList[i].latitude),{icon:myIcon});
		    		mp.addOverlay(marker);
		    		marker.addEventListener("click",showInformation.bind(this,userList[i].shortCompanyName,userList[i].legalPersonName,userList[i].phoneNumber));
				}
			},function(data){console.log("fail")},true,false);   	 		
   	 	}
    </script> 
</body>
</html>