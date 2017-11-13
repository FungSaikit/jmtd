<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib prefix="thumbnail" uri="/WEB-INF/tld/thumbnailTag.tld"%>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>管理后台</title>
    <link rel="icon" type="image/x-icon" href="${path}/resources/backStage/image/favicon.ico" />

    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/common/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/backStage/css/index.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/backStage/css/order.css" />
	
	<style>
		/* 遮罩层 */
		.shade{
			width:100%;
			height:100%;
			background-color:rgba(0,0,0,.5);
			position:fixed;
			left:0;
			top:0;
			z-index:100;
			display:none;
		}
		.waiting{
			text-align:center;
			position:fixed;
			left:0;
			top:40%;
			width:100%;
			z-index:1003;
			line-height:50px;
			display:none;
		}
		.waiting>i{
			color:#fff;
			font-size:50px;
			width:50px;
			height:50px;
			-webkit-transform-origin: 50% 60%;
		   -moz-transform-origin:  50% 60%;
		   transform-origin:  50% 60%;
		}
		
		.modal-body ul{
			margin:0;
			padding:0;
		}
		.modal-body li{
			border:1px solid #ddd;
			height:3rem;
			line-height:3rem;
		}
		.modal-body .selectSpan{
			display:inline-block;
			padding-left:.5rem;
			width:95%;
		}
		.modal-body li input{
		}
	</style>

