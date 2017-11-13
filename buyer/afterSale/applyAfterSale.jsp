<%@ page language="java" import="java.util.*,com.alphaking.constant.*,com.alphaking.model.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <meta charset="UTF-8">
    <title>东方百泰</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/customer/assets/css/topbar_orange.css">

    <style type="text/css">

		textarea,input{
			border:none; resize : none; 
		}
        body {
            background-color: #f4f4f4;
        }

        .block {
            margin-top: 0.5rem;
            background-color: #fff;
            width: 100%;
        }

        .goodsdetails {
            height: 13rem;
        }

        .post_button {
            display: block;
            position: fixed;
            bottom: 0;
            height: 3rem;
            text-align: center;
            font-size: 1.2rem;
            background-color: #f38200;
            color: #fff;
            width: 100%;
            border: 0;
        }

        .goodsinfotop {
            height: 2rem;
            width: 100%;
            border-bottom: 1px #d5d5d5 solid;
            line-height: 2rem;
            display: block;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            word-wrap: break-word;
            font-size: 0.9rem;
        }

        .goodsinfo {
            height: 8rem;
            border-bottom: 1px #e5e5e5 solid;
            display: flex;
        }

        .goodspic {
            display: inline-block;
            width: 8rem;
            height: 8rem;

        }

        .goodspic img {
            margin: 0.5rem;
            width: 7rem;
            height: 7rem;
        }

        .goodsdetail {
            display: flex;
            height: 8rem;
            flex-grow: 1;
            flex-flow: column;
        }

        .goodstitle {
            margin-top: 0.5rem;
            height: 1.75rem;
        }

        .goodstitle_span {
            display: inline-block;
            width: 100%;
            font-size: 0.9rem;
            line-height: 1.75rem;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 1;
            -webkit-box-orient: vertical;
            vertical-align: middle;
        }

        .goodsmodel {
            height: 1.75rem;
        }

        .goodsmodel_span {
            color: #999;
            font-size: 0.8rem;
            line-height: 1.75rem;

            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 1;
            -webkit-box-orient: vertical;
            vertical-align: middle;
            word-break: break-all;
        }

        .goodsprice {
            height: 1.75rem;
        }

        .goodsprice_span {
            color: #f55e0b;
            line-height: 1.75rem;
        }

        .goodsnumber_span {
            font-size: 0.8rem;
            color: #999;
            line-height: 1.75rem;
            margin-right: 0.5rem;
            float: right;
        }

        .roundbutton {
            display: inline-block;
            height: 1.5rem;
            line-height: 1.5rem;
            width: 5.5rem;
            border-radius: 1rem;
            text-align: center;
            text-decoration: none;
            font-size: 0.8rem;
            background-color: #fff;
        }

        .service_div {
            height: 3rem;
            width: 100%;
        }

        .button_unselected {
            border: 1px #999999 solid;
            color: #000;
        }

        .button_selected {
            border: 1px #f38200 solid;
            color: #f38200;
        }

        .button_div {
            width: 49.75%;
            background-color: #fff;
            height: 2.9rem;
            line-height: 2.9rem;
            text-align: center;
        }

        .leftbutton {
            float: left;
        }

        .rightbutton {
            float: right;
        }

        .reason {
            height: 4rem;
            display: flex;
        }

        #reasontitle {
            display: inline-block;
            width: 6rem;
            text-align: center;
            padding-top: 0.5rem;
        }

        #reasoncontent {
            display: inline-block;
            flex-grow: 1;
            padding: 0;
        }

        .remarks {
            height: 2rem;
            display: flex;
        }

        .remarkstitle {
            display: inline-block;
            width: 6rem;
            height: 2rem;
            line-height: 2rem;
        }

        .remarkscontent {
            flex-grow: 1;
        }

        .uploadtitle {
            height: 2rem;
            line-height: 2rem;
            border-bottom: 1px #d5d5d5 solid;
        }

        .uploadimg {
            width: 100%;
        }

        .uploadimg a {
            display: inline-block;
            height: 5rem;
            width: 5rem;
            border: 1px #868686 solid;
            margin: 0.5rem;
            text-decoration: none;
            font-size: 0.8rem;
            color: #a8a8a8;
            vertical-align: top;
            text-align: center;
        }

        .uploadpicture {
            display: inline-block;
            width: 1.6rem;
            margin: 0.5rem 1.7rem 0 1.7rem;
        }

        .picture_a {
            display: inline-block;
            height: 5rem;
            width: 5rem;
            line-height: 5rem;
            text-align: center;
            vertical-align: top;
        }

        .picture {
            width: auto;
            height: auto;
            max-width: 100%;
            max-height: 100%;
            vertical-align: middle;
        }

        .deletepic {
            /*height: 1rem;
            width: 1rem;*/
            float: right;
            position: relative;
            bottom: 5rem;
		    background: none;
		    border: none;
        }

        .deletepic img {
            width: 2rem;
            height: 2rem;
        }
		.placeholder{
			margin-top:3rem;
		}
		.block select{
			width:100%;
			border:none;
		}
    </style>

