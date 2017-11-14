<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="thumbnail" uri="/WEB-INF/tld/thumbnailTag.tld"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
   	<meta name="format-detection" content="telephone=no" />
    <title>金明同达灯饰</title>
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/common/dropload.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/customer/assets/css/product.css?11xxx1xcbacq" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
 	
  </head>
  <body class="all">
  	<c:set var="SALES_SORT" value="<%=ProductSortType.SALES_SORT%>" />
	<c:set var="NEW_SORT" value="<%=ProductSortType.NEW_SORT%>" />
	<c:set var="PRICE_SORT" value="<%=ProductSortType.PRICE_SORT%>" />
	<c:set var="CUSTOMER" value="<%=UserType.CUSTOMER%>" />
	<c:set var="AUTHENTICATION_SUCCESS" value="<%=UserCheckStatus.AUTHENTICATION_SUCCESS%>" />
    <div class="productList">	
      <div class="title">产品列表</div>
      <div class="product-content">
        <!--[[搜索栏-->
        <form class="search" onsubmit="searchByKeyword();return false">
          <div class="formDiv">
              <input placeholder="请输入搜索内容......" class="searchInput" id="keyword" value="${productParam.keyword }">
              <a class="searchBtn" href="javascript:searchByKeyword()"><i class="iconfont">&#xe610;</i></a>
              <input type="file" id="file">
          </div>
        </form>
        <!--搜索栏]]-->
      </div>
      <!--[[商品-->
      <div class="page">
        <div style="hight:100%;" class="bd">
          <div class="weui_tab">
            <!--商品类别-->
            <div class="weui_navbar">
              <div class="weui_navbar_item" data="${SALES_SORT}"><a href="javascript:orderBy(${SALES_SORT })">热门</a></div>
              <div class="weui_navbar_item" data="${NEW_SORT}"><a href="<%=request.getContextPath()%>/product/spreadProductList	">推荐</a></div>
              <div class="weui_navbar_item" data="${PRICE_SORT}"><a href="javascript:orderBy(${PRICE_SORT })">价格</a></div>
              <div class="weui_navbar_item filterA filterProduct">筛选</div>
            </div>
            <!--商品类别-->
            <!--商品-->
            <div class="weui_tab_bd">
            <div class="pageDiv" style="display:none">
            	<div class="pageUpDown">
	              	<button id="pagePrev">上一页</button>
	              	<button id="pageNow"><span id="now">1</span>/10</button>
	              	<button id="pageNext">下一页</button>
	            </div>
	            <!-- 选择页数-->
				<div class="choosePage">
					<div class="choosePageClose">
						<span>选择页数</span>
						<i class="iconfont" id="closePage">&#xe632;</i>
					</div>
					<ul class="allPage">
					</ul>
				</div>
            </div>
          </div>
          <div class="noProduct">
          	  <span><i class="iconfont">&#xe623;</i></span>
	          <p>没有找到符合条件的灯具</p>
	          <button id="allBtn">查看所有商品</button>
          </div>
        </div>
      </div>
      <!--商品]]-->
    </div>
    <!--[[底部-->
   	<jsp:include page="/jsp/buyer/footer.jsp"></jsp:include>
    <!--底部]]-->
    
</div>
<form action="<%=request.getContextPath() %>/product/productList" id="productForm">
   	<input type="hidden" name="keyword" value="${productParam.keyword }">
   	<input type="hidden" name="type" value="${productParam.type}">
   	<input type="hidden" name="style" value="${productParam.style}">
   	<input type="hidden" name="material" value="${productParam.material}">
   	<input type="hidden" name="space" value="${productParam.space}">
   	<input type="hidden" name="fromPrice" value="${productParam.fromPrice}">
   	<input type="hidden" name="toPrice" value="${productParam.toPrice}">
   	<input type="hidden" name="province" value="${productParam.province}">
   	<input type="hidden" name="city" value="${productParam.city}">
   	<input type="hidden" name="area" value="${productParam.area}">
   	<input type="hidden" name="isPopular" value="${productParam.isPopular}">
   	<input type="hidden" name="orderBy" value="${productParam.orderBy}">
   	<input type="hidden" name="brand" value="${productParam.brand}">
   	<input type="hidden" name="shape" value="${productParam.shape}">
   	<input type="hidden" name="fromDiameter" value="${productParam.fromDiameter}">
   	<input type="hidden" name="toDiameter" value="${productParam.toDiameter}">
   	<input type="hidden" name="plies" value="${productParam.plies}">
   	<input type="hidden" name="lightType" value="${productParam.lightType}">
   	<input type="hidden" name="offset" value="0"> 
