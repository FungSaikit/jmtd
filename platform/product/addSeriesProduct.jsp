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
        <form action="<%=request.getContextPath()%>/platform/addSeriesProduct" method="post" class="form-horizontal" onsubmit="return submitForm();">
            <input type="hidden" class="form-control" name="productStock" value="100"/>
            <input type="hidden" class="form-control" name="purchaseQuantity" value="1"/>
            <input type="hidden" class="form-control" name="rentTerm" value="1"/>
            
            <input type="hidden" class="form-control" value="1" name="userId" />
            <%-- <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">灯位编号</label>
                <div class="col-xs-12 col-lg-4 input-group">
                	<select class="form-control" name="lampPlaceId"> 
                    <option value="0">--请选择灯位--</option>
                    <c:forEach items="${lampPositionList}" var="lampPosition">
                    	<option value="${lampPosition.lampPositionId}">${lampPosition.lampPositionId}</option>
                    </c:forEach>
                    </select>
                    <!-- <input class="form-control" name="lampPlaceId" onchange="getLamp(this.value)"> -->
                </div>
            </div> --%>
			
           <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*型号</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text" class="form-control" id= value="${product.productCode}" name="productCode" />
                </div>
           </div>

            <!-- [[商品轮播 -->
            <div class="form-group">
                <label class="control-label col-xs-12 col-lg-2">
                    *商品轮播图
                    <p class="tip">（最少1张，最多5张）</p>
                </label>
                <div class="col-xs-12 col-lg-9 imgArea" id="carouselImg">
					
                    <!-- [[添加图片 -->
                    <div class="col-xs-6 col-sm-2 col-lg-2">
                        <div class="img-content add-content">
                            <input type="file"  class="fileInp"/>
                            <span class="add">&#43;</span>
                            <img src="" alt="" class="img-responsive" style="background-color: #3598DC;"/>
                            <input type="hidden"  value=""/>
                            <span class="cancel" >&#88;</span>
                        </div>
                    </div><!-- 添加图片]] -->

                </div>
            </div><!-- [[商品轮播 -->
            <!-- [[商品配图 -->
            <!-- <div class="form-group">
                <label class="control-label col-xs-12 col-lg-2">
                  	  png图
                </label>
                <div class="col-sx-12 col-lg-9 imgArea" id="pngPicture">
                    [[添加图片
                    <div class="col-xs-6 col-sm-2 col-lg-2">
                        <div class="img-content add-content">
                            <input type="file" class="fileInp"/>
                            <span class="add">&#43;</span>
                            <img src="" alt="" class="img-responsive" style="background-color: #3598DC;"/>
                            <input type="hidden"  value=""/>
                              <span class="cancel">&#88;</span>
                        </div>
                    </div>添加图片]]
                </div>
            </div> --><!-- 商品配图]] -->

            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*出厂价</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text" class="form-control" name="originUnitPrice" value="${product.unitPrice}" oninput="unitPrice1();"/>
                </div>
            </div>
            <%-- <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*业务员提成（%）</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text" class="form-control" value="3" id="spreadPercent" name="spreadPercent" oninput="unitPrice1();changePrice()"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*平台提成（%）</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text" class="form-control" value="0" id="platformPercent" name="platformPercent" oninput="unitPrice1();changePrice()"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*出厂价(加点后)</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text" class="form-control"  onchange="changePlatformPercent(this.value);halfPrice(this.value);" name="unitPrice" value="${product.unitPrice}" />
                </div>
            </div> --%>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*原价</label>	
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text" class="form-control" name="costPrice" value="${product.costPrice}"/>
                </div>
            </div>
            <%-- <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">木架费（元）</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text" class="form-control" value="${product.woodenFee}" name="woodenFee" oninput="changePrice()"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*物流费（元）</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text" class="form-control" value="${product.freight}" name="freight" oninput="changePrice()"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*上门安装费（元）</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text" class="form-control" value="${product.installPrice}" name="installPrice" oninput="changePrice()"/>
                </div>
            </div>
             <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*售后服务费（元）</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text" class="form-control" value="${product.servicePrice}" name="servicePrice" oninput="changePrice()"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*分佣金额（元）</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text" class="form-control" value="${product.shoperSpreadMoney}" name="shoperSpreadMoney" oninput="changePrice()"/>
                </div>
            </div> --%>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*全国建议零售价（元）</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text" class="form-control" value="${product.retailPrice}" id="retailPrice"  name="retailPrice"/>
                </div>
            </div>
            
            <!-- <div class="form-group">
                <label class="control-label  col-sm-12 col-lg-2">*库存</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text" class="form-control" name="productStock" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-sm-12 col-lg-2">*起订量</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text" class="form-control" name="purchaseQuantity"/>
                </div>
            </div> -->
           <%--  <div class="form-group">
                <label class="control-label  col-xs-2 col-lg-2">*收货地址</label>
                <div class="col-xs-12 col-lg-4 input-group">
                <select class="form-control" name="receiveAddress" id="type">
                    <c:forEach items="${addressList}" var="address">
                    	<option value="${address.receiveAddress.receiveAddressId}">${address.receiveAddress.receivePerson}-${address.receiveAddress.contactNumber}-${address.province }${address.city }${address.area }${address.receiveAddress.addressDetail }</option>
                    </c:forEach>
                </select>
                </div>
            </div> --%>
            
            <input type="hidden" value="178" name="receiveAddress"/>
            <div class="form-group">
                <label class="control-label  col-xs-2 col-lg-2">*货型</label>
                <div class="radio-inline">
                    <label>
                        <input type="radio" name="productKind" value="1" checked="checked"> 现货
                    </label>
                </div>
                <div class="radio-inline">
                    <label>
                        <input type="radio" name="productKind" value="0"  <c:if test="${product.productKind eq 0}">checked="checked"</c:if>> 订货
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
                <label class="control-label  col-xs-12 col-lg-2"><em style="color: #f00;font-size: 20px;">*</em>库存数量</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text" class="form-control" value="${product.productStock}" name="productStock"/>
                    <span id="stockInfo" style="color:red;display:none;">库存数量不能为空</span><br>
                </div>
                <span class="col-xs-12 col-lg-2"></span>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-2 col-lg-2">*状态</label>
            	<div class="radio-inline">
                    <label>
                        <input type="radio" name="productTag" value="" > 无
                    </label>
                </div>
            	<div class="radio-inline">
                    <label>
                        <input type="radio" name="productTag" value="爆款" > 爆款
                    </label>
                </div>
                 <div class="radio-inline">
                    <label>
                        <input type="radio" name="productTag" value="新品" > 新品
                    </label>
                </div>
                 <div class="radio-inline">
                    <label>
                        <input type="radio" name="productTag" value="活动" > 活动
                    </label>
                </div>
            </div> 
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*类型</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <select class="form-control" name="productType"  id="type">
                    <c:forEach items="${typeList}" var="propertyValue">
                    	<option value="${propertyValue.propertyValueId}" <c:if test="${propertyValue.propertyValueId eq product.productType}">selected="selected"</c:if>>${propertyValue.propertyValue}</option>
                    </c:forEach>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*空间</label>
                <div class="col-xs-12 col-lg-4 input-group" id="spaceDiv">
                	<input type="hidden" name="productSpace"/>
                     <c:forEach items="${spaceList}" var="propertyValue">
                     	<input type="checkbox" name="space" value="${propertyValue.propertyValueId }"  <c:forEach items="${fn:split(product.productSpace, ';')}" var="space"><c:if test="${space==propertyValue.propertyValueId }">checked</c:if></c:forEach>>${propertyValue.propertyValue}
                   	</c:forEach>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">颜色</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text" class="form-control" value="${product.productColor}" name="productColor"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">光源数量</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text" class="form-control" value="${product.lightNumber}" name="lightNumber" />
                </div>
            </div>
             <%-- <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">功率</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text" class="form-control" value="${product.productPower}" name="productPower" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">层数</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text" class="form-control" value="${product.productPlies}" name="productPlies" />
                </div>
            </div> --%>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">产品尺寸</label>
                <div class="col-lg-offset-2 col-xs-12 col-lg-4 input-group">
                    <span class="input-group-addon">长(L)</span>
                    <input type="text" class="form-control" value="${product.productLength}" name="productLength" />
                    <span class="input-group-addon">mm</span>
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-offset-2 col-xs-12 col-lg-4 input-group">
                    <span class="input-group-addon">宽(W)</span>
                    <input type="text" class="form-control" value="${product.productWidth}" name="productWidth"/>
                    <span class="input-group-addon">mm</span>
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-offset-2 col-xs-12 col-lg-4 input-group">
                    <span class="input-group-addon">高(H)</span>
                    <input type="text" class="form-control"  value="${product.productHeight}"  name="productHeight" />
                    <span class="input-group-addon">mm</span>
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-offset-2 col-xs-12 col-lg-4 input-group">
                    <span class="input-group-addon">直径(D)</span>
                    <input type="text" class="form-control" value="${product.productDiameter}"  name="productDiameter"/>
                    <span class="input-group-addon">mm</span>
                </div>
            </div>
            <%-- <div class="form-group">
                <div class="col-lg-offset-2 col-xs-12 col-lg-4 input-group">
                    <span class="input-group-addon">开孔</span>
                    <input type="text" class="form-control" value="${product.productTrompil}" name="productTrompil" />
                    <span class="input-group-addon">mm</span>
                </div>
            </div> --%>
            <div class="form-group">
                <div class="col-lg-offset-2 col-xs-12 col-lg-4 input-group">
                    <span class="input-group-addon">净重</span>
                    <input type="text" class="form-control" value="${product.productWeight}" name="productWeight" />
                    <span class="input-group-addon">kg</span>
                </div>
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
                    <span class="input-group-addon">高(H)</span>
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
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*上线时间</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="date" value="<%=new SimpleDateFormat("yyyy-MM-dd").format(new Date()) %>" class="form-control" value="${product.onlineTime}" name="productOnlineTime" />
                </div>
            </div>
            <!-- <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*租期(月)</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text" class="form-control" value="12" name="rentTerm" />
                </div>
            </div> -->
            <input type="hidden" name="lampPositionPrice"/>
            <input type="hidden" name="productSeriesId" value="${productSeriesId }"/>
            <!-- [[提交按钮-->
            <div class="form-group">
                <label class="control-label  col-sm-2 col-lg-2"></label>
                <div class="col-sm-9 col-lg-4 input-group">
                    <input type="submit" class="btn btn-primary" value="保存"/>
                </div>
            </div>
            <!-- 提交按钮]]-->

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
		if($("#carouselImg").find(".img-content").length<2){
			alert("请至少上传一张产品轮播图");return false;
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
		}
		return true;
	}

	function upload(parentId,maxNum,_this){
		var imgcontent = $(_this).parents(".img-content");
		var parent = imgcontent.parents(parentId);
		var data = new FormData();
		imgcontent.find('.fileInp').remove();
		data.append("file",_this.files[0])
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
					
					
				}
			},
			error : function(data){
				alert("----error----");
			}
		});
	
	}
	
	$('#carouselImg').on("change",".fileInp",function(){
		upload("#carouselImg",5,this);
	});
	$('#illustration').on("change",".fileInp",function(){
		upload("#illustration",20,this);
	});
	$('#pngPicture').on("change",".fileInp",function(){
		upload("#pngPicture",1,this);
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
				+ '<img src="" alt="" class="img" style="display: none;background-color: #3598DC;" />'
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
		/* platformPercent=parseFloat($("input[name='unitPrice']").val(sss))/parseFloat($("input[name='originUnitPrice']").val())-(100+parseInt($("input[name='spreadPercent']").val()))/100.0;
		$("input[name='platformPercent']").val(parseInt(platformPercent*10000)/100); */
		platformPercent=1-parseFloat($("input[name='originUnitPrice']").val())/parseFloat($("input[name='unitPrice']").val())-parseFloat($("input[name='spreadPercent']").val())/100.0;
		$("input[name='platformPercent']").val(parseInt(platformPercent*10000)/100);
	}
</script>
</html>