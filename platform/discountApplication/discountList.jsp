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
		<c:set var="PENDING_CHECK" value="<%=DiscountApplicationStatus.PENDING_CHECK%>"/>
		<c:set var="PASS" value="<%=DiscountApplicationStatus.PASS%>"/>
		<c:set var="FAILED" value="<%=DiscountApplicationStatus.FAILED%>"/>
		
		<jsp:include page="/jsp/platform/header.jsp"></jsp:include>
		<jsp:include page="/jsp/platform/navigation.jsp"></jsp:include>
		<input type="text" id="keyword" value="${keyword}" placeholder="输入厂家公司简称"><button onclick="searchByKeyword()">搜索</button>
        <div class="nav-tabs">
            <button class="btn <c:if test='${status==PENDING_CHECK}'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath() %>/platform/discountApplicationList?status=${PENDING_CHECK}'">待审核</button>
            <button class="btn <c:if test='${status==PASS}'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath() %>/platform/discountApplicationList?status=${PASS}'">审核通过</button>
            <button class="btn <c:if test='${status==FAILED }'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath() %>/platform/discountApplicationList?status=${FAILED}'">审核不通过</button>
           
        </div>

         <div class="table-responsive">
            <table class="table table-bordered table-striped table-hover">
                <thead>
                <tr>
                    <th>姓名</th>
                    <th>申请时间</th>
                    <th>内容</th>
                    <th>首页文字</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${bap.list }" var="da" varStatus="i">
	                <tr>
	                    <td>${userList[i.index].legalPersonName}</td>
	                    <td>${da.discountCreatTime}</td>
	                    <td>${da.discountTitle}</td>
	                    <td>${da.welcomeTitle }</td>
	                    <td>
	                    	<c:if test="${da.discountStatus==0 }">
		                    	<a href="javascript:passApplication(${da.discountApplicationId})">通过</a>|
		                    	<a href="javascript:refuseApplication(${da.discountApplicationId})">不通过</a>
		                    </c:if>
	                    </td>
	                </tr>
               	</c:forEach>
                </tbody>
            </table>
         </div>

        <!-- [[分页-->
        <div class="paging">
            <span class="prev btn btn-primary" onclick="window.location.href='<%=request.getContextPath()%>/platform/discountApplicationList?status=${navActive}&offset=${bap.before}&keyword=${keyword }'">上一页</span>
            <span>当前第页<fmt:formatNumber value="${((bap.after==bap.count&&bap.after%10!=0)?1:0)+((bap.after-bap.after%10))/10 }" pattern="#0"/>/共<fmt:formatNumber value="${((bap.count-1-(bap.count-1)%10))/10+1}" pattern="#0" />页</span>
            <span class="next btn btn-primary" onclick="window.location.href='<%=request.getContextPath()%>/platform/discountApplicationList?status=${navActive}&offset=${bap.after}&keyword=${keyword }'">下一页</span>
        </div>
        <!-- 分页]]-->

    </div><!-- 页面主体的右边]] -->

    </div><!-- 页面主体]] -->

    <footer>

    </footer>
	<script>
		function passApplication(discountApplicationId){
			var url="<%=request.getContextPath()%>/platform/passDiscountApplication";
			var params={discountApplicationId:discountApplicationId};
			doAjax("GET",url,params,function(data){location.reload()},function(data){console.log("fail")},true,false);
			
		}
		
		function refuseApplication(discountApplicationId){
			var url="<%=request.getContextPath()%>/platform/refuseDiscountApplication";
			var params={discountApplicationId:discountApplicationId};
			doAjax("GET",url,params,function(data){location.reload()},function(data){console.log("fail")},true,false);
		}
		
		
	</script>
</body>
</html>