<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>金明同达灯饰</title>
    <link href="<%=request.getContextPath() %>/resources/common/bootstrap.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/common/swiper.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/factory/assets/css/address.css" rel="stylesheet">
</head>
<body>
<c:set var="DEFAULT_ADDRESS" value="<%=ReceiveAddressType.DEFAULT_ADDRESS%>" />
<c:set var="ADDRESS" value="<%=ReceiveAddressType.ADDRESS%>" />
<div class="addAddress">
    <div class="title">编辑收货地址</div>
    
	<form action="<%=request.getContextPath()%>/factory/updateAddress" id="form" method="POST">
    <!-- [[新增地址信息-->
    <input type="hidden" name="receiveAddressId" value="${receiveAddress.receiveAddressId }"/>
    <input type="hidden" name="userId" value="${receiveAddress.userId }"/>
    <div class="address-msg">
        <label for="name" class="name">
            <input type="text" id="name" class="form-control" placeholder="姓名" name="receivePerson" value="${receiveAddress.receivePerson }"/>
        </label>
        <label for="phone" class="phone">
            <input type="text" id="phone" class="form-control" placeholder="电话" name="contactNumber" value="${receiveAddress.contactNumber }"/>
        </label>
        <label for="province" class="province" >
            <select name="provinceId" onchange="queryCity(this.value)" id="province" class="form-control">
            	<c:forEach items="${provinceList }" var="province">
            		<option value="${province.addressId}">${province.addressName }</option>
            	</c:forEach>
            </select>
        </label>
        <label for="city" class="city">
            <select name="cityId" id="city" onchange="queryArea(this.value)" class="form-control">
           </select>
        </label>
        <label for="district" class="district">
            <select name="areaId" id="area" class="form-control">
            </select>
        </label>
        <label for="detail" class="detail">
            <input type="text" id="detail" class="form-control" name="addressDetail" value="${receiveAddress.addressDetail }" placeholder="详细地址"/>
        </label>
    </div>
    <input type="hidden" id="defaultFlag" value="${receiveAddress.defaultFlag }" name="defaultFlag"/>
    <c:if test="${receiveAddress.defaultFlag==ADDRESS }">
    <!-- 新增地址信息]]-->
    <div class="setDefault clearfix">
        <div class="pull-left">设为默认地址</div>
        <label class="pull-right" for="default">
            <input type="checkbox" id="default"/>
        </label>
    </div>
    </c:if>
    <div class="opaBtn text-center">
       <button class="btn btn-primary save" type="button" onclick="submitForm()">保存</button>
   	   <button class="btn btn-primary cancel" type="button"  onclick="window.location.href='<%=request.getContextPath()%>/factory/deleteAddress?receiveAddressId=${receiveAddress.receiveAddressId}'">删除</button>
       
    </div>
    </form>
</div>

<!--[[底部-->
<jsp:include page="/jsp/factory/footer.jsp"></jsp:include>
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
<!--底部]]-->
<script>
	function submitForm(){
		if($("#default").is(':checked')){
			$("#defaultFlag").val(1)
		}
		$("#form").submit();
	}

	function queryCity(addressId){
		var url="<%=request.getContextPath()%>/address/queryAddress";
		var params={upAddressId:addressId};
		doAjax("GET",url,params,queryCitySuccess,fail,true,false);
	}
	
	function queryCitySuccess(data){
		var option="";
		for(var i=0;i<data.length;i++){
			option+="<option value='"+data[i].addressId+"'>"+data[i].addressName+"</option>";
		}
		$("#city").html(option);
		queryArea(data[0].addressId);
	}
	
	function queryArea(addressId){
		var url="<%=request.getContextPath()%>/address/queryAddress";
		var params={upAddressId:addressId};
		doAjax("GET",url,params,queryAreaSuccess,fail,true,false);
	}
	
	function queryAreaSuccess(data){
		var option="";
		for(var i=0;i<data.length;i++){
			option+="<option value='"+data[i].addressId+"'>"+data[i].addressName+"</option>";
		}
		$("#area").html(option);
	}
	
	function fail(){
		alert("fail");
	}
	
	$(function(){
		queryCity(${receiveAddress.provinceId});
		$("#province").val(${receiveAddress.provinceId});
		$("#city").val(${receiveAddress.cityId});
		$("#area").val(${receiveAddress.areaId});
	})
</script>
</body>
</html>