<%@ page language="java" import="java.util.*,com.alphaking.constant.*,com.alphaking.model.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>管理后台</title>
    <link rel="icon" type="image/x-icon" href="../image/favicon.ico" />

    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/common/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/backStage/css/index.css" />
	<style>
		table tr td:first-child{
			width:25%;
			font-weight:bold;
		}
		table tr td:last-child{
			width:75%;
		}
	</style>
</head>
<body>
		<c:set var="SALESMAN" value="<%=UserType.SALESMAN%>" />
		<c:set var="CUSTOMER" value="<%=UserType.CUSTOMER%>" />
		<c:set var="AGENCY" value="<%=UserType.AGENCY%>" />
		<c:set var="FACTORY" value="<%=UserType.FACTORY%>" />
		<c:set var="DEMAND_FACTORY" value="<%=UserType.DEMAND_FACTORY%>" />
		<c:set var="FACILITATOR" value="<%=UserType.FACILITATOR%>" />
		<c:set var="UNAUTHORIZED" value="<%=UserCheckStatus.UNAUTHORIZED%>" />
		<c:set var="AUTHORIZING" value="<%=UserCheckStatus.AUTHORIZING%>" />
		<c:set var="AUTHENTICATION_FAILURE" value="<%=UserCheckStatus.AUTHENTICATION_FAILURE%>" />
		<c:set var="AUTHENTICATION_SUCCESS" value="<%=UserCheckStatus.AUTHENTICATION_SUCCESS%>" />
		<jsp:include page="/jsp/platform/header.jsp"></jsp:include>
		<jsp:include page="/jsp/platform/navigation.jsp"></jsp:include>
       <div class="area">
            <table border="1" class="table table-bordered table-striped table-hover">
            	<tr>
            		<td>联系人</td>
            		<td>${demandModel.demand.demandLegalPerson}</td>
            	</tr>
            	<tr>
            		<td>联系方式</td>
            		<td>${demandModel.demand.demandPhoneNumber}</td>
            	</tr>
            	<tr>
            		<td>需求名</td>
            		<td>${demandModel.demand.demandName }</td>
            	</tr>
            	<tr>
            		<td>价格区间</td>
            		<td>${demandModel.demand.demandPriceDown }--${demandModel.demand.demandPriceUp }</td>
            	</tr>
            	<tr>
            		<td>数量</td>
            		<td>${demandModel.demand.demandNumber }</td>
            	</tr>
            	<tr>
            		<td>类型</td>
            		<td>${demandModel.type }</td>
            	</tr>
            	<tr>
            		<td>材质</td>
            		<td>${demandModel.material }</td>
            	</tr>
            	<tr>
            		<td>风格</td>
            		<td>${demandModel.style }</td>
            	</tr>
            	<tr>
            		<td>空间</td>
            		<td>${demandModel.space }</td>
            	</tr>
            	<tr>
            		<td>颜色</td>
            		<td>${demandModel.demand.demandColor }</td>
            	</tr>
            	<tr>
            		<td>详细说明</td>
            		<td>${demandModel.demand.demandContent }</td>
            	</tr>
            	<tr>
            		<td>说明图片</td>
            		<td>
            			<c:if test="${!empty demandModel.demand.demandCover1 }"><img src="${demandModel.demand.demandCover1 }" style="width:100px;height:100px;" data-click="show"/></c:if>
            			<c:if test="${!empty demandModel.demand.demandCover2 }"><img src="${demandModel.demand.demandCover2 }" style="width:100px;height:100px;" data-click="show"/></c:if>
            			<c:if test="${!empty demandModel.demand.demandCover3 }"><img src="${demandModel.demand.demandCover3 }" style="width:100px;height:100px;" data-click="show"/></c:if>
            			<c:if test="${!empty demandModel.demand.demandCover4 }"><img src="${demandModel.demand.demandCover4 }" style="width:100px;height:100px;" data-click="show"/></c:if>
            			<c:if test="${!empty demandModel.demand.demandCover5 }"><img src="${demandModel.demand.demandCover5 }" style="width:100px;height:100px;" data-click="show"/></c:if>
            			<c:if test="${!empty demandModel.demand.demandCover6 }"><img src="${demandModel.demand.demandCover6 }" style="width:100px;height:100px;" data-click="show"/></c:if>
            		</td>
            	</tr>
            	<tr>
            		<td>尺寸</td>
            		<td><c:if test="${!empty demandModel.demand.demandLength }">长:<fmt:formatNumber value=" ${demandModel.demand.demandLength }" pattern="#0"/>*</c:if>
													<c:if test="${!empty demandModel.demand.demandWidth }">宽:<fmt:formatNumber value=" ${demandModel.demand.demandWidth }" pattern="#0"/>*</c:if>	
													<c:if test="${!empty demandModel.demand.demandHeight }">高:<fmt:formatNumber value="${demandModel.demand.demandHeight }" pattern="#0"/><c:if test="${!empty demandModel.demand.demandDiameter }">*</c:if></c:if>
													<c:if test="${!empty demandModel.demand.demandDiameter }">直径:<fmt:formatNumber value=" ${demandModel.demand.demandDiameter}" pattern="#0"/></c:if></td>
            	</tr>
            	<tr>
            		<td>申请时间</td>
            		<td>${demandModel.demand.applyTime }</td>
            	</tr>
            	<tr>
            		<td>过期时间</td>
            		<td><fmt:formatDate value="${demandModel.demand.expireTime }"  pattern="yyyy-MM-dd"/></td>
            	</tr>
            	
            </table>
            
			
			
            <c:if test="${demandModel.demand.demandStatus==-1}">
            <div class="operateArea">
                <button type="submit" class="btn navActive" onclick="submitForm()">通过审核</button>
             </div>
            </c:if>
            <c:if test="${demandModel.demand.demandStatus==-1}">
            <div class="operateArea">
                <button type="submit" class="btn" onclick="window.location.href='<%=request.getContextPath()%>/platform/refuseDemand?demandId=${demandModel.demand.demandId}'">不通过审核</button>
            </div>
            </c:if>
        </div><!-- area]] -->
       

    </div><!-- 页面主体的右边]] -->

    </div><!-- 页面主体]] -->

    <footer>

    </footer>
    <script>
    	function submitForm(){
    		window.location.href='<%=request.getContextPath()%>/platform/passDemand?demandId=${demandModel.demand.demandId}';
    	}
    </script>
</body>

</html>
