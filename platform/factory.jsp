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

    <%-- <script src="<%=request.getContextPath() %>/resources/common/require.js" data-main="<%=request.getContextPath() %>/resources/backStage/script/main.js" defer async="true"></script>
 --%>
</head>
<body>
		<c:set var="UNAUTHORIZED" value="<%=UserCheckStatus.UNAUTHORIZED%>" />
		<c:set var="AUTHORIZING" value="<%=UserCheckStatus.AUTHORIZING%>" />
		<c:set var="AUTHENTICATION_FAILURE" value="<%=UserCheckStatus.AUTHENTICATION_FAILURE%>" />
		<c:set var="AUTHENTICATION_SUCCESS" value="<%=UserCheckStatus.AUTHENTICATION_SUCCESS%>" />
		<c:set var="UPDATE_AUTHORIZING" value="<%=UserCheckStatus.UPDATE_AUTHORIZING%>" />
		
		<jsp:include page="/jsp/platform/header.jsp"></jsp:include>
		<jsp:include page="/jsp/platform/navigation.jsp"></jsp:include>
		<input type="text" id="keyword" value="${keyword}" placeholder="输入厂家公司简称"><button onclick="searchByKeyword()">搜索</button>
        <div class="nav-tabs">
        	<button class="btn <c:if test='${navActive==UNAUTHORIZED }'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath() %>/platform/manageFactory?checkStatus=${UNAUTHORIZED}'">未认证</button>
            <button class="btn <c:if test='${navActive==AUTHORIZING }'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath() %>/platform/manageFactory?checkStatus=${AUTHORIZING}'">待审核</button>
            <button class="btn <c:if test='${navActive==AUTHENTICATION_SUCCESS }'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath() %>/platform/manageFactory?checkStatus=${AUTHENTICATION_SUCCESS }'">审核通过</button>
            <button class="btn <c:if test='${navActive==AUTHENTICATION_FAILURE }'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath() %>/platform/manageFactory?checkStatus=${AUTHENTICATION_FAILURE }'">审核不通过</button>
        	<button class="btn <c:if test='${navActive==UPDATE_AUTHORIZING }'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath() %>/platform/manageFactory?checkStatus=${UPDATE_AUTHORIZING }'">信息修改待审核</button>
        </div>

         <div class="table-responsive">
            <table class="table table-bordered table-striped table-hover">
                <thead>
                <tr>
                    <th class="textLeft">姓名</th>
                    <th>申请时间</th>
                    <th class="textRight">可支配资金（元）</th>
                    <th class="textRight">待结算资金（元）</th>
                    <th>联系人</th>
                    <th>联系电话</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:if test="${empty applicationList}">
                <c:forEach items="${userList.list }" var="user" varStatus="i">
	                <tr>
	                    <td class="textLeft"><a href="<%=request.getContextPath()%>/platform/applicationDetail?applyId=${user.applyId}&userId=${user.userId}">${user.userNickname }</a></td>
	                    <td>${applicationList[i.index].submitTime }</td>
	                    <td class="textRight moneyText">${user.flowMoney }</td>
	                    <td class="textRight moneyText">${user.pendingMoney }</td>
	                    <td></td>
	                    <td></td>
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
	                    <td>${applicationList[i.index].legalPerson }</td>
	                    <td>${applicationList[i.index].contact }</td>
	                    <td><a href="<%=request.getContextPath() %>/platform/factoryCapitalDetail?userId=${user.userId }">查看</a></td>
	                </tr>
               	</c:forEach>
               	</c:if>
                </tbody>
            </table>
         </div>

        <!-- [[分页-->
        <div class="paging">
            <span class="prev btn btn-primary" onclick="window.location.href='<%=request.getContextPath()%>/platform/manageFactory?checkStatus=${navActive}&offset=${userList.before}&keyword=${keyword }'">上一页</span>
            <span>当前第页<fmt:formatNumber value="${((userList.after==userList.count&&userList.after%10!=0)?1:0)+((userList.after-userList.after%10))/10 }" pattern="#0"/>/共<fmt:formatNumber value="${((userList.count-1-(userList.count-1)%10))/10+1}" pattern="#0" />页</span>
            <span class="next btn btn-primary" onclick="window.location.href='<%=request.getContextPath()%>/platform/manageFactory?checkStatus=${navActive}&offset=${userList.after}&keyword=${keyword }'">下一页</span>
        </div>
        <!-- 分页]]-->

    </div><!-- 页面主体的右边]] -->

    </div><!-- 页面主体]] -->

    <footer>

    </footer>
	<script>
		function searchByKeyword(){
			window.location.href="<%=request.getContextPath()%>/platform/manageFactory?checkStatus=${navActive}&keyword="+$("#keyword").val();
		}
	</script>
</body>
</html>