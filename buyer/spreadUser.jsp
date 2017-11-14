<%@ page language="java" import="java.util.*,com.alphaking.constant.*,com.alphaking.model.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>金明同达灯饰</title>
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
			    	客户列表
			    	<span class="iSpan showHide <c:if test="${show==0 }">show</c:if>">
			    	<i class="iconfont rightI"><c:choose><c:when test="${show==0 }">&#xe62b;</c:when>
			    	<c:otherwise>&#xe62a;</c:otherwise></c:choose></i></span>
			    </div>
				<ul class="memFilter">
					<li><a href="javascript:sortByScore();">分数</a></li>
					<li><a href="javascript:sortByTradeTimes();">交易次数</a></li>
					<li><a href="javascript:sortByTradeMoney();">交易量</a></li>
					<!--对搜索结果去除i标签，写上关键字-->
					<li class="search"><c:choose><c:when test="${empty keyword }"><i class='iconfont'>&#xe610;</i></c:when>
								<c:otherwise>${keyword }</c:otherwise></c:choose></li>
				</ul>
				<div class="searchDiv">
					<input type="text" class="searchInput" placeholder="请输入客户昵称" value="${keyword }"/>
					<i class="iconfont" id="clear">&#xe628;</i>
				</div>
				<div class="hasClient">
					<div class="memList">
	            	
					</div>
					<p class="allMem">共<span id="allNum"></span>个客户</p>
					<div class="loading" style="visibility: visible;"><i class="iconfont">&#xe62c;</i><span id="jiazai">加载中...</span></div>        		
				</div>
	           <div class="noClient">
	            	<span><i class="iconfont">&#xe600;</i></span>
	            	<p id="spreadTipP">您还没有自己的客户哦！继续加油吧！</p>
	            	<!-- <p id="spreadTipP">没有符合条件的客户</p> -->
	            </div>
			</div>
            <div class="swiper-slide swiper-no-swiping infoSlider memSlider">
            <form id="clientForm">
            	<input type="hidden" name="clientInfoId"/>
            	<div class="title">
            		<span class="prevI"><i class="iconfont prevPage">&#xe624;</i></span>
            		
            		<span class="iSpan edit editInfo"><i class="iconfont rightI">&#xe602;</i></span>
            	</div>
            	<div class="imgDiv">
            		<div class="memImg">
	            		<i class="iconfont">&#xe628;</i>
	            		<!-- img的透明度为0，显示图片时要将其改为1，否则图片不显示 -->
	            		<img src="" id="clientImg"/>
	            		<input type="hidden" name="clientImg"/>
            		</div>
            		<div class="imgBottom">
            			<div>
            				<p></p>
            				<p>交易次数</p>
            			</div>
            			<div>
            				<p></p>
            				<p>交易量</p>
            			</div>
            		</div>
            	</div>
            	<div class="infoDiv">基本信息</div>
            	<table class="infoTB">
            		<tr class="writeAble">
            			<td>备注名</td>
            			<td></td>
            			<td><input type="text" value="刘美静" name="clientName"/></td>
            		</tr>
            		<tr>
            			<td>性别</td>
            			<td></td>
            			<td>
            				<input class="sex" type="radio" name="clientSex" value="1"/>女
            				<input class="sex" type="radio" name="clientSex" value="0"/>男
            			</td>
            		</tr>
            		<tr class="writeAble">
            			<td>年龄</td>
            			<td></td>
            			<td><input type="text"  name="clientAge"/></td>
            		</tr>
            	</table>
            	<div class="infoDiv">联系方式</div>
            	<table class="infoTB">
            		<tr class="writeAble">
            			<td>手机号码</td>
            			<td></td>
            			<td><input type="text"  name="clientCellphoneNumber"/></td>
            		</tr>
            		<tr class="writeAble">
            			<td>电话号码</td>
            			<td></td>
            			<td><input type="text" name="clientPhoneNumber"/></td>
            		</tr>
            		<tr class="writeAble">
            			<td>QQ</td>
            			<td></td>
            			<td><input type="text" name="clientQq"/></td>
            		</tr>
            		<tr class="writeAble">
            			<td>微信</td>
            			<td></td>
            			<td><input type="text" name="clientWechatNumber"/></td>
            		</tr>
            		<tr>
            			<td>住址</td>
            			<td></td>
            			<td>
            				<select class="shortSect" name="clientProvinceId" onchange="queryCity(this.value)">
            					<c:forEach items="${provinceList }" var="province">
            						<option value="${province.addressId }">${province.addressName }</option>
            					</c:forEach>
            				</select>
            				<select class="shortSect" name="clientCityId" onchange="queryArea(this.value)">
            				</select>
            				<select class="shortSect" name="clientAreaId">
            				</select>
            				<input type="text" name="clientAddressDetail"/>
            			</td>
            		</tr>
            	</table>
            	<div class="infoDiv">价值评判</div>
            	<table class="infoTB">
            		<tr>
            			<td>价值分数</td>
            			<td></td>
            			<td>
							<select class="longSect" name="clientScore">
								<option></option>
            					<option>1</option>
            					<option>2</option>
            					<option>3</option>
            					<option>4</option>
            					<option>5</option>
            					<option>6</option>
            					<option>7</option>
            					<option>8</option>
            					<option>9</option>
            					<option>10</option>
            				</select>
						</td>
            		</tr>
            		<tr class="writeAble">
            			<td>说明</td>
            			<td></td>
            			<td>
							<textarea rows="3" name="clientDescription"></textarea>
						</td>
            		</tr>
            	</table>
            </form>
            <button class="submit">保　存</button>
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
	<p><c:choose><c:when test="${show==0 }">确定删除？</c:when><c:otherwise>确定还原?</c:otherwise></c:choose></p>
	<div class="confirmBottom">
		<span id="cancel">取消</span>
		<span id="confirm">确定</span>
	</div>
