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
    <link href="<%=request.getContextPath() %>/resources/customer/assets/css/product.css" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
</head>
<body>
<div class="filter">
    <div class="title">筛选</div>

    <form class="form-horizontal" action="<%=request.getContextPath() %>/product/productList">
        <div class="form-group">
            <label class="control-label col-xs-4 text-right">热门推荐：</label>
            <div class="col-xs-7 hotRadio">
                <input name="hot" type="radio" class=""/>是
                <input name="hot" type="radio" class=""/>否
            </div>
        </div>
        <div class="form-group">
            <label for="type" class="control-label col-xs-4 text-right">类别：</label>
            <div class="col-xs-7">
                <select name="type" id="type" class="form-control">
                	 <option value="">--请选择--</option>
                    <c:forEach items="${typeList}" var="type">
                		<option value="${type.propertyValueId }">${type.propertyValue }</option>
                	</c:forEach>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label for="style" class="control-label col-xs-4 text-right">风格：</label>
            <div class="col-xs-7">
                <select name="style" id="style" class="form-control">
                	 <option value="">--请选择--</option>
                    <c:forEach items="${styleList}" var="style">
                		<option value="${style.propertyValueId }">${style.propertyValue }</option>
                	</c:forEach>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label for="material" class="control-label col-xs-4 text-right">材质：</label>
            <div class="col-xs-7">
                <select name="material" id="material" class="form-control">
                	 <option value="">--请选择--</option>
                     <c:forEach items="${materialList}" var="material">
                		<option value="${material.propertyValueId }">${material.propertyValue }</option>
                	</c:forEach>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label for="space" class="control-label col-xs-4 text-right">空间：</label>
            <div class="col-xs-7">
                <select name="space" id="space" class="form-control">
                	 <option value="">--请选择--</option>
                    <c:forEach items="${spaceList}" var="space">
                		<option value="${space.propertyValueId }">${space.propertyValue }</option>
                	</c:forEach>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-xs-4 text-right">价格区间(元)：</label>
            <div class="col-xs-7 priceArea">
                <input name="fromPrice" type="text" class="form-control"/> --
                <input name="toPrice" type="text" class="form-control"/>
            </div>
        </div>
        <div class="form-group">
            <label for="province" class="control-label col-xs-4 text-right">省：</label>
            <div class="col-xs-7">
                <select name="province" id="province" class="form-control">
                	 <option value="">--请选择--</option>
                     <c:forEach items="${provinceList}" var="province">
                		<option value="${province.addressId }">${province.addressName }</option>
                	</c:forEach>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label for="city" class="control-label col-xs-4 text-right">市：</label>
            <div class="col-xs-7">
                <select name="city" id="city" class="form-control">
                    
                </select>
            </div>
        </div>
        <div class="form-group">
            <label for="town" class="control-label col-xs-4 text-right">区/县/镇：</label>
            <div class="col-xs-7">
                <select name="area" id="area" class="form-control">
                    
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-xs-4 text-right"></label>
            <div class="col-xs-7 priceArea">
                <input  type="submit" class="btn btn-primary"/>
            </div>
        </div>
    </form>
</div>
<!--[[底部-->
<jsp:include page="/jsp/buyer/footer.jsp"></jsp:include>
<!--底部]]-->
<script>
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
</script>
</body>
</html>