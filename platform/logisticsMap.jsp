<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>管理后台</title>
    <link rel="icon" type="image/x-icon" href="<%=request.getContextPath() %>/resources/image/favicon.ico" />

    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/common/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/backStage/css/index.css" />

</head>
<body>
		<jsp:include page="/jsp/platform/header.jsp"></jsp:include>
		<jsp:include page="/jsp/platform/navigation.jsp"></jsp:include>
		<button onclick="window.location.href='<%=request.getContextPath()%>/platform/addLogisticsMap.html'">添加记录</button>
         <div class="table-responsive">
            <table class="table table-bordered table-striped table-hover">
                <thead>
                <tr>
                    <th class="textLeft">物流公司</th>
                    <th class="">物流园</th>
                    <th class="">操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${lmList.list }" var="lm">
                <tr>
                    <td class="textLeft">${lm.logisticsCompany}</td>
                    <td>${lm.logisticsPark}</td>
                    <td><a href="<%=request.getContextPath()%>/platform/updateLogisticsMap.html?logisticsMapId=${lm.logisticsMapId}">修改</a></td>
                </tr>
                </c:forEach>
                </tbody>
            </table>
         </div>

        <!-- [[分页-->
         <div class="paging">
            <span class="prev btn btn-primary" onclick="window.location.href='<%=request.getContextPath()%>/platform/showLogisticsMap?offset=${lmList.before}'">上一页</span>
            <span class="next btn btn-primary" onclick="window.location.href='<%=request.getContextPath()%>/platform/showLogisticsMap?offset=${lmList.after}'">下一页</span>
        </div>
        <!-- 分页]]-->

    </div><!-- 页面主体的右边]] -->

    </div><!-- 页面主体]] -->

    <footer>

    </footer>

</body>
</html>