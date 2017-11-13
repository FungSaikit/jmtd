<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 字体图标 -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/common/font/iconfont.css" />


<div class="mainBody">
    <!-- [[ 左边导航 -->
    <ul class="col-md-3 col-lg-2 navigation" aria-expanded="true">
    	<c:if test="${sessionScope.role==0||sessionScope.role==1}">
    	<%-- <li>
            <a href="<%=request.getContextPath()%>/platform/platformStation"><div class="navItem" id="index"><span class="iconfont icon-home"></span>首页</div></a>
        </li> --%>
        <%-- <li>
            <div class="navItem"><span class="iconfont icon-caiwujiesuan"></span>数据统计</div>
            <ul class="subNav" <c:if test="${active=='dataOverview'||active=='userMap'}">style="display:block;"</c:if>>
                <li id="vender" <c:if test="${active=='dataOverview'}">class="active"</c:if>><a href="<%=request.getContextPath()%>/platform/dataOverview">数据概览</a></li>
                <li id="vender" <c:if test="${active=='userMap1'}">class="active"</c:if>><a href="<%=request.getContextPath()%>/platform/userAnalysis">用户分析</a></li>
            	<li id="vender" <c:if test="${active=='userMap'}">class="active"</c:if>><a href="<%=request.getContextPath()%>/platform/userMap">用户地图</a></li>
            	<li id="vender" <c:if test="${active=='userDistribution'}">class="active"</c:if>><a href="<%=request.getContextPath()%>/platform/userDistribution">用户分布</a></li>
            	<li id="vender" <c:if test="${active=='userMap1'}">class="active"</c:if>><a href="<%=request.getContextPath()%>/platform/productAnalysis">产品分析</a></li>
            </ul>
        </li> --%>
        <li>
            <div class="navItem"><span class="iconfont icon-yonghu"></span>用户管理</div>
            <ul class="subNav" <c:if test="${active=='factory'||active=='salesman'||active=='agency'||active=='customer'||active=='facilitator'||active=='agent'}">style="display:block;"</c:if>>
                <%-- <li id="vender" <c:if test="${active=='factory'}">class="active"</c:if>><a href="<%=request.getContextPath()%>/platform/manageFactory">厂家</a></li> --%>
                <li id="salesman" <c:if test="${active=='salesman'}">class="active"</c:if>><a href="<%=request.getContextPath()%>/platform/manageSalesman">业务员</a></li>
                <li id="agency" <c:if test="${active=='agency'}">class="active"</c:if>><a href="<%=request.getContextPath()%>/platform/manageAgency">经销商</a></li>
                <li id="customer" <c:if test="${active=='customer'}">class="active"</c:if>><a href="<%=request.getContextPath()%>/platform/manageCustomer">消费者</a></li>
                <%--<li id="customer" <c:if test="${active=='facilitator'}">class="active"</c:if>><a href="<%=request.getContextPath()%>/platform/manageFacilitator">服务商</a></li>
                 <li id="customer" <c:if test="${active=='agent'}">class="active"</c:if>><a href="<%=request.getContextPath()%>/platform/manageAgent">代理商</a></li>
                 <li id="customer" <c:if test="${active=='demandFactory'}">class="active"</c:if>><a href="<%=request.getContextPath()%>/platform/manageDemandFactory">需求厂家</a></li>--%>
            </ul>
        </li>
        <li>
            <div class="navItem"><span class="iconfont icon-suoyou"></span>产品管理</div>
            <ul class="subNav">
                <li id="pList"><a href="<%=request.getContextPath()%>/platform/getProductList?buttonFlag=5&offset=0">商品列表</a></li>
                <li id="pList"><a href="<%=request.getContextPath()%>/platform/toAddProduct">添加商品</a></li><%--
                <li id="pQuery"><a href="<%=request.getContextPath()%>/platform/productList">商品报表</a></li>
                <li id="pQuery"><a href="<%=request.getContextPath()%>/platform/manageProductColumn">商品栏目</a></li> 
                <li id="pQuery"><a href="<%=request.getContextPath()%>/platform/productApplicationList">商品审核</a></li>--%>
            </ul>
        </li>
        </c:if><%-- 
        <li>
            <div class="navItem"><span class="iconfont icon-shangpin"></span>灯位管理</div>
            <ul class="subNav">
                <li id="pList"><a href="javascript:void()">灯位设置</a></li>
                <li id="pList"><a href="<%=request.getContextPath()%>/platform/lampPositionOnSale?buttonFlag=0&offset=0">灯位出租</a></li>
            </ul>
        </li> --%>
        <li>
            <div class="navItem"><span class="iconfont icon-dingdan"></span>订单管理</div>
            <ul class="subNav">
                <li id="oList"><a href="<%=request.getContextPath()%>/platform/orderList">订单列表</a></li>
                <%-- <li><a href="<%=request.getContextPath()%>/platform/platformOrderStockStatus">库存状况</a> --%>
                <li><a href="<%=request.getContextPath()%>/platform/afterSaleList">售后服务</a>
            </ul>
        </li>
        <c:if test="${sessionScope.role==0}">
        <li>
            <div class="navItem"><span class="iconfont icon-mingxi"></span>资金流水</div>
            <ul class="subNav">
                <li id="fList"><a href="<%=request.getContextPath()%>/platform/tradeManage">交易列表</a></li>
            </ul>
        </li>
        </c:if>
    	<li>
            <div class="navItem"><span class="iconfont icon-weixin"></span>消息管理</div>
            <ul class="subNav">
                <li id="indexCarousel"><a href="<%=request.getContextPath()%>/platform/freebackList">服务与反馈</a></li>
            </ul>
        </li>
    	<c:if test="${sessionScope.role==0||sessionScope.role==1}">
        <li>
            <div class="navItem"><span class="iconfont icon-baocun"></span>系统设置</div>
            <ul class="subNav">
                <li id="indexCarousel"><a href="<%=request.getContextPath()%>/platform/manageCarousel">轮播图</a></li><!-- 
                <li id="commissionParameter"><a href="javascript:void()">佣金参数</a></li> -->
               <%--  <li ><a href="<%=request.getContextPath()%>/platform/manageAddress">添加收货地址</a> --%><!-- 
                <li id="lampParameter"><a href="javascript:void()">灯具参数</a></li> 
                <li id="lampParameter"><a href="<%=request.getContextPath()%>/platform/personQrCodeConf">产品推广</a></li>-->
                <%-- <li id="indexCarousel"><a href="<%=request.getContextPath()%>/platform/welcomePic">首页欢迎图</a>
            	 --%><c:if test="${sessionScope.role==0}">
            		<li id="payQrCode"><a href="<%=request.getContextPath()%>/platform/payQrCode">支付二维码</a>
            	</c:if>
            </ul>
        </li>
        </c:if>
        <li>
            <div class="navItem"><span class="iconfont icon-neirong"></span>其他</div>
            <ul class="subNav">
            	 <li id="indexCarousel"><a href="<%=request.getContextPath()%>/platform/getUserList">客户绑定关系</a></li>
                <li id="commissionParameter"><a href="<%=request.getContextPath()%>/user/toLogin">注册经销商</a></li>
                <%-- <li id="commissionParameter"><a href="<%=request.getContextPath()%>/platform/customerList">注册厂家</a></li>
                 --%><c:if test="${sessionScope.supervisor!='oQO-QwnsaSsL6c0QM8GyXRHzJInI'&&sessionScope.supervisor!='oQO-Qwl2IkZN8-3q_oEArFv7QTMI'}">
               	<li id="indexCarousel"><a href="<%=request.getContextPath()%>/platform/unbundingList">解绑申请</a></li><%-- 
                <li id="indexCarousel"><a href="<%=request.getContextPath()%>/platform/showLogisticsMap">物流园</a></li> --%><%-- 
                <li id="indexCarousel"><a href="<%=request.getContextPath()%>/platform/discountApplicationList">折扣申请</a></li> --%><%-- 
                <li id="indexCarousel"><a href="<%=request.getContextPath()%>/platform/manageDemand">需求</a></li> --%>
                </c:if>
            </ul>
        </li>
    </ul> <!-- 左边导航]] -->

    <div class="col-md-9 col-lg-10 rightContent">
        <!-- [[路径导航 -->
        <ol class="breadcrumb">
          <li id="breadcrumb1"></li>
          <li id="breadcrumb2"></li>
        </ol>
	
	
	<script src="<%=request.getContextPath()%>/resources/common/jquery.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/common/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
	<script src="<%=request.getContextPath() %>/resources/backStage/script/main.js" ></script>

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
