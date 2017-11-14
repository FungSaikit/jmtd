<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="thumbnail" uri="/WEB-INF/tld/thumbnailTag.tld"%>
<!DOCTYPE html>

<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
  <title>金明同达灯饰</title>
  <link href="<%=request.getContextPath() %>/resources/common/swiper.min.css" rel="stylesheet">
  <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
  <link href="<%=request.getContextPath() %>/resources/customer/assets/css/index.css?a1211xdcc1" rel="stylesheet">
  <script src="<%=request.getContextPath() %>/resources/config.js"></script>
  <link href="<%=request.getContextPath() %>/resources/common/liMarquee.css" rel="stylesheet">
  <style>
 	 .demandDiv{
 	 	overflow:hidden;
 	 	padding:0.2rem;
 	 	background-color:#fff;
		margin: .3rem 0;
 	 }
 	 .demandImg{
 	 	width:100%;
 	 }
 	 .imageDiv{
 	 	height:0px;
 	 	width:22%;
 	 	float:left;
 	 	overflow: hidden;
 	 	padding-bottom:22%;
 	 }
 	 .demandDetail{
 	 	float:left;
 	 	padding-left:0.2rem;
 	 	width:75%;
 	 }
 	 .demandDetail span{
 	 	display:block;
 	 }
 	 .demandName{
 	 	font-size:.4rem;filter: url(blur.svg#blur); /* FireFox, Chrome, Opera */
    	/* filter: blur(3px); 
    	-webkit-filter: blur(3px); /* Chrome, Opera */
       	-moz-filter: blur(3px);
        -ms-filter: blur(3px);   */
 	 }
 	 .demandContent{
 	 	font-size:.3rem;
 	 	color:#969696;
 	 	padding-top:.2rem;
 	 }
 	 .prePage{
 	     left: .3rem;
	    position: absolute;
	    top: 1rem;
	    height: 1.2rem;
	    width: 1.2rem;
	    line-height: .7rem;
	    text-align: center;
	    background-color: rgba(0,0,0,.5);
	    border-radius: 50%;
	    color: #fff;
	    display: block;
	    text-decoration: none;
	    border: 0px !important;
	    z-index:100;
 	 }
 	 .setting{
 	    right: .3rem;
	    position: absolute;
	    top: 1rem;
	    height: 1.2rem;
	    width: 1.2rem;
	    line-height: .7rem;
	    text-align: center;
	    background-color: rgba(0,0,0,.5);
	    border-radius: 50%;
	    color: #fff;
	    display: block;
	    text-decoration: none;
	    border: 0px !important;
	    z-index:100;
 	 }
 	 .prePage i，.setting i{
 	 	font-size:.7rem;
 	 }
 	 .orderNum {
	    position: absolute;
	    top: -0.1rem;
	    left: 50%;
	    display: none;
	    background-color: rgba(255,0,0,0.7);
	    width: .7rem;
	    height: .7rem;
	    text-align: center;
	    line-height: .7rem;
	    border-radius: 50%;
	    color: #fff;
	    font-size: .4rem;
	}
	.weui_tab_bd div:first-child{
		margin-top:0rem;
	}
	.noDemandDiv{
		text-align:center;
	}
	.noDemand{
		font-size:.5rem;
		color:#999;
	}
  </style>
 </head>
<body style="overflow-x:hidden;" <c:if test="${(user.role==4&&!empty user.welcomePic)||(upperUser.role==4&&!empty upperUser.welcomePic)}">class="body"</c:if>>

	
<div class="index">
  <!--搜索栏]]-->
 <!--  <a href="http://map.baidu.com/mobile/">百度地图</a> -->
  <!--[[轮播图-->
  <%-- <div class="swiper-container carousel">
  	<c:if test="${user.role!=9}">
	    <a href="<%=request.getContextPath()%>/demand/demandList" class="prePage">
	    	<i class="iconfont">&#xe622;</i><span class="orderNum" id="demandOfferNumber" style="display: none;"></span>
	    </a>
    </c:if>
    <a href="javascript:void()" class="setting filterProduct">
    	<i class="iconfont">&#xe63c;</i>
    	<span class="orderNum" id="demandNumber" style="display: none;"></span>
    </a>
    <div class="swiper-wrapper">
     <c:forEach items="${carouselList}" var="carousel">
     	<div class="swiper-slide"><a href="${carousel.carouselLink}"><img src="${carousel.carouselPic}"></a></div>
     </c:forEach>
    </div>
    <div class="swiper-pagination"></div>
    <!--轮播图]]-->
  </div> --%>
  <!--[[商品-->
  <!--[[搜索栏-->
     <div class="form-group">
     	<img src="<%=request.getContextPath() %>/resources/customer/assets/images/logo.jpg" alt="" class="logo"/>
     	<form action="" id="searchForm"  style="width:83%;margin:0px 0px 0px 14%;">
     		<input placeholder="请输入需求......" class="form-control float-left col-xs-10" name="keyword">
         	<button class="search float-left col-xs-2" type="button"><i class="icon iconfont">&#xe610;</i></button>
		</form>
     </div>
  <!--搜索栏]]-->
  <!-- [[热门推荐-->
  <c:choose>
  	  <c:when test="${empty user || user.role==5 }">
  	  </c:when>
  	  <c:otherwise>
  		<div class="page">
		  <div class="twoStyle">
			<%-- <img id="styleID" src="<%=request.getContextPath() %>/resources/customer/assets/images/styleType.jpg"/> --%>
			<a class="active styleChange styleChange2" href="javascript:void();">所有需求</a>
			<a class=" styleChange styleChange1" href="javascript:void();">我的关注</a>
			
		  </div>
  		</div>
	  </c:otherwise>
  </c:choose>
<div class="recommend" style="margin-top:.1rem;">
    <div class="weui_tab_bd" style="margin-top:0rem;">
      <div class="loading"><i class="iconfont">&#xe62c;</i><span id="jiazai">加载中...</span></div> 
    </div>
  </div> 
  <!-- 热门推荐]]-->
</div>
<div class="tip"></div>

<input type="hidden" value="-1" id="upPageNo"/>
<input type="hidden" value="0" id="downPageNo"/>
<!-- 底部 -->
<input type="hidden" value="<%=request.getContextPath()%>" id="path"/>
<input type="hidden" value="${percent}" id="percent"/>
<input type="hidden" value="${user.role}" id="role"/>
<jsp:include page="/jsp/buyer/demand/demandFooter.jsp"></jsp:include>
<script>
	var offset=0;
	var demandStatus=1;
	var keyword="";
</script>
	<script>
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
		/**
		 * Created by Administrator on 2016/3/31.
		 */
		$(function(){
			var mySwiper = new Swiper('.swiper-container', {
		        direction: 'horizontal',
		        loop: true,
		        autoplay : 3000,
		        autoplayDisableOnInteraction : false,
		        speed:800,
		        effect : 'coverflow',
		        slidesPerView: 1,
		        centeredSlides: true,
		        coverflow: {
		            rotate: 30,
		            stretch: 10,
		            depth: 60,
		            modifier: 2,
		            slideShadows : true
		        },
		        //effect : 'flip',
		        //flip: {
		        //    slideShadows : true,
		        //    limitRotation : true,
		        //},
		        // 如果需要分页器
		        pagination: '.swiper-pagination'
		        //
		        // 如果需要前进后退按钮
		        //nextButton: '.swiper-button-next',
		        //prevButton: '.swiper-button-prev'
	
		        // 如果需要滚动条
		        //scrollbar: '.swiper-scrollbar'
		    });
	
		    var dom = {
		        $tab : $('.weui_navbar_item')
		    };
	
		    //首页tab
		    dom.$tab.on('tap',function(){
		        dom.$tab.removeClass('weui_bar_item_on');
		        $(this).addClass('weui_bar_item_on');
		    });
		    
		    $(".sameSize").height($(".sameSize").width());
		    
		  //开始加载中
		    var canLoad=true;
			var noDate=false;
			var wiwH=$(window).height();
			var load=$(".loading");
			var time;
			var sameSize=$(".sameSize");
			
		    $(document).scroll(function(){
				if(load.offset().top - $(window).scrollTop()<wiwH){
					load.css("visibility","visible");
					if(canLoad&&!noDate){
						load.css("visibility","visible");
						canLoad=false;
						loadProduct();
					}
					if(noDate){
						load.html("");
						load.css("visibility","visible");
					}
					//加载失败
					//$("#jiazai").html("系统繁忙，请稍候再试！");load.css("animation-play-state","paused");
					time=setTimeout(function(){
						$("#jiazai").html("系统繁忙，请稍候再试！");
						$(".loading>i").css("animation-play-state","paused");
					},8000);
				}else{
					window.clearTimeout(time);
					$("#jiazai").html("加载中...");
					load.css("visibility","hidden");
					$(".loading>i").css("animation-play-state","running");
				}
				$(".sameSize").each(function(index){
					var canvas = $(this);
					if(canvas.offset().top - $(window).scrollTop()<wiwH){
						if(canvas.attr("flag")=="false"){
							canvas[0].width=canvas.parent().width();
							canvas[0].height=canvas[0].width;
					        var image = new Image();
				            image.src = canvas.attr("data-src");
				            canvas.attr("flag","true");
				            image.onload = function(){
				            	console.log(canvas.attr("data-src"));
				            	var ctx = canvas[0].getContext('2d');
				                ctx.drawImage( image , 0 , 0 ,canvas[0].width,canvas[0].height);
				            }
						}
					}		
				});
		    });
		    //结束加载中
		    
			$("#popular").tap(function(){
				var divRecomm=$(".recommend").offset().top;
				var osTop=0;
				var timer=setInterval(function(){
					osTop=document.documentElement.scrollTop || document.body.scrollTop;
					if(divRecomm-osTop<divRecomm/20){
						document.documentElement.scrollTop=document.body.scrollTop+=divRecomm-osTop;
						clearInterval(timer);
					}else{
						document.documentElement.scrollTop=document.body.scrollTop+=divRecomm/20;
					}
				},10);
			});
			
			$(function(){
				loadProduct();
			});
			
			/*加载产品*/
			function loadProduct(){
				var url="";
				var params;
				
				url=$("#path").val()+"/demand/indexDemandList";
				params={demandStatus:demandStatus,offset:offset,keyword:keyword};
				doAjax("GET",url,params,loadProductSuccess,fail,true,false);
				sessionStorage.removeItem("scrollTop");
			}
			
			
			function loadProductSuccess(data){
				var productList = data.data.list;
				var html="";
				var i;
				for(i=0;i<productList.length;i++){
					html+='<div class="demandDiv" data-id="'+(productList[i].demandId==null?productList[i].pushDemand.demandId:productList[i].demandId)+'">';
					html+='<div class="imageDiv"><img class="demandImg" src="'+productList[i].demandCover+'"></div>';
					html+='<div class="demandDetail">';
					html+='<span class="demandName">'+productList[i].demandName;
					switch(productList[i].demandStatus){
						case 0:
							html+='<span style="color:red;display:inline">(报价中)</span>';
							break;
						case 1:case 2:
							html+='(报价结束)';
							break;
						case 3:
							html+='(已截止)';
							break;
					}
					if(productList[i].demandOfferStatus==0)
						html+="(已提交)";
					else if(productList[i].demandOfferStatus==1)
						html+="(已采用)";
					else if(productList[i].demandOfferStatus==2)
						html+="(未采用)";
					html+='</span>';
					html+='<span class="demandContent">'+productList[i].demandContent+'</span>';
					html+='<span class="demandContent">需求量：'+productList[i].demandNumber+'</span>';
					html+='<span class="demandContent">发布日期：'+showDate(productList[i].releaseTime==null?productList[i].pushDemand.pushTime:productList[i].releaseTime)+'</span>';
					html+='</div></div>';
				}
				$(html).insertBefore(".loading");
				load.css("visibility","hidden");
				if((parseInt(offset)+10)>=data.data.count){
					noDate=true;
				}
				if(i>9&&i>=data.data.count){
					noDate=true;
				}
				offset=data.data.after;
				canLoad=true;
				if(data.data.count==0&&demandStatus==0){
					$('<div class="noDemandDiv"><span class="noDemand">暂时没有需求~点击添加订阅</span><div>').insertBefore(".loading");	
				}
				
				$(".sameSize").each(function(index){
					var canvas = $(this);
					if(canvas.offset().top - $(window).scrollTop()<wiwH){
						if(canvas.attr("flag")=="false"){
							canvas[0].width=canvas.parent().width();
							canvas[0].height=canvas[0].width;
					        var image = new Image();
				            image.src = canvas.attr("data-src");
				            canvas.attr("flag","true");
				            image.onload = function(){
				            	console.log(canvas.attr("data-src"));
				            	var ctx = canvas[0].getContext('2d');
				            	ctx.drawImage( image , 0 , 0 ,canvas[0].width,canvas[0].height);
				            }
						}
					}		
				});
				
			}
			
			$(".search").tap(function(){
				$(".demandDiv").each(function(){
					$(this).remove();
				});
				$(".noDemandDiv").remove();
				offset=0;noDate=false;
				keyword=$("input[name='keyword']").val();
				loadProduct();
			});
			
			$(document).on("tap",".demandDiv",function(){
				window.location.href="<%=request.getContextPath()%>/demand/demandDetail?demandId="+$(this).attr("data-id");
			})
			
			function changePath(path){
				var i=path.lastIndexOf("/");
				return path.substring(0,i+1)+"thumbnailImage/"+path.substring(i+1);
			}
			
			function fail(data){
				alert("fail");
			}
			$(document).on("tap",".toDetailA",function(e){
				var _thisId=$(this).attr("data-id");
				sessionStorage.setItem("pageNo",$(".toDetailA[data-id='"+_thisId+"']").attr("data-pageNo"));
				sessionStorage.setItem("scrollTop",document.body.scrollTop);
				if(!$(e.target).closest(".toCartBtn").length!=0){
					window.location.href=$("#path").val()+'/product/productDetail?productId='+_thisId;
				}else{
					if(${!empty sessionScope.openId && buyer.role!=9}){
						addShopcart(_thisId,$(this).attr("data-canBuy"));
						$(".fooCartNum").html(parseInt($(".fooCartNum").text())+1);
					}else{
						alert("不能购买");
					}
				}
			});
			
			$(document).on("tap",".noDemand",function(){
				toAddSubscribe();
			})
			
			$(".styleChange").tap(function(){
				if($(this).html()=="我的关注" && !$(this).hasClass("active")){
					$(".twoStyle>a").removeClass("active");
					$(this).addClass("active");

					$(".demandDiv").each(function(){
						$(this).remove();
					});
					$(".noDemandDiv").remove();
					offset=0;noDate=false;
					demandStatus=0;
					loadProduct();
				}else if($(this).html()=="所有需求" && !$(this).hasClass("active")){
					$(".twoStyle>a").removeClass("active");
					$(this).addClass("active");

					$(".demandDiv").each(function(){
						$(this).remove();
					});
					$(".noDemand").remove();
					offset=0;noDate=false;
					demandStatus=1;
					loadProduct();
				}
			});
			
			function toAddSubscribe(){
				var url="<%=request.getContextPath()%>/demand/checkSubscribeNumber";
				var params={};
				doAjax("GET",url,params,function(data){
					if(data.code==1){
						window.location.href="<%=request.getContextPath()%>/demand/toAddSubscribe";
					}else{
						alert("订阅的需求不能超过三个");
					}
				},function(data){console.log("false")},false,false);
			}
			
			function showDate(str){
				var date = new Date(str);
				return date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
			}
			
			function addShopcart(productId,canBuy) {
				/*if(${product.product.productKind==1}){ 
					if($(".num").val()<=parseInt($("#num").text())){ */
					if(canBuy=="null"){
						var url = $("#path").val()+"/shopcart/addShopcart";
						var params = {productId: productId,num:1}
						doAjax("GET", url, params, addShopcartSuccess, fail1, true, false);
					}else{
						showTip("暂时不能购买")
					}
					/* }
					else{
						$(".tip").html("添加数量不能多于库存量！");
						$(".tip").css("opacity","0.8");
						setTimeout(function(){
							$(".tip").css("opacity","0");
						},1000);
					} */
				/*}else{
					var url = "<%=request.getContextPath()%>/shopcart/addShopcart";
					var params = {productId: productId,num:$(".num").val()}
					doAjax("GET", url, params, success, fail, true, false);
				}*/
			}
			
			function addShopcartSuccess(data){
				showTip("加入购物车成功");countShopcart();
			}
			
			function fail1(data){
				alert("fail");
			}
		});
		
		$(".welcome").tap(function(){
			$(this).addClass("fadeOut");
			$("body").removeClass("body");
			var that=this;
			setTimeout(function(){
				$(that).width(0);
			},1500)
		});
		
		setTimeout(function(){
			$(".welcome").addClass("fadeOut");
			$("body").removeClass("body");
			setTimeout(function(){
				$(".welcome").width(0);
			},1500)
		},3000);
		
		getDemandOfferNumber();getPushDemandNumber();
		
		function getDemandOfferNumber(){
			var url="<%=request.getContextPath()%>/demand/countNewDemandOfferNumber";
			var params={};
			doAjax("GET",url,params,function(data){
				if(data.data!=0){
					$("#demandOfferNumber").html(data.data);
					$("#demandOfferNumber").show();
				}
			},function(data){console.log("fail"),true,false})
		}
		
		function getPushDemandNumber(){
			var url="<%=request.getContextPath()%>/demand/countNewDemandNumber";
			var params={};
			doAjax("GET",url,params,function(data){
				if(data.data!=0){
					$("#demandNumber").html(data.data);
					$("#demandNumber").show();
				}
			},function(data){console.log("fail"),true,false})
		}
		
		
	</script>
</body>	
</html>