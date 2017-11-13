<%@ page language="java" import="java.util.*,com.alphaking.constant.*,com.alphaking.model.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="cn">
<meta name="viewport"
      content="width=device-width,height=device-height, user-scalable=no,initial-scale=1, minimum-scale=1, maximum-scale=1">

<head>
    <meta charset="UTF-8">
    <title>佐为照明</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/customer/assets/css/fung.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/customer/assets/css/m_menu.css">
    <style type="text/css">

        .block {
            padding: 0;
        }

        .blocktitle {
            text-align: left;
            font-size: 1.2rem;
            color: #f07a00;
            padding: 0.3rem;
            vertical-align: middle;
            margin-bottom: 0;
        }

        .block_box {
            width: 100%;
            display: flex;
        }

        .block_box_sub {
            padding: 0.5rem 0;
            border-right: 2px #eee solid;
            border-top: 2px #eee solid;
            width: 25%;
            text-align: center;
            position: relative;
        }

        .block_img_div {
            width: 30%;
            margin: 0.5rem auto;
            text-align: center;
        }

        .block_img_div img {
            width: auto;
            height: auto;
            max-width: 100%;
            max-height: 100%;
            vertical-align: middle;
        }

        .corner_number {
            display: none;
            font-size: 0.8rem;
            background-color: red;
            color: #fff;
            border: 1px #fff solid;
            height: 1rem;
            line-height: 1rem;
            padding-left: 0.4rem;
            padding-right: 0.4rem;
            border-radius: 1rem;
            position: absolute;
            top: 0;
            right: 0;
        }

        .box_smallfont {
            font-size: 0.8rem;
        }

        .bgc_orange {
            background-color: #eb9c01;
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
<c:set var="AGENT" value="<%=UserType.AGENT %>"/>
<c:set var="RETAIL_SALES" value="<%=UserType.RETAIL_SALES %>"/>
<c:set var="UNAUTHORIZED" value="<%=UserCheckStatus.UNAUTHORIZED%>" />
<c:set var="AUTHORIZING" value="<%=UserCheckStatus.AUTHORIZING%>" />
<c:set var="AUTHENTICATION_FAILURE" value="<%=UserCheckStatus.AUTHENTICATION_FAILURE%>" />
<c:set var="AUTHENTICATION_SUCCESS" value="<%=UserCheckStatus.AUTHENTICATION_SUCCESS%>" />
<c:set var="OBLIGATION" value="<%=OrderStatus.OBLIGATION%>" />
<c:set var="TO_BE_SHIPPED" value="<%=OrderStatus.TO_BE_SHIPPED%>" />
<c:set var="TO_BE_SIGNED" value="<%=OrderStatus.TO_BE_SIGNED%>" />
<c:set var="SIGNED" value="<%=OrderStatus.SIGNED%>" />
<c:set var="FINISHED" value="<%=OrderStatus.FINISHED%>" />
<c:set var="CLOSED" value="<%=OrderStatus.CLOSED%>" />
<div class="m_menu">

    <img class="background" src="<%=request.getContextPath()%>/resources/customer/assets/images/personal_center/pc_bg.jpg">

    <div class="navibar">
        <img src="<%=request.getContextPath()%>/resources/customer/assets/images/top_bar/back_white.png" alt="" class="topbar_button prevPage">
        <img src="<%=request.getContextPath()%>/resources/customer/assets/images/top_bar/setting_white.png" style="float: right;" class="topbar_button"
             onclick="showPersonalSetting()">
    </div>
    <img class="usericon" src="${user.userProtraitPic }" alt="">
    <div class="username">${user.userNickname }</div>
    <!-- <div class="user_menu">

        <div class="user_menu_sub">
            <div>¥ 0</div>
            <div>账户余额</div>
        </div>

        <div class="user_menu_sub user_menu_sub_center">
            <div>4850</div>
            <div>会员积分</div>
        </div>

        <div class="user_menu_sub">
            <div>2</div>
            <div>&nbsp优惠券&nbsp</div>
        </div>

    </div> -->

</div>

<div class="block myOrder">
    <div class="blocktitle">我的订单</div>
    <div class="block_box">
        <div class="block_box_sub" onclick='window.location.href="<%=request.getContextPath()%>/buyer/orderManage?orderStatus=${OBLIGATION}"'>
            <div class="block_img_div" style="width: 25%">
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/user/0.png">
            </div>
            <span>待付款</span>
            <span class="corner_number" data-status="${OBLIGATION}"></span>
        </div>
        <div class="block_box_sub" onclick='window.location.href="<%=request.getContextPath()%>/buyer/orderManage?orderStatus=${TO_BE_SHIPPED}"'>
            <div class="block_img_div">
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/user/1.png">
            </div>
            <span>待发货</span>
            <span class="corner_number" data-status="${TO_BE_SHIPPED}"></span>
        </div>
        <div class="block_box_sub" onclick='window.location.href="<%=request.getContextPath()%>/buyer/orderManage?orderStatus=${TO_BE_SIGNED}"'>
            <div class="block_img_div">
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/user/2.png">
            </div>
            <span>待收货</span>
            <span class="corner_number" data-status="${TO_BE_SIGNED}"></span> 
        </div>
        <div class="block_box_sub" style="border-right: 0;" onclick='window.location.href="<%=request.getContextPath()%>/buyer/returnOrderManage"'>
            <div class="block_img_div">
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/user/3.png">
            </div>
            <span>退款/退货</span>
            <span class="corner_number" data-status="return"></span> 
        </div>

    </div>
</div>
<c:if test="${(user.role==SALESMAN||user.role==AGENCY)&&user.checkStatus== AUTHENTICATION_SUCCESS}">
<div class="block lowUserOrder">
    <div class="blocktitle">客户订单</div>
    <div class="block_box">
        <div class="block_box_sub" onclick='window.location.href="<%=request.getContextPath()%>/buyer/lowUserOrderList?orderStatus=${OBLIGATION}"'>
            <div class="block_img_div" style="width: 25%">
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/user/0.png">
            </div>
            <span>待付款</span>
            <span class="corner_number" data-status="${OBLIGATION}"></span> 
        </div>
        <div class="block_box_sub" onclick='window.location.href="<%=request.getContextPath() %>/buyer/lowUserOrderList?orderStatus=${TO_BE_SHIPPED}"'>
            <div class="block_img_div">
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/user/1.png">
            </div>
            <span>待发货</span>
            <span class="corner_number" data-status="${TO_BE_SHIPPED}"></span> 
        </div>
        <div class="block_box_sub" onclick='window.location.href="<%=request.getContextPath() %>/buyer/lowUserOrderList?orderStatus=${TO_BE_SIGNED}"'>
            <div class="block_img_div">
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/user/2.png">
            </div>
            <span>待收货</span>
            <span class="corner_number" data-status="${TO_BE_SIGNED}"></span> 
        </div>
        <div class="block_box_sub" style="border-right: 0;" onclick='window.location.href="<%=request.getContextPath()%>/buyer/lowUserReturnOrderList"'>
            <div class="block_img_div">
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/user/3.png">
            </div>
            <span>退款/退货</span>
            <span class="corner_number" data-status="return"></span> 
        </div>
    </div>
</div>
</c:if>

<div class="block">
    <div class="blocktitle">其他功能</div>
    <div class="block_box">
        <div class="block_box_sub" onclick="window.location.href='<%=request.getContextPath() %>/buyer/manageReceiveAddress'">
            <div class="block_img_div" style="width: 25%">
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/user/00.png">
            </div>
            <span class="box_smallfont">地址管理</span>
        </div>
        <div class="block_box_sub" onclick="window.location.href='<%=request.getContextPath() %>/buyer/wallet'">
            <div class="block_img_div">
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/user/01.png">
            </div>
            <span class="box_smallfont">我的钱包</span>
        </div>
        <div class="block_box_sub" onclick="window.location.href='<%=request.getContextPath() %>/buyer/afterSaleList'">
            <div class="block_img_div">
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/user/02.png">
            </div>
            <span class="box_smallfont">售后列表</span>
            <span class="corner_number">20</span>
        </div>
        <div class="block_box_sub" style="border-right: 0;" onclick="window.location.href='<%=request.getContextPath()%>/user/serviceAndFeedback'">
            <div class="block_img_div">
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/personal_center/feedback.png">
            </div>
            <span class="box_smallfont">服务反馈</span>
            <span class="corner_number">1</span>
        </div>
        
    </div>
    
    <c:if test="${(user.role==SALESMAN||user.role==AGENCY)&&user.checkStatus== AUTHENTICATION_SUCCESS}">
    <div class="block_box">
    	<div class="block_box_sub"  onclick="window.location.href='<%=request.getContextPath()%>/information/clientList'">
            <div class="block_img_div">
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/user/03.png">
            </div>
            <span class="box_smallfont">客户列表</span>
            <span class="corner_number">13</span>
        </div>
        <div class="block_box_sub"  onclick="window.location.href='<%=request.getContextPath()%>/information/informationList'">
            <div class="block_img_div" style="width: 25%">
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/user/04.png">
            </div>
            <span class="box_smallfont">客户消息</span>
            <span class="corner_number">1</span>
        </div>
        <div class="block_box_sub" style="border-right-color: #fafafa;"></div>
        <div class="block_box_sub" style="border-right: 0;"></div>
     </div>
     </c:if>
</div>

<c:if test="${!empty user.manageRole}">
<div class="block">
    <div class="blocktitle">其他功能</div>
    <div class="block_box">
    	<div class="block_box_sub" onclick="window.location.href='<%=request.getContextPath() %>/buyer/orderSendLogisticsCompany'">
            <div class="block_img_div">
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/user/1.png">
            </div>
            <span class="box_smallfont">今日待发</span>
            <span class="corner_number">20</span>
        </div>
	   	<div class="block_box_sub" onclick="window.location.href='<%=request.getContextPath() %>/buyer/prepareReceiveFactory'">
           <div class="block_img_div">
               <img src="<%=request.getContextPath()%>/resources/customer/assets/images/user/2.png">
           </div>
           <span class="box_smallfont">待收货</span>
           <span class="corner_number">20</span>
	    </div>
	   	<div class="block_box_sub" onclick="window.location.href='<%=request.getContextPath() %>/buyer/receiveFactory'">
           <div class="block_img_div">
               <img src="<%=request.getContextPath()%>/resources/customer/assets/images/personal_center/received.png">
           </div>
           <span class="box_smallfont">已收货</span>
           <span class="corner_number">20</span>
	    </div>
	</div>
</div>
</c:if>
<div style="margin-bottom:2.4rem";>
</div>

<script type="text/javascript">

    var imgBox = document.getElementsByClassName('block_img_div');
    for (var i = 0; i < imgBox.length; i++) {
        imgBox[i].style.height = imgBox[1].offsetWidth + 'px';
        imgBox[i].style.lineHeight = imgBox[1].offsetWidth + 'px';
    }

</script>

<div class="page" id="personal_setting" hidden>

    <div class="navibar bgc_orange">
        <img src="<%=request.getContextPath()%>/resources/customer/assets/images/top_bar/back_white.png" alt="" class="topbar_button" onclick="hidePersonalSetting()">
    </div>

    <div class="menu_line" style="height: 6rem; line-height: 6rem" onclick="viewIcon()">
        <span>会员头像</span>
        <div class="menu_content">
            <img src="${user.userProtraitPic}" class="inner_usericon" style=" border-color: lightgray;">
        </div>
        <img src="<%=request.getContextPath()%>/resources/customer/assets/images/user/to.png" style="margin: 2.5rem 0.5rem;" class="change_img">
    </div>
    <div class="menu_line">
        <span>会员昵称</span>
        <div class="menu_content">
            ${user.userNickname }
        </div>
        <div class="change_img"></div>
    </div>
    <div style="height: 0.5rem"></div>
    <div class="menu_line">
        <span>姓名</span>
        <div class="menu_content">
            ${user.legalPersonName}
        </div>
        <div class="change_img"></div>
    </div>
    <div class="menu_line">
        <span>联系电话</span>
        <div class="menu_content">
            ${user.phoneNumber }
        </div>
        <div class="change_img"></div>
    </div>
    <div class="menu_line" onclick="changeQNumber()">
        <span>QQ号</span>
        <div class="menu_content" id="qqNumber">
            ${user.qqNumber }
        </div>
        <img src="<%=request.getContextPath()%>/resources/customer/assets/images/user/to.png" class="change_img">
    </div>
    <div class="menu_line" onclick="changeWeChatNumber()">
        <span>微信号</span>
        <div class="menu_content" id="wechatNumber">
            ${user.wechatNumber }
        </div>
        <img src="<%=request.getContextPath()%>/resources/customer/assets/images/user/to.png" class="change_img">
    </div>
    <div class="menu_line" onclick="viewQRCode()">
        <span>我的二维码</span>
        <div class="menu_content">
            点击查看二维码
        </div>
        <img src="<%=request.getContextPath()%>/resources/customer/assets/images/user/to.png" class="change_img">
    </div>

    <div class="placeholder"></div>

</div>
<jsp:include page="/jsp/buyer/footer.jsp"></jsp:include>
<script type="text/javascript">
	$(".myOrder .corner_number").each(function(){
		loadOrderNum($(this));
	});

	$(".lowUserOrder .corner_number").each(function(){
		loadLowUserOrderNum($(this));
	});
	function loadOrderNum($obj){
		var status=$obj.attr("data-status");
		var url="";
		if(status=="return")
			url="<%=request.getContextPath()%>/user/countReturnNum?isBuyer=true";
		else
			url="<%=request.getContextPath()%>/user/countOrderNum?orderStatus="+status
				+"&isBuyer=true";
		$.ajax({
			type: "get",
			url: url,
			success:function(data) {
				if(data.data>0){
	   		 		$obj.html(data.data);
					$obj.show();
					$obj.next().show();
				}
	   		},
	  		error: function(data) {      			
	  		
	  		}
		});
	}
	
	function loadLowUserOrderNum($obj){
		var status=$obj.attr("data-status");
		var url="";
		if(status=="return")
			url="<%=request.getContextPath()%>/user/countLowUserListReturnNum";
		else
			url="<%=request.getContextPath()%>/user/countLowUserOrderNum?orderStatus="+status;
		$.ajax({
			type: "get",
			url: url,
			success:function(data) {
				if(data.data>0){
	   		 		$obj.html(data.data);
					$obj.show();
					$obj.next().show();
				}
	   		},
	  		error: function(data) {      			
	  		
	  		}
		});
	}
	
    var personalSetting = document.getElementById('personal_setting');

    function showPersonalSetting() {
        personalSetting.hidden = false;
    }

    function hidePersonalSetting() {
        personalSetting.hidden = true;
    }

    function viewIcon() {
        /*微信接口查看头像*/
        WeixinJSBridge.invoke("imagePreview",{
            "urls":[
           		"${user.userProtraitPic}"
            	],
            "current":"${user.userProtraitPic}"
         })
    }

    function viewQRCode() {
        /*微信接口查看二维码*/

        WeixinJSBridge.invoke("imagePreview",{
            "urls":[
           		"${user.spreadQrCodePic}"
            	],
            "current":"${user.spreadQrCodePic}"
         })
    }

    function changeQNumber() {
        var QNumber = prompt("请输入QQ号:");
        if (QNumber!=null){
            if (QNumber.length < 5) {
                alert("输入长度不正确!请重新输入");
                changeQNumber();
            } else {
                if (isNaN(QNumber)) {
                    alert("输入了非数字字符!请重新输入");
                    changeQNumber();
                } else {
                    /* a j a x 请 求*/
					toChangeQqNumber(QNumber);
                }
            }
        }

    }

    function changeWeChatNumber() {
        var wcNumber = prompt("请输入微信号:");
        if (wcNumber!=null){
            if (wcNumber.length > 20 || wcNumber < 6) {
                alert("您输入的微信号不正确！")
            } else {

                /* a j a x 请 求*/
				toChangeWechatNumber(wcNumber);

            }
        }

    }
    
    function toChangeQqNumber(qqNumber){
    	var url = "<%=request.getContextPath()%>/buyer/changeUserQqNumber";
    	var params={qqNumber:qqNumber};
    	doAjax("GET",url,params,function(data){
            alert("您的QQ号成功改为：" + qqNumber);
            $("#qqNumber").html(qqNumber);
            },function(data){console.log("fail");},true,false)
    }
    
    function toChangeWechatNumber(wechatNumber){
    	var url = "<%=request.getContextPath()%>/buyer/changeUserWechatNumber";
    	var params={wechatNumber:wechatNumber};
    	doAjax("GET",url,params,function(data){
            alert("您的微信号成功改为：" + wechatNumber);
            $("#wechatNumber").html(wechatNumber);},function(data){console.log("fail");},true,false)
    }
    
    $(".prevPage").click(function(){
    	if(personalSetting.hidden){
    		history.go(-1);
    	}else{
    		personalSetting.hidden = true;
    	}
    });

</script>

</body>
</html>