<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="thumbnail" uri="/WEB-INF/tld/thumbnailTag.tld"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>佐为照明</title>
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/customer/assets/css/product.css?ba1ss" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
    <link href="<%=request.getContextPath() %>/resources/common/dropload.css" rel="stylesheet">
	<style>
		
	</style>
</head>
<body class="all">
<c:set var="SALES_SORT" value="<%=ProductSortType.SALES_SORT%>" />
<c:set var="NEW_SORT" value="<%=ProductSortType.NEW_SORT%>" />
<c:set var="PRICE_SORT" value="<%=ProductSortType.PRICE_SORT%>" />
<c:set var="CUSTOMER" value="<%=UserType.CUSTOMER%>" />
<c:set var="AUTHENTICATION_SUCCESS" value="<%=UserCheckStatus.AUTHENTICATION_SUCCESS%>" />
<div class="productList">
    <div class="title">精选产品</div>
    <!--[[商品-->
    <div class="page">
        <div style="hight:100%;" class="bd">
            <div class="weui_tab">
                <!--商品类别-->
                <!--商品-->
                <div class="page">
	                <div class="weui_tab_bd" style="padding: 0.2rem 0.2rem 0.2rem 0.2rem;">
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
	            </div>
       		 </div>
    	</div>
    	<!--商品]]-->
	</div>
