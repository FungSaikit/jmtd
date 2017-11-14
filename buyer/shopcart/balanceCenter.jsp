<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib prefix="thumbnail" uri="/WEB-INF/tld/thumbnailTag.tld"%>
<%@ taglib prefix="ppt" uri="/WEB-INF/tld/productPriceTag.tld"%>

<!DOCTYPE html>
<html class="balanceHtml">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>金明同达灯饰</title>
    <link href="<%=request.getContextPath() %>/resources/common/swiper.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/customer/assets/css/orderCart.css?1221" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
</head>
<body class="balanceBody">
<c:set var="SALES_SORT" value="<%=ProductSortType.SALES_SORT%>" />
<c:set var="NEW_SORT" value="<%=ProductSortType.NEW_SORT%>" />
<c:set var="PRICE_SORT" value="<%=ProductSortType.PRICE_SORT%>" />
<c:set var="CUSTOMER" value="<%=UserType.CUSTOMER%>" />
<c:set var="RETAIL_SALES" value="<%=UserType.RETAIL_SALES%>" /> 
<c:set var="AUTHENTICATION_SUCCESS" value="<%=UserCheckStatus.AUTHENTICATION_SUCCESS%>" />
<div class="balance">
	<div class="swiper-container payContainer">
        <div class="swiper-wrapper">
            <div class="swiper-slide swiper-no-swiping paySlider" data-hash="slide1">
				<div class="title" id="title"><i class="iconfont prevPage payPrev" >&#xe63f;</i>填写订单</div>
				<div class="payOrder">
					<div class="payAddress" <c:if test="${empty receiveAddress }">style="display:none"</c:if>>
						<div class="left"><i class="iconfont">&#xe608;</i></div>
						<div class="middle">
							<div class="namePhone">
								<span class="name">收货人：${receiveAddress.receiveAddress.receivePerson}</span>
								<span class="phone">${receiveAddress.receiveAddress.contactNumber}</span>
							</div>
							<div class="address" data-id="${receiveAddress.receiveAddress.receiveAddressId }">收货地址：
								<span class="province">${receiveAddress.province}</span>
								<span class="city">${receiveAddress.city}</span>
								<span class="area">${receiveAddress.area}</span>
								<span class="addressDetail">${receiveAddress.receiveAddress.addressDetail }</span>
							</div>
						</div>
						<div class="right"><i class="iconfont">&#xe624;</i></div>
					</div>
					<!-- 开始没有收货地址 -->
					<div class="noAddress" <c:if test="${!empty receiveAddress}">style="display:none"</c:if>>
						<div><i class="iconfont">&#xe639;</i></div>
						<p>您还没有收货地址，<a href="javascript:void(0);">去添加</a></p>
					</div>
					<!-- 结束没有收货地址 -->
					<input type="hidden" name="isInstall" value="0"/>
					<input type="hidden" name="transportType" value="0"/>
			    	<div class="allOrder">
			    		
			    		<div class="shopOrder">
				    		<div class="shopName">
				    			订单
					    		<%-- <a href="<%=request.getContextPath()%>/product/shopProductList?shopId=${shopcart.seller.userId}">
					    			<span><i class="iconfont">&#xe606;</i></span>
					    		</a> --%>
					    		<!-- <i class="iconfont show">&#xe624;</i> -->
					    	</div>
					    	<c:forEach items="${shopcartList}" var="shopcart">
					    	<c:forEach items="${shopcart.shopcartItemList}" var="shopcartItem">
				    		<div class="commodity" data-installPrice="${shopcartItem.product.installPrice*shopcartItem.shopcartItem.productNumber}"
				    			data-money="<ppt:date percent="${percent}" role="${(user.role==CUSTOMER||user.role==RETAIL_SALES||user.checkStatus!=AUTHENTICATION_SUCCESS)}" 
    					productPrice="${(user.role==CUSTOMER||user.role==RETAIL_SALES||user.checkStatus!=AUTHENTICATION_SUCCESS)?shopcartItem.product.retailPrice:(shopcartItem.product.unitPrice+shopcartItem.product.woodenFee)}" productNumber="${shopcartItem.shopcartItem.productNumber}" productOriginPrice="${shopcartItem.product.unitPrice }"></ppt:date>">
				    			<img src="<thumbnail:date value="${shopcartItem.product.cover1}"/>"/>
				    			<div class="commDiv">
				    				<p><a href="<%=request.getContextPath()%>/product/productDetail?productId=${shopcartItem.product.productId}">${shopcartItem.product.productName}</a></p>
					    			<div class="moneyNum">
					    				<h4>￥<ppt:date percent="${percent}" role="${(user.role==CUSTOMER||user.role==RETAIL_SALES||user.checkStatus!=AUTHENTICATION_SUCCESS)}" 
    					productPrice="${(user.role==CUSTOMER||user.role==RETAIL_SALES||user.checkStatus!=AUTHENTICATION_SUCCESS)?shopcartItem.product.retailPrice:(shopcartItem.product.unitPrice+shopcartItem.product.woodenFee)}" productNumber="1" productOriginPrice="${shopcartItem.product.unitPrice }"></ppt:date></h4>
					    				<span><font>X</font>${shopcartItem.shopcartItem.productNumber}</span>
					    			</div>
				    			</div>
				    		</div>
				    		</c:forEach>
				    	</c:forEach>
				    	</div>
			    	</div>
			    	<%-- <c:if test="${user.role==CUSTOMER||user.checkStatus!=AUTHENTICATION_SUCCESS }">
			    	 --%>
			    	<div class="ps">
			    		<div class="RemmLogistics">
			    			<label for="logisticsInput">备注信息：</label>
			    			<select id="logisticsSelect" <c:if test="${logisticsList.size()==0 }">style="display:none"</c:if>>
			    				<c:forEach items="${logisticsList}" var="logistics">
			    					<option value="${logistics.userLogisticsId }">${logistics.logisticsCompanyName }</option>
			    				</c:forEach>
			    				<option value="0">其他</option>
			    			</select>
			    			<input type="text" name="suggestLogistics" id="logisticsInput" <c:if test="${logisticsList.size()==0 }">style="display:block"</c:if> placeHolder="请输入发货物流公司">
			    		</div>
			    		<div class="RemmLogistics">
			    			<input type="text" name="orderRemark" style="display:block" placeHolder="其他备注信息">
			    		</div>
			    		
			    	</div>
				</div>
			</div>
			<div class="swiper-slide swiper-no-swiping addressSlider" data-hash="slide2">
				<div class="title"><i class="iconfont prevPage normalPrev">&#xe63f;</i>管理收货地址</div>
				<div class="addressList">
					
				</div>
				<div class="emptyAddress empty">
				    <i class="iconfont">&#xe639;</i>
				    <p>还没有添加地址哦！</p>
			    </div>
			</div>
			<div class="swiper-slide swiper-no-swiping addAddressSlider" data-hash="slide3">
				<div class="title"><i class="iconfont prevPage normalPrev" >&#xe63f;</i>
					<span id="addressTitle">新增收货地址</span></div>
				<form>
					<input type="hidden" name="receiveAddressId"/>
					<input type="hidden" name="userId"/>
					<input type="hidden" name="defaultFlag"/>
					<table class="formTable">
						<tr>
							<td>收货人</td>
							<td><input id="contactName" name="receivePerson" type="text" value="" data-name="收货人"/></td>
						</tr>
						<tr>
							<td>联系电话</td>
							<td><input type="text" name="contactNumber" value="" data-name="联系电话"/></td>
						</tr>
						<tr>
							<td>选择省份</td>
							<td>
								<select name="provinceId" onchange="queryCity(this.value)" data-name="省份">
									<option>--请选择省份--</option>
									<c:forEach items="${provinceList}" var="province">
										<option value="${province.addressId }">${province.addressName}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<td>选择市区</td>
							<td>
								<select name="cityId" onchange="queryArea(this.value)" data-name="市区">
									<option>--请选择市区--</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>选择区/县</td>
							<td>
								<select name="areaId" data-name="区/县">
									<option>--请选择区/县--</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>详细地址</td>
							<td><input type="text" name="addressDetail" value="" data-name="详细地址"/></td>
						</tr>
					</table>
					<div class="defaultAddress"><span><i class="iconfont">&#xe611;</i></span>设为默认地址</div>
				</form>
					<button class="submit">保　存</button>
					<button class="delete" data-id="1">删　除</button>
			</div>
		</div>
	</div>
