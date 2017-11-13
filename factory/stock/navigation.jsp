<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 字体图标 -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/backStage/iconfont/iconfont.css" />

<div class="mainBody">
    <!-- [[ 左边导航 -->
    <ul class="col-md-3 col-lg-2 navigation" aria-expanded="true">
        <li>
            <div class="navItem"><span class="iconfont icon-crmtubiaohuaban35fuben3773"></span>用户管理</div>
            <ul class="subNav" style="display:block;">
                <li id="vender" <c:if test="${active=='factory'}">class="active"</c:if>><a href="<%=request.getContextPath()%>/stock/newOrderStation?orderStockStatus=1">订单管理</a></li>
                <li id="salesman" <c:if test="${active=='salesman'}">class="active"</c:if>><a href="<%=request.getContextPath()%>/stock/manageProductList">产品管理</a></li>
               <%--  <li id="agency" <c:if test="${active=='agency'}">class="active"</c:if>><a href="<%=request.getContextPath()%>/stock/orderList">订单流水</a></li>
             --%></ul>
        </li>
    </ul> <!-- 左边导航]] -->

    <div class="col-md-9 col-lg-10 rightContent">

        <!-- [[路径导航 -->
        <ol class="breadcrumb">
          <li id="breadcrumb1"></li>
          <li id="breadcrumb2"></li>
        </ol>

<script src="<%=request.getContextPath() %>/resources/common/jquery.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>

	<script>
	countVisit();
	function countVisit(){
		var url="<%=request.getContextPath()%>/visit/countVisit";
		var params={url:window.location.href};
		doAjax("GET",url,params,visitSuccess,fail1,true,false);
	}
	
	function visitSuccess(data){
		
	}
	function fail1(data){
		
	}
	</script>
