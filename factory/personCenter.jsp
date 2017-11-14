<%@ page language="java" import="java.util.*,com.alphaking.constant.*,com.alphaking.model.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>金明同达灯饰</title>
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1"/>
    <link href="<%=request.getContextPath() %>/resources/factory/assets/css/personCenter.css" rel="stylesheet">
	
</head>
<body class="index">
<c:set var="UNAUTHORIZED" value="<%=UserCheckStatus.UNAUTHORIZED%>" />
<c:set var="AUTHORIZING" value="<%=UserCheckStatus.AUTHORIZING%>" />
<c:set var="AUTHENTICATION_FAILURE" value="<%=UserCheckStatus.AUTHENTICATION_FAILURE%>" /><c:set var="OBLIGATION" value="<%=OrderStatus.OBLIGATION%>" />
<c:set var="TO_BE_SHIPPED" value="<%=OrderStatus.TO_BE_SHIPPED%>" />
<c:set var="TO_BE_SIGNED" value="<%=OrderStatus.TO_BE_SIGNED%>" />
<c:set var="SIGNED" value="<%=OrderStatus.SIGNED%>" />
<c:set var="FINISHED" value="<%=OrderStatus.FINISHED%>" />
<c:set var="CLOSED" value="<%=OrderStatus.CLOSED%>" />

<div class="personCenter">

