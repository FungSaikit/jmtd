<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="thumbnail" uri="/WEB-INF/tld/thumbnailTag.tld"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
		 <meta name="format-detection" content="telephone=yes">
		<title>佐为照明</title>
		<link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
		<link href="<%=request.getContextPath() %>/resources/customer/assets/css/product.css?59cc59" rel="stylesheet">
		<link href="<%=request.getContextPath() %>/resources/common/swiper.min.css" rel="stylesheet">
	</head>

	<body>
		<c:set var="PRICE_SORT" value="<%=ProductSortType.PRICE_SORT%>" />
		<c:set var="CUSTOMER" value="<%=UserType.CUSTOMER%>" />
		<c:set var="AGENCY" value="<%=UserType.AGENCY%>" />
		<c:set var="SALESMAN" value="<%=UserType.SALESMAN%>"/>
		<c:set var="FACILITATOR" value="<%=UserType.FACILITATOR%>" /> 
		<c:set var="RETAIL_SALES" value="<%=UserType.RETAIL_SALES%>" /> 
		<c:set var="DEMAND_FACTORY" value="<%=UserType.DEMAND_FACTORY%>" /> 
		<c:set var="AUTHENTICATION_SUCCESS" value="<%=UserCheckStatus.AUTHENTICATION_SUCCESS%>" />
		<div class="productDetail">
			<div class="title">
				<ul>
					<li class="active">商品</li>
					<li>详情</li>
					<li>评价</li>
				</ul>
				<i class="iconfont back">&#xe624;</i>
				<i class="iconfont topCart">&#xe605;
					<span class="plusSpan all" id="all" style="visibility:hidden"></span>
					<span class="plusSpan add">+<span id="add">1</span></span>
				</i>
			</div>
			<!--[[轮播图-->
			<div class="swiper-container menuSwiper">
				<div class="swiper-wrapper ">
					<div class="swiper-slide goods">
						<!--[[轮播图-->
						<div class="swiper-container carousel">
							<div class="swiper-wrapper">
								<c:if test="${!empty product.customProduct.cover1 }">
									<div class="swiper-slide">
										<div class="backImage">
											<img src="${fn:replace(product.customProduct.cover1 ,'product', 'saveProduct')}" style="z-index:100;position:absolute;top:0;opacity:0;">
											<img src="${product.customProduct.cover1 }">
										</div>
									</div>
								</c:if>
								<c:if test="${!empty product.customProduct.cover2 }">
									<div class="swiper-slide">
										<div class="backImage">
											<img src="${fn:replace(product.customProduct.cover2 ,'product', 'saveProduct')}" style="z-index:100;position:absolute;top:0;opacity:0;">
											<img src="${product.customProduct.cover2 }">
										</div>
									</div>
								</c:if>
								<c:if test="${!empty product.customProduct.cover3 }">
									<div class="swiper-slide">
										<div class="backImage">
											<img src="${fn:replace(product.customProduct.cover3 ,'product', 'saveProduct')}" style="z-index:100;position:absolute;top:0;opacity:0;">
											<img src="${product.customProduct.cover3 }">
										</div>
									</div>
								</c:if>
								<c:if test="${!empty product.customProduct.cover4 }">
									<div class="swiper-slide">
										<div class="backImage">
											<img src="${fn:replace(product.customProduct.cover4 ,'product', 'saveProduct')}" style="z-index:100;position:absolute;top:0;opacity:0">
											<img src="${product.customProduct.cover4 }">
										</div>
									</div>
								</c:if>
								<c:if test="${!empty product.customProduct.cover5 }">
									<div class="swiper-slide">
										<div class="backImage">
											<img src="${fn:replace(product.customProduct.cover5 ,'product', 'saveProduct')}" style="z-index:100;position:absolute;top:0;opacity:0">
											<img src="${product.customProduct.cover5 }">
										</div>
									</div>
								</c:if>
							</div>
							<div class="swiper-pagination"></div>
						</div>
						<!--轮播图]]-->
						<!--[[产品信息-->
						<div class="product-msg">
							<div class="product-name">${product.customProduct.productName }<span class="hasOrNot"><c:choose><c:when test="${product.customProduct.productKind==1}">现货</c:when>
								<c:when test="${product.customProduct.productKind==0}">订货</c:when>
								<c:when test="${product.customProduct.productKind==2}">现货</c:when></c:choose></span>
							</div>
							<div class="productInfo">
								<div class="red" style="font-weight:bold;font-size:0.6rem;">￥${product.customProduct.unitPrice}</div><%-- 
								<div class="productSales">销量：${product.customProduct.productSales }</div> --%>
							</div>
							<div class="numDiv1">
								<div class="pull-left numDiv">
									<span>数量：</span>
									<span class="change-num reduce btn btn-default">-</span>
										<input class="num"  value="1"/>
									<span class="change-num increase btn btn-default">+</span>
								</div><%-- 
								<div class="productStock" style="display:none">库存：<span id="num">${product.customProduct.productStock }</span></div> --%>
								<div class="spreadBtn" <c:if test="${(buyer.role==2||buyer.role==4||buyer.role==6)
								&&(product.customProduct.isSpreadProduct==1||product.product.historySpreadProduct==1)}">style="display:block;"</c:if>>推广图</div>
							</div>
						</div>
						<!--产品信息]]-->
						<div class="series">
							<div>
								<p>同系列产品</p>
								<c:if test="${buyer.role!=CUSTOMER&&buyer.role!=RETAIL_SALES&&buyer.role!=DEMAND_FACTORY&&buyer.checkStatus==AUTHENTICATION_SUCCESS}"><span class="showprice hide" data-price="<fmt:formatNumber type="number" value="${product.product.unitPrice+product.product.woodenFee}" maxFractionDigits="2"/>"><i class="iconfont">&#xe628;</i></span><s id="costPrice" style="display:inline-block;padding: 0.1rem 0.4rem 0.4rem;float: right;font-size: .5rem;" ></s></c:if>
							</div>
							<ul class="seriesUl">
								<c:forEach items="${seriesList}" var="seriesProduct">
								<li data-id="${seriesProduct.productId}" <c:if test="${seriesProduct.productId==product.customProduct.productId }">class="active"</c:if>>
									<a>
										<img src="<thumbnail:date value="${seriesProduct.cover1 }"/>"/>
										<span>${seriesProduct.productCode }</span>
									</a>
								</li>
								</c:forEach>
								
							</ul>
						</div>
						<!--[[店铺-->
						<div class="shop">
							<div class="imgDiv">
								<div class="img-content">
									<img src="${factory.logoPic}">
								</div>
								<span class="shop-name">${factory.shortCompanyName}</span>
							</div>
						</div>
						<!--店铺]]-->
						<!-- 开始产品数据和售后服务 -->
						<div class="info">
							<ul class="infoMenu">
								<li <c:if test="${!empty user }">class="active hidLi"</c:if><%-- <c:if test="${empty user }">class="hidLi"</c:if> --%>>规格参数</li>
								<%-- <c:if test="${!empty user }"><li>售后服务</li></c:if> --%>
							</ul>
							<div class="swiper-container infoSwiper">
						        <div class="swiper-wrapper" id="warpper">
						            <div class="swiper-slide <c:if test="${empty user }">swiper-no-swiping</c:if>">
										<ul class="values">
											<li>
												<span>展厅编号</span>
												<span>-</span>
											</li>
											<c:if test="${buyer.role==SALESMAN}">
											<c:if test="${sessionScope.openId=='oQO-Qwu4DMV2DEOeacxdIKS6cVRQ'||sessionScope.openId=='oQO-QwkFyoLYu4nB6a4Lk3lamsW4'
   		 ||sessionScope.openId=='oQO-QwnsaSsL6c0QM8GyXRHzJInI'||sessionScope.openId=='oQO-QwsNw46NjP13S9vhlzvDxOZM'
   		 ||sessionScope.openId=='oQO-Qwml3yWRbjpPalYXKWDesYTI'||sessionScope.openId=='oQO-QwvpAID9vBcUQ8xnWuJjWCPY'
   		 ||sessionScope.openId=='oQO-QwvVOUHiDGupj1o8lcOhflkA'||sessionScope.openId=='oQO-QwgrqQExIsRRw-8OfO4OSZmo'
   		 ||sessionScope.openId=='oQO-QwmeRlMdo42ujI45178jkoEM'}">
											<li>
												<span>品牌</span>
												<span>${factory.shortCompanyName }</span>
											</li>
											</c:if>
											</c:if>
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
												<span>${product.lightType }</span>
											</li>
											<li>
												<span>光源数量</span>
												<span id="lightNumber">${product.customProduct.lightNumber }</span>
											</li>
											<li>
												<span>功率</span>
												<span id="productPower">${product.customProduct.productPower }</span>
											</li>
											<li>
												<span>空间</span>
												<span id="space">${product.space }</span>
											</li>
											<li>
												<span>颜色</span>
												<span id="productColor">${product.customProduct.productColor }</span>
											</li>
											<li>
												<span>型号</span>
												<span id="productCode">${product.customProduct.productCode }</span>
											</li>
											<li>
												<span>产品尺寸</span>
												<span id="productSize">
													<c:if test="${!empty product.customProduct.productLength }">长:<fmt:formatNumber value=" ${product.customProduct.productLength }" pattern="#0"/>*</c:if>
													<c:if test="${!empty product.customProduct.productWidth }">宽:<fmt:formatNumber value=" ${product.customProduct.productWidth }" pattern="#0"/>*</c:if>	
													<c:if test="${!empty product.customProduct.productHeight }">高:<fmt:formatNumber value="${product.customProduct.productHeight }" pattern="#0"/><c:if test="${!empty product.customProduct.productDiameter }">*</c:if></c:if>
													<c:if test="${!empty product.customProduct.productDiameter }">直径:<fmt:formatNumber value=" ${product.customProduct.productDiameter}" pattern="#0"/></c:if></span>
											
											</li>
											<li>
												<span>净重(kg)</span>
												<span id="productWeight">${product.customProduct.productWeight}</span>
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
							  <c:if test="${!empty product.customProduct.productContent }"><p>${product.product.productContent}</p></c:if>
							  <c:if test="${!empty product.customProduct.descriptionPic1 }"><img src="<%=request.getContextPath() %>/resources/customer/assets/images/defaultImg.jpg" alt="" data-show="false" data-img="${product.customProduct.descriptionPic1 }"/></c:if>
			                  <c:if test="${!empty product.customProduct.descriptionPic2 }"><img src="<%=request.getContextPath() %>/resources/customer/assets/images/defaultImg.jpg" alt="" data-show="false" data-img="${product.customProduct.descriptionPic2 }"/></c:if>
			                  <c:if test="${!empty product.customProduct.descriptionPic3 }"><img src="<%=request.getContextPath() %>/resources/customer/assets/images/defaultImg.jpg" alt="" data-show="false" data-img="${product.customProduct.descriptionPic3 }"/></c:if>
			                  <c:if test="${!empty product.customProduct.descriptionPic4 }"><img src="<%=request.getContextPath() %>/resources/customer/assets/images/defaultImg.jpg" alt="" data-show="false" data-img="${product.customProduct.descriptionPic4 }"/></c:if>
			                  <c:if test="${!empty product.customProduct.descriptionPic5 }"><img src="<%=request.getContextPath() %>/resources/customer/assets/images/defaultImg.jpg" alt="" data-show="false" data-img="${product.customProduct.descriptionPic5 }"/></c:if>
			                  <c:if test="${!empty product.customProduct.descriptionPic6 }"><img src="<%=request.getContextPath() %>/resources/customer/assets/images/defaultImg.jpg" alt="" data-show="false" data-img="${product.customProduct.descriptionPic6 }"/></c:if>
			                  <c:if test="${!empty product.customProduct.descriptionPic7 }"><img src="<%=request.getContextPath() %>/resources/customer/assets/images/defaultImg.jpg" alt="" data-show="false" data-img="${product.customProduct.descriptionPic7 }"/></c:if>
			                  <c:if test="${!empty product.customProduct.descriptionPic8 }"><img src="<%=request.getContextPath() %>/resources/customer/assets/images/defaultImg.jpg" alt="" data-show="false" data-img="${product.customProduct.descriptionPic8 }"/></c:if>
			                  <c:if test="${!empty product.customProduct.descriptionPic9 }"><img src="<%=request.getContextPath() %>/resources/customer/assets/images/defaultImg.jpg" alt="" data-show="false" data-img="${product.customProduct.descriptionPic9 }"/></c:if>
			                  <c:if test="${!empty product.customProduct.descriptionPic10 }"><img src="<%=request.getContextPath() %>/resources/customer/assets/images/defaultImg.jpg" alt="" data-show="false" data-img="${product.customProduct.descriptionPic10 }"/></c:if>
						</div>
		            </div>	
					<div class="swiper-slide comment scroll">
						
						功能正在完善中，请耐心等候...
					</div>
				</div>
			</div>
			<!--[[信息-->
			<!-- [[加入购物车-->
			<%-- <c:if test="${!empty online }"> --%>
			<c:if test="${product.customProduct.productStatus==5}">
			<div class="addCart text-center">
				<div class="cartDiv contactIcon gpsA" <%-- onclick="<c:if test="${buyer.upperUserId!=1 }">baiduMap()</c:if>
						<c:if test="${buyer.upperUserId==1 }">toBaiduMap()</c:if>" --%>>
					<i class="iconfont ">&#xe608;</i>
					<p>一键导航</p>
				</div>
				<div class="cartDiv contactIcon" id="phoneKe">
					<i class="iconfont">&#xe60e;</i>
					<p>联系客服</p>
				</div>
				
				<div class="cartDiv buyBtn toCart">
					<a href="javascript:alert('请到店购买')">加入购物车</a>
				</div>
				<div class="cartDiv buyBtn toBuy">
					<a href="javascript:alert('请到店购买')">立即购买</a>
				</div>
				
			</div>
			</c:if>
			<!-- 加入购物车]]-->
		</div>
		<!--提示框 -->
		<div class="tip"></div>
		
		<!-- 等待加载 -->
		<div class="waiting"><i class="iconfont">&#xe62c;</i></div>
		<div class="shade"></div>
		<!-- 等待加载 -->
		<div class="moveCart"></div>
		<!--[[底部-->
		<input type="hidden" id="lujing" value="<%=request.getContextPath() %>">
		<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
		<script src="<%=request.getContextPath() %>/resources/common/swiper.min.js"></script>
		<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
		<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
		<script src="<%=request.getContextPath() %>/resources/common/jweixin-1.0.0.js"></script>
		<script src="<%=request.getContextPath()%>/resources/common/count.js?1c#xx"></script><!-- 
		<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=6OqF8pnZwtLqg8qlhwh1wyN4"></script> -->
		<!--底部]]-->
		<script>
			var productStatus=${product.customProduct.productStatus};
		
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
			
			var productId=${product.customProduct.productId};
			var productName="${product.customProduct.productName}";
			function addShopcart() {
				if(${!empty sessionScope.openId && buyer.role!=9}){
					if(buyFlag){
						if(${product.customProduct.productKind==1}){/* 
							if($(".num").val()<=parseInt($("#num").text())){ */
								var url = "<%=request.getContextPath()%>/shopcart/addShopcart";
								var params = {productId: productId,num:$(".num").val()}
								doAjax("GET", url, params, success, fail, true, false);
							/* }
							else{
								$(".tip").html("添加数量不能多于库存量！");
								$(".tip").css("opacity","0.8");
								setTimeout(function(){
									$(".tip").css("opacity","0");
								},1000);
							} */
						}else{
							var url = "<%=request.getContextPath()%>/shopcart/addShopcart";
							var params = {productId: productId,num:$(".num").val()}
							doAjax("GET", url, params, success, fail, true, false);
						}
					}else{
						$(".tip").html("暂时不能购买！");
						$(".tip").css("opacity","0.8");
						addTime=setTimeout(function(){
							$(".tip").css("opacity","0");
						},1000);
					}
				}else{
					alert("不能购买")
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
				if(${product.customProduct.productKind==1}){
					if ($(this).hasClass("reduce")) {
						if ($(".num").val() != 1)
							$(".num").val(parseInt($(".num").val()) - 1);
					} else /* if($(".num").val()<parseInt($("#num").text())) */{
						$(".num").val(parseInt($(".num").val()) + 1);
					}/* else{
						$(".tip").html("添加数量不能多于库存量！");
						$(".tip").css("opacity","0.8");
						setTimeout(function(){
							$(".tip").css("opacity","0");
						},1000);
					} */
				}else{
					if ($(this).hasClass("reduce")) {
						if ($(".num").val() != 1)
							$(".num").val(parseInt($(".num").val()) - 1);
					} else{
						$(".num").val(parseInt($(".num").val()) + 1);
					}
				}
			})
			
			function buyImmediately(){
				if(${!empty sessionScope.openId && buyer.role!=9}){
					window.location.href='<%=request.getContextPath() %>/buyer/buyImmediately?productId='+productId+
						'&num='+$(".num").val();
				}else{
					alert("不能购买");
				}
			}
			
			$(".seriesUl li").tap(function(){
				if(!$(this).hasClass("active")){
					$(".seriesUl li").removeClass("active");
					$(this).addClass("active");
					changeProduct($(this).attr("data-id"));
				}	
				//window.location.href='<%=request.getContextPath()%>/product/productDetail?productId='+$(this).attr("data-id");
			});
			
			$(".back").click(function(){
				if(document.referrer=="")
					window.location.href="<%=request.getContextPath()%>/product/productList";
				else
					history.go(-1);
			});
			
			$("#phoneKe").tap(function(){
				/* window.location.href='tel:${service.phoneNumber}'; */
				closeWindow(true);
			});
			
			$(".topCart").tap(function(){
				window.location.href="<%=request.getContextPath()%>/shopcart/myShopcart";
			});
			
			function changeProduct(productId){
				var url="<%=request.getContextPath()%>/product/getProductAjax";
				var params={productId:productId};
				doAjax("GET",url,params,changeSuccess,fail,true,false);
			}
			
			var percent="${percent}";
			function changeSuccess(data){
				var product = data.data;
				mySwiper.removeAllSlides();
				if(product.product.cover1!=null)
					mySwiper.appendSlide('<div class="swiper-slide"><div class="backImage"><img src="'+product.product.cover1+'"><img src="'+saveProductPath(product.product.cover1)+'" style="z-index:100;position:absolute;top:0;opacity:0;left:0px"></div></div>'); 
				if(product.product.cover2!=null)
					mySwiper.appendSlide('<div class="swiper-slide"><div class="backImage"><img src="'+product.product.cover2+'"><img src="'+saveProductPath(product.product.cover2)+'" style="z-index:100;position:absolute;top:0;opacity:0;left:0px"></div></div>'); 
				if(product.product.cover3!=null)
					mySwiper.appendSlide('<div class="swiper-slide"><div class="backImage"><img src="'+product.product.cover3+'"><img src="'+saveProductPath(product.product.cover3)+'" style="z-index:100;position:absolute;top:0;opacity:0;left:0px"></div></div>'); 
				if(product.product.cover4!=null)
					mySwiper.appendSlide('<div class="swiper-slide"><div class="backImage"><img src="'+product.product.cover4+'"><img src="'+saveProductPath(product.product.cover4)+'" style="z-index:100;position:absolute;top:0;opacity:0;left:0px"></div></div>'); 
				if(product.product.cover5!=null)
					mySwiper.appendSlide('<div class="swiper-slide"><div class="backImage"><img src="'+product.product.cover5+'"><img src="'+saveProductPath(product.product.cover5)+'" style="z-index:100;position:absolute;top:0;opacity:0;left:0px"></div></div>'); 
				
				if(percent!=""){
					product.product.unitPrice=(product.product.unitPrice+Math.ceil(product.product.unitPrice*parseFloat(percent))).toFixed(2);
				}
				
				$(".product-name").html(product.product.productName+"<span class='hasOrNot'>"+(product.product.productKind==0?"订货":"现货")+"</span>");
				$(".productInfo .red").html("￥"+product.product.retailPrice);
				$(".productSales").html("销量："+product.product.productSales);
				$("#num").html(product.product.productStock);
				$("#lightNumber").html(product.product.lightNumber);
				$("#space").html(product.space);
				$("#productColor").html(product.product.productColor);
				$("#productCode").html(product.product.productCode);
				$(".showprice").attr("data-price",parseFloat(product.product.unitPrice)+parseFloat(product.product.woodenFee));
				$("#costPrice").attr("data-price",product.product.costPrice);
				
				if($(".showprice").html()!=null&&$(".showprice").html().indexOf("iconfont")<0){
					if(product.product.costPrice!=null){
						$("#costPrice").html("原价:"+product.product.costPrice);
					}else{
						$("#costPrice").html("");
					}
				}
				
				if(${buyer.role==2||buyer.role==4||buyer.role==6}&&(product.product.isSpreadProduct==1||product.product.historySpreadProduct==1))
					$(".spreadBtn").show();
				else
					$(".spreadBtn").hide();
				
				if($(".showprice").html()!=null&&$(".showprice").html().indexOf("iconfont")<0){
					if(product.product.costPrice!=null){
						$(".showprice").html("活动价:"+(parseFloat(product.product.unitPrice)+parseFloat(product.product.woodenFee)));
						$(".showprice").attr("style","color:red");
					}else{
						$(".showprice").html(parseFloat(product.product.unitPrice)+parseFloat(product.product.woodenFee));
						$(".showprice").removeAttr("style");
					}
				}
				
				
				var productSize="";
				if(product.product.productLength!=null){
					productSize+="长:"+product.product.productLength+"*";
				}
				if(product.product.productWidth!=null){
					productSize+="宽:"+product.product.productWidth+"*";
				}
				if(product.product.productHeight!=null){
					productSize+="高:"+product.product.productHeight+((product.product.productDiameter!=null)?"*":"");
				}
				if(product.product.productDiameter!=null){
					productSize+="直径:"+product.product.productDiameter;
				}
				$("#productSize").html(productSize);
				
				$("#productWeight").html(product.product.productWeight);
			
				var packageSize="";
				if(product.product.packageLength!=null){
					packageSize+="长:"+product.product.packageLength+"*";
				}	
				if(product.product.packageWidth!=null){
					packageSize+="宽:"+product.product.packageWidth+"*";
				}
				if(product.product.packageHeight!=null){
					packageSize+="高:"+product.product.packageHeight;
				}
				$("#packageSize").html(packageSize);
				
				$("#packageWeight").html(product.product.packageWeight);
				
				productId=product.product.productId;
				productName=product.product.productName;

				$("#installPrice").html(product.product.installPrice);
				$("#servicePrice").html(product.product.servicePrice);
				$("#shoperSpreadMoney").html(product.product.shoperSpreadMoney);
				$("#productPower").html(product.product.productPower)
				if(product.product.buyFlag==null)
					buyFlag=true;
				else
					buyFlag=false;
			}
			
			function closeWindow(obj) {
				var url=location.href.split('#')[0].replace(/&/g,"-");
		  		var urlStr = "<%=request.getContextPath()%>/wechat/signature?url="+url;
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
					        jsApiList: ['closeWindow'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
					    });
					    wx.error(function(res){
					           
					    });
					    wx.ready(function(){
							wx.closeWindow();
							if(obj){
								url="<%=request.getContextPath()%>/information/sendProductInformation";
								var params={url:"<%=request.getContextPath()%>/product/productDetail?productId="+productId
											,productName:productName};
								doAjax("GET",url,params,sendSuccess,fail,true,false);
							}
					    });
					}
				}); // end ajax
			}
			
			function testSend(){
				url="<%=request.getContextPath()%>/information/sendProductInformation";
				var params={url:"<%=request.getContextPath()%>/product/productDetail?productId="+productId
					,productName:productName};
				doAjax("GET",url,params,sendSuccess,fail,true,false);
			} 
			
			function sendSuccess(data){
				
			}
			
			function saveProductPath(productPath){
				return productPath.replace('product','saveProduct');
			}
			
			$(document).on("tap",".spreadBtn",function(){
	    		var url="<%=request.getContextPath()%>/product/generateSpreadProductPic";
	    		var params = {productId:productId};
	    		$(".shade").show();
	    		$(".waiting").show();
	    		doAjax("GET",url,params,function(data){
	    			$(".shade").hide();
	    			$(".waiting").hide();
					closeWindow(false);},function(){console.log("fail"),true,false});
	    	});
	 	</script><%-- 
	 	<%@ include file="/cs.jsp" %>
		<%CS cs = new CS(1261321176);cs.setHttpServlet(request,response);
		String imgurl = cs.trackPageView();%> 
		<img src="<%= imgurl %>" width="0" height="0"  />	 --%>
	 	<script src="<%=request.getContextPath()%>/resources/customer/assets/js/product.js?cacdccc1"></script>
	</body>

</html>
