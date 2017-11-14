<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=2.0, user-scalable=yes" />
		<title>您好，欢迎使用金明同达灯饰在线商城！- 金明同达灯饰</title>
		<meta name="renderer" content="webkit">
		<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/resources/computer/css/font-awesome-ie7.min.css" />
		<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/resources/computer/css/font-awesome.min.css" />
		<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/resources/computer/css/reset-min.css">
		<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/resources/computer/css/common.css">
		<link rel="icon" href="<%=request.getContextPath() %>/resources/index/image/79icon.jpg" />
		<script type="text/javascript" src="<%=request.getContextPath() %>/resources/common/jquery.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resources/computer/script/jquery.cookie.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resources/computer/script/jquery.showLoop.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resources/computer/script/common.js"></script>
		<style type="text/css">
			.lxm_classify_top{
			    width: 100%;
			    height: 40px;
			    font-size: 16px;
			    color:#fff;
			    background: #c00;
			    vertical-align: middle;
			    line-height: 40px;
			    display: none;
			    position: fixed;
			    top: 0;
			    z-index: 2;}
			.lxm_classify_top ul{margin: 0 auto}
			.lxm_classify_top li{float: left;width: 9%;text-align: center;}
			.lxm_classify_top li a{color: #fff}
			.lxm_pir{width: 1020px; margin: 0 auto;}
			.lxm_classify_top .active{background:#b30000;}
			.lxm_classify_top li:hover{background:#b30000;}
			.titsh{background-color: rgba(0, 0, 0, 0.42); color:#fff}
			/* .lxm_classify_top ul >li:first-child {background: #f60;} */
		</style>
	</head>

	<body>
		<jsp:include page="/jsp/computer/loginPanel.jsp"/>	
		<!--header-->
		<div class="top">
			<div class="topbar">
				<div class="topbar-main md clear">
					<div class="topbar-left fl">
						<span id="loginStatus">您好，欢迎来到繁灯网<a href="#">手机逛商城</a></span>
						<%-- <span id="loginSpan"><a class="loginA" href="JavaScript:void()">[登录]</a>
							<a href="<%=request.getContextPath()%>/user/toRegister">[注册]</a>即可浏览更多精彩内容……</span> --%>
					</div>
					<div class="topbar-right fr">
					<ul>
						<ol>
							<a href="http://wpa.qq.com/msgrd?v=3&uin=1058980845&site=qq&menu=yes" target="_blank"><i class="fa fa-phone-square"></i>在线客服</a>
						</ol>
						<ol>
							<a href="javascript:skip('product/collection_product')"><i class="fa fa-star"></i>我的收藏</a>
						</ol>
						<%-- <ol class="bzdh">
							<a href="#"><i class="fa fa-list"></i>本站导航<i class="fa fa-caret-down caret"></i></a>
							<div class="topbar-nav">
								<div class="list fl">
									<p>79灯网</p>
									<ul name="dengUl">
										<li><a href="<%=request.getContextPath() %>/information/toArticleList?type=帮助中心">帮助中心</a></li>
									</ul>
								</div>
								<div class="list fl">
									<p>新手指南</p>
									<ul name="newGuideUl">
										<li><a href="<%=request.getContextPath() %>/user/findPassword">忘记密码</a></li>
									</ul>
								</div>
								<div class="list fl">
									<p>本站保障</p>
									<ul name="guaranteeUl">
									</ul>
								</div>
								<div class="list fl">
									<p>友情链接</p>
									<ul name="linkUl">
										
									</ul>
								</div>
							</div>
						</ol> --%>
					</ul>
					</div>
				</div>
			</div>
			<div class="header md">
				<div class="logo fl">
				<a href="<%=request.getContextPath() %>/">
					<img src="<%=request.getContextPath()%>/resources/index/images/logo.png" alt="您好，欢迎使用79deng.com访问79灯网！" title="您好，欢迎使用79deng.com访问79灯网！"/>
				</a>
				</div>
				<div class="search fl">
					<input type="text" class="search-text fl" value="${keyword}" id="keyword" onkeydown="if(event.keyCode==13){searchByKeyword();}" oninput="javascript:changeKeyword()">
					<input type="button" value="搜 索" class="search-btn fl" onclick="searchByKeyword()">
					<!-- <input type="button" value="搜店铺" class="search-btn fl btn-left" onclick="searchShopByKeyword()"> -->
				</div>
				<div class="shopcar fr">
					<div class="shopcarBtn" >
						<span class="shopcar-name fl">我的购物车</span>
						<span class="shopcar-num fl">
							<i class="fa fa-shopping-cart fl"></i>
							<span class="fr" id="cartNum"></span>
						</span>
					</div>
					<div class="shopList">
						<div class="shopList-body" id="shopListBody">
							<div class="shopNote">
								<span>最近加入的商品：</span>
								
							</div>
							
						</div>
						<div class="shopList-foot">
							<a href="<%=request.getContextPath() %>/shopCart/shoppingCart" class="fr">查看购物车</a>
						</div>
					</div>
				</div>
			</div>
			<div class="navi">
				<div class="blank"></div>
				<ul>
					<li>
						<a href="<%=request.getContextPath()%>/" <c:if test="${menu==1 }">class="active"</c:if>>首页</a>
					</li>
					<li>
						<a href="<%=request.getContextPath() %>/search/index_search1_pro" <c:if test="${menu==3 }">class="active"</c:if>>新中式</a>
					</li>
					<li>
						<a href="<%=request.getContextPath()%>/search/index_search1_pro" <c:if test="${menu==4 }">class="active"</c:if>>非新中式</a>
					</li>
					<li>
						<a href="<%=request.getContextPath() %>/search/index_search1_dem" <c:if test="${menu==2 }">class="active"</c:if>>需求信息</a>
					</li>
				</ul>
			</div>
		</div>
		<!-- 滑动后出现 -->
			<div class="lxm_classify_top " id="headerMenu">
				<div class="lxm_pir" >
				<ul >
					<c:forEach items="${typeList}" var="l2" varStatus="st">
					<c:choose>
						<c:when test="${l2.propertyValue=='其他'}">
							<li><a href="<%=request.getContextPath()%>/search/index_search1_pro">${l2.propertyValue}</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="<%=request.getContextPath()%>/#lamp${st.index}">${l2.propertyValue}</a></li>						
						</c:otherwise>
					</c:choose>
					</c:forEach>
				</ul>
			</div>
		</div>
	</body>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/index/js/index.js"></script>
	<script type="text/javascript">
	/* $(function(){
            $("li").each(function(index){
                $(this).click(function(){
                  $(".lxm_pir .titsh").removeClass("titsh");
                    $(this).addClass("titsh");
                });
            });               
        }); */
	$(document).ready(function(){
		$(window).scroll(function(){
		    if($(window).scrollTop()>170){
		       /* alert($(window).scrollTop()); */
		      $(".lxm_classify_top").css("display","block");
		      }
		      else if($(window).scrollTop()<170){
		       $(".lxm_classify_top").css("display","none");
		      }
		   });
		});
		$(function(){
				getCartNum();
				getLink();
		});
		
		function getCartNum(){
			 var urlStr = "<%=request.getContextPath()%>/shopCart/getCartNum";
			//alert("Before Call:"+urlStr);
			$.ajax({
				method: "GET",
				url: urlStr,
				success:function(data,status,jqXHR){
					$("#cartNum").html(data);
				}
			}); // end ajax
		} 
		
	function getCartList(){
	  		 var urlStr = "<%=request.getContextPath()%>/shopCart/getCartList";
			//alert("Before Call:"+urlStr);
			$.ajax({
				method: "GET",
				url: urlStr,
				success:function(data,status,jqXHR){
					//alert(data);
					if(data==""){
						urlStr = "<%=request.getContextPath() %>/user/isLogin";
						//alert("Before Call:"+urlStr);
						$.ajax({
							method: "POST",
							url: urlStr,
							success:function(data,status,jqXHR){			
								if(data==""){
									html="登录后可查看购物车<a href='javascript:void()' class='loginA'>[去登陆]</a>";
									
								}else{
									html="购物车里没有货物";				
								}	
								$("#shopListBody").html(html);
							}	
						}); // end ajax
					}else{
						var html="<div class='shopNote'><span>最近加入的商品：</span></div>";
						for(var i=0;i<data.length;i++){
							html+="<div class='shopProd' id='cart'"+data[i].itemId+"><div class='prod fl'>";
							html+="<a href='javascript:void()'><img src='<%=request.getContextPath()%>/resources/upload/product/"+data[i].productCoverPic+"' width='20' height='20' alt='' /></a>";
							html+="</div><div class='text fl'><a href='javascript:void()'>"+data[i].productName+"</a>";
							html+="<span class='text-num fl'>数量：&nbsp;<strong>"+data[i].productNumber+"</strong></span>";
							html+="<span class='text-price fr'>总价：&nbsp;￥<strong>"+data[i].tradeSum+"</strong></span>";
							html+="</div><a href='javascript:deleteCart("+data[i].itemId+")' class='shopList-del fr'>[删除]</a></div>";
						}
					}	
					$("#shopListBody").html(html);
					$(".shopList-del").click(function(){
						$(this).parent().fadeOut("300", function(){
							$(this).remove();
						
						});
					});
				}
			}); // end ajax 
	  	} 
	  	
		//获取友情链接
		function getLink(){
			var urlStr = "<%=request.getContextPath()%>/link/getLink";
			//alert("Before Call:"+urlStr);
			$.ajax({
				method: "GET",
				url: urlStr,
				success:function(data,status,jqXHR){
					 for(var i=0;i<data.length;i++){
						 $("[name='linkUl']").append("<li><a href='"+data[i].link+"'>"+data[i].linkName+"</a></li>");
					 }
				}
			}); // end ajax
		}
		
		
		//获取本站保障下的文章
		function getArticle(name,type){
			var urlStr = "<%=request.getContextPath()%>/information/getArticle?type="+type;
			//alert(urlStr);
			$.ajax({
				method: "GET",
				url: urlStr,
				success:function(data,status,jqXHR){
					if(data!="")
				 		$("[name='"+name+"']").append("<li><a href='<%=request.getContextPath()%>/information/seeArticle?informId="+data+"'>"+type+"</a></li>");				 
				}
			}); // end ajax
		}
		
	  	function deleteCart(itemId){
	  		var urlStr = "<%=request.getContextPath()%>/shopCart/deleteCart?itemId="+itemId;
			//alert("Before Call:"+urlStr);
			$.ajax({
				method: "GET",
				url: urlStr,
				success:function(data,status,jqXHR){
					getCartNum();
				}
			}); // end ajax
	  	}
	  	
	  
		function searchByKeyword(){
//			<c:if test="${searchFlag==1}">
//				window.location.href="<%=request.getContextPath()%>/product/searchProduct?keyword="+$("#keyword").val();
//			</c:if>
//			<c:if test="${searchFlag==0}">
//				window.location.href="<%=request.getContextPath()%>/demand/searchDemand?keyword="+$("#keyword").val();
//			</c:if>
//			<c:if test="${empty searchFlag}">
//				window.location.href="<%=request.getContextPath()%>/product/searchProduct?keyword="+$("#keyword").val();
//			</c:if>
			if(document.getElementById("frm")!=null){
			$("#keyword2").val($("#keyword").val());
			$("#frm").submit();
			}else{
				window.location.href="<%=request.getContextPath()%>/search/index_search1_pro?keyword="+$("#keyword").val();
			}
		}
		
		function searchShopByKeyword(){
			window.location.href="<%=request.getContextPath()%>/shop/searchshop?keyword="+$("#keyword").val();
		}
		
		function changeKeyword()
		{
			if(document.getElementById("keyword2")!=null)
				$("#keyword2").val($("#keyword").val());
		}
	</script>
</html>		