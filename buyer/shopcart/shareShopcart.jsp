<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib prefix="thumbnail" uri="/WEB-INF/tld/thumbnailTag.tld"%>
<%@ taglib prefix="ppt" uri="/WEB-INF/tld/productPriceTag.tld"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>佐为照明</title>
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/customer/assets/css/orderCart.css?12" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
</head>
<body>
<c:set var="SALES_SORT" value="<%=ProductSortType.SALES_SORT%>" />
<c:set var="NEW_SORT" value="<%=ProductSortType.NEW_SORT%>" />
<c:set var="PRICE_SORT" value="<%=ProductSortType.PRICE_SORT%>" />
<c:set var="CUSTOMER" value="<%=UserType.CUSTOMER%>" />
<c:set var="RETAIL_SALES" value="<%=UserType.RETAIL_SALES%>" /> 
<c:set var="AUTHENTICATION_SUCCESS" value="<%=UserCheckStatus.AUTHENTICATION_SUCCESS%>" />
<div class="cart">
    <div class="title"><i class="iconfont prevPage" >&#xe624;</i>购物车 </div>
    <div class="allShop">
    	<c:forEach items="${shopcartList}" var="shopcart">
    	<div class="oneShop">
    		<div class="shopName">
	    		<span class="shopI"><span class="radius "><i class="iconfont">&#xe611;</i></span></span>
	    		<a href="<%=request.getContextPath()%>/product/shopProductList?shopId=${shopcart.seller.userId}">
	    			<i class="iconfont">&#xe606;</i><%-- ${shopcart.seller.shortCompanyName } --%>
	    		</a>
	    		<i class="iconfont show">&#xe624;</i>
	    	</div>
	    	<c:forEach items="${shopcart.shopcartItemList}" var="shopcartItem">
    		<div class="commodity" data-id="${shopcartItem.shopcartItem.itemId}" data-product-id="${shopcartItem.shopcartItem.productId}">
    			<span class="oneI"><span class="radius "><i class="iconfont">&#xe611;</i></span></span>
    			<img src="<thumbnail:date value="${shopcartItem.product.cover1}"/>"/>
    			<div class="cartLeft">
    				<p><a href="<%=request.getContextPath()%>/product/productDetail?productId=${shopcartItem.product.productId}">${shopcartItem.product.productName}</a></p>
    				<div class="numDiv">
    					<span class="change-num reduce">-</span>
							<input class="num" type="tel" value="${shopcartItem.shopcartItem.productNumber}"  maxData="${shopcartItem.product.productStock }" data-price="${user.role==CUSTOMER||user.role==RETAIL_SALES||user.checkStatus!=AUTHENTICATION_SUCCESS?shopcartItem.product.retailPrice:(shopcartItem.product.unitPrice+shopcartItem.product.woodenFee)}" data-originPrice="${shopcartItem.product.unitPrice}"/>
						<span class="change-num increase">+</span>
    				</div>
    			</div>
    			<div class="cartRight">
    				<i class="iconfont delIcon">&#xe603;</i>
    				<h4>￥<ppt:date percent="${percent}" role="${(user.role==CUSTOMER||user.role==RETAIL_SALES||user.checkStatus!=AUTHENTICATION_SUCCESS)}" 
    					productPrice="${(user.role==CUSTOMER||user.role==RETAIL_SALES||user.checkStatus!=AUTHENTICATION_SUCCESS)?shopcartItem.product.retailPrice:(shopcartItem.product.unitPrice+shopcartItem.product.woodenFee)}" productNumber="${shopcartItem.shopcartItem.productNumber}" productOriginPrice="${shopcartItem.product.unitPrice}"></ppt:date>
    				<%-- <fmt:formatNumber value="${(user.role==CUSTOMER||user.checkStatus!=AUTHENTICATION_SUCCESS)?
    						shopcartItem.product.retailPrice*shopcartItem.shopcartItem.productNumber:shopcartItem.product.unitPrice*shopcartItem.shopcartItem.productNumber}" pattern="#0.00" /> --%></h4>
    			</div>
    		</div>
    		</c:forEach>
    	</div>
    	</c:forEach>
    </div>
    <div class="cartBottom">
    	<div class="chooseAll active">
    		<span class="radius"><i class="iconfont">&#xe611;</i></span>
    		<span>全选</span>
    	</div>
    	<div class="payDiv">
    		<span>共:<span class="allMoney">0</span></span>
    		<button class="payButtom">去结算(<span class="allNum">0</span>)</button>
    	</div>
    </div>
