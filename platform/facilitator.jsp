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
		<c:set var="UNAUTHORIZED" value="<%=UserCheckStatus.UNAUTHORIZED%>" />
		<c:set var="AUTHORIZING" value="<%=UserCheckStatus.AUTHORIZING%>" />
		<c:set var="AUTHENTICATION_FAILURE" value="<%=UserCheckStatus.AUTHENTICATION_FAILURE%>" />
		<c:set var="AUTHENTICATION_SUCCESS" value="<%=UserCheckStatus.AUTHENTICATION_SUCCESS%>" />
		<c:set var="UPDATE_AUTHORIZING" value="<%=UserCheckStatus.UPDATE_AUTHORIZING%>" />
		<jsp:include page="/jsp/platform/header.jsp"></jsp:include>
		<jsp:include page="/jsp/platform/navigation.jsp"></jsp:include>
		<input type="text" id="keyword" value="${keyword}" placeholder="输入经销商公司简称"><button onclick="searchByKeyword()">搜索</button>
        <div class="nav-tabs">
        	<button class="btn <c:if test='${navActive==UNAUTHORIZED }'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath() %>/platform/manageFacilitator?checkStatus=${UNAUTHORIZED}'">未认证</button>
            <button class="btn <c:if test='${navActive==AUTHORIZING }'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath() %>/platform/manageFacilitator?checkStatus=${AUTHORIZING}'">待审核</button>
            <button class="btn <c:if test='${navActive==AUTHENTICATION_SUCCESS }'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath() %>/platform/manageFacilitator?checkStatus=${AUTHENTICATION_SUCCESS }'">审核通过</button>
            <button class="btn <c:if test='${navActive==AUTHENTICATION_FAILURE }'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath() %>/platform/manageFacilitator?checkStatus=${AUTHENTICATION_FAILURE }'">审核不通过</button>
       		 <button class="btn <c:if test='${navActive==UPDATE_AUTHORIZING }'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath() %>/platform/manageFacilitator?checkStatus=${UPDATE_AUTHORIZING }'">信息修改待审核</button>
        </div>

         <div class="table-responsive">
            <table class="table table-bordered table-striped table-hover">
                <thead>
                <tr>
                    <th class="textLeft">姓名</th>
                    <th>申请时间</th>
                    <th class="textRight">可支配资金（元）</th>
                    <th class="textRight">待结算资金（元）</th>
                    <th>审核状态</th>
                    <th>审核时间</th>
                    <c:if test="${navActive==AUTHENTICATION_SUCCESS }"><th>操作</th></c:if>
                </tr>
                </thead>
                <tbody>
                <c:if test="${empty applicationList }">
                <c:forEach items="${userList.list }" var="user" varStatus="i">
	                <tr>
	                    <td class="textLeft"><a href="<%=request.getContextPath()%>/platform/applicationDetail?applyId=${user.applyId}&userId=${user.userId}">${user.shortCompanyName }</a></td>
	                    <td>${applicationList[i.index].submitTime }</td>
	                    <td class="textRight moneyText">${user.flowMoney }</td>
	                    <td class="textRight moneyText">${user.pendingMoney }</td>
	                    <td><c:choose>
                    		<c:when test="${navActive==UNAUTHORIZED }">未认证</c:when>
                    		<c:when test="${navActive==AUTHORIZING }">认证处理中</c:when>
                    		<c:when test="${navActive==AUTHENTICATION_FAILURE }">认证失败</c:when>
                    		<c:when test="${navActive==AUTHENTICATION_SUCCESS }">认证成功</c:when>
                    		<c:when test="${navActive==UPDATE_AUTHORIZING }">信息修改待审核</c:when>
                    	</c:choose></td>
	                    <td>${applicationList[i.index].checkTime }</td>
	                    <c:if test="${navActive==AUTHENTICATION_SUCCESS }">
	                    	<td><a href="<%=request.getContextPath() %>/platform/setAgency?userId=${userList.list[i.index].userId}">更改为经销商</a></td>
	                    </c:if>
	                </tr>
               	</c:forEach>
               	</c:if>
               	<c:if test="${!empty applicationList}">
                <c:forEach items="${applicationList }" var="user" varStatus="i">
	                <tr>
	                    <td class="textLeft"><a href="<%=request.getContextPath()%>/platform/applicationDetail?applyId=${user.applyId}&userId=${user.userId}">${user.shortCompanyName }</a></td>
	                    <td>${applicationList[i.index].submitTime }</td>
	                    <td class="textRight moneyText">${userList.list[i.index].flowMoney}</td>
	                    <td class="textRight moneyText">${userList.list[i.index].pendingMoney}</td>
	                    <td><c:choose>
                    		<c:when test="${navActive==UNAUTHORIZED }">未认证</c:when>
                    		<c:when test="${navActive==AUTHORIZING }">认证处理中</c:when>
                    		<c:when test="${navActive==AUTHENTICATION_FAILURE }">认证失败</c:when>
                    		<c:when test="${navActive==AUTHENTICATION_SUCCESS }">认证成功</c:when>
                    	</c:choose></td>
	                    <td>${applicationList[i.index].checkTime }</td>
	                    <c:if test="${navActive==AUTHENTICATION_SUCCESS }">
	                    	<td><a href="<%=request.getContextPath() %>/platform/setAgency?userId=${userList.list[i.index].userId}">更改为经销商</a></td>
	                    </c:if>
	                </tr>
               	</c:forEach>
               	</c:if>
                </tbody>
            </table>
         </div>

        <!-- [[分页-->
        <div class="paging">
            <span class="prev btn btn-primary" onclick="window.location.href='<%=request.getContextPath()%>/platform/manageFacilitator?checkStatus=${navActive}&offset=${userList.before}&keyword=${keyword }'">上一页</span>
            <span>当前第页<fmt:formatNumber value="${((userList.after==userList.count&&userList.after%10!=0)?1:0)+((userList.after-userList.after%10))/10 }" pattern="#0"/>/共<fmt:formatNumber value="${((userList.count-1-(userList.count-1)%10))/10+1}" pattern="#0" />页</span>
            <span class="next btn btn-primary" onclick="window.location.href='<%=request.getContextPath()%>/platform/manageFacilitator?checkStatus=${navActive}&offset=${userList.after}&keyword=${keyword }'">下一页</span>
        </div>
        <!-- 分页]]-->

    </div><!-- 页面主体的右边]] -->

    </div><!-- 页面主体]] -->

    <footer>

    </footer>
	<script>
		function searchByKeyword(){
			window.location.href="<%=request.getContextPath()%>/platform/manageFacilitator?checkStatus=${navActive}&keyword="+$("#keyword").val();
		}
	</script>
</body>
</html>