</form>  
	<!--提示框 -->
	<div class="tip"></div>
    <input type="hidden" value="-1" id="upPageNo"/>
    <input type="hidden" value="0" id="downPageNo"/>
    <script src="<%=request.getContextPath() %>/resources/customer/assets/js/product.js?1"></script>
    <script src="<%=request.getContextPath() %>/resources/common/dropload.js"></script>
    <script src="<%=request.getContextPath() %>/resources/common/hidpi-canvas.min.js"></script>
   
    <script>
    	var k=0;	
    	if(sessionStorage.getItem("pageNo")==null){
    		$("#upPageNo").val(-1);
    		$("#downPageNo").val(${offset});
    	}else{
    		$("#downPageNo").val(sessionStorage.getItem("pageNo"));
    		if(sessionStorage.getItem("pageNo")%100==0)
    			$("#upPageNo").val(-1);
    		else
    			$("#upPageNo").val(sessionStorage.getItem("pageNo")-10);
    	}
		//开始分页
    	$(document).on("tap",".allPage li",function(){
    		var pageNo=$(this).html();
    		hideChoose();
    		//页面跳转至所选页
    		$("input[name='offset']").val((pageNo-1)*100);
    		$("#productForm").submit();
    	});
    	
    	$("#pageNow").tap(function(){
    		if($(".choosePage").css("display")=="block"){
    			hideChoose();
    		}else{
    			showChoose();
    		}
    	});
    	
    	$("#closePage").tap(function(){
    		hideChoose();
    	});
    	
    	function showChoose(){
    		$(".choosePage").css("display","block");
    		$("#pagePrev").css("border-radius","0 0 0 3px");
    		$("#pageNext").css("border-radius","0 0 3px 0");
    	}
    	
    	function hideChoose(){
    		$(".choosePage").css("display","none");
    		$("#pagePrev").css("border-radius","3px 0 0 3px");
    		$("#pageNext").css("border-radius","0 3px 3px 0");
    	}
    	//结束分页
    	
    	$("#file").change(function(){
    		var data = new FormData();
    		data.append("file",this.files[0]);
    		$.ajax({
    			type : "post",
    			url : "<%=request.getContextPath()%>/file/uploadSearchImage",
    			data : data,
    			processData : false,
    			contentType : false,
    			success : function(data){
    				var url="<%=request.getContextPath()%>/buyer/testSimilar";
    				doAjax("GET",url,{file:data.data},similarSuccess,fail,true,false);
    			},
    			error : function(data){
    				alert("----error----");
    			}
    		});
    	});
    	
    	function changePath(path){
    		var i=path.lastIndexOf("/");
    		return path.substring(0,i+1)+"thumbnailImage/"+path.substring(i+1);
    	}
    	
    	function similarSuccess(data){
    		var productList = data.list;
    		var html="";
    		for(var i=0;i<productList.length;i++){
    			if(i%2==0)
    				html+='<div class="twoProduct">';
    			html+='<div class="oneProduct" data-id="'+productList[i].productId+'" data-pageNo="'+$("#upPageNo").val()+'">';
    			html+='<a class="productA" data-id="'+productList[i].productId+'" data-buy="'+productList[i].buyFlag+'">';
            	html+='<div class="backImage">';
            	html+='<canvas class="sameSize canvas" flag="false" data-src="'+changePath(productList[i].cover1)+'"></canvas>';
            	html+='</div>';
            	html+='<div class="product-msg">';
            	html+='<div class="product-name ellipsis-product-name">'+productList[i].productName+'</div>';
            	html+='<div class="product-value">';
            	
                html+='<div>￥'+productList[i].retailPrice+'</div>';
            	   
                html+='<div class="toCartBtn" data-id='+productList[i].productId+'><button>加入购物车</button></div>';
            	html+='</div></div></a><div class="tag">';
            	if(productList[i].productTag==null){
                	switch(productList[i].productKind){
	            		case 0:
	            			html+="订货";
	            			break;
	            		case 1:
	            			html+="";
	            			break;
	            	}
            	}else{
            		html+=productList[i].productTag;
            	}
            	html+='</div></div>';
            	if(i%2==1)
    				html+='</div>';
    		}
    		var top=$(".weui_tab_bd .oneProduct").eq(0);
			$(".weui_tab_bd").prepend(html);
			document.body.scrollTop=top[0].offsetTop+30;
    		/* load.css("visibility","hidden"); */
			

			
    		$(".sameSize").each(function(index){
    			var canvas = $(this);
    			if(canvas.offset().top - $(window).scrollTop()<wiwH){
    				if(canvas.attr("flag")=="false"){
    					canvas[0].width=canvas.parent().width();
    					canvas[0].height=canvas[0].width;
    			        var context = canvas[0].getContext("2d");
    			        var image = new Image();
    		            image.src = canvas.attr("data-src");
    		            canvas.attr("flag","true");
    		            image.onload = function(){
    		                context.drawImage( image , 0 , 0 ,canvas[0].width,canvas[0].height);
    		            }
    				}
    			}		
			});
    	}
    	
    	$("#pageNo").val(0);
    	
    	$(".weui_navbar_item").tap(function(){
    		if(!$(this).hasClass("filterA")){
    			if($(this).attr("data")!="1"){
	    			$("input[name='orderBy']").val($(this).attr("data"));
	        		$("#productForm").submit();
    			}else{
        			window.location.href="<%=request.getContextPath()%>/product/spreadProductList";
        		}
    		}
    	});
    	
    	function orderBy(orderBy){
			$("input[name='orderBy']").val(orderBy);
    		$("#productForm").submit();
    	}
    	
    	function toPage(offset){
    		$("input[name='offset']").val(offset);
    		$("#productForm").submit();
    	}
    	
    	function searchByKeyword(){
        	sessionStorage.removeItem("pageNo");
    		$("input[name='keyword']").val($("#keyword").val());
    		$("input[name='offset']").val(0);
    		$("#productForm").submit();
    	}
    	
    	var percent="${percent}";
    	var canLoad=true;
    	var noDate=false;
    	$(function(){
    		var wiwH=$(window).height();
    		//开始加载中
    		/* var wiwH=$(window).height();
    		var load=$(".loading");
    		var time; */
    		//loadProduct();
    	   
    		$(document).scroll(function(){
    			/* if(load.offset().top - $(window).scrollTop()<wiwH){
    				if(canLoad&&!noDate){
        				load.css("visibility","visible");
    					canLoad=false;
    					loadProduct();
    				}
    				if(noDate){
        				load.html("暂无更多产品");
        				load.css("visibility","visible");
    				}
    				//ajax加载数据
    				//加载成功
    				//load.css("visibility","hidden");
    				//加载失败
    				//$("#jiazai").html("系统繁忙，请稍候再试！");load.css("animation-play-state","paused");
    				time=setTimeout(function(){
    					$("#jiazai").html("系统繁忙，请稍候再试！");
    					$(".loading>i").css({
    						"animation-play-state":"paused",
    						"-webkit-animation-play-state":"paused"
    					});
    				},8000);
    			}else{
    				window.clearTimeout(time);
    				$("#jiazai").html("加载中...");
    				load.css("visibility","hidden");
    				$(".loading>i").css({
   						"animation-play-state":"running",
						"-webkit-animation-play-state":"running"
					});
    			} */
    			$(".sameSize").each(function(index){
    				var canvas = $(this);
    				if(canvas.offset().top - $(window).scrollTop()<wiwH){
    					if(canvas.attr("flag")=="false"){
    						canvas[0].width=canvas.parent().width();
    						canvas[0].height=canvas[0].width;
    				        var context = canvas[0].getContext("2d");
    				        var image = new Image();
    			            image.src = canvas.attr("data-src");
    			            canvas.attr("flag","true");
    			            image.onload = function(){
    			                context.drawImage( image , 0 , 0 ,canvas[0].width,canvas[0].height);
    			            }
    					}
    				}			
    			});
    	    });
    	    //结束加载中
    	    
    		function loadProductUp(me){
				$("input[name='offset']").val($("#upPageNo").val());
				$.ajax({
                    type: 'GET',
                    url: '<%=request.getContextPath()%>/product/productListAjax',
                    dataType: 'json',
                    data:$("#productForm").serialize(),
                    success: function(data){
                    	 loadProductUpS(data);
                    	 me.resetload();
                         me.unlock();
                         me.noData(false);
                    },
                    error: function(xhr, type){
                    	console.log('Ajax error!');
                        // 即使加载出错，也得重置
                        me.resetload();
                    }
                });
        	}
        	
        	function loadProductUpS(data){
        	    var productList = data.list;
        		var html="";
        		for(var i=0;i<productList.length;i++){
        			if(i%2==0)
        				html+='<div class="twoProduct">';
        			html+='<div class="oneProduct" data-id="'+productList[i].productId+'" data-pageNo="'+$("#upPageNo").val()+'">';
        			html+='<a class="productA" data-id="'+productList[i].productId+'" data-buy="'+productList[i].buyFlag+'">';
                	html+='<div class="backImage">';
                	html+='<canvas class="sameSize canvas" flag="false" data-src="'+changePath(productList[i].cover1)+'"></canvas>';
                	html+='</div>';
                	html+='<div class="product-msg">';
                	html+='<div class="product-name ellipsis-product-name">'+productList[i].productName+'</div>';
                	html+='<div class="product-value">';
                	
	                html+='<div>￥'+productList[i].retailPrice+'</div>';
                	   
	                html+='<div class="toCartBtn" data-id='+productList[i].productId+'><button>加入购物车</button></div>';
                	html+='</div></div></a><div class="tag">';
                	if(productList[i].productTag==null){
	                	switch(productList[i].productKind){
		            		case 0:
		            			html+="订货";
		            			break;
		            		case 1:
		            			html+="";
		            			break;
		            	}
                	}else{
                		html+=productList[i].productTag;
                	}
	            	html+='</div></div>';
                	if(i%2==1)
        				html+='</div>';
        		}
        		var top=$(".weui_tab_bd .oneProduct").eq(0);
    			$(".weui_tab_bd").prepend(html);
    			document.body.scrollTop=top[0].offsetTop+30;
        		/* load.css("visibility","hidden"); */
    			

        		if($("#upPageNo").val()==0){
        			canLoad=false;
        		}else{
        			canLoad=true;
        		}
        		
    			if($("#upPageNo").val()==0){
    				$("#upPageNo").val("-1")
    			}else
        			$("#upPageNo").val(data.before);
				
        		$(".sameSize").each(function(index){
        			var canvas = $(this);
        			if(canvas.offset().top - $(window).scrollTop()<wiwH){
        				if(canvas.attr("flag")=="false"){
        					canvas[0].width=canvas.parent().width();
        					canvas[0].height=canvas[0].width;
        			        var context = canvas[0].getContext("2d");
        			        var image = new Image();
        		            image.src = canvas.attr("data-src");
        		            canvas.attr("flag","true");
        		            image.onload = function(){
        		                context.drawImage( image , 0 , 0 ,canvas[0].width,canvas[0].height);
        		            }
        				}
        			}		
    			});
        	}
        	
        	
        	
        	function loadProductDown(me){

    			if(noDate){
    				if($("#downPageNo").val()==0){
    					me.noData(true);
    				}
               	 	me.resetload(true);
                    me.unlock('up');
    			}else{
    				$("input[name='offset']").val($("#downPageNo").val());
    				$.ajax({
                        type: 'GET',
                        url: '<%=request.getContextPath()%>/product/productListAjax',
                        dataType: 'json',
                        data:$("#productForm").serialize(),
                        success: function(data){
                        	 loadProductDownS(data);
                        	 me.resetload();
                             me.unlock();
                             me.noData(false);
                        },
                        error: function(xhr, type){
                        	console.log('Ajax error!');
                            // 即使加载出错，也得重置
                            me.resetload();
                        }
                    });
    			}

        	}
        	
        	
        	function loadProductDownS(data){
        	    var productList = data.list;
        		var html="";
        		for(var i=0;i<productList.length;i++){
        			console.log(productList[i].productId);
        			if(i%2==0)
        				html+='<div class="twoProduct">';
        			html+='<div class="oneProduct" data-id="'+productList[i].productId+'" data-pageNo="'+$("#downPageNo").val()+'">';
                	html+='<a class="productA" data-id="'+productList[i].productId+'"  data-buy="'+productList[i].buyFlag+'">';
                	html+='<div class="backImage">';
                	html+='<canvas class="sameSize canvas" flag="false" data-src="'+changePath(productList[i].cover1)+'"></canvas>';
                	html+='</div>';
                	html+='<div class="product-msg">';
                	html+='<div class="product-name ellipsis-product-name">'+productList[i].productName+'</div>';
                	html+='<div class="product-value">';
	                html+='<div>￥'+productList[i].retailPrice+'</div>';
	                html+='<div class="toCartBtn" data-id='+productList[i].productId+'><button>加入购物车</button></div>';
                	html+='</div></div></a><div class="tag">';
                	if(productList[i].productTag==null){
	                	switch(productList[i].productKind){
		            		case 0:
		            			html+="订货";
		            			break;
		            		case 1:
		            			html+="";
		            			break;
		            	}
                	}else{
                		html+=productList[i].productTag;
                	}
                	html+='</div></div>';
                	if(i%2==1)
        				html+='</div>';
        		}
    			$(html).insertBefore(".pageDiv");	
        		/* load.css("visibility","hidden"); */
        		
    			if((parseInt($("#downPageNo").val())+10)>=data.count){
    				noDate=true;
    				$(".dropload-down").hide();
    				if(data.count>100){
        				$(".pageDiv").show();
    				}
    			}
        		
        		if(parseInt($("#downPageNo").val())%100==90){
    				if(data.count>100){
        				$(".pageDiv").show();
    				}
    				noDate=true;
    				$(".dropload-down").hide();
        		}
    			
    			if(k==0){
        			var pageCount=parseInt((data.count-1)/100)+1;
        			var li="";
        			for(var i=0;i<pageCount;i++){
        				li+="<li>"+(i+1)+"</li>";
        			}
        			$(".allPage").html(li);
  					currentPage=parseInt($("#downPageNo").val()/100)+1;
  					$("#pageNow").html("<span id='now'>"+currentPage+"</span>/"+pageCount);
        			k++;
        			if(currentPage!=1)
	              		$("#pagePrev").attr("data-offset",(currentPage-2)*100);
        			else
        				$("#pagePrev").attr("data-offset",0);
        			
        			if(currentPage!=pageCount)
        				$("#pageNext").attr("data-offset",currentPage*100);
        			else
        				$("#pageNext").attr("data-offset",(currentPage-1)*100);
        		}
        		
        		$("#downPageNo").val(data.after);

        		canLoad=true;
        		//没有商品时显示对于的页面
        		if(data.count==0){
        			$(".noProduct").show();
        			$(".pageDiv").hide();
        		}
        		
        		$(".sameSize").each(function(index){
        			var canvas = $(this);
        			if(canvas.offset().top - $(window).scrollTop()<wiwH){
        				if(canvas.attr("flag")=="false"){
        					canvas[0].width=canvas.parent().width();
        					canvas[0].height=canvas[0].width;
        			        var context = canvas[0].getContext("2d");
        			        var image = new Image();
        		            image.src = canvas.attr("data-src");
        		            canvas.attr("flag","true");
        		            image.onload = function(){
        		                context.drawImage( image , 0 , 0 ,canvas[0].width,canvas[0].height);
        		            }
        				}
        			}			
    			});
        	}
        	
           
            // dropload
            $('.weui_tab_bd').dropload({
                scrollArea : window,
                domUp : {
                    domClass   : 'dropload-up',
                    domRefresh : '<div class="dropload-refresh"><i class="iconfont">&#xe634;</i>下拉刷新</div>',
                    domUpdate  : '<div class="dropload-update"><i class="iconfont">&#xe633;</i>释放更新</div>',
                    domLoad    : '<div class="dropload-load"><span class="iconfont">&#xe62c;</span>加载中...</div>',
                    domNoData  : '<div class="dropload-noData">已经到顶部了</div>'
                },
                domDown : {
                    domClass   : 'dropload-down',
                    domRefresh : '<div class="dropload-refresh"><i class="iconfont">&#xe633;</i>上拉加载更多</div>',
                    domLoad    : '<div class="dropload-load"><span class="iconfont">&#xe62c;</span>加载中...</div>',
                    domNoData  : '<div class="dropload-noData">暂无数据</div>'
                },
                loadUpFn : function(me){
                	/* if(parseInt($("#upPageNo").val())>=0)
                		if(canLoad){
     		               	loadProductUp(me);
                		}else{
                			me.resetload();
                            me.unlock();
            				me.noData(true);
            				showTip("已经到顶部了!");
                		}
                	else{
                		me.resetload();
                        me.unlock();
        				me.noData(true);
        				showTip("已经到顶部了!");
                	} */
                },
                loadDownFn : function(me){
                	//loadProductDown(me);
                },
                threshold : 50
            });
    	});
    	$(document).on("tap",".productA",function(e){
        	var _thisId=$(this).attr("data-id");
    		if(!$(e.target).closest(".toCartBtn").length!=0){
    			sessionStorage.setItem("pageNo",$(".oneProduct[data-id='"+_thisId+"']").attr("data-pageNo"));
    			window.location.href="<%=request.getContextPath()%>/product/productDetail?productId="+_thisId;
    		}else{
				if(${!empty sessionScope.openId && user.role!=9}){
    				addShopcart(_thisId,$(this).attr("data-buy"));

					if($(this).attr("data-buy")=="null")
	    			$(".fooCartNum").html(parseInt($(".fooCartNum").text())+1);
    			}else{
    				alert("不能购买");
    			}
    		}
    	});
    	
    	/* $(document).on("tap",".toDetailA",function(e){
    		var _thisId=$(this).attr("data-id");
    		if(!$(e.target).closest(".toCartBtn").length!=0){
    			window.location.href=$("#path").val()+'/product/productDetail?productId='+_thisId;
    		}else{
    			addShopcart(_thisId)
    			$(".fooCartNum").html(parseInt($(".fooCartNum").text())+1);
    		}
    	}); */
    	
    	$("#pageNext").tap(function(){
    		sessionStorage.removeItem("pageNo");
    		$("input[name='offset']").val($(this).attr("data-offset"));
    		$("#productForm").submit();
    	});
    	
    	$("#pagePrev").tap(function(){
    		sessionStorage.removeItem("pageNo");
    		$("input[name='offset']").val($(this).attr("data-offset"));
    		$("#productForm").submit();
    	});
    	
    	$("#allBtn").tap(function(){
    		window.location.href="<%=request.getContextPath()%>/product/productList";
    	});
    	
    	function addShopcart(productId,buyFlag){
			/*if(${product.product.productKind==1}){ 
				if($(".num").val()<=parseInt($("#num").text())){ */
				if(buyFlag=="null"){
					var url = "<%=request.getContextPath()%>/shopcart/addShopcart";
					var params = {productId: productId,num:1}
					doAjax("GET", url, params, addShopcartSuccess, fail, true, false);
				}else{
					showTip("暂时不能购买");
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
				doAjax("GET", url, params, addShopcartSuccess, fail, true, false);
			}*/
		}
		
		function addShopcartSuccess(data){
    			showTip("加入购物车成功");countShopcart();
    	}
    </script>
  </body>
</html>