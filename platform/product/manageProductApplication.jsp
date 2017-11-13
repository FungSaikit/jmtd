<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib prefix="thumbnail" uri="/WEB-INF/tld/thumbnailTag.tld"%>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>管理后台</title>
    <link rel="icon" type="image/x-icon" href="${path}/resources/backStage/image/favicon.ico" />

    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/common/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/backStage/css/index.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/backStage/css/order.css" />
	

</head>
    <body>
    	<c:set var="CHECK_SUCCESS" value="<%=LampStatus.CHECK_SUCCESS%>" />
		<c:set var="WAITING_ONLINE" value="<%=LampStatus.WAITING_ONLINE%>" />
		<c:set var="ONLINE" value="<%=LampStatus.ONLINE%>" />
		<c:set var="UNDERCARRIAGED" value="<%=LampStatus.UNDERCARRIAGED%>" />
		<c:set var="DELETED" value="<%=LampStatus.DELETED%>" />
		<c:set var="WAITING_CHECK" value="<%=LampStatus.WAITING_CHECK%>" />
		
        <!-- [[头部 -->
        <jsp:include page="/jsp/platform/header.jsp"></jsp:include>
         <!-- [[页面主体 -->
		<jsp:include page="/jsp/platform/navigation.jsp"></jsp:include>
		<form action="<%=request.getContextPath()%>/platform/productApplicationList" id="formB">
            <input type="hidden" name="offset" value="${offset }"/>
		</form>
            <!-- [[选项卡-->
            <form action="<%=request.getContextPath()%>/platform/getProductList" id="formA">
            <input type="hidden" value="${buttonFlag }" name="buttonFlag"/>
			<%-- <input type="text" name="keyword" value="${productParam.keyword}" placeHolder="输入商品名"/>
			<select name="type">
            	<option value="">--请选择类型--</option>
          		<c:forEach items="${typeList}" var="type">
              		<option value="${type.propertyValueId }" <c:if test="${productParam.type==type.propertyValueId }">selected</c:if>>${type.propertyValue }</option>
              	</c:forEach>
            </select>
            <select name="style">
            	<option value="">--请选择风格--</option>
          		<c:forEach items="${styleList}" var="style">
              		<option value="${style.propertyValueId }" <c:if test="${productParam.style==style.propertyValueId }">selected</c:if>>${style.propertyValue }</option>
              	</c:forEach>
            </select>
            <select name="material">
            	<option value="">--请选择材质--</option>
          		<c:forEach items="${materialList}" var="material">
              		<option value="${material.propertyValueId }" <c:if test="${productParam.material==material.propertyValueId }">selected</c:if>>${material.propertyValue }</option>
              	</c:forEach>
            </select>
            <select name="brand">
            	<option value="">--请选择品牌--</option>
          		<c:forEach items="${brandList}" var="brand">
              		<option value="${brand.shortCompanyName }" <c:if test="${productParam.brand==brand.shortCompanyName }">selected</c:if>>${brand.shortCompanyName }</option>
              	</c:forEach>
            </select>
            <button type="button" onclick="search()">搜索</button> --%>
            <input type="hidden" name="offset" value="${offset }"/>
            </form> 
            <div class="nav-tabs">
            	<button class="btn <c:if test='${buttonFlag==WAITING_CHECK}'>navActive</c:if>" onclick="toButton(${WAITING_CHECK})">待审核</button>
            	<button class="btn <c:if test='${buttonFlag==ONLINE}'>navActive</c:if>" onclick="toButton(${ONLINE})">已上线</button>
                <button class="btn <c:if test='${buttonFlag==UNDERCARRIAGED}'>navActive</c:if>" onclick="toButton(${UNDERCARRIAGED})">已下架</button>
                <button class="btn <c:if test='${buttonFlag==DELETED}'>navActive</c:if>" onclick="toButton(${DELETED})">已删除</button>
                <button class="btn" onclick="window.location.href='<%=request.getContextPath()%>/platform/spreadProductList'">每日推广</button>
                
				<button class="btn navActive" onclick="window.location.href='<%=request.getContextPath()%>/platform/productApplicationList'">产品修改</button>
                <button class="btn active" style="float:right" onclick="window.location.href='<%=request.getContextPath()%>/platform/toAddProduct'">添加商品</button>
            </div><!-- 选项卡]] -->
            <!-- [[商品列表 -->
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover">
                    <thead>
                    <tr>
                        <th class="textLeft">商品名</th>
                        <th>厂家名</th>
                        <th >封面</th>
                        <th class="textRight">出厂价</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${bap.list}" var="product" varStatus="i">
                    	<tr>
	                        <td class="textLeft" ><a href="<%=request.getContextPath()%>/platform/productApplicationDetail?productApplicationId=${product.productApplicationId}&buttonFlag=${buttonFlag}">${product.productCode}</a></td>
	                        <td>${product.productBrand}</td>
	                        <td class=""><img src="<thumbnail:date value="${product.cover1}"/>" style="width:100px;height:100px;"/></td>
	                        <td class="textRight numberText">${product.originUnitPrice}</td>
	                        <td>
	                        	<a href="<%=request.getContextPath()%>/platform/productApplicationDetail?productApplicationId=${product.productApplicationId}&buttonFlag=${buttonFlag}">查看</a>
	                        </td>
	                    </tr> 
                    </c:forEach> 
                    </tbody>
                </table>
            </div><!-- 商品列表]] -->

            <!-- [[分页-->
            <div class="paging">
                <span class="prev btn btn-primary" onclick="toPage(${bap.before})">上一页</span>
                <span>当前第页<fmt:formatNumber value="${((bap.after==bap.count&&bap.after%10!=0)?1:0)+((bap.after-bap.after%10))/10 }" pattern="#0"/>/共<fmt:formatNumber value="${((bap.count-1-(bap.count-1)%10))/10+1}" pattern="#0" />页</span>
                <input type="text" id="pageNo"><button onclick="toPageNo()">前往</button>
                <span class="next btn btn-primary" onclick="toPage(${bap.after})">下一页</span>
            </div>
            <!-- 分页]]-->

        </div><!-- rightConten右边区域]] -->
        </div><!-- mainBody页面主体]] -->

        <footer>
        </footer>
		
		<div class="waiting"><i class="iconfont">&#xe62c;</i></div>
		<div class="shade"></div>
    </body>
    <script src="<%=request.getContextPath()%>/resources/backStage/script/product.js"></script>
    <script type="text/javascript">
    	function toPageNo(){
    		$("input[name='offset']").val($("#pageNo").val()==""?0:(parseInt($("#pageNo").val()-1)*5));
    		$("#formA").submit();
    	}
    
    	function generateQrCode(productId){
    		var url="<%=request.getContextPath()%>/platform/generateProductQrCode?productId="+productId;
    		doAjax("GET",url,{},success,fail,true,false);
    	}
    	
    	
    	function success(data){
    		window.location.href=data.data;
    	}
    	
    	function fail(data){
    		alert(data);
    	}
    	
    	function changeFictionSales(productId,sales){
    		var url="<%=request.getContextPath()%>/platform/updateProductSales";
    		var params={productId:productId,productSales:sales};
    		doAjax("GET",url,params,success1,fail,true,false);
    	}
    	
    	function success1(data){
    		
    	}
    	
    	function searchByKeyword(){
    		window.location.href="<%=request.getContextPath()%>/platform/getProductList?buttonFlag=${buttonFlag}&offset=0&keyword="+$("#keyword").val();
    	}
    	
    	function toPage(offset){
    		$("input[name='offset']").val(offset);
    		$("#formB").submit();
    	}
    	
    	function toButton(buttonFlag){
    		$("input[name='buttonFlag']").val(buttonFlag);
    		$("input[name='offset']").val(0);
    		$("#formA").submit();
    	}
    	
    	function search(){
    		$("input[name='offset']").val(0);
    		$("#formB").submit();
    	}
    	
    	function offlineProduct(productId){
    		var url="<%=request.getContextPath()%>/platform/offlineProductAjax";
    		var params={productId:productId};
    		doAjax("GET",url,params,offlineSuccess,fail,true,false);
    	}
    	
    	function offlineSuccess(data){
    		location.reload();
    	}
    	
    	function setProductSpread(productId){
    		var url="<%=request.getContextPath()%>/platform/setProductSpread";
    		var params={productId:productId};
    		doAjax("GET",url,params,function(data){location.reload();},function(data){console.log(fail);},true,false)
    	}
    	
    	function cancelProductSpread(productId){
    		var url="<%=request.getContextPath()%>/platform/cancelProductSpread";
    		var params={productId:productId};
    		doAjax("GET",url,params,function(data){location.reload();},function(data){console.log(fail);},true,false)
    	}
    	
    	function deleteProduct(productId){
    		var url="<%=request.getContextPath()%>/platform/deleteProduct";
    		var params={productId:productId};
    		doAjax("GET",url,params,function(data){location.reload();},function(data){console.log(fail);},true,false)
    	}
    	
    	function restoreProduct(productId){
    		var url="<%=request.getContextPath()%>/platform/restoreProduct";
    		var params={productId:productId};
    		doAjax("GET",url,params,function(data){location.reload();},function(data){console.log(fail);},true,false)
    	}
    	
    	function setSeriesHead(productId){
    		var url="<%=request.getContextPath()%>/platform/setSeriesHead";
    		var params={productId:productId};
    		doAjax("GET",url,params,function(data){location.reload();},function(data){console.log(fail);},true,false)
    	}
    	
    	function changeSeriesIndex(sign,productId){
    		var url="<%=request.getContextPath()%>/platform/changeSeriesIndex";
    		var params={sign:sign,productId:productId};
    		doAjax("GET",url,params,function(data){location.reload();},function(data){console.log(fail);},true,false)
    	}
    	
    	function onlineProduct(productId){
    		var url="<%=request.getContextPath()%>/platform/onlineProduct";
    		var params={productId:productId};
    		doAjax("GET",url,params,function(data){location.reload();},function(data){console.log(fail);},true,false);
    	}
    	
    	function getProductReceiveStation(productId){
    		var url="<%=request.getContextPath()%>/platform/consultProductReceiveStation";
    		var params={productId:productId};
    		doAjax("GET",url,params,getProductReceiveSuccess,fail,true,false);
    	}
    	
    	function getProductReceiveSuccess(data){
    		if(data.code==0){
    			alert("暂时没有记录");
    		}else{
    			alert(data.data[0]+"\n"+data.data[1]);
    		}
    	}
    </script>
</html>