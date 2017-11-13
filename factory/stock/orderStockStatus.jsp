<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib prefix="thumbnail" uri="/WEB-INF/tld/thumbnailTag.tld"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=0.5, minimum-scale=0.1, maximum-scale=2.0, user-scalable=yes" />
    <title>繁灯网供应商管理系统</title>
    <link rel="icon" type="image/x-icon" href="${path}/resources/backStage/image/favicon.ico" />

    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/common/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/backStage/css/index.css?121" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/backStage/css/order.css" />
	<style>
		.waiting {
		    text-align: center;
		    position: fixed;
		    left: 0;
		    top: 40%;
		    width: 100%;
		    z-index: 1003;
		    line-height: 50px;
		    display: none;
		}
		
		.shade {
		    width: 100%;
		    height: 100%;
		    background-color: rgba(0,0,0,.5);
		    position: fixed;
		    left: 0;
		    top: 0;
		    z-index: 100;
		    display: none;
		}
	</style>
    <script src="<%=request.getContextPath() %>/resources/common/require.js" data-main="<%=request.getContextPath() %>/resources/backStage/script/main.js" defer async="true"></script>
</head>
<body>
	<jsp:include page="/jsp/factory/stock/navigation.jsp"></jsp:include>
<div class="orderStock">
	    <div class="allStatus">
		    <a href="<%=request.getContextPath()%>/stock/newOrderStation?orderStockStatus=1" class="btn btn-default <c:if test="${orderStockStatus==1 }">btn-primary</c:if>">待处理</a>
		    <a href="<%=request.getContextPath()%>/stock/newOrderStation?orderStockStatus=2" class="btn btn-default <c:if test="${orderStockStatus==2 }">btn-primary</c:if>">待发货</a>
		    <a href="<%=request.getContextPath()%>/stock/newOrderStation?orderStockStatus=3" class="btn btn-default <c:if test="${orderStockStatus==3 }">btn-primary</c:if>">已发货</a>
	    	 </div>
   	    <div class="table-responsive">
           <table class="table table-bordered table-striped table-hover">
               <thead>
               <tr>
                   <th>订单号</th>
                   <th>下单日期</th>
                   <th>编号</th>
                   <th>型号</th>
                   <th>封面</th>
                   <th>单价</th>
                   <th>数量</th>
                   <th>备注</th>
                   <th>现货数量/个</th>
                   <c:if test="${orderStockStatus==1||orderStockStatus==2 }">
                  	 <th>备货期/天</th>
                   </c:if>
                   <c:if test="${orderStockStatus==2||orderStockStatus==3 }">
                  	 <th>发货数量</th>
                   </c:if>
                   <th>操作</th>
               </tr>
               </thead>
               <tbody>
               <c:forEach items="${ofmList}" var="orderForm" varStatus="i">
               	<tr <c:if test="${!empty orderForm.orderItemList[0].orderItem.haveGoodsNum && orderForm.orderItemList[0].orderItem.haveGoodsNum!=orderForm.orderItemList[0].orderItem.orderItemNumber}">style="color:red"</c:if>>
                	<td class="center" rowspan="${orderForm.orderItemList.size()}">${orderForm.orderForm.orderNumber}</td>
                    <td class="center" rowspan="${orderForm.orderItemList.size()}">
                    	<fmt:formatDate value="${orderForm.orderForm.payTime}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
                   	<td class="center" rowspan="${orderForm.orderItemList.size()}">
                   		${orderForm.buyer.userIdenticalCode }</td>
                    <td class="width">${orderForm.orderItemList[0].orderItem.productName}</td>
                    <td class="center"><img src="<thumbnail:date value="${orderForm.orderItemList[0].product.cover1}"/>"/></td>
                    <td class="">${orderForm.orderItemList[0].orderItem.orderItemOriginPrice}</td>	                        
                    <td class="center">${orderForm.orderItemList[0].orderItem.orderItemNumber}</td>
                    <td class="center">${!empty orderForm.orderItemList[0].orderItem.isRushOrder?'急单':'无'}</td>
                    <td>
                    	<div class="numDiv">
                    		<c:if test="${orderStockStatus==1}">
                    			<a class="reduce">-</a>
								<input type="text" data-max="${orderStockStatus==1?orderForm.orderItemList[0].orderItem.orderItemNumber-orderForm.orderItemList[0].orderItem.haveGoodsNum:orderForm.orderItemList[0].orderItem.haveGoodsNum-(empty orderForm.orderItemList[0].orderItem.factorySendNumber?orderForm.orderItemList[0].orderItem.receiveNumber:orderForm.orderItemList[0].orderItem.factorySendNumber)}" 
									value="${orderStockStatus==1?orderForm.orderItemList[0].orderItem.orderItemNumber-orderForm.orderItemList[0].orderItem.haveGoodsNum:orderForm.orderItemList[0].orderItem.haveGoodsNum-(empty orderForm.orderItemList[0].orderItem.factorySendNumber?orderForm.orderItemList[0].orderItem.receiveNumber:orderForm.orderItemList[0].orderItem.factorySendNumber)}" name="haveGoodsNum"/>	
                    			<a class="plus">+</a>
							</c:if>
							<c:if test="${orderStockStatus==2 }">
								${orderForm.orderItemList[0].orderItem.spotGoodsNum}
							</c:if>
                    		<c:if test="${orderStockStatus==3}">
								${empty orderForm.orderItemList[0].orderItem.factorySendNumber?orderForm.orderItemList[0].orderItem.receiveNumber:orderForm.orderItemList[0].orderItem.factorySendNumber}
                    		</c:if>
                    	</div>
					</td>
					
                   <c:if test="${orderStockStatus==1}">
                    <td>
                    	<div class="numDiv">
	                    	<a class="reduce">-</a>
							<input type="text" value="${empty orderForm.orderItemList[0].orderItem.consignmentTime?0:orderForm.orderItemList[0].orderItem.consignmentTime }" name="consignmentTime"/>
							<a class="plus">+</a>
						</div>
					</td>
					</c:if>
					<c:if test="${orderStockStatus==2}">
                    <td>
                    	<div class="numDiv">
	                    	${empty orderForm.orderItemList[0].orderItem.consignmentTime?0:orderForm.orderItemList[0].orderItem.consignmentTime }
						</div>
					</td>
					</c:if>
					
					<!-- 发货数 -->
					<c:if test="${orderStockStatus==2 }">
						<td>
							<div class="numDiv">
		                    	<a class="reduce">-</a>
								<input type="text" data-max="${orderForm.orderItemList[0].orderItem.orderItemNumber-(empty orderForm.orderItemList[0].orderItem.factorySendNumber?orderForm.orderItemList[0].orderItem.receiveNumber:orderForm.orderItemList[0].orderItem.factorySendNumber)}" 
									value="0" name="haveGoodsNum"/>
								<a class="plus">+</a>
							</div>
						</td>
					</c:if>
					<c:if test="${orderStockStatus==3 }">
						<td>
							${empty orderForm.orderItemList[0].orderItem.factorySendNumber?orderForm.orderItemList[0].orderItem.receiveNumber:orderForm.orderItemList[0].orderItem.factorySendNumber}
						</td>
					</c:if>
					<!-- 发货数 -->
					
					<td><div class="checkBox" data-id="${orderForm.orderItemList[0].orderItem.orderItemId }">
	   						<span></span>
	   					</div></td>
                </tr> 
                <c:forEach items="${orderForm.orderItemList}" var="orderItem" varStatus="i" begin="1">
                	<tr <c:if test="${!empty orderItem.orderItem.haveGoodsNum && orderItem.orderItem.haveGoodsNum!=orderItem.orderItem.orderItemNumber}">style="color:red"</c:if>>
                    <td class="width">${orderItem.product.productCode}</td>
                    <td class="center"><img src="<thumbnail:date value="${orderItem.product.cover1}"/>"></td>
                    <td class="">${orderItem.orderItem.orderItemOriginPrice}</td>
                    <td class="center">${orderItem.orderItem.orderItemNumber}</td>
                    <td class="center">${!empty orderItem.orderItem.isRushOrder?'急单':'无'}</td>
                    <td>
                    	<div class="numDiv">
                   			<c:if test="${orderStockStatus==1||orderStockStatus==2 }">
                   			<a class="reduce">-</a>
   							<input type="text" data-max="${orderStockStatus==1?orderItem.orderItem.orderItemNumber-orderItem.orderItem.haveGoodsNum:orderItem.orderItem.haveGoodsNum-(empty orderItem.orderItem.factorySendNumber?orderItem.orderItem.receiveNumber:orderItem.orderItem.factorySendNumber)}" 
   								value="${orderStockStatus==1?orderItem.orderItem.orderItemNumber-orderItem.orderItem.haveGoodsNum:orderItem.orderItem.haveGoodsNum-(empty orderItem.orderItem.factorySendNumber?orderItem.orderItem.receiveNumber:orderItem.orderItem.factorySendNumber) }" name="haveGoodsNum"/>
   							
   							<a class="plus">+</a>
   							</c:if>
   							<c:if test="${orderStockStatus==3}">
								${empty orderItem.orderItem.factorySendNumber?orderItem.orderItem.receiveNumber:orderItem.orderItem.factorySendNumber}
                    		</c:if>
	   					</div>			
	   				</td>
                   <c:if test="${orderStockStatus==1||orderStockStatus==2 }">
                    <td>
                    	<div class="numDiv">
                    		<a class="reduce">-</a>
	   						<input type="text" value="${empty orderItem.orderItem.consignmentTime?0:orderItem.orderItem.consignmentTime }" name="consignmentTime"/>
	   						<a class="plus">+</a>
	   					</div>
	   				</td>
	   				</c:if>
					<td><div class="checkBox" data-id="${orderItem.orderItem.orderItemId }">
	   						<span></span>
	   					</div></td>
                </tr> 
                </c:forEach>
               </c:forEach> 
               </tbody>
           </table>
	   </div><!-- 商品列表]] -->
	    <form <c:if test="${orderStockStatus==1 }">action="<%=request.getContextPath()%>/stock/inputOrderStation"</c:if>
	    	<c:if test="${orderStockStatus==2 }">action="<%=request.getContextPath()%>/stock/factorySend"</c:if>>
	    	<input type="hidden" name="idList"/>
		   	<input type="hidden" value="${orderItem.orderItem.orderItemNumber }" name="haveGoodsNums"/>
		   	<input type="hidden" value="1" name="consignmentTimes"/>
		   	<input type="hidden" value="${orderStockStatus}" name="orderStockStatus"/>
	    </form>
    	<c:if test="${orderStockStatus!=3 }"><div class="submit"><button class="btn btn-primary">
    		<c:if test="${orderStockStatus==1 }">提　交</c:if>
    		<c:if test="${orderStockStatus==2 }">发货</c:if></button></div></c:if>
    	</div>
