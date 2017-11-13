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
		<input type="text" id="keyword" value="${keyword}" placeholder="输入经销商公司简称">
		<select name="provinceId" onchange="queryCity(this.value)" id="provinceId">
			<option value="">请选择</option>
			<c:forEach items="${provinceList }" var="province">
				<option value="${province.addressId }" ${provinceId==province.addressId?"selected":""}>${province.addressName}</option>
			</c:forEach>
		</select>
        <select name="cityId" id="city" onchange="queryArea(this.value)" >
			<option value="">请选择</option></select>
        <select name="areaId" id="area" >
			<option value="">请选择</option></select>
		<button onclick="searchByKeyword()">搜索</button>
        <div class="nav-tabs">
        	<button class="btn <c:if test='${navActive==UNAUTHORIZED }'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath() %>/platform/manageAgency?checkStatus=${UNAUTHORIZED}'">未认证</button>
            <button class="btn <c:if test='${navActive==AUTHORIZING }'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath() %>/platform/manageAgency?checkStatus=${AUTHORIZING}'">待审核</button>
            <button class="btn <c:if test='${navActive==AUTHENTICATION_SUCCESS }'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath() %>/platform/manageAgency?checkStatus=${AUTHENTICATION_SUCCESS }'">审核通过</button>
            <button class="btn <c:if test='${navActive==AUTHENTICATION_FAILURE }'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath() %>/platform/manageAgency?checkStatus=${AUTHENTICATION_FAILURE }'">审核不通过</button>
            <button class="btn <c:if test='${navActive==UPDATE_AUTHORIZING }'>navActive</c:if>" onclick="window.location.href='<%=request.getContextPath() %>/platform/manageAgency?checkStatus=${UPDATE_AUTHORIZING }'">信息修改待审核</button>
        </div>

         <div class="table-responsive">
            <table class="table table-bordered table-striped table-hover">
                <thead>
                <tr>
                    <th class="textLeft">姓名</th>
                    <th>申请时间</th>
                    <th class="textRight">可支配资金（元）</th>
                    <th class="textRight">待结算资金（元）</th>
                    <th>联系电话</th>
                    <th>上级</th>
                    <c:if test="${navActive==AUTHENTICATION_SUCCESS }"><th>操作</th></c:if>
                    <th>详情</th>
                </tr>
                </thead>
                <tbody>
                <c:if test="${empty applicationList}">
                <c:forEach items="${userList.list }" var="user" varStatus="i">
	                <tr>
	                    <td class="textLeft"><a href="<%=request.getContextPath()%>/platform/applicationDetail?applyId=${user.applyId}&userId=${user.userId}">${user.userNickname }</a></td>
	                    <td>-</td>
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
	                    <td class="textLeft"><a href="<%=request.getContextPath()%>/platform/applicationDetail?applyId=${user.applyId}&userId=${user.userId}">${user.legalPerson}(${userList.list[i.index].userNickname})</a></td>
	                    <td>${applicationList[i.index].submitTime }</td>
	                    <td class="textRight moneyText">${userList.list[i.index].flowMoney}</td>
	                    <td class="textRight moneyText">${userList.list[i.index].pendingMoney}</td>
	                    <td>${applicationList[i.index].contact }</td>
	                    <td>${strList[i.index]}</td>
	                    <c:if test="${navActive==AUTHENTICATION_SUCCESS }">
	                    	<td><a href="<%=request.getContextPath() %>/platform/setFacilitator?userId=${userList.list[i.index].userId}">更改为服务商</a>
	                    	/<a href="<%=request.getContextPath() %>/platform/setAgent?userId=${userList.list[i.index].userId}">更改为代理商</a></td>
	                    </c:if>
	                    <td><a href="<%=request.getContextPath() %>/platform/agencyDetail?userId=${userList.list[i.index].userId}">查看</a></td>
	                </tr>
               	</c:forEach>
               	</c:if>
                </tbody>
            </table>
         </div>

        <!-- [[分页-->
        <div class="paging">
            <span class="prev btn btn-primary" onclick="window.location.href='<%=request.getContextPath()%>/platform/manageAgency?checkStatus=${navActive}&offset=${userList.before}&keyword=${keyword}&provinceId=${provinceId}&cityId=${cityId }&areaId=${areaId }'">上一页</span>
            <span>当前第页<fmt:formatNumber value="${((userList.after==userList.count&&userList.after%10!=0)?1:0)+((userList.after-userList.after%10))/10 }" pattern="#0"/>/共<fmt:formatNumber value="${((userList.count-1-(userList.count-1)%10))/10+1}" pattern="#0" />页</span>
            <span class="next btn btn-primary" onclick="window.location.href='<%=request.getContextPath()%>/platform/manageAgency?checkStatus=${navActive}&offset=${userList.after}&keyword=${keyword}&provinceId=${provinceId}&cityId=${cityId }&areaId=${areaId }'">下一页</span>
        </div>
        <!-- 分页]]-->

    </div><!-- 页面主体的右边]] -->

    </div><!-- 页面主体]] -->

    <footer>

    </footer>
	<script>
		function searchByKeyword(){
			window.location.href="<%=request.getContextPath()%>/platform/manageAgency?checkStatus=${navActive}&keyword="+$("#keyword").val()
					+"&provinceId="+$("#provinceId").val()+"&cityId="+$("#city").val()
					+"&areaId="+$("#area").val();
		}
		
		function queryCity(addressId){
			var url="<%=request.getContextPath()%>/address/queryAddress";
			var params={upAddressId:addressId};
			doAjax("GET",url,params,queryCitySuccess,fail,false,false);
		}
		
		function queryCitySuccess(data){
			var option="";
			option+='<option value="">请选择</option>';
			for(var i=0;i<data.length;i++){
				option+="<option value='"+data[i].addressId+"'>"+data[i].addressName+"</option>";
			}
			$("#city").html(option);
		}
		
		function queryArea(addressId){
			var url="<%=request.getContextPath()%>/address/queryAddress";
			var params={upAddressId:addressId};
			doAjax("GET",url,params,queryAreaSuccess,fail,false,false);
		}
		
		function queryAreaSuccess(data){
			var option="";
			option+='<option value="">请选择</option>';
			for(var i=0;i<data.length;i++){
				option+="<option value='"+data[i].addressId+"'>"+data[i].addressName+"</option>";
			}
			$("#area").html(option);
		}
		
		function fail(){
			alert("fail");
		}
		
		$(function(){
			<c:if test="${!empty provinceId}">
			queryCity(${provinceId});
			</c:if>
			<c:if test="${!empty cityId}">
			queryArea(${cityId});
			</c:if>
			$("#provinceId").val(${provinceId});
			$("#city").val(${cityId});
			$("#area").val(${areaId});
		})
		
	</script>
</body>
</html>