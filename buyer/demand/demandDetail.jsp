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
		<title>金明同达灯饰</title>
		<link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
		<link href="<%=request.getContextPath() %>/resources/customer/assets/css/product.css?59cc59" rel="stylesheet">
		<link href="<%=request.getContextPath() %>/resources/common/swiper.min.css" rel="stylesheet">
		<style>
			html{
				padding:0px;
				margin:0px;
			}
			.checkBox {
			    border: 2px solid #999;
			    width: 20px;
			    height: 20px;
			    text-align: center;
			    line-height: 20px;
			    color: #fff;
			}
			.getGoods {
			    float: right;
			}
			.orderStock {
			    background-color: #fff;
			    padding: .3rem .3rem ;
			    border-bottom:1px solid #DDD;
			    position: relative;
			}
			.myOrder, .orderStock {
			    font-size: 0.5rem;
			    font-family: "微软雅黑";
			}
			.stockNum>div:first-child, .stockNum>div:first-child>div {
			    display: inline-block;
			}
			.checkBox.active {
			    color: red;
			    border: 2px solid red;
			}
			.toChoose{
			    background-color: #F23030;
			}
		</style>
	</head>

	<body>
		<c:set var="PRICE_SORT" value="<%=ProductSortType.PRICE_SORT%>" />
		<c:set var="CUSTOMER" value="<%=UserType.CUSTOMER%>" />
		<c:set var="AGENCY" value="<%=UserType.AGENCY%>" />
		<c:set var="SALESMAN" value="<%=UserType.SALESMAN%>"/>
		<c:set var="FACILITATOR" value="<%=UserType.FACILITATOR%>" /> 
		<c:set var="RETAIL_SALES" value="<%=UserType.RETAIL_SALES%>" /> 
		<c:set var="AUTHENTICATION_SUCCESS" value="<%=UserCheckStatus.AUTHENTICATION_SUCCESS%>" />
		<div class="productDetail">
			<div class="title">
				<ul>
					<li <c:if test="${demandModel.demand.userId!=user.userId }">style="width:100%;"</c:if>
					<c:if test="${demandModel.demand.userId==user.userId }">style="width:50%;"</c:if> class="active">需求</li>
					<c:if test="${demandModel.demand.userId==user.userId }"><li style="width:50%;">参数</li></c:if>
				</ul>
				<i class="iconfont back">&#xe624;</i>
				<!-- <i class="iconfont topCart">&#xe605;
					<span class="plusSpan all" id="all" style="visibility:hidden"></span>
					<span class="plusSpan add">+<span id="add">1</span></span>
				</i> -->
			</div>
			<!--[[轮播图-->
			<div class="swiper-container menuSwiper">
				<div class="swiper-wrapper ">
					<div class="swiper-slide goods">
						<!--[[轮播图-->
						<div class="swiper-container carousel">
							<div class="swiper-wrapper">
								<c:if test="${!empty demandModel.demand.demandCover1 }">
									<div class="swiper-slide">
										<div class="backImage"><img src="${demandModel.demand.demandCover1 }">
										</div>
									</div>
								</c:if>
								<c:if test="${!empty demandModel.demand.demandCover2 }">
									<div class="swiper-slide">
										<div class="backImage"><img src="${demandModel.demand.demandCover2 }">
										</div>
									</div>
								</c:if>
								<c:if test="${!empty demandModel.demand.demandCover3 }">
									<div class="swiper-slide">
										<div class="backImage"><img src="${demandModel.demand.demandCover3 }">
										</div>
									</div>
								</c:if>
								<c:if test="${!empty demandModel.demand.demandCover4 }">
									<div class="swiper-slide">
										<div class="backImage"><img src="${demandModel.demand.demandCover4 }">
										</div>
									</div>
								</c:if>
								<c:if test="${!empty demandModel.demand.demandCover5 }">
									<div class="swiper-slide">
										<div class="backImage"><img src="${demandModel.demand.demandCover5}">
										</div>
									</div>
								</c:if>
								<c:if test="${!empty demandModel.demand.demandCover6 }">
									<div class="swiper-slide">
										<div class="backImage"><img src="${demandModel.demand.demandCover6}">
										</div>
									</div>
								</c:if>
							</div>
							<div class="swiper-pagination"></div>
						</div>
						<!--轮播图]]-->
						<!--[[产品信息-->
						<div class="product-msg">
							<div class="product-name">${demandModel.demand.demandName }<span class="hasOrNot"></span>
							</div>
							<div class="productInfo">
								<div class="red" style="font-weight:bold;font-size:0.6rem;">
									<c:if test="${!empty demandModel.demand.demandPriceDown||!empty demandModel.demand.demandPriceUp}">
										￥${demandModel.demand.demandPriceDown}-${demandModel.demand.demandPriceUp}
									</c:if>
								</div>
								<div class="productSales">需求量：${demandModel.demand.demandNumber}</div>
							</div>
							<c:if test="${!empty phoneNumber }">
							<div class="productInfo">
								<div class="red">联系电话：<a href="tel:${phoneNumber}">${phoneNumber }</a></div>
								<div class="productSales">联系人：${legalPerson }</div>
							</div>
							</c:if>
							<%-- <div class="numDiv1">
								<div class="pull-left numDiv">
									<span>数量：</span>
									<span class="change-num reduce btn btn-default">-</span>
										<input class="num"  value="1"/>
									<span class="change-num increase btn btn-default">+</span>
								</div>
								<div class="productStock" style="display:none">库存：<span id="num">${product.product.productStock }</span></div>
								<div class="spreadBtn" <c:if test="${(buyer.role==2||buyer.role==4||buyer.role==6)
								&&(product.product.isSpreadProduct==1||product.product.historySpreadProduct==1)}">style="display:block;"</c:if>>推广图</div>
							</div> --%>
						</div>
						
						<c:if test="${demandModel.demand.userId==user.userId }">
						<div class="info" style="margin: 0.2rem 0;">
							<ul class="infoMenu">
								<li class="active hidLi">报价列表</li>
							</ul>
							<div class="offerList">
								<div class="loading" style="visibility: visible;"><span id="jiazai">加载更多</span></div> 
							</div>
						</div>
						</c:if>
						<c:if test="${!empty demandOffer}">
						<div class="info" style="margin: 0.2rem 0;">
							<ul class="infoMenu">
								<li class="active hidLi">我的报价</li>
							</ul>
							<div class="orderStock" data-id="5">
								<div class="orderStockHead">
									<p class="fl">提交时间：${demandOffer.creatTime }</p>
									
								</div>
								<div class="orderStockBody">
									<div class="stock" data-id="1">
										<div class="stockNum">
											<div>报价：${demandOffer.demandPrice }</div>
											<div class="imgBox"></div>
										</div>
										<div class="stockNum">
											<div><label>交货天数：${demandOffer.timeLimit}</label>
												<div></div>
												<span>天</span>
											</div>
										</div>
										<%-- <div class="stockNum">
											<div><label>联系人：${legalPerson }</label>
											</div>
										</div>
										<div class="stockNum">
											<div><label>联系方式：<a class="phone" href="tel:${phoneNumber}">${phoneNumber }</a></label>
											</div>
										</div> --%>
									</div>
								</div>
							</div>
						</div>
						</c:if>
						<!--店铺]]-->
						<c:if test="${demandModel.demand.userId!=user.userId }">
						<!-- 开始产品数据和售后服务 -->
						<div class="info">
							<ul class="infoMenu">
								<li class="active hidLi">规格参数</li>
								<%-- <c:if test="${!empty user }"><li>售后服务</li></c:if> --%>
							</ul>
							<div class="swiper-container infoSwiper">
						        <div class="swiper-wrapper" id="warpper">
						            <div class="swiper-slide ">
										<ul class="values">
											<li>
												<span>截止日期</span>
												<span><fmt:formatDate value="${demandModel.demand.expireTime}"  pattern="yyyy-MM-dd"/></span>
											</li>
											<li>
												<span>类型</span>
												<span>${demandModel.type}</span>
											</li>
											<li>
												<span>材质</span>
												<span>${demandModel.material }</span>
											</li>
											<li>
												<span>风格</span>
												<span>${demandModel.style }</span>
											</li>
											<%--<li>
												<span>光源类型</span>
												<span>${demandModel.lightType }</span>
											</li>
											<li>
												<span>光源数量</span>
												<span id="lightNumber">${demandModel.demand.lightNumber}</span>
											</li> --%>
											<li>
												<span>空间</span>
												<span id="space">${demandModel.space}</span>
											</li>
											<li>
												<span>详情</span>
												<span>${demandModel.demand.demandContent}</span>
											</li>
											<%-- <li>
												<span>颜色</span>
												<span id="productColor">${demandModel.demand.demandColor}</span>
											</li>
											<li>
												<span>产品尺寸</span>
												<span id="productSize">
													<c:if test="${!empty demandModel.demand.demandLength }">长:<fmt:formatNumber value=" ${demandModel.demand.demandLength }" pattern="#0"/>*</c:if>
													<c:if test="${!empty demandModel.demand.demandWidth }">宽:<fmt:formatNumber value=" ${demandModel.demand.demandWidth }" pattern="#0"/>*</c:if>	
													<c:if test="${!empty demandModel.demand.demandHeight }">高:<fmt:formatNumber value="${demandModel.demand.demandHeight }" pattern="#0"/><c:if test="${!empty demandModel.demand.demandDiameter }">*</c:if></c:if>
													<c:if test="${!empty demandModel.demand.demandDiameter }">直径:<fmt:formatNumber value=" ${demandModel.demand.demandDiameter}" pattern="#0"/></c:if></span>
											
											</li> --%>
											
										</ul>
										
									</div>
									
						        </div>
						    </div>
					    </div>
						<!-- 结束产品数据和售后服务 -->
						</c:if>
					</div>
					<c:if test="${demandModel.demand.userId==user.userId }">
					<div class="swiper-slide imagesScroll scrollDiv">
		            	<div class="info">
							<ul class="infoMenu">
								<li class="active hidLi">规格参数</li>
								<%-- <c:if test="${!empty user }"><li>售后服务</li></c:if> --%>
							</ul>
							<div class="swiper-container infoSwiper">
						        <div class="swiper-wrapper" id="warpper">
						            <div class="swiper-slide ">
										<ul class="values">
											<li>
												<span>截止日期</span>
												<span><fmt:formatDate value="${demandModel.demand.expireTime}"  pattern="yyyy-MM-dd"/></span>
											</li>
											<li>
												<span>类型</span>
												<span>${demandModel.type}</span>
											</li>
											<li>
												<span>材质</span>
												<span>${demandModel.material }</span>
											</li>
											<li>
												<span>风格</span>
												<span>${demandModel.style }</span>
											</li>
											<%--<li>
												<span>光源类型</span>
												<span>${demandModel.lightType }</span>
											</li>
											<li>
												<span>光源数量</span>
												<span id="lightNumber">${demandModel.demand.lightNumber}</span>
											</li> --%>
											<li>
												<span>空间</span>
												<span id="space">${demandModel.space}</span>
											</li>
											<li>
												<span>详情</span>
												<span>${demandModel.demand.demandContent}</span>
											</li>
											<%-- <li>
												<span>颜色</span>
												<span id="productColor">${demandModel.demand.demandColor}</span>
											</li>
											<li>
												<span>产品尺寸</span>
												<span id="productSize">
													<c:if test="${!empty demandModel.demand.demandLength }">长:<fmt:formatNumber value=" ${demandModel.demand.demandLength }" pattern="#0"/>*</c:if>
													<c:if test="${!empty demandModel.demand.demandWidth }">宽:<fmt:formatNumber value=" ${demandModel.demand.demandWidth }" pattern="#0"/>*</c:if>	
													<c:if test="${!empty demandModel.demand.demandHeight }">高:<fmt:formatNumber value="${demandModel.demand.demandHeight }" pattern="#0"/><c:if test="${!empty demandModel.demand.demandDiameter }">*</c:if></c:if>
													<c:if test="${!empty demandModel.demand.demandDiameter }">直径:<fmt:formatNumber value=" ${demandModel.demand.demandDiameter}" pattern="#0"/></c:if></span>
											
											</li> --%>
											
										</ul>
										
									</div>
									
						        </div>
						    </div>
					    </div>
		            </div>	
		            </c:if>
				</div>
			</div>
			<!--[[信息-->
			<!-- [[加入购物车-->
			<%-- <c:if test="${!empty online }"> --%>
			<c:if test="${demandModel.demand.demandStatus==0&&!empty canOffer}">
			<div class="addCart text-center">
				<div class="cartDiv buyBtn toBuy" style="width:100%;height:44px;line-height:44px;">
					<a href="javascript:void()">报价</a>
				</div>
			</div>
			</c:if>
			<%-- </c:if> --%>
			<c:if test="${(demandModel.demand.demandStatus==0||demandModel.demand.demandStatus==3)&&
				demandModel.demand.userId==user.userId }">
				<div class="addCart text-center">
					<div class="cartDiv buyBtn toChoose" style="width:100%;height:44px;line-height:44px;">
						<a href="javascript:void()">采纳报价</a>
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
		<script src="<%=request.getContextPath()%>/resources/common/count.js?1c#xx"></script>
		<!--底部]]-->
		<!-- 开始确认框 -->
		<div class="confirmDiv" id="delete">
			<div class="confirmTop">
				<span>注意</span>
				<span id="closeConfirm"><i class="iconfont">&#xe632;</i></span>
			</div>
			<p id="phoneNumber">您还没注册，无法提供报价，请选择对应身份注册(注册经销商需要联系客服人员)</p>
			<div class="confirmBottom">
				<span id="agency">经销商</span>
				<span id="factory">厂家</span>
			</div>
		</div>
		<!--[[底部-->
		<form action="<%=request.getContextPath()%>/demand/chooseDemandOffer" style="display:none;">
			<input type="hidden" name="demandOfferIds" id="demandOfferIds"/>
		</form>
		<script>
			$(".backImage img").each(function(){
				$(this).width($(this).parents(".swiper-slide").width());
				$(this).height($(this).parents(".swiper-slide").height());
			});
		
			$(".toBuy").tap(function(){
				if(${user.role==5||empty user}){
					showRegister();
				}else{
					window.location.href="<%=request.getContextPath() %>/demand/toAddDemandOffer?demandId=${demandModel.demand.demandId}";
				}
			});
			
			$("#agency").tap(function(){
				window.location.href="tel:13610092487";
			})
			
			$("#factory").tap(function(){
				window.location.href="<%=request.getContextPath()%>/user/toAuthenticationFactory";
			})
			
			function showRegister(){
				$("#delete").show();
				$(".shade").show();
			}
			
			$("#closeConfirm,.shade").tap(function(){
				$("#delete").hide();
				$(".shade").hide();
			})
			
			$(".service").click(function(e){
				$(".dropdown-menu").toggle()
				e.stopPropagation();
			})
			
			$("body").click(function(){
				$(".dropdown-menu").hide()
			})
			
			
			function fail(data) {
				$(".tip").html("系统繁忙！ 请稍后再试");
				$(".tip").css("opacity","0.8");
				setTimeout(function(){
					$(".tip").css("opacity","0");
				},1000);
			}

			$(".change-num").click(function() {
				if(${product.product.productKind==1}){
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
				if(${empty product.product.buyFlag}){
					window.location.href='<%=request.getContextPath() %>/buyer/buyImmediately?productId='+productId+
							'&num='+$(".num").val();
				}else{
					$(".tip").html("暂时不能购买！");
					$(".tip").css("opacity","0.8");
					addTime=setTimeout(function(){
						$(".tip").css("opacity","0");
					},1000);
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
				history.go(-1);
			});
			
			var offset=0;
			var load=$(".loading");
			if(${demandModel.demand.userId==user.userId})
				loadOrder();
			$("#jiazai").tap(function(){
				loadOrder();
			});
			function loadOrder(){
				var url="<%=request.getContextPath()%>/demand/demandOfferListAjax";
				var params={offset:offset,demandId:${demandModel.demand.demandId}};
				doAjax("GET",url,params,loadSuccess,fail,true,false);
			}
			
			var index=1;
			function loadSuccess(data){
				var demandList = data.data.list;
				var html="";
				for(var i=0;i<demandList.length;i++){
					html+='<div class="orderStock" data-id="'+demandList[i].demandOffer.demandOfferId+'"><div class="orderStockHead">';
					html+='<p class="fl">提交时间：'+showDate(demandList[i].demandOffer.creatTime)+'</p>';
					if(${empty complete}&&demandList[i].demandOffer.demandOfferStatus!=1)
						html+='<span class="checkBox getGoods" data-id="'+demandList[i].demandOffer.demandOfferId+'"><i class="iconfont">&#xe611;</i></span>'; 
					if(demandList[i].demandOffer.demandOfferStatus==1)
						html+='<span class="getGoods" style="color:red" data-id="'+demandList[i].demandOffer.demandOfferId+'">已采纳</span>'; 
					html+='</div><div class="orderStockBody">';
					html+='<div class="stock" data-id="1">';
					html+='<div class="stockNum"><div>报价：'+demandList[i].demandOffer.demandPrice+'</div><div class="imgBox">';/* 
					html+='<img src="'+demandList[i].demandPrice+'" alt="">'; */
					html+='</div></div><div class="stockNum"><div><label>交货天数：'+demandList[i].demandOffer.timeLimit+'</label>';
					html+='<div>';
					html+='</div><span>天</span></div></div>';/* 
					html+='<table><tr>';
					html+='<td class="detail">查看详情</td>'
					if(demandList[i].demandOfferStatus==1)
						html+='<td class="contact">联系方式</td>';
					html+='</tr></table>'; */
					if(${!empty complete}||demandList[i].demandOffer.demandOfferStatus==1){
						html+='<div class="stockNum"><div><label>联系人：'+demandList[i].user.legalPersonName+'</label>';
						html+='<div>';
						html+='</div></div></div>';
						html+='<div class="stockNum"><div><label>联系电话：<a class="phone" href="tel:'+demandList[i].user.phoneNumber+'">'+demandList[i].user.phoneNumber+'</a></label>';
						html+='<div>';
						html+='</div></div></div>';
					}
					html+='</div></div></div>';
				}
				$(html).insertBefore(load);
				
				if(parseInt(offset+10)>=data.data.count){
					noDate=true;
					load.html("没有更多数据");
				}
				offset=data.data.after;
				canLoad=true;
			}
			
			function showDate(str){
				var date = new Date(str);
				return date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate()+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds();
			}
			
			$(document).on("tap",".checkBox",function(){
				var index=0;
				$(".checkBox").each(function(){
					if($(this).hasClass("active")){		
						index++;
					}
				});
				
				
				if($(this).hasClass("active")){
					$(this).removeClass("active");
				}else{
					/* $(".checkBox").each(function(){
						$(this).removeClass("active");
					}); */
					if(index<3){
						$(this).addClass("active");
					}else{
						showTip("最多选择三份报价");
					}
				}
				
			});
			
			$(document).on("tap",".orderStock",function(e){
				if(!$(e.target).hasClass("phone")&&!$(e.target).hasClass("iconfont")){
					window.location.href="<%=request.getContextPath()%>/demand/demandOfferDetail?demandOfferId="+$(this).attr("data-id");
				}
			});
			
			var clicked=false;
			$(document).on("tap",".toChoose",function(){
				$(".shade").show();
				$(".waiting").show();
				if(clicked==false){
					clicked=true;
					var dataId="";
					$(".checkBox").each(function(){
						if($(this).hasClass("active")){		
							dataId+=$(this).attr("data-id")+",";
						}
					});
					if(dataId==""){
						showTip("请至少选择一份报价");
						clicked=false;
						$(".shade").hide();
						$(".waiting").hide();
					}else{
						dataId=dataId.substring(0,dataId.length-1);
						$("#demandOfferIds").val(dataId);
						$("form").submit();
					}
				}	
			});
			function showTip(str){
				$(".tip").html(str);
				$(".tip").css("opacity",1);
				setTimeout(function(){
					$(".tip").html("");
					$(".tip").css("opacity",0);
				},1000);
			}
			
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
						    title: '繁灯网求购信息', // 分享标题
						    imgUrl: 'http://lanmao.zhuanlitou.com/resources/customer/assets/images/qiugou.png', // 分享图标
						    success: function () { 
						        // 用户确认分享后执行的回调函数
						    },
						    cancel: function () { 
						        // 用户取消分享后执行的回调函数
						    }
						});
						wx.onMenuShareAppMessage({
						    title: '繁灯网求购信息', // 分享标题
						    imgUrl: 'http://lanmao.zhuanlitou.com/resources/customer/assets/images/qiugou.png', // 分享图标
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
	 	</script>
	 	<script src="<%=request.getContextPath()%>/resources/customer/assets/js/product.js?cacdccc1"></script>
	</body>

</html>