<!--[[个人中心--会员-->
<div class="person-member">
    <div class="person-msg clearfix">
	    <a href="javascript:history.go(-1);" class="prePage"><i class="iconfont">&#xe624;</i></a>
    	<a href="<%=request.getContextPath()%>/user/accountManage" class="setting"><i class="iconfont">&#xe631;</i></a>
    	<img src="${user.userProtraitPic }" alt=""/>
    	<p><i class="iconfont changjia">&#xe61a;</i>${user.userNickname}</p>
    </div>

    <div class="clearfix link order mOrder">
        <a href="<%=request.getContextPath() %>/factory/orderManage" class="clearfix" style="padding:0.1rem 0">
            <div class="pull-left"><span class="iconSpan" id="color1"><i class="icon iconfont">&#xe622;</i></span>客户订单</div>
            <div class="pull-right"> <i class="iconfont" style="font-size:18px;">&#xe624;</i></div>
        </a>
        <div class="clearfix text-center">
            <div class="widthPer-3 order-type">
                <a href="<%=request.getContextPath() %>/factory/orderManage?orderStatus=${OBLIGATION}">
                    <div class="iconDiv"><i class="icon iconfont big">&#xe613;</i></div>
                    <div>待付款</div>
                    <span class="orderNum" data-status="${OBLIGATION}"></span>
                </a>
            </div>
            <div class="widthPer-3 order-type">
                <a href="<%=request.getContextPath() %>/factory/orderManage?orderStatus=${TO_BE_SHIPPED}">
                    <div class="iconDiv"><i class="icon iconfont">&#xe619;</i></div>
                    <div>待发货</div>
                    <span class="orderNum" data-status="${TO_BE_SHIPPED}"></span>
                </a>
            </div>
            <div class="widthPer-3 order-type">
                <a href="<%=request.getContextPath() %>/factory/orderManage?orderStatus=${TO_BE_SIGNED}">
                    <div class="iconDiv"><i class="icon iconfont small">&#xe616;</i></div>
                    <div>待收货</div>
                    <span class="orderNum" data-status="${TO_BE_SIGNED}"></span>
                </a>
            </div>
            <div class="widthPer-3 order-type">
                <a href="<%=request.getContextPath()%>/factory/returnOrderManage">
                    <div class="iconDiv"><i class="icon iconfont big">&#xe61c;</i></div>
                    <div>退款/货</div>
                    <span class="orderNum" data-status="return"></span>
                </a>
            </div>
        </div>
    </div>
    <!-- <div class="clearfix link">
        <a href="javascript:void()" class="clearfix">
            <div class="pull-left"><i class="icon iconfont purple">&#xe618; </i>灯位管理</div>
            <div class="pull-right"> <i class="iconfont" style="font-size:18px;">&#xe624;</i></div>
        </a>
    </div> -->
<%--     <div class="clearfix link ">
        <a href="<%=request.getContextPath() %>/factory/lampManage" class="clearfix">
            <div class="pull-left"><i class="icon iconfont purple">&#xe618; </i>灯位管理</div>
            <div class="pull-right"> <i class="iconfont" style="font-size:18px;">&#xe624;</i></div>
        </a>
    </div> 
 
     <div class="clearfix link order">
        <a href="javascript:sessionStorage.status=0;javascript:window.location.href='<%=request.getContextPath() %>/factory/lampManage'" class="clearfix" style="padding:0.1rem 0">
            <div class="pull-left"><span class="iconSpan" id="color2"><i class="icon iconfont big">&#xe623;</i></span>灯位管理</div>
            <div class="pull-right"> <i class="iconfont" style="font-size:18px;">&#xe624;</i></div>
        </a>
        <div class="clearfix text-center">
            <div class="widthPer-3 order-type">
                <a href="javascript:sessionStorage.status=0;javascript:window.location.href='<%=request.getContextPath() %>/factory/lampManage'">
                    <div class="iconDiv"><i class="icon iconfont big">&#xe669;</i></div>
                    <div>新灯位</div>
                </a>
            </div>
            <div class="widthPer-3 order-type">
                <a href="javascript:sessionStorage.status=1;javascript:window.location.href='<%=request.getContextPath() %>/factory/lampManage'">
                    <div class="iconDiv"><i class="icon iconfont">&#xe667;</i></div>
                    <div>可上线</div>
                </a>
            </div>
            <div class="widthPer-3 order-type">
                <a href="javascript:sessionStorage.status=2;javascript:window.location.href='<%=request.getContextPath() %>/factory/lampManage'">
                    <div class="iconDiv"><i class="icon iconfont big">&#xe668;</i></div>
                    <div>已上线</div>
                </a>
            </div>
            <div class="widthPer-3 order-type">
                <a href="javascript:sessionStorage.status=3;javascript:window.location.href='<%=request.getContextPath() %>/factory/lampManage'">
                    <div class="iconDiv"><i class="icon iconfont small">&#xe666;</i></div>
                    <div>待续费</div>
                </a>
            </div>
        </div>
    </div>   --%>
    
    <div class="clearfix link">
        <a href="<%=request.getContextPath() %>/factory/newOrderStation?orderStockStatus=1" class="clearfix">
            <div class="pull-left"><span class="iconSpan" id="color6"><i class="icon iconfont">&#xe622;</i></span>订单管理</div>
            <div class="pull-right"> <i class="iconfont" style="font-size:18px;">&#xe624;</i></div>
        </a>
    </div>
    <%-- <div class="clearfix ">
        <a href="<%=request.getContextPath() %>/factory/productList" class="clearfix">
            <div class="pull-left"><span class="iconSpan" id="color6"><i class="icon iconfont">&#xe605;</i></span>库存管理</div>
            <div class="pull-right"> <i class="iconfont" style="font-size:18px;">&#xe624;</i></div>
        </a>
    </div>  --%>
    <div class="clearfix ">
        <a href="<%=request.getContextPath() %>/factory/toAddAddress" class="clearfix">
            <div class="pull-left"><span class="iconSpan" id="color3"><i class="icon iconfont big">&#xe639;</i></span>退货地址</div>
            <div class="pull-right"> <i class="iconfont" style="font-size:18px;">&#xe624;</i></div>
        </a>
    </div>
    <div class="clearfix ">
        <a href="<%=request.getContextPath() %>/factory/wallet" class="clearfix">
            <div class="pull-left"><span class="iconSpan" id="color4"><i class="icon iconfont">&#xe618;</i></span>我的钱包</div>
            <div class="pull-right"> <i class="iconfont" style="font-size:18px;">&#xe624;</i></div>
        </a>
    </div>
    <%--<div class="clearfix ">
	        <a href="<%=request.getContextPath()%>/factory/spreadUserList" class="clearfix">
	            <div class="pull-left"><span class="iconSpan" id="color5"><i class="icon iconfont">&#xe61b;</i></span>客户列表</div>
	            <div class="pull-right"><i class="iconfont" style="font-size:18px;">&#xe624;</i></div>
	        </a>
	    </div>--%>
    <div class="clearfix ">
        <a href="<%=request.getContextPath() %>/user/serviceAndFeedback" class="clearfix">
            <div class="pull-left"><span class="iconSpan" id="color6"><i class="icon iconfont">&#xe61f;</i></span>服务与反馈</div>
            <div class="pull-right"> <i class="iconfont" style="font-size:18px;">&#xe624;</i></div>
        </a>
    </div>
    <c:if test="${user.role!=CUSTOMER && !empty user}">
    <div class="clearfix ">
         <a href="<%=request.getContextPath() %>/factory/toAuthentication" class="clearfix">
            <div class="pull-left"><span class="iconSpan" id="color7"><i class="icon iconfont">&#xe61e;</i></span>身份认证(
				<c:choose>
					<c:when test="${application.checkStatus==AUTHORIZING }">信息审核中</c:when>
					<c:otherwise>认证成功</c:otherwise>
				</c:choose>)
            </div>
            <div class="pull-right"> <i class="iconfont" style="font-size:18px;">&#xe624;</i></div>
        </a>
    </div>
    </c:if>
    <div class="clearfix ">
        <a href="<%=request.getContextPath() %>/factory/toSetPassword" class="clearfix">
            <div class="pull-left"><span class="iconSpan" id="color6"><i class="icon iconfont">&#xe602;</i></span>设置密码</div>
            <div class="pull-right"> <i class="iconfont" style="font-size:18px;">&#xe624;</i></div>
        </a>
    </div>
    <c:if test="${sessionScope.supervisor=='oQO-QwhvfrO7w8I4OGnp2299MHpw'}">
    	<div class="clearfix ">
	        <a href="<%=request.getContextPath() %>/buyer/toPlatform" class="clearfix">
	            <div class="pull-left"><span class="iconSpan" id="color6"><i class="icon iconfont">&#xe62d;</i></span>后台</div>
	            <div class="pull-right"><i class="iconfont" style="font-size:18px;">&#xe624;</i></div>
	        </a>
	    </div>
    </c:if>
</div>
<!--个人中心--会员]]-->
</div>
<!--[[通用尾部-->
<jsp:include page="/jsp/factory/footer.jsp"></jsp:include>

</body>
<script>
	$(".mOrder .orderNum").each(function(){
		loadOrderNum($(this));
	});

	function loadOrderNum($obj){
		var status=$obj.attr("data-status");
		var url="";
		if(status=="return")
			url="<%=request.getContextPath()%>/user/countReturnNum?isBuyer=false";
		else
			url="<%=request.getContextPath()%>/user/countOrderNum?orderStatus="+status
				+"&isBuyer=false";
		$.ajax({
			type: "get",
			url: url,
			success:function(data) {
				if(data.data>0){
	   		 		$obj.html(data.data);
					$obj.show();
				}
	   		},
	  		error: function(data) {      			
	  		
	  		}
		});
}
</script>
</html>
