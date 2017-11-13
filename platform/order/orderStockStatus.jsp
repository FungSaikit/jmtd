<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="date" uri="/WEB-INF/tld/dateTag.tld"%> 
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>管理后台</title>
    <link rel="icon" type="image/x-icon" href="${path}/resources/backStage/image/favicon.ico" />

    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/common/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/backStage/css/index.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/backStage/css/order.css" />
	
</head>
<body>
 <!-- [[头部 -->
        <jsp:include page="/jsp/platform/header.jsp"></jsp:include>
         <!-- [[页面主体 -->
		<jsp:include page="/jsp/platform/navigation.jsp"></jsp:include>
            <!-- [[商品列表 -->
            <div class="table-responsive">
            <form action="<%=request.getContextPath() %>/platform/orderStockStatus?orderStockStatus=2">
		    	<input type="date" name="from" value="${from }"/>
		    	<input type="date" name="to" value="${to}"/>
		    	<input type="text" name="keyword" value="${keyword}" placeHolder="输入订单号或型号搜索"/>
		    	<select name="userId">
		    		<option value="0">--选择厂家--</option>
		    		<c:forEach items="${brandList}" var="brand">
		    			<option value="${brand.userId}" <c:if test="${brand.userId==userId }">selected</c:if>>${brand.shortCompanyName }</option>
		    		</c:forEach>
		    	</select>
		    	<button>提交</button></form>
		    	<button onclick="generateExcel()">excel</button>
                <table class="table table-bordered table-striped table-hover">
                    <thead>
                    <tr>
                        <th>订单号</th>
                        <th>下单日期</th>
                        <th>厂家</th>
                        <th>型号</th>
                        <th>封面</th>
                        <th >单价</th>
                        <th>数量</th>
                        <th >备货情况</th>
                        <th>交货期</th>
                        <th>交货日期</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${ofmList}" var="orderForm" varStatus="i">
                    	<tr>
	                    	<td rowspan="${orderForm.orderItemList.size()}">${orderForm.orderForm.orderNumber}</td>
	                        <td rowspan="${orderForm.orderItemList.size()}">
	                        	<fmt:formatDate value="${orderForm.orderForm.payTime}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
	                        <td rowspan="${orderForm.orderItemList.size()}">${orderForm.seller.shortCompanyName}</td>
	                        <td>${orderForm.orderItemList[0].product.productCode}</td>
	                        <td class=""><img src="${orderForm.orderItemList[0].product.cover1}" style="width:80px;height:80px"/></td>
	                        <td class="">${orderForm.orderItemList[0].orderItem.orderItemPrice}</td>	                        
	                        <td>${orderForm.orderItemList[0].orderItem.orderItemNumber}</td>
	                        <td class="">${orderForm.orderItemList[0].orderItem.haveGoodsNum }</td>
	                        <td class="">${orderForm.orderItemList[0].orderItem.consignmentTime}天</td>
	                       <td class=""><date:date value="${orderForm.orderForm.payTime}" dateNumber="${orderForm.orderItemList[0].orderItem.consignmentTime}"></date:date></td>
	                    </tr> 
                     <c:forEach items="${orderForm.orderItemList}" var="orderItem" varStatus="i" begin="1">
                     	<tr>
	                        <td >${orderItem.product.productCode}</td>
	                        <td><img src="${orderItem.product.cover1}" style="width:80px;height:80px"></td>
	                        <td class="">${orderItem.orderItem.orderItemPrice}</td>
	                        <td >${orderItem.orderItem.orderItemNumber}</td>
	                        <td class="">${orderItem.orderItem.haveGoodsNum }</td>
	                        <td class="">${orderItem.orderItem.consignmentTime}天</td>
	                        <td class=""><date:date value="${orderForm.orderForm.payTime}" dateNumber="${orderItem.orderItem.consignmentTime}"></date:date></td>
	                    </tr> 
                     </c:forEach>
                    </c:forEach> 
                    </tbody>
                </table>
            </div><!-- 商品列表]] -->

            

        </div><!-- rightConten右边区域]] -->

        </div><!-- mainBody页面主体]] -->

        <footer>
        </footer>
		
		<div class="waiting"><i class="iconfont">&#xe62c;</i></div>
		<div class="shade"></div>
    </body>
    
	<script src="<%=request.getContextPath()%>/resources/backStage/script/product.js"></script>
    <script type="text/javascript">
    	function generateExcel(){
    		var url="<%=request.getContextPath()%>/platform/orderExcel";
    		var params={};
    		doAjax("GET",url,params,success,fail,true,false);
    	}
    	
    	function success(data){
    		window.location.href=data.data;
    	}
    	
    	function fail(data){
    		alert(fail);
    	}
    </script>
</html>