</head>
<body>
<div class="topbar">
    <a href="#"><img class="topbar_left" src="<%=request.getContextPath() %>/resources/customer/assets/images/top_bar/back_white.png" alt="返回"></a>
    <span class="topbar_middle">订单详情</span>
    <span class="topbar_right">&nbsp&nbsp&nbsp&nbsp&nbsp</span>
</div>

<div class="placeholder"></div>

<div class="block goodsdetails">
    <div class="goodsinfotop">
        &nbsp&nbsp产品编号:${orderItem.orderNumber }
    </div>
    <div class="goodsinfo">
        <div class="goodspic">
            <img src="${product.cover1}" alt="图片">
        </div>
        <div class="goodsdetail">
            <div class="goodstitle">
                <span class="goodstitle_span">${product.productName}</span>
            </div>
            <div class="goodsmodel">
                <span class="goodsmodel_span">型号:${product.productCode}</span>
            </div>
            <div style="height: 2rem;"></div>
            <div class="goodsprice">
                <span class="goodsprice_span">￥${orderItem.orderItemPrice }</span>
                <span class="goodsnumber_span">数量：${orderItem.orderItemNumber }</span>
            </div>
        </div>
    </div>
    <div class="service_div">
        <div class="leftbutton button_div">
            <button class="roundbutton service_button button_selected" id="return" onclick="changeService(this)">退货/退款
            </button>
        </div>
        <div class="rightbutton button_div">
            <button class="roundbutton service_button button_unselected" id="send" onclick="changeService(this)">补发配件
            </button>
        </div>
        <div style="height: 1rem; width: 100%;">

        </div>
        <div style="height: 1rem; width: 100%; background-color: #f4f4f4;">

        </div>
    </div>
</div>
<form action="">
<input type="hidden" name="afterSaleOrderItemId" value="${orderItemId }"/>
<input type="hidden" name="orderItemId" value="${orderItemId }"/>
 <input type="hidden" name="afterSaleOrderNumber" value="${orderNumber }"/>

<div class="block remarks">
    <div class="remarkstitle">
        &nbsp&nbsp售后类型
    </div>
    <select name="returnType">
    	<option value="0">--请选择--</option>
    	<option value="1">退款</option>
    	<option value="2">退货</option>
    </select>
</div>

<div class="block reason">
    <div id="reasontitle">
        退货/退款<br>原因
    </div>
    <textarea id="reasoncontent" name="afterSaleDescription">

    </textarea>
</div>

<div class="block remarks">
    <div class="remarkstitle">
        &nbsp&nbsp备注说明
    </div>
    <input class="remarkscontent" type="text" placeholder="选填">
</div>

<div class="block upload">
    <div class="uploadtitle">&nbsp&nbsp上传凭证</div>
    <div class="uploadimg">
        <a href="javascript:void(0)" onclick="addPicture()">
            <img src="<%=request.getContextPath() %>/resources/customer/assets/images/service/picture.png" alt="" class="uploadpicture">
            <br>
            <span>上传凭证</span>
            <br>
            <span>(最多三张)</span>
        </a>
		
    </div>
</div>
</form>

<div class="placeholder" style="margin-top: 0.5rem"></div>

<button class="post_button">提交</button>
</body>

