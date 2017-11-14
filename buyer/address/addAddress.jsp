<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
    <link href="<%=request.getContextPath() %>/resources/customer/assets/css/address.css" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
</head>
<body>
<div class="addAddress">
    <div class="title">新增收货地址</div>
	
	<form action="<%=request.getContextPath()%>/buyer/addReceiveAddress" id="form"  method="POST">
    <input type="hidden" value="${balance }" name="balance"/>
     <input type="hidden" value="${isImmediately }" name="isImmediately"/>
    <!-- [[新增地址信息-->
    <div class="address-msg">
        <label for="name" class="name">
            <input type="text" id="name" name="receivePerson" class="form-control" placeholder="姓名"/>
        </label>
        <label for="phone" class="phone">
            <input type="text" id="phone" name="contactNumber" class="form-control" placeholder="电话"/>
        </label>
        <label for="province" class="province">
            <select name="provinceId" onchange="queryCity(this.value)" class="form-control" placeholder="省">
            	<option value="">省</option>
            	<c:forEach items="${provinceList }" var="province">
            		<option value="${province.addressId}">${province.addressName }</option>
            	</c:forEach>
            </select>
        </label>
        <label for="city" class="city">
           <select name="cityId" id="city" class="form-control" onchange="queryArea(this.value)"  placeholder="市">
           	<option value="">市</option>
           </select>
        </label>
        <label for="district" class="district">
            <select name="areaId" class="form-control" id="area" placeholder="区">
            <option value="">区</option>
            </select>
        </label>
        <label for="detail" class="detail">
            <input type="text" id="detail" name="addressDetail" class="form-control" placeholder="详细地址" value="${receiveAddress.addressDetail }"/>
        </label>
    </div>
    <input type="hidden" id="defaultFlag" value="0" name="defaultFlag"/>
    <!-- 新增地址信息]]-->
    <div class="setDefault clearfix">
        <div class="pull-left">设为默认地址</div>
        <label class="pull-right" for="default">
            <input type="checkbox" id="default" />
        </label>
    </div>
    <div class="opaBtn text-center">
       <input class="btn btn-primary save" type="submit" value="保存" style="width: 60%;margin: 0.2rem 0;" />
       <button class="btn btn-primary cancel" type="button" onclick="history.go(-1)">取消</button>
  
    </div>
    </form>
</div>

<jsp:include page="/jsp/buyer/footer.jsp"></jsp:include>
<script type="text/javascript">
//	function submitForm(){
//		if($("#default").is(':checked')){
//			$("#defaultFlag").val(1)
//		}
//		$("#form").submit();
//	}
		$("form").submit(function(){
			var flag = true
			var x=""
		if($("#default").is(':checked')){
			$("#defaultFlag").val(1)
		}
		$(this).find("input[type='text'],select,input[id='defaultFlag']").each(function(){
			if($(this).val()==""||$(this).val()==null){
				x=$(this).attr("placeholder")
				flag = false
				return false
			}
		})
		
		if(!flag){
			alert("请输入"+x)
			return flag;
		}
		
	})
	
	function queryCity(addressId){
		var url="<%=request.getContextPath()%>/address/queryAddress";
		var params={upAddressId:addressId};
		doAjax("GET",url,params,queryCitySuccess,fail,false,false);
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
		doAjax("GET",url,params,queryAreaSuccess,fail,false,false);
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
</script>
</body>
</html>