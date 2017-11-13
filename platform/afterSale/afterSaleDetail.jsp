<%@ page language="java" import="java.util.*,com.alphaking.constant.*,com.alphaking.model.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>管理后台</title>
    <link rel="icon" type="image/x-icon" href="../image/favicon.ico" />

    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/common/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/backStage/css/index.css" />
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/backStage/css/order.css" />
	
</head>
<body>
		<jsp:include page="/jsp/platform/header.jsp"></jsp:include>
		<jsp:include page="/jsp/platform/navigation.jsp"></jsp:include>
		<div class="order">
			<h3 style="text-align:center">订单信息</h3>
            <div class="product clearfix">
                <div class="pull-left ">
                    <div class="">
                        <table class="table table-bordered table-striped table-hover">
                        	<tr>
                        		<th>订单号</th>
                        		<th>下单时间</th>
                        		<th>发货时间</th>
                        		<th>厂家</th>
                        		<th>买家</th>
                        		<th>客服</th>
                        		<th>产品</th>
                        		<th>图片</th>
                        		<th>收货人</th>
                        		<th>联系电话</th>
                        		<th>收货地址</th>
                        	</tr>
	                        <tr>
	                        	<td>
	                        		${orderForm.orderNumber }
	                        	</td>
	                        	<td>
	                        		${orderForm.payTime}
	                        	</td>
	                        	<td>
	                        		${orderForm.sendTime}
	                        	</td>
	                        	<td>
	                        		${seller.shortCompanyName}
	                        	</td>
	                        	<td>
	                        		${buyer.legalPersonName}
	                        	</td>
	                        	<td>
	                        		${service.legalPersonName}
	                        	</td>
	                        	<td>${product.productCode}</td>
	                       		<td><img src="${product.cover1}" style="width:100px;height:100px" data-click="show"></td>
	                       		<td>${orderForm.receivePerson}</td>
	                        	<td>${orderForm.receivePhone}</td>
	                        	<td>${orderForm.receiveProvince}${orderForm.receiveCity}${orderForm.receiveArea}${orderForm.receiveAddress}</td>
	                        </tr>
                        </table>
                    </div>
                </div>
            </div>
            <h3 style="text-align:center">售后信息</h3>
            <div class="product clearfix">
                <div class="pull-left ">
                    <div class="">
                        <table class="table table-bordered table-striped table-hover">
                        	<tr>
                        		<th>问题</th>
                        		<th>图片</th>
                        		<th>状态</th>
                        		<th>申请时间</th>
                        		<th>处理时间</th>
                        		<th>备注</th>
                        	</tr>
	                        <tr>
	                        	<td>
	                        		${afterSale.afterSaleDescription }
	                        	</td>
	                        	<td>
	                        		<img src="${afterSale.afterSalePic1 }" style="width:100px;height:100px" data-click="show"/>
	                        		<c:if test="${!empty afterSale.afterSalePic2 }"><img src="${afterSale.afterSalePic2 }" style="width:100px;height:100px" data-click="show"/></c:if>
	                        		<c:if test="${!empty afterSale.afterSalePic3 }"><img src="${afterSale.afterSalePic3 }" style="width:100px;height:100px" data-click="show"/></c:if>
	                        	</td>
	                        	<td><c:choose>
	                        			<c:when test="${afterSale.afterSaleStatus==0}">待处理</c:when>
	                        			<c:when test="${afterSale.afterSaleStatus==1}">已处理</c:when>
	                        			<c:when test="${afterSale.afterSaleStatus==2}">待发货</c:when>
	                        		</c:choose></td>
	                        	<td>
	                        		${afterSale.applyTime}
	                        	</td>
	                        	<td>
	                        		${afterSale.handleTime}
	                        	</td>
	                        	<td>
	                        		${afterSale.afterSaleRemark }
	                        	</td>
	                        	
	                        </tr>
                        </table>
                    </div>
                </div>
            </div>
            <c:if test="${afterSale.afterSaleStatus==1||afterSale.afterSaleStatus==2||afterSale.isRepair==1}">
            <h3 style="text-align:center">处理方式</h3>
            <div class="product clearfix">
                <div class="pull-left ">
                    <div class="">
                        <table class="table table-bordered table-striped table-hover">
                        	<tr>
                        		<c:if test="${afterSale.isRepair==1}">
                        		<th>配件</th>
                        		<th>数量</th>
                        		</c:if>
                        		<c:if test="${afterSale.afterSaleStatus==1 }">
                        		<th>描述</th>
                        		<th>图片</th>
                        		<th>金额</th>
                        		</c:if>
                        	</tr>
	                        <tr>
                        		<c:if test="${afterSale.isRepair==1}">
                        		<td>${afterSale.afterSaleRepairName }</td>
                        		<td>${afterSale.afterSaleNumber }</td>
                        		</c:if>
                        		<c:if test="${afterSale.afterSaleStatus==1 }">
	                        	<td>
	                        		${afterSale.afterSaleHandleDescription}
	                        	</td>
	                        	<td>
	                        		<img src="${afterSale.afterSaleHandlePic1 }" style="width:100px;height:100px" data-click="show"/>
	                        	</td>
	                        	<td>
	                        		${afterSale.afterSaleMoney}
	                        	</td>
	                        	</c:if>
	                        </tr>
                        </table>
                    </div>
                </div>
            </div>
            </c:if>
            
            <div class="form-group">
                <label class="control-label  col-sm-2 col-lg-2"></label>
                <div class="col-sm-9 col-lg-4 input-group">
                    <c:if test="${empty afterSale.isRepair && afterSale.afterSaleStatus==0 }"><input type="button" class="btn btn-primary" onclick="setRepair()" value="补配件"/></c:if>
           	      	<c:if test="${afterSale.afterSaleStatus!=1 }"><input type="button" class="btn btn-primary" onclick="pass()" value="处理"/></c:if>
                </div>
            </div>
		</div>

    </div><!-- 页面主体的右边]] -->

    </div><!-- 页面主体]] -->

    <footer>

    </footer>
    <script>
    	function pass(){
    		window.location.href="<%=request.getContextPath()%>/platform/toHandleAfterSale?afterSaleId=${afterSale.afterSaleId}";
    	}
    	
    	function setRepair(){
        	window.location.href="<%=request.getContextPath()%>/platform/toSetAfterSaleRepair?afterSaleId=${afterSale.afterSaleId}";
    	}
    </script>
</body>


</html>
