<%@ page language="java" import="java.util.*,com.alphaking.constant.*,com.alphaking.model.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>佐为照明</title>
    <meta name="format-detection" content="telephone=no">
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/common/swiper.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/customer/assets/css/classify.css?88" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
</head>
<body>
<c:set var="CUSTOMER" value="<%=UserType.CUSTOMER%>" />
<c:set var="AGENCY" value="<%=UserType.AGENCY%>" />
<c:set var="FACILITATOR" value="<%=UserType.FACILITATOR%>" />
<div class="spreadMember">
	<div class="swiper-container memContainer">
        <div class="swiper-wrapper">
            <div class="swiper-slide swiper-no-swiping memSlider">
			    <div class="title">
			    	团队成员
			    </div>
				
				<div class="searchDiv">
					<input type="text" class="searchInput" placeholder="请输入客户昵称" value="${keyword}"/>
					<i class="iconfont" id="clear">&#xe628;</i>
				</div>
				<div class="hasClient">
					<div class="memList">
						<c:forEach items="${staffList}" var="staff" varStatus="i">
		            		<div class="member" data-id="${staff.userId }">
		            			<img src="${staff.userProtraitPic}">
		            			<div class="leftDiv">
		            				<span class="memName">
		            					<span>${staff.userNickname}</span><i class="iconfont sale"></i>
		            				</span>
		            			</div>
		            			<div class="rightDiv">
		            				${customerList[i.index]}客户
		            			</div>
		            			<!-- <span class="toSpan"><i class="iconfont goToDetail"></i></span>
		            			<div class="rightDiv">
		            				<span class="memNum">0/0</span><span class="memScore" style="display:none">【0】</span>
		            			</div> -->
		            		</div>
	            		</c:forEach>
					</div>
					<!--<p class="allMem">共<span id="allNum"></span>个客户</p>
					 <div class="loading" style="visibility: visible;"><i class="iconfont">&#xe62c;</i><span id="jiazai">加载中...</span></div>        		 -->
				</div>
				<ul class="memFilter" style="margin-top:10px;"><!-- 
					<li><a href="javascript:sortByScore();">分数</a></li>
					<li><a href="javascript:sortByTradeTimes();">交易次数</a></li>
					<li><a href="javascript:sortByTradeMoney();">交易量</a></li> --> 
					<!--对搜索结果去除i标签，写上关键字-->
					<%-- 
					<li class="search"><c:choose><c:when test="${empty keyword }"><i class='iconfont'>&#xe610;</i></c:when>
								<c:otherwise>${keyword }</c:otherwise></c:choose></li> --%>
					<li style="width:100%;background-color:#F00;color:#FFF;" id="addStaff"><span>添加成员</span></li>
				</ul>
	           <div class="noClient">
	            	<span><i class="iconfont">&#xe600;</i></span>
	            	<p id="spreadTipP">您还没有自己的客户哦！继续加油吧！</p>
	            	<!-- <p id="spreadTipP">没有符合条件的客户</p> -->
	            </div>
			</div>
         </div>
    </div>
</div>
<!-- 开始确认框 -->
<div class="confirmDiv" id="delete">
	<div class="confirmTop">
		<span>温馨提醒</span>
		<span id="closeConfirm"><i class="iconfont">&#xe632;</i></span>
	</div>
	<p>确定删除？</p>
	<div class="confirmBottom">
		<span id="cancel">取消</span>
		<span id="confirm">确定</span>
	</div>
