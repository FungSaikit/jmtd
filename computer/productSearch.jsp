<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=2.0, user-scalable=yes" />
		<title>产品信息 - 金明同达灯饰</title>
		<meta name="renderer" content="webkit">
		<link rel="icon" href="<%=request.getContextPath() %>/resources/index/image/79icon.jpg" />
		<link type="text/css" rel="stylesheet" href="<%=path %>/resources/computer/css/search.css">
		<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/resources/computer/css/showloading.css">
		<style>
			/* 列表分类 */
			.tijiao:hover { background-color: #fff;border: 1px solid #dcdcdc;height: 25px;}
			.sort-price span input {left: 0px; width: 100%;padding-left: 3px;}
			.sort-price span {border: 1px solid #dcdcdc;height: 23px;margin-top: 8px;}
			.tijiao {background: #fff; border: 1px solid #dcdcdc;color: #666;height: 25px;}
			.sort-price span input { height: 23px; padding-top: 1px;} 
			.sort li>a.active {background: #e4393c;margin-left: -1px;width: 92px;height: 31px;}
			.sort li>a.active:hove {background: #e4393c;color: #fff;margin-left: -1px;}
			.sort li:first-child>a:hover {border-left: 1px solid #e4393c;}
			.sort li>a:hover, .sort li>a.clicked {height:30px; width: 90px;border: 1px solid #e4393c;background: #eee;color: #e4393c;margin-left: -1px;}
			.sort li>a {width: 90px;height: 30px;}
			.sort, .page-sm {height: 30px; line-height: 30px;font-size: 14px;}
			#showPanel{margin-top: 30px;}
			.sort li, .page-sm li {border: 1px solid #CCC; margin-right: -1px;z-index: 1;}
			.result { padding-left: 0px;}
			.search-li{margin-left: -7px}
			.search-div .result span { color: #c00;}
			/* 列表商品显示 */
			.add{background-color: #c00}
			.lamp-div2{margin-bottom: 10px;border: 1px solid #fff;margin-top: 2px;padding-right: 13px;padding-bottom: 10px} 
			.lampadd{border: 1px solid #fefefe;box-shadow: 0 0 2px 2px #eee;} 
			.lamp-div2  .lamp-info {width: 193px;height: 55px; margin-left: 13px;}
			.lamp-div2 .add p a,.add dl,.lamp-div2 .add strong{color: #fff}
			.lamp-div2 .lamp-info p a:hover {text-decoration: none; color: #fff;}
			.lamp-div2 .deng-pic img {height: 212px;}
			.lamp-div2 .deng-pic { height: 212px;left: 7px;width:225px}
			.lamp-div2 .lamp-pic, .lamp-pic img {width: 100%;height: 220px;}
			.page-div .page li a:hover, .page li a.active { background: #EFEFEF;color: #2953A6}
			.lxm_classify_top {visibility: hidden;}
			/* 侧导航栏 */
		</style>
	</head>

	<body>
		<jsp:include page="/jsp/computer/header.jsp"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/computer/script/jquery.showLoading.min.js"></script>
		
		<!--main-->
		<div class="main" id="mainPanel" style="background: #FCFCFC;">
			<div class="main-body md">
				<div class="main-gp-head">
					<div class="classify">
						<c:forEach items="${list}" var="l" varStatus="st">
						<c:if test="${l.typeName!='品牌'}">
						<c:if test="${l.typeName!='风格' || (l.typeName=='风格' && typeValue!='开关插座' && typeValue!='其他') }">
							<dl class="clear">
									<dt>${l.typeName}</dt>
									<c:forEach items="${valueList}" var="value" varStatus="i" begin="${st.index }" end="${st.index }">
									<dd>
										<ul> 
										<li>
												<a href="javascript:change('a${st.index}','全部')"  <c:if test="${value=='全部' && !(l.typeName=='价格区间' && (!empty lowPrice || !empty highPrice))}">class="cur"</c:if>>全部</a>
										</li>
										<c:forEach items="${l.propertyValueList}" var="pvl" varStatus="st2">
										<li>
										<c:choose>
											<c:when test="${l.typeName=='风格' }">
												<c:if test="${((typeValue=='吊灯'||typeValue=='壁灯'||typeValue=='台灯'||typeValue=='风扇灯'||typeValue=='落地灯'||typeValue=='吸顶灯'||typeValue=='镜前灯'||typeValue=='全部'||empty typeValue) && pvl.isDigital==0)||(typeValue=='户外照明' && pvl.isDigital==1)||(typeValue=='照明光源' && pvl.isDigital==2)}">
													<a href="javascript:change('a${st.index}','${pvl.propertyValueId}')" <c:if test="${value==pvl.propertyValueId.toString()  && !(l.typeName=='价格区间' && (!empty lowPrice || !empty hightPrice))}">class="cur"</c:if>>${pvl.propertyValue}</a>
												</c:if>
											</c:when>
											<c:otherwise>
												<a href="javascript:change('a${st.index}','${pvl.propertyValueId}')" <c:if test="${value==pvl.propertyValueId.toString()  && !(l.typeName=='价格区间' && (!empty lowPrice || !empty hightPrice))}">class="cur"</c:if>>${pvl.propertyValue}</a>	
											</c:otherwise>
										</c:choose>
										</li>
										<c:if test="${pvl.propertyValue=='20000以上'}">
											<li>
												<div class="sort-price">
													<span class="fl">
														<input type="number" maxlength="6" placeholder="￥" id="priceFrom" value="${lowPrice }"/>
													</span>
													<label class="fl">&nbsp;-&nbsp;</label>
													<span class="fl">
														<input type="number" maxlength="6" placeholder="￥" id="priceTo" value="${highPrice}"/>
													</span>
													<input type="submit" onclick="selectPrice()" class="tijiao fl" value="确定" />
														
												</div>
											</li>
										</c:if>
										</c:forEach>
										</ul>
									</dd>
									</c:forEach>
								</dl>
								</c:if>
								</c:if>
							</c:forEach>
						
					</div>
				</div>
				<div class="main-gp clear" id="showPanel">
					<div class="sort fl">
						<ul>
							<li><a href="javascript:defaultSort()" <c:if test="${sort==0 }"> class="active"</c:if>>默认排序</a></li>
							<li><a href="javascript:newPublish()"  <c:if test="${sort==1 }"> class="active"</c:if>>最新发布</a></li>
							<li><a href="javascript:NewHot_pro()"  <c:if test="${sort==9 }"> class="active"</c:if>>热门推荐</a></li>
							<li><a href="javascript:findNearBy()"  <c:if test="${sort==2 }"> class="active"</c:if>>找附近</a></li>
							<!-- <li class="origin">
								<a>货源地<i class="fa fa-caret-down caret"></i></a>
								<div class="" id="element_id" data-url="js/cityData.min.json" data-required="true">
									<form action="" method="">
										<select class="province" data-value="广东省" id="province" onchange="queryCity(this.value)"></select>
										<select class="city" data-value="中山市" id="city" name="city"></select>
										<input type="button" class="tijiao" value="确定" onclick="selectAddress()"/>
									</form>
								</div>
							</li> -->
						</ul>
					</div>
					<%-- <div class="page-sm  fr">
						<ul>
							<li>
								<a <c:choose><c:when test="${page.currentPageNo>1 }">href="javascript:toPage(${page.currentPageNo-1 })"</c:when> <c:otherwise>class="disabled"</c:otherwise></c:choose>>
								<i class="fa fa-angle-left"></i></a>
							</li>
							<li>
								<a href="#" class="num"><span>${page.currentPageNo}</span><span>&nbsp;&frasl;&nbsp;</span><span>${page.totalPages }</span></a>
							</li>
							<li>
								<a <c:choose><c:when test="${page.currentPageNo<page.totalPages }">href="javascript:toPage(${page.currentPageNo+1 })"</c:when> <c:otherwise>class="disabled"</c:otherwise></c:choose>>
								<i class="fa fa-angle-right"></i></a>
							</li>
						</ul>
					</div> --%>
				</div>
				<div class="main-gp-head" >
					<%-- <div class="search-div">
					<c:if test="${page.recordCount==0 }">
						<div class="result nothing bor">
						<c:if test="${keyword==''||keyword==null}">
							<strong>抱歉！没有找到符合的产品。</strong>
						</c:if>
						<c:if test="${keyword!=''&&keyword!=null}">
							<strong>抱歉！没有找到与&quot;<span>${keyword }</span>&quot;相关的产品。</strong>
						</c:if>
						</div>
					</c:if>
						<c:if test="${page.recordCount>0}">
						<div class="result">
							<strong>找到相关商品&nbsp;<span>${page.recordCount}</span>&nbsp;件：</strong>
						</div>
						<div class="search-li clear">
						<c:forEach items="${prolist}" var="pl" varStatus="st"> 
						<div class="lamp-div2 fl">
								<div class="lamp-pic">
									<a href="<%=path%>/product/intoPro/${pl.product.productId}" class="deng-pic" >
									<img src="<%=Variable.PATH%>/resources/upload/product/thumbnailImage/${pl.product.productCoverPic}" alt="" />
									</a>
								</div>
								<div class="lamp-info clear">
									<p><a class="intwoline" href="<%=path%>/product/intoPro/${pl.product.productId}">${pl.product.productName}</a></p>
									
									<dl>
										
										<c:if test="${!empty sessionScope.user}">
										<dt>会员价：</dt>
										<dd><strong>${pl.product.unitPrice}</strong></dd>
										</c:if>
										<c:if test="${empty sessionScope.user}">
										<dt>零售价：</dt>
										<dd><strong>${pl.product.productOriginPrice}</strong></dd>
										</c:if>
									</dl>
								</div>
							</div>
						</c:forEach>	
						</div>
						</c:if>
					</div> --%>
					<div class="search-div">
						<div class="result">
							<strong>找到相关商品&nbsp;<span>548</span>&nbsp;件：</strong>
						</div>
						<div class="search-li clear">
						 
						<div class="lamp-div2 fl">
								<div class="lamp-pic">
									<a href="/hot/product/intoPro/861" class="deng-pic">
									<img src="http://img13.360buyimg.com/n7/jfs/t5041/315/1258239314/96415/e34cc3eb/58eee4feN9bb9f96e.jpg" alt="" width="100%">
									</a>
								</div>
								<div class="lamp-info clear">
									<p><a class="intwoline" href="/hot/product/intoPro/861">欧式蜡烛灯</a></p>
									<dl>
										<dt>零售价：</dt>
										<dd><strong>12800.0</strong></dd>
									</dl>
								</div>
							</div>
						 
						<div class="lamp-div2 fl">
								<div class="lamp-pic">
									<a href="/hot/product/intoPro/1117" class="deng-pic">
									<img src="http://img10.360buyimg.com/n7/jfs/t2590/292/1095517291/471923/1581a794/5734d6cfNeed740e4.jpg" alt="">
									</a>
								</div>
								<div class="lamp-info clear">
									<p><a class="intwoline" href="/hot/product/intoPro/1117">宝达</a></p>
									
									<dl>
										
										
										
										<dt>零售价：</dt>
										<dd><strong>380.0</strong></dd>
										
									</dl>
									
									
									
								</div>
							</div>
						 
						<div class="lamp-div2 fl">
								<div class="lamp-pic">
									<a href="/hot/product/intoPro/1109" class="deng-pic">
									<img src="http://img14.360buyimg.com/n7/jfs/t2941/6/1996996131/271909/3fa4331b/579b3256N4d877dfb.jpg" alt="">
									</a>
								</div>
								<div class="lamp-info clear">
									<p><a class="intwoline" href="/hot/product/intoPro/1109">LED射灯</a></p>
									
									<dl>
										
										
										
										<dt>零售价：</dt>
										<dd><strong>50.0</strong></dd>
										
									</dl>
									
									
									
								</div>
							</div>
						 
						<div class="lamp-div2 fl">
								<div class="lamp-pic">
									<a href="/hot/product/intoPro/546" class="deng-pic">
									<img src="http://img12.360buyimg.com/n7/jfs/t4168/284/3819785055/260733/650c0781/58e84723Neb9cb64d.jpg" alt="">
									</a>
								</div>
								<div class="lamp-info clear">
									<p><a class="intwoline" href="/hot/product/intoPro/546">灯之家卧室灯</a></p>
									
									<dl>
										
										
										
										<dt>零售价：</dt>
										<dd><strong>180.0</strong></dd>
										
									</dl>
									
									
									
								</div>
							</div>
						 
						<div class="lamp-div2 fl">
								<div class="lamp-pic">
									<a href="/hot/product/intoPro/784" class="deng-pic">
									<img src="http://img12.360buyimg.com/n7/jfs/t1840/102/1802629613/398344/a4012033/567cbe9fNc063fb0d.jpg" alt="">
									</a>
								</div>
								<div class="lamp-info clear">
									<p><a class="intwoline" href="/hot/product/intoPro/784">镜前灯</a></p>
									
									<dl>
										
										
										
										<dt>零售价：</dt>
										<dd><strong>80.0</strong></dd>
										
									</dl>
									
									
									
								</div>
							</div>
						 
						<div class="lamp-div2 fl">
								<div class="lamp-pic">
									<a href="/hot/product/intoPro/860" class="deng-pic">
									<img src="http://img12.360buyimg.com/n7/jfs/t4168/284/3819785055/260733/650c0781/58e84723Neb9cb64d.jpg" alt="">
									</a>
								</div>
								<div class="lamp-info clear">
									<p><a class="intwoline" href="/hot/product/intoPro/860">欧式蜡烛灯</a></p>
									
									<dl>
										
										
										
										<dt>零售价：</dt>
										<dd><strong>1580.0</strong></dd>
										
									</dl>
									
									
									
								</div>
							</div>
						 
						<div class="lamp-div2 fl">
								<div class="lamp-pic">
									<a href="/hot/product/intoPro/1116" class="deng-pic">
									<img src="http://img14.360buyimg.com/n7/jfs/t2941/6/1996996131/271909/3fa4331b/579b3256N4d877dfb.jpg" alt="">
									</a>
								</div>
								<div class="lamp-info clear">
									<p><a class="intwoline" href="/hot/product/intoPro/1116">宝达</a></p>
									
									<dl>
										
										
										
										<dt>零售价：</dt>
										<dd><strong>248.0</strong></dd>
										
									</dl>
									
									
									
								</div>
							</div>
						 
						<div class="lamp-div2 fl">
								<div class="lamp-pic">
									<a href="/hot/product/intoPro/1108" class="deng-pic">
									<img src="http://img13.360buyimg.com/n7/jfs/t5041/315/1258239314/96415/e34cc3eb/58eee4feN9bb9f96e.jpg" alt="">
									</a>
								</div>
								<div class="lamp-info clear">
									<p><a class="intwoline" href="/hot/product/intoPro/1108">LED射灯</a></p>
									
									<dl>
										
										
										
										<dt>零售价：</dt>
										<dd><strong>50.0</strong></dd>
										
									</dl>
									
									
									
								</div>
							</div>
						 
						<div class="lamp-div2 fl">
								<div class="lamp-pic">
									<a href="/hot/product/intoPro/545" class="deng-pic">
									<img src="http://img12.360buyimg.com/n7/jfs/t1840/102/1802629613/398344/a4012033/567cbe9fNc063fb0d.jpg" alt="">
									</a>
								</div>
								<div class="lamp-info clear">
									<p><a class="intwoline" href="/hot/product/intoPro/545">灯之家卧室灯</a></p>
									
									<dl>
										<dt>零售价：</dt>
										<dd><strong>180.0</strong></dd>
										
									</dl>
								</div>
							</div>
						 
						<div class="lamp-div2 fl">
								<div class="lamp-pic">
									<a href="/hot/product/intoPro/783" class="deng-pic">
									<img src="http://img12.360buyimg.com/n7/jfs/t2932/186/2386194298/234002/fba075d/57aecbadN9ee64f5e.jpg" alt="">
									</a>
								</div>
								<div class="lamp-info clear">
									<p><a class="intwoline" href="/hot/product/intoPro/783">镜前灯</a></p>
									
									<dl>
										<dt>零售价：</dt>
										<dd><strong>80.0</strong></dd>
										
									</dl>
								</div>
							</div>
						 
						<div class="lamp-div2 fl">
								<div class="lamp-pic">
									<a href="/hot/product/intoPro/859" class="deng-pic">
									<img src="http://img14.360buyimg.com/n7/jfs/t2941/6/1996996131/271909/3fa4331b/579b3256N4d877dfb.jpg" alt="">
									</a>
								</div>
								<div class="lamp-info clear">
									<p><a class="intwoline" href="/hot/product/intoPro/859">欧式蜡烛灯</a></p>
									
									<dl>
										<dt>零售价：</dt>
										<dd><strong>18000.0</strong></dd>
										
									</dl>
								</div>
							</div>
						 
						<div class="lamp-div2 fl">
								<div class="lamp-pic">
									<a href="/hot/product/intoPro/1115" class="deng-pic">
									<img src="http://img12.360buyimg.com/n7/jfs/t4168/284/3819785055/260733/650c0781/58e84723Neb9cb64d.jpg" alt="">
									</a>
								</div>
								<div class="lamp-info clear">
									<p><a class="intwoline" href="/hot/product/intoPro/1115">奥格朗</a></p>
									
									<dl>
										<dt>零售价：</dt>
										<dd><strong>480.0</strong></dd>
										
									</dl>
								</div>
							</div>
						 
						<div class="lamp-div2 fl">
								<div class="lamp-pic">
									<a href="/hot/product/intoPro/1107" class="deng-pic">
									<img src="http://img10.360buyimg.com/n7/jfs/t2590/292/1095517291/471923/1581a794/5734d6cfNeed740e4.jpg" alt="">
									</a>
								</div>
								<div class="lamp-info clear">
									<p><a class="intwoline" href="/hot/product/intoPro/1107">LED射灯</a></p>
									
									<dl>
										<dt>零售价：</dt>
										<dd><strong>50.0</strong></dd>
										
									</dl>
								</div>
							</div>
						 
						<div class="lamp-div2 fl">
								<div class="lamp-pic">
									<a href="/hot/product/intoPro/544" class="deng-pic">
									<img src="http://img12.360buyimg.com/n7/jfs/t1840/102/1802629613/398344/a4012033/567cbe9fNc063fb0d.jpg" alt="">
									</a>
								</div>
								<div class="lamp-info clear">
									<p><a class="intwoline" href="/hot/product/intoPro/544">灯之家卧室灯</a></p>
									
									<dl>
										<dt>零售价：</dt>
										<dd><strong>180.0</strong></dd>
										
									</dl>
								</div>
							</div>
						 
						<div class="lamp-div2 fl">
								<div class="lamp-pic">
									<a href="/hot/product/intoPro/782" class="deng-pic">
									<img src="http://img12.360buyimg.com/n7/jfs/t2932/186/2386194298/234002/fba075d/57aecbadN9ee64f5e.jpg" alt="">
									</a>
								</div>
								<div class="lamp-info clear">
									<p><a class="intwoline" href="/hot/product/intoPro/782">镜前灯</a></p>
									<dl>
										<dt>零售价：</dt>
										<dd><strong>80.0</strong></dd>
									</dl>
								</div>
							</div>
						</div>
					</div>
				</div>
					<div class="main-gp-head page-div">
							<c:set var="currPage" value="${page.currentPageNo}" scope="request"/>
							<c:set var="pageCount" value="${page.totalPages}" scope="request"/>
							<%
								int currpage = (Integer)request.getAttribute("currPage");
								int pageCount = (Integer)request.getAttribute("pageCount");
							%>
							<div class="page">
								<ul class="fl">
									<li><a href="javascript:toPage(1)" class="disabled">首页</a></li>
									<%
								int start=1,end=pageCount;
								if(pageCount>5 && currpage>2 && currpage< pageCount-1){	
									start=currpage-2;
									end=currpage+2;
								}
								else{
									if(pageCount>5 && currpage>=pageCount-1){
										start=pageCount-4;
									}
									if(pageCount>5 && currpage<=2){
										end=5;
									}
								}
								for(int i=start;i<=end;i++){
									if(i==currpage){%>
										<li><a href="javascript:toPage(<%=i%>)" class="active">
									<%}else{ %>
										<li><a href="javascript:toPage(<%=i%>)" ><%} %>
							   		 <%=i %>
							   			</a></li>
							   		<%} 
									%>
									<li><a href="javascript:toPage(${page.totalPages})">尾页</a></li>
								</ul>
								<p class="fl">共<span>${page.totalPages}</span>页</p>
								<div class="jump fl">
									
										<label>到第</label>
										<input type="text" class="jumpto bor" value="${page.currentPageNo}" id="pageNo"/>
										<label>页</label>
										<input type="submit" class="tijiao" value="确定" onclick="toPage2()"/>
									
								</div>
							</div>
						</div>
			</div>
			<jsp:include page="/jsp/computer/sidebar.jsp"/>
		</div>
		<form id="frm" action="<%=path%>/search/index_search1_pro" method="get">
		<c:forEach items="${valueList}" var="l" varStatus="st">
		<input type="hidden" name="property" id="a${st.index}" value="${l}"/>
		</c:forEach>
		<input type="hidden" name="sort" id="sort" value="${sort}">
		<input type="hidden" name="currentPageNo" id="currentPageNo" value="${page.currentPageNo}">
		<input type="hidden" name="longitude" id="longitude" value="${longitude }"/>
		<input type="hidden" name="latitude" id="latitude" value="${latitude }"/>
		<input type="hidden" name="cityId" id="cityId" value="${cityId }"/>
		<input type="hidden" name="lowPrice" id="lowPrice" value="${lowPrice }"/>
		<input type="hidden" name="highPrice" id="highPrice" value="${highPrice}"/>
		<input type="hidden" name="keyword" id="keyword2" value="${keyword}"> 
		<input type="hidden" name="typeValue" value="${typeValue }"/>
		</form>
		
		<jsp:include page="/jsp/computer/footer.jsp"/>
		<script> 
			  $(".lamp-div2").hover(function() {
				    $(this).addClass('lampadd');
				   // $(this).css("border","1px solid #c00");  
				    $(this).children(".lamp-info").addClass('add');
				}, function() {
					 $(this).removeClass('lampadd');
					 $(this).children(".lamp-info").removeClass('add');
				}); 
			$(".origin a").bind("click",function(){
				var $div = $(this).parent().find("div");
				var $a = $(this);
				$div.toggle();
				if($div.css("display") == "block"){
					$a.addClass("clicked");
					$a.find("i").removeClass("fa-caret-down").addClass("fa-caret-up");
				}else{
					$a.removeClass("clicked");
					$a.find("i").removeClass("fa-caret-up").addClass("fa-caret-down");
				}
			});
			
			function change(demo,value)
			{	
				if(demo=='a6'){
					$("#lowPrice").val("");
					$("#highPrice").val("");
				}	
				document.getElementById("currentPageNo").value=1;
				document.getElementById(demo).value=value;
				document.getElementById("frm").submit();
			}
			
			function toPage(i)
			{
				document.getElementById("currentPageNo").value=i;
				document.getElementById("frm").submit();
			}
			function toPage2()
			{
				var i=document.getElementById("pageNo").value;
				document.getElementById("currentPageNo").value=i;
				document.getElementById("frm").submit();
			}
			
			function defaultSort(){
				$("#sort").val("0");
				document.getElementById("currentPageNo").value=1;
				$("#frm").attr("action",$("#frm").attr("action")+"#showPanel");
				$("#frm").submit();
			}
			
			function newPublish(){
				$("#sort").val("1");
				document.getElementById("currentPageNo").value=1;
				$("#frm").attr("action",$("#frm").attr("action")+"#showPanel");
				$("#frm").submit();
			}
			
			function NewHot_pro()
			{
				$("#sort").val("9");
				$("#currentPageNo").val(1);
				$("#frm").submit();
			}
			
			//获取当前地址的经纬度
			function findNearBy(){
				jQuery('#mainPanel').showLoading();
				var geolocation = new BMap.Geolocation();
				geolocation.getCurrentPosition(function(r){
					jQuery('#mainPanel').hideLoading();
					if(this.getStatus() == BMAP_STATUS_SUCCESS){
						$("#longitude").val(r.point.lng);
						$("#latitude").val(r.point.lat);
						$("#sort").val("2");
						document.getElementById("currentPageNo").value=1;
						$("#frm").attr("action",$("#frm").attr("action")+"#showPanel");
						$("#frm").submit();
					}
					else {
						alert('failed'+this.getStatus());
					}        
				},{enableHighAccuracy: true})
				
			}
			
			$(window).on('load', function() {
				   
				var urlStr = "<%=request.getContextPath()%>/receiveAddress/getProvinceList";
				//alert("Before Call:"+urlStr);
				$.ajax({
					method: "GET",
					url: urlStr,
					success:function(data,status,jqXHR){
						$("#province").append("<option>请选择</option>")
						for(var i=0;i<data.length;i++){
							$("#province").append("<option value='"+data[i].provinceId+"'>"+data[i].provinceName+"</option>");	
						}
					}	
				}); // end ajax 
		 	});
			
			function queryCity(obj){
				var urlStr = "<%=request.getContextPath()%>/address/queryCity?provinceId="+obj;
				//alert("Before Call:"+urlStr);
				$.ajax({
					method: "GET",
					url: urlStr,
					success:function(data,status,jqXHR){
						//alert(data);
						$("#city").html("");
					
						for(var i=0;i<data.length;i++){
							$("#city").append("<option value="+data[i].cityId+">"+data[i].cityName+"</option>");
						}
					}
				}); // end ajax 
			}
			
			function selectAddress(){
				$("#sort").val("3");
				$("#cityId").val($("#city").val());
				$("#keyword2").val($("#keyword").val());
				$("#frm").attr("action",$("#frm").attr("action")+"#showPanel");
				$("#frm").submit();
			}
			
			function selectPrice(){
				$("#a6").val("全部");
				$("#lowPrice").val($("#priceFrom").val());
				$("#highPrice").val($("#priceTo").val());
				$("#frm").submit();
			}
			
			$(function(){
				//保证首页需求,产品图片不压缩
				$(".deng-pic img").each(function(){
					var img = new Image();
					img.src = $(this).attr("src");
					var $this= $(this);
					var w=$this.parent().css("width");
					var h=$this.parent().css("height");
					// 如果图片被缓存，则直接返回缓存数据
					if(img.complete){
						realImg($this,img.src,img.width, img.height,w,h);
					}else{
						// 完全加载完毕的事件
						img.onload = function(){
						realImg($this,img.src,img.width, img.height,w,h);
					 }}
				});
				
				function realImg(obj,objUrl,width,height,w,h){
					var imgWidth=width;
					var imgHeight=height;
					if(imgHeight>imgWidth){
						obj.css("width",w);
						var realHeight=parseFloat(imgHeight)*parseFloat(w)/parseFloat(imgWidth);
						var clipless=(parseFloat(realHeight)-parseFloat(h))/2;
						var clipmore=parseFloat(clipless)+parseFloat(h);
						obj.css("height",realHeight+"px");
						obj.attr("src",objUrl);
						obj.css("clip","rect("+clipless+"px "+parseFloat(w)+"px "+clipmore+"px 0px)");
						obj.css("top",-(parseFloat(clipless))+"px");
						obj.css("left","0px");
					}
					else{
						obj.css("height",h);
						var realWidth=parseFloat(imgWidth)*parseFloat(h)/parseFloat(imgHeight);
						var clipless=(parseFloat(realWidth)-parseFloat(w))/2;
						var clipmore=parseFloat(clipless)+parseFloat(w);
						obj.css("width",realWidth+"px");
						obj.attr("src",objUrl);
						obj.css("clip","rect(0px "+clipmore+"px "+parseFloat(h)+"px "+clipless+"px)");
						obj.css("top","0px");
						obj.css("left",-(parseFloat(clipless))+"px");
					}
				}
			});
		</script>
	</body>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=6OqF8pnZwtLqg8qlhwh1wyN4"></script>
</html>