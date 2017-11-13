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
    <title>厂家库存管理</title>
    <link rel="icon" type="image/x-icon" href="${path}/resources/backStage/image/favicon.ico" />

    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/common/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/backStage/css/index.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/backStage/css/order.css" />
	
    <script src="<%=request.getContextPath() %>/resources/common/require.js" data-main="<%=request.getContextPath() %>/resources/backStage/script/main.js" defer async="true"></script>
</head>
<body>
	<jsp:include page="/jsp/fund/navigation.jsp"></jsp:include>
	<form action="<%=request.getContextPath()%>/fund/fundList">
    	<input type="date" name="from" value="${from}">
   		<input type="date" name="to" value="${to}">
	   	<input type="hidden" value="0" name="offset"/>
	   	<input type="hidden" value="${customerBuy }" name="customerBuy"/>
	   	<button>确定</button>
	   	<button type="button" onclick="generateExcel();">生成excel</button>
    </form>
	    <div class="allStatus">
		    <a href="javascript:fundList(false)" class="btn btn-default <c:if test="${!customerBuy}">btn-primary</c:if>">非消费者订单</a>
		    <a href="javascript:fundList(true)" class="btn btn-default <c:if test="${customerBuy}">btn-primary</c:if>">消费者订单</a>
	    </div>
   	    <div class="table-responsive">
           <table class="table table-bordered table-striped table-hover">
               <thead>
               <tr>
                   <th>订单号</th>
                   <th>下单日期</th>
                   <th>状态</th>
                   <th>买家</th>
                   <th>订单金额</th>
                   <th>厂家</th>
                   <th>厂家货款</th>
                   <th>业务员</th>
                   <th>业务员提成</th>
                   <th>平台提成</th>
                   <th>木架费</th>
                   <c:if test="${customerBuy }">
	                   <th>推广人</th>
	                   <th>推广费用</th>
	                   <th>服务商</th>
	                   <th>服务费</th>
	                   <th>平台物流费</th>
	               </c:if>
                   <th>退款金额</th>
               </tr>
               </thead>
               <tbody>
               <c:forEach items="${fundList.list}" var="fund" varStatus="i">
               	<tr>
                	<td class="center">${fund.orderNumber}</td>
                    <td class="center">
                    	<fmt:formatDate value="${fund.payTime}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
                	<td class="center"><c:choose><c:when test="${fund.orderStatus==4||fund.orderStatus==5}">已结算</c:when>
                	<c:otherwise>待结算</c:otherwise></c:choose></td>
                    <td class="center">${fund.buyerName}</td>
                	<td class="center">${fund.orderMoney}</td>                 
                    <td class="center">${fund.sellerName}</td>
                   	<td class="center">${fund.goodsMoney}</td> 
                    <td class="center">${fund.salesName}</td>
                    <td class="width">${fund.salesCommision}</td>  
                    <td class="center">${fund.platformCommision}</td>
                    <td class="center">${fund.woodenFee }</td>
                    <c:if test="${customerBuy }">
	                    <td class="center">${fund.agencyName}</td>
	                    <td class="center">${fund.agencyCommision}</td>
	                    <td class="center">${empty fund.serviceUserName?'待定':fund.serviceUserName}</td>
	                    <td class="center">${fund.serviceMoney}</td>
	                    <td class="center">${fund.freight}</td>
                    </c:if>
                    <td class="">${fund.returnMoney}</td>	    
                </tr> 
               </c:forEach> 
               </tbody>
           </table>
	   </div><!-- 商品列表]] -->
	   <div class="paging">
           <span class="prev btn btn-primary" onclick="toPage(${fundList.before})">上一页</span>
           <span>当前第页<fmt:formatNumber value="${((fundList.after==fundList.count&&fundList.after%10!=0)?1:0)+((fundList.after-fundList.after%10))/10 }" pattern="#0"/>/共<fmt:formatNumber value="${((fundList.count-1-(fundList.count-1)%10))/10+1}" pattern="#0" />页</span>
           <span class="next btn btn-primary" onclick="toPage(${fundList.after})">下一页</span>
       </div>
	    
<!--[[底部-->
<script src="<%=request.getContextPath() %>/resources/common/jquery.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
<!--底部]]-->
<script>
	function toPage(offset){
		$("input[name='offset']").val(offset);
		$("form").submit();
	}
	
	function fundList(obj){
		$("input[name='customerBuy']").val(obj);
		$("input[name='offset']").val(0);
		$("form").submit();
	}
	
	function generateExcel(){
		var url="<%=request.getContextPath()%>/fund/fundListExcel";
		var params={from:$("input[name='from']").val(),to:$("input[name='to']").val(),
				customerBuy:$("input[name='customerBuy']").val()};
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
