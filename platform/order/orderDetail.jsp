<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>管理后台</title>
    <link rel="icon" type="image/x-icon" href="<%=request.getContextPath() %>/resources/image/favicon.ico" />

    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/common/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/backStage/css/index.css" />
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/backStage/css/order.css" />
	
	
</head>
<body>
	<c:set var="OBLIGATION" value="<%=OrderStatus.OBLIGATION%>" />
	<c:set var="TO_BE_SHIPPED" value="<%=OrderStatus.TO_BE_SHIPPED%>" />
	<c:set var="TO_BE_SIGNED" value="<%=OrderStatus.TO_BE_SIGNED%>" />
	<c:set var="SIGNED" value="<%=OrderStatus.SIGNED%>" />
	<c:set var="FINISHED" value="<%=OrderStatus.FINISHED%>" />
	<c:set var="CLOSED" value="<%=OrderStatus.CLOSED%>" />
	<c:set var="NONE_REFUND" value="<%=RefundStatus.NONE_REFUND%>" />
	<c:set var="REFUND_APPLYING" value="<%=RefundStatus.REFUND_APPLYING%>" />
	<c:set var="REFUND_FAILURE" value="<%=RefundStatus.REFUND_FAILURE%>" />
	<c:set var="REFUND_SUCCESS" value="<%=RefundStatus.REFUND_SUCCESS%>" />
	<c:set var="NONE_RETURN" value="<%=ReturnStatus.NONE_RETURN%>" />
	<c:set var="RETURN_APPLYING" value="<%=ReturnStatus.RETURN_APPLYING%>" />
	<c:set var="RETURN_FAILURE" value="<%=ReturnStatus.RETURN_FAILURE%>" />
	<c:set var="RETURN_AGREE" value="<%=ReturnStatus.RETURN_AGREE%>" />
	<c:set var="WAITTING_SELLER_SIGNED" value="<%=ReturnStatus.WAITTING_SELLER_SIGNED%>" />
	<c:set var="RETURN_SUCCESS" value="<%=ReturnStatus.RETURN_SUCCESS%>" />
	<jsp:include page="/jsp/platform/header.jsp"></jsp:include>
	<jsp:include page="/jsp/platform/navigation.jsp"></jsp:include>
        <!-- [[订单详情-->
       <div class="order">
        <div class="order-statue clearfix">
            <div class="order-statue clearfix">
                <div class="order-number pull-left">订单号：${orderForm.orderNumber }</div>
                <div class="pull-right statue"><c:choose>
					<c:when test="${orderForm.orderStatus==OBLIGATION }">待付款</c:when>
					<c:when test="${orderForm.orderStatus==TO_BE_SHIPPED }">待发货</c:when>
					<c:when test="${orderForm.orderStatus==TO_BE_SIGNED }">待签收</c:when>
					<c:when test="${orderForm.orderStatus==SIGNED }">已签收</c:when>
					<c:when test="${orderForm.orderStatus==FINISHED }">已完成</c:when>
					<c:when test="${orderForm.orderStatus==CLOSED }">已关闭</c:when></c:choose>
				</div>
            </div>
            <div class="receive-message text-left">
                <div class="receive-title">收货人信息</div>
                <div class="name">收货人：${orderForm.receivePerson }</div>
                <div class="phone">电话：${orderForm.receivePhone }</div>
                <div class="address">地址：${orderForm.receiveProvince}${orderForm.receiveCity}${orderForm.receiveArea}${orderForm.receiveAddress}</div>
            	<c:if test="${orderForm.transportType==0}">
	            	<div class="address">物流公司：${orderForm.recommendLogistics }</div>
	    			<div class="address">物流园：<span id="logisticsParkSpan">${orderForm.logisticsPark}</span>
	    				<c:if test="${!empty orderForm.logisticsPark }"><input type="text" value="${orderForm.logisticsPark }" id="logisticsPark" onChange="changeOrderLogisticsPark(this.value)" style="display:none"/><button onclick="showInput()">修改</button></c:if>
	    				<c:if test="${empty orderForm.logisticsPark }"><input type="text" onChange="changeOrderLogisticsPark(this.value)"/><button>保存</button></c:if></div>
    			</c:if>
    			<c:if test="${orderForm.transportType==1}">
	            	<div class="address">提货方式：自提</div>
    			</c:if>
    			<div class="address">备注：${orderForm.orderRemark}</div>
            </div>
            <c:forEach items="${orderItemList }" var="orderItem">
            <div class="product clearfix">
                <div class="pull-left col-md-8">
                    <div class="col-md-4" onclick="window.location.href='<%=request.getContextPath()%>/product/productDetail?productId=${orderItem.product.productId}'">
                        <img src="${orderItem.product.cover1}" alt=""/>
                    </div>
                    <div class="col-md-8 text-left" onclick="window.location.href='<%=request.getContextPath()%>/product/productDetail?productId=${orderItem.product.productId}'">
                        <span class="name">${orderItem.product.productName }</span><br /><br />
                        <span class="specific">规格：${orderItem.product.productCode }</span><br />
                    </div>
                </div>
                <div class="pull-right width-2 text-right">
                    <span class="price">￥<fmt:formatNumber value="${orderItem.orderItem.orderItemPrice+orderItem.orderItem.orderItemFreight+orderItem.orderItem.orderItemCommision+orderItem.orderItem.orderItemServiceFee }" pattern="#0.00"/></span><br /><br />
                    <span class="number">X ${orderItem.orderItem.orderItemNumber}</span>
                    <span class="number">(${orderItem.orderItem.perpareSendNumber })件待发货  (${orderItem.orderItem.sendNumber})已发货</span>
                    <c:choose>
		            	<c:when test="${empty orderItem.orderItem.returnId && orderItem.orderItem.refundStatus==REFUND_APPLYING}">退款申请中</c:when>
		            	<c:when test="${empty orderItem.orderItem.returnId && orderItem.orderItem.refundStatus==REFUND_FAILURE}">退款失败</c:when>
		            	<c:when test="${empty orderItem.orderItem.returnId && orderItem.orderItem.refundStatus==REFUND_SUCCESS}">退款成功</c:when>
		            	<c:when test="${orderItem.orderItem.returnStatus==RETURN_APPLYING}">退货申请中</c:when>
		            	<c:when test="${orderItem.orderItem.returnStatus==RETURN_FAILURE}">退货失败</c:when>
		            	<c:when test="${orderItem.orderItem.returnStatus==RETURN_AGREE}">买家待发货</c:when>
		            	<c:when test="${orderItem.orderItem.returnStatus==WAITTING_SELLER_SIGNED}">卖家待收货</c:when>
			            <c:when test="${rol.orderItemModel.orderItem.returnStatus==RETURN_SUCCESS}">退货成功</c:when>
		            </c:choose>
                </div>
            </div>
            </c:forEach>
            <div class="order-total clearfix text-left">
                <div class="pull-left">
                    <div class="product-total">商品合计：￥${orderForm.orderMoney}（共productCount件）</div>
                    <%-- <div class="freight">运费合计：￥${orderForm.orderFreight}</div> --%>
                </div>
                <div class="pull-right">
                   <!--  <button class="btn btn-warning" >同意退款</button> -->
                </div>
            </div>
            <h3 style="text-align:center">收货记录</h3>
            <div class="product clearfix">
                <div class="pull-left ">
                    <div class="">
                        <table class="table table-bordered table-striped table-hover">
                        	<tr>
                        		<th>收货时间</th>
                        		<th>收货人</th>
                        		<th>型号</th>
                        		<th>图片</th>
                        		<th>数量</th>
                        	</tr>
                        	<c:forEach items="${receiveList}" var="rl" varStatus="i">
	                        <tr>
	                        	<td>
	                        		${rl.receiveTime}
	                        	</td>
	                        	<td>
	                        		${receiveUserList[i.index].legalPersonName}
	                        	</td>
	                        	<td>
	                        		${receiveProductList[i.index].productCode}
	                        	</td>
	                       		<td><img src="${receiveProductList[i.index].cover1 }" style="width:100px;height:100px"></td>
	                       		<td>${rl.receiveNumber }</td> 
	                        </tr>
            				</c:forEach>
                        </table>
                    </div>
                </div>
            </div>
            <h3 style="text-align:center">发货单</h3>
            <div class="product clearfix">
                <div class="pull-left ">
                    <div class="">
                        <table class="table table-bordered table-striped table-hover">
                        	<tr>
                        		<th>发货单</th>
                        		<th>发货时间</th>
                        		<th>单号</th>
                        		<th>发货人</th>
                        		<th>物流公司</th>
                        		<th>物流电话</th>
                        		<th>型号</th>
                        		<th>图片</th>
                        		<th>数量</th>
                        	</tr>
                        	<c:forEach items="${sendList}" var="send" varStatus="i">
	                        <tr>
	                        	<td rowspan="${oimList[i.index].size()}">
	                        		<img src="${send.sendLogisticsPic}" alt="" style="width:100px;" data-click="show">
	                        	</td>
	                        	<td rowspan="${oimList[i.index].size()}">
	                        		${send.sendTime}
	                        	</td>
	                        	<td rowspan="${oimList[i.index].size()}">
	                        		${send.transportNumber }
	                        	</td>
	                        	<td rowspan="${oimList[i.index].size()}">
	                        		${userList[i.index].legalPersonName}
	                        	</td>
	                        	<td rowspan="${oimList[i.index].size()}">
	                        		${send.sendLogisticsCompany }
	                        	</td>
	                        	<td rowspan="${oimList[i.index].size()}">
	                        		${send.sendPhoneNumber}
	                        	</td>
	                        	<td>${oimList[i.index][0].product.productCode }</td>
	                       		<td><img src="${oimList[i.index][0].product.cover1 }" style="width:100px;height:100px"></td>
	                       		<td>${oimList[i.index][0].orderItem.orderItemNumber }</td> 
	                        </tr>
	                        <c:forEach items="${oimList[i.index]}" var="oi" begin="1">
	                        		<tr><td>${oi.product.productCode }</td>
	                        		<td><img src="${oi.product.cover1 }" style="width:100px;height:100px"></td>
	                        		<td>${oi.orderItem.orderItemNumber }</td>
	                        </c:forEach>
	                        </c:forEach>
                        </table>
                    </div>
                </div>
            </div>
            <div class="order-time text-left">
                <div class="placeOrder">下单时间：<fmt:formatDate value="${orderForm.orderTime}" pattern="yyyy-MM-dd HH:mm:ss" /></div>
                <div class="payOrder">付款时间：<c:if test="${!empty orderForm.payTime }"><fmt:formatDate value="${orderForm.payTime}" pattern="yyyy-MM-dd HH:mm:ss" /></c:if>
        						<c:if test="${empty orderForm.payTime }">暂未付款</c:if></div>
                <div class="sendOrder">发货时间：<c:if test="${!empty orderForm.sendTime }"><fmt:formatDate value="${orderForm.sendTime}" pattern="yyyy-MM-dd HH:mm:ss" /></c:if>
        						<c:if test="${empty orderForm.sendTime }">暂未发货</c:if></div>
				<div class="sendOrder">收货时间：<c:if test="${!empty orderForm.receiveTime }"><fmt:formatDate value="${orderForm.receiveTime}" pattern="yyyy-MM-dd HH:mm:ss" /></c:if>
				<c:if test="${empty orderForm.receiveTime }">暂未发货</c:if></div>
				<div class="sendOrder">完成时间：<c:if test="${!empty orderForm.completeTime }"><fmt:formatDate value="${orderForm.completeTime}" pattern="yyyy-MM-dd HH:mm:ss" /></c:if>
				<c:if test="${empty orderForm.completeTime }">暂未发货</c:if></div>
            </div>
            <c:if test="${orderForm.transportType!=1&&!empty orderForm.logisticsCompanyCode &&orderForm.toPlatform!=1}">
			    <div class="tableInfo logisticsInfo">
			    	<div class="grayTitle">物流信息</div>
			    	<table>
			    		<tr>
			    			<td>物流公司</td>
			    			<td>${logisticsCompany.logisticsCompanyName}</td>
			    		</tr>
			    		<tr>
			    			<td>物流编号</td>
			    			<td>${logisticsCompany.logisticsCompanyCode }</td>
			    		</tr>
			    		<tr>
			    			<td>电话</td>
			    			<td>${orderForm.transportPhoneNumber }</td>
			    		</tr>
			    		<tr>
			    			<td>电话</td>
			    			<td>${orderForm.transportPhoneNumber }</td>
			    		</tr>
			    		<tr>
			    			<td>物流公司</td>
			    			<td class="red">${orderForm.recommendLogistics }</td>
			    		</tr>
			    	</table>
			    </div>
			    </c:if>
            <div class="logisticsTrace clearfix">
            	<c:if test="${orderForm.orderStatus==OBLIGATION}"> 
                <a href="javascript:setPayComplete()">
                    <button class="btn btn-primary">设为已付款</button>
                </a>
                </c:if>
            	<c:if test="${orderForm.orderStatus==TO_BE_SIGNED||orderForm.orderStatus==SIGNED||orderForm.orderStatus==FINISHED}"> 
                <a href="javascript:consultLogistics()">
                    <button class="btn btn-primary">物流追踪</button>
                </a>
                </c:if>
              <%--   <c:if test="${orderForm.toPlatform==1 }">平台发货</c:if>
                <c:if test="${orderForm.orderStatus==TO_BE_SHIPPED&& orderForm.refundReturnPendingNum==0}"> 
                	<div class="sendToDiv">
					<div class="sendToDivTop">
						<span>输入物流信息</span>
					</div>
					<div class="logisticsInfo">
						<select id="logisticsSelect">
							<c:forEach items="${logisticsList }" var="logistics">
								<option value="${logistics.userLogisticsId}" data-phone="${logistics.logisticsPhoneNumber }"
									data-park="${logistics.logisticsPark }">${logistics.logisticsCompanyName}</option>
							</c:forEach>
							<option value="otherLogistics">其他</option>
						</select>
						<input type="text" placeHolder="请输入物流公司的名字" id="otherInput" <c:if test="${logisticsList.size()!=0 }">style="display:none"</c:if>/>
						<input type="text" placeHolder="请输入物流公司电话号码" id="transportPhone" <c:if test="${logisticsList.size()!=0 }">value="${logisticsList[0].logisticsPhoneNumber }"</c:if>/>
						<input type="text" placeHolder="请输入物流园" id="logisticsPark" <c:if test="${logisticsList.size()!=0 }">value="${logisticsList[0].logisticsPark }"</c:if>/>
						<input type="text" placeHolder="请输入物流编号" id="transportNumber"/>
					</div>
					</div>
				    <button class="sendTo" id="sendTo">发货</button>
			    </c:if> --%>
			    <c:if test="${orderForm.orderStatus==TO_BE_SIGNED }"> 
		    		<button class="toPay bgcolorBtn receiveBtn">确认收货</button>
		    	</c:if>
            </div>
        </div>
    </div>
        <!-- 订单详情]]-->

    </div><!-- rightConten右边区域]] -->

    </div><!-- mainBody页面主体]] -->

    <footer>

    </footer>
