<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>金明同达灯饰</title>
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/customer/assets/css/orderCart.css" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
</head>
<body>
<div class="orderDetail">
    <div class="title"><i class="iconfont prevPage" >&#xe63f;</i>售后详情</div>
    <div class="goodsInfo">
    	<div class="grayTitle">商品信息</div>
    	<div class="shopOrder">
	   		<div class="commodity">
	   			<a href="<%=request.getContextPath()%>/product/productDetail?productId=${product.productId}"><img src="${product.cover1}"/></a>
	   			<div class="commDiv">
	   				<p>
	   					<a href="<%=request.getContextPath()%>/product/productDetail?productId=${product.productId}">${product.productName}</a>
	   					(${productTimes })
	   				</p>
	    			<div class="moneyNum">
	    				<span><font>X</font>${orderItem.orderItemNumber}</span>
	    			</div>
	   			</div>
	   		</div>
   		</div>
   	</div>
    <div class="orderInfo tableInfo">
    	<div class="grayTitle"> </div>
    	<table>
    		<tr>
    			<td>订单号</td>
    			<td>${orderForm.orderNumber}</td>
    		</tr>
    		<tr>
    			<td>付款时间</td>
    			<td>
    				<c:if test="${!empty orderForm.payTime }"><fmt:formatDate value="${orderForm.payTime}" pattern="yyyy-MM-dd HH:mm:ss" /></c:if>
        			<c:if test="${empty orderForm.payTime }">暂未付款</c:if>
        		</td>
    		</tr>
    		<tr>
    			<td>发货时间</td>
    			<td>
    				<c:if test="${!empty orderForm.sendTime }"><fmt:formatDate value="${orderForm.sendTime}" pattern="yyyy-MM-dd HH:mm:ss" /></c:if>
        			<c:if test="${empty orderForm.sendTime }">暂未发货</c:if>
				</td>
    		</tr>
    		<tr>
    			<td>收货时间</td>
    			<td>
    				<c:if test="${!empty orderForm.receiveTime }"><fmt:formatDate value="${orderForm.receiveTime}" pattern="yyyy-MM-dd HH:mm:ss" /></c:if>
        			<c:if test="${empty orderForm.receiveTime }">暂未收货</c:if>
				</td>
    		</tr>
    		<c:if test="${!empty buyer.manageRole}">
    		<tr>
    			<td>厂家</td>
    			<td>${seller.shortCompanyName }</td>
    		</tr>
    		<tr>
    			<td>买家</td>
    			<td>${buyer.legalPersonName }</td>
    		</tr>
    		<tr>
    			<td>客服</td>
    			<td>${service.legalPersonName }</td>
    		</tr>
    		</c:if>
    		<tr>
    			<td>收货人</td>
    			<td>${orderForm.receivePerson}</td>
    		</tr>
    		<tr>
    			<td>联系电话</td>
    			<td>${orderForm.receivePhone}</td>
    		</tr>
    		<tr>
    			<td>收货地址</td>
    			<td>${orderForm.receiveProvince}${orderForm.receiveCity}${orderForm.receiveArea}${orderForm.receiveAddress}</td>
    		</tr>
    	</table>
    </div>
    <div class="orderInfo tableInfo">
    	<div class="grayTitle">问题描述</div>
    	<table>
    		<tr>
    			<td>申请时间</td>
    			<td><fmt:formatDate value="${afterSale.applyTime }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
    		</tr>
    		<tr>
    			<td>描述</td>
    			<td>${afterSale.afterSaleDescription}</td>
    		</tr>
    		<tr>
    			<td>图片</td>
    			<td><img src="${afterSale.afterSalePic1}" class="smallImg"/>
    			<c:if test="${!empty afterSale.afterSalePic2}"><img src="${afterSale.afterSalePic2}" class="smallImg""/></c:if>
    			<c:if test="${!empty afterSale.afterSalePic3}"><img src="${afterSale.afterSalePic3}" class="smallImg""/></c:if></td>
    		</tr>
    		<c:if test="${!empty buyer.manageRole}">
    		<tr>
    			<td>备注</td>
    			<td>${afterSale.afterSaleRemark}</td>
    		</tr>
    		</c:if>
    		<c:if test="${afterSale.isRepair==1 }">
    		<tr>
    			<td>配件</td>
    			<td>${afterSale.afterSaleRepairName}</td>
    		</tr>
    		<tr>
    			<td>数量</td>
    			<td>${afterSale.afterSaleNumber}</td>
    		</tr>
    		</c:if>
    	</table>
    </div>
    <c:if test="${afterSale.afterSaleStatus==1}">
    <div class="orderInfo tableInfo">
    	<div class="grayTitle">处理结果</div>
    	<table>
    		<tr>
    			<td>处理时间</td>
    			<td><fmt:formatDate value="${afterSale.handleTime }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
    		</tr>
    		<tr>
    			<td>描述</td>
    			<td>${afterSale.afterSaleHandleDescription}</td>
    		</tr>
    		<tr>
    			<td>图片</td>
    			<td><c:if test="${!empty afterSale.afterSaleHandlePic1}"><img src="${afterSale.afterSaleHandlePic1}" class="smallImg"/></c:if></td>
    		</tr>
    	</table>
    </div>
    </c:if>
   <c:if test="${!empty buyer.manageRole}">
    <div class="handle">
    	<div class="btnGroup">
    	<c:if test="${afterSale.afterSaleStatus==0||afterSale.afterSaleStatus==2}"> 		
	    	<c:if test="${afterSale.isRepair!=1}">
		    	<button class="toRepair">补配件</button>
	    	</c:if> 
		    <button class="toHandle">处理售后</button>
	    </c:if>
    	</div>
    </div>
    </c:if>