</div>
<!--[[底部-->
<jsp:include page="/jsp/buyer/footer.jsp"></jsp:include>
<!--提示框 -->
<div class="tip"></div>
<input type="hidden" value="-1" id="upPageNo"/>
<input type="hidden" value="0" id="downPageNo"/>
 <form action="<%=request.getContextPath() %>/product/spreadProductList" id="shopProductForm">
    	<input type="hidden" name="offset" value="0"> 
    </form> 
<script src="<%=request.getContextPath() %>/resources/common/dropload.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/hidpi-canvas.min.js"></script>
<!--底部]]-->
<script>
var k=0;	
if(sessionStorage.getItem("pageNo")==null){
	$("#upPageNo").val(-1);
	$("#downPageNo").val(0);
}else{
	$("#downPageNo").val(sessionStorage.getItem("pageNo"));
	if(sessionStorage.getItem("pageNo")==0)
		$("#upPageNo").val(-1);
	else
		$("#upPageNo").val(sessionStorage.getItem("pageNo")-10);
}
//开始分页
$(document).on("tap",".allPage li",function(){
	var pageNo=$(this).html();
	hideChoose();
	//页面跳转至所选页
	$("input[name='offset']").val((pageNo-1)*200);
	$("#shopProductForm").submit();
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

$("#pageNo").val(0);
var canLoad=true;
var noDate=false;
$(function(){
	var wiwH=$(window).height();
	$(document).scroll(function(){
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
            url: '<%=request.getContextPath()%>/product/spreadProductListAjax',
            dataType: 'json',
            data:$("#shopProductForm").serialize(),
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
			html+='<div class="oneProduct" data-id="'+productList[i].productId+'" data-pageNo="'+$("#upPageNo").val()+'" >';
			html+='<a class="toDetailA" data-id='+productList[i].productId+' data-buy="'+productList[i].buyFlag+'">';
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
        	
        	html+='</div>';/* 
        	if(${user.role==2}||${user.role==4}||${user.role==6})
        		html+='<div class="picBtn"><i class="icon iconfont">&#xe623;</i></div>'; */
        	html+='</div>';
        	if(i%2==1)
				html+='</div>';
		}
		var top=$(".weui_tab_bd .oneProduct").eq(0);
		$(".weui_tab_bd").prepend(html);
		document.body.scrollTop=top[0].offsetTop+30;
		/* load.css("visibility","hidden"); */
		if((parseInt($("input[name='offset']").val())+10)>=data.count){
			noDate=true;
		}
		
		if($("#upPageNo").val()==0){
			$("#upPageNo").val("-1")
		}else
			$("#upPageNo").val(data.before);

		canLoad=true;
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
	
	function changePath(path){
		var i=path.lastIndexOf("/");
		return path.substring(0,i+1)+"thumbnailImage/"+path.substring(i+1);
	}
	
	function loadProductDown(me){
		if(noDate){
			if($("#downPageNo").val()==0)
				me.noData(true);
		}else{
			$("input[name='offset']").val($("#downPageNo").val());
			$.ajax({
                type: 'GET',
                url: '<%=request.getContextPath()%>/product/spreadProductListAjax',
                dataType: 'json',
                data:$("#shopProductForm").serialize(),
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
			if(i%2==0)
				html+='<div class="twoProduct">';
			html+='<div class="oneProduct" data-id="'+productList[i].productId+'" data-pageNo="'+$("#downPageNo").val()+'">';
        	html+='<a class="toDetailA" data-id='+productList[i].productId+' data-buy="'+productList[i].buyFlag+'">';
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
        	html+='</div>';
        	/* if(${user.role==2}||${user.role==4}||${user.role==6})
        		html+='</div><div class="picBtn"><i class="icon iconfont">&#xe623;</i></div>'; */
            	html+='</div>';
        	if(i%2==1)
				html+='</div>';
		}
		$(html).insertBefore(".pageDiv");	
		/* load.css("visibility","hidden"); */
		if((parseInt($("#downPageNo").val())+10)>=data.count){
			noDate=true;
			$(".pageDiv").show();
			$(".dropload-down").hide();
		}
		
		console.log(parseInt($("#downPageNo").val())%200);
		if(parseInt($("#downPageNo").val())%200==190){
			$(".pageDiv").show();
			$(".dropload-down").hide();
		}
		
		if(k==0){
			var pageCount=parseInt(data.count/200)+1;
			var li="";
			for(var i=0;i<pageCount;i++){
				li+="<li>"+(i+1)+"</li>";
			}
			$(".allPage").html(li);
				currentPage=parseInt($("#downPageNo").val()/200)+1;
				$("#pageNow").html("<span id='now'>"+currentPage+"</span>/"+pageCount);
			k++;
			if(currentPage!=1)
          		$("#pagePrev").attr("data-offset",(currentPage-2)*200);
			else
				$("#pagePrev").attr("data-offset",0);
			
			if(currentPage!=pageCount)
				$("#pageNext").attr("data-offset",currentPage*200);
			else
				$("#pageNext").attr("data-offset",(currentPage-1)*200);
				
		}
		
		$("#downPageNo").val(data.after);

		canLoad=true;
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
        	if(parseInt($("#upPageNo").val())>=0)
	               	loadProductUp(me);
        	else{
        		me.resetload();
                me.unlock();
				me.noData(true);
				showTip("已经到顶部了!");
        	}
        },
        loadDownFn : function(me){
        	loadProductDown(me);
        },
        threshold : 50
        
    });
});

$(document).on("tap",".toDetailA",function(e){
	var _thisId=$(this).attr("data-id");
	if(!$(e.target).closest(".toCartBtn").length!=0){
		sessionStorage.setItem("pageNo",$(".oneProduct[data-id='"+_thisId+"']").attr("data-pageNo"));
		window.location.href="<%=request.getContextPath()%>/product/productDetail?productId="+_thisId;
	}else{
		addShopcart(_thisId,$(this).attr("data-buy"));

		if($(this).attr("data-buy")=="null")
			$(".fooCartNum").html(parseInt($(".fooCartNum").text())+1);
	}
});

$("#pageNext").tap(function(){
	sessionStorage.removeItem("pageNo");
	$("input[name='offset']").val($(this).attr("data-offset"));
	$("#shopProductForm").submit();
});

$("#pagePrev").tap(function(){
	sessionStorage.removeItem("pageNo");
	$("input[name='offset']").val($(this).attr("data-offset"));
	$("#shopProductForm").submit();
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
    		showTip("加入购物车成功");
    	}
		

    	<%-- $(document).on("tap",".picBtn",function(){
    		var productId=$(this).parents(".oneProduct").attr("data-id");
    		var url="<%=request.getContextPath()%>/product/generateSpreadProductPic";
    		var params = {productId:productId};
    		$(".shade").show();
    		$(".waiting").show();
    		doAjax("GET",url,params,function(data){
    			$(".shade").hide();
    			$(".waiting").hide();
				showTip("产品推广图生成成功!");},function(){console.log("fail"),true,false});
    	}); --%>
</script>
</body>
</html>