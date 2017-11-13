<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib prefix="thumbnail" uri="/WEB-INF/tld/thumbnailTag.tld"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>繁灯网供应商管理系统</title>
    <link rel="icon" type="image/x-icon" href="${path}/resources/backStage/image/favicon.ico" />

    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/common/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/backStage/css/index.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/backStage/css/order.css" />
	
    <script src="<%=request.getContextPath() %>/resources/common/require.js" data-main="<%=request.getContextPath() %>/resources/backStage/script/main.js" defer async="true"></script>
</head>
<body>
	<c:set var="OBLIGATION" value="<%=OrderStatus.OBLIGATION%>" />
	<c:set var="TO_BE_SHIPPED" value="<%=OrderStatus.TO_BE_SHIPPED%>" />
	<c:set var="TO_BE_SIGNED" value="<%=OrderStatus.TO_BE_SIGNED%>" />
	<c:set var="SIGNED" value="<%=OrderStatus.SIGNED%>" />
	<c:set var="FINISHED" value="<%=OrderStatus.FINISHED%>" />
	<c:set var="CLOSED" value="<%=OrderStatus.CLOSED%>" />
	<c:set var="PREPARE_SEND" value="<%=OrderStatus.PREPARE_SEND%>" />
	<jsp:include page="/jsp/factory/stock/navigation.jsp"></jsp:include>
		<form action="<%=request.getContextPath() %>/stock/orderList">
			<input type="hidden" name="orderStatus" value="${orderStatus}"/>
			<input type="date" name="from" value="${from }"/>
			<input type="date" name="to" value="${to }"/>
			<input type="hidden" name="offset" value="0"/>
    		<button class="btn btn-primary">提　交</button>
    		<button class="btn btn-primary" type="button" onclick="generateExcel()">生成excel</button>
		</form>
	    <div class="allStatus" style="float:left">
	    	<a href="<%=request.getContextPath()%>/stock/orderList?orderStatus=-1" class="btn btn-default <c:if test="${orderStatus==-1 }">btn-primary</c:if>">全部</a>
		    <a href="<%=request.getContextPath()%>/stock/orderList?orderStatus=1" class="btn btn-default <c:if test="${orderStatus==1 }">btn-primary</c:if>">待发货</a>
		    <a href="<%=request.getContextPath()%>/stock/orderList?orderStatus=2" class="btn btn-default <c:if test="${orderStatus==2||orderStatus==4 }">btn-primary</c:if>">已发货</a> 	
	    </div>
	    <c:if test="${orderStatus==2||orderStatus==4}">
		    <div class="allStatus" style="float:right">
			    <a href="<%=request.getContextPath()%>/stock/orderList?orderStatus=2" class="btn btn-default <c:if test="${orderStatus==2 }">btn-primary</c:if>">未结算</a>
			    <a href="<%=request.getContextPath()%>/stock/orderList?orderStatus=4" class="btn btn-default <c:if test="${orderStatus==4 }">btn-primary</c:if>">已结算</a> 	
		    </div>
	    </c:if>
   	    <div class="table-responsive" style="width:100%">
           <table class="table table-bordered table-striped table-hover">
               <thead>
               <tr>
                   <th>订单号</th>
                   <th>下单日期</th>
                   <th>发货日期</th>
                   <th>结算状态</th>
                   <th>产品型号</th>
                   <th>图片</th>
                   <th>出厂价</th>
                   <th>数量</th>
               </tr>
               </thead>
               <tbody>
               <c:forEach items="${orderList.list}" var="ofm" varStatus="i">
               	<tr <c:if test="${!empty orderForm.orderItemList[0].orderItem.haveGoodsNum && orderForm.orderItemList[0].orderItem.haveGoodsNum!=orderForm.orderItemList[0].orderItem.orderItemNumber}">style="color:red"</c:if>>
                	<td rowspan="${ofm.orderItemList.size() }"><a href="<%=request.getContextPath() %>/platform/orderDetail?orderNum=${ofm.orderForm.orderNumber}" class="blueText">${ofm.orderForm.orderNumber}</a></td>
                    <td rowspan="${ofm.orderItemList.size() }"><fmt:formatDate value="${ofm.orderForm.payTime}"  pattern="yyyy-MM-dd HH:mm:ss"/></td>
            		<td rowspan="${ofm.orderItemList.size() }"><fmt:formatDate value="${ofm.orderForm.sendTime}"  pattern="yyyy-MM-dd HH:mm:ss"/></td>
            		<td rowspan="${ofm.orderItemList.size() }"><c:choose><c:when test="${ofm.orderForm.orderStatus==4}">已结算</c:when>
            													<c:otherwise>待结算</c:otherwise></c:choose></td>
                    <td>${ofm.orderItemList[0].orderItem.productName}</td>
    				<td><img src="${ofm.orderItemList[0].product.cover1}" style="width:80px;height:80px"/></td>
    				<td>${ofm.orderItemList[0].orderItem.orderItemOriginPrice}</td>
                    <td><c:choose><c:when test="${empty ofm.orderForm.toPlatform}">
	                    	<c:choose><c:when test="${orderStatus==TO_BE_SHIPPED}">
			    			${orderStatus==TO_BE_SHIPPED?ofm.orderItemList[0].orderItem.orderItemNumber-ofm.orderItemList[0].orderItem.sendNumber:ofm.orderItemList[0].orderItem.sendNumber}
			    			</c:when>
			    			<c:when test="${orderStatus==TO_BE_SIGNED }">${ofm.orderItemList[0].orderItem.sendNumber }</c:when>
			    			<c:when test="${orderStatus==-1 }">
			    				<c:choose><c:when test="${ofm.orderForm.orderStatus==TO_BE_SHIPPED&&ofm.orderItemList[0].orderItem.sendFlag!=2 }">${ofm.orderItemList[0].orderItem.orderItemNumber}(${ofm.orderItemList[0].orderItem.orderItemNumber-ofm.orderItemList[0].orderItem.sendNumber}件没发货)</c:when>
			    						<c:otherwise>${ofm.orderItemList[0].orderItem.orderItemNumber }</c:otherwise></c:choose>
			    			</c:when>
			    			<c:otherwise>${ofm.orderItemList[0].orderItem.orderItemNumber}</c:otherwise>
		    			</c:choose>
		    			</c:when>
		    			<c:otherwise>
		    				<c:choose><c:when test="${orderStatus==TO_BE_SHIPPED}">
			    			${orderStatus==TO_BE_SHIPPED?ofm.orderItemList[0].orderItem.orderItemNumber-ofm.orderItemList[0].orderItem.factorySendNumber:ofm.orderItemList[0].orderItem.factorySendNumber}
			    			</c:when> 	
			    			<c:when test="${orderStatus==TO_BE_SIGNED }">${ofm.orderItemList[0].orderItem.factorySendNumber}</c:when>
			    			<c:when test="${orderStatus==-1 }">
			    				<c:choose><c:when test="${ofm.orderForm.orderStatus==TO_BE_SHIPPED&&ofm.orderItemList[0].orderItem.factorySendFlag!=2 }">${ofm.orderItemList[0].orderItem.orderItemNumber}(${ofm.orderItemList[0].orderItem.orderItemNumber-ofm.orderItemList[0].orderItem.factorySendNumber}件没发货)</c:when>
			    						<c:otherwise>${ofm.orderItemList[0].orderItem.orderItemNumber }</c:otherwise></c:choose>
			    			</c:when>
			    			<c:otherwise>${ofm.orderItemList[0].orderItem.orderItemNumber}</c:otherwise>
			    			</c:choose>
		    			</c:otherwise>
		    			</c:choose>
		    		</td>
                </tr> 
    			<c:forEach items="${ofm.orderItemList }" var="oim" begin="1">
                	<tr>
	                    <td>${oim.product.productName}</td>
			    		<td><img src="${oim.product.cover1}" style="width:80px;height:80px"/></td>
			    		<td>${oim.orderItem.orderItemOriginPrice}</td>
			    		<td><c:choose><c:when test="${empty ofm.orderForm.toPlatform}">
				    			<c:choose><c:when test="${orderStatus==TO_BE_SHIPPED ||orderStatus==7}">
				    				${orderStatus==TO_BE_SHIPPED?oim.orderItem.orderItemNumber-oim.orderItem.sendNumber:oim.orderItem.sendNumber}
				    			</c:when>
				    			<c:when test="${orderStatus==TO_BE_SIGNED }">${oim.orderItem.sendNumber}</c:when>
				    			<c:when test="${orderStatus==-1 }">
			    				<c:choose><c:when test="${ofm.orderForm.orderStatus==TO_BE_SHIPPED&&oim.orderItem.sendFlag!=2 }">${oim.orderItem.orderItemNumber}(${oim.orderItem.orderItemNumber-oim.orderItem.sendNumber}件没发货)</c:when>
			    						<c:otherwise>${oim.orderItem.orderItemNumber }</c:otherwise></c:choose>
			    				</c:when>
				    			<c:otherwise>${oim.orderItem.orderItemNumber }</c:otherwise>
				    			</c:choose>
				    			</c:when>
				    			<c:otherwise>
				    				<c:choose><c:when test="${orderStatus==TO_BE_SHIPPED}">
						    			${orderStatus==TO_BE_SHIPPED?oim.orderItem.orderItemNumber-oim.orderItem.factorySendNumber:oim.orderItem.factorySendNumber}
						    			</c:when>
						    			<c:when test="${orderStatus==TO_BE_SIGNED }">${oim.orderItem.factorySendNumber }</c:when>
						    			<c:when test="${orderStatus==-1 }">
						    				<c:choose><c:when test="${ofm.orderForm.orderStatus==TO_BE_SHIPPED&&oim.orderItem.factorySendFlag!=2 }">${oim.orderItem.orderItemNumber}(${oim.orderItem.orderItemNumber-oim.orderItem.factorySendNumber}件没发货)</c:when>
						    						<c:otherwise>${oim.orderItem.orderItemNumber }</c:otherwise></c:choose>
						    			</c:when>
						    			<c:otherwise>${oim.orderItem.orderItemNumber}</c:otherwise>
						    			</c:choose>
				    			</c:otherwise>
			    			</c:choose>
			    		</td>
               		 </tr> 
                </c:forEach>
               </c:forEach> 
               </tbody>
           </table>
	   </div><!-- 商品列表]] -->
	   <!-- [[分页-->
	    <div class="paging">
	        <span class="prev btn btn-primary" onclick="toPage(${orderList.before})">上一页</span>
	        <span>当前第页<fmt:formatNumber value="${((orderList.after==orderList.count&&orderList.after%10!=0)?1:0)+((orderList.after-orderList.after%10))/10 }" pattern="#0"/>/共<fmt:formatNumber value="${((orderList.count-1-(orderList.count-1)%10))/10+1}" pattern="#0" />页</span>
	        <span class="next btn btn-primary" onclick="toPage(${orderList.after})">下一页</span>
	    </div>
	    <!-- 分页]]-->
	   
<!--[[底部-->
<script src="<%=request.getContextPath() %>/resources/common/jquery.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
<!--底部]]-->
<script>
	function toPage(offset){
		$("input[name='offset']").val(offset);
		$("form").submit();
	}
	
	function generateExcel(){
		var url="<%=request.getContextPath()%>/stock/orderListExcel";
		var params={orderStatus:${orderStatus},from:$("input[name='from']").val(),to:$("input[name='to']").val()};
		doAjax("GET",url,params,successExcel,fail,true,false);
	}
	
	function successExcel(data){
		window.location.href=data.data;
	}
	
	function fail(data){
		alert("fail");
	}
</script>
</body>
</html>
