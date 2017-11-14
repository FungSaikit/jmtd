<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <meta charset="UTF-8">
    <title>金明同达灯饰</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/customer/assets/css/topbar_orange.css">

    <style type="text/css">

        body {
            background-color: #f4f4f4;
        }

        table {
            border-collapse: collapse;
        }

        .placeholder {
            height: 3rem;
        }

        .title {
            background-color: #fff;
            margin-top: 0.5rem;
            width: 100%;
            height: 2rem;
        }

        .title td {
            line-height: 2rem;
        }

        .inputmoney {
            height: 6rem;
            background-color: #fff;
            margin-top: 0.5rem;
        }

        .inputmoneytop {
            height: 4rem;
            border-bottom: 1px #f4f4f4 solid;
            display: flex;
        }

        .inputmontybottom {
            line-height: 2rem;
            color: #c3c3c3;
            font-size: 0.8rem;
        }

        #money_input::-webkit-input-placeholder { /* WebKit browsers */
            color: #a1a1a1;
        }

        #money_input:-moz-placeholder { /* Mozilla Firefox 4 to 18 */
            color: #a1a1a1;
        }

        #money_input::-moz-placeholder { /* Mozilla Firefox 19+ */
            color: #a1a1a1;
        }

        #money_input:-ms-input-placeholder { /* Internet Explorer 10+ */
            color: #a1a1a1;
        }

        .poundage {
            height: 5rem;
            width: 100%;
            margin-top: 0.5rem;
            background-color: #fff;
        }

        .poundagetop {
            height: 3rem;
            border-bottom: 1px #f4f4f4 solid;
            display: flex;
        }

        .poundagebottom {
            line-height: 2rem;
            color: #c3c3c3;
            font-size: 0.8rem;
        }

        .withdraw_button {
            text-decoration: none;
            background-color: #f38200;
            color: #fff;
            width: 8rem;
            height: 2.4rem;
            font-size: 1.2rem;
            text-align: center;
            line-height: 2.4rem;
            border-radius: 0.5rem;
            position: fixed;
            top: 90%;
            left: 0;
            right: 0;
            margin: auto
        }

        .time_div {
            margin-top: 0.5rem;
            height: 2rem;
            line-height: 2rem;
            background-color: #fff;
        }

    </style>

</head>
<body>

<div class="topbar">
    <a href="javascript:history.go(-1);"><img class="topbar_left" src="<%=request.getContextPath()%>/resources/customer/assets/images/top_bar/back_white.png" alt="返回"></a>
    <span class="topbar_middle">提现</span>
    <span class="topbar_right">&nbsp&nbsp&nbsp&nbsp&nbsp</span>
</div>

<div class="placeholder"></div>

<div class="title">
    <table style="width: 100%">
        <tr style="display: flex;">
            <td style="width: 5rem">&nbsp&nbsp提现到</td>
            <td style="color: #a1a1a1;flex-grow: 1;">微信钱包</td>
        </tr>
    </table>
</div>

<div class="inputmoney">
    <div class="inputmoneytop">
        <div style="height: 4rem; line-height: 4rem; display: inline-block; width: 5rem;">&nbsp&nbsp提现金额</div>
        <div style="height: 4rem; line-height: 4rem; display: inline-block; color:#df0b08; font-size: 2rem;">￥</div>
        <input id="money_input" type="number"
               style="height: 4rem; width: 3rem; display: inline-block; font-size: 2rem; flex-grow: 1; color: #df0b08; border: 0;"
               placeholder="0" onkeyup="countPoundage()">
    </div>
    <div class="inputmontybottom">
        &nbsp&nbsp当前可提现金额
        <span id="balance">${user.flowMoney}</span>,
        <a href="javascript:void(0)" onclick="withdrawAll()" style="color: #dd0b0c; text-decoration: none;">全部提现</a>
    </div>
</div>

<div class="poundage">
    <div class="poundagetop">
        <div style="display: inline-block; line-height: 3rem;">
            &nbsp&nbsp手续费
        </div>
        <div style="display: inline-block; line-height: 3rem; color: #da0d0a; font-size: 1.5rem;">
            ￥
        </div>
        <div id="poundage" style="display: inline-block; line-height: 3rem; color: #da0d0a; font-size: 1.5rem;">
            0
        </div>
    </div>
    <div class="poundagebottom">
        &nbsp&nbsp微信将收取提现金额的0.6%作为手续费
    </div>
</div>

<div class="time_div">
    &nbsp&nbsp预计到账时间：<span id="time"></span>
</div>


<a class="withdraw_button" href="javascript:toWithdraw();">确认提现</a>


</body>

<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
<script type="text/javascript">

    var moneyInput = document.getElementById("money_input");
    var balance = document.getElementById("balance");
    var poundage = document.getElementById("poundage");
    var time = document.getElementById("time");

    window.onload = function () {
        var date = new Date();
        date.setDate(date.getDate() + 2);
        time.innerHTML = date.getFullYear() + "-" + (date.getMonth()+1) + "-" + date.getDate() + " " + date.getHours() + ":" + date.getMinutes();
    }

    function countPoundage() {
        if (moneyInput.value){
            poundage.innerHTML = (0.006 * parseInt(moneyInput.value)).toFixed(2);
        } else {
            poundage.innerHTML = 0;
        }
    }

    function withdrawAll() {
        moneyInput.value = balance.innerHTML;
        countPoundage();
    }
    
    function checkMoney(){
		var withdrawMoney=$("#money_input").val();
		if(withdrawMoney.trim()==""){
			alert("请填写要提现的金额");
		}else{
			if((parseFloat(withdrawMoney)-parseFloat(withdrawMoney)*0.006)<=1){
				alert("提现金额必须大于一元");
			}else{
				if(withdrawMoney>${user.flowMoney}){
					alert("提现金额不能超过可支配金额");
					return false;
				}else{
					return true;
				}
			}
		}
	}
	
    function toWithdraw(){
    	if(checkMoney()){
			var url="<%=request.getContextPath()%>/buyer/withdrawWechat";
			var params={"withdrawMoney":$("#money_input").val()};
			doAjax("GET",url,params,withdrawSuccess,fail,true,false);
    	}
	}
	
	function withdrawSuccess(data){
		//window.location.href="<%=request.getContextPath()%>/buyer/tradeList?settlementStatus=0&capitalFlowType=3";
		/* $("#delete").show();
		$(".shade").show(); */
		alert("提现成功，请等待平台审核。");
		location.reload();
	}
	
	function fail(data){
	}
</script>

</html>