</div>

<div class="tip"></div>
<div class="bigImgDiv">
	<img class="bigImg" src=""/>
</div>
<!-- 开始确认框 -->
<div class="confirmDiv" id="delete">
	<div class="confirmTop">
		<span>温馨提醒</span>
		<span id="closeConfirm"><i class="iconfont">&#xe632;</i></span>
	</div>
	<p>确定删除？</p>
	<div class="confirmBottom">
		<span id="cancel1">取消</span>
		<span id="confirm" data-url="">确定</span>
	</div>
</div>
	
<div class="shade"></div>
<!--[[底部-->
<%-- <jsp:include page="/jsp/buyer/footer.jsp"></jsp:include> --%>
<!--底部]]-->
<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
<script>
	$(".toHandle").tap(function(){
		window.location.href="<%=request.getContextPath()%>/buyer/toHandleAfterSale?afterSaleId=${afterSale.afterSaleId}";
	});
	

	$(".toRepair").tap(function(){
		window.location.href="<%=request.getContextPath()%>/buyer/toSetAfterSaleRepair?afterSaleId=${afterSale.afterSaleId}";
	});
	
	//确认收货
	$(".receiveBtn").tap(function(){
		window.location.href="<%=request.getContextPath()%>/buyer/toSign?orderNum=${orderForm.orderNumber}";
	});
	
	$(".refundBtn").tap(function(){
		$("#delete p").html("确认退款？");
		$("#delete").show();
		$(".shade").show();
		$("#confirm").attr("data-url","<%=request.getContextPath()%>/buyer/applyRefund?orderItemId="+$(this).attr("data-id"));
		//window.location.href="<%=request.getContextPath()%>/buyer/applyRefund?orderItemId="+$(this).attr("data-id");
	});
	
	$(".returnBtn").tap(function(){
		$("#delete p").html("确认退货？");
		$("#delete").show();
		$(".shade").show();
		$("#confirm").attr("data-url","<%=request.getContextPath()%>/buyer/applyReturn?orderItemId="+$(this).attr("data-id"));
	});	
	
	$("#confirm").tap(function(){
		window.location.href=$(this).attr("data-url");
	});
	
	$(".rdBtn").tap(function(){
		window.location.href="<%=request.getContextPath()%>/buyer/returnDetail?returnInfoId="+$(this).attr("data-id");
	});
	
	$(".afterSaleBtn").tap(function(){
		window.location.href="<%=request.getContextPath()%>/buyer/toApplyAfterSale?orderItemId="+$(this).attr("data-id")+
				"&orderNumber=${orderForm.orderNumber}";
	});
	
	$(".toPay").tap(function(){
		var url="<%=request.getContextPath()%>/buyer/payOrder?orderNum=${orderForm.orderNumber}";
		var params={};
		doAjax("GET",url,params,payOrderSuccess,fail,false,false);
	});
	
	function payOrderSuccess(data){
		var urlStr = "<%=request.getContextPath()%>/wechat/signature?url="+location.href.split('#')[0];
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
			                	alert("fail");
			                if(res.errMsg=="chooseWXPay:cancel")
			                	alert("cancle");
			                if(res.errMsg=="chooseWXPay:ok"){
			                	location.reload();
			                } 
			            }
			        }); 
			    });
			}
		}); // end ajax   
	}
	
	function fail(data){
		alert("fail");
	} 
	
	$(function(){
		calculate();
	})
	
	function calculate(){
		var numbers=0;
		$(".commodity").each(function(){
			numbers = numbers+parseInt($(this).find(".moneyNum span").html().match(/\d+(\.\d+)?/g));
		});
		$(".allP span").eq(0).html(numbers);
	}
	
	//开始物流信息
	$(".toSend").tap(function(){
		$(".sendLogistics").show();
	});
	$("#closeSendToDiv,#cancel,.shade").on("tap",function(){
		$(".sendToDiv").hide();
		$(".shade").hide();
	});
	$("#cancel1,#closeConfirm").on("tap",function(){
		$(".shade").hide();
		$("#delete").hide();
	});
	
	$("#sendToUl li:not(.firstWord)").tap(function(){
		$("#sendToUl li").removeClass("active");
		$("#otherLogistics").removeClass("active");
		$(this).addClass("active");
		$(".sendToDiv").show();
		$(".shade").show();
		$("#logisticsCompany").html($(this).html());
		$("#otherInput").hide();
		$("#companySpan").show();
	});
	
	$("#otherLogistics").tap(function(){
		$(".sendToDiv").show();
		$(".shade").show();
		$("#otherInput").show();
		$("#companySpan").hide();
		$("#sendToUl li").removeClass("active");
		$("#otherLogistics").addClass("active");
	});
	
	$(".sendTop").tap(function(){
		$(".sendLogistics").hide();
	});
	
	$(".prevPage").tap(function(){
		history.go(-1);
	});
	
	$("#sendTo").tap(function(){
		if($("#logisticsSelect").val()=="otherLogistics"){
			if($("#otherInput").val().trim()==""){
				showTip("请输入物流公司名称！");
			}
		}
		if($("#transportPhone").val().trim()==""){
			showTip("请输入物流公司电话！");
		}else if($("#transportNumber").val().trim()==""){
			showTip("请输入物流编号！");
		}else{
			var url="<%=request.getContextPath()%>/platform/delivery?transportPhoneNumber="+$("#transportPhone").val();
			var params;
			if(logisticsCompanyCode==null)
				params={logisticsCompanyCode:$("#otherInput").val(),logisticsCode:$("#transportNumber").val(),
					orderNum:orderNum,logisticsSelect:$("#logisticsSelect").val()};
			else
				params={logisticsCompanyCode:logisticsCompanyCode,logisticsCode:$("#transportNumber").val(),
					orderNum:orderNum,logisticsSelect:$("#logisticsSelect").val()};
			doAjax("GET",url,params,sendSuccess,fail,true,false);
		}
	});
	
	$(document).on("tap",".smallImg",function(){
		var img = new Image();
		img.src=$(this).attr("src");
		
		$(".bigImg").removeAttr("style");
		if(img.complete){
			changeImg(img);
		}else{
			img.onload=function(){
				changeImg(img);
			}
		}
		$(".bigImgDiv").show();
		$(".shade").show();
	});
</script>
</body>
</html>