<%@ page language="java" import="java.util.*,com.alphaking.constant.*,com.alphaking.model.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>灯饰网</title>
    <link href="<%=request.getContextPath() %>/resources/common/bootstrap.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/common/swiper.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/factory/assets/css/personCenter.css" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/common/jquery.min.js"></script>
    <script src="<%=request.getContextPath() %>/resources/factory/assets/js/nextpage.js"></script>
</head>
<body>
<div class="lampManage">
    <div class="title">灯位管理</div>
	<input type="hidden" id="path" value="<%=request.getContextPath()%>"/>
    <div class="orderType">
        <div class="span-content">
            <span class="type">新灯位</span>
            <span class="type">可上线</span>
            <span class="type">已上线</span>
            <span class="type">待续费</span>
            <span class="type">已下架</span>

        </div>

    </div>

    <!-- [[待付定-->
    <!--<div class="book">
        <div class="bookNum">租赁编号：jr4l3ij54l3j4l</div>
        <div class="line clearfix">
            <div class="pull-left left">灯位ID：2j43lj5o4j3l45j</div>
            <div class="pull-left right">租用期限：3个月</div>
        </div>
        <div class="line clearfix">
            <div class="pull-left left">定金：￥1314.20</div>
        </div>
        <div class="line clearfix">
            <div class="pull-left left">选购时间：2012-02-02</div>
            <div class="pull-left right">付定时间：2012-02-02</div>
        </div>
        <div class="line clearfix">
            <div class="pull-left left">付款时间：2012-02-02</div>
            <div class="pull-left right">审核时间：2012-02-02</div>
        </div>
        <div class="line clearfix">
            <div class="pull-left left">上线时间：2012-02-02</div>
            <div class="pull-left right">下架时间：2012-02-02</div>
        </div>
        <div class="line clearfix text-center">
            <button class="btn btn-primary">去预定</button>
        </div>
    </div>-->
    
    <!--update 5.28 start-->
    <!--<div class="book">
		<div class="line clearfix width-12">
		<div class="line clearfix  width-6">
		<div class="bookNum"><span>租赁编号：</span>jr4l3ij54l3j4l</div>
    	<div class="line clearfix"><span>灯&nbsp;&nbsp;位&nbsp;&nbsp;ID：</span>123</div>
    	<div class="line clearfix"><span>灯位状态：</span>租赁中</div>
    	<div class="line clearfix"><span>租&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;期：</span>2个月</div>
    	<div class="line clearfix"><span>上线时间：</span>- - -</div>
		</div>
		<div class="line clearfix  width-3">
		<img src="../../customer/assets/images/buyer.jpg" style="width: 100%;" />
		</div>
		</div>		
    	<div class="line clearfix more width-12"><span>查看详情</span><button class="btn btn-warning" value="">操作</button> <button class="btn btn-warning" value="">操作</button> </div>
    </div>-->
<!--    
        <div class="book">
    	<div class="bookNum"><span>租赁编号：</span>jr4l3ij54l3j4l</div>
    	<div class="line clearfix"><span>灯&nbsp;&nbsp;位&nbsp;&nbsp;ID：</span>123</div>
    	<div class="line clearfix"><span>灯位状态：</span>租赁中</div>
    	<div class="line clearfix"><span>租&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;期：</span>2个月</div>
    	<div class="line clearfix"><span>上线时间：</span>- - -</div>
    	<div class="line clearfix more"><span>查看详情</span><button class="btn btn-warning" value="">操作</button> <button class="btn btn-warning" value="">操作</button> </div>
    </div>
 
         <div class="book">
    	<div class="bookNum"><span>租赁编号：</span>jr4l3ij54l3j4l</div>
    	<div class="line clearfix"><span>灯&nbsp;&nbsp;位&nbsp;&nbsp;ID：</span>123</div>
    	<div class="line clearfix"><span>灯位状态：</span>租赁中</div>
    	<div class="line clearfix"><span>租&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;期：</span>2个月</div>
    	<div class="line clearfix"><span>上线时间：</span>- - -</div>
    	<div class="line clearfix more"><span>查看详情</span><button class="btn btn-warning" value="">操作</button> <button class="btn btn-warning" value="">操作</button> </div>
    </div>
    -->
    <!--update 5.28 end-->
    <!-- 待付定]]-->
    <!-- [[待付款-->
    <!-- 待付款]]-->
    <!-- [[待审核-->
    <!-- 待审核]]-->
    <!-- [[审核不过-->
    <!-- 审核不过]]-->
    <!-- [[审核通过-->
    <!-- 审核通过]]-->
    <!-- [[上线中-->
    <!-- 上线中]]-->
    <!-- [[已关闭-->
    <!-- 已关闭]]-->
    <div class="booklist">
    	
    </div>
    <!-- [[分页-->
    <a class="pagenage" style="display: none;" data-code="">
    </a>
    <!-- 分页]]-->
    <div class="loading"><img src="<%=request.getContextPath() %>/resources/factory/assets/images/loading.gif">加载中</div>
    <input type="hidden" id="path" value="<%=request.getContextPath() %>"/>
</div>
<!--[[底部-->
<jsp:include page="/jsp/factory/footer.jsp"></jsp:include>
<!--底部]]-->
</body>
</html>