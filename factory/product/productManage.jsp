<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>金明同达灯饰</title>
    <link href="<%=request.getContextPath() %>/resources/common/bootstrap.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/common/swiper.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/factory/assets/css/product.css" rel="stylesheet">
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

<div class="productManage">
    <div class="title">线上灯位管理</div>

   
    <%-- <div class="orderType">
        <div class="span-content text-center">
            <span class="type <c:if test='${checkStatus==UNCHECK}'>active</c:if> col-xs-2" onclick="window.location.href='<%=request.getContextPath()%>/factory/productManage?checkStatus=${UNCHECK}'">未审核</span>
            <span class="type <c:if test='${checkStatus==PENDING_CHECK}'>active</c:if> col-xs-2" onclick="window.location.href='<%=request.getContextPath()%>/factory/productManage?checkStatus=${PENDING_CHECK}'">审核中</span>
            <span class="type <c:if test='${checkStatus==CHECK_FAILURE}'>active</c:if> col-xs-2" onclick="window.location.href='<%=request.getContextPath()%>/factory/productManage?checkStatus=${CHECK_FAILURE}'">审核失败</span>
            <span class="type <c:if test='${checkStatus==CHECK_SUCCESS}'>active</c:if> col-xs-2" onclick="window.location.href='<%=request.getContextPath()%>/factory/productManage?checkStatus=${CHECK_SUCCESS}'">审核通过</span>
            <span class="type <c:if test='${onlineStatus==CAN_BE_ONLINE}'>active</c:if> col-xs-2" onclick="window.location.href='<%=request.getContextPath()%>/factory/productManage?onlineStatus=${CAN_BE_ONLINE}'">可上线</span>
            <span class="type <c:if test='${onlineStatus==PENDING_PAY}'>active</c:if> col-xs-2" onclick="window.location.href='<%=request.getContextPath()%>/factory/productManage?onlineStatus=${PENDING_PAY}'">待付款</span>
            <span class="type <c:if test='${onlineStatus==ONLINEING}'>active</c:if> col-xs-2" onclick="window.location.href='<%=request.getContextPath()%>/factory/productManage?onlineStatus=${ONLINEING}'">上线中</span>
        </div>
    </div> --%>
    <div class="order-type clearfix">
        <div class="tab-content clearfix">
            <%-- <button class="tab-type btn <c:if test='${checkStatus==UNCHECK}'>active btn-primary</c:if>" data-index="1"  onclick="window.location.href='<%=request.getContextPath()%>/factory/productManage?checkStatus=${UNCHECK}'">未审核</button> --%>
            <button class="tab-type btn <c:if test='${onlineStatus==CAN_BE_ONLINE}'>active btn-primary</c:if>" data-index="2" onclick="window.location.href='<%=request.getContextPath()%>/factory/productManage?onlineStatus=${CAN_BE_ONLINE}'">可上线</button>
            <button class="tab-type btn <c:if test='${onlineStatus==PENDING_PAY}'>active btn-primary</c:if>" data-index="3" onclick="window.location.href='<%=request.getContextPath()%>/factory/productManage?onlineStatus=${PENDING_PAY}'">待付款</button>
            <button class="tab-type btn <c:if test='${onlineStatus==ONLINEING}'>active btn-primary</c:if>" data-index="4"  onclick="window.location.href='<%=request.getContextPath()%>/factory/productManage?onlineStatus=${ONLINEING}'">上线中</button>
            <button class="tab-type btn <c:if test='${onlineStatus==OFFLINEING}'>active btn-primary</c:if>" data-index="1"  onclick="window.location.href='<%=request.getContextPath()%>/factory/productManage?onlineStatus=${OFFLINEING}'">已下线</button>
            <%-- <span class="btn other">其他...
                <div class="other-content" style="display: none;">
                    <button class="tab-type btn <c:if test='${checkStatus==PENDING_CHECK}'>active btn-primary</c:if>" data-index="5" data-value="${PENDING_CHECK }" >审核中</button>
                    <button class="tab-type btn <c:if test='${checkStatus==CHECK_FAILURE}'>active btn-primary</c:if>" data-index="6" data-value="${CHECK_FAILURE}">审核失败</button>
                </div>
            </span> --%>
        </div>
    </div>

    <div class="product-content">
    	<c:forEach items="${productPager.list }" var="productModel">
	        <div class="product clearfix">
	            <div class="col-xs-4 text-center">
	                <img src="${productModel.product.cover1 }" alt=""/>
	            </div>
	            <div class="col-xs-8">
	                <div class="product-title">${productModel.product.productName }</div>
	                <div class="clearfix">
	                    <div class="pull-left price red"><c:if test="${onlineStatus==PENDING_PAY}">租期：${productModel.productOnline.rentTerm }个月</c:if></div>
	                    <div class="pull-right book">【<c:choose><c:when test="${productModel.product.productKind==1 }">现货</c:when><c:otherwise>订货</c:otherwise></c:choose>】</div>
	               		<br>
	               		<div><c:if test="${onlineStatus==ONLINEING}">到期时间：<fmt:formatDate value="${productModel.product.offlineTime }" pattern="yyyy-MM-dd HH:mm" /></c:if></div>
	               		<div ><c:if test="${onlineStatus==ONLINEING}">上线时间：<fmt:formatDate value="${productModel.productOnline.payTime }" pattern="yyyy-MM-dd HH:mm" /></c:if></div>
	                </div>
	                <div class="clearfix">
	                    <div class="pull-right">
	                        <c:if test="${checkStatus==UNCHECK||checkStatus==CHECK_FAILURE}">
	                        	<button class="btn btn-warning" onclick="window.location.href='<%=request.getContextPath()%>/factory/submitAudit?productId=${productModel.product.productId}'">去审核</button>
	                        	<button class="btn btn-warning" onclick="window.location.href='<%=request.getContextPath()%>/factory/toUpdateProduct?productId=${productModel.product.productId}'">修改</button>	
	                        </c:if>
	                    	<c:if test="${onlineStatus==CAN_BE_ONLINE||onlineStatus==OFFLINEING}"><button class="btn btn-warning" onclick="window.location.href='<%=request.getContextPath()%>/factory/toOnlineProduct?productId=${productModel.product.productId }'">去上线</button></c:if>
	                    	<c:if test="${onlineStatus==PENDING_PAY}"><button class="btn btn-warning" onclick="toPay(${productModel.product.onlineId})">去付款</button></c:if>
	                    	<c:if test="${onlineStatus==ONLINEING}"><button class="btn btn-warning" onclick="window.location.href='<%=request.getContextPath()%>/factory/toReletProduct?productId=${productModel.product.productId }'">续租</button></c:if>
	                    </div>
	                </div>
	            </div>
	        </div>
        </c:forEach>
    </div>
    <!-- [[加载更多-->
    <c:if test="${productPager.after<productPager.count }">
    <div class="loadMore text-center">
        <button class="btn btn-primary" onclick="loadMore()">加载更多</button>
    </div>
    </c:if>
    <!-- 加载更多]]-->
    
