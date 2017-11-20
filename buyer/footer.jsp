<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    body {
        -webkit-text-size-adjust: 100% !important;
    }

    /*底部*/
    footer {
        position: fixed;
        bottom: 0;
        left: 0;
        width: 100%;
        background-color: #fff;
        z-index: 1000;
        line-height: normal;
        font-family: "微软雅黑";
    }

    footer .footerA {
        display: block;
        text-align: center;
        color: #272724;
        line-height: 1.2rem;
        text-decoration: none;
        padding-top: .4rem;
        position: relative;
        width: 25%;
        float: left;
    }

    footer .footerA i {
        font-size: 1.2rem;
        display: inline-block;
        position: relative;
    }

    footer .footerA img {
        height: 1.4rem;
        display: inline-block;
        position: relative;
    }

    footer .footerA .fooCartNum {
        position: absolute;
        top: -.1rem;
        width: 1rem;
        height: 1rem;
        text-align: center;
        line-height: 1rem;

        color: #fff;
        font-size: .8rem;
        background-color: #29a2f5;
        display: inline-block;
        border-radius: 50%;
    }

    footer .footerA p {
        font-size: .8rem;
    }

    footer .footerA.active p {
        color: #29a2f5;
    }

    footer .footerA:active p {
        color: #29a2f5;
    }

    .footer-width {
        width: 33.33%;
        float: left;
    }

    footer {
        border-top: 1px solid lightgrey;
    }
</style>
<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/jweixin-1.0.0.js"></script>
<!--[[底部-->
<footer class="clearfix text-center footer">
    <a href="<%=request.getContextPath()%>/buyer/index" data-href="<%=request.getContextPath()%>/buyer/index"
       class="fa footerA width-2 <c:if test='${fActive==0 }'>active</c:if>">
        <img src="<%=request.getContextPath() %>/resources/customer/assets/images/bottom_bar/${fActive==0?'home_orange':'home_black'}.png"/>
        <p>首页</p>
    </a>
    <a href="<%=request.getContextPath()%>/product/productList?showFilter=1"
       class="fa footerA width-2 <c:if test='${fActive==1 }'>active</c:if>">
        <img src="<%=request.getContextPath() %>/resources/customer/assets/images/bottom_bar/${fActive==1?'search_orange':'search_black'}.png"/>
        <p>分类查找</p>
    </a>
    <c:choose>
        <c:when test="${sessionScope.openId!='notFollow' }">
            <a href="<%=request.getContextPath()%>/shopcart/myShopcart"
               data-href="<%=request.getContextPath()%>/shopcart/myShopcart"
               class="fa footerA width-2 <c:if test='${fActive==3 }'>active</c:if>">
                <img src="<%=request.getContextPath() %>/resources/customer/assets/images/bottom_bar/${fActive==3?'cart_orange':'cart_black'}.png"/>
                <span class="fooCartNum" style="display:none"></span>
                <p>购物车</p>
            </a>
        </c:when>
        <c:otherwise>
            <a href="javascript:alert('请先关注平台');" class="footerA width-2 <c:if test='${fActive==3 }'>active</c:if>">
                <img src="<%=request.getContextPath() %>/resources/customer/assets/images/bottom_bar/cart_black.png"/>
                <p>购物车</p>
            </a>
        </c:otherwise>
    </c:choose>
    <c:choose>
        <c:when test="${sessionScope.openId!='notFollow' }">
            <a href="<%=request.getContextPath()%>/buyer/personCenter"
               data-href="<%=request.getContextPath()%>/buyer/personCenter"
               class="fa footerA width-2 <c:if test='${fActive==4 }'>active</c:if>">
                <img src="<%=request.getContextPath() %>/resources/customer/assets/images/bottom_bar/${fActive==4?'personalcenter_orange':'personalcenter_black'}.png"/>
                <p>个人中心</p>
            </a>
        </c:when>
        <c:otherwise>
            <a href="javascript:alert('请先关注平台');" class="footerA width-2 <c:if test='${fActive==4 }'>active</c:if>">
                <img src="<%=request.getContextPath() %>/resources/customer/assets/images/${fActive==4?'personActive':'person'}.png"/>
                <p>个人中心</p>
            </a>
        </c:otherwise>
    </c:choose>
</footer>
<!--底部]]-->
<!-- 等待加载 -->
<%--<div class="waiting"><i class="iconfont">&#xe605;</i></div>
<div class="shade"></div>--%>
<!-- 等待加载 -->

