<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>佐为照明</title>
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1"/>
    <meta name="format-detection" content="telephone=no">
 	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/factory/assets/css/capital.css"/>
</head>
<body class="index">
<div class="wallet widthdraw">
    <div class="title">
    	<i class="iconfont back">&#xe624;</i>
    	提现
    </div>
	
	<div class="wrap">
	<form action="<%=request.getContextPath()%>/factory/withdraw" id="withForm">
		<div class="widthdrawWechat">
	 		<div class="drawMoney">
				<span class="spanTitle">提现金额</span>
				<div class="moneyInput">
					<span>￥</span>
					<input autofocus type="text" name="money" oninput="changeWithdraw()"/>
				</div>
				<span>当前可支配金额${user.flowMoney}元，<a href="javascript:putAll()">全部提现</a></span>
			</div>
			<div class="minusMoney">
				<span class="spanTitle">手续费</span>
				<span id="money">0元</span>
				<span>提现需要交<font>0.6%</font>的手续费给微信</span>
			</div> 
		</div>
		
		
		<div class="drawInfo">
			<div class="formDiv">
				<span>开户人</span>
				<input type="text" name="accountPerson" value="${userBank.userBankPerson }"/>
			</div>
			<div class="formDiv">
				<span>开户账号</span>
				<input type="text" name="account" placeholder="请输入工商银行卡卡号" value="${userBank.userBankAccount }"/>
			</div>
			<div class="formDiv">
				<span>开户省</span>
				<select onchange="queryCity(this.value)" name="accountProvince">
					<option>--请选择--</option>
					<c:forEach items="${provinceList }" var="province">
						<option value="${province.addressId }" <c:if test="${province.addressId==userBank.userBankProvinceId}">selected</c:if>>${province.addressName }</option>
					</c:forEach>
				</select>
			</div>
			<div class="formDiv">
				<span>开户市</span>
				<select id="city" name="accountCity">
					<option>--请选择--</option>
				</select>
			</div>
			<div class="formDiv">
				<span>开户银行</span>
				<input type="text" name="accountBank" value="中国工商银行" readonly="readonly" style="color:#999" value="${userBank.userBankName }"/>
			</div>
			<div class="formDiv">
				<span>开户支行</span>
				<input type="text" name="accountBankSubName" value="${userBank.userBankSubName }"/>
			</div>
			<div class="formDiv">
				<span>联系人</span>
				<input type="text" name="contactPerson" value="${userBank.userContactPerson }"/>
			</div>
			<div class="formDiv">
				<span>联系方式</span>
				<input type="text" name="contactWay" value="${userBank.userContact }"/>
			</div>
		</div>
		<p class="time">后天24点前到账</p>
		<button class="toWithdraw" type="button">提　现</button>
	</form>
	</div>
	
	<div class="widthdrawWechat authCode">
		<p>我们已经发送了验证码到你的手机号码：</p>
		<p>${user.phoneNumber}</p>
		<input autofocus class="code" type="tel"/>
		<span class="restSpan"><span id="rest">60</span>秒后重发验证码</span>
		<button id="sureBtn">确　定</button>
	</div>
	<div class="tip"></div>
</div>
<!-- 开始确认框 -->
<div class="confirmDiv" id="delete">
	<div class="confirmTop">
		<span>温馨提醒</span>
		<span id="closeConfirm"><i class="iconfont">&#xe632;</i></span>
	</div>
	<p>您的提现申请已交由管理员审核，预计后天24点前到账。</p>
	<div class="confirmBottom">
		<span id="cancel">取消</span>
		<span id="confirm">确定</span>
	</div>
</div>
<div class="shade"></div>
<!--提现明细--非会员]]-->

<!--[[通用尾部-->

<%-- <jsp:include page="/jsp/factory/footer.jsp"></jsp:include> --%>
<!--通用尾部]]-->

