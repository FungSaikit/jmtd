<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>佐为照明</title>
    <link href="<%=request.getContextPath() %>/resources/common/bootstrap.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/common/swiper.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/customer/assets/css/orderCart.css" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
</head>
<body>
<c:set var="SALES_SORT" value="<%=ProductSortType.SALES_SORT%>" />
<c:set var="NEW_SORT" value="<%=ProductSortType.NEW_SORT%>" />
<c:set var="PRICE_SORT" value="<%=ProductSortType.PRICE_SORT%>" />
<c:set var="CUSTOMER" value="<%=UserType.CUSTOMER%>" />
<c:set var="AUTHENTICATION_SUCCESS" value="<%=UserCheckStatus.AUTHENTICATION_SUCCESS%>" />
<div class="cart">
    <div class="title">购物车</div>

    <!-- [[购买商品-->
    <c:forEach items="${shopcartList}" var="shopcart">
    <div class="product-content">
        <div class="contact-c clearfix">
            <div class="pull-left">
                <div class="img-content">
                    <img src="${shopcart.seller.userProtraitPic }" alt=""/>
                </div>
                <span class="company-name">${shopcart.seller.companyName }</span>
            </div>
        </div>
        <c:forEach items="${shopcart.shopcartItemList}" var="shopcartItem">
        <div class="product clearfix" id="shopcartItem${shopcartItem.shopcartItem.itemId}" data-unitPrice="${shopcartItem.product.unitPrice }" data-freight="${shopcartItem.product.freight }">
            <div class="pull-left col-xs-8">
                <div class="col-xs-4">
                    <img src="${shopcartItem.product.cover1}" alt=""/>
                </div>
                <div class="col-xs-8">
                    <span class="name">${shopcartItem.product.productName}</span><br />
                    <span class="specific grey">规格：${shopcartItem.product.productCode }</span><br />
		            <span class="number grey">
		               <span class="number-label">数量：</span>
		               <button class="reduce btn btn-default" onclick="changeShopcart(${shopcartItem.shopcartItem.itemId},this,'-')">-</button>
		               <span class="number-count">${shopcartItem.shopcartItem.productNumber}</span>
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
                <div class="freight grey">运费合计：<span class="red">￥</span></div>
            </div>
        </div>
    </div>
   	</c:forEach>
    <!-- 购买商品]]-->
    
    <!-- [[结算-->
    <div class="set-account clearfix">
        <div class="pull-left">
            <div class="product-total grey">商品合计：<span class="red">￥99.99（共99件）</span></div>
            <div class="freight grey">运费合计：<span class="red">￥9.99</span></div>
        </div>
        <div class="pull-right">
            <a href="<%=request.getContextPath()%>/buyer/toSettleAccount">
                <button class="btn btn-primary">去结算</button>
            </a>
        </div>
    </div>
    <!-- 结算]]-->
</div>

<jsp:include page="/jsp/buyer/footer.jsp"></jsp:include>
<script>
	function changeShopcart(shopcartItemId,obj,sign){
		var url="<%=request.getContextPath()%>/shopcart/changeShopcartNumber";
		var number=$(obj).siblings(".number-count").html();
		if(sign==="+")
			number=parseInt(number)+1;
		else
			number=parseInt(number)-1;
		
		var params={itemId:shopcartItemId,num:number};
		doAjax("GET",url,params,changeSuccess,changeFail,false,false);
	}
	
	function changeSuccess(data){
		var shopcartItem=$("#shopcartItem"+data.data.itemId);
		shopcartItem.find(".number-count").html(data.data.productNumber);
		//shopcartItem.find(".price").html("￥"+(parseFloat(shopcartItem.attr("data-unitPrice"))*data.data.productNumber).toFixed(2));
		calculte();
	}
	
	function changeFail(data){
		alert("faile");
	}
	
	function deleteShopcart(itemId){
		if(confirm("确认删除？")){
			var url="<%=request.getContextPath()%>/shopcart/deleteShopcart";
			var params={itemId:itemId};
			doAjax("GET",url,params,deleteSuccess,deleteFail,false,false);
		}
	}
	
	function deleteSuccess(data){
		if(data.data.shopcartId==0){
			$("#shopcartItem"+data.data.itemId).parents(".product-content").remove();
		}else{
			$("#shopcartItem"+data.data.itemId).remove();
		}
		if(calculte()==0.00)
			location.reload();
		
	}
	
	function deleteFail(){
		alert(fail);
	}
	
	$(function(){
		calculte();
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
				numbers = numbers+parseInt($(this).find(".number-count").html());
				moneys = moneys+parseFloat($(this).find(".price").html().match(/\d+(\.\d+)?/g))*parseFloat($(this).find(".number-count").html());
				freight+=parseFloat($(this).attr("data-freight"))*parseFloat($(this).find(".number-count").html());
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
</script>
</body>
</html>