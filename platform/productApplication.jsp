<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 

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
	
	<style>
		/* 遮罩层 */
		.shade{
			width:100%;
			height:100%;
			background-color:rgba(0,0,0,.5);
			position:fixed;
			left:0;
			top:0;
			z-index:100;
			display:none;
		}
		.waiting{
			text-align:center;
			position:fixed;
			left:0;
			top:40%;
			width:100%;
			z-index:1003;
			line-height:50px;
			display:none;
		}
		.waiting>i{
			color:#fff;
			font-size:50px;
			width:50px;
			height:50px;
			-webkit-transform-origin: 50% 60%;
		   -moz-transform-origin:  50% 60%;
		   transform-origin:  50% 60%;
		}
	</style>

</head>
    <body>	
		<!-- 等待加载 -->
		<div class="waiting"><i class="iconfont">&#xe62c;</i></div>
		<div class="shade"></div>
    	<c:set var="CHECK_SUCCESS" value="<%=LampStatus.CHECK_SUCCESS%>" />
		<c:set var="WAITING_ONLINE" value="<%=LampStatus.WAITING_ONLINE%>" />
		<c:set var="ONLINE" value="<%=LampStatus.ONLINE%>" />
		<c:set var="UNDERCARRIAGED" value="<%=LampStatus.UNDERCARRIAGED%>" />
		
        <!-- [[头部 -->
        <jsp:include page="/jsp/platform/header.jsp"></jsp:include>
         <!-- [[页面主体 -->
		<jsp:include page="/jsp/platform/navigation.jsp"></jsp:include>
            <!-- [[选项卡-->
            <button class="btn <c:if test="${status==0 }">navActive</c:if>" onclick="toStatus(0)">待审核</button>
            <button class="btn <c:if test="${status==1 }">navActive</c:if>" onclick="toStatus(1)">审核通过</button>
            <button class="btn <c:if test="${status==2 }">navActive</c:if>" onclick="toStatus(2)">审核不通过</button>
            <!-- [[商品列表 -->
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover">
                    <thead>
                    <tr>
                        <th class="textLeft">商品名</th>
                        <th>主图</th>
                        <th class="textRight">品牌</th>
                        <th>申请状态</th>
                        <th>类型</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${bap.list}" var="pa" varStatus="i">
                    	<tr>
	                    	<td class="textLeft" ><a href="<%=request.getContextPath()%>/platform/getProductDetail?productId=${pa.product.productId}&buttonFlag=${buttonFlag}">${pa.product.productName}</a></td>
	                        <td class=""><img src="${pa.product.cover1 }" width="100" height="100"/></td>
	                        <td class="textRight moneyText">${pa.product.productBrand}</td>
	                        <td class="textRight numberText">
	                        	<c:if test="${pa.productApplication.productStatus==5 }">上架</c:if>
	                        	<c:if test="${pa.productApplication.productStatus==6 }">下架</c:if>
	                        </td>
	                        <td class="textRight numberText">
	                        	<c:if test="${pa.productApplication.productKind==1}">现货</c:if>
	                        	<c:if test="${pa.productApplication.productKind==0}">订货</c:if>
	                        	<c:if test="${pa.productApplication.productKind==2}">爆款</c:if>
	                        </td>
	                        <td><c:if test="${status==0 }"><a href="<%=request.getContextPath()%>/platform/passProductApplication?productApplicationId=${pa.productApplication.productApplicationId}&status=${status}">通过</a>
	                        	<a href="<%=request.getContextPath()%>/platform/refuseProductApplication?productApplicationId=${pa.productApplication.productApplicationId}&status=${status}">不通过</a></c:if></td>
	                    </tr> 
                    </c:forEach> 
                    </tbody>
                </table>
            </div><!-- 商品列表]] -->

            <!-- [[分页-->
            <div class="paging">
                <span class="prev btn btn-primary" onclick="window.location.href='<%=request.getContextPath()%>/platform/productApplicationList?buttonFlag=${buttonFlag}&status=${status }&offset=${bap.before}'">上一页</span>
                <span><fmt:formatNumber value="${(offset/beforeAfterPager.size)+1 }" pattern="#0"/>/<fmt:formatNumber value="${beforeAfterPager.count/beforeAfterPager.size+1}" pattern="#0"/></span>
                <span class="next btn btn-primary" onclick="window.location.href='<%=request.getContextPath()%>/platform/productApplicationList?buttonFlag=${buttonFlag}&status=${status }&offset=${bap.after}'">下一页</span>
            </div>
            <!-- 分页]]-->

        </div><!-- rightConten右边区域]] -->

        </div><!-- mainBody页面主体]] -->

        <footer>
        </footer> 
    </body>
	<script src="<%=request.getContextPath()%>/resources/backStage/script/product.js"></script>
    <script type="text/javascript">
    	function toStatus(status){
    		window.location.href="<%=request.getContextPath()%>/platform/productApplicationList?status="+status
    	}
    </script>
</html>