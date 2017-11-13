<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<!DOCTYPE HTML >
<html>
  <head>
    <title>test1</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/common/zepto.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/interactive.js"></script>
  	<meta http-equiv="X-UA-Compatible" content="chrome=1"> 
	<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no">
	<style>
		*{
			padding:0;
			margin:0;
		}
		#thecanvas{
			width:100%;
			
		}
	</style>
  </head>
  
  <body>
  	<canvas style="display:none;" id="thecanvas"></canvas> 
	<img src="" id="img"/>
  </body>
  <script>
  window.onload = function() { 
		draw(); 
		function draw(){ 
			var canvas = document.getElementById("thecanvas"); 
			var ctx = canvas.getContext("2d"); 
			var image = new Image();
			var image1 = new Image();
			image.src = "<%=request.getContextPath()%>/resources/123.jpg";
			image.onload = function(){
				ctx.drawImage( image , 0 , 0 );
				image1.src = "<%=request.getContextPath()%>/resources/1234.jpg";
				image1.onload = function(){
					ctx.drawImage( image1 , 50 , 50 );
					var img = canvas.toDataURL("image/png"); 
					toPut(img);
				}
			}
		} 
	}
  
  	function toPut(imgstr){
  		var url="<%=request.getContextPath()%>/getAgency/uploadPic";
  		var params={imgstr:imgstr};
  		doAjax("POST",url,params,success,fail,true,false);
  	}
  	
  	function success(data){
		document.getElementById("img").src=data.data;
  	}
  	
  	function fail(data){
  		alert();
  		
  	}
  </script>
</html>