<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
</body>
<script>
	function checkMoney(){
		if(checkForm()){
			var withdrawMoney=$("input[name='money']").val();
			if((parseFloat(withdrawMoney)-parseFloat(withdrawMoney)*0.006)<=1){
				showTip("提现金额必须大于一元");
			}else{
				if(withdrawMoney>${user.flowMoney}){
					showTip("提现金额不能超过可支配金额");
					return false;
				}else{
					return true;
				}
			}
		}else
			return false;
	}
	
	
	function toWithdraw(){
		var url="<%=request.getContextPath()%>/factory/withdraw";
		var params=$("#withForm").serialize();
		doAjax("GET",url,params,withdrawSuccess,fail,true,false);
	}
	
	$(".toWithdraw").tap(function(){
		if(checkMoney()){
			toWithdraw();
		}
	});
	
	function withdrawSuccess(data){
		$("#delete").show();
		$(".shade").show();
	}
	
	$("#cancel,#confirm").tap(function(){
		window.location.href="<%=request.getContextPath()%>/factory/tradeList?settlementStatus=0&capitalFlowType=4";
	});
	
	queryCity("${userBank.userBankProvinceId}");
	function queryCity(addressId){
		var url="<%=request.getContextPath()%>/address/queryAddress";
		var params={upAddressId:addressId};
		doAjax("GET",url,params,queryCitySuccess,fail,false,false);
	}
	
	var cityId="${userBank.userBankCityId}";
	function queryCitySuccess(data){
		var option="";
		for(var i=0;i<data.length;i++){
			option+="<option value='"+data[i].addressId+"' '+(cityId==data[i].addressId?'selected':'')+'>"+data[i].addressName+"</option>";
		}
		$("#city").html(option);
	}
	
	function fail(data){
		alert("fail");
	}
	
	function changeWithdraw(){
		var money = $("input[name='money']").val();
		if(!isNaN(money)&&money!=""){
			money = (parseFloat(money)*0.006).toFixed(2);
			$("#money").html(money+"元");
		}else{
			$("#money").html("0元");
		}
	}
	
	function putAll(){
		$("input[name='money']").val(${user.flowMoney});
		changeWithdraw();
	}
	
	var restS=setInterval("testS()",1000);//1000为1秒钟
	function testS(){
		var r=parseInt($("#rest").html());
		if(r>0){
			$("#rest").html(r-1);
		}else{
			$(".restSpan").css("color","#3879D9");
			$(".restSpan").html("点击重新发送验证码");
		}
	}
	$(".restSpan").tap(function(){
		if($(".restSpan").html()=="点击重新发送验证码"){
			//ajax重新发送验证码
			sendCode();
			$(".restSpan").css("color","#ccc");
			$(".restSpan").html("<span id='rest'>60</span>秒后重发验证码");
		}
	});
	
	var code="";
	$("#sureBtn").tap(function(){
		checkCode();
	});
	
	$(function(){
		sendCode();
	});
	
	function sendCode(){
		var url="<%=request.getContextPath()%>/sms/generatePhoneCode";
		var params={phoneNumber:${user.phoneNumber}};
		doAjax("GET",url,params,success,fail,true,false);
	}
	
	function success(data){
	}
	
	function fail(data){
	}
	
	function checkCode(){
		var url="<%=request.getContextPath()%>/sms/checkPhoneCode";
		var params={phoneNum:${user.phoneNumber},phoneCode:$(".code").val()};
		doAjax("GET",url,params,checkSuccess,fail,false,false);
	}
	
	function checkSuccess(data){
		if(data.data){
			clearInterval(restS);
			$(".authCode").hide();
			$(".wrap").show();
		}else{
			$(".tip").html("验证码输入错误！");
			$(".tip").css("opacity","0.8");
			addTime=setTimeout(function(){
				$(".tip").css("opacity","0");
				$(".tip").html("");
			},1000);
		}
	}
	
	function showTip(content){
		$(".tip").html(content);
		$(".tip").css("opacity","0.8");
		setTimeout(function(){
			$(".tip").css("opacity","0");
		},1000);
	}
	
	$(".back").tap(function(){
		history.go(-1);
	});
	
	function checkForm(){
		if($("input[name='accountPerson']").val().trim()==""){
			showTip("请输入开户人");
			return false;
		}
		if($("input[name='account']").val().trim()==""){
			showTip("请输入开户人");
			return false;
		}
		if($("select[name='accountProvince']").val().trim()=="--请选择--"){
			showTip("请输入开户省");
			return false;
		}
		if($("select[name='accountCity']").val().trim()=="--请选择--"){
			showTip("请输入开户市");
			return false;
		}
		if($("input[name='accountBank']").val().trim()==""){
			showTip("请输入开户银行");
			return false;
		}
		if($("input[name='accountBankSubName']").val().trim()==""){
			showTip("请输入开户支行");
			return false;
		}
		if($("input[name='contactPerson']").val().trim()==""){
			showTip("请输入联系人");
			return false;
		}
		if($("input[name='contactWay']").val().trim()==""){
			showTip("请输入联系方式");
			return false;
		}
		return true;
	}
</script>
</html>