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
        <div class="nav-tabs">
            <button class="btn <c:if test='${status==0}'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath() %>/platform/unbundingList?unbundingStatus=0'">待审核</button>
            <button class="btn <c:if test='${status==1}'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath() %>/platform/unbundingList?unbundingStatus=1'">已通过</button>
            <button class="btn <c:if test='${status==2}'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath() %>/platform/unbundingList?unbundingStatus=2'">不通过</button>
        </div>

         <div class="table-responsive">
            <table class="table table-bordered table-striped table-hover">
                <thead>
                <tr>
                    <th class="textLeft">申请人</th>
                    <th>原因</th>
                    <th>上级</th>
                    <th>申请时间</th>
                    <th>审核时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${unbundingList.list }" var="u" varStatus="i">
	                <tr>
	                    <td class="textLeft">${u.unbundingUserName }</td>
	                    <td>${u.unbundingReason}</td>
	                    <td>${u.unbundingUpUserName}</td>
	                    <td>${u.unbundingApplyTime }</td>
	                    <td>${u.unbundingHandleTime }</td>
	                    <td><a href="<%=request.getContextPath()%>/platform/passUnbunding?unbundingId=${u.unbundingId}&unbundingStatus=${status}&offset=${offset}">通过</a>
	                    ||<a href="<%=request.getContextPath()%>/platform/refuseUnbunding?unbundingId=${u.unbundingId}&unbundingStatus=${status}&offset=${offset}">不通过</a></td>
	                </tr>
               	</c:forEach>
                </tbody>
            </table>
         </div>

        <!-- [[分页-->
        <div class="paging">
            <span class="prev btn btn-primary" onclick="window.location.href='<%=request.getContextPath()%>/platform/unbundingList?checkStatus=${navActive}&offset=${unbundingList.before}&keyword=${keyword}'">上一页</span>
            <span>当前第页<fmt:formatNumber value="${((unbundingList.after==unbundingList.count&&unbundingList.after%10!=0)?1:0)+((unbundingList.after-unbundingList.after%10))/10 }" pattern="#0"/>/共<fmt:formatNumber value="${((unbundingList.count-1-(unbundingList.count-1)%10))/10+1}" pattern="#0" />页</span>
            <span class="next btn btn-primary" onclick="window.location.href='<%=request.getContextPath()%>/platform/unbundingList?checkStatus=${navActive}&offset=${unbundingList.after}&keyword=${keyword}'">下一页</span>
        </div>
        <!-- 分页]]-->

    </div><!-- 页面主体的右边]] -->

    </div><!-- 页面主体]] -->

    <footer>

    </footer>
	<script>
		function searchByKeyword(){
			window.location.href="<%=request.getContextPath()%>/platform/unbundingList?checkStatus=${navActive}&keyword="+$("#keyword").val();
		}
	</script>
</body>
</html>