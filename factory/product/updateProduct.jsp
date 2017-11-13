<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>佐为照明</title>
    <link href="<%=request.getContextPath() %>/resources/common/bootstrap.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/common/swiper.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/factory/assets/css/product.css" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
   
</head>
<body class="addProductPop">
<div class="addProduct">
    <div class="title">添加商品</div>

    <form action="<%=request.getContextPath() %>/factory/updateProduct" method="post" class="form-horizontal" onsubmit="return submitForm()">
        <input type="hidden" name="productId" value="${product.product.productId }">
        <input type="hidden" name="userId" value="${product.product.userId}">
        <input type="hidden" name="checkStatus" value="${product.product.checkStatus}">
        <input type="hidden" name="onlineStatus" value="${product.product.onlineStatus}">
        <input type="hidden" name="productSales" value="${product.product.productSales}">
        <input type="hidden" name="checkId" value="${product.product.checkId}">
        <input type="hidden" name="isPopular" value="${product.product.isPopular}">
        <input type="hidden" name="publishTime" value="${product.product.publishTime}">
        <input type="hidden" name="producStatus" value="${product.product.productStatus }"/>
        <div class="form-group">
            <label for="productName" class="control-label col-xs-offset-1 col-xs-3">商品名</label>
            <div class="col-xs-7">
                <input type="text" class="form-control" id="productName" name="productName" value="${product.product.productName }"/>
            </div>
        </div>
        <div class="form-group clearfix" id="carouselImg">
            <div class="tip">商品轮播图（最少一张，最多五张）</div>
            <c:if test="${!empty product.product.cover1 }">
            	<div class="width-2 img-content">
	                <img src="${product.product.cover1 }" alt="" class="img" />
	                <input type="hidden" class="imgSrc" value="${product.product.cover1 }"/>
	                <span class="cancel">X</span>
	            </div>
            </c:if>
            <c:if test="${!empty product.product.cover2 }">
            	<div class="width-2 img-content">
	                <img src="${product.product.cover2 }" alt="" class="img" />
	                <input type="hidden" class="imgSrc" value="${product.product.cover2 }"/>
	                <span class="cancel">X</span>
	            </div>
            </c:if>
            <c:if test="${!empty product.product.cover3 }">
            	<div class="width-2 img-content">
	                <img src="${product.product.cover3 }" alt="" class="img" />
	                <input type="hidden" class="imgSrc" value="${product.product.cover3 }"/>
	                <span class="cancel">X</span>
	            </div>
            </c:if>
            <c:if test="${!empty product.product.cover4 }">
            	<div class="width-2 img-content">
	                <img src="${product.product.cover4 }" alt="" class="img" />
	                <input type="hidden" class="imgSrc" value="${product.product.cover4}"/>
	                <span class="cancel">X</span>
	            </div>
            </c:if>
            <c:if test="${!empty product.product.cover5 }">
            	<div class="width-2 img-content">
	                <img src="${product.product.cover5 }" alt="" class="img" />
	                <input type="hidden" class="imgSrc" value="${product.product.cover5 }"/>
	                <span class="cancel">X</span>
	            </div>
            </c:if>
            <div class="width-2 img-content add-content" <c:if test="${!empty product.product.cover5}">style="display:none"</c:if>>
                <span class="add">+</span>
                <img src="" alt="" class="img" style="display: none" />
                <span class="cancel" style="display:none">X</span>
            </div>
           
        </div>
        <div class="form-group">
            <div class="tip">商品描述</div>
            <label class="areaLab">
                <textarea  class="form-control" id="introduce" name="productContent" rows="5" >${product.product.productContent}</textarea>
            </label>
        </div>
        <div class="form-group clearfix" id="illustration">
            <div class="tip">配图（最多10张）</div>
            <c:if test="${!empty product.product.descriptionPic1}">
            <div class="width-2 img-content">
	            <img src="${product.product.descriptionPic1}" alt="" class="img" />
	            <input type="hidden" class="imgSrc" value="${product.product.descriptionPic1}"/>
	            <span class="cancel">X</span>
            </div>
            </c:if>
             <c:if test="${!empty product.product.descriptionPic2}">
            <div class="width-2 img-content">
	            <img src="${product.product.descriptionPic2}" alt="" class="img" />
	            <input type="hidden" class="imgSrc" value="${product.product.descriptionPic2}"/>
	            <span class="cancel">X</span>
            </div>
            </c:if>
             <c:if test="${!empty product.product.descriptionPic3}">
            <div class="width-2 img-content">
	            <img src="${product.product.descriptionPic3}" alt="" class="img" />
	            <input type="hidden" class="imgSrc" value="${product.product.descriptionPic3}"/>
	            <span class="cancel">X</span>
            </div>
            </c:if>
             <c:if test="${!empty product.product.descriptionPic4}">
            <div class="width-2 img-content">
	            <img src="${product.product.descriptionPic4}" alt="" class="img" />
	            <input type="hidden" class="imgSrc" value="${product.product.descriptionPic4}"/>
	            <span class="cancel">X</span>
            </div>
            </c:if>
             <c:if test="${!empty product.product.descriptionPic5}">
            <div class="width-2 img-content">
	            <img src="${product.product.descriptionPic5}" alt="" class="img" />
	            <input type="hidden" class="imgSrc" value="${product.product.descriptionPic5}"/>
	            <span class="cancel">X</span>
            </div>
            </c:if>
             <c:if test="${!empty product.product.descriptionPic6}">
            <div class="width-2 img-content">
	            <img src="${product.product.descriptionPic6}" alt="" class="img" />
	            <input type="hidden" class="imgSrc" value="${product.product.descriptionPic6}"/>
	            <span class="cancel">X</span>
            </div>
            </c:if>
             <c:if test="${!empty product.product.descriptionPic7}">
            <div class="width-2 img-content">
	            <img src="${product.product.descriptionPic7}" alt="" class="img" />
	            <input type="hidden" class="imgSrc" value="${product.product.descriptionPic7}"/>
	            <span class="cancel">X</span>
            </div>
            </c:if>
             <c:if test="${!empty product.product.descriptionPic8}">
            <div class="width-2 img-content">
	            <img src="${product.product.descriptionPic8}" alt="" class="img" />
	            <input type="hidden" class="imgSrc" value="${product.product.descriptionPic8}"/>
	            <span class="cancel">X</span>
            </div>
            </c:if>
             <c:if test="${!empty product.product.descriptionPic9}">
            <div class="width-2 img-content">
	            <img src="${product.product.descriptionPic9}" alt="" class="img" />
	            <input type="hidden" class="imgSrc" value="${product.product.descriptionPic9}"/>
	            <span class="cancel">X</span>
            </div>
            </c:if>
             <c:if test="${!empty product.product.descriptionPic10}">
            <div class="width-2 img-content">
	            <img src="${product.product.descriptionPic10}" alt="" class="img" />
	            <input type="hidden" class="imgSrc" value="${product.product.descriptionPic10}"/>
	            <span class="cancel">X</span>
            </div>
            </c:if>
             <div class="width-2 img-content add-content" <c:if test="${!empty product.product.descriptionPic10}">style="display:none"</c:if>>
                <input type="file" class="fileInp"/>
                <span class="add">+</span>
                <img src="" alt="" class="img" style="display: none" />
                <span class="cancel" style="display:none">X</span>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-xs-3">批发价</label>
            <div class="col-xs-8">
                <input type="text" class="form-control" name="unitPrice" value="${product.product.unitPrice }"/>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-xs-3">库存</label>
            <div class="col-xs-8">
                <input type="text" class="form-control" name="productStock" value="${product.product.productStock }"/>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-xs-3">货型</label>
            <div class="col-xs-8 radioInp">
                <input type="radio" value="1" name="productKind" class="" <c:if test="${product.product.productKind==1 }">checked</c:if> />现货
                <input type="radio" value="0" name="productKind" class="" <c:if test="${product.product.productKind==0 }">checked</c:if> /> 订货
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-xs-3">类型</label>
            <div class="col-xs-8">
                <select class="form-control" name="productType">
                	<c:forEach items="${typeList}" var="type">
                		<option value="${type.propertyValueId }" <c:if test="${type.propertyValueId==product.product.productType }">selected</c:if>>${type.propertyValue }</option>
                	</c:forEach>
                </select>
            </div>
        </div>
         <div class="form-group">
            <label class="control-label col-xs-3">风格</label>
            <div class="col-xs-8">
                <select class="form-control" name="productStyle">
                     <c:forEach items="${styleList}" var="style">
                		<option value="${style.propertyValueId }" <c:if test="${style.propertyValueId==product.product.productStyle}">selected</c:if>>${style.propertyValue }</option>
                	</c:forEach>
                </select>
            </div>
        </div> 
        <div class="form-group">
            <label class="control-label col-xs-3">材质</label>
            <div class="col-xs-8">
                <input type="text" id="material" class="form-control" value="${product.material }"/>
                <input type="hidden" name="productMaterial" value="${product.product.productMaterial}">
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-xs-3">空间</label>
            <div class="col-xs-8">
                <input type="text" id="room" class="form-control"  value="${product.space }"/>
                <input type="hidden" name="productSpace" value="${product.product.productSpace }">
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-xs-3">颜色</label>
            <div class="col-xs-8">
                <input type="text" class="form-control" name="productColor" value="${product.product.productColor }"/>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-xs-3">型号</label>
            <div class="col-xs-8">
                <input type="text" class="form-control" name="productCode" value="${product.product.productCode }"/>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-xs-3">光源类型</label>
            <div class="col-xs-8">
                <input type="text" class="form-control" name="lightType" value="${product.product.lightType }"/>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-xs-3">光源数量</label>
            <div class="col-xs-8">
                <input type="text" class="form-control" name="lightNumber" value="${product.product.lightNumber }"/>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-xs-3">尺寸(长)</label>
            <div class="col-xs-8 tog">
                <input type="text" class="form-control" name="productLength" value="${product.product.productLength }"/> cm
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-xs-3">尺寸(宽)</label>
            <div class="col-xs-8 tog">
                <input type="text" class="form-control" name="productWidth" value="${product.product.productWidth }"/> cm
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-xs-3">尺寸(高)</label>
            <div class="col-xs-8 tog">
                <input type="text" class="form-control" name="productHeight" value="${product.product.productHeight }"/> cm
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-xs-3">尺寸(直径)</label>
            <div class="col-xs-8 tog">
                <input type="text" class="form-control" name="productDiameter" value="${product.product.productDiameter }"/> cm
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-xs-3">尺寸(开孔)</label>
            <div class="col-xs-8 tog">
                <input type="text" class="form-control" name="productTrompil" value="${product.product.productTrompil }"/> cm
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-xs-3">尺寸(重量)</label>
            <div class="col-xs-8 tog">
                <input type="text" class="form-control" name="productWeight" value="${product.product.productWeight }"/> kg
            </div>
        </div>
        <!-- [[提交按钮-->
        <div class="form-group">
            <label class="control-label col-xs-3"></label>
            <div class="col-xs-8">
                <input type="submit" class="btn btn-primary"/>
            </div>
        </div>
        <!-- 提交按钮]]-->
    </form>
