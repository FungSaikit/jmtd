<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>管理后台</title>
    <link rel="icon" type="image/x-icon" href="${path}/resources/backStage/image/favicon.ico" />

    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/common/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/backStage/css/index.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/backStage/css/order.css" />
	
	<script src="<%=request.getContextPath()%>/resources/common/jquery.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/common/bootstrap.min.js"></script>
    

</head>
    <body>

        <!-- [[头部 -->
        <jsp:include page="/jsp/platform/header.jsp"></jsp:include>
         <!-- [[页面主体 -->
		<jsp:include page="/jsp/platform/navigation.jsp"></jsp:include>

            <!-- [[选项卡-->
            <div class="nav-tabs">
                <%-- <button class="btn <c:if test='${buttonFlag==1}'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath()%>/platform/getProductList?buttonFlag=1&offset=0'">未审核</button> --%>
               <%--  <button class="btn <c:if test='${buttonFlag==2}'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath()%>/platform/getProductList?buttonFlag=2&offset=0'">待审核</button>
                <button class="btn <c:if test='${buttonFlag==3}'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath()%>/platform/getProductList?buttonFlag=3&offset=0'">审核不过</button> --%>
                <%-- <button class="btn <c:if test='${buttonFlag==4}'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath()%>/platform/getProductList?buttonFlag=4&offset=0'">审核通过</button> --%>
                <button class="btn <c:if test='${buttonFlag==0}'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath()%>/platform/lampPositionOnSale?buttonFlag=0&offset=0'">可租用</button>
                <button class="btn <c:if test='${buttonFlag==1}'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath()%>/platform/lampPositionOnSale?buttonFlag=1&offset=0'">待上传资料</button>
                <button class="btn <c:if test='${buttonFlag==2}'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath()%>/platform/lampPositionOnSale?buttonFlag=2&offset=0'">待审核</button>
                <button class="btn <c:if test='${buttonFlag==3}'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath()%>/platform/lampPositionOnSale?buttonFlag=3&offset=0'">已租用</button>
                
                <!-- 
                <button class="btn active" style="float:right" onclic
                k="window.location.href='<%=request.getContextPath()%>/platform/toAddProduct'">添加商品</button>
                -->
            </div><!-- 选项卡]] -->

            <!-- [[商品列表 -->
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover">
                    <thead>
                    <tr>
                        <th>灯位ID</th>
                        <th>状态</th>
                        <th>租期（个月）</th>
                        <th>上线时间</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${beforeAfterPager.list}" var="lampPosition">
                    	<tr>
                        <td>${lampPosition.lampPositionId}</td>
                        <c:if test="${lampPosition.lampPositionStatus eq 0}">
                        	<td>可租用</td>
                        	<td>----</td>
                        	<td>----</td>
                        	<td>----</td>
                        </c:if>
                        <c:if test="${lampPosition.lampPositionStatus eq 1}">
                        	<td>待上传资料</td>
                        	<td>${lampPosition.rentTerm}</td>
                        	<td>----</td>
                        	<td>----</td>
                        </c:if>
                        <c:if test="${lampPosition.lampPositionStatus eq 2}">
                        	<td>待审核</td>
                        	<td>${lampPosition.rentTerm}</td>
                        	<td>----</td>
                        	<td><a href="#">审核</a></td>
                        </c:if>
                        <c:if test="${lampPosition.lampPositionStatus eq 3}">
                        	<td>审核成功</td>
                        	<td>${lampPosition.rentTerm}</td>
                        	<td>----</td>
                        	<td>----</td>
                        </c:if>
                        <c:if test="${lampPosition.lampPositionStatus eq 4}">
                        	<td>可上线</td>
                        	<td>${lampPosition.rentTerm}</td>
                        	<td>${lampPosition.onlineTime}</td>
                        	<td>----</td>
                        </c:if>
                        <c:if test="${lampPosition.lampPositionStatus eq 5}">
                        	<td>上线中</td>
                        	<td>${lampPosition.rentTerm}</td>
                        	<td>${lampPosition.onlineTime}</td>
                        	<td>----</td>
                        </c:if>
                    </tr> 
                    </c:forEach> 
                    </tbody>
                </table>
            </div><!-- 商品列表]] -->

            <!-- [[分页-->
            <div class="paging">
                <span class="prev btn btn-primary" onclick="window.location.href='<%=request.getContextPath()%>/platform/lampPositionOnSale?buttonFlag=${buttonFlag}&offset=${beforeAfterPager.before}'">上一页</span>
                <span class="next btn btn-primary" onclick="window.location.href='<%=request.getContextPath()%>/platform/lampPositionOnSale?buttonFlag=${buttonFlag}&offset=${beforeAfterPager.after}'">下一页</span>
            </div>
            <!-- 分页]]-->

        </div><!-- rightConten右边区域]] -->

        </div><!-- mainBody页面主体]] -->

        <footer>
        </footer>

    </body><script src="<%=request.getContextPath()%>/resources/backStage/script/product.js"></script>
    <script type="text/javascript">
    	function generateQrCode(productId){
    		var url="<%=request.getContextPath()%>/platform/generateProductQrCode?productId="+productId;
    		doAjax("GET",url,{},success,fail,false,false);
    	}
    	
    	function success(data){
    		window.location.href=data.data;
    	}
    	
    	function fail(data){
    		alert(data);
    	}
    </script>
</html>