<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>佐为照明</title>
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/factory/assets/css/order.css" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
</head>
<body>
<div class="orderStock">
    <div class="title">库存管理</div>
    <div class="allStatus">
    	<ul id="statusUl">
	    	<li <c:if test="${orderStockStatus==1 }">class="active"</c:if>><a href="<%=request.getContextPath()%>/factory/newOrderStation?orderStockStatus=1">已上线</a></li>
	    	<li <c:if test="${orderStockStatus==2 }">class="active"</c:if>><a href="<%=request.getContextPath()%>/factory/newOrderStation?orderStockStatus=2">已下架</a></li>
	    </ul>
    </div>
    <div class="stockInfo">
    	<c:forEach items="${beforeAfterPager.list}" var="product" varStatus="i">
   		<div class="orderStock">
   			<div class="orderStockHead">
   				<p>系列：${product.product.productSeriesId}</p>
   			</div>
   			<div class="orderStockBody">
   				<c:forEach items="${product.seriesProductList }" var="product">
   				<div class="stock" data-id="${product.productId }">
   					<div class="order">
   						<div class="fl">型号：${product.productCode }</div>
   						<div class="fr">数量：${orderItem.orderItem.orderItemNumber }</div>
   					</div>
   					<div class="stockNum">
   						<div>
	   						<label>现货：</label>
	   						<div>
	   							<a class="reduce">-</a>
	   							<input type="text" data-max="${orderItem.orderItem.orderItemNumber}" 
	   								value="${empty orderItem.orderItem.haveGoodsNum?orderItem.orderItem.orderItemNumber:orderItem.orderItem.haveGoodsNum }" name="haveGoodsNum"/>
	   							<a class="plus">+</a>
	   						</div>
	   						<span>个</span>
	   					</div>
	   					<div class="checkBox" data-id="${orderItem.orderItem.orderItemId }">
	   						<span class="iconfont">&#xe611;</span>
	   					</div>
   					</div>
   					<div class="stockNum">
   						<div>
	   						<label>货期：</label>
	   						<div>
	   							<a class="reduce">-</a>
	   							<input type="text" value="${empty orderItem.orderItem.consignmentTime?1:orderItem.orderItem.consignmentTime }" name="consignmentTime"/>
	   							<a class="plus">+</a>
	   						</div>
	   						<span>天</span>
	   					</div>
   					</div>
   				</div>
   				</c:forEach>
   			</div>
   		</div>
    	</c:forEach>
   		<div class="submit"><a>提　交</a></div>
    </div>
    <form action="<%=request.getContextPath()%>/factory/inputOrderStation">
    	<input type="hidden" name="idList"/>
	   	<input type="hidden" value="${orderItem.orderItem.orderItemNumber }" name="haveGoodsNums"/>
	   	<input type="hidden" value="1" name="consignmentTimes"/>
	   	<input type="hidden" value="${orderStockStatus}" name="orderStockStatus"/>
    </form>
	<div class="noOrder">
		<span><i class="iconfont">&#xe664;</i></span>
		<p>您还没有相关订单</p>
	</div><!-- 
    <div class="loading" style="visibility: visible;"><i class="iconfont">&#xe62c;</i><span id="jiazai">加载中...</span></div> -->
    <!-- 分页]]-->
</div>
<div class="tip"></div>
<!--[[底部-->
<jsp:include page="/jsp/factory/footer.jsp"></jsp:include>
<!--底部]]-->
<script>
	$(".checkBox").tap(function(){
		if($(this).hasClass("active")){
			$(this).removeClass("active");
		}else{
			$(this).addClass("active");
		}
	});
	$("#statusUl li").tap(function(){
		$("#statusUl li").removeClass("active");
		$(this).addClass("active");
	});
	function showTip(str){
		$(".tip").html(str);
		$(".tip").css("opacity",1);
		setTimeout(function(){
			$(".tip").html("");
			$(".tip").css("opacity",0);
		},1000);
	}
	
	$(".submit").tap(function(){
		var dataId="";
		var haveGoodsNums="";
		var consignmentTimes="";
		$(".checkBox").each(function(){
			if($(this).hasClass("active")){
				dataId+=$(this).attr("data-id")+",";
				haveGoodsNums+=$(this).parents(".stock").find("input[name='haveGoodsNum']").val()+",";
				consignmentTimes+=$(this).parents(".stock").find("input[name='consignmentTime']").val()+",";
			}
		});
		if(dataId==""){
			showTip("请至少选择一项提交");
		}else{
			dataId=dataId.substring(0, dataId.length-1);
			haveGoodsNums=haveGoodsNums.substring(0, haveGoodsNums.length-1);
			consignmentTimes=consignmentTimes.substring(0, consignmentTimes.length-1);
			$("input[name='idList']").val(dataId);
			$("input[name='haveGoodsNums']").val(haveGoodsNums);
			$("input[name='consignmentTimes']").val(consignmentTimes);
			$("form").submit();
		}
	});
	
	$(".plus").tap(function(){
		var $input=$(this).prev();
		if($input.attr("data-max")!=undefined){
			if(parseInt($input.val())>=parseInt($input.attr("data-max"))){
			}else{
				$input.val(parseInt($input.val())+1);
			}
		}else{
			$input.val(parseInt($input.val())+1);
		}
	});
	
	$(".reduce").tap(function(){
		var $input=$(this).next();
		if($input.val()<=0){
		}else{
			$input.val(parseInt($input.val())-1);
		}
	});
	
	$("input[type='text']").change(function(){
		if(isNaN($(this).val())||parseInt($(this).val())<0){
			$(this).val("0")
		}else{
			if($(this).attr("data-max")!=undefined){
				if(parseInt($(this).val())>=parseInt($(this).attr("data-max"))){
					$(this).val($(this).attr("data-max"));
				}
			}
		}
	});
</script>
</body>
</html>