</div>

<!--[[底部-->
<jsp:include page="/jsp/factory/footer.jsp"></jsp:include>
<!--底部]]-->

<!--[[遮罩层--><div id="shadow"></div><!--遮罩层]]-->
<!--[[材质弹窗-->
<div id="popMaterial">
    <div class="text-right">
        <button class="btn btn-primary" id="confirmBtnMa">确定</button>
    </div>
   <c:forEach items="${materialList}" var="material" varStatus="i">
   		<c:if test="${i.index<10 }">
  		<div class="line clearfix <c:if test='${i.index==0}'>selected</c:if>">
	        <span class="col-xs-6 selectItem" data-id="${material.propertyValueId}">${material.propertyValue }</span>
	        <span class="col-xs-6 text-right gou"><c:if test="${fn:contains(product.material, material.propertyValue)}"><i class="icon iconfont">&#xe611;</i></c:if></span>
	     </div>
	    </c:if>
  	</c:forEach> 
  	
    
</div>
<!--材质弹窗]]-->
<!--[[空间弹窗-->
<div id="popRoom">
    <div class="text-right">
        <button class="btn btn-primary" id="confirmBtnRo">确定</button>
    </div>
   	<c:forEach items="${spaceList}" var="space" varStatus="i">
   		<div class="line clearfix <c:if test='${i.index==0}'>selected</c:if>">
	        <span class="col-xs-6 selectItem" data-id="${space.propertyValueId}">${space.propertyValue }</span>
	        <span class="col-xs-6 text-right gou"><c:if test="${fn:contains(product.space, space.propertyValue)}"><i class="icon iconfont">&#xe611;</i></c:if></span>
	    </div>
   	</c:forEach>
</div>
<!--空间弹窗]]-->

