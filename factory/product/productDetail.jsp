<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib prefix="thumbnail" uri="/WEB-INF/tld/thumbnailTag.tld"%>

<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
		 <meta name="format-detection" content="telephone=yes">
		<title>佐为照明</title>
		<link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
		<link href="<%=request.getContextPath() %>/resources/customer/assets/css/product.css?411" rel="stylesheet">
		<link href="<%=request.getContextPath() %>/resources/common/swiper.min.css" rel="stylesheet">
		<script src="<%=request.getContextPath() %>/resources/config.js"></script>
		
	</head>

	<body>
		<c:set var="PRICE_SORT" value="<%=ProductSortType.PRICE_SORT%>" />
		<c:set var="CUSTOMER" value="<%=UserType.CUSTOMER%>" />
		<%-- 
	<c:set var="AGENCY" value="<%=UserType.AGENCY%>" />
		<c:set var="SALESMAN" value="<%=UserType.SALESMAN%>" />
		<c:set var="FACILITATOR" value="<%=UserType.FACILITATOR%>" /> --%>
		<c:set var="AUTHENTICATION_SUCCESS" value="<%=UserCheckStatus.AUTHENTICATION_SUCCESS%>" />
		<div class="productDetail">
			<div class="title">
				<ul>
					<li class="active">商品</li>
					<li>详情</li>
					<li>评价</li>
				</ul>
				<i class="iconfont back">&#xe624;</i>
				
			</div>
			<!--[[轮播图-->
			<div class="swiper-container menuSwiper">
				<div class="swiper-wrapper ">
					<div class="swiper-slide goods">
						<!--[[轮播图-->
						<div class="swiper-container carousel">
							<div class="swiper-wrapper">
								<c:if test="${!empty product.product.cover1 }">
									<div class="swiper-slide">
										<a href="#"><div class="backImage"><img src="${product.product.cover1 }"></div></a>
									</div>
								</c:if>
								<c:if test="${!empty product.product.cover2 }">
									<div class="swiper-slide">
										<a href="#"><div class="backImage"><img src="${product.product.cover2 }"></div></a>
									</div>
								</c:if>
								<c:if test="${!empty product.product.cover3 }">
									<div class="swiper-slide">
										<a href="#"><div class="backImage"><img src="${product.product.cover3 }"></div></a>
									</div>
								</c:if>
								<c:if test="${!empty product.product.cover4 }">
									<div class="swiper-slide">
										<a href="#"><div class="backImage"><img src="${product.product.cover4 }"></div></a>
									</div>
								</c:if>
								<c:if test="${!empty product.product.cover5 }">
									<div class="swiper-slide">
										<a href="#"><div class="backImage"><img src="${product.product.cover5 }"></div></a>
									</div>
								</c:if>
							</div>
							<div class="swiper-pagination"></div>
						</div>
						<!--轮播图]]-->
						<!--[[产品信息-->
						<div class="product-msg">
							<div class="product-name">${product.product.productName }<span class="hasOrNot"><c:choose><c:when test="${product.product.productKind==1}">现货</c:when><c:otherwise>订货</c:otherwise></c:choose></span></div>
							<div class="productInfo">
								<div class="red" style="font-weight:bold;font-size:0.6rem;">￥${product.product.originUnitPrice}</div>
								<div class="productSales">销量：${product.product.productSales }</div>
							</div>
							<div class="numDiv1">
								<div class="pull-left numDiv">
									<span>数量：</span>
									<span class="change-num reduce btn btn-default">-</span>
										<input class="num"  value="1"/>
									<span class="change-num increase btn btn-default">+</span>
								</div>
								<div class="productStock">库存：<span id="num">${product.product.productStock }</span></div>
							</div>
						</div>
						<!--产品信息]]-->
						<div class="series">
							<div>
								<p>同系列产品</p>
								<span class="showprice hide" data-price="${product.product.originUnitPrice }"><!-- <i class="iconfont">&#xe628;</i> --></span>
							</div>
							<ul class="seriesUl">
								<c:forEach items="${seriesList }" var="seriesProduct">
								<c:if test="${!((buyer.role==CUSTOMER||buyer.checkStatus!=AUTHENTICATION_SUCCESS)&&seriesProduct.productKind==0) }">
								<li data-id="${seriesProduct.productId }" <c:if test="${seriesProduct.productId==product.product.productId }">class="active"</c:if>>
									<a>
										<img src="<thumbnail:date value="${seriesProduct.cover1 }"/>"/>
										<span>${seriesProduct.productCode }</span>
									</a>
								</li>
								</c:if>
								</c:forEach>
								
							</ul>
						</div>
						<!--[[店铺-->
						<div class="shop">
							<div class="imgDiv">
								<div class="img-content">
									<img src="${factory.logoPic }">
								</div>
								<span class="shop-name">${factory.shortCompanyName}</span>
							</div>
							<div class="btnDiv">
								<a href="<%=request.getContextPath()%>/product/shopProductList?shopId=${factory.userId}" class="sameFactory">
						           <i class="icon iconfont">&#xe606;</i>同厂产品
						        </a>
							</div>
						</div>
						<!--店铺]]-->
						<!-- 开始产品数据和售后服务 -->
						<div class="info">
							<ul class="infoMenu">
								<li class="active">规格参数</li>
								<li>售后服务</li>
							</ul>
							<div class="swiper-container infoSwiper">
						        <div class="swiper-wrapper" id="warpper">
						            <div class="swiper-slide">
										<ul class="values">
											<li>
												<span>展厅编号</span>
												<span>-</span>
											</li>
											<li>
												<span>品牌</span>
												<span>${factory.shortCompanyName }</span>
											</li>
											<li>
												<span>类型</span>
												<span>${product.type }</span>
											</li>
											<li>
												<span>材质</span>
												<span>${product.material }</span>
											</li>
											<li>
												<span>风格</span>
												<span>${product.style }</span>
											</li>
											<li>
												<span>光源类型</span>
												<span>${product.product.lightType }</span>
											</li>
											<li>
												<span>光源数量</span>
												<span id="lightNumber">${product.product.lightNumber }</span>
											</li>
											<li>
												<span>空间</span>
												<span id="space">${product.space }</span>
											</li>
											<li>
												<span>颜色</span>
												<span id="productColor">${product.product.productColor }</span>
											</li>
											<li>
												<span>型号</span>
												<span id="productCode">${product.product.productCode }</span>
											</li>
											<li>
												<span>产品尺寸(mm)</span>
												<span id="productSize">
													<c:if test="${!empty product.product.productLength }">L:<fmt:formatNumber value=" ${product.product.productLength }" pattern="#0"/>*</c:if>
													<c:if test="${!empty product.product.productWidth }">W:<fmt:formatNumber value=" ${product.product.productWidth }" pattern="#0"/>*</c:if>	
													<c:if test="${!empty product.product.productHeight }">H:<fmt:formatNumber value="${product.product.productHeight }" pattern="#0"/><c:if test="${!empty product.product.productDiameter }">*</c:if></c:if>
													<c:if test="${!empty product.product.productDiameter }">D:<fmt:formatNumber value=" ${product.product.productDiameter}" pattern="#0"/></c:if></span>
											</li>
											<li>
												<span>净重(kg)</span>
												<span id="productWeight">${product.product.productWeight}</span>
											</li>
											<li>
												<span>包装尺寸(cm)</span>
												<span id="packageSize">
													<c:if test="${!empty product.product.packageLength }">L:<fmt:formatNumber  value="${product.product.packageLength }" pattern="#0"/>*</c:if>
													<c:if test="${!empty product.product.packageWidth }">W:<fmt:formatNumber value="${product.product.packageWidth }" pattern="#0"/>*</c:if>
													<c:if test="${!empty product.product.packageHeight }">H:<fmt:formatNumber value=" ${product.product.packageHeight }" pattern="#0"/></c:if>
												</span>
											</li>
											<li>
												<span>毛重(kg)</span>
												<span id="packageWeight">
													${product.product.packageWeight }
												</span>
											</li>
										</ul>
										
									</div>
						            <div class="swiper-slide maxHeight scroll">
										<ul class="values contact">
											<li>
												<span><i class="iconfont">&#xe608;</i>地址</span>
												<span>${user.companyAddressDetail }</span>
											</li>
											<li>
												<span><i class="iconfont">&#xe60d;</i>联系人</span>
												<span>${user.legalPersonName }</span>
											</li>
											<li>
												<span><i class="iconfont">&#xe60f;</i>联系方式</span>
												<span>${user.phoneNumber }</span>
											</li>
											<li>
												<span><i class="iconfont">&#xe609;</i>固定电话</span>
												<span>${user.contact }</span>
											</li>
											<li>
												<span><i class="iconfont">&#xe60e;</i>微信</span>
												<span>${user.wechatNumber }</span>
											</li>
											<li>
												<span><i class="iconfont">&#xe607;</i>QQ</span>
												<span>${user.qqNumber }</span>
											</li>
											<li>
												<span><i class="iconfont">&#xe60c;</i>邮箱</span>
												<span>${user.email }</span>
											</li>
										</ul>
									</div>
						        </div>
						    </div>
					    </div>
						<!-- 结束产品数据和售后服务 -->
					</div>
					<div class="swiper-slide imagesScroll scrollDiv">
		            	<div class="images">
							  <c:if test="${!empty product.product.productContent }"><p>${product.product.productContent}</p></c:if>
							  <c:if test="${!empty product.product.descriptionPic1 }"><img src="<%=request.getContextPath() %>/resources/customer/assets/images/defaultImg.jpg" alt="" data-show="false" data-img="${product.product.descriptionPic1 }"/></c:if>
			                  <c:if test="${!empty product.product.descriptionPic2 }"><img src="<%=request.getContextPath() %>/resources/customer/assets/images/defaultImg.jpg" alt="" data-show="false" data-img="${product.product.descriptionPic2 }"/></c:if>
			                  <c:if test="${!empty product.product.descriptionPic3 }"><img src="<%=request.getContextPath() %>/resources/customer/assets/images/defaultImg.jpg" alt="" data-show="false" data-img="${product.product.descriptionPic3 }"/></c:if>
			                  <c:if test="${!empty product.product.descriptionPic4 }"><img src="<%=request.getContextPath() %>/resources/customer/assets/images/defaultImg.jpg" alt="" data-show="false" data-img="${product.product.descriptionPic4 }"/></c:if>
			                  <c:if test="${!empty product.product.descriptionPic5 }"><img src="<%=request.getContextPath() %>/resources/customer/assets/images/defaultImg.jpg" alt="" data-show="false" data-img="${product.product.descriptionPic5 }"/></c:if>
			                  <c:if test="${!empty product.product.descriptionPic6 }"><img src="<%=request.getContextPath() %>/resources/customer/assets/images/defaultImg.jpg" alt="" data-show="false" data-img="${product.product.descriptionPic6 }"/></c:if>
			                  <c:if test="${!empty product.product.descriptionPic7 }"><img src="<%=request.getContextPath() %>/resources/customer/assets/images/defaultImg.jpg" alt="" data-show="false" data-img="${product.product.descriptionPic7 }"/></c:if>
			                  <c:if test="${!empty product.product.descriptionPic8 }"><img src="<%=request.getContextPath() %>/resources/customer/assets/images/defaultImg.jpg" alt="" data-show="false" data-img="${product.product.descriptionPic8 }"/></c:if>
			                  <c:if test="${!empty product.product.descriptionPic9 }"><img src="<%=request.getContextPath() %>/resources/customer/assets/images/defaultImg.jpg" alt="" data-show="false" data-img="${product.product.descriptionPic9 }"/></c:if>
			                  <c:if test="${!empty product.product.descriptionPic10 }"><img src="<%=request.getContextPath() %>/resources/customer/assets/images/defaultImg.jpg" alt="" data-show="false" data-img="${product.product.descriptionPic10 }"/></c:if>
						</div>
		            </div>	
					<div class="swiper-slide comment scroll">
						<a href="javascript:baiduMap()">一键导航</a>
						功能正在完善中，请耐心等候...
					</div>
				</div>
			</div>
			<!--[[信息-->
			
		</div>
		<!--提示框 -->
		<div class="tip"></div>
		<div class="moveCart"></div>
		<!--[[底部-->
		<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
		<script src="<%=request.getContextPath() %>/resources/common/swiper.min.js"></script>
		<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
		<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
		<script src="<%=request.getContextPath() %>/resources/common/jweixin-1.0.0.js"></script><!-- 
		<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=6OqF8pnZwtLqg8qlhwh1wyN4"></script> -->
		<!--底部]]-->
		<script>
			$(".service").click(function(e){
				$(".dropdown-menu").toggle()
				e.stopPropagation();
			})
			
			$("body").click(function(){
				$(".dropdown-menu").hide()
			})
			
			function countShopcart(){
				var url="<%=request.getContextPath()%>/shopcart/countShopCartNum";
				doAjax("GET",url,{},countSuccess,fail,true,false);
			}
			
			function countSuccess(data){
				if(data.data!=0){
					$("#all").html(data.data);
					$("#all").css("visibility","visible");
				}
			}
			countShopcart();
			
			var productId=${product.product.productId};
			function addShopcart() {
				if($(".num").val()<=parseInt($("#num").text())){
					var url = "<%=request.getContextPath()%>/shopcart/addShopcart";
					var params = {productId: productId,num:$(".num").val()}
					doAjax("GET", url, params, success, fail, true, false);
				}
				else{
					$(".tip").html("添加数量不能多于库存量！");
					$(".tip").css("opacity","0.8");
					setTimeout(function(){
						$(".tip").css("opacity","0");
					},1000);
				}
			}
			var addTime,plusTime;
			function success(data) {
				$(".tip").html("成功加入购物车！");
				$(".tip").css("opacity","0.8");
				addTime=setTimeout(function(){
					$(".tip").css("opacity","0");
				},1000);
				
			    $("#add").html($(".num").val()); 
				$(".add").addClass("scale");
				plusTime=setTimeout(function(){
					$(".add").removeClass("scale");
				},2700);
				
				setTimeout(function(){
					$("#all").html(($("#all").html()==""?0:parseInt($("#all").html()))+parseInt($(".num").val())); 
					$("#all").css("visibility","visible");
				},2000);
				
				$(".moveCart").addClass("move");
				plusTime=setTimeout(function(){
					$(".moveCart").removeClass("move");
				},1700);
			}

			function fail(data) {
				$(".tip").html("系统繁忙！ 请稍后再试");
				$(".tip").css("opacity","0.8");
				setTimeout(function(){
					$(".tip").css("opacity","0");
				},1000);
			}
//			$(".change-num").click(function() {
//				if ($(this).hasClass("reduce")) {
//					if ($(".num").html() != 1)
//						$(".num").html(parseInt($(".num").html()) - 1);
//				} else
//					$(".num").html(parseInt($(".num").html()) + 1);
//			})
//			$(".num").keydown(function(e){
//				if(e.keyCode<48||e.keyCode>57 && e.keyCode!=67){
//					return false;
//				}
//			})

			$(".change-num").click(function() {
				if ($(this).hasClass("reduce")) {
					if ($(".num").val() != 1)
						$(".num").val(parseInt($(".num").val()) - 1);
				} else if($(".num").val()<parseInt($("#num").text())){
					$(".num").val(parseInt($(".num").val()) + 1);
				}else{
					$(".tip").html("添加数量不能多于库存量！");
					$(".tip").css("opacity","0.8");
					setTimeout(function(){
						$(".tip").css("opacity","0");
					},1000);
				}
			})
			
			function buyImmediately(){
				window.location.href='<%=request.getContextPath() %>/buyer/buyImmediately?productId='+productId+
						'&num='+$(".num").val();
			}
			
			$(".seriesUl li").tap(function(){
				if(!$(this).hasClass("active")){
					$(".seriesUl li").removeClass("active");
					$(this).addClass("active");
					changeProduct($(this).attr("data-id"));
				}
				//window.location.href='<%=request.getContextPath()%>/product/productDetail?productId='+$(this).attr("data-id");
			});
			
			$(".back").tap(function(){
				if(document.referrer=="")
					window.location.href="<%=request.getContextPath()%>/product/productList";
				else
					history.go(-1);
			});
			
			$("#phoneKe").tap(function(){
				window.location.href='tel:${service.phoneNumber}';
				
			});
			
			$(".topCart").tap(function(){
				window.location.href="<%=request.getContextPath()%>/shopcart/myShopcart";
			});
			
			function changeProduct(productId){
				var url="<%=request.getContextPath()%>/product/getProductAjax";
				var params={productId:productId};
				doAjax("GET",url,params,changeSuccess,fail,true,false);
			}
			
			function changeSuccess(data){
				var product = data.data;
				mySwiper.removeAllSlides();
				if(product.product.cover1!=null)
					mySwiper.appendSlide('<div class="swiper-slide"><a href="#"><div class="backImage"><img src="'+product.product.cover1+'"></div></a></div>'); 
				if(product.product.cover2!=null)
					mySwiper.appendSlide('<div class="swiper-slide"><a href="#"><div class="backImage"><img src="'+product.product.cover2+'"></div></a></div>'); 
				if(product.product.cover3!=null)
					mySwiper.appendSlide('<div class="swiper-slide"><a href="#"><div class="backImage"><img src="'+product.product.cover3+'"></div></a></div>'); 
				if(product.product.cover4!=null)
					mySwiper.appendSlide('<div class="swiper-slide"><a href="#"><div class="backImage"><img src="'+product.product.cover4+'"></div></a></div>'); 
				if(product.product.cover5!=null)
					mySwiper.appendSlide('<div class="swiper-slide"><a href="#"><div class="backImage"><img src="'+product.product.cover5+'"></div></a></div>'); 
				
				$(".product-name").html(product.product.productName+"<span class='hasOrNot'>"+(product.product.productKind==0?"订货":"现货")+"</span>");
				$(".productInfo .red").html("￥"+product.product.originUnitPrice);
				$(".productSales").html("销量："+product.product.productSales);
				$("#num").html(product.product.productStock);
				$("#lightNumber").html(product.product.lightNumber);
				$("#space").html(product.space);
				$("#productColor").html(product.product.productColor);
				$("#productCode").html(product.product.productCode);
				$(".showprice").attr("data-price",product.product.unitPrice);
				if($(".showprice").html().indexOf("iconfont")<0)
					$(".showprice").html(product.product.originUnitPrice);
				
				var productSize="";
				if(product.product.productLength!=null){
					productSize+="L:"+product.product.productLength+"*";
				}
				if(product.product.productWidth!=null){
					productSize+="W:"+product.product.productWidth+"*";
				}
				if(product.product.productHeight!=null){
					productSize+="H:"+product.product.productHeight+((product.product.productDiameter!=null)?"*":"");
				}
				if(product.product.productDiameter!=null){
					productSize+="D:"+product.product.productDiameter;
				}
				$("#productSize").html(productSize);
				
				$("#productWeight").html(product.product.productWeight);
			
				var packageSize="";
				if(product.product.packageLength!=null){
					packageSize+="L:"+product.product.packageLength+"*";
				}	
				if(product.product.packageWidth!=null){
					packageSize+="W:"+product.product.packageWidth+"*";
				}
				if(product.product.packageHeight!=null){
					packageSize+="H:"+product.product.packageHeight;
				}
				$("#packageSize").html(packageSize);
				
				$("#packageWeight").html(product.product.packageWeight);
				
				productId=product.product.productId;
			}
	 	</script>
		<script src="<%=request.getContextPath() %>/resources/customer/assets/js/product.js?1212"></script>
	</body>

</html>