<script>
    $(".subscribePanel").on("touchend", function () {
        $(this).off('touchstart', 'touchmove');
        $("body").removeClass("body");
    });

    $(".subscribePanel").on("touchmove", function (ev) {
        console.log(ev);
        $("body").addClass("body");
        $(this).css({
            top: ev.targetTouches[0].clientY + "px"
        });
    });

    /*$(".fa").tap(function () {
        window.location.href = $(this).attr("data-href");
    });*/

    $(".filterProduct").tap(function () {
        show();
    });

    /*function getQrCode(){
        $(".waiting").show();
        $(".shade").show();

        var url=location.href.split('#')[0].replace(/&/g,"-");
          var urlStr = "<%=request.getContextPath()%>/wechat/signature?url="+url;
  		console.log(urlStr);
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
			        jsApiList: ['scanQRCode'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
			    });
			    wx.ready(function(){
			        // config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
			        wx.scanQRCode({
			        	needResult: 0, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
		        	    scanType: ["qrCode"], // 可以指定扫二维码还是一维码，默认二者都有
		        	    success: function (res) {
		        	    	var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果

		        			$(".waiting").hide();
		        			$(".shade").hide();
		        	    }
			        }); 
			    });
			}
		}); // end ajax   
	}*/
    countShopcart();

    function countShopcart() {
        var url = "<%=request.getContextPath()%>/shopcart/countShopCartNum";
        doAjax("GET", url, {}, countSuccess, fail, true, false);
    }

    function countSuccess(data) {
        if (data.data > 0) {
            $(".fooCartNum").html(data.data);
            $(".fooCartNum").show();
        }
    }


    function fail(data) {
    }


    function showTip(content) {
        $(".tip").html(content);
        $(".tip").css("opacity", "0.8");
        setTimeout(function () {
            $(".tip").html("");
            $(".tip").css("opacity", "0");
        }, 1000);
    }

    function closeWindow() {
        var url = location.href.split('#')[0].replace(/&/g, "-");
        var urlStr = "<%=request.getContextPath()%>/wechat/signature?url=" + url;
        //alert("Before Call:"+urlStr);
        $.ajax({
            method: "GET",
            url: urlStr,
            success: function (data, status, jqXHR) {
                //alert(data.appId+","+data.signature+","+data.timeStamp+","+data.nonceStr);
                var result = data;
                var appId = result.appId;
                var signature = result.signature;
                var timeStamp = result.timeStamp;
                var nonceStr = result.nonceStr;

                wx.config({
                    debug: false,// 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                    appId: appId, // 必填，公众号的唯一标识
                    timestamp: timeStamp, // 必填，生成签名的时间戳
                    nonceStr: nonceStr, // 必填，生成签名的随机串
                    signature: signature,// 必填，签名，见附录1
                    jsApiList: ['closeWindow'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
                });
                wx.error(function (res) {

                });
                wx.ready(function () {
                    url = "<%=request.getContextPath()%>/buyer/sendWarnMessage";
                    var params = {};
                    doAjax("GET", url, params, function (data) {
                    }, function (data) {
                        console.log(fail);
                    }, true, false);
                    wx.closeWindow();
                });
            }
        }); // end ajax
    }

    $(".classifyA").tap(function () {
        window.location.href = "<%=request.getContextPath()%>/product/productList?orderBy=1";
    });

    (function () {
        if (typeof WeixinJSBridge == "object" && typeof WeixinJSBridge.invoke == "function") {
            handleFontSize();
        } else {
            if (document.addEventListener) {
                document.addEventListener("WeixinJSBridgeReady", handleFontSize, false);
            } else if (document.attachEvent) {
                document.attachEvent("WeixinJSBridgeReady", handleFontSize);
                document.attachEvent("onWeixinJSBridgeReady", handleFontSize);
            }
        }

        function handleFontSize() {
            // 设置网页字体为默认大小
            WeixinJSBridge.invoke('setFontSizeCallback', {'fontSize': 0});
            // 重写设置网页字体大小的事件
            WeixinJSBridge.on('menu:setfont', function () {
                WeixinJSBridge.invoke('setFontSizeCallback', {'fontSize': 0});
            });
        }
    })();
</script>
<input type="hidden" id="lujing" value="<%=request.getContextPath()%>">
<script src="<%=request.getContextPath()%>/resources/common/count.js?2"></script>