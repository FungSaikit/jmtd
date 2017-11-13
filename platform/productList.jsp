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
	<style>
		.pagination {
		    margin: 0 0 35px;
		    text-align: center;
		    display: block;
		}
		.pagination a {
		    text-align: center;
		    display: inline-block;
		    color: #ffffff;
		    background: #337ab7;
		    border-radius: 2px;
		    padding: 8px 15px;
		}
		
		.pagination .page-number {
		    background: #337ab7;
		    color: #ffffff;
		    display: inline-block;
		    line-height: 36px;
		    padding: 0 14px;
		    border-radius: 2px;
		    text-align: center;
		}
		.paginput{ 
			text-align: center;
		    display: inline-block;
		    color: #ffffff;
		    border-radius: 2px;
		    padding: 1px 2px;
		    }
		 .pagnggo{border: 1px solid #337ab7;background-color: #337ab7;color: #fff;}
		 .pagination a:HOVER {text-decoration: none;background-color: #23527c;color: #fff}
		 .btn.btn-default.pagnggo:HOVER{background-color: #23527c;color: #fff;border: 1px solid #23527c;}
		 .paging{padding: 0 3px;}
	</style>	

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
            <!-- [[选项卡-->
            <form action="<%=request.getContextPath()%>/platform/getProductList" id="formA">
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
            <div class="nav-tabs">
            	<button class="btn <c:if test='${buttonFlag==WAITING_CHECK}'>navActive</c:if>" onclick="toButton(${WAITING_CHECK})">待审核</button>
                <button class="btn <c:if test='${buttonFlag==ONLINE}'>navActive</c:if>" onclick="toButton(${ONLINE})">已上线</button>
               <%--  <button class="btn <c:if test='${buttonFlag==-1}'>navActive</c:if>" onclick="toButton(-1)">待续费</button> --%>
                <button class="btn <c:if test='${buttonFlag==UNDERCARRIAGED}'>navActive</c:if>" onclick="toButton(${UNDERCARRIAGED})">已下架</button>
                <button class="btn <c:if test='${buttonFlag==DELETED}'>navActive</c:if>" onclick="toButton(${DELETED})">已删除</button><%-- 
                <button class="btn" onclick="window.location.href='<%=request.getContextPath()%>/platform/spreadProductList'">每日推广</button>
				<button class="btn" onclick="window.location.href='<%=request.getContextPath()%>/platform/productApplicationList'">产品修改</button> --%>
                <button class="btn active" style="float:right" onclick="window.location.href='<%=request.getContextPath()%>/platform/toAddProduct'">添加商品</button>
            </div><!-- 选项卡]] -->
            <!-- [[商品列表 -->
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover">
                    <thead>
                    <tr>
                        <th>系列</th>
                        <th class="textLeft">商品名</th>
                        <th>厂家名</th>
                        <th >封面</th>
                        <th class="textRight">规格</th>
                        <th class="textRight">出厂价</th>
                        <th>操作</th>
                        <c:if test="${buttonFlag==ONLINE}">
	                        <th class="textRight">移动</th>
	                        <th>操作</th>
	                        <th>推广</th>
	                    </c:if>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${beforeAfterPager.list}" var="product" varStatus="i">
                    	<tr>
	                    	<td rowspan="${product.seriesProductList.size()+1}"><c:if test="${i.index==0||beforeAfterPager.list[i.index].product.productSeriesId!=beforeAfterPager.list[i.index-1].product.productSeriesId}">${product.product.productSeriesId}</c:if></td>
	                        <td class="textLeft" ><a <c:if test="${product.product.seriesHead==1}">style="color:red"</c:if> href="<%=request.getContextPath()%>/platform/getProductDetail?productId=${product.product.productId}&buttonFlag=${buttonFlag}">${product.product.productName}</a></td>
	                        <td>${product.product.productBrand}</td>
	                        <td class="" onclick="getProductReceiveStation(${product.product.productId})"><img src="<thumbnail:date value="${product.product.cover1}"/>" style="width:100px;height:100px;"/></td>
	                        <td class="textRight numberText">${product.product.productCode}</td>
	                        <td class="textRight numberText">${product.product.unitPrice}</td>
	                        <td>
	                        	<c:if test="${buttonFlag==ONLINE}"><a href="javascript:setSeriesHead(${product.product.productId })">在列表页展示</a>|</c:if>
	                       		<c:choose>
	                       			<c:when test="${buttonFlag==ONLINE }"><a href="javascript:offlineProduct(${product.product.productId})">下架</a></c:when>                       		
	                       			<c:when test="${buttonFlag==UNDERCARRIAGED }"><a href="javascript:onlineProduct(${product.product.productId })">上架</a>
	                       				|<a href="javascript:deleteProduct(${product.product.productId})">删除</a></c:when>
	                        		<c:otherwise><a href="javascript:restoreProduct(${product.product.productId})">还原</a></c:otherwise>
	                        	</c:choose>
	                        </td>
	                        <c:if test="${buttonFlag==ONLINE}">
		                        <td class="textRight numberText"><a href="javascript:changeSeriesIndex(1,${product.product.productId })">上移</a>
		                        	|<a href="javascript:changeSeriesIndex(0,${product.product.productId })">下移</a>
		                        </td>
		                        <td class="textRight numberText">
		                        	<c:if test="${i.index==0||beforeAfterPager.list[i.index].product.productSeriesId!=beforeAfterPager.list[i.index-1].product.productSeriesId}"><a href="<%=request.getContextPath()%>/platform/toAddSeriesProduct?productSeriesId=${product.product.productSeriesId}">添加此系列</a></c:if>
		                        	|<a href="javascript:generateQrCode(${product.product.productId })">产品二维码</a>
		                        	|<a href="<%=request.getContextPath()%>/platform/changePopularStatus?productId=${product.product.productId}&productStatus=${buttonFlag}&offset=${offset}"><c:choose><c:when test="${product.product.isPopular==0 }">设为</c:when><c:otherwise>取消</c:otherwise></c:choose>热门推荐</a>
		                        </td>
		                    	<td><c:if test="${product.product.isSpreadProduct==0}"><a href="javascript:setProductSpread(${product.product.productId })">设为每日推广</a></c:if>
		                    		<c:if test="${product.product.isSpreadProduct==1||product.product.historySpreadProduct==1}"><a href="javascript:cancelProductSpread(${product.product.productId })">取消每日推广</a></c:if>
		                    	</td>
	                    	</c:if>
	                    </tr> 
                     <c:forEach items="${product.seriesProductList}" var="product" varStatus="i">
                     	<tr>
	                        <td class="textLeft" ><a <c:if test="${product.seriesHead==1}">style="color:red"</c:if> href="<%=request.getContextPath()%>/platform/getProductDetail?productId=${product.productId}&buttonFlag=${buttonFlag}">${product.productName}</a></td>
	                        <td></td>
	                        <td class="" onclick="getProductReceiveStation(${product.productId})"><img src="<thumbnail:date value="${product.cover1}"/>" style="width:100px;height:100px;"/></td>
	                        <td class="textRight numberText">${product.productCode }</td>
	                        <td class="textRight numberText">${product.unitPrice}</td>
	                        <td>
	                        	<c:if test="${buttonFlag==ONLINE}"><a href="javascript:setSeriesHead(${product.productId })">在列表页展示</a>|</c:if>
	                        	<c:choose><c:when test="${buttonFlag==ONLINE}"><a href="javascript:offlineProduct(${product.productId})">下架</a></c:when>
	                        				<c:when test="${buttonFlag==UNDERCARRIAGED }"><a href="javascript:onlineProduct(${product.productId })">上架</a>
	                        					|<a href="javascript:deleteProduct(${product.productId})">删除</a></c:when>
	                        				<c:when test="${buttonFlag==WAITING_CHECK }"><a href="<%=request.getContextPath()%>/platform/getProductDetail?productId=${product.productId}&buttonFlag=${buttonFlag}">查看</a></c:when>
	                        				<c:otherwise><a href="javascript:restoreProduct(${product.productId})">还原</a></c:otherwise></c:choose></td>
	                        <c:if test="${buttonFlag==ONLINE}">    
		                        <td class="textRight numberText"><a href="javascript:changeSeriesIndex(1,${product.productId })">上移</a>
		                        	|<a href="javascript:changeSeriesIndex(0,${product.productId})">下移</a>
		                        </td>
		                        <td class="textRight numberText">
		                        	<a href="javascript:generateQrCode(${product.productId })">产品二维码</a>
		                        	|<a href="<%=request.getContextPath()%>/platform/changePopularStatus?productId=${product.productId}&productStatus=${buttonFlag}&offset=${offset}"><c:choose><c:when test="${product.isPopular==0 }">设为</c:when><c:otherwise>取消</c:otherwise></c:choose>热门推荐</a>
		                        </td>
		                        <td><c:if test="${product.isSpreadProduct==0}"><a href="javascript:setProductSpread(${product.productId })">设为每日推广</a></c:if>
		                    		<c:if test="${product.isSpreadProduct==1||product.historySpreadProduct==1}"><a href="javascript:cancelProductSpread(${product.productId })">取消每日推广</a></c:if>
		                    	</td>
	                    	</c:if>
	                    </tr> 
                     </c:forEach>
                    </c:forEach> 
                    </tbody>
                </table>
            </div><!-- 商品列表]] -->

            <!-- [[分页-->
            <%-- <div class="paging">
                <span class="prev btn btn-primary" onclick="toPage(${beforeAfterPager.before})">上一页</span>
                <span>当前第页<fmt:formatNumber value="${((beforeAfterPager.after==beforeAfterPager.count&&beforeAfterPager.after%5!=0)?1:0)+((beforeAfterPager.after-beforeAfterPager.after%5))/5 }" pattern="#0"/>/共<fmt:formatNumber value="${((beforeAfterPager.count-1-(beforeAfterPager.count-1)%5))/5+1}" pattern="#0" />页</span>
                <input type="text" id="pageNo"><button onclick="toPageNo()">前往</button>
                <span class="next btn btn-primary" onclick="toPage(${beforeAfterPager.after})">下一页</span>
            </div> --%>
            	<div class="col-lg-4"></div>
            	<nav class="pagination col-lg-8" role="navigation">
	            	<div class="col-lg-5"></div>
				        <a class="newer-posts col-lg-1" onclick="toPage(${beforeAfterPager.before})"><i class="fa fa-angle-left">&lt;</i></a>
				     <div class="col-lg-3 paging"><span class="page-number col-lg-12">第<fmt:formatNumber value="${((beforeAfterPager.after==beforeAfterPager.count&&beforeAfterPager.after%5!=0)?1:0)+((beforeAfterPager.after-beforeAfterPager.after%5))/5 }" pattern="#0"/>页/共<fmt:formatNumber value="${((beforeAfterPager.count-1-(beforeAfterPager.count-1)%5))/5+1}" pattern="#0" />页</span></div>
				     		<div class="col-lg-2 paginput" style="">
					<div class="input-group">
						<input type="text" class="form-control" id="pageNo" style="border: 1px solid #337ab7;">
						<span class="input-group-btn" >
							<button class="btn btn-default pagnggo" type="button" onclick="toPageNo()">
								前往
							</button>
						</span>
					</div><!-- /input-group -->
				</div><!-- /.col-lg-6 -->
				        <a class="older-posts col-lg-1" onclick="toPage(${beforeAfterPager.after})"><i class="fa fa-angle-right">&gt;</i></a>
				</nav>
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