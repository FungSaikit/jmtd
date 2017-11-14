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
    <title>金明同达灯饰供应商管理系统</title>
    <link rel="icon" type="image/x-icon" href="${path}/resources/backStage/image/favicon.ico" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/common/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/backStage/css/index.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/backStage/css/order.css" />
	<script src="<%=request.getContextPath()%>/resources/common/jquery.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
	<style>
		.orderStock{
			margin:10px;
			width:auto;
		}
		.orderStock input{
			height:auto;
			width:auto;
		}
	</style>
</head>
    <body>
    	<c:set var="CHECK_SUCCESS" value="<%=LampStatus.CHECK_SUCCESS%>" />
		<c:set var="WAITING_ONLINE" value="<%=LampStatus.WAITING_ONLINE%>" />
		<c:set var="ONLINE" value="<%=LampStatus.ONLINE%>" />
		<c:set var="UNDERCARRIAGED" value="<%=LampStatus.UNDERCARRIAGED%>" />
		<jsp:include page="/jsp/factory/stock/navigation.jsp"></jsp:include>
		
		<div class="orderStock">
            <!-- [[选项卡-->
            <form action="<%=request.getContextPath()%>/stock/productList" id="formA">
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
	            <button type="button" onclick="search()">搜索</button>
	            <input type="hidden" name="offset" value="${offset }"/>
            </form>
            <div class="nav-tabs">
               	<button class="btn <c:if test='${buttonFlag==ONLINE}'>btn-primary</c:if>" onclick="toButton(${ONLINE})">已上线</button>
                <button class="btn <c:if test='${buttonFlag==UNDERCARRIAGED}'>btn-primary</c:if>" onclick="toButton(${UNDERCARRIAGED})">已下架</button>
            </div><!-- 选项卡]] -->
            <!-- [[商品列表 -->
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover">
                    <thead>
                    <tr>
                        <th>系列</th>
                        <th class="textLeft">商品名</th>
                        <th >封面</th>
                        <th class="textRight">库存</th>
                        <th>类型</th>
                        <th class="textRight">状态</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${beforeAfterPager.list}" var="product" varStatus="i">
                    	<tr>
	                    	<td rowspan="${product.seriesProductList.size()+1}"><c:if test="${i.index==0||beforeAfterPager.list[i.index].product.productSeriesId!=beforeAfterPager.list[i.index-1].product.productSeriesId}">${product.product.productSeriesId}</c:if></td>
	                        <td class="textLeft" ><a <c:if test="${product.product.seriesHead==1}">style="color:red"</c:if> href="javascript:void();">${product.product.productName}</a></td>
	                        <td class=""><img src="<thumbnail:date value="${product.product.cover1}"/>" style="width:100px;height:100px;"/></td>
	                        <td class="textRight numberText"><input type="text" value="${product.product.productStock}" onchange="changeProductStock(${product.product.productId},this.value)" style="width:35px;text-align:center;"/></td>
	                        <td>
	                        	<select name="productKind">
	                        		<option value="1" <c:if test="${product.product.productKind==1 }">selected</c:if>>现货</option>
	                        		<option value="0" <c:if test="${product.product.productKind==0 }">selected</c:if>>订货</option>
	                        		<option value="2" <c:if test="${product.product.productKind==2 }">selected</c:if>>爆款</option>
	                        	</select>
	                        </td>
	                        <td class=" ">
	                        	<select name="productStatus">
	                        		<option value="5" <c:if test="${product.product.productStatus==5 }">selected</c:if>>上线中</option>
	                        		<option value="6" <c:if test="${product.product.productStatus==6 }">selected</c:if>>下架</option>
	                        	</select>
	                       	</td>
	                       	<td>
	                       		<div class="checkBox" data-id="${product.product.productId }">
	   								<span></span>
	   							</div></td>
	                    </tr> 
                     <c:forEach items="${product.seriesProductList}" var="product" varStatus="i">
                     	<tr>
	                        <td class="textLeft" ><a <c:if test="${product.seriesHead==1}">style="color:red"</c:if> href="javascript:void();">${product.productName}</a></td>
	                        
	                        <td class=""><img src="<thumbnail:date value="${product.cover1}"/>" style="width:100px;height:100px;"/></td>
	                        <td class="textRight numberText"><input type="text" value="${product.productStock}" onchange="changeProductStock(${product.productId},this.value)" style="width:35px;text-align:center;"/></td>
	                        <td><select name="productKind">
	                        		<option value="1" <c:if test="${product.productKind==1 }">selected</c:if>>现货</option>
	                        		<option value="0" <c:if test="${product.productKind==0 }">selected</c:if>>订货</option>
	                        		<option value="2" <c:if test="${product.productKind==2 }">selected</c:if>>爆款</option>
	                        	</select></td>
	                        <td>
	                        	<select name="productStatus">
	                        		<option value="5" <c:if test="${product.productStatus==5 }">selected</c:if>>上线中</option>
	                        		<option value="6" <c:if test="${product.productStatus==6 }">selected</c:if>>下架</option>
	                        	</select>
	                        </td>
	                        <td><div class="checkBox" data-id="${product.productId}">
	   								<span></span>
	   							</div></td>
	                    </tr> 
                     </c:forEach>
                    </c:forEach> 
                    </tbody>
                </table>
            </div><!-- 商品列表]] -->
			<button class="submit">提交</button>
            <!-- [[分页-->
            <div class="paging">
                <span class="prev btn btn-primary" onclick="toPage(${beforeAfterPager.before})">上一页</span>
                <span>当前第页<fmt:formatNumber value="${((beforeAfterPager.after==beforeAfterPager.count&&beforeAfterPager.after%5!=0)?1:0)+((beforeAfterPager.after-beforeAfterPager.after%5))/5 }" pattern="#0"/>/共<fmt:formatNumber value="${((beforeAfterPager.count-1-(beforeAfterPager.count-1)%5))/5+1}" pattern="#0" />页</span>
                <span class="next btn btn-primary" onclick="toPage(${beforeAfterPager.after})">下一页</span>
            </div>
            <!-- 分页]]-->
		
            </div>
        <form action="<%=request.getContextPath()%>/stock/updateProduct">
	    	<input type="hidden" name="idList"/>
		   	<input type="hidden" value="" name="productKinds"/>
		   	<input type="hidden" value="" name="productStatuss"/>
		   	<input type="hidden" value="${orderStockStatus}" name="orderStockStatus"/>
	    </form>
    </body>
    <script type="text/javascript">
	    $(".checkBox").click(function(){
			if($(this).hasClass("active")){
				$(this).removeClass("active");
			}else{
				$(this).addClass("active");
			}
		});
    
    	function changeProductStock(productId,stock){
    		var url="<%=request.getContextPath()%>/stock/changeProductStock";
    		var params = {productId:productId,stock:stock};
    		doAjax("GET",url,params,changeSuccess,fail,true,false);
    	}
    	
    	function changeSuccess(data){
    		
    	}
    
    	function fail(data){
    		alert(data);
    	}
    	
    	function searchByKeyword(){
    		window.location.href="<%=request.getContextPath()%>/stock/productList?buttonFlag=${buttonFlag}&offset=0&keyword="+$("#keyword").val();
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
    	
    	$(".submit").click(function(){
    		var dataId="";
    		var productKinds="";
    		var productStatuss="";
    		$(".checkBox").each(function(){
    			if($(this).hasClass("active")){
    				dataId+=$(this).attr("data-id")+",";
    				productKinds+=$(this).parents("tr").find("select[name='productKind']").val()+",";
    				productStatuss+=$(this).parents("tr").find("select[name='productStatus']").val()+",";
    			}
    		});
    		if(dataId==""){
    			alert("请至少选择一项提交");
    		}else{
    			dataId=dataId.substring(0, dataId.length-1);
    			productKinds=productKinds.substring(0, productKinds.length-1);
    			productStatuss=productStatuss.substring(0, productStatuss.length-1);
    			$("input[name='idList']").val(dataId);
    			$("input[name='productKinds']").val(productKinds);
    			$("input[name='productStatuss']").val(productStatuss);
    			$("form").submit();
    		}
    	});
    </script>
</html>