</div>
<button class="addButton"><span><i class="iconfont">&#xe628;</i></span>新增收货地址</button>
<div class="orderBottom">
	<div class="allMoney">
		<span><span>￥<span id="moneySpan"></span></span></span>
	</div>
	<button class="payOrder" id="payOrderBtn">提交订单</button>
</div>
<!--[[遮罩层-->
<div class="shadow" style="display: none;"></div>
<!--遮罩层]]-->
<!-- 开始确认框 -->
<div class="confirmDiv" id="delete">
	<div class="confirmTop">
		<span>温馨提醒</span>
		<span id="closeConfirm">X</span>
	</div>
	<p>确定删除？</p>
	<div class="confirmBottom">
		<span id="cancel">取消</span>
		<span id="confirm">确定</span>
	</div>
</div>
<!-- 结束确认框 -->
<!--[[地址选择-->
<!-- <div class="balance-address">
   
</div> -->
<!--地址选择]]-->

<!--[[底部-->
<%-- <jsp:include page="/jsp/buyer/footer.jsp"></jsp:include> --%>
<!--底部]]-->
<!-- 等待加载 -->
<div class="waiting"><i class="iconfont">&#xe62c;</i></div>
<div class="payQrCode">
	<img src="${payQrCode.payQrCodePic}"/>
	<div class="payQrCodeDiv" style="background-color:#22AB38;position:fixed;width:90%;">
		<p>识别图中二维码，前往支付页面</p>
		<p>长按3秒，点击"识别图中二维码"</p>
		<p>￥<span id="moneySpan1"></span></p>
		<p>支付完成后，点击按钮</p>
		<button class="paySuccess">已完成支付</button>
	</div>