</body>
<script>
	$(function(){
		calculate();
	})
	
	function setPayComplete(){
		var url="<%=request.getContextPath()%>/buyer/setPayComplete?orderNumber=${orderForm.orderNumber}";
		var params={                                                  };
		doAjax("GET",url,params,function(data){location.reload();},fail,false,false);
	}
	
	function calculate(){
		var numbers=0;
		$(".product").each(function(){
			numbers = numbers+parseInt($(this).find(".number").html().match(/\d+(\.\d+)?/g));
		});
		$(".product-total").html($(".product-total").html().replace("productCount",numbers));
	}
	
	//查询物流
	function consultLogistics(){
		window.location.href="<%=request.getContextPath()%>/buyer/consultLogistics?logisticsCompanyCode=${orderForm.logisticsCompanyCode}"+
				"&logisticsCode=${orderForm.transportNumber}";
	}
	
	$(document).on("click",".receiveBtn",function(){
		var url="<%=request.getContextPath()%>/buyer/toSignAjax";
		var params={orderNum:$(this).parents(".shopOrder").attr("data-id")};
		doAjax("GET",url,params,receiveSuccess,fail,true,false);
	});
	
	function receiveSuccess(data){
		location.reload();
	}
	
	var logisticsCompanyCode=null;
	$("#sendTo").click(function(){
		if($("#logisticsSelect").val()=="otherLogistics"){
			if($("#otherInput").val().trim()==""){
				showTip("请输入物流公司名称！");
			}
		}
		if($("#transportPhone").val().trim()==""){
			showTip("请输入物流公司电话！");
		}else if($("#transportNumber").val().trim()==""){
			showTip("请输入物流编号！");
		}else{
			var url="<%=request.getContextPath()%>/platform/delivery?transportPhoneNumber="+$("#transportPhone").val();
			var params;
			if(logisticsCompanyCode==null)
				params={logisticsCompanyCode:$("#otherInput").val(),logisticsCode:$("#transportNumber").val(),
					orderNumber:"${orderForm.orderNumber}",logisticsSelect:$("#logisticsSelect").val(),
					logisticsPark:$("#logisticsPark").val()};
			else
				params={logisticsCompanyCode:logisticsCompanyCode,logisticsCode:$("#transportNumber").val(),
					orderNumber:"${orderForm.orderNumber}",logisticsSelect:$("#logisticsSelect").val(),
					logisticsPark:$("#logisticsPark").val()};
			doAjax("GET",url,params,sendSuccess,fail,true,false);
		}
	});
	
	function fail(data){
		alert("fail");
	}
	
	function sendSuccess(data){
		location.reload();
	}
	
	function changeOrderLogisticsPark(logisticsPark){
		var url="<%=request.getContextPath()%>/platform/setOrderLogisticsPark";
		var params={logisticsPark:logisticsPark,orderNumber:"${orderForm.orderNumber}"};
		doAjax("GET",url,params,changeSuccess,fail,true,false);
	}
	
	function changeSuccess(data){
		location.reload();
	}
	
	$("#logisticsSelect").change(function(){
		if($(this).val()=="otherLogistics"){
			$("#otherInput").css("display","block");
			$("#transportPhone").val("");
		}else{
			$("#otherInput").css("display","none");
			$("#transportPhone").val($('#logisticsSelect').find('option').not(function(){ return !this.selected }).attr("data-phone"));
			$("#logisticsPark").val($('#logisticsSelect').find('option').not(function(){ return !this.selected }).attr("data-park"));
		}
	});
	
	function showInput(){
		$("#logisticsPark").show();
		$("#logisticsParkSpan").hide();
	}
</script>
</html>