</head>
    <body>	
		<!-- 等待加载 -->
		<div class="waiting"><i class="iconfont">&#xe62c;</i></div>
		<div class="shade"></div>
    	<c:set var="CHECK_SUCCESS" value="<%=LampStatus.CHECK_SUCCESS%>" />
		<c:set var="WAITING_ONLINE" value="<%=LampStatus.WAITING_ONLINE%>" />
		<c:set var="ONLINE" value="<%=LampStatus.ONLINE%>" />
		<c:set var="UNDERCARRIAGED" value="<%=LampStatus.UNDERCARRIAGED%>" />
		
        <!-- [[头部 -->
        <jsp:include page="/jsp/platform/header.jsp"></jsp:include>
         <!-- [[页面主体 -->
		<jsp:include page="/jsp/platform/navigation.jsp"></jsp:include>
            <!-- [[选项卡-->
           <%--  <form action="<%=request.getContextPath() %>/platform/productList">
			<input type="text" id="keyword" name="keyword" value="${productParam.keyword}" placeHolder="输入商品名"/>
			</form> --%>
			<button class="btn" onclick="deleteProductColumn()">删除</button>
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover">
                    <thead>
                    <tr>
                        <th>商品名</th>
                        <th>主图</th>
                        <th class="textRight">品牌</th>
                        <th onclick="allSelect(this)" data-select="false">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${productList}" var="product" varStatus="i">
                    	<tr>
	                    	<td class="clickTd" data-select="false">${product.productCode}</td>
	                       <td class="textRight"><img src="<thumbnail:date value="${product.cover1 }"/>" width="100" height="100"/></td>
	                        <td class="textRight moneyText">${product.unitPrice}</td>
	                        <td class="textRight numberText">
	                        	<input type="checkBox" name="productIdList" value="${product.productId }">
	                        </td>
	                    </tr> 
                    </c:forEach> 
                    </tbody>
                </table>
            </div><!-- 商品列表]] -->

            <!-- [[分页-->
            <div class="paging">
                <span class="prev btn btn-primary" onclick="window.location.href='<%=request.getContextPath()%>/platform/getProductList?buttonFlag=${buttonFlag}&offset=${beforeAfterPager.before}&keyword=${keyword }'">上一页</span>
                <span><fmt:formatNumber value="${(offset/beforeAfterPager.size)+1 }" pattern="#0"/>/<fmt:formatNumber value="${beforeAfterPager.count/beforeAfterPager.size+1}" pattern="#0"/></span>
                <span class="next btn btn-primary" onclick="window.location.href='<%=request.getContextPath()%>/platform/getProductList?buttonFlag=${buttonFlag}&offset=${beforeAfterPager.after}&keyword=${keyword }'">下一页</span>
            </div>
            <!-- 分页]]-->

        </div><!-- rightConten右边区域]] -->
		
        </div><!-- mainBody页面主体]] -->

        <footer>
        </footer>
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                <h4 class="modal-title" id="myModalLabel">选择要绑定的栏目</h4>
		            </div>
		            <div class="modal-body">
						<ul>
							
						</ul>
					</div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		                <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="bindProductColumn()">提交更改</button>
		            </div>
		        </div><!-- /.modal-content -->
		    </div><!-- /.modal -->
		</div> 
    </body>
	<script src="<%=request.getContextPath()%>/resources/backStage/script/product.js"></script>
    <script type="text/javascript">
    
    	function generateQrCode(productId){
    		var url="<%=request.getContextPath()%>/platform/generateProductQrCode?productId="+productId;
    		doAjax("post",url,{},success,fail,true,false);
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
    	
    	$(".clickTd").click(function(){
    		var flag;
    		if($(this).attr("data-select")=="false"){
    			flag=true;
    			$(this).attr("data-select","true");
    		}else{
    			flag=false;
    			$(this).attr("data-select","false");
    		}
    		var tr=$(this).parents("tr");
    		var number = $(this).attr("rowspan");
    		for(var i=0;i<number;i++){
    			tr.find("input[type='checkBox']").prop("checked",flag);
    			tr=tr.next();
    		}
    		//find("input[type='checkBox']").attr("checked",true);
    	});
    	
    	function deleteProductColumn(){
    		var checkBox=$("input[name='productIdList']");
    		var productIdList="";
    		checkBox.each(function(){
    			if($(this).is(':checked'))
    				productIdList+=$(this).val()+",";
    		});
    		productIdList=productIdList.substring(0, productIdList.length-1);
			if(productIdList!=""){
	    		$(".waiting").show();
	    		$(".shade").show();
	    		var url="<%=request.getContextPath()%>/platform/deleteProductColumnProduct";
	    		var params={proudctIdList:productIdList,productColumnId:${productColumn.productColumnId}};
	    		console.log(productIdList);
	    		doAjax("POST",url,params,success2,fail,true,false);
	    	}
    	}
    	
    	function success2(data){
			location.reload();
    	}
    	
    	function generateStampPic(){
    		var checkBox=$("input[name='productIdList']");
    		var productIdList="";
    		checkBox.each(function(){
    			if($(this).is(':checked'))
    				productIdList+=$(this).val()+",";
    		});
    		productIdList=productIdList.substring(0, productIdList.length-1);
			if(productIdList!=""){
	    		$(".waiting").show();
	    		$(".shade").show();
	    		var url="<%=request.getContextPath()%>/platform/testProduct";
	    		var params={productIdList:productIdList,hasDetailPic:$("select[name='hasDetailPic']").val()};
	    		console.log(productIdList);
	    		doAjax("POST",url,params,success2,fail,true,false);
	    	}
    	}
    
    	function allSelect(obj){
    		if($(obj).attr("data-select")=="false"){
	    		$("input[type='checkBox']").prop("checked",true);
	    		$(obj).attr("data-select",true);
    		}else{
	    		$("input[type='checkBox']").prop("checked",false);
	    		$(obj).attr("data-select",false);
    		}
    	}
    	
    	function generateProductParam(){
    		var checkBox=$("input[name='productIdList']");
    		var productIdList="";
    		checkBox.each(function(){
    			if($(this).is(':checked'))
    				productIdList+=$(this).val()+",";
    		});
    		productIdList=productIdList.substring(0, productIdList.length-1);
			if(productIdList!=""){
	    		$(".waiting").show();
	    		$(".shade").show();
	    		var url="<%=request.getContextPath()%>/platform/productParamPic";
	    		var params={productIdList:productIdList,hasDetailPic:$("select[name='hasDetailPic']").val()};
	    		console.log(productIdList);
	    		doAjax("POST",url,params,success2,fail,true,false);
	    	}
    	}
    	
    	showProductColumnList();
    	function showProductColumnList(){
    		var url = "<%=request.getContextPath()%>/platform/showProductColumnList";
    		var params = {};
    		doAjax("GET",url,params,showProductColumnSuccess,fail,true,false);
    	}
    	
    	function showProductColumnSuccess(data){
    		var list = data.data;
    		var html = "";
    		for(var i=0;i<list.length;i++){
    			html+='<li><span class="selectSpan">'+list[i].productColumnName+'</span>';
    			html+='<input type="radio" name="productColumnId" value="'+list[i].productColumnId+'"/></li>'
    		}
    		$(".modal-body ul").html(html);
    	}
    	
    	function bindProductColumn(){
    		var productIdList="";
    		var checkBox=$("input[name='productIdList']");
    		checkBox.each(function(){
    			if($(this).is(':checked'))
    				productIdList+=$(this).val()+",";
    		});
    		productIdList=productIdList.substring(0, productIdList.length-1);
    		
    		var url="<%=request.getContextPath()%>/platform/addProductToColumn";
    		var params={productColumnId:$("input[name='productColumnId']").val(),
    				productIdLists:productIdList};
    		doAjax("GET",url,params,function(data){alert("绑定成功");},function(data){console.log("fail"),true,false})
    	}
    </script>
</html>