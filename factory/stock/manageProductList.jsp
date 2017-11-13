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
    <title>繁灯网供应商管理系统</title>
    <link rel="icon" type="image/x-icon" href="${path}/resources/backStage/image/favicon.ico" />

    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/common/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/backStage/css/index.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/backStage/css/order.css" />
	

</head>
    <body>
    	<c:set var="WAITING_CHECK" value="<%=LampStatus.WAITING_CHECK%>" />
    	<c:set var="CHECK_SUCCESS" value="<%=LampStatus.CHECK_SUCCESS%>" />
		<c:set var="WAITING_ONLINE" value="<%=LampStatus.WAITING_ONLINE%>" />
		<c:set var="ONLINE" value="<%=LampStatus.ONLINE%>" />
		<c:set var="UNDERCARRIAGED" value="<%=LampStatus.UNDERCARRIAGED%>" />
		<c:set var="DELETED" value="<%=LampStatus.DELETED%>" />
		<c:set var="CHECK_FAILURE" value="<%=LampStatus.CHECK_FAILURE%>" />
		
		<jsp:include page="/jsp/factory/stock/navigation.jsp"></jsp:include>
            <!-- [[选项卡-->
            <form action="<%=request.getContextPath()%>/stock/manageProductList" id="formA">
            <input type="hidden" value="${buttonFlag }" name="buttonFlag"/>
			<input type="text" name="keyword" value="${productParam.keyword}" placeHolder="输入商品名"/>
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
            <button type="button" onclick="search()">搜索</button>
            <input type="hidden" name="offset" value="${offset }"/>
            </form>
            <div class="nav-tabs"><%-- 
                <button class="btn <c:if test='${buttonFlag==CHECK_SUCCESS}'>navActive</c:if>" onclick="toButton(${CHECK_SUCCESS})">新产品</button> --%>
                <button class="btn <c:if test='${buttonFlag==WAITING_CHECK}'>navActive</c:if>" onclick="toButton(${WAITING_CHECK})">待审核</button>
                <button class="btn <c:if test='${buttonFlag==ONLINE}'>navActive</c:if>" onclick="toButton(${ONLINE})">已上线</button>
                <button class="btn <c:if test='${buttonFlag==UNDERCARRIAGED}'>navActive</c:if>" onclick="toButton(${UNDERCARRIAGED})">已下架</button>
                <button class="btn <c:if test='${buttonFlag==CHECK_FAILURE}'>navActive</c:if>" onclick="toButton(${CHECK_FAILURE})">不通过</button>
                <button class="btn active" style="float:right" onclick="window.location.href='<%=request.getContextPath()%>/stock/toAddProduct'">添加商品</button>
            </div><!-- 选项卡]] -->
            <!-- [[商品列表 -->
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover">
                    <thead>
                    <tr>
                        <th>系列</th>
                        <th class="textLeft">商品名</th>
                        <th>封面</th>
                        <th class="textRight">库存</th>
                        <th class="textRight">规格</th>
                        <th class="textRight">价格</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${beforeAfterPager.list}" var="product" varStatus="i">
                    	<tr>
	                    	<td rowspan="${product.seriesProductList.size()+1}"><c:if test="${i.index==0||beforeAfterPager.list[i.index].product.productSeriesId!=beforeAfterPager.list[i.index-1].product.productSeriesId}">${product.product.productSeriesId}</c:if></td>
	                        <td class="textLeft" ><a <c:if test="${product.product.seriesHead==1}">style="color:red"</c:if> href="<%=request.getContextPath()%>/stock/manageProductDetail?productId=${product.product.productId}&buttonFlag=${buttonFlag}">${product.product.productName}</a></td>
	                        <td class="" ><img src="<thumbnail:date value="${product.product.cover1}"/>" style="width:100px;height:100px;"/></td>
	                        <td class="textRight numberText"><input type="text" value="${product.product.productStock}" onchange="changeProductStock(${product.product.productId},this.value)" style="width:35px;text-align:center;"/></td>
	                        <td class="textRight numberText">${product.product.productCode}</td>
	                        <td class="textRight numberText">${product.product.originUnitPrice}</td>
	                        <td>
	                        	<a href="<%=request.getContextPath()%>/stock/toAddSeriesProduct?productSeriesId=${product.product.productSeriesId}">添加同系列产品</a>
	                        </td>
	                        
	                    </tr> 
                     <c:forEach items="${product.seriesProductList}" var="product" varStatus="i">
                     	<tr>
	                        <td class="textLeft" ><a <c:if test="${product.seriesHead==1}">style="color:red"</c:if> href="<%=request.getContextPath()%>/stock/manageProductDetail?productId=${product.productId}&buttonFlag=${buttonFlag}">${product.productName}</a></td>
	                        <td class="" ><img src="<thumbnail:date value="${product.cover1}"/>" style="width:100px;height:100px;"/></td>
	                        <td class="textRight numberText"><input type="text" value="${product.productStock}" onchange="changeProductStock(${product.productId},this.value)" style="width:35px;text-align:center;"/></td>
	                        <td class="textRight numberText">${product.productCode }</td>
	                        <td class="textRight numberText">${product.originUnitPrice}</td>
	                        <td>
	                        	
	                        </td>
	                    </tr> 
                     </c:forEach>
                    </c:forEach> 
                    </tbody>
                </table>
            </div><!-- 商品列表]] -->

            <!-- [[分页-->
            <div class="paging">
                <span class="prev btn btn-primary" onclick="toPage(${beforeAfterPager.before})">上一页</span>
                <span>当前第页<fmt:formatNumber value="${((beforeAfterPager.after==beforeAfterPager.count&&beforeAfterPager.after%10!=0)?1:0)+((beforeAfterPager.after-beforeAfterPager.after%10))/10 }" pattern="#0"/>/共<fmt:formatNumber value="${((beforeAfterPager.count-1-(beforeAfterPager.count-1)%10))/10+1}" pattern="#0" />页</span>
                <input type="text" id="pageNo"><button onclick="toPageNo()">前往</button>
                <span class="next btn btn-primary" onclick="toPage(${beforeAfterPager.after})">下一页</span>
            </div>
            <!-- 分页]]-->

        </div><!-- rightConten右边区域]] -->

        </div><!-- mainBody页面主体]] -->

        <footer>
        </footer>
		
		<div class="waiting"><i class="iconfont">&#xe62c;</i></div>
		<div class="shade"></div>
    </body>
    <script src="<%=request.getContextPath()%>/resources/common/jquery.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/backStage/script/product.js"></script>
    <script type="text/javascript">
    	function toPageNo(){
    		$("input[name='offset']").val($("#pageNo").val()==""?0:(parseInt($("#pageNo").val()-1)*10));
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
    		$("#formA").submit();
    	}
    	
    	function toButton(buttonFlag){
    		$("input[name='buttonFlag']").val(buttonFlag);
    		$("input[name='offset']").val(0);
    		$("#formA").submit();
    	}
    	
    	function search(){
    		$("input[name='offset']").val(0);
    		$("#formA").submit();
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
    	
    	function changeProductStock(productId,stock){
    		var url="<%=request.getContextPath()%>/stock/changeProductStock";
    		var params = {productId:productId,stock:stock};
    		doAjax("GET",url,params,function(data){location.reload();},function(data){console.log(fail);},true,false);
    	}
    	
    </script>
</html>