<%-- 
    <!-- [[购买商品-->
    <c:forEach items="${shopcartList}" var="shopcart">
    <div class="product-content">
        <div class="contact-c clearfix">
            <div class="pull-left">
                <div class="img-content">
                    <img src="${shopcart.seller.logoPic }" alt=""/>
                </div>
                <span class="company-name">${shopcart.seller.shortCompanyName }</span>
            </div>
        </div>
        <c:forEach items="${shopcart.shopcartItemList}" var="shopcartItem">
        <div class="product clearfix" id="shopcartItem${shopcartItem.shopcartItem.itemId}" data-unitPrice="${shopcartItem.product.unitPrice }" data-freight="${shopcartItem.product.freight }">
            <div class="pull-left col-xs-8">
                <div class="col-xs-4" onclick="window.location.href='<%=request.getContextPath()%>/product/productDetail?productId=${shopcartItem.product.productId }'">
                    <img src="${shopcartItem.product.cover1}" alt=""/>
                </div>
                <div class="col-xs-8">
                    <span class="name" onclick="window.location.href='<%=request.getContextPath()%>/product/productDetail?productId=${shopcartItem.product.productId }'">${shopcartItem.product.productName}</span><br />
                    <span class="specific grey">规格：${shopcartItem.product.productCode }</span><br />
		            <span class="number grey">
		               <span class="number-label">数量：</span>
		               <button class="reduce btn btn-default" onclick="changeShopcart(${shopcartItem.shopcartItem.itemId},this,'-')">-</button>
<!--		               <span class="number-count">${shopcartItem.shopcartItem.productNumber}</span>-->
					   <input class="number-count" value="${shopcartItem.shopcartItem.productNumber}"  style="width: 1rem; text-align: center;"/>
		               <button class="increase btn btn-default" onclick="changeShopcart(${shopcartItem.shopcartItem.itemId},this,'+')">+</button>
		            </span>
                </div>
            </div>
            <div class="pull-right col-xs-4 text-right">
                <span class="delete" onclick="deleteShopcart(${shopcartItem.shopcartItem.itemId})"><i class="icon iconfont">&#xe603;</i></span><br /><br />
                <span class="price red">￥
                	<c:choose>
	                   	<c:when test="${user.role==CUSTOMER||user.checkStatus!=AUTHENTICATION_SUCCESS}">
	                   		${shopcartItem.product.retailPrice }
	                   	</c:when>
	                   	<c:otherwise>
	                   		${shopcartItem.product.unitPrice }
	                   	</c:otherwise>
                   	</c:choose>	
                	</span>
            </div>
        </div>
        </c:forEach>
        <div class="account clearfix">
            <div class="pull-left">
                <div class="product-total grey">商品合计：<span class="red">￥99.99（共99件）</span></div>
                <!-- <div class="freight grey">运费合计：<span class="red">￥</span></div> -->
            </div>
        </div>
    </div>
   	</c:forEach>
    <!-- 购买商品]]--> --%>
</div>
<!--提示框 -->
<div class="tip"></div>
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
<!-- 遮罩层 -->
<div class="shade"></div>
<!-- 提示文字 -->
<div class="tip"></div>
<%--     <!-- [[结算-->
    <div class="set-account clearfix">
        <div class="pull-left">
            <div class="product-total grey">商品合计：<span class="red">￥99.99（共99件）</span></div>
            <!-- <div class="freight grey">运费合计：<span class="red">￥9.99</span></div> -->
        </div>
        <div class="pull-right">
            <a href="<%=request.getContextPath()%>/buyer/toSettleAccount">
               	去结算
            </a>
        </div>
    </div>
    <!-- 结算]]--> --%>

