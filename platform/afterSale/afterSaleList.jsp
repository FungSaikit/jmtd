<%@ page language="java" import="java.util.*,com.alphaking.constant.*,com.alphaking.model.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>管理后台</title>
    <link rel="icon" type="image/x-icon" href="<%=request.getContextPath() %>/resources/backStage/image/favicon.ico" />

    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/common/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/backStage/css/index.css" />
</head>
<body>
		<c:set var="PENDING_CHECK" value="<%=DiscountApplicationStatus.PENDING_CHECK%>" />
		<c:set var="PASS" value="<%=DiscountApplicationStatus.PASS%>" />
		<c:set var="FAILED" value="<%=DiscountApplicationStatus.FAILED%>" />
		
		<jsp:include page="/jsp/platform/header.jsp"></jsp:include>
		<jsp:include page="/jsp/platform/navigation.jsp"></jsp:include>
		<form action="<%=request.getContextPath() %>/platform/afterSaleList">
			<input type="text" name="orderNumber" value="${orderNumber}" placeholder="输入订单号">
			<input type="text" name="productName" value="${productName}" placeholder="输入产品名">
			<input type="text" name="sellerName" value="${sellerName}" placeholder="输入卖家名">
			<input type="text" name="buyerName" value="${buyerName}" placeholder="输入买家名">
			<input type="text" name="serviceName" value="${serviceName}" placeholder="输入客服">
			<input type="hidden" name="status" value="${status}" placeholder="输入客服">
			<input type="hidden" name="offset" value="${offset}">
		<button onclick="search()">搜索</button>
		</form>
        <div class="nav-tabs">
            <button class="btn <c:if test='${status==0}'>navActive</c:if>" onclick="changeStatus(0)">待处理</button>
            <button class="btn <c:if test='${status==2}'>navActive</c:if>" onclick="changeStatus(2)">待发货</button>
            <button class="btn <c:if test='${status==1}'>navActive</c:if>" onclick="changeStatus(1)">已处理</button>
        </div>

         <div class="table-responsive">
            <table class="table table-bordered table-striped table-hover">
                <thead>
                <tr>
                    <th>订单号</th>
                    <th>卖家</th>
                    <th>买家</th>
                    <th>客服</th>
                    <th>下单时间</th>
                    <th>发货时间</th>
                    <th>申请时间</th>
                    <th>产品</th>
                    <th>图片</th>
                    <th>操作</th>
                    <th>备注</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${bap.list }" var="as" varStatus="i">
	                <tr>
	                    <td>${as.afterSale.afterSaleOrderNumber}</td>
	                    <td>${as.sellerName}(${as.sellerTimes})</td>
	                    <td>${as.buyerName}(${as.buyerTimes})</td>
	                    <td>${as.serviceName}(${as.serviceTimes})</td>
	                    <td>${as.payTime}</td>
	                    <td>${as.sendTime}</td>
	                    <td>${as.afterSale.applyTime}</td>
	                    <td>${as.product.productCode}(${as.productTimes})</td>
	                    <td><img src="${as.product.cover1}" style="width:100px;height:100px" data-click="show"/></td>
	                    <td>
	                    	<a href="<%=request.getContextPath()%>/platform/afterSaleDetail?afterSaleId=${as.afterSale.afterSaleId}">查看详情</a>
	                    	<c:if test="${as.afterSale.isRepair!=1&&as.afterSale.afterSaleStatus==0}">|<a href="<%=request.getContextPath()%>/platform/toSetAfterSaleRepair?afterSaleId=${as.afterSale.afterSaleId}">补配件</a></c:if>
	                    	<c:if test="${as.afterSale.afterSaleStatus!=1}">|<a href="<%=request.getContextPath()%>/platform/toHandleAfterSale?afterSaleId=${as.afterSale.afterSaleId}">处理</a></c:if>
	                    </td>
	                    <td><input type="text" value="${as.afterSale.afterSaleRemark }" onchange="changeRemark(this.value,${as.afterSale.afterSaleId})"/></td>
	                </tr>
               	</c:forEach>
                </tbody>
            </table>
         </div>

        <!-- [[分页-->
        <div class="paging">
            <span class="prev btn btn-primary" onclick="toPage(${bap.before})">上一页</span>
            <span>当前第页<fmt:formatNumber value="${((bap.after==bap.count&&bap.after%10!=0)?1:0)+((bap.after-bap.after%10))/10 }" pattern="#0"/>/共<fmt:formatNumber value="${((bap.count-1-(bap.count-1)%10))/10+1}" pattern="#0" />页</span>
            <span class="next btn btn-primary" onclick="toPage(${bap.after})">下一页</span>
        </div>
        <!-- 分页]]-->

    </div><!-- 页面主体的右边]] -->

    </div><!-- 页面主体]] -->

    <footer>

    </footer>
	<script>
		function toPage(offset){
			$("input[name='offset']").val(offset);
			$("form").submit();
		}
	
		function changeStatus(status){
			$("input[name='status']").val(status);
			$("input[name='offset']").val(0);
			$("form").submit();
		}
		
		function changeRemark(remark,id){
			var url="<%=request.getContextPath()%>/platform/setAfterSaleRemark";
			var params={afterSaleId:id,afterSaleRemark:remark};
			doAjax("GET",url,params,function(data){},function(data){},true,false);
		}
		
		function search(){
			$("input[name='offset']").val(0);
			$("form").submit();
		}
	</script>
</body>
</html>