<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>金明同达灯饰</title>
    <link href="<%=request.getContextPath() %>/resources/common/bootstrap.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/common/swiper.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/customer/assets/css/orderCart.css" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
	<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
</head>
<body>
<c:set var="UNCHECK" value="<%=ProductCheckStatus.UNCHECK%>" />
<c:set var="PENDING_CHECK" value="<%=ProductCheckStatus.PENDING_CHECK%>" />
<c:set var="CHECK_FAILURE" value="<%=ProductCheckStatus.CHECK_FAILURE%>" />
<c:set var="CHECK_SUCCESS" value="<%=ProductCheckStatus.CHECK_SUCCESS%>" />
<c:set var="CAN_BE_ONLINE" value="<%=ProductOnlineStatus.CAN_BE_ONLINE%>" />
<c:set var="PENDING_PAY" value="<%=ProductOnlineStatus.PENDING_PAY%>" />
<c:set var="ONLINEING" value="<%=ProductOnlineStatus.ONLINEING%>" />
<c:set var="OFFLINEING" value="<%=ProductOnlineStatus.OFFLINEING%>" />
<div class="cart">
    <div class="title">选择租期</div>
    <input type="hidden" id="allLine" value="${allLine }"/>
    <div class="product-content">
        <div class="product clearfix" id="shopcartItem${shopcartItem.shopcartItem.itemId}" data-unitPrice="${shopcartItem.product.unitPrice }" data-freight="${shopcartItem.product.freight }">
            <div class="pull-left col-xs-8">
                <div class="col-xs-4">
                    <img src="${product.cover1}" alt=""/>
                </div>
                <div class="col-xs-8">
                    <span class="name">商品名：${product.productName}</span><br />
                    <br/>
		            <span class="number grey">
		               <span class="number-label">租期(月)：</span>
		               <button class="reduce btn btn-default" onclick="changeNum(this,'-')">-</button>
		               <span class="number-count">1</span>
		               <button class="increase btn btn-default" onclick="changeNum(this,'+')">+</button>
		            </span>
                </div>
            </div>
            <div class="pull-right col-xs-4 text-right">
            	<span class="delete" onclick=""></span><br /><br />
                 <span class="price red">￥
                 	<c:if test="${empty lampPosition }">
                		<%=SystemParams.ONLINE_LAMP_RENT_MONEY %>
                	</c:if>
                	<c:if test="${!empty lampPosition }">
                		${lampPosition.lampPositionPrice}
                	</c:if>
                 </span>
            </div>
        </div>
    </div>
    <!-- 购买商品]]-->
    
    <!-- [[结算-->
    <div class="set-account clearfix">
        <div class="pull-left">
            <div class="product-total grey">费用合计：<span class="red">￥1.00（共1月）</span></div>
        </div>
        <div class="pull-right">
            <a href="javascript:onlineProduct(${product.productId })">
                <button class="btn btn-primary">去结算</button>
            </a>
        </div>
    </div>
    <!-- 结算]]-->
</div>

<jsp:include page="/jsp/factory/footer.jsp"></jsp:include>
<script>
	function changeNum(obj,sign){
		var number=$(obj).siblings(".number-count").html();
		if(!(number==1&&sign==="-")){
			if(sign==="+")
				number=parseInt(number)+1;
			else
				number=parseInt(number)-1;
		
			$(obj).siblings(".number-count").html(number);
			var totalMoney=parseFloat($(".pull-right .price").html().match(/\d+(\.\d+)?/g)*number).toFixed(2);
			$(".set-account .red").html("￥"+totalMoney+"（共"+number+"月）");
		}
	}
	
	function onlineProduct(productId){
		$("#loading").show();
		var url="<%=request.getContextPath()%>/factory/reletProduct";
		var params={productId:productId,rentTerm:$(".number-count").html(),allLine:$("#allLine").val()};
		doAjax("GET",url,params,success,fail,false,false);
	}
	
	function success(data){
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
					$("#loading").hide();
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
			            		window.location.href='<%=request.getContextPath()%>/factory/lampManage?onlineStatus=${ONLINEING}';
			                if(res.errMsg=="chooseWXPay:cancel")
			                	window.location.href='<%=request.getContextPath()%>/factory/lampManage?onlineStatus=${ONLINEING}';
				            if(res.errMsg=="chooseWXPay:ok")
				            	window.location.href='<%=request.getContextPath()%>/factory/lampManage?onlineStatus=${ONLINEING}';    	   
			            }
			        }); 
			    });
			}
		}); // end ajax   
	}
	
	function fail(){
		alert("fail")
	}
</script>
</body>
</html>