<!--[[底部-->
<script src="<%=request.getContextPath() %>/resources/common/jquery.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>

<!-- 等待加载 -->
<div class="waiting"><i class="iconfont">&#xe62c;</i></div>
<div class="shade"></div>
<!-- 等待加载 -->
<!--底部]]-->
<script>
	$(".checkBox").click(function(){
		if($(this).hasClass("active")){
			$(this).removeClass("active");
		}else{
			$(this).addClass("active");
		}
	});
	$("#statusUl li").click(function(){
		$("#statusUl li").removeClass("active");
		$(this).addClass("active");
	});
	
	$(".submit").click(function(){
		var dataId="";
		var haveGoodsNums="";
		var consignmentTimes="";
		$(".checkBox").each(function(){
			if($(this).hasClass("active")){
				dataId+=$(this).attr("data-id")+",";
				haveGoodsNums+=$(this).parents("tr").find("input[name='haveGoodsNum']").val()+",";
				consignmentTimes+=$(this).parents("tr").find("input[name='consignmentTime']").val()+",";
			}
		});
		if(dataId==""){
			alert("请至少选择一项提交");
		}else{
			$(".waiting").show();
			$(".shade").show();
			dataId=dataId.substring(0, dataId.length-1);
			haveGoodsNums=haveGoodsNums.substring(0, haveGoodsNums.length-1);
			consignmentTimes=consignmentTimes.substring(0, consignmentTimes.length-1);
			$("input[name='idList']").val(dataId);
			$("input[name='haveGoodsNums']").val(haveGoodsNums);
			$("input[name='consignmentTimes']").val(consignmentTimes);
			$("form").submit();
		}
	});
	
	$(".plus").click(function(){
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
	
	$(".reduce").click(function(){
		var $input=$(this).next();
		if($input.val()<=1){
		}else{
			$input.val(parseInt($input.val())-1);
		}
	});
	
	$("input[type='text']").change(function(){
		if(isNaN($(this).val())||parseInt($(this).val())<0){
			$(this).val("0");
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
