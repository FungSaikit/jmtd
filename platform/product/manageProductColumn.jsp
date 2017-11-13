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
        	<button class="btn <c:if test="${productStyleType==0 }">navActive</c:if>" onclick="window.location.href='<%=request.getContextPath() %>/platform/manageProductColumn?productStyleType=0'">新中式</button>
        	<button class="btn <c:if test="${productStyleType==1 }">navActive</c:if>" onclick="window.location.href='<%=request.getContextPath() %>/platform/manageProductColumn?productStyleType=1'">非新中式</button>
        	
        	<button class="btn navActive" onclick="window.location.href='<%=request.getContextPath() %>/platform/toAddProductColumn'" style="float:right;">添加栏目</button>
            <%-- <button class="btn <c:if test='${navActive==AUTHORIZING }'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath() %>/platform/manageAgency?checkStatus=${AUTHORIZING}'">待审核</button>
            <button class="btn <c:if test='${navActive==AUTHENTICATION_SUCCESS }'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath() %>/platform/manageAgency?checkStatus=${AUTHENTICATION_SUCCESS }'">审核通过</button>
            <button class="btn <c:if test='${navActive==AUTHENTICATION_FAILURE }'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath() %>/platform/manageAgency?checkStatus=${AUTHENTICATION_FAILURE }'">审核不通过</button>
            <button class="btn <c:if test='${navActive==UPDATE_AUTHORIZING }'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath() %>/platform/manageAgency?checkStatus=${UPDATE_AUTHORIZING }'">信息修改待审核</button> --%>
        </div>
		
         <div class="table-responsive">
            <table class="table table-bordered table-striped table-hover">
                <thead>
                <tr>
                    <th class="textLeft">序号</th>
                    <th>栏目名</th>
                    <th class="textRight">操作</th>
                    <th class="">删除</th>
                    <th class="">查看</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${productColumnList }" var="productColumn" varStatus="i">
	                <tr>
	                    <td class="textLeft">${i.index}</td>
	                    <td class="textRight moneyText"><a href="<%=request.getContextPath()%>/platform/productColumnDetail?productColumnId=${productColumn.productColumnId}">
	                    	${productColumn.productColumnName}(${productColumn.productColumnTitle})</a></td>
	                    <td class="textRight moneyText">
	                    	<a href="javascript:upProductColumn(${productColumn.productColumnId })">上移</a>|
	                    	<a href="javascript:downProductColumn(${productColumn.productColumnId })">下移</a></td>
	                    <td>
	                    	<a href="javascript:deleteProductColumn(${productColumn.productColumnId })">删除</a></td>
	                    <td><a href="<%=request.getContextPath()%>/platform/productColumnDetail?productColumnId=${productColumn.productColumnId}">
	                    	查看</a></td>
	                </tr>
               	</c:forEach>
                </tbody>
            </table>
         </div>

        <%-- <!-- [[分页-->
        <div class="paging">
            <span class="prev btn btn-primary" onclick="window.location.href='<%=request.getContextPath()%>/platform/manageAgency?checkStatus=${navActive}&offset=${userList.before}&keyword=${keyword}&provinceId=${provinceId}&cityId=${cityId }&areaId=${areaId }'">上一页</span>
            <span>当前第页<fmt:formatNumber value="${((userList.after==userList.count&&userList.after%10!=0)?1:0)+((userList.after-userList.after%10))/10 }" pattern="#0"/>/共<fmt:formatNumber value="${((userList.count-1-(userList.count-1)%10))/10+1}" pattern="#0" />页</span>
            <span class="next btn btn-primary" onclick="window.location.href='<%=request.getContextPath()%>/platform/manageAgency?checkStatus=${navActive}&offset=${userList.after}&keyword=${keyword}&provinceId=${provinceId}&cityId=${cityId }&areaId=${areaId }'">下一页</span>
        </div>
        <!-- 分页]]--> --%>

    </div><!-- 页面主体的右边]] -->

    </div><!-- 页面主体]] -->

    <footer>

    </footer>
	<script>
		function upProductColumn(productColumnId){
			var url="<%=request.getContextPath()%>/platform/upProudctColumn";
			var params={productColumnId:productColumnId,productStyleType:${productStyleType}};
			doAjax("GET",url,params,function(data){location.reload();},
					function(data){console.log(data)},true,false);
		}
		
		function downProductColumn(productColumnId){
			var url="<%=request.getContextPath()%>/platform/downProductColumn";
			var params={productColumnId:productColumnId,productStyleType:${productStyleType}};
			doAjax("GET",url,params,function(data){location.reload();},
					function(data){console.log(data)},true,false);
		}
		
		function deleteProductColumn(productColumnId){
			var url="<%=request.getContextPath()%>/platform/deleteProductColumn";
			var params = {productColumnId:productColumnId};
			doAjax("GET",url,params,function(data){location.reload();},function(data){console.log(data)},true,false);
		}
	</script>
</body>
</html>