</div>
<!-- 结束确认框 -->
<jsp:include page="/jsp/buyer/footer.jsp"></jsp:include>
<!--底部]]-->
<script>
	var offset=0;
	var canLoad=true;
	var noDate=false;
	var load=$(".loading");
	$(function(){
		var wiwH=$(window).height();
		var time;
		loadList();
		$(".memSlider").scroll(function(){
			if(load.offset().top - $(window).scrollTop()<wiwH){
				if(canLoad&&!noDate){
    				load.css("visibility","visible");
					canLoad=false;
					loadList();
				}
				if(noDate){
    				load.html("暂无更多数据");
    				load.css("visibility","visible");
				}
			}else{
				window.clearTimeout(time);
				$("#jiazai").html("加载中...");
				load.css("visibility","hidden");
				$(".loading>i").css({
						"animation-play-state":"running",
					"-webkit-animation-play-state":"running"
				});
			}
		})
	});
	
	//读取用户列表
	function loadList(){
		var url;
		url="<%=request.getContextPath()%>/buyer/spreadUserListMore?offset="+offset+
				"&keyword=${keyword}";
		
		var data={show:${show}};
		doAjax("GET",url,data,success,error,true,false);
	} 
	
	function success(data){
		var list =data.data.list;
		var html="";
		for(var i=0;i<list.length;i++){
			html+='<div class="member" data-id="'+list[i].clientInfoId+'">';
			html+='<img src="'+list[i].clientImg+'"/>';	
			html+='<div class="leftDiv">';
			html+='<span class="memName"><span>'+list[i].clientName+'</span><i class="iconfont '+((list[i].clientRole==5)?'business':'sale')+'">&#xe61a;</i></span>';
			html+='<span class="memPhone">'+((list[i].clientCellphoneNumber==null)?'':list[i].clientCellphoneNumber)+''
				+((list[i].salesmanName==null)?'':('('+list[i].salesmanName+')'))+'</span>';
			html+='</div>';
			html+='<span class="toSpan"><i class="iconfont goToDetail">&#xe624;</i></span>';
			html+='<div class="rightDiv">';
			html+='<span class="memNum">'+list[i].clientTradeTimes+'/'+list[i].clientTradeMoney+'</span>';
			if(list[i].clientScore!=null)
				html+='<span class="memScore">【'+list[i].clientScore+'】</span>';
			else
				html+='<span class="memScore" style="display:none">【'+0+'】</span>';	
			html+='</div></div>';
		}
		$(".memList").append(html);
		load.css("visibility","hidden");
		if(parseInt(offset+10)>=data.data.count){
			noDate=true;
		}
		$("#allNum").html(data.data.count);
		
		offset=data.data.after;
		canLoad=true;
		
		if(data.data.count==0){
			$(".noClient").show();
			if(${empty keyword}){
				$("#spreadTipP").html("您还没有自己的客户哦！继续加油吧！");
			}else{
				$("#spreadTipP").html("没有符合条件的客户");
			}
			$(".allMem").hide();
		}
	}
	
	function error(){
		alert("error");
	}
	

	//读取某个客户信息
	function getClientInfo(id){
		var url="<%=request.getContextPath()%>/buyer/getClientInfo";
		var params={clientInfoId:id};
		doAjax("GET",url,params,getSuccess,error,true,false);
	}
	
	function getSuccess(data){
		var ci=data.data;
		$("input[name='clientInfoId']").val(ci.clientInfoId);
		$("#clientForm .title").html('<span class="prevI"><i class="iconfont prevPage">&#xe624;</i></span><span class="titleName">'+ci.clientName+'</span><span class="iSpan edit editInfo"><i class="iconfont rightI">&#xe602;</i></span>');
		$("input[name='clientImg']").val(ci.clientImg);
		$("input[name='clientImg']").prev().attr("src",ci.clientImg);
		$("input[name='clientImg']").prev().css("opacity",1);
		$(".imgBottom div:nth-child(1) p:nth-child(1)").html(ci.clientTradeTimes);
		$(".imgBottom div:nth-child(2) p:nth-child(1)").html(ci.clientTradeMoney);
		$("input[name='clientName']").val(ci.clientName);
		$("input[name='clientName']").parent().prev().html(ci.clientName);
		$("input[name='clientSex'][value='"+ci.clientSex+"']").attr("checked","checked");
		$("input[name='clientSex']").parent().prev().html((ci.clientSex==null)?"":((ci.clientSex==1)?"女":"男"));
		$("input[name='clientAge']").val(ci.clientAge);
		$("input[name='clientAge']").parent().prev().html(ci.clientAge);
		$("input[name='clientCellphoneNumber']").val(ci.clientCellphoneNumber);
		$("input[name='clientCellphoneNumber']").parent().prev().html(ci.clientCellphoneNumber);
		$("input[name='clientPhoneNumber']").val(ci.clientPhoneNumber);
		$("input[name='clientPhoneNumber']").parent().prev().html(ci.clientPhoneNumber);
		$("input[name='clientQq']").val(ci.clientQq);
		$("input[name='clientQq']").parent().prev().html(ci.clientQq);
		$("input[name='clientWechatNumber']").val(ci.clientWechatNumber);
		$("input[name='clientWechatNumber']").parent().prev().html(ci.clientWechatNumber);
		$("select[name='clientProvinceId']").val(ci.clientProvinceId);
		queryCity(ci.clientProvinceId);
		$("select[name='clientCityId']").val(ci.clientCityId);
		queryArea(ci.clientCityId);
		$("select[name='clientAreaId']").val(ci.clientAreaId);
		$("input[name='clientAddressDetail']").val(ci.clientAddressDetail);
		if(ci.clientProvince!=null)
			$("select[name='clientProvinceId']").parent().prev().html(ci.clientProvince+ci.clientCity
				+ci.clientArea+ci.clientAddressDetail);
		
		$("select[name='clientScore']").val(ci.clientScore);
		$("select[name='clientScore']").parent().prev().html(ci.clientScore);
		$("textArea[name='clientDescription']").val(ci.clientDescription);
		$("textArea[name='clientDescription']").parent().prev().html(ci.clientDescription);
	}
	
	//保存信息
	function saveClientInfo(){
		var url="<%=request.getContextPath()%>/buyer/updateClientInfo";
		var params=$("#clientForm").serialize();
		doAjax("GET",url,params,saveSuccess,fail,true,false);
	}
	
	function saveSuccess(data){
		var ci =data.data;
		var member=$(".member[data-id='"+ci.clientInfoId+"']");
		var name=member.find(".memName").html();
		var index=name.indexOf("<i");
		name=ci.clientName+name.substring(index);
		member.find("img").attr("src",$("#clientImg").attr("src"));
		member.find(".memName").html(name);
		member.find(".memPhone").html(ci.clientCellphoneNumber);
		if(ci.clientScore!=null){
			member.find(".memScore").html("【"+ci.clientScore+"】");
			member.find(".memScore").show();
		}else{
			member.find(".memScore").hide();
		}
		$(".writeAble").each(function(){
			$(this).find("td:nth-child(2)").html($(this).find("td:nth-child(3) input").val());
		});
		var sex = $("input[name='clientSex']:checked").val();
		$("input[name='clientSex']").parent().prev().html(sex==undefined?"":(sex==1?"女":"男"));
		if(ci.clientProvince!=null)
			$("select[name='clientProvinceId']").parent().prev().html(ci.clientProvince+ci.clientCity
				+ci.clientArea+ci.clientAddressDetail);
		$("select[name='clientScore']").parent().prev().html($("select[name='clientScore']").val());
		$("textArea[name='clientDescription']").parent().prev().html($("textArea[name='clientDescription']").val());
	}

	var data_id=0;
	function deleteClientInfo(){
		var url="<%=request.getContextPath()%>/buyer/deleteClientInfo";
		var params={clientInfoId:data_id};
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
		if($(this).hasClass("show")){
			//显示被删除的客户
			//进行页面跳转，以下三行几乎没用
			window.location.href='<%=request.getContextPath()%>/buyer/spreadUserList?show=1';
			$(this).find("i").html("&#xe62a;");
			$(this).removeClass("show");
			$("#delete").find("p").html("确定还原？");
		}else{
			//隐藏被删除的客户
			//进行页面跳转，以下三行几乎没用
			window.location.href='<%=request.getContextPath()%>/buyer/spreadUserList?show=0';
			$(this).find("i").html("&#xe62b;");
			$(this).addClass("show");
			$("#delete").find("p").html("确定删除？");
		}
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