<%-- <jsp:include page="/jsp/buyer/footer.jsp"></jsp:include> --%>
<%@ include file="/cs.jsp" %>
<%CS cs = new CS(1261321176);cs.setHttpServlet(request,response);
String imgurl = cs.trackPageView();%> 
<img src="<%= imgurl %>" width="0" height="0"  />
<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
<script src="<%=request.getContextPath()%>/resources/common/count.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/jweixin-1.0.0.js"></script>
<script>
	$(this).addClass("active");
	$(".shopName").addClass("active");
	$(".commodity").addClass("active");
	countCart();
	//开始删除操作
	var data_id=0;
	$(document).on("tap",".delIcon",function(){
		$("#delete").show();
		$(".shade").show();
		data_id=$(this).parent().parent().attr("data-id");
	});
	$("#confirm").tap(function(){
		/* 用ajax将此数据删除*/
		deleteShopcart(data_id);
		
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
	//结束删除操作
	//开始选择操作
	$(document).on("tap",".shopI",function(){
		var dot=$(this).parent();
		
		if(dot.hasClass("active")){
			$(".chooseAll").removeClass("active");	
			
			dot.removeClass("active");
			dot.parent().find(".commodity").removeClass("active");
			
		}else{
			
			dot.addClass("active");
			dot.parent().find(".commodity").addClass("active");
			
			var flag=true;
			$(".shopName").each(function(){
				if(!$(this).hasClass("active")){
					flag=false;
					return false;
				}
			});
			if(flag){
				$(".chooseAll").addClass("active");
			}
		}
		countCart();
	});
	$(document).on("tap",".oneI",function(){
		var dot=$(this).parent();
		if(dot.hasClass("active")){
			dot.removeClass("active");
			dot.parent().find(".shopName").removeClass("active");
			$(".chooseAll").removeClass("active");
		}else{
			dot.addClass("active");
			var flag=true;
			dot.parent().find(".commodity").each(function(){
				if(!$(this).hasClass("active")){
					flag=false;
					return false;
				}
			});
			if(flag){
				dot.parent().find(".shopName").addClass("active");
				var flag1=true;
				$(".shopName").each(function(){
					if(!$(this).hasClass("active")){
						flag1=false;
						return false;
					}
				});
				if(flag1){
					$(".chooseAll").addClass("active");
				}
			}
		}
		countCart();
	});
	$(".chooseAll").tap(function(){
		if($(this).hasClass("active")){
			$(this).removeClass("active");
			$(".shopName").removeClass("active");
			$(".commodity").removeClass("active");
			$(".allNum").html("0");
			$(".allMoney").html("￥0");
		}else{
			$(this).addClass("active");
			$(".shopName").addClass("active");
			$(".commodity").addClass("active");
			countCart();
		}
	});
	//结束选择操作
	//开始调整数量
	 $(document).on("tap",".reduce",function(){
		 if($(this).next().val()==1){
			 $(".tip").html("数量不能小于1！");
			 $(".tip").css("opacity","0.8");
			 setTimeout(function(){
				 $(".tip").html("");
				$(".tip").css("opacity","0");
			 },1000); 
		 }else{
			 $(this).next().val(parseInt($(this).next().val())-1);
			 changeShopcart($(this).parents(".commodity ").attr("data-id"),$(this).next().val());
		 }
		 countCart();
	 });
	 $(document).on("tap",".increase",function(){
		 /* if($(this).prev().val()==$(this).prev().attr("maxData")){
			 $(".tip").html("数量不能大于库存量"+$(this).prev().attr("maxData")+"！");
			 $(".tip").css("opacity","0.8");
			 setTimeout(function(){
				$(".tip").html("");
				$(".tip").css("opacity","0");
			 },1000); 
		 }else{ */
			 $(this).prev().val(parseInt($(this).prev().val())+1);
			 changeShopcart($(this).parents(".commodity ").attr("data-id"),$(this).prev().val());
		 /* } */
		 countCart();
	 });
	 $(document).on("change",".num",function(){
		 var act=$(this).parent().parent().parent();
		 if(parseInt($(this).val())>parseInt($(this).attr("maxData"))||parseInt($(this).val())<=0){
			 /* if(parseInt($(this).val())>parseInt($(this).attr("maxData"))){
			 	$(".tip").html("数量不能大于库存量"+$(this).attr("maxData")+"！");
			 	$(this).val($(this).attr("maxData"));
			 }else */if(parseInt($(this).val())<=0){
	 			 $(".tip").html("数量不能小于1");
	 			 $(this).val(1);
			 }
			 $(".tip").css("opacity","0.8");
			 setTimeout(function(){
				 $(".tip").html("");
				$(".tip").css("opacity","0");
			 },1000); 
		 }
		 changeShopcart($(this).parents(".commodity ").attr("data-id"),$(this).val());
		 countCart();
	 });
	//结束调整数量
	//控制商品的显示和隐藏
	$(document).on("tap",".shopName",function(e){
		if(!$(e.target).closest(".shopI").length!=0&&!$(e.target).closest("a").length!=0){
			if($(this).find(".show").hasClass("rotate")){
				$(this).find(".show").removeClass("rotate");
				$(this).parent().find(".commodity").css("display","block");
			}else{
				$(this).find(".show").addClass("rotate");
				$(this).parent().find(".commodity").css("display","none");
			}
		}
	});
	
	function changeShopcart(shopcartItemId,number){
		var url="<%=request.getContextPath()%>/shopcart/changeShopcartNumber";
		
		var params={itemId:shopcartItemId,num:number};
		doAjax("GET",url,params,changeSuccess,changeFail,false,false);
	}
	
	function changeSuccess(data){
		var shopcartItem=$("#shopcartItem"+data.data.itemId);
		shopcartItem.find(".number-count").val(data.data.productNumber);
		//shopcartItem.find(".price").html("￥"+(parseFloat(shopcartItem.attr("data-unitPrice"))*data.data.productNumber).toFixed(2));
		calculte();
	}
	
	function changeFail(data){
		alert("fail");
	}
	
	function deleteShopcart(itemId){
		var url="<%=request.getContextPath()%>/shopcart/deleteShopcart";
		var params={itemId:itemId};
		doAjax("GET",url,params,deleteSuccess,deleteFail,true,false);
	}
	
	function deleteSuccess(data){
		if($(".commodity[data-id='"+data_id+"']").parent().find(".commodity").length==1){
			$(".commodity[data-id='"+data_id+"']").parent().remove();
			if($(".oneShop").length==0){
				//购物车已被清空，页面跳转至购物车为空的页面
				$(".chooseAll").removeClass("active");
				location.reload();
			}
		}else{
			$(".commodity[data-id='"+data_id+"']").remove();
		}
		countCart();
	}
	
	function deleteFail(){
		alert(fail);
	}
	
	$(function(){
		calculte();
	});
	
	$(".prevPage").tap(function(){
		history.go(-1);
	});
	
	//统计总价，运费等
	function calculte(){
		var totalProductNum=0;
		var totalMoney=0;
		var totalPostage=0;
		$(".product-content").each(function(){
			var numbers=0;
			var moneys=0;
			var freight=0;
			$(this).find(".product").each(function(){
				numbers = numbers+parseInt($(this).find(".number-count").val());
				moneys = moneys+parseFloat($(this).find(".price").html().match(/\d+(\.\d+)?/g))*parseFloat($(this).find(".number-count").val());
				freight+=parseFloat($(this).attr("data-freight"))*parseFloat($(this).find(".number-count").val());
			});
			
			moneys=moneys.toFixed(2);
			$(this).find(".product-total .red").html("￥"+moneys+"（共"+numbers+"件）");
			totalProductNum=totalProductNum+numbers;
			totalMoney=parseFloat(totalMoney)+parseFloat(moneys);
			
			$(this).find(".freight .red").html("￥"+freight.toFixed(2));
			totalPostage=(parseFloat(totalPostage)+freight).toFixed(2);
		});
		
		//格式化结果
		totalMoney=totalMoney.toFixed(2);
		$(".set-account").find(".product-total").html("商品合计：￥"+totalMoney+"（共"+totalProductNum+"件）");
		$(".set-account").find(".freight").html("运费合计：￥"+totalPostage);
		
		return totalMoney;
	}
	
	function countCart(){
		var totalCount=0;
		var totalMoney=0;
		$(".commodity").each(function(){
			var percent="${percent}";
			var numInput = $(this).find(".num");
			var roleFlag="${(user.role==CUSTOMER||user.role==RETAIL_SALES||user.checkStatus!=AUTHENTICATION_SUCCESS)}";
			if(percent==""||roleFlag=="true")
				$(this).find(".cartRight h4").html("￥"+(parseFloat(numInput.attr("data-price"))*parseInt(numInput.val())).toFixed(2));
			else
				$(this).find(".cartRight h4").html("￥"+(parseFloat(parseFloat(numInput.attr("data-price"))+Math.ceil(parseFloat(numInput.attr("data-originPrice"))*percent))*parseInt(numInput.val())).toFixed(2));
				
			if($(this).hasClass("active")){
				totalCount+=parseInt(numInput.val());
				totalMoney+=parseFloat($(this).find(".cartRight h4").html().match(/\d+(\.\d+)?/g));
			}
		});
		$(".allMoney").html("￥"+totalMoney.toFixed(2));
		$(".allNum").html(totalCount);
		share();
	}
	
	function getShopcartIdList(){
		var shopcartIdList="";
		$(".commodity").each(function(){
			if($(this).hasClass("active")){
				shopcartIdList+=$(this).attr("data-id")+",";
			}
		});	
		return shopcartIdList.substring(0,shopcartIdList.length-1);
	}
	
	$(".payButtom").tap(function(){
		if(${!empty sessionScope.openId && user.role!=9}){
			var shopcartIdList=getShopcartIdList();
			if(shopcartIdList!="")
				window.location.href='<%=request.getContextPath()%>/buyer/toSettleAccount?shopcartIdList='+shopcartIdList;
			else{
				showTip("至少选择一件商品");
			}
		}else{
			alert("不能购买");
		}
	});
	
	function showTip(text){
		$(".tip").html(text);
		$(".tip").css("opacity","0.8");
		setTimeout(function(){
			$(".tip").css("opacity","0");
		},1000);
	}
	
	function share(){
		var productList="";
		var numberList="";
		$(".commodity").each(function(){
			if($(this).hasClass("active")){
				productList+=$(this).attr("data-product-id")+",";
				numberList+=$(this).find(".num").val()+",";
			}
		});	
		productList=productList.substring(0,productList.length-1);
		numberList=numberList.substring(0,numberList.length-1);
		console.log("<%=request.getContextPath()%>/shopcart/shareShopcart?itemList="+productList+
				"&numberList="+numberList);
		/* 
		alert(productList);
		alert(numberList); */

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
			        jsApiList: ['onMenuShareTimeline','onMenuShareAppMessage'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
			    });
			    wx.ready(function(){
					wx.onMenuShareTimeline({
					    title: '购物车', // 分享标题
					    link: 'http://lanmao.zhuanlitou.com/shopcart/shareShopcart?itemList='+
					    		productList+'&numberList='+numberList, // 分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
					    imgUrl: 'http://lanmao.zhuanlitou.com/resources/customer/assets/images/logo.jpg', // 分享图标
					    success: function () { 
					        // 用户确认分享后执行的回调函数
					    },
					    cancel: function () { 
					        // 用户取消分享后执行的回调函数
					    }
					});
					wx.onMenuShareAppMessage({
					    title: '购物车', // 分享标题
					    link: 'http://lanmao.zhuanlitou.com/shopcart/shareShopcart?itemList='+
					    		productList+'&numberList='+numberList, // 分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
					    imgUrl: 'http://lanmao.zhuanlitou.com/resources/customer/assets/images/logo.jpg', // 分享图标
					    success: function () { 
					        // 用户确认分享后执行的回调函数
					    },
					    cancel: function () { 
					        // 用户取消分享后执行的回调函数
					    }
					});
			    });
			}
		}); // end ajax   
		
	}
</script>
</body>
</html>