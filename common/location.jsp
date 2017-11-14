<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib prefix="thumbnail" uri="/WEB-INF/tld/thumbnailTag.tld"%>

<!DOCTYPE html>
<html class="balanceHtml">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>金明同达灯饰</title>
    <link href="<%=request.getContextPath() %>/resources/common/swiper.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/customer/assets/css/orderCart.css" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
</head>
<body class="balanceBody">
<c:set var="SALES_SORT" value="<%=ProductSortType.SALES_SORT%>" />
<c:set var="NEW_SORT" value="<%=ProductSortType.NEW_SORT%>" />
<c:set var="PRICE_SORT" value="<%=ProductSortType.PRICE_SORT%>" />
<c:set var="CUSTOMER" value="<%=UserType.CUSTOMER%>" />
<c:set var="AUTHENTICATION_SUCCESS" value="<%=UserCheckStatus.AUTHENTICATION_SUCCESS%>" />
<div class="balance">
	<div class="swiper-container payContainer">
        <div class="swiper-wrapper">
            <div class="swiper-slide swiper-no-swiping paySlider">
				<div class="title" id="title"><i class="iconfont prevPage payPrev" >&#xe624;</i>结算中心</div>
				<div class="payOrder">
					<div class="payAddress" <c:if test="${empty receiveAddress }">style="display:none"</c:if>>
						<div class="left"><i class="iconfont">&#xe608;</i></div>
						<div class="middle">
							<div class="namePhone">
								<span class="name">联系人：${receiveAddress.receiveAddress.receivePerson}</span>
								<span class="phone">${receiveAddress.receiveAddress.contactNumber}</span>
							</div>
							<div class="address" data-id="${receiveAddress.receiveAddress.receiveAddressId }">联系地址：
								<span class="province">${receiveAddress.province}</span>
								<span class="city">${receiveAddress.city}</span>
								<span class="area">${receiveAddress.area}</span>
								<span class="addressDetail">${receiveAddress.receiveAddress.addressDetail }</span>
							</div>
						</div>
						<div class="right"><i class="iconfont">&#xe624;</i></div>
					</div>
					<!-- 开始没有收货地址 -->
					<div class="noAddress" <c:if test="${!empty receiveAddress }">style="display:none"</c:if>>
						<div><i class="iconfont">&#xe639;</i></div>
						<p>还没有收货地址，<a href="#">去添加</a></p>
					</div>
					<!-- 结束没有收货地址 -->
					<input type="hidden" name="isInstall" value="0"/>
					<input type="hidden" name="transportType" value="0"/>
			    	<div class="allOrder">
			    		<c:forEach items="${shopcartList}" var="shopcart">
			    		<div class="shopOrder">
				    		<div class="shopName">
					    		<a href="<%=request.getContextPath()%>/product/shopProductList?shopId=${shopcart.seller.userId}">
					    			<span><i class="iconfont">&#xe606;</i>${shopcart.seller.shortCompanyName}</span>
					    		</a>
					    		<i class="iconfont show">&#xe624;</i>
					    	</div>
					    	<c:forEach items="${shopcart.shopcartItemList}" var="shopcartItem">
				    		<div class="commodity" data-installPrice="${shopcartItem.product.installPrice*shopcartItem.shopcartItem.productNumber}"
				    			data-money="${((user.role==CUSTOMER||user.checkStatus!=AUTHENTICATION_SUCCESS)?shopcartItem.product.retailPrice:shopcartItem.product.unitPrice)*shopcartItem.shopcartItem.productNumber}">
				    			<img src="<thumbnail:date value="${shopcartItem.product.cover1}"/>"/>
				    			<div class="commDiv">
				    				<p><a href="<%=request.getContextPath()%>/product/productDetail?productId=${shopcartItem.product.productId}">${shopcartItem.product.productName}</a></p>
					    			<div class="moneyNum">
					    				<h4>￥${(user.role==CUSTOMER||user.checkStatus!=AUTHENTICATION_SUCCESS)?shopcartItem.product.retailPrice:shopcartItem.product.unitPrice}</h4>
					    				<span><font>X</font>${shopcartItem.shopcartItem.productNumber}</span>
					    			</div>
				    			</div>
				    		</div>
				    		</c:forEach>
				    	</div>
				    	</c:forEach>
			    	</div>
			    	<%-- <c:if test="${user.role==CUSTOMER||user.checkStatus!=AUTHENTICATION_SUCCESS }">
			    	 --%>
			    	<div class="ps">
			    		<div class="RemmLogistics">
			    			<input type="text" name="suggestLogistics" placeHolder="请输入建议发货物流公司">
			    		</div>
			    		<c:if test="${user.role==CUSTOMER||user.checkStatus!=AUTHENTICATION_SUCCESS }">
			    		<div class="install">
				    		<span class="check"><i class="iconfont">&#xe611;</i></span>
				    		<span>上门安装(￥<span id="installMoney"></span>)</span>
				    	</div>
				    	</c:if>
				    	<div class="delivery">
				    		<span class="check"><i class="iconfont">&#xe611;</i></span>
				    		<span>是否自提商品</span>
				    	</div>
			    	</div>
			    	<%-- </c:if> --%>
			    	<div class="orderBottom">
				    	<div class="allMoney">
				    		<span>合计：<span>￥<span id="moneySpan"></span></span></span>
				    	</div>
				    	<button class="payOrder" id="payOrderBtn">提交订单</button>
				    </div>
				</div>
			</div>
			<div class="swiper-slide swiper-no-swiping addressSlider">
				<div class="title"><i class="iconfont prevPage normalPrev">&#xe624;</i>管理收货地址</div>
				<div class="addressList">
					
				</div>
				<div class="emptyAddress empty">
				    <i class="iconfont">&#xe639;</i>
				    <p>还没有添加地址哦！</p>
			    </div>
			</div>
			<div class="swiper-slide swiper-no-swiping addAddressSlider">
				<div class="title"><i class="iconfont prevPage normalPrev" >&#xe624;</i>
					<span id="addressTitle">新增收货地址</span></div>
				<form>
					<input type="hidden" name="receiveAddressId"/>
					<input type="hidden" name="userId"/>
					<input type="hidden" name="defaultFlag"/>
					<table class="formTable">
						<tr>
							<td>联系人</td>
							<td><input id="contactName" name="receivePerson" type="text" value="" data-name="联系人"/></td>
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
<div class="shade"></div>
<div class="tip"></div>
<!-- 等待加载 -->
<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/swiper.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
<script>

</script>
</body>
</html>