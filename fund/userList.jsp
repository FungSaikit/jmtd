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
	<form action="<%=request.getContextPath()%>/fund/userStationList">
    	<input type="date" name="from" value="${from}">
   		<input type="date" name="to" value="${to}">
	   	<input type="hidden" value="0" name="offset"/>
	   	<input type="hidden" value="${role }" name="role"/>
	   	<button>提交</button>
	   	<button type="button" onclick="generateExcel();">生成excel</button>
    </form>
	    <div class="allStatus">
		    <a href="javascript:fundList(1)" class="btn btn-default <c:if test="${role==1}">btn-primary</c:if>">厂家</a>
		    <a href="javascript:fundList(2)" class="btn btn-default <c:if test="${role==2}">btn-primary</c:if>">业务员</a>
		    <a href="javascript:fundList(4)" class="btn btn-default <c:if test="${role==4}">btn-primary</c:if>">经销商</a>
		    <a href="javascript:fundList(6)" class="btn btn-default <c:if test="${role==6}">btn-primary</c:if>">服务商</a>
		    <a href="javascript:fundList(7)" class="btn btn-default <c:if test="${role==7}">btn-primary</c:if>">代理商</a>
		    <a href="javascript:fundList(5)" class="btn btn-default <c:if test="${role==5}">btn-primary</c:if>">消费者</a>
	    </div>
   	    <div class="table-responsive">
           <table class="table table-bordered table-striped table-hover">
               <thead>
               <tr>
                   <th>用户名</th>
                   <c:if test="${role!=5 }">
                   	  <th>真实姓名</th>
                   	  <c:if test="${role!=2 }">
                   	  	<th>公司名</th>
                   	  </c:if>
                   </c:if>
                   <th>已提现金额</th>
                   <th>可支配金额</th>
                   <th>待结算金额</th>
               </tr>
               </thead>
               <tbody>
               <c:forEach items="${userList.list}" var="user" varStatus="i">
               	<tr>
                	<td class="center">${user.user.userNickname}</td>
                   	<c:if test="${role!=5 }">
                    	<td class="center">${user.user.legalPersonName }</td>	
                   		<c:if test="${role!=2 }">
                    		<td class="center">${user.user.shortCompanyName }</td>
                    	</c:if>
                    </c:if>
                	<td class="center">${user.withdrawMoney }</td>
                    <td class="center">${user.flowMoney}</td>
                	<td class="center">${user.pendingMoney}</td>   
                </tr> 
               </c:forEach> 
               </tbody>
           </table>
	   </div><!-- 商品列表]] -->
	   <div class="paging">
           <span class="prev btn btn-primary" onclick="toPage(${userList.before})">上一页</span>
           <span>当前第页<fmt:formatNumber value="${((userList.after==userList.count&&userList.after%10!=0)?1:0)+((userList.after-userList.after%10))/10 }" pattern="#0"/>/共<fmt:formatNumber value="${((userList.count-1-(userList.count-1)%10))/10+1}" pattern="#0" />页</span>
           <span class="next btn btn-primary" onclick="toPage(${userList.after})">下一页</span>
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
		$("input[name='role']").val(obj);
		$("input[name='offset']").val(0);
		$("form").submit();
	}
	
	function generateExcel(){
		var url="<%=request.getContextPath()%>/fund/userListExcel";
		var params={
				role:$("input[name='role']").val()};
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
