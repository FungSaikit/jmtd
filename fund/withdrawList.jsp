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
	<form action="<%=request.getContextPath()%>/fund/withdrawList">
    	<input type="date" name="from" value="${from}">
   		<input type="date" name="to" value="${to}">
	   	<input type="hidden" value="0" name="offset"/>
	   	<input type="hidden" value="${withdrawType }" name="withdrawType"/>
	   	<button>确定</button>
	   	<button onclick="generateExcel()" type="button">生成excel</button>
    </form>
	    <div class="allStatus">
		    <a href="javascript:fundList(4)" class="btn btn-default <c:if test="${withdrawType==4}">btn-primary</c:if>">提现到银行卡</a>
		    <a href="javascript:fundList(3)" class="btn btn-default <c:if test="${withdrawType==3}">btn-primary</c:if>">提现到微信</a>
		    <a href="javascript:fundList(5)" class="btn btn-default <c:if test="${withdrawType==5}">btn-primary</c:if>">提现到平台</a>
	    </div>
   	    <div class="table-responsive">
           <table class="table table-bordered table-striped table-hover">
               <thead>
               <tr>
	               <c:if test="${withdrawType==4||withdrawType==3}">
                   <th>申请时间</th>
                   <th>通过时间</th>
                   <th>状态</th>
                   <th>用户名</th>
                   <th>提现金额</th>
                   <th>手续费</th>
                   <th>到账金额</th>
	               <c:if test="${withdrawType==4 }">
	                   <th>开户账号</th>
	                   <th>开户人</th>
	                   <th>开户银行</th>
	                   <th>联系人</th>
	                   <th>联系方式</th>
                   </c:if>
                   </c:if>
	               <c:if test="${withdrawType==5}">
	               		<th>提现时间</th>
		                <th>提现人</th>
		                <th>提现金额</th>
	               </c:if>
               </tr>
               </thead>
               <tbody>
               <c:forEach items="${withdrawList.list}" var="withdraw" varStatus="i">
               	<tr>
	               <c:if test="${withdrawType==4||withdrawType==3}">
                    <td class="center">
                    	<fmt:formatDate value="${withdraw.creatTime}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
                    <td class="center">
                    	<fmt:formatDate value="${withdraw.settleTime}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
                	<td class="center"><c:choose><c:when test="${withdraw.settlementStatus==1}">已结算</c:when>
                	<c:otherwise>待结算</c:otherwise></c:choose></td>
                    <td class="center">${withdraw.withdrawUser}</td>
                	<td class="center">${withdraw.withdrawMoney}</td>                 
                    <td class="center"><fmt:formatNumber type="number" value="${withdraw.withdrawMoney-withdraw.arrivalMoney}" pattern="0.00" maxFractionDigits="2"/> </td>
                   	<td class="center">
                   		${withdraw.arrivalMoney}</td> 
		            <c:if test="${withdrawType==4 }">
	                    <td class="center">${withdraw.account}</td> 
	                    <td class="center">${withdraw.accountPerson}</td> 
	                    <td class="center">${withdraw.accountProvince}${withdraw.accountCity}${withdraw.accountBank }</td>
	                    <td class="center">${withdraw.contactPerson}</td>     
	                    <td class="center">${withdraw.contactWay}</td> 
                    </c:if>
                    </c:if>
	               	<c:if test="${withdrawType==5}">
	               		<td class="center">${withdraw.settleTime}</td> 
	                    <td class="center">${withdraw.withdrawUser}</td> 
	                    <td class="center">${withdraw.withdrawMoney}</td> 
	               	</c:if>
                </tr> 
               </c:forEach> 
               </tbody>
           </table>
	   </div><!-- 商品列表]] -->
	   <div class="paging">
           <span class="prev btn btn-primary" onclick="toPage(${withdrawList.before})">上一页</span>
           <span>当前第页<fmt:formatNumber value="${((withdrawList.after==withdrawList.count&&withdrawList.after%10!=0)?1:0)+((withdrawList.after-withdrawList.after%10))/10 }" pattern="#0"/>/共<fmt:formatNumber value="${((withdrawList.count-1-(withdrawList.count-1)%10))/10+1}" pattern="#0" />页</span>
           <span class="next btn btn-primary" onclick="toPage(${withdrawList.after})">下一页</span>
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
		$("input[name='withdrawType']").val(obj);
		$("input[name='offset']").val(0);
		$("form").submit();
	}
	
	function generateExcel(){
		var url="<%=request.getContextPath()%>/fund/withdrawListExcel";
		var params={from:$("input[name='from']").val(),to:$("input[name='to']").val(),
				withdrawType:$("input[name='withdrawType']").val()};
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