<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/jweixin-1.0.0.js"></script>
<script type="text/javascript">
    var uploadImg = document.getElementsByClassName("uploadimg")[0];
    var service_button = document.getElementsByClassName(" service_button");
    var reason = document.getElementById("reasontitle");

    function addPicture() {
        var picList = document.getElementsByClassName("picture_a");
        chooseImg();
        
        <%-- if (picList.length >= 3) {
            alert("只能上传三张凭证哦");
        } else {
            
        } --%>
    }

    function reorderPic() {
        var picList = document.getElementsByClassName("picture_a");
        for (var i = 0; i < picList.length; i++) {
            picList[i].id = "pic" + ( i + 1 );
        }
    }
    
    function addPictureToDom(src){
        var picList = document.getElementsByClassName("picture_a");
    	var pictureA = document.createElement("a");
        pictureA.className = "picture_a";
        pictureA.id = "pic" + (picList.length + 1);
        pictureA.href = "javascript:void(0)";
        pictureA.setAttribute("onclick", "previewPicture(this)");
        var picImg = document.createElement("img");
        picImg.src = src;/*图片地址*/
        picImg.className = "picture";
        var deletePic = document.createElement("button");
        deletePic.className = "deletepic";
        deletePic.setAttribute("onclick", "deletePic(this, event)");
        var deleteImg = document.createElement("img");
        deleteImg.src = "<%=request.getContextPath() %>/resources/customer/assets/images/service/x.png";
        deletePic.appendChild(deleteImg);
        pictureA.appendChild(picImg);
        pictureA.appendChild(deletePic);
        uploadImg.appendChild(pictureA);
    }

    function deletePic(object, event) {
        object = object.parentNode;
        if (confirm("您确定要删除第" + object.id.substr(3) + "张图片吗？")) {
            object.parentNode.removeChild(object);
            reorderPic();
        }
        event.stopPropagation();
    }

    function changeService(object) {
        for (var i = 0; i < service_button.length; i++) {
            service_button[i].className = "roundbutton service_button button_unselected";
        }
        object.className = "roundbutton service_button button_selected";
        reason.innerHTML = object.id == "return" ? "退货/退款<br>原因" : "问题描述";
    }
    
    function previewPicture(object) {

        var picList = document.getElementsByClassName("picture_a");
        var picArray = [];
        for (var i = 0; i < picList.length; i++) {
            picArray.push(picList[i].childNodes[1].src);
        }
        console.log(picArray);

        /*wx.previewImage({
            current: object.childNodes[1].src, // 当前显示图片的http链接
            urls: [] // 需要预览的图片http链接列表
        });*/
    }
    
    $(".post_button").click(function(){
    	if($("#send").hasClass("button_selected")){
    		$("form").attr("action","<%=request.getContextPath()%>/buyer/applyAfterSale");
    		$("form").submit();
    	}else{
    		if($("select[name='returnType']").val()==0){
    			alert("请至少选择一个类型");
    		}else if($("select[name='returnType']").val()==1){
    			$("form").attr("action","<%=request.getContextPath()%>/buyer/applyRefund");
        		$("form").submit();
    		}else{
    			$("form").attr("action","<%=request.getContextPath()%>/buyer/applyReturn");
        		$("form").submit();
    		}
    	}
    });
	
	function chooseImg(obj) {
		var url=location.href.split('#')[0].replace(/&/g,"-");
		var urlStr = "<%=request.getContextPath()%>/wechat/signature?url="+url;
		alert("Before Call:"+urlStr);
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
			        debug: true,// 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
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
			    			//$(obj).find("img").attr("src",localIds);
			    			addPictureToDom(localIds);
			    			/* var img = new Image();
			    			img.src=localIds;
			    			if(img.complete){
			    				console.log(123);
			    				changeImgDisplay(img,$(obj).find("img"));
			    			}else{
			    				var $that=$(this);
			    				img.onload=function(){
			    					changeImgDisplay(img,$(obj).find("img"));
			    				}
			    			} */
			    	    }
			    	});
			    });
			}
		}); // end ajax
	}
	
	function changeImgDisplay(img,obj){
		var wid=img.width;
		var hgt=img.height;
		var width=$(".imgContent").width();
		var height=$(".imgContent").height();
		var rat=parseFloat(wid)/parseFloat(hgt);
		var ratio=parseFloat(width)/parseFloat(height);
		if(wid>=hgt&&wid>=parseFloat(width)&&hgt>=parseFloat(height)){
			obj.height(height);
		}else if(wid<hgt&&hgt>=parseFloat(height)&&wid>=parseFloat(width)){
			obj.width(width);
		}
		obj.attr("src",img.src);
	}
	
	function chooseUpload(obj,localIds){
		wx.uploadImage({
	   		 localId: localIds, // 需要上传的图片的本地ID，由chooseImage接口获得
	   		 isShowProgressTips: 1, // 默认为1，显示进度提示
	   		 success: function(res) {
	   		 	//返回图片的服务器端ID res.serverId,然后调用wxImgCallback函数进行下载图片操作
	   			$(obj).find("input[class='imgUrl']").val(res.serverId);
	   			$(obj).find("input[class='file']").remove();
	   			$(obj).find(".add").hide();
	   			$(obj).find(".cancel").show();
	   			$(obj).find("img").show();
	   		 },
	  		 fail: function(res) {      			
	  		 
	  		 }
	   	});
	}
	
	
</script>

</html>