</div>
<!-- 结束确认框 -->
<jsp:include page="/jsp/buyer/footer.jsp"></jsp:include>
<!--底部]]-->
<script>
	$("#addStaff").tap(function(){
		window.location.href="<%=request.getContextPath()%>/buyer/toAddStaff";
	})

	var data_id=0;
	function deleteClientInfo(){
		var url="<%=request.getContextPath()%>/buyer/deleteStaff";
		var params={userId:data_id};
		doAjax("GET",url,params,deleteSuccess,fail,true,false);
	}
	
	function deleteSuccess(data){
		var ci=data.data;
	}
	
	function showClientInfo(){
		var url="<%=request.getContextPath()%>/buyer/showClientInfo";
		var params={clientInfoId:data_id};
		doAjax("GET",url,params,showSuccess,fail,true,false);
	}
	
	function showSuccess(data){
		var ci=data.data;
	}
	
	var swiper = new Swiper('.memContainer',{
		noSwiping : true,
	});
	$(".memSlider").css("height",$(window).height());
	
	$(document).on("tap",".member",function(e){
		if(!$(e.target).closest(".memPhone").length!=0){
			swiper.slideNext();
			getClientInfo($(this).attr("data-id"));
			$(".infoTB tr td:nth-child(3)").css("display","none");
			$(".infoTB tr td:nth-child(2)").css("display","block");
			$(".submit").css("display","none");
			$(".edit").find("i").html("&#xe602;");
			$(".edit").addClass("editInfo");
		}
	});
	
	$(document).on("longTap",".member",function(){
		$("#delete").show();
		$(".shade").show();
		data_id=$(this).attr("data-id");
	});
	
	$("#confirm").tap(function(){
		if($("#delete").find("p").html()=="确定删除？"){
			/* 用ajax将此数据变为不可见 */
			deleteClientInfo();
			$("#allNum").html(parseInt($("#allNum").html())-1);
		}else{
			/* 用ajax将此数据变为可见 */
			showClientInfo();
			$("#allNum").html(parseInt($("#allNum").html())+1);
		}
		$(".member[data-id='"+data_id+"']").remove();
		$("#delete").hide();
		$(".shade").hide();
	});
	
	$(".shade").tap(function(){
		$("#delete").hide();
		$(this).hide();
	});
	$("#closeConfirm").tap(function(){
		$("#delete").hide();
		$(".shade").hide();
	});
	$("#cancel").tap(function(){
		$("#delete").hide();
		$(".shade").hide();
	});
	
	$(document).on("tap",".prevI",function(){
		swiper.slidePrev();
	});
	
	$(document).on("tap",".edit",function(){
		if($(this).hasClass("editInfo")){
			//编辑信息
			$(this).find("i").html("&#xe629;");
			$(this).removeClass("editInfo");
			$(".infoTB tr td:nth-child(2)").css("display","none");
			$(".infoTB tr td:nth-child(3)").css("display","block");
			$(".submit").css("display","block");
		}else{
			//保存信息
			saveClientInfo();
			$(this).find("i").html("&#xe602;");
			$(this).addClass("editInfo");
			$(".infoTB tr td:nth-child(3)").css("display","none");
			$(".infoTB tr td:nth-child(2)").css("display","block");
			$(".submit").css("display","none");
		}
	});
	$(".submit").tap(function(){
		saveClientInfo();
		$(".infoTB tr td:nth-child(3)").css("display","none");
		$(".infoTB tr td:nth-child(2)").css("display","block");
		$(this).css("display","none");
		$(".edit").find("i").html("&#xe602;");
		$(".edit").addClass("editInfo");
	});
	$(".showHide").tap(function(){
		//隐藏被删除的客户
		//进行页面跳转，以下三行几乎没用
		$(this).find("i").html("&#xe62b;");
		$(this).addClass("show");
		$("#delete").find("p").html("确定删除？");
		
	});
	$(".search").tap(function(){
		if($(".searchDiv").css("left")!="0px"){
			if($(this).html().split("<i class=").length==1){
				$(".searchInput").val($(this).html().trim());
				$(this).html("<i class='iconfont'>&#xe610;</i>");
			}
			$(".searchDiv").css("left","0px");
		}else{
			//向后台提交搜索关键字
			if($(".searchInput").val()!="")
				$(this).html($(".searchInput").val());
			window.location.href="<%=request.getContextPath()%>/buyer/spreadUserList?show=${show}"
					+"&keyword="+$(".searchInput").val();
			$(".searchDiv").css("left","-84%");
		}
	});
	$("#clear").tap(function(){
		$(".searchInput").val("");
	});
	$(".searchDiv").css("height",$(".search").height());
	
	function queryCity(addressId){
		var url="<%=request.getContextPath()%>/address/queryAddress";
		var params={upAddressId:addressId};
		doAjax("GET",url,params,queryCitySuccess,fail,false,false);
	}
	
	function queryCitySuccess(data){
		var option="";
		for(var i=0;i<data.length;i++){
			option+="<option value='"+data[i].addressId+"'>"+data[i].addressName+"</option>";
		}
		$("select[name='clientCityId']").html(option);
		queryArea(data[0].addressId);
	}
	
	function queryArea(addressId){
		var url="<%=request.getContextPath()%>/address/queryAddress";
		var params={upAddressId:addressId};
		doAjax("GET",url,params,queryAreaSuccess,fail,false,false);
	}
	
	function queryAreaSuccess(data){
		var option="";
		for(var i=0;i<data.length;i++){
			option+="<option value='"+data[i].addressId+"'>"+data[i].addressName+"</option>";
		}
		$("select[name='clientAreaId']").html(option);
	}
	
	function fail(){
		alert("fail");
	}
	
	function sortByScore(){
		var memberList = $(".member");
		for(var i=0;i<memberList.size();i++){
			for(var j=memberList.size()-1;j>i;j--){
				if(parseInt($(".member").eq(j).find(".memScore").html().match(/\d+(\.\d+)?/g))>parseInt($(".member").eq(j-1).find(".memScore").html().match(/\d+(\.\d+)?/g))){					
					$(".member").eq(j).insertBefore($(".member").eq(j-1));
				}
			}
		} 
		
	}
	
	function sortByTradeTimes(){
		var memberList = $(".member");
		for(var i=0;i<memberList.size();i++){
			for(var j=memberList.size()-1;j>i;j--){
				var a=$(".member").eq(j).find(".memNum").html();
				var b=$(".member").eq(j-1).find(".memNum").html();
				a=a.substring(0,a.indexOf("/"));
				b=b.substring(0,b.indexOf("/"));
				if(parseInt(a)>parseInt(b)){					
					$(".member").eq(j).insertBefore($(".member").eq(j-1));
				}
			}
		} 
	}
	
	function sortByTradeMoney(){
		var memberList = $(".member");
		for(var i=0;i<memberList.size();i++){
			for(var j=memberList.size()-1;j>i;j--){
				var a=$(".member").eq(j).find(".memNum").html();
				var b=$(".member").eq(j-1).find(".memNum").html();
				a=a.substring(a.indexOf("/")+1);
				b=b.substring(b.indexOf("/")+1);
				if(parseFloat(a)>parseFloat(b)){					
					$(".member").eq(j).insertBefore($(".member").eq(j-1));
				}
			}
		} 
	}
	
	function chooseImg(obj) {
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
							
			    			$(obj).attr("src",localIds);
			    			
			    	    }
			    	});
			    });
			}
		}); // end ajax
	}
	
	function chooseUpload(obj,localIds){
		wx.uploadImage({
	   		 localId: localIds, // 需要上传的图片的本地ID，由chooseImage接口获得
	   		 isShowProgressTips: 1, // 默认为1，显示进度提示
	   		 success: function(res) {
	   		 	//返回图片的服务器端ID res.serverId,然后调用wxImgCallback函数进行下载图片操作
	   			$("input[name='clientImg']").val(res.serverId);
	   		 	
	   		 },
	  		 fail: function(res) {      			
	  		 
	  		 }
	   	});
	}
	
	$("#clientImg").tap(function(){
		if(!$(".iSpan ").hasClass("editInfo")){
			$(".waiting").show();
			$(".shade").show();
			chooseImg(this);
		}
	});
</script>
</body>
</html>