</div>
<div class="shade"></div>
<div class="tip"></div>
<input type="hidden" id="lujing" value="<%=request.getContextPath()%>">
<!-- 等待加载 -->
<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/swiper.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/jweixin-1.0.0.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/count.js"></script>
<script>
	
	var swiper = new Swiper('.payContainer',{
		noSwiping : true,
		hashnav:true,
	});
	$("#title").tap(function(){
		history.go(-1);
	});
	window.onhashchange=function(){
		if(location.hash=="#slide1"){
			$(".addButton").hide();
			$(".orderBottom").show();
		}
		if(location.hash=="#slide2"){
			$(".orderBottom").hide();
			$(".addButton").show();
		}
		swiper.slideTo(location.hash.substr(6)-1);
	}
	//开始结算页面
	$(".install").tap(function(){
		if($(this).find(".check").hasClass("active")){
			$(this).find(".check").removeClass("active");
			$("input[name='isInstall']").val("0");
			$("#moneySpan").html(parseFloat($("#moneySpan").html())-parseFloat($("#installMoney").html()));
		}else{
			$(this).find(".check").addClass("active");
			$("input[name='isInstall']").val("1");
			$("#moneySpan").html(parseFloat($("#moneySpan").html())+parseFloat($("#installMoney").html()));
		}
	});
	$(".delivery").tap(function(){
		if($(this).find(".check").hasClass("active")){
			$(this).find(".check").removeClass("active");
			$("input[name='transportType']").val(0);
		}else{
			$(this).find(".check").addClass("active");
			$("input[name='transportType']").val(1);
		}
	});
	$(document).on("tap",".shopName",function(e){
		if(!$(e.target).closest("a").length!=0){
			if($(this).find(".show").hasClass("rotate")){
				$(this).find(".show").removeClass("rotate");
				$(this).parent().find(".commodity").css("display","block");
			}else{
				$(this).find(".show").addClass("rotate");
				$(this).parent().find(".commodity").css("display","none");
			}
		}
	});
	$(".payAddress").tap(function(){
    	$(".addButton").show();
    	$(".orderButtom").hide();
		swiper.slideNext();
		queryReceiveAddress();
	});
	//结束结算页面
	//开始地址管理
	function textAddress(){
		if($(".oneAddress").length==0){
			$(".addressList").hide();
			$(".emptyAddress").show();
			$(".balanceBody").css("background-color","#fff");
		}else{
			$(".addressList").show();
			$(".emptyAddress").hide();
			$(".balanceBody").css("background-color","#f3f3f3");
		}
	}
	textAddress();
	
	$(document).on("tap",".addressList .check",function(){
		//ajax设置默认地址
		$(".check").removeClass("active");
		$(this).addClass("active");
		setDefault($(this).parents(".oneAddress").attr("data-id"));
	});
	
	var data_id;
	$(document).on("tap",".delIcon",function(){
		data_id=$(this).parent().parent().attr("data-id");
		$("#delete").show();
		$(".shadow").show();
	});
	$("#confirm").tap(function(){
		/* 用ajax将此数据删除*/
		deleteAddress();
	});
	$(".shadow").tap(function(){
		$("#delete").hide();
		$(this).hide();
	});
	$("#closeConfirm").tap(function(){
		$("#delete").hide();
		$(".shadow").hide();
	});
	$("#cancel").tap(function(){
		$("#delete").hide();
		$(".shadow").hide();
	});
	
	$(".addButton").tap(function(){
		$(this).hide();
		$("orderButton").hide();
		swiper.slideNext();
		$("#addressTitle").html("添加收货地址");
		$(".addAddressSlider input,.addAddressSlider select").each(function(){
			$(this).val("");
		});
		$("select[name='cityId']").html("");
		$("select[name='areaId']").html("");
		$(".defaultAddress").show();
	});
	$(document).on("tap",".editIcon",function(){
		$(".delete").css("display","block");
		$(".addButton").hide();
		$(".orderBottom").hide();
		swiper.slideNext();
		$("#addressTitle").html("修改收货地址");
		getReceiveAddress($(this).parents(".oneAddress").attr("data-id"));
	});
	//结束地址管理
	//开始添加地址
	$(".normalPrev").tap(function(){
		$(".delete").css("display","none");
		swiper.slidePrev();
		if(swiper.activeIndex==0){
			$(".addButton").hide();
			$(".orderBottom").show();
			querySingleAddress();
		}
		if(swiper.activeIndex==1){
			$(".addButton").show();
			$(".orderBottom").hide();
		}
	});
	$(".defaultAddress").tap(function(){
		if($(this).hasClass("active")){
			$(this).removeClass("active");
		}else{
			$(this).addClass("active");
		}
	});
	$(".delete").tap(function(){
		data_id=$("input[name='receiveAddressId']").val();
		$("#delete").show();
		$(".shadow").show();
		
	});
	//结束添加地址
	
	$("#payOrderBtn").tap(function(){
		<%-- if($(".middle .address").attr("data-id")==undefined||$(".middle .address").attr("data-id")=="")
			showTip("请填写收货地址");
		else{
			if(${(user.role==4||use.role==6)&&user.checkStatus==3}){
    			if($("input[name='suggestLogistics']").val().trim()==""&&$("input[name='transportType']").val()=="0"&&$("#logisticsSelect").val()=="0")
    				showTip("请填写你需要的物流公司");
    			else{
    				var url="<%=request.getContextPath()%>/buyer/placeOrder?shopcartIdList=${shopcartIdList}";
    				var params={receiveAddressId:$(".middle .address").attr("data-id")
    							,isInstall:$("input[name='isInstall']").val(),isImmediately:${isImmediately}
    							,transportType:$("input[name='transportType']").val()
    							,suggestLogistics:$("input[name='suggestLogistics']").val()
								,logisticsSelect:$("#logisticsSelect").val()
								,orderRemark:$("input[name='orderRemark']").val()};//
    				doAjax("GET",url,params,orderSuccess,fail,false,false);
    			}
    		}else{
				var url="<%=request.getContextPath()%>/buyer/placeOrder?shopcartIdList=${shopcartIdList}";
				var params={receiveAddressId:$(".middle .address").attr("data-id")
							,isInstall:$("input[name='isInstall']").val(),isImmediately:${isImmediately}
							,transportType:$("input[name='transportType']").val()
							,suggestLogistics:$("input[name='suggestLogistics']").val()
							,logisticsSelect:$("#logisticsSelect").val()
							,orderRemark:$("input[name='orderRemark']").val()};//
				doAjax("GET",url,params,orderSuccess,fail,false,false);
    		}
		} --%>
		alert("支付功能暂时没有开放");
	});
	
	var orderNumbers;
	function orderSuccess(data){
		$(".shade").show();
		$(".payQrCode").show();
		$(".payQrCodeDiv").css("left",$(".payQrCode img").position().left);
		$(".payQrCodeDiv").css("top",$(".payQrCode img").position().top+$(".payQrCode img").height()*0.7);
		orderNumbers=data.data;
	}
	
	function placeOrderSuccess(data){
		var url=location.href.split('#')[0].replace(/&/g,"-");
		var urlStr = "<%=request.getContextPath()%>/wechat/signature?url="+url;
		//alert("Before Call:"+urlStr);
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
			        jsApiList: ['chooseWXPay'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
			    });
			    wx.ready(function(){

					$(".waiting").hide();
					$(".shade").hide();
			        // config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
			        wx.chooseWXPay({
			            timestamp: data.timestamp, // 支付签名时间戳，注意微信jssdk中的所有使用timestamp字段均为小写。但最新版的支付后台生成签名使用的timeStamp字段名需大写其中的S字符
			            nonceStr:data.nonceStr, // 支付签名随机串，不长于 32 位
			            package: data.Package, // 统一支付接口返回的prepay_id参数值，提交格式如：prepay_id=***）
			            signType: "MD5", // 签名方式，默认为'SHA1'，使用新版支付需传入'MD5'
			            paySign: data.paySign, // 支付签名
			            complete: function (res) {
			                // 支付成功后的回调函数
			            	if(res.errMsg=="chxooseWXPay:fail")
			                	window.location.href="<%=request.getContextPath()%>/buyer/orderManage";
			                if(res.errMsg=="chooseWXPay:cancel")
			                	window.location.href="<%=request.getContextPath()%>/buyer/orderManage?orderStatus=0";
				            if(res.errMsg=="chooseWXPay:ok")
			                	window.location.href="<%=request.getContextPath()%>/buyer/orderManage?orderStatus=1";
			            }
			        }); 
			    });
			}
		}); // end ajax   
	}
	
	$(document).on("tap",".addressTop",function(){
		$(".middle .name").html("收货人："+$(this).find(".name").html());
		$(".middle .phone").html($(this).find(".phone").html());
		$(".middle .province").html($(this).find(".province").html());
		$(".middle .city").html($(this).find(".city").html());
		$(".middle .area").html($(this).find(".area").html());
		$(".middle .addressDetail").html($(this).find(".addressDetail").html());
		$(".middle .address").attr("data-id",$(this).parent().attr("data-id"));
		$(".payAddress").show();
		$(".noAddress").hide();
		swiper.slidePrev();
		$(".addButton").hide();
		$(".orderBottom").show();
	});
	
	function checkForm(){
		var flag=true;
		$(".formTable input,.formTable select").each(function(){
			if($(this).attr("name")!="addressDetail"){
				if($(this).val()==""||$(this).val()=="--请选择省份--"||$(this).val()=="--请选择市区--"||$(this).val()=="--请选择区/县--"){
					flag=false;
					showTip($(this).attr("data-name")+"不能为空");
					return false;
				}
			}
		});
		return flag;
	}
	
	$(".submit").tap(function(){
		if(checkForm()){
			if($("#addressTitle").html()=="修改收货地址")
				updateAddress();
			else
				addAddress();
			$(".addButton").show();
			$(".orderBottom").hide();
		}else{
			
		}
	});
	
	//查询地址
	function queryReceiveAddress(){
		var url="<%=request.getContextPath()%>/address/queryReceiveAddress";
		var params={};
		doAjax("GET",url,params,querySuccess,fail,true,false);
	}
	
	function querySuccess(data){
		var html="";
		var addressList = data.data;
		for(var i=0;i<addressList.length;i++){
			html+='<div class="oneAddress" data-id="'+addressList[i].receiveAddress.receiveAddressId+'">';
			html+='<div class="addressTop">';
			html+='<div class="namePhone">';
			html+='<span class="name">'+addressList[i].receiveAddress.receivePerson+'</span>';
			html+='<span class="phone">'+addressList[i].receiveAddress.contactNumber+'</span>';
			html+='</div>';
			html+='<div class="address">';
			html+='<span class="province">'+addressList[i].province+'</span>';
			html+='<span class="city">'+addressList[i].city+'</span>';
			html+='<span class="area">'+addressList[i].area+'</span>';
			html+='<span class="addressDetail">'+addressList[i].receiveAddress.addressDetail+'</span>';
			html+='</div></div>';
			html+='<div class="addressBottom">';
			html+='<span class="check'+(addressList[i].receiveAddress.defaultFlag==1?' active':'')+'"><i class="iconfont">&#xe611;</i>设为默认地址</span>';
			html+='<span class="delIcon"><i class="iconfont">&#xe603;</i>删除</span>';
			html+='<span class="editIcon"><i class="iconfont">&#xe602;</i>编辑</span>';
			html+='</div></div>';
		}
		$(".addressList").html(html);
		if(addressList.length>0){
			$(".addressList").show();
			$(".emptyAddress").hide();
		}else{
			$(".addressList").hide();
			$(".emptyAddress").show();
		}
	}
	
	//查询单个地址详情
	function getReceiveAddress(receiveAddressId){
		var url="<%=request.getContextPath()%>/address/toUpdateAddress";
		var params={receiveAddressId:receiveAddressId};
		doAjax("GET",url,params,getSuccess,fail,true,false);
	}
	
	function getSuccess(data){
		var address = data.data;
		$("input[name='receiveAddressId']").val(address.receiveAddressId);
		$("input[name='userId']").val(address.userId);
		$("input[name='defaultFlag']").val(address.defaultFlag);
		if(address.defaultFlag==1)
			$(".defaultAddress").hide();
		else
			$(".defaultAddress").show();
		$("input[name='receivePerson']").val(address.receivePerson);	
		$("input[name='contactNumber']").val(address.contactNumber);
		$("select[name='provinceId']").val(address.provinceId);
		queryCity(address.provinceId);
		queryArea(address.cityId);
		$("select[name='cityId']").val(address.cityId);
		$("select[name='areaId']").val(address.areaId);
		$("input[name='addressDetail']").val(address.addressDetail);
		
	}
	
	function updateAddress(){
		if($(".defaultAddress").hasClass("active")){
			$("input[name='defaultFlag']").val(1);
		}else{
			if($(".defaultAddress").attr("style")!="display: none;"){
				$("input[name='defaultFlag']").val(0);
			}
		}
		var url="<%=request.getContextPath()%>/address/updateAddress";
		var params=$("form").serialize();
		doAjax("GET",url,params,updateSuccess, fail,true,false);
	}
	
	function updateSuccess(data){
		swiper.slidePrev();
		swiper.slidePrev();
		$(".middle .address").attr("data-id",data.data);
		querySingleAddress();
		$(".payAddress").show();
		$(".noAddress").hide();
		$(".addButton").hide();
		$(".orderBottom").show();
	}
	
	function addAddress(){
		if($(".defaultAddress").hasClass("active")){
			$("input[name='defaultFlag']").val(1);
		}else{
			$("input[name='defaultFlag']").val(0);
		}
		var url="<%=request.getContextPath()%>/address/addReceiveAddress";
		var params=$("form").serialize();
		doAjax("GET",url,params,addSuccess, fail,true,false);
	}
	
	function addSuccess(data){
		swiper.slidePrev();
		swiper.slidePrev();
		$(".middle .address").attr("data-id",data.data);
		querySingleAddress();
		$(".payAddress").show();
		$(".noAddress").hide();
		$(".addButton").hide();
		$(".orderBottom").show();
	}
	
	function deleteAddress(){
		var url="<%=request.getContextPath()%>/address/deleteAddress";
		var params={receiveAddressId:data_id};
		doAjax("GET",url,params,deleteSuccess,fail,true,false);
	}
	
	function deleteSuccess(){
		$(".oneAddress[data-id='"+data_id+"']").remove(); 
		var address=$(".payAddress .address").attr("data-id");
		if(address==data_id){
			$(".payAddress .address").removeAttr("data-id");
		}
		textAddress();
		$("#delete").hide();
		$(".shadow").hide();
		if(swiper.activeIndex==2){
			$(".addButton").show();
			$(".orderBottom").hide();
			swiper.slideTo(1);
		}
	}
	
	function setDefault(receiveAddressId){
		var url="<%=request.getContextPath()%>/address/setDefault";
		var params={receiveAddressId:receiveAddressId};
		doAjax("GET",url,params,setDefaultSuccess,fail,true,false);
	}
	
	function setDefaultSuccess(data){
		
	}
	
	function fail(data){
		alert(fail);
	}
    
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
		$("select[name='cityId']").html(option);
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
		$("select[name='areaId']").html(option);
	}
	
    $(function(){
		window.location.hash="#slide1";
		swiper.slideTo(0);
    	var installPrice=0;
    	var totalMoney=0;
    	$(".commodity").each(function(){
    		installPrice+=parseFloat($(this).attr("data-installPrice"));
    		totalMoney+=parseFloat($(this).attr("data-money"));
    	});
    	$("#installMoney").html(installPrice.toFixed(2));
    	$("#moneySpan").html(totalMoney.toFixed(2));
    	$("#moneySpan1").html(totalMoney.toFixed(2));
    });
    
    $(".noAddress a").tap(function(){
    	/*$(".addButton").show();
		swiper.slideNext();
		 queryReceiveAddress();
		 */
		console.log(1)
		$(".addButton").hide();
		$(".orderBottom").hide();
		swiper.slideNext();
		swiper.slideNext();
		$("#addressTitle").html("添加收货地址");
		$(".addAddressSlider input,.addAddressSlide select").each(function(){
			$(this).val("");
		});
		$("select[name='cityId']").html("");
		$("select[name='areaId']").html("");
		$(".defaultAddress").show();
    });
    
    function querySingleAddress(){
    	var url="<%=request.getContextPath()%>/address/queryAddressBean";
    	var params={};
    	if($(".payAddress .address").attr("data-id")!=undefined){
    		params={receiveAddressId:$(".payAddress .address").attr("data-id")};
    	}
    	doAjax("GET",url,params,querySingleSuccess,fail,true,false);
    }
    
    function querySingleSuccess(data){
    	if(data.code=="0"){
    		$(".payAddress").hide();
    		$(".payAddress .address").removeAttr("data-id");
    		$(".noAddress").show();
    	}else{
    		
    		$(".payAddress").show();
    		$(".noAddress").hide();
    		var address=data.data;
    		var $address=$(".payAddress .address");
    		
    		$address.attr("data-id",address.receiveAddress.receiveAddressId);
    		$address.find(".province").html(address.province);
    		$address.find(".city").html(address.city);
    		$address.find(".area").html(address.area);
    		$address.find(".addressDetail").html(address.receiveAddress.addressDetail);
    		$(".payAddress .name").html("收货人："+address.receiveAddress.receivePerson);
    		$(".payAddress .phone").html(address.receiveAddress.contactNumber);
    	}
    }
    
    function showTip(content){
		$(".tip").html(content);
		$(".tip").css("opacity","0.8");
		setTimeout(function(){
			$(".tip").css("opacity","0");
		},1000);
	}

	$("#logisticsSelect").change(function(){
		if($(this).val()=="0"){
			$("#logisticsInput").show();
		}else{
			$("#logisticsInput").hide();
		}
	});
	$(".paySuccess").click(function(){
		var orderNumber = orderNumbers.split(",");
		for(var i=0;i<orderNumber.length;i++){
			var url = "<%=request.getContextPath()%>/buyer/notifyManagePayResult";
			var params = {orderNumber:orderNumber[i],userId:${payQrCode.payQrCodeUserId}};
			doAjax("GET",url,params,function(data){
				$(".shade").hide();
				$(".payQrCode").hide();
				showTip("已联系管理员，请等待订单完成。");
				setTimeout(function(){
					window.location.href="<%=request.getContextPath()%>/buyer/orderManage?orderStatus=0"
				},1000);
			},function(data){},true,false);
		}
	})
	
	
  </script>
</body>
</html>