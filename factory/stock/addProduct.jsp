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
    <title>繁灯网供应商管理系统</title>
    <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/resources/backStage/image/favicon.ico" />

    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/common/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/common/bootstrapValidator.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/backStage/css/index.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/backStage/css/product.css?11" />
</head>
<body>
     <!-- [[页面主体 -->
	 <jsp:include page="/jsp/factory/stock/navigation.jsp"></jsp:include>

    <!-- [[商品详情操作区 -->
    <div class="area productDetail">
        <form action="<%=request.getContextPath()%>/stock/addProduct" method="post" id="defaultForm" class="form-horizontal" onsubmit="return submitForm();">
			<input type="hidden" class="form-control" name="purchaseQuantity" value="1"/>
           <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2"><em style="color: #f00;font-size: 20px;">*</em>型号</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text" class="form-control" id="productCode" value="${product.productCode}" name="productCode"/>
                	<span id="userNameInfo" style="color:red;display:none;">型号不能为空</span><br>
                </div>
            </div>
            <!-- [[商品轮播 -->
            <div class="form-group">
                <label class="control-label col-xs-12 col-lg-2">
                    <em style="color: #f00;font-size: 20px;">*</em>商品轮播图
                    <p class="tip">（最少1张，最多5张）</p>
                </label>
                <div class="col-xs-12 col-lg-9 imgArea" id="carouselImg">
                    <!-- [[添加图片 -->
                    <div class="col-xs-6 col-sm-2 col-lg-2">
                        <div class="img-content add-content">
                            <input type="file"  class="fileInp form-control" name="secondFile"  multiple="multiple"/>
                            <span class="add">&#43;</span>
                            <img src="" alt="" class="img-responsive" />
                            <input type="hidden"  value=""/>
                            <span class="cancel" >&#88;</span>
                        </div>
                    </div>
                    <!-- 添加图片]] -->
                </div>
                <span class="col-xs-12 col-lg-2"></span>
                <span  class="col-xs-9 col-sm-9 col-lg-9" id="carouselImgInfo" style="color:red;display:none;">轮播图至少上传一张，至多上传五张</span>
            </div><!-- [[商品轮播 -->

            <%-- <!-- [[商品描述 -->
            <div class="form-group">
                <label class="control-label col-xs-12 col-lg-2">商品描述</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <textarea name="productContent" class="form-control" id="introduce" rows="5">${product.productContent}</textarea>
                </div>
            </div> <!-- 商品描述]] --> --%>

            <!-- [[商品配图 -->
            <div class="form-group">
                <label class="control-label col-xs-12 col-lg-2">
                  	  <em style="color: #f00;font-size: 20px;">*</em>详情图
                    <p class="tip">（最多20张）</p>
                </label>
                <div class="col-sx-12 col-lg-9 imgArea"  id="illustration">
                    <!-- [[添加图片 -->
                    <div class="col-xs-6 col-sm-2 col-lg-2">
                        <div class="img-content add-content">
                            <input type="file" class="fileInp" name="illustration" />
                            <span class="add">&#43;</span>
                            <img src="" alt="" class="img-responsive" />
                            <input type="hidden"  value=""/>
                              <span class="cancel">&#88;</span>
                        </div>
                    </div><!-- 添加图片]] -->
                </div>
                <span class="col-xs-12 col-lg-2"></span>
                <span  class="col-xs-9 col-sm-9 col-lg-9" id="illustrationInfo" style="color:red;display:none">详情图至少上传一张，最多上传二十张</span>
            </div><!-- 商品配图]] -->
            
            <!-- [[商品配图 -->
            <div class="form-group">
                <label class="control-label col-xs-12 col-lg-2">
                  	  <em style="color: #f00;font-size: 20px;">*</em>配灯图（png格式)
                </label>
                <!-- <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text" class="form-control imageInput" id="" value="" name="pngfileText" />
                </div> -->
                <div class="col-sx-12 col-lg-9 imgArea" id="pngPicture">
                    <!-- [[添加图片 -->
                    <div class="col-xs-6 col-sm-2 col-lg-2">
                        <div class="img-content add-content">
                            <input type="file" class="fileInp" name="pngFile" accept="image/png" />
                            <span class="add">&#43;</span>
                            <img src="" alt="" class="img-responsive" />
                            <input type="hidden"  value="" name="pngFile" />
                              <span class="cancel">&#88;</span>
                        </div>
                    </div><!-- 添加图片]] -->
                </div>
                <span class="col-xs-12 col-lg-2"></span>
                <span  class="col-xs-9 col-sm-9 col-lg-9" id="pngpictureInfo" style="color:red;display:none">png图至少上传一张 </span>
            </div><!-- 商品配图]] -->

            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2"><em style="color: #f00;font-size: 20px;">*</em>出厂价</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text"  class="form-control" name="originUnitPrice" value="${product.originUnitPrice}"/>
                	<span id="moneyInfo" style="color:red;display:none;">请输入正确的数字形式</span>
                	<span id="moneyNullInfo" style="color:red;display:none;">价格不能为空</span>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-2 col-lg-2"><em style="color: #f00;font-size: 20px;">*</em>货型</label>
                <div class="radio-inline">
                    <label>
                        <input type="radio" name="productKind" value="1" checked="checked"> 现货
                    </label>
                </div>
                <div class="radio-inline">
                    <label>
                        <input type="radio" name="productKind" value="0" > 订货
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2"><em style="color: #f00;font-size: 20px;">*</em>交货期</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text" class="form-control" value="${product.deliveryTime}" name="deliveryTime"/>
                    <span id="deliveryInfo" style="color:red;display:none;">交货期不能为空</span><br>
                </div>
                <span class="col-xs-12 col-lg-2"></span>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2"><em style="color: #f00;font-size: 20px;">*</em>类型</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <select class="form-control" name="productType"  id="type">
                    <c:forEach items="${typeList}" var="propertyValue">
                    	<option value="${propertyValue.propertyValueId}" <c:if test="${propertyValue.propertyValueId eq product.productType}">selected="selected"</c:if>>${propertyValue.propertyValue}</option>
                    </c:forEach>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2"><em style="color: #f00;font-size: 20px;">*</em>风格</label>
                <div class="col-xs-12 col-lg-4 input-group">
                	<select class="form-control" name="productStyle" id="style">
                    	<c:forEach items="${styleList}" var="propertyValue">
                    		<option value="${propertyValue.propertyValueId}" >${propertyValue.propertyValue}</option>
                    	</c:forEach>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2"><em style="color: #f00;font-size: 20px;">*</em>形状</label>
                <div class="col-xs-12 col-lg-4 input-group">
                	<select class="form-control" name="productShape" id="shape">
                    	<c:forEach items="${shapeList}" var="propertyValue">
                    		<option value="${propertyValue.propertyValueId}" >${propertyValue.propertyValue}</option>
                    	</c:forEach>
                    </select>
                </div>
            </div>
             <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2"><em style="color: #f00;font-size: 20px;">*</em>材质</label>
                <div class="col-xs-12 col-lg-4 input-group" id="materialDiv">
                	<input type="hidden" name="productMaterial"/>
                    <c:forEach items="${materilList}" var="propertyValue">
                  		<input type="checkbox" name="material" value="${propertyValue.propertyValueId }" <c:forEach items="${fn:split(product.productMaterial, ';')}" var="materil"><c:if test="${materil==propertyValue.propertyValueId }">checked</c:if></c:forEach>>${propertyValue.propertyValue}
                  	</c:forEach>
                  	<br><span id="materialInfo" style="color:red;display:none;">请选择至少一种材质</span>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2"><em style="color: #f00;font-size: 20px;">*</em>空间</label>
                <div class="col-xs-12 col-lg-4 input-group" id="spaceDiv">
                	<input type="hidden" name="productSpace"  class="productSpace" />
                     <c:forEach items="${spaceList}" var="propertyValue">
                     	<input type="checkbox" name="space" value="${propertyValue.propertyValueId }"  <c:forEach items="${fn:split(product.productSpace, ';')}" var="space"><c:if test="${space==propertyValue.propertyValueId }">checked</c:if></c:forEach>>${propertyValue.propertyValue}
                   	</c:forEach>
                   	<br><span id="spaceInfo" style="color:red;display:none;">请选择至少一种空间</span>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2"><em style="color: #f00;font-size: 20px;">*</em>库存数量</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text" class="form-control" value="${product.productStock}" name="productStock"/>
                    <span id="stockInfo" style="color:red;display:none;">库存数量不能为空</span><br>
                </div>
                <span class="col-xs-12 col-lg-2"></span>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">颜色</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text" class="form-control" value="${product.productColor}" name="productColor"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">光源类型</label>
                <div class="col-xs-12 col-lg-4 input-group">
                	<select class="form-control" name="lightType" id="lighttype">
                		<c:forEach items="${lightTypeList}" var="propertyValue">
                			<option value="${propertyValue.propertyValueId}" <c:if test="${propertyValue.propertyValueId==product.lightType}">selected="selected"</c:if>>${propertyValue.propertyValue}</option>
                		</c:forEach>
                	</select>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2"><em style="color: #f00;font-size: 20px;">*</em>光源数量</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text" class="form-control" value="${product.lightNumber}" name="lightNumber"/>
                    <span id="numberInfo" style="color:red;display:none;">光源数量不能为空</span><br>
                </div>
                <span class="col-xs-12 col-lg-2"></span>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">功率</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text" class="form-control" value="${product.productPower}" name="productPower"/>
                	<span id="powerInfo" style="color:red;display:none;">功率不能为空</span><br>
                </div>
            </div>
             <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">层数</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text" class="form-control" value="${product.productPlies}" name="productPlies"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2"><em style="color: #f00;font-size: 20px;">*</em>产品尺寸</label>
                <div class="col-lg-offset-2 col-xs-12 col-lg-4 input-group">
                    <span class="input-group-addon">长(L)</span>
                    <input type="text" class="form-control" value="${product.productLength}" name="productLength" />
                    <span class="input-group-addon">mm</span>
                </div>
                 <span class="col-xs-12 col-lg-2"></span><span id="lengthInfo" class="col-xs-12 col-lg-4" style="color:red;display:none;">请填写正确的长度</span>
            </div>
            <div class="form-group">
                <div class="col-lg-offset-2 col-xs-12 col-lg-4 input-group">
                    <span class="input-group-addon">宽(W)</span>
                    <input type="text" class="form-control" value="${product.productWidth}" name="productWidth"/>
                    <span class="input-group-addon">mm</span>
                </div>
                <span class="col-xs-12 col-lg-2"></span><span id="widthInfo" class="col-xs-12 col-lg-4" style="color:red;display:none;">请填写正确的宽度</span>
            </div>
            <div class="form-group">
                <div class="col-lg-offset-2 col-xs-12 col-lg-4 input-group">
                    <span class="input-group-addon">直径(D)</span>
                    <input type="text" class="form-control" value="${product.productDiameter}"  name="productDiameter"/>
                    <span class="input-group-addon">mm</span>
                </div>
                <span class="col-xs-12 col-lg-2"></span>
                <span id="lwdInfo" class="col-xs-12 col-lg-4" style="color:red;display:none;">请填写长度高度 或者 直径</span>
                <span id="diameterInfo" class="col-xs-12 col-lg-4" style="color:red;display:none;">请填写正确的直径</span>
            </div>
            <div class="form-group">
                <div class="col-lg-offset-2 col-xs-12 col-lg-4 input-group">
                    <span class="input-group-addon">高(H)</span>
                    <input type="text" class="form-control"  value="${product.productHeight}"  name="productHeight" />
                    <span class="input-group-addon">mm</span>
                </div>
                <span class="col-xs-12 col-lg-2"></span><span id="heightInfo" 
                class="col-xs-12 col-lg-4" style="color:red;display:none;">高度不能为空</span>
            </div>
            <div class="form-group">
                <div class="col-lg-offset-2 col-xs-12 col-lg-4 input-group">
                    <span class="input-group-addon">净重</span>
                    <input type="text" class="form-control" value="${product.productWeight}" name="productWeight" />
                    <span class="input-group-addon">kg</span>
                </div>
                <span class="col-xs-12 col-lg-2"></span><span id="weightInfo" class="col-xs-12 col-lg-4" style="color:red;display:none;">灯重不能为空</span>
            </div>
            <div class="form-group">
                <div class="col-lg-offset-2 col-xs-12 col-lg-4 input-group">
                    <span class="input-group-addon">其他</span>
                    <input type="text" class="form-control" value="${product.productSize}" name="productSize" />
                    <span class="input-group-addon"></span>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">包装尺寸</label>
                <div class="col-lg-offset-2 col-xs-12 col-lg-4 input-group">
                    <span class="input-group-addon">长(L)</span>
                    <input type="text" class="form-control" value="${product.packageLength}" name="packageLength" />
                    <span class="input-group-addon">cm</span>
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-offset-2 col-xs-12 col-lg-4 input-group">
                    <span class="input-group-addon">宽(W)</span>
                    <input type="text" class="form-control" value="${product.packageWidth}" name="packageWidth"/>
                    <span class="input-group-addon">cm</span>
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-offset-2 col-xs-12 col-lg-4 input-group">
                    <span class="input-group-addon">高(D)</span>
                    <input type="text" class="form-control"  value="${product.packageHeight}"  name="packageHeight" />
                    <span class="input-group-addon">cm</span>
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-offset-2 col-xs-12 col-lg-4 input-group">
                    <span class="input-group-addon">毛重</span>
                    <input type="text" class="form-control" value="${product.packageWeight}" name="packageWeight" />
                    <span class="input-group-addon">kg</span>
                </div>
            </div>
            <!-- [[提交按钮-->
            <div class="form-group">
                <label class="control-label  col-sm-2 col-lg-2"></label>
                <div class="col-sm-9 col-lg-4 input-group">
                    <input type="submit" class="btn btn-primary" value="保存"/>
                    <c:if test="${product.checkStatus==1 }">
             	      	 <input type="button" class="btn btn-primary" onclick="passProduct()" value="通过审核"/>
             	      	 <input type="button" class="btn btn-primary" onclick="refuseProduct()" value="不通过审核"/>
                    </c:if>
                </div>
            </div>
            <!-- 提交按钮]]-->

        </form>
    </div><!-- 商品详情操作区 -->

    </div><!-- rightConten右边区域]] -->

    </div><!-- mainBody页面主体]] -->
	<div class="proerr"></div>
    <footer>
    </footer>
    <!--[[遮罩层-->
	<div class="shadow" style="display: none;"></div>
	<script src="<%=request.getContextPath()%>/resources/common/jquery.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/common/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/backStage/script/product.js"></script>
	<script src="<%=request.getContextPath() %>/resources/backStage/script/lrz.bundle.js"></script>
	<script src="<%=request.getContextPath() %>/resources/backStage/script/validate.js?12"></script>
</body>
<script type="text/javascript">
		 
	/* ============验证=========== */

	function upload(parentId,maxNum,_this){
		var imgcontent = $(_this).parents(".img-content");
		var parent = imgcontent.parents(parentId);
		var imageInput = $(_this).parents(".form-group").find(".imageInput");
		var data = new FormData();
		imgcontent.find('.fileInp').remove();
		data.append("file",_this.files[0]);
		var index = parent.find('.img-content').length;

		if(index < maxNum) {
              	parent.append(addDom());
              	var imgContainer = $(".img-content");
  				var oWidth = imgContainer.width();
  				imgContainer.height( oWidth );
  				imgContainer.css("line-height", oWidth + "px");
         		}
		$.ajax({
			type : "post",
			url : "<%=request.getContextPath()%>/file/uploadProductPic",
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
					imageInput.val(1);
				}
			},
			error : function(data){
				alert("----error----");
			}
		});
	
	}
	
	$('#carouselImg').on("change",".fileInp",function(){
		console.log(this)
    	var fileTypes = new Array("jpg","png","jpeg");  //定义可支持的文件类型数组
		if(fileChange(this,fileTypes)){
			upload("#carouselImg",5,this);
		}
	});
	$('#illustration').on("change",".fileInp",function(){
    	var fileTypes = new Array("jpg","png","jpeg");  //定义可支持的文件类型数组
		if(fileChange(this,fileTypes)){
		upload("#illustration",20,this);
		}
	});
	$('#pngPicture').on("change",".fileInp",function(){
    	var fileTypes = new Array("png");  //定义可支持的文件类型数组
		if(fileChange(this,fileTypes)){
			upload("#pngPicture",1,this);
		}
		
	});

	
	function submitForm(){
		var i=1;
		$("#carouselImg .img-content").each(function(){
			if(!$(this).hasClass("add-content")){
				$(this).find("input[type='hidden']").attr("name","cover"+i);
				i++;
			}	
		});
		
		var j=1;
		$("#illustration .img-content").each(function(){
			if(!$(this).hasClass("add-content")){
				$(this).find("input[type='hidden']").attr("name","descriptionPic"+j);
				j++;
			}	
		});
		 
		
		$("#pngPicture .img-content").each(function(){
			if(!$(this).hasClass("add-content")){
				$(this).find("input[type='hidden']").attr("name","productPngPic");
			}	
		});
		
		var materialStr="";
		$("#materialDiv input[name='material']").each(function(){
			if($(this).is(':checked'))
				materialStr+=$(this).val()+";";
		});
		materialStr=";"+materialStr;
		$("input[name='productMaterial']").val(materialStr);
		
		var spaceStr="";
		$("#spaceDiv input[name='space']").each(function(){
			if($(this).is(':checked'))
				spaceStr+=$(this).val()+";";
		});
		spaceStr=";"+spaceStr;
		$("input[name='productSpace']").val(spaceStr);
		if(checkForm())
			return true;
		else
			return false;
		}
	
	
	function addDom() {
		return '<div class="col-xs-6 col-sm-2 col-lg-2">'
				+ '<div class="img-content add-content">'
				+ '<input type="file" class="fileInp"/>'
				+ '<span class="add">&#43;</span>'
				+ '<img src="" alt="" class="img" style="display: none" />'
				+ '<input type="hidden"  value=""/>'
				+ '<span class="cancel" style="display: none;">&#88;</span>'
				+ '</div>' + '</div>';
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
	
	function success(data){
		if(data.code==1)
			$("#input[name='lampPositionPrice']").val(data.lampPositionPrice);
		else{
			if(data.code==2)
				alert("灯位已被使用");
			else
				alert("灯位不存在");
		}
	}
	
	function fail(data){
		alert("fail");
	}
	
	function changeBrand(){
		if($("select[name='userId']").val()!="")
			$("input[name='productBrand']").val($("select[name='userId']").find("option:selected").text());
		else
			$("input[name='productBrand']").val("");
	}
	
	function halfPrice(price){
		var halfPrice= (parseFloat(price)/2.0).toFixed(2);
		$("input[name='servicePrice']").val(halfPrice);
		$("input[name='shoperSpreadMoney']").val(halfPrice);
		$("input[name='freight']").val(halfPrice);
		$("input[name='installPrice']").val(halfPrice);
		changePrice();
	}
	   
	function unitPrice1(){
		console.log((($("input[name='spreadPercent']").val()+$("input[name='platformPercent']").val())));
		var originUnitPrice=parseFloat($("input[name='originUnitPrice']").val());
		var spreadPercent=parseFloat($("input[name='spreadPercent']").val()/100);
		var platformPercent=parseFloat($("input[name='platformPercent']").val()/100);

		var value=originUnitPrice/(1-spreadPercent-platformPercent);//originUnitPrice*spreadPercent+originUnitPrice*platformPercent+originUnitPrice;
		$("input[name='unitPrice']").val(value.toFixed(2));
		halfPrice(value.toFixed(2));
	}
	
	function changePlatformPercent(value){
		var platformPercent;
		/* platformPercent=parseFloat($("input[name='unitPrice']").val())/parseFloat($("input[name='originUnitPrice']").val())-(100+parseInt($("input[name='spreadPercent']").val()))/100.0;
		$("input[name='platformPercent']").val(parseInt(platformPercent*10000)/100); */
		platformPercent=1-parseFloat($("input[name='originUnitPrice']").val())/parseFloat($("input[name='unitPrice']").val())-parseFloat($("input[name='spreadPercent']").val())/100.0;
		$("input[name='platformPercent']").val(parseInt(platformPercent*10000)/100);
	}
</script>
</html>