</div>
<!--[[底部-->
<jsp:include page="/jsp/factory/footer.jsp"></jsp:include>
<!--底部]]-->
<script>
	function onlineProduct(productId){
		var number=prompt("请输入租期","");
		$("#loading").show();
		var url="<%=request.getContextPath()%>/factory/onlineProduct";
		var params={productId:productId,rentTerm:number};
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
			            		window.location.href='<%=request.getContextPath()%>/factory/productManage?onlineStatus=${PENDING_PAY}';
			                if(res.errMsg=="chooseWXPay:cancel")
			                	window.location.href='<%=request.getContextPath()%>/factory/productManage?onlineStatus=${PENDING_PAY}';
				            if(res.errMsg=="chooseWXPay:ok")
				            	window.location.href='<%=request.getContextPath()%>/factory/productManage?onlineStatus=${ONLINEING}';    	   
			            }
			        }); 
			    });
			}
		}); // end ajax   
	}
	
	function fail(){
		alert("fail")
	}
	
	function toPay(onlineId){
		var url="<%=request.getContextPath()%>/factory/toPay";
		var params={onlineId:onlineId};
		doAjax("GET",url,params,success,fail,false,false);
	}
	
	var offset=${productPager.after};
	function loadMore(){
		var url="<%=request.getContextPath()%>/factory/productManageAjax?checkStatus=${checkStatus}&onlineStatus=${onlineStatus}";
		var params={offset:offset};
		doAjax("GET",url,params,loadMoreSuccess,fail,false,false);
	}
	
	
	function loadMoreSuccess(data){
		var productList=data.data.list;
		var html="";
		for(var i=0;i<productList.length;i++){
			var type="";
			if(productList[i].productKind==0)
				type="订货";
			else
				type="现货";
			var button="";
			if(productList[i].onlineStatus==${CAN_BE_ONLINE})
				button='<button class="btn btn-warning" onclick="onlineProduct('+productList[i].productId+')">去上线</button>';
			if(productList[i].onlineStatus==${PENDING_PAY})
				button='<button class="btn btn-warning" onclick="toPay('+productList[i].onlineId+')">去付款</button>';
			html+='<div class="product clearfix">'+
			     '<div class="col-xs-4 text-center">'+
			     '<img src="'+productList[i].cover1+'" alt=""/></div>'+
			     '<div class="col-xs-8">'+
			     '<div class="product-title">'+productList[i].productName+'</div>'+
			     '<div class="clearfix">'+
			     '<div class="pull-left price red">￥<span class="product-price">'+productList[i].unitPrice+'</span></div>'+
			     '<div class="pull-right book">【'+type+'】</div>'+
			     '</div>'+'<div class="clearfix">'+
			     '<div class="pull-left count red">销量：<span class="product-count">'+productList[i].productSales+'</span></div>'+
			     '<div class="pull-right">'+
			     ''+button+
			     '</div></div></div></div>';
		}
		$(".product-content").append(html);
		if((offset+10)>=data.data.count)
			$(".btn").hide();
		offset=data.data.after;
	}
	
	$(".other").on("tap",function(){
		$(this).find(".other-content").toggle();
	});
	
	$(".other .tab-type").on("tap",function(){
		window.location.href="<%=request.getContextPath()%>/factory/productManage?checkStatus="+$(this).attr("data-value");
	})
</script>
</body>
</html>