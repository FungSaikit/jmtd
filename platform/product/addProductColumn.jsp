<%@ page language="java" import="java.util.*,java.text.SimpleDateFormat" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>管理后台</title>
    <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/resources/backStage/image/favicon.ico" />

    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/common/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/backStage/css/index.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/backStage/css/product.css" />
	
</head>
<body>
     <!-- [[头部 -->
     <jsp:include page="/jsp/platform/header.jsp"></jsp:include>
     <!-- [[页面主体 -->
	 <jsp:include page="/jsp/platform/navigation.jsp"></jsp:include>

    <!-- [[商品详情操作区 -->
    <div class="area productDetail">
        <form action="<%=request.getContextPath()%>/platform/addProductColumn" method="post" class="form-horizontal" onsubmit="return submitForm();">
			<div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*栏目分类</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <select class="form-control" name="productStyleType" id="productStyleType" >
                    	<option value="0">新中式</option>
                    	<option value="1">非新中式</option>
                    </select>
                </div>
            </div>
			<div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*栏目类型</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <select class="form-control" name="productColumnType" id="productColumnType" onchange="changeProductColumnType(this.value)">
                    	<option value="0">用已有属性</option>
                    	<option value="1">新栏目</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*栏目名字</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input class="form-control" name="productColumnName"  id="productColumnName"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*栏目标题</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input class="form-control" name="productColumnTitle"  id="productColumnTitle"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*链接</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input class="form-control" name="productColumnUrl"  id="productColumnUrl"/>
                </div>
            </div>
            
      		<div id="hideDiv">
				<div class="form-group">
	                <label class="control-label  col-xs-12 col-lg-2">*类型</label>
	                <div class="col-xs-12 col-lg-4 input-group">
	                    <select class="form-control" name="productType"  id="type">
	                	<option value="0">--请选择--</option>
	                    <c:forEach items="${typeList}" var="propertyValue">
	                    	<option value="${propertyValue.propertyValueId}" <c:if test="${propertyValue.propertyValueId eq product.productType}">selected="selected"</c:if>>${propertyValue.propertyValue}</option>
	                    </c:forEach>
	                    </select>
	                </div>
	            </div>
	            <div class="form-group">
	                <label class="control-label  col-xs-12 col-lg-2">*风格</label>
	                <div class="col-xs-12 col-lg-4 input-group">
	                	<select class="form-control" name="productStyle" id="style">
	                	<option value="0">--请选择--</option>
	                    	<c:forEach items="${styleList}" var="propertyValue">
	                    		<option value="${propertyValue.propertyValueId}" >${propertyValue.propertyValue}</option>
	                    	</c:forEach>
	                    </select>
	                </div>
	            </div>
	            <div class="form-group">
	                <label class="control-label col-xs-12 col-lg-2">*形状</label>
	                <div class="col-xs-12 col-lg-4 input-group">
	                	<select class="form-control" name="productShape" id="shape">
	                	<option value="0">--请选择--</option>
	                    	<c:forEach items="${shapeList}" var="propertyValue">
	                    		<option value="${propertyValue.propertyValueId}" >${propertyValue.propertyValue}</option>
	                    	</c:forEach>
	                    </select>
	                </div>
	            </div>
	             <div class="form-group">
	                <label class="control-label  col-xs-12 col-lg-2">*材质</label>
	                <div class="col-xs-12 col-lg-4 input-group" id="materialDiv">
	                	<select class="form-control" name="productMaterial" id="productMaterial">
	                	<option value="0">--请选择--</option>
		                    <c:forEach items="${materilList}" var="propertyValue">
		                  		<option value="${propertyValue.propertyValueId}" >${propertyValue.propertyValue}</option>
		                  	</c:forEach>
	                  	</select>
	                </div>
	            </div>
	            <div class="form-group">
	                <label class="control-label  col-xs-12 col-lg-2">*空间</label>
	                <div class="col-xs-12 col-lg-4 input-group" id="spaceDiv">
	                	<select class="form-control" name="productSpace" id="productSpace">
	                	<option value="0">--请选择--</option>
	                     <c:forEach items="${spaceList}" var="propertyValue">
	                     	<option value="${propertyValue.propertyValueId}" >${propertyValue.propertyValue}</option>
	                   	</c:forEach>
	                   	</select>
	                </div>
	            </div>
	            
            </div>
            <!-- [[商品轮播 -->
	            <div class="form-group">
	                <label class="control-label col-xs-12 col-lg-2">
	                    *栏目图片
	                </label>
	                <div class="col-xs-12 col-lg-9 imgArea" id="carouselImg">
	                    <!-- [[添加图片 -->
	                    <div class="col-xs-6 col-sm-2 col-lg-2">
	                        <div class="img-content add-content">
	                            <input type="file"  class="fileInp"/>
	                            <span class="add">&#43;</span>
	                            <img src="" alt="" class="img-responsive" />
	                            <input type="hidden" name="productColumnPic" value=""/>
	                            <span class="cancel" >&#88;</span>
	                        </div>
	                    </div><!-- 添加图片]] -->
	
	                </div>
	            </div><!-- [[商品轮播 -->
            <button class="btn btn-primary">提交</button>
        </form>
    </div><!-- 商品详情操作区 -->

    </div><!-- rightConten右边区域]] -->

    </div><!-- mainBody页面主体]] -->
	
    <footer>
    </footer>
    <!--[[遮罩层-->
	<div class="shadow" style="display: none;"></div>
    <script src="<%=request.getContextPath()%>/resources/backStage/script/product.js"></script>
	<script src="<%=request.getContextPath() %>/resources/backStage/script/lrz.bundle.js"></script>
</body>
<script type="text/javascript">
	function checkForm(){
		/* if($("select[name='userId']").val()==0){
			alert("请选择厂家");return false;
		}
		
		if($("#illustration").find(".img-content").length<2){
			alert("请至少上传一张产品描述图");return false;
		}
		if($("input[name='unitPrice']").val().trim()==""){
			alert("请填写出厂价");return false;
		}else{
			if(isNaN($("input[name='unitPrice']").val().trim())){
				alert("请填写正确格式出厂价");return false;
			}
		}
		if($("input[name='productStock']").val().trim()==""){
			alert("请填写库存");return false;
		}else{
			if(isNaN($("input[name='productStock']").val().trim())){
				alert("请填写正确格式库存");return false;
			}
		}
		if($("input[name='productKind']:checked").val()==undefined){
			alert("请选择货型");return false;
		}
		if($("input[name='productMaterial']").val()==""){
			alert("请选择至少一种材质");return false;
		}
		if($("input[name='productSpace']").val()==""){
			alert("请选择至少一种空间");return false;
		}
		if($("input[name='productOnlineTime']").val()==""){
			alert("请选择上线时间");return false;
		}
		if($("input[name='rentTerm']").val()==""){
			alert("请选择租期");return false;
		} */
		return true;
	}
	
	function submitForm(){
		if(checkForm())
			return true;
		else
			return false;
	}
	
	function passProduct(){
		window.location.href="<%=request.getContextPath()%>/platform/passProduct?productId=${product.productId}&buttonFlag=${buttonFlag}";
	}
	
	function refuseProduct(){
		window.location.href="<%=request.getContextPath()%>/platform/refuseProduct?productId=${product.productId}&buttonFlag=${buttonFlag}";
	}
	
	function changePrice(){
		var unitPrice=$("input[name='unitPrice']").val()==""?0:parseFloat($("input[name='unitPrice']").val().match(/\d+(\.\d+)?/g));
		var servicePrice=$("input[name='servicePrice']").val()==""?0:parseFloat($("input[name='servicePrice']").val().match(/\d+(\.\d+)?/g));
		var shoperSpreadMoney=$("input[name='shoperSpreadMoney']").val()==""?0:parseFloat($("input[name='shoperSpreadMoney']").val().match(/\d+(\.\d+)?/g));
		var freight=$("input[name='freight']").val()==""?0:parseFloat($("input[name='freight']").val().match(/\d+(\.\d+)?/g));
		var woodenFee=$("input[name='woodenFee']").val()==""?0:parseFloat($("input[name='woodenFee']").val().match(/\d+(\.\d+)?/g));
		$("#retailPrice").val((unitPrice+servicePrice+shoperSpreadMoney+freight+woodenFee).toFixed(2));
	}
	
	function getLamp(value){
		var url="<%=request.getContextPath()%>/platform/getLamp";
		var params={lampId:value};
		doAjax("GET",url,params,success,fail,false,false);
	}
	
	function fail(data){
		alert("fail");
	}
	
	function changeProductColumnType(value){
		if(value==0){
			$("#hideDiv").show();
		}else{
			$("#hideDiv").hide();
		}
	}
	
	$("#hideDiv select").change(function(){
		var that = this;
		$("#hideDiv select").each(function(){
			if(this!=that){
				$(this).val("0");
			}
		})
	})
	
	function upload(maxNum,_this){
		var imgcontent = $(_this).parents(".img-content");
		var data = new FormData();
		imgcontent.find('.fileInp').remove();
		data.append("file",_this.files[0])
		var index = parent.find('.img-content').length;

		
		$.ajax({
			type : "post",
			url : "<%=request.getContextPath()%>/file/uploadProductColumnPic",
			data : data,
			processData : false,
			contentType : false,
			success : function(data){
				if(data.code === 1){
					imgcontent.find('.add').hide();
					imgcontent.find('img').attr({'src':data.data}).show();
					imgcontent.find('.cancel').show();
					imgcontent.find('input[type="hidden"]').val(data.data);
					imgcontent.removeClass('add-content');
				}
			},
			error : function(data){
				alert("----error----");
			}
		});
	}
	
	$(document).on("change",".fileInp",function(){
		upload(1,this);
	});
</script>
</html>