<script src="<%=request.getContextPath() %>/resources/factory/assets/js/addProduct.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script>
	$(document).on("tap",".add",function(){
		chooseImg(this);
	});
	
	function checkForm(){
		if($("#carouselImg").find(".img-content").length<2){
			alert("请至少上传一张产品轮播图");return false;
		}
		if($("#illustration").find(".img-content").length<2){
			alert("请至少上传一张产品描述图");return false;
		}
		if($("#productName").val().trim()==""){
			alert("请填写商品名");return false;
		}
		if($("#introduce").val().trim()==""){
			alert("请填写商品描述");return false;
		}
		if($("input[name='unitPrice']").val().trim()==""){
			alert("请填写批发价");return false;
		}else{
			if(isNaN($("input[name='unitPrice']").val().trim())){
				alert("请填写正确格式批发价");return false;
			}
		}
		if($("input[name='productStock']").val().trim()==""){
			alert("请填写库存");return false;
		}else{
			if(isNaN($("input[name='productStock']").val().trim())){
				alert("请填写正确格式库存");return false;
			}
		}
		if($("input[name='productKind']:checked").val()==undefined){
			alert("请选择货型");return false;
		}
		if($("input[name='productMaterial']").val()==""){
			alert("请选择至少一种材质");return false;
		}
		if($("input[name='productSpace']").val()==""){
			alert("请选择至少一种空间");return false;
		}
		return true;
	}
	

	function submitForm(){
		if(checkForm()){
			var i=1;
			$("#carouselImg .img-content").each(function(){
				$(this).find("input[type='hidden']").attr("name","cover"+i);
				i++;
			});
			
			var j=1;
			$("#illustration .img-content").each(function(){
				$(this).find("input[type='hidden']").attr("name","descriptionPic"+j);
				j++;
			})
		}else{
			return false;
		}
	}
	
	var localIds;
	var imageIndex;
	var imgType;
	function chooseImg(obj) {
		imgType=$(obj).parents(".form-group").attr("id");
		var leftImgNum=0;
		imageIndex=0;
		var imgNum=$("#"+imgType).find(".img-content").length-$("#"+imgType).find(".add-content").length;
		if(imgType=="carouselImg")
			leftImgNum=5-imgNum;
		else
			leftImgNum=10-imgNum;
		
		failImg="";
		imageIndex=0;
		
		/* var image = $("<img />");
    	var div = $("<div class='width-2 img-content'></div>");
    	var input = $("<input type='hidden' name='fileId' class='imgSrc'>");
    	var span = $("<span class='cancel' style='display:none'></span>");
    	

    	
    	image.appendTo(div);
    	input.appendTo(div);
    	span.appendTo(div);
		$("#"+imgType+" .add").parent().before(div);
		

		image.attr("src","http://findeng.79deng.com:8080/findeng/picture/authentication/14630311181310.jpg"); */
		/* 
			$("#load_shade").find("span").eq(1).html("请稍候...");
			$("#load_shade").show(); 
		*/
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
			    	$("#load_shade").hide();
			        // config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行
					//。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
			    	wx.chooseImage({
			    	    count: leftImgNum, // 默认9
			    	    sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
			    	    sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
			    	    success: function (res) {
			    	        localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
			    	        count=localIds.length;
			    	        imgLength=localIds.length;
			    	        chooseUpload();
			    	    }
			    	});
			    });
			}
		}); // end ajax
	}
	
	function chooseUpload(){
		var image = $("<img />");
    	var div = $("<div class='width-2 img-content'></div>");
    	var input = $("<input type='hidden' name='fileId' class='imgSrc'>");
    	var span = $("<span class='cancel' style='display:none'>X</span>");
    	

    	
    	image.appendTo(div);
    	input.appendTo(div);
    	span.appendTo(div);
		$("#"+imgType+" .add").parent().before(div);
		//getImageWidth(image,localIds[imageIndex]);
		
		
		/* var fullImage="<div class='swiper-slide fullscreen_slide'><img src='"+localIds[imageIndex]+"'/></div>";
		fullscreenSwiper.appendSlide(fullImage); */
		
		var index = $("#"+imgType+" .img-content img").index(image);
		uploadImg(image,localIds[imageIndex],index);
		image.attr("src",localIds[imageIndex]);
   		
		var maxNum;
		if(imgType=="carouselImg"){
			maxNum=6;
		}else{
			maxNum=11;
		}
		
        if($("#"+imgType+" .img-content ").length>=maxNum)
        	$("#"+imgType+" .add").parent().css("display","none");
	}
	
	function uploadImg(image,localIds,index){
		 
    	 wx.uploadImage({
    		 localId: localIds, // 需要上传的图片的本地ID，由chooseImage接口获得
    		 isShowProgressTips: 1, // 默认为1，显示进度提示
    		 success: function(res) {
    		 //返回图片的服务器端ID res.serverId,然后调用wxImgCallback函数进行下载图片操作
    			image.next().val(res.serverId);
    		 	image.next().next().show();
    		 	count--;
    		 	imageIndex++;
    		 	if(imageIndex<imgLength)
    		 		chooseUpload();
    		 	
    		 	if(count==0){
    		 		if(failImg!=""){	 			
    		 			$("#uploadSpan").html("上传完成,第"+failImg.substring(0,failImg.length-1)+"张图片上传失败");
        		 		$("#uploadSpan").show();
        		 		setTimeout(function(){
        		 			$("#upload_shade").hide();
        		 		},1500);
    		 		}	
    		 	}	
    		 },
       		 fail: function(res) {      			
       		 	image.parent().remove();
       			fullscreenSwiper.removeSlide(index);
       			
	 				faileImg=(index+1)+",";
	 				count--;
	 				imageIndex++;
	 				if(imageIndex<imgLength)
    		 		chooseUpload();
	 				
	 				if(count==0){
    		 		if(failImg!=""){	
    		 			$("#uploadSpan").html("上传完成,第"+failImg.substring(0,failImg.length-1)+"张图片上传失败");
    		 			$("#uploadSpan").show();
        		 		setTimeout(function(){
        		 			$("#upload_shade").hide();
        		 		},1500);
    		 		}	
    		 	}	
       		 }
    	});
	}
	
	function getImageWidth(obj,objUrl){
		var img = new Image();
		img.src = objUrl;
		
		// 如果图片被缓存，则直接返回缓存数据
		if(img.complete){
			alert(11)
		    realImg(obj,objUrl,img.width, img.height);

		}else{
	            // 完全加载完毕的事件
		    img.onload = function(){
			 realImg(obj,objUrl,img.width, img.height);
		    }
	       }
	}

	function realImg(obj,objUrl,width,height){
		var imgWidth=width;
		var imgHeight=height;
		
		if(imgHeight>imgWidth){
			obj.css("width","150px");
			var realHeight=parseFloat(imgHeight)*150/parseFloat(imgWidth);
			var clipless=(realHeight-150)/2;
			var clipmore=clipless+150;
			obj.css("height",realHeight+"px");
			obj.attr("src",objUrl);
			obj.css("clip","rect("+clipless+"px 150px "+clipmore+"px 0px)");
			obj.css("top","-"+clipless+"px");
			obj.css("left","0px");
		}
		else{
			obj.css("height","150px");
			var realWidth=parseFloat(imgWidth)*150/parseFloat(imgHeight);
			var clipless=(realWidth-150)/2;
			var clipmore=clipless+150;
			obj.css("width",realWidth+"px");
			obj.attr("src",objUrl);
			obj.css("clip","rect(0px "+clipmore+"px 150px "+clipless+"px)");
			obj.css("top","0px");
			obj.css("left","-"+clipless+"px");
		}
		obj.siblings(".closeStyle").css("display", "inline-block");
		_warn_img.hide();
	}
	
	$(document).on("tap",".cancel",function(){
		var parent = $(this).parents('.img-content');

	    var index = $(this).parents(".clearfix").find('.add-content');
	    parent.remove();
	    
	    if(index.css("display")=='none'){
	    	index.css("display","inline-block");
	    }
	})
</script>
</body>
</html>