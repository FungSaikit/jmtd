<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>

<script type="text/javascript">

var _spn = "<i class='fa fa-spinner fa-spin'></i>";
$(".lamp-pic a").append(_spn);
$(window).on('load',function(){
		ajaxurl="<%=request.getContextPath() %>/product/Index?type=<%=request.getParameter("type")%>&typeId=<%=request.getParameter("typeId")%>";
		
		$.ajax({
	        type:  "POST",  
	        url: ajaxurl,
	        success: function(data,status,jqXHR){
	        	var imagePath;
	        	switch(data.type.propertyValue){
	        		case "吊灯":
	        			imagePath="diaodeng";
	        			break;
	        		case "壁灯":
	        			imagePath="bideng";
	        			break;
	        		case "台灯":
	        			imagePath="taideng";
	        			break;
	        		case "风扇灯":
	        			imagePath="fengsandeng";
	        			break;
	        		case "落地灯":
	        			imagePath="luodideng";
	        			break;
	        		case "吸顶灯":
	        			imagePath="xidingdeng";
	        			break;
	        		case "镜前灯":
	        			imagePath="jingqiandeng";
	        			break;
	        		case "户外照明":
	        			imagePath="shanyezhaoming";
	        			break;
	        		case "开关插座":
	        			imagePath="kaiguanchazuo";
	        			break;
	        		case "照明光源":
	        			imagePath="guangyuandengdai";
	        			break;
	        		case "其他":
	        			imagePath="qita";
	        			break;
	        	}
	        	str= "<div class='lamp-title fl'>"+
	        		 "<a href='javascript:more4(&quot;"+data.type.propertyValueId+"&quot;)'><span class='fl' style='background: url(<%=request.getContextPath()%>/resources/index/images/"+imagePath+".png) left top no-repeat;background-size:50px 50px;'></span>"+
	        		 "<h3 class='fl'>"+data.type.propertyValue+"</h3></a></div>"+
	        		 "<div class='lamp-style fl'><ul>";
	        	//风格的循环
	        	var max=(data.list.length>=6)?6:data.list.length;
	        	for(var i=0;i<max;i++)
	        		if(data.list[i].style.propertyValue!='无'){
		        		if(i==0)
		        			str+="<li class='active' data-id='"+data.list[i].style.propertyValueId+"'><a href='javascript:void()'>"+data.list[i].style.propertyValue+"</a></li>";
		        			else 
		        		    str+="<li data-id='"+data.list[i].style.propertyValueId+"'><a href='javascript:void()'>"+data.list[i].style.propertyValue+"</a></li>";
	        		}else{
	        			str+="<li class='active' style='display:none' data-id='"+data.list[i].style.propertyValueId+"'>"+data.list[i].style.propertyValue+"</a>";
	        		}
	        		    
	        	str+="</ul><label><a href='javascript:more(&quot;lamp"+<%=request.getParameter("index")%>+"&quot;)'>更多&gt;&gt;</a></label></div>"+
	        		 "<div class='lamp-k-n fl'><div class='lamp-kind fl'><h4>材质：</h4>";
	        	 
	        		for(var j=0;j<data.materialList.length;j++)
	        			if(j%3==0)
	        				str+="<span><a href='javascript:more2(&quot;lamp"+<%=request.getParameter("index")%>+"&quot;,&quot;"+data.materialList[j].propertyValueId+"&quot;)'>"+data.materialList[j].propertyValue+"</a>";
	        			else if(j%3==1)
	        				str+="<a href='javascript:more2(&quot;lamp"+<%=request.getParameter("index")%>+"&quot;,&quot;"+data.materialList[j].propertyValueId+"&quot;)'>"+data.materialList[j].propertyValue+"</a>";
	        			else if(j%3==2) 
	        				str+="<a href='javascript:more2(&quot;lamp"+<%=request.getParameter("index")%>+"&quot;,&quot;"+data.materialList[j].propertyValueId+"&quot;)'>"+data.materialList[j].propertyValue+"</a></span>";
	        				
	        				
   				str+="</div><div class='lamp-need title-md fl'>";
   	        	if(data.delist!=null&&data.delist.length>0){
   	        		str+="<h2 class='fl'>品牌推荐</h2>"+
   	        			"<span class='more fr'><a href='javascript:more3(&quot;"+data.type.propertyValueId+"&quot;)'>更多推荐&gt;&gt;</a></span>";
   		        	for(var k=0;k<1;k++)
   		        		str+="<span class='need-li clear'><a href='<%=request.getContextPath()%>/demand/intoDem/"+data.delist[k].demand.demandId+"' class='need-pic fl'>"+
   		        			"<img src='"+data.delist[k].demand.demandCoverPic+"' alt='' /></a>"+
   		        			"<div class='need-groom'><div>弄啥地方ID</div>"+
   		        			"</div><div class='need-info fl'>"+
   		        			"<dl class='price'><dd>￥:"+"7356"+"</dd></dl>"+
   		        			"<dl class='sell'><dd>已	    售:"+"<em>786</em>"+"</dd></dl></div></span>";
   	        	}else{
   	        		str+="<span class='need-li clear nothing_box'><img src='<%=request.getContextPath()%>/resources/index/image/"+imagePath+".jpg' class='nothing'/></span>";
   	        	}		
	        	str+="</div></div>";
	        	
	        	for(var l=0;l<max;l++)
	        		{
	        		if(l==0)
	        		str+="<div class='lamp-list lamp-active fl'>";
	        		else
	        			str+="<div class='lamp-list fl'>";
	        			var num=data.list[l].pelist.length>=6?6:data.list[l].pelist.length;
	        		for(var n=0;n<num;n++)
	        			{
	        			console.log(n)
	        			str+="<div class='lamp-div fl'><div class='lamp-pic'>"+"<a href='<%=request.getContextPath()%>/product/intoPro/"+data.list[l].pelist[n].product.productId+"' class='deng-pic'>"+
	        				"<img src='"+data.list[l].pelist[n].product.productCoverPic+"' alt='' /></a></div><div class='lamp-info clear'>"+
	        				"<p><a class='intwoline' href='<%=request.getContextPath()%>/product/intoPro/"+data.list[l].pelist[n].product.productId+"'>"+data.list[l].pelist[n].product.productName+"</a></p>";	        				
	        			if(${! empty sessionScope.user})
	        				str+="<dl><dt></dt><dd><strong>￥"+data.list[l].pelist[n].product.unitPrice+"</strong></dd></dl>";
	        			else
	        				str+="<dl><dt></dt><dd><strong>￥"+data.list[l].pelist[n].product.productOriginPrice+"</strong></dd></dl>";
	        			/* str+="<dl><dt>店铺：</dt><dd>"+data.list[l].pelist[n].shopName+"</dd><dl>"+
	        				 "<dl><dt>库存：</dt><dd>"+data.list[l].pelist[n].product.productStock+"</dd></dl>"+
	        				 "<dl><dt>地区：</dt><dd>"+data.list[l].pelist[n].city+"</div></div>"; */
	        				 str+="<span class='buy'>订制</span></div></div>";
	        			}
	        		str+="</div>";
	        		}

	        		str+="</div>";
	        	document.getElementById("lamp<%=request.getParameter("index")%>").innerHTML=str;
	        	
	        	//保证首页需求,产品图片不压缩
				$(".deng-pic img,.need-pic img").each(function(){
					var img = new Image();
					img.src = $(this).attr("src");
					var $this= $(this);
					var w=$this.parent().css("width");
					var h=$this.parent().css("height");
					// 如果图片被缓存，则直接返回缓存数据
					if(img.complete){
						realImg($this,img.src,img.width, img.height,w,h);
					}else{
						// 完全加载完毕的事件
						img.onload = function(){
						realImg($this,img.src,img.width, img.height,w,h);
					 }}
				});
				
				function realImg(obj,objUrl,width,height,w,h){
					var imgWidth=width;
					var imgHeight=height;
					if(imgHeight>imgWidth){
						obj.css("width",w);
						var realHeight=parseFloat(imgHeight)*parseFloat(w)/parseFloat(imgWidth);
						var clipless=(parseFloat(realHeight)-parseFloat(h))/2;
						var clipmore=parseFloat(clipless)+parseFloat(h);
						obj.css("height",realHeight+"px");
						obj.attr("src",objUrl);
						obj.css("clip","rect("+clipless+"px "+parseFloat(w)+"px "+clipmore+"px 0px)");
						obj.css("top",-(parseFloat(clipless))+"px");
						obj.css("left","0px");
					}
					else{
						obj.css("height",h);
						var realWidth=parseFloat(imgWidth)*parseFloat(h)/parseFloat(imgHeight);
						var clipless=(parseFloat(realWidth)-parseFloat(w))/2;
						var clipmore=parseFloat(clipless)+parseFloat(w);
						obj.css("width",realWidth+"px");
						obj.attr("src",objUrl);
						obj.css("clip","rect(0px "+clipmore+"px "+parseFloat(h)+"px "+clipless+"px)");
						obj.css("top","0px");
						obj.css("left",-(parseFloat(clipless))+"px");
					}
				}
	        	
	        	
	        		setTimeout(function (){
	        			$(function(){
			        		var $li = $('.lamp-style ul li');
			        		$li.mouseenter(function(){
			        			$(this).addClass('active').siblings().removeClass('active');
			        			var index = $li.index(this);
			        			$("div.main-gp-top .lamp-list").eq(index).addClass('lamp-active').siblings().removeClass('lamp-active');
			        		});
			        	});
	        			
	        			
	        			$(window).scroll(function(){
	        				var top = $(document).scrollTop();
	        				var menu = $("#headerMenu");
	        				var items = $("#content").find(".main-gp-top");
	        				var maxH = 300,
	        				offsetMax = 9340, offsetMin = 170;
	        				speed = 250;
	        				
	        				var currentId = "";//当前所在的楼层id
	        				items.each(function(){
	        					var m = $(this);
	        				
	        					var itemTop = m.offset().top;
	        					if(top > itemTop - maxH){
	        						currentId = $("#request.getContextPath()").val()+"#" + m.attr("id");
	        					}else{
	        						return false;
	        					}
	        				});
	        				
	        				//给相应楼层的a设置current，取消其他链接的
	        				var currentLink = menu.find(".active");
	        			
	        				if(top < offsetMin){
	        					currentLink.removeClass("active");
	        					return;
	        				}
	        				if(currentId && (currentLink.attr("href")!=currentId) ){
	        					currentLink.removeClass("active");
	        				
	        					menu.find("[href='"+ currentId + "']").parent().addClass("active");
	        				}
	        				
	        				top < offsetMax ? menu.fadeIn(speed):menu.fadeOut(speed);
	        				if(top < offsetMin){
	        					currentLink.removeClass("active");
	        				}
	        			});
	        			
	        			
		        	  }, 1000);
	        		
		        	
	        		
	        }
		});
	
}
);
			
			//风格的更多
			function more(str)
			{
				id2="#"+str+" h3";
				id ="#"+str;
				var typeId = $(id).attr("data-text");
				var type = $(id2).text();
				   $.each($(id+" ul li"),function(index,style){
					   if($(this).attr('class')=='active'){
						  var styleId=$(this).attr('data-id');
						  url='<%=request.getContextPath()%>/search/index_search1_pro?property='+typeId+'&property=全部&property='+styleId;
						  window.location.href=url;
					   }
					});
			}
			//材质的更多
			function more2(str,material)
			{
				id="#"+str;
				id2="#"+str+" h3";
				var typeId = $(id).attr("data-text");
				$.each($(id+" ul li"),function(index,style){
					   if($(this).attr('class')=='active'){
						  var styleId=$(this).attr('data-id');
						  var materialId=material;
						  url='<%=request.getContextPath()%>/search/index_search1_pro?property='+typeId+'&property='+materialId+'&property='+styleId;
						  window.location.href=url;
					   }
					});
			}
			
			//需求的更多
			function more3(type)
			{
				window.location.href='<%=request.getContextPath()%>/search/index_search1_dem?property='+type;
			}
			
			function more4(type)
			{
				window.location.href='<%=request.getContextPath()%>/search/index_search1_pro?property='+type;
			}
			
			
			function transToPropertyValueId(propertyName,propertyValue)
			{
				var result;
				url="<%=request.getContextPath()%>/property/trans?propertyName="+propertyName+"&propertyValue="+propertyValue;
				$.ajax({
					type:"post",
					url:url,
					async:false,
					success:function(data,status,jqXHR){
						result=data;
					}
				});
				return result;
			}

</script>
  </head>
  <body>
    <div id="lamp<%=request.getParameter("index")%>" class="main-gp-top clear" data-text="<%=request.getParameter("typeId")%>">
    	
    </div>
   <!--  <div style="height: 200px;margin-bottom: 30px;">
	    <div>
	    	<div style="width:50%;height:200px;float:left;background-color: palegoldenrod;"><img style=" width: 100%;height: 200px;" src="http://pic.qiantucdn.com/58pic/22/79/42/48h58PIC7Tr_1024.JPG!/fw/780/watermark/url/L3dhdGVybWFyay12MS4zLnBuZw==/align/center"/></div>
	    	<div style="width:50%;height:200px;float:right;background-color: pink;"><img style=" width: 100%;height: 200px;" src="http://pic.qiantucdn.com/58pic/19/83/26/02958PICzCa_1024.jpg!/fw/780/watermark/url/L3dhdGVybWFyay12MS4zLnBuZw==/align/center"/></div>
	    </div>
    </div> -->
  </body>
</html>
