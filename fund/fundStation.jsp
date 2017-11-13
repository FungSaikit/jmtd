<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib prefix="thumbnail" uri="/WEB-INF/tld/thumbnailTag.tld"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>厂家库存管理</title>
    <link rel="icon" type="image/x-icon" href="${path}/resources/backStage/image/favicon.ico" />

    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/common/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/backStage/css/index.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/backStage/css/order.css" />
	
    <script src="<%=request.getContextPath() %>/resources/common/require.js" data-main="<%=request.getContextPath() %>/resources/backStage/script/main.js" defer async="true"></script>
</head>
<body>
	<jsp:include page="/jsp/fund/navigation.jsp"></jsp:include>
	<form action="<%=request.getContextPath()%>/fund/fundStation">
    	<input type="date" name="from" value="${from}">
   		<input type="date" name="to" value="${to}">
	   	<button>确定</button>
    </form>
    <div class="row">
        <div class="col-xs-6 col-sm-4">
            <a class="indexBlock indexBlock1">
                <i class="icon iconfont">&#xe603;</i>
                累计消费${consume}
            </a>
        </div>
        <div class="col-xs-6 col-sm-4" >
            <a class="indexBlock indexBlock2">
                <i class="icon iconfont">&#xe604;</i>
                用户总提现${withdrawMoney}
            </a>
        </div>
        <div class="col-xs-6 col-sm-4">
            <a class="indexBlock indexBlock3">
                <i class="icon iconfont">&#xe601;</i>
                 退款：${returnMoney}
            </a>
        </div>
        <div class="col-xs-6 col-sm-4">
            <a class="indexBlock indexBlock4">
                <i class="icon iconfont">&#xe601;</i>
                 平台总提现：${platformWithdraw}
            </a>
        </div>
        <div class="col-xs-6 col-sm-4">
            <a class="indexBlock indexBlock5">
                <i class="icon iconfont">&#xe605;</i>
               平台余额:${restMoney}
            </a>
        </div>
       </div>
	  
<!--[[底部-->
<script src="<%=request.getContextPath() %>/resources/common/jquery.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
<!--底部]]-->
<script>
	function toPage(offset){
		$("input[name='offset']").val(offset);
		$("form").submit();
	}
	
	function fundList(obj){
		$("input[name='customerBuy']").val(obj);
		$("input[name='offset']").val(0);
		$("form").submit();
	}
	
	function generateExcel(){
		var url="<%=request.getContextPath()%>/fund/fundListExcel";
		var params={from:$("input[name='from']").val(),to:$("input[name='to']").val(),
				customerBuy:$("input[name='customerBuy']").val()};
		doAjax("GET",url,params,successExcel,fail,true,false);
	}
	
	function successExcel(data){
		window.location.href=data.data;
	}
	
	function fail(data){
		alert("fail");
	}
</script>
</body>
</html>
