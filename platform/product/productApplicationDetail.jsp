<%@ page language="java" import="java.util.*,java.text.SimpleDateFormat" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>  
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
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/backStage/css/product.css?1212" />
	
</head>
<body>
     <!-- [[头部 -->
     <jsp:include page="/jsp/platform/header.jsp"></jsp:include>
     <!-- [[页面主体 -->
	 <jsp:include page="/jsp/platform/navigation.jsp"></jsp:include>

    <!-- [[商品详情操作区 -->
    <div class="area productDetail">
        <div class="col-md-6" style="border-right:1px dashed rgba(158, 158, 158, 0.25);padding-right: 0;">
        	<div class="col-md-12 form-group txtfont" >原有</div>
			
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*厂家</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <select class="form-control" name="userId" onchange="changeBrand()"> 
                    <option value="0">--请选择厂家--</option>
                    <c:forEach items="${userList}" var="user">
                    	<option value="${user.userId}" <c:if test="${user.userId==product.userId}">selected</c:if>>${user.shortCompanyName}</option>
                    </c:forEach>
                    </select>
                </div>
            </div>
            
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">灯位编号</label>
                <div class="col-xs-12 col-lg-8 input-group">
                	<select class="form-control" name="lampPlaceId"> 
                    <option value="0">--请选择灯位--</option>
                    <c:forEach items="${lampPositionList}" var="lampPosition">
                    	<option value="${lampPosition.lampPositionId}">${lampPosition.lampPositionId}</option>
                    </c:forEach>
                    </select>
                    <!-- <input class="form-control" name="lampPlaceId" onchange="getLamp(this.value)"> -->
                </div>
            </div>
             <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">型号</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="text" class="form-control" value="${product.productCode}" disabled="true"  />
                </div>
            </div>

            <!-- [[商品轮播 -->
            <div class="form-group">
                <label class="control-label col-xs-12 col-lg-2">
                    商品轮播图
                    <p class="tip">（最少1张，最多5张）</p>
                </label>
                <div class="col-xs-12 col-lg-9 imgArea" >
					<c:if test="${not empty product.cover1}">
						<div class="col-xs-6 col-sm-2 col-lg-6">
                        <div class="img-content ">
                            <input type="file" accept="image/*" class="fileInp" style="display: none" />
                            <span class="add" style="display: none">+</span>
                            <img src="${product.cover1}" alt="" class="img-responsive" style="" />
                            <input type="hidden"  value="${product.cover1}"/>
                            <span class="cancel">&#88;</span>
                        </div>
                    </div>
					</c:if>
					
					<c:if test="${not empty product.cover2}">
						<div class="col-xs-6 col-sm-2 col-lg-6">
                        <div class="img-content ">
                            <input type="file" accept="image/*" class="fileInp" style="display: none" />
                            <span class="add" style="display: none">+</span>
                            <img src="${product.cover2}" alt="" class="img-responsive" style="" />
                            <input type="hidden"  value="${product.cover2}"/>
                            <span class="cancel">&#88;</span>
                        </div>
                    </div>
					</c:if>
					
					<c:if test="${not empty product.cover3}">
						<div class="col-xs-6 col-sm-2 col-lg-6">
                        <div class="img-content ">
                            <input type="file" accept="image/*" class="fileInp" style="display: none" />
                            <span class="add" style="display: none">+</span>
                            <img src="${product.cover3}" alt="" class="img-responsive" style="" />
                            <input type="hidden"  value="${product.cover3}"/>
                            <span class="cancel">&#88;</span>
                        </div>
                    </div>
					</c:if>
					
					<c:if test="${not empty product.cover4}">
						<div class="col-xs-6 col-sm-2 col-lg-6">
                        <div class="img-content ">
                            <input type="file" accept="image/*" class="fileInp" style="display: none" />
                            <span class="add" style="display: none">+</span>
                            <img src="${product.cover4}" alt="" class="img-responsive" style="" />
                            <input type="hidden"  value="${product.cover4}"/>
                            <span class="cancel">&#88;</span>
                        </div>
                    </div>
					</c:if>   
					
					<c:if test="${not empty product.cover5}">
						<div class="col-xs-6 col-sm-2 col-lg-6">
                        <div class="img-content ">
                            <input type="file" accept="image/*" class="fileInp" style="display: none" />
                            <span class="add" style="display: none">+</span>
                            <img src="${product.cover5}" alt="" class="img-responsive" style="" />
                            <input type="hidden"  value="${product.cover5}"/>
                            <span class="cancel">&#88;</span>
                        </div>
                    </div>
					</c:if>
                </div>
            </div><!-- [[商品轮播 -->

            <!-- [[商品描述 -->
            <div class="form-group">
                <label class="control-label col-xs-12 col-lg-2">商品描述</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <textarea  class="form-control" id="introduce" disabled="true" rows="5">${product.productContent}</textarea>
                </div>
            </div> <!-- 商品描述]] -->

            <!-- [[商品配图 -->
            <div class="form-group">
                <label class="control-label col-xs-12 col-lg-2">
                    配图
                    <p class="tip">（最多10张）</p>
                </label>
                <div class="col-sx-12 col-lg-9 imgArea" >

				<c:if test="${not empty product.descriptionPic1}">
					<div class="col-xs-6 col-sm-2 col-lg-6">
                        <div class="img-content">
                            <input type="file" accept="image/*" class="fileInp" style="display: none" />
                            <span class="add" style="display: none">+</span>
                            <img src="${product.descriptionPic1}" alt="" class="img-responsive" style="" />
                            <input type="hidden"  value="${product.descriptionPic1}"/>
                            <span class="cancel">&#88;</span>
                        </div>
                    </div>
				</c:if>
				
				<c:if test="${not empty product.descriptionPic2}">
					<div class="col-xs-6 col-sm-2 col-lg-6">
                        <div class="img-content">
                            <input type="file" accept="image/*" class="fileInp" style="display: none" />
                            <span class="add" style="display: none">+</span>
                            <img src="${product.descriptionPic2}" alt="" class="img-responsive" style="" />
                            <input type="hidden"  value="${product.descriptionPic2}"/>
                            <span class="cancel">&#88;</span>
                        </div>
                    </div>
				</c:if>
				
				<c:if test="${not empty product.descriptionPic3}">
					<div class="col-xs-6 col-sm-2 col-lg-6">
                        <div class="img-content">
                            <input type="file" accept="image/*" class="fileInp" style="display: none" />
                            <span class="add" style="display: none">+</span>
                            <img src="${product.descriptionPic3}" alt="" class="img-responsive" style="" />
                            <input type="hidden"  value="${product.descriptionPic3}"/>
                            <span class="cancel">&#88;</span>
                        </div>
                    </div>
				</c:if>
				
				<c:if test="${not empty product.descriptionPic4}">
					<div class="col-xs-6 col-sm-2 col-lg-6">
                        <div class="img-content">
                            <input type="file" accept="image/*" class="fileInp" style="display: none" />
                            <span class="add" style="display: none">+</span>
                            <img src="${product.descriptionPic4}" alt="" class="img-responsive" style="" />
                            <input type="hidden"  value="${product.descriptionPic4}"/>
                            <span class="cancel">&#88;</span>
                        </div>
                    </div>
				</c:if>
				
				<c:if test="${not empty product.descriptionPic5}">
					<div class="col-xs-6 col-sm-2 col-lg-6">
                        <div class="img-content">
                            <input type="file" accept="image/*" class="fileInp" style="display: none" />
                            <span class="add" style="display: none">+</span>
                            <img src="${product.descriptionPic5}" alt="" class="img-responsive" style="" />
                            <input type="hidden"  value="${product.descriptionPic5}"/>
                            <span class="cancel">&#88;</span>
                        </div>
                    </div>
				</c:if>
				
				<c:if test="${not empty product.descriptionPic6}">
					<div class="col-xs-6 col-sm-2 col-lg-6">
                        <div class="img-content">
                            <input type="file" accept="image/*" class="fileInp" style="display: none" />
                            <span class="add" style="display: none">+</span>
                            <img src="${product.descriptionPic6}" alt="" class="img-responsive" style="" />
                            <input type="hidden"  value="${product.descriptionPic6}"/>
                            <span class="cancel">&#88;</span>
                        </div>
                    </div>
				</c:if>
				
				<c:if test="${not empty product.descriptionPic7}">
					<div class="col-xs-6 col-sm-2 col-lg-6">
                        <div class="img-content">
                            <input type="file" accept="image/*" class="fileInp" style="display: none" />
                            <span class="add" style="display: none">+</span>
                            <img src="${product.descriptionPic7}" alt="" class="img-responsive" style="" />
                            <input type="hidden"  value="${product.descriptionPic7}"/>
                            <span class="cancel">&#88;</span>
                        </div>
                    </div>
				</c:if>
				
				<c:if test="${not empty product.descriptionPic8}">
					<div class="col-xs-6 col-sm-2 col-lg-6">
                        <div class="img-content">
                            <input type="file" accept="image/*" class="fileInp" style="display: none" />
                            <span class="add" style="display: none">+</span>
                            <img src="${product.descriptionPic8}" alt="" class="img-responsive" style="" />
                            <input type="hidden"  value="${product.descriptionPic8}"/>
                            <span class="cancel">&#88;</span>
                        </div>
                    </div>
				</c:if>

				<c:if test="${not empty product.descriptionPic9}">
					<div class="col-xs-6 col-sm-2 col-lg-6">
                        <div class="img-content">
                            <input type="file" accept="image/*" class="fileInp" style="display: none" />
                            <span class="add" style="display: none">+</span>
                            <img src="${product.descriptionPic9}" alt="" class="img-responsive" style="" />
                            <input type="hidden"  value="${product.descriptionPic9}"/>
                            <span class="cancel">&#88;</span>
                        </div>
                    </div>
				</c:if>
				
				<c:if test="${not empty product.descriptionPic10}">
					<div class="col-xs-6 col-sm-2 col-lg-6">
                        <div class="img-content">
                            <input type="file" accept="image/*" class="fileInp" style="display: none" />
                            <span class="add" style="display: none">+</span>
                            <img src="${product.descriptionPic10}" alt="" class="img-responsive" style="" />
                            <input type="hidden"  value="${product.descriptionPic10}"/>
                            <span class="cancel">&#88;</span>
                        </div>
                    </div>
				</c:if>
                </div>
            </div><!-- 商品配图]] -->
            
            <div class="form-group">
                <label class="control-label col-xs-12 col-lg-2">
                  	  png图
                </label>
                <div class="col-sx-12 col-lg-9 imgArea" id="pngPicture">
                 <c:if test="${!empty product.productPngPic}">
               	 <div class="col-xs-6 col-sm-2 col-lg-6">
                        <div class="img-content">
                            <input type="file" accept="image/*" class="fileInp" style="display: none" />
                            <span class="add" style="display: none">+</span>
                            <img src="${product.productPngPic}" alt="" class="img-responsive" style="" />
                            <input type="hidden"  value="${product.productPngPic}"/>
                            <span class="cancel">&#88;</span>
                        </div>
                    </div>
                  </c:if>
	            <c:if test="${empty product.productPngPic}">
	            <!-- [[商品配图 -->
	                    <!-- [[添加图片 -->
	                    <div class="col-xs-6 col-sm-2 col-lg-6">
	                        <div class="img-content add-content">
	                            <input type="file" class="fileInp"/>
	                            <span class="add">&#43;</span>
	                            <img src="" alt="" class="img-responsive" />
	                            <input type="hidden"  value=""/>
	                              <span class="cancel">&#88;</span>
	                        </div>
	                    </div><!-- 添加图片]] -->
	            </c:if>
                </div>
            </div><!-- 商品配图]] -->
			
             <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*出厂价</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="text" class="form-control"  value="${product.originUnitPrice}" disabled="true"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*业务员提成（%）</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="text" class="form-control" value="<fmt:formatNumber value="${product.spreadPercent*100}" pattern="0.##"/>"  disabled="true"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*平台提成（%）</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="text" class="form-control" value="<fmt:formatNumber value="${product.platformPercent*100}" pattern="0.##" />"  disabled="true"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*出厂价(加点后)</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="text" class="form-control" onchange="changePlatformPercent(this.value);halfPrice(this.value);" value="${product.unitPrice}" disabled="true"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*原价</label>	
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="text" class="form-control"  value="${product.costPrice}" disabled="true"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">木架费（元）</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="text" class="form-control" value="${product.woodenFee}"  disabled="true"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">物流费（元）</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="text" class="form-control" value="${product.freight}" disabled="true"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">上门安装费（元）</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="text" class="form-control" value="${product.installPrice}" disabled="true"/>
                </div>
            </div>
             <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">售后服务费（元）</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="text" class="form-control" value="${product.servicePrice}" disabled="true"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">分佣金额（元）</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="text" class="form-control" value="${product.shoperSpreadMoney}" disabled="true"/>
                </div>
            </div>
            
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">全国建议零售价（元）</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="text" class="form-control" value="${product.retailPrice }"  disabled/>
                </div>
            </div>
            <%-- 
            <div class="form-group">
                <label class="control-label  col-sm-12 col-lg-2">库存</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text" class="form-control" name="productStock" value="${product.productStock}"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-sm-12 col-lg-2">*起订量</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text" class="form-control" name="purchaseQuantity" value="${product.purchaseQuantity}"/>
                </div>
            </div> --%>
            <div class="form-group">
                <label class="control-label  col-xs-2 col-lg-2">*收货地址</label>
                <div class="col-xs-12 col-lg-8 input-group">
                <select class="form-control" name="receiveAddress" id="type">
                    <c:forEach items="${addressList}" var="address">
                    	<option <c:if test="${product.receiveAddress==address.receiveAddress.receiveAddressId }">selected</c:if> value="${address.receiveAddress.receiveAddressId}">${address.receiveAddress.receivePerson}-${address.receiveAddress.contactNumber}-${address.province }${address.city }${address.area }${address.receiveAddress.addressDetail }</option>
                    </c:forEach>
                </select>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-2 col-lg-2">货型</label>
                <div class="radio-inline">
                    <label>
                        <input type="radio" name="productKind" value="1" <c:if test="${product.productKind eq 1}">checked="checked"</c:if>> 现货
                    </label>
                </div>
                <div class="radio-inline">
                    <label>
                        <input type="radio" name="productKind" value="0"  <c:if test="${product.productKind eq 0}">checked="checked"</c:if>> 订货
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-2 col-lg-2">*状态</label>
            	<div class="radio-inline">
                    <label>
                        <input type="radio" name="productTag" value="" <c:if test="${empty product.productTag }">checked="checked"</c:if>> 无
                    </label>
                </div>
            	<div class="radio-inline">
                    <label>
                        <input type="radio" name="productTag" value="爆款" <c:if test="${product.productTag eq '爆款'}">checked="checked"</c:if>> 爆款
                    </label>
                </div>
                 <div class="radio-inline">
                    <label>
                        <input type="radio" name="productTag" value="新品" <c:if test="${product.productTag eq '新品'}">checked="checked"</c:if>> 新品
                    </label>
                </div>
                 <div class="radio-inline">
                    <label>
                        <input type="radio" name="productTag" value="活动" <c:if test="${product.productTag eq '活动'}">checked="checked"</c:if>> 活动
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">类型</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <select class="form-control" name="productType" id="type">
                    <c:forEach items="${typeList}" var="propertyValue">
                    	<option value="${propertyValue.propertyValueId}" <c:if test="${propertyValue.propertyValueId eq product.productType}">selected="selected"</c:if>>${propertyValue.propertyValue}</option>
                    </c:forEach>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">风格</label>
                <div class="col-xs-12 col-lg-8 input-group">
                	<select class="form-control" name="productStyle" id="style">
                    	<c:forEach items="${styleList}" var="propertyValue">
                    		<option value="${propertyValue.propertyValueId}" <c:if test="${propertyValue.propertyValueId==product.productStyle}">selected="selected"</c:if>>${propertyValue.propertyValue}</option>
                    	</c:forEach>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*形状</label>
                <div class="col-xs-12 col-lg-8 input-group">
                	<select class="form-control" name="productShape" id="shape">
                    	<c:forEach items="${shapeList}" var="propertyValue">
                    		<option value="${propertyValue.propertyValueId}" <c:if test="${propertyValue.propertyValueId==product.productShape}">selected="selected"</c:if>>${propertyValue.propertyValue}</option>
                    	</c:forEach>
                    </select>
                </div>
            </div>
             <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">材质</label>
                <div class="col-xs-12 col-lg-8 input-group" id="materialDiv">
                	<input type="hidden" name="productMaterial"/>
                    <c:forEach items="${materilList}" var="propertyValue">
                  		<input type="checkbox" name="material" value="${propertyValue.propertyValueId }" <c:forEach items="${fn:split(product.productMaterial, ';')}" var="materil"><c:if test="${materil==propertyValue.propertyValueId }">checked</c:if></c:forEach>>${propertyValue.propertyValue}
                  	</c:forEach>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">空间</label>
                <div class="col-xs-12 col-lg-8 input-group" id="spaceDiv">
                	<input type="hidden" name="productSpace"/>
                     <c:forEach items="${spaceList}" var="propertyValue">
                     	<input type="checkbox" name="space" value="${propertyValue.propertyValueId }"  <c:forEach items="${fn:split(product.productSpace, ';')}" var="space"><c:if test="${space==propertyValue.propertyValueId }">checked</c:if></c:forEach>>${propertyValue.propertyValue}
                   	</c:forEach>
                </div>
            </div>
             <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">品牌</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="text" class="form-control" disabled  value="${product.productBrand}" value="众享照明"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">颜色</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="text" class="form-control" disabled value="${product.productColor}"/>
                </div>
            </div>
           
           
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">光源类型</label>
                <div class="col-xs-12 col-lg-8 input-group">
                	<select class="form-control" name="lightType">
                		<%-- <option <c:if test="${product.lightType=='LED'}">selected</c:if>>LED</option>
                		<option <c:if test="${product.lightType=='E27'}">selected</c:if>>E27</option>
                		<option <c:if test="${product.lightType=='E14'}">selected</c:if>>E14</option>
                		<option <c:if test="${product.lightType=='GU10'}">selected</c:if>>GU10</option>
                		<option <c:if test="${product.lightType=='MR16'}">selected</c:if>>MR16</option>
                		<option <c:if test="${product.lightType=='G4'}">selected</c:if>>G4</option>
                		<option <c:if test="${product.lightType=='G9'}">selected</c:if>>G9</option>
                		<option <c:if test="${product.lightType=='E40'}">selected</c:if>>E40</option>
                		<option <c:if test="${product.lightType=='其他'}">selected</c:if>>其他</option> --%>
                		<c:forEach items="${lightTypeList}" var="propertyValue">
                			<option value="${propertyValue.propertyValueId}" <c:if test="${propertyValue.propertyValueId==product.lightType}">selected="selected"</c:if>>${propertyValue.propertyValue}</option>
                		</c:forEach>
                	</select>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">光源数量</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="text" class="form-control" disabled value="${product.lightNumber}"  />
                </div>
            </div>
             <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">功率</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="text" disabled class="form-control" value="${product.productPower}" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">层数</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="text" disabled class="form-control" value="${product.productPlies}"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">产品尺寸</label>
                <div class="col-lg-offset-2 col-xs-12 col-lg-8 input-group">
                    <span class="input-group-addon">长</span>
                    <input type="text" disabled class="form-control" value="${product.productLength}" />
                    <span class="input-group-addon">mm</span>
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-offset-2 col-xs-12 col-lg-8 input-group">
                    <span class="input-group-addon">宽</span>
                    <input type="text" disabled class="form-control" value="${product.productWidth}"/>
                    <span class="input-group-addon">mm</span>
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-offset-2 col-xs-12 col-lg-8 input-group">
                    <span class="input-group-addon">高</span>
                    <input type="text" disabled class="form-control"  value="${product.productHeight}" />
                    <span class="input-group-addon">mm</span>
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-offset-2 col-xs-12 col-lg-8 input-group">
                    <span class="input-group-addon">直径</span>
                    <input type="text" disabled class="form-control" value="${product.productDiameter}" />
                    <span class="input-group-addon">mm</span>
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-offset-2 col-xs-12 col-lg-8 input-group">
                    <span class="input-group-addon">净重</span>
                    <input type="text" disabled class="form-control" value="${product.productWeight}" />
                    <span class="input-group-addon">kg</span>
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-offset-2 col-xs-12 col-lg-8 input-group">
                    <span class="input-group-addon">其他</span>
                    <input type="text" disabled class="form-control" value="${product.productSize}" />
                    <span class="input-group-addon"></span>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">包装尺寸</label>
                <div class="col-lg-offset-2 col-xs-12 col-lg-8 input-group">
                    <span class="input-group-addon">长(L)</span>
                    <input type="text" disabled class="form-control" value="${product.packageLength}" />
                    <span class="input-group-addon">cm</span>
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-offset-2 col-xs-12 col-lg-8 input-group">
                    <span class="input-group-addon">宽(W)</span>
                    <input type="text" disabled class="form-control" value="${product.packageWidth}" />
                    <span class="input-group-addon">cm</span>
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-offset-2 col-xs-12 col-lg-8 input-group">
                    <span class="input-group-addon">高(D)</span>
                    <input type="text" disabled class="form-control"  value="${product.packageHeight}"  />
                    <span class="input-group-addon">cm</span>
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-offset-2 col-xs-12 col-lg-8 input-group">
                    <span class="input-group-addon">毛重</span>
                    <input type="text" disabled class="form-control" value="${product.packageWeight}" />
                    <span class="input-group-addon">kg</span>
                </div>
            </div>
			<div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*上线时间</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="date"  class="form-control" value="<c:if test="${product.productStatus==2}"><%=new SimpleDateFormat("yyyy-MM-dd").format(new Date()) %></c:if><c:if test="${product.productStatus!=2 }"><fmt:formatDate value="${product.onlineTime}" pattern="yyyy-MM-dd" /></c:if>" name="productOnlineTime" />
                </div>
            </div>
           
            </div>
            <!--==========================【 复制 -->
        	<form action="<%=request.getContextPath()%>/platform/updateProduct" method="post" class="form-horizontal " >
        	<div class="col-md-6" style="padding-right: 0;padding-left: 30px;">
        	<div class="col-md-12 form-group txtfont" >修改后</div>
			<input type="hidden" value="${product.productId }" name="productId">
			<input type="hidden" value="${productApplication.productApplicationId }" name="productApplicationId">
	        <input type="hidden" name="productSales" value="${product.productSales}">
	        <input type="hidden" name="productVisitCount" value="${product.productVisitCount}">
	        <input type="hidden" name="isPopular" value="${product.isPopular}">
	        <input type="hidden" name="buttonFlag" value="${buttonFlag}">
	        <c:if test="${!empty productQrCodePic }"><input type="hidden" name="productQrCodePic" value="${product.productQrCodePic }"></c:if>
	        <input type="hidden" name="productStatus" value="${product.productStatus }"/>
	        <input type="hidden" name="creatTime" value="${product.creatTime }"/>
	        <input type="hidden" name="productSeriesId" value="${product.productSeriesId }"/>
	        <input type="hidden" name="seriesIndex" value="${product.seriesIndex }"/>
	        <input type="hidden" name="seriesHead" value="${product.seriesHead }"/>
	        <input type="hidden" name="productFictionSales" value="${product.productFictionSales }"/>
	        <input type="hidden" name="productHeadType" value="${product.productHeadType }"/>
	        <input type="hidden" name="productQrCodePic" value="${product.productQrCodePic}"/>
	        <input type="hidden" name="isSpreadProduct" value="${product.isSpreadProduct}"/>
	        <input type="hidden" name="historySpreadProduct" value="${product.historySpreadProduct}"/>
	        <input type="hidden" name="productOriginUserId" value="${product.userId }"/>
	        <input type="hidden" class="form-control" name="productStock" value="100"/>
            <input type="hidden" class="form-control" name="purchaseQuantity" value="1"/>
	        <input type="hidden" class="form-control" name="productStock" value="${product.productStock }"/>
            <input type="hidden" class="form-control" name="purchaseQuantity" value="${product.purchaseQuantity }"/>
            <c:if test="${!empty product.publishTime }"><input type="hidden" name="publishTime" value="${product.publishTime}"></c:if>
	        <c:if test="${!empty product.offlineTime }"><input type="hidden" name="offlineTime" value="${product.offlineTime }"></c:if>
	        <c:if test="${!empty product.onlineTime }"><input type="hidden" name="onlineTime" value="${product.onlineTime }"></c:if>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*厂家</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <select class="form-control" name="userId" onchange="changeBrand()"> 
                    <option value="0">--请选择厂家--</option>
                    <c:forEach items="${userList}" var="user">
                    	<option value="${user.userId}" <c:if test="${user.userId==product.userId}">selected</c:if>>${user.shortCompanyName}</option>
                    </c:forEach>
                    </select>
                </div>
            </div>
            
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">灯位编号</label>
                <div class="col-xs-12 col-lg-8 input-group">
                	<select class="form-control" name="lampPlaceId"> 
                    <option value="0">--请选择灯位--</option>
                    <c:forEach items="${lampPositionList}" var="lampPosition">
                    	<option value="${lampPosition.lampPositionId}">${lampPosition.lampPositionId}</option>
                    </c:forEach>
                    </select>
                    <!-- <input class="form-control" name="lampPlaceId" onchange="getLamp(this.value)"> -->
                </div>
            </div>
             <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">型号</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="text" class="form-control" value="${productApplication.productCode}" name="productCode" />
                </div>
            </div>

            <!-- [[商品轮播 -->
            <div class="form-group">
                <label class="control-label col-xs-12 col-lg-2">
                    商品轮播图
                    <p class="tip">（最少1张，最多5张）</p>
                </label>
                <div class="col-xs-12 col-lg-9 imgArea" id="carouselImg">
					<c:if test="${not empty productApplication.cover1}">
						<div class="col-xs-6 col-sm-2 col-lg-6">
                        <div class="img-content ">
                            <input type="file" accept="image/*" class="fileInp" style="display: none" />
                            <span class="add" style="display: none">+</span>
                            <img src="${productApplication.cover1}" alt="" class="img-responsive" style="" />
                            <input type="hidden"  value="${productApplication.cover1}"/>
                            <span class="cancel">&#88;</span>
                        </div>
                    </div>
					</c:if>
					
					<c:if test="${not empty productApplication.cover2}">
						<div class="col-xs-6 col-sm-2 col-lg-6">
                        <div class="img-content ">
                            <input type="file" accept="image/*" class="fileInp" style="display: none" />
                            <span class="add" style="display: none">+</span>
                            <img src="${productApplication.cover2}" alt="" class="img-responsive" style="" />
                            <input type="hidden"  value="${productApplication.cover2}"/>
                            <span class="cancel">&#88;</span>
                        </div>
                    </div>
					</c:if>
					
					<c:if test="${not empty productApplication.cover3}">
						<div class="col-xs-6 col-sm-2 col-lg-6">
                        <div class="img-content ">
                            <input type="file" accept="image/*" class="fileInp" style="display: none" />
                            <span class="add" style="display: none">+</span>
                            <img src="${productApplication.cover3}" alt="" class="img-responsive" style="" />
                            <input type="hidden"  value="${productApplication.cover3}"/>
                            <span class="cancel">&#88;</span>
                        </div>
                    </div>
					</c:if>
					
					<c:if test="${not empty productApplication.cover4}">
						<div class="col-xs-6 col-sm-2 col-lg-6">
                        <div class="img-content ">
                            <input type="file" accept="image/*" class="fileInp" style="display: none" />
                            <span class="add" style="display: none">+</span>
                            <img src="${productApplication.cover4}" alt="" class="img-responsive" style="" />
                            <input type="hidden"  value="${productApplication.cover4}"/>
                            <span class="cancel">&#88;</span>
                        </div>
                    </div>
					</c:if>   
					
					<c:if test="${not empty productApplication.cover5}">
						<div class="col-xs-6 col-sm-2 col-lg-6">
                        <div class="img-content ">
                            <input type="file" accept="image/*" class="fileInp" style="display: none" />
                            <span class="add" style="display: none">+</span>
                            <img src="${productApplication.cover5}" alt="" class="img-responsive" style="" />
                            <input type="hidden"  value="${productApplication.cover5}"/>
                            <span class="cancel">&#88;</span>
                        </div>
                    </div>
					</c:if>
					
					<%-- <c:if test="${empty productApplication.cover5}">
                    <!-- [[添加图片 -->
                    <div class="col-xs-6 col-sm-2 col-lg-6">
                        <div class="img-content add-content">
                            <input type="file" accept="image/*" class="fileInp"/>
                            <span class="add">&#43;</span>
                            <img src="" alt="" class="img-responsive" />
                            <input type="hidden"  value=""/>
                            <span class="cancel" >&#88;</span>
                        </div>
                    </div><!-- 添加图片]] -->
                    </c:if> --%>

                </div>
            </div><!-- [[商品轮播 -->

            <!-- [[商品描述 -->
            <div class="form-group">
                <label class="control-label col-xs-12 col-lg-2">商品描述</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <textarea name="productContent" class="form-control" id="introduce" rows="5">${productApplication.productContent}</textarea>
                </div>
            </div> <!-- 商品描述]] -->

            <!-- [[商品配图 -->
            <div class="form-group">
                <label class="control-label col-xs-12 col-lg-2">
                   	 配图
                    <p class="tip">（最多10张）</p>
                </label>
                <div class="col-sx-12 col-lg-9 imgArea"  id="illustration">

				<c:if test="${not empty productApplication.descriptionPic1}">
					<div class="col-xs-6 col-sm-2 col-lg-6">
                        <div class="img-content">
                            <input type="file" accept="image/*" class="fileInp" style="display: none" />
                            <span class="add" style="display: none">+</span>
                            <img src="${productApplication.descriptionPic1}" alt="" class="img-responsive" style="" />
                            <input type="hidden"  value="${productApplication.descriptionPic1}"/>
                            <span class="cancel">&#88;</span>
                        </div>
                    </div>
				</c:if>
				
				<c:if test="${not empty productApplication.descriptionPic2}">
					<div class="col-xs-6 col-sm-2 col-lg-6">
                        <div class="img-content">
                            <input type="file" accept="image/*" class="fileInp" style="display: none" />
                            <span class="add" style="display: none">+</span>
                            <img src="${productApplication.descriptionPic2}" alt="" class="img-responsive" style="" />
                            <input type="hidden"  value="${productApplication.descriptionPic2}"/>
                            <span class="cancel">&#88;</span>
                        </div>
                    </div>
				</c:if>
				
				<c:if test="${not empty productApplication.descriptionPic3}">
					<div class="col-xs-6 col-sm-2 col-lg-6">
                        <div class="img-content">
                            <input type="file" accept="image/*" class="fileInp" style="display: none" />
                            <span class="add" style="display: none">+</span>
                            <img src="${productApplication.descriptionPic3}" alt="" class="img-responsive" style="" />
                            <input type="hidden"  value="${productApplication.descriptionPic3}"/>
                            <span class="cancel">&#88;</span>
                        </div>
                    </div>
				</c:if>
				
				<c:if test="${not empty productApplication.descriptionPic4}">
					<div class="col-xs-6 col-sm-2 col-lg-6">
                        <div class="img-content">
                            <input type="file" accept="image/*" class="fileInp" style="display: none" />
                            <span class="add" style="display: none">+</span>
                            <img src="${productApplication.descriptionPic4}" alt="" class="img-responsive" style="" />
                            <input type="hidden"  value="${productApplication.descriptionPic4}"/>
                            <span class="cancel">&#88;</span>
                        </div>
                    </div>
				</c:if>
				
				<c:if test="${not empty productApplication.descriptionPic5}">
					<div class="col-xs-6 col-sm-2 col-lg-6">
                        <div class="img-content">
                            <input type="file" accept="image/*" class="fileInp" style="display: none" />
                            <span class="add" style="display: none">+</span>
                            <img src="${productApplication.descriptionPic5}" alt="" class="img-responsive" style="" />
                            <input type="hidden"  value="${productApplication.descriptionPic5}"/>
                            <span class="cancel">&#88;</span>
                        </div>
                    </div>
				</c:if>
				
				<c:if test="${not empty productApplication.descriptionPic6}">
					<div class="col-xs-6 col-sm-2 col-lg-6">
                        <div class="img-content">
                            <input type="file" accept="image/*" class="fileInp" style="display: none" />
                            <span class="add" style="display: none">+</span>
                            <img src="${productApplication.descriptionPic6}" alt="" class="img-responsive" style="" />
                            <input type="hidden"  value="${productApplication.descriptionPic6}"/>
                            <span class="cancel">&#88;</span>
                        </div>
                    </div>
				</c:if>
				
				<c:if test="${not empty productApplication.descriptionPic7}">
					<div class="col-xs-6 col-sm-2 col-lg-6">
                        <div class="img-content">
                            <input type="file" accept="image/*" class="fileInp" style="display: none" />
                            <span class="add" style="display: none">+</span>
                            <img src="${productApplication.descriptionPic7}" alt="" class="img-responsive" style="" />
                            <input type="hidden"  value="${productApplication.descriptionPic7}"/>
                            <span class="cancel">&#88;</span>
                        </div>
                    </div>
				</c:if>
				
				<c:if test="${not empty productApplication.descriptionPic8}">
					<div class="col-xs-6 col-sm-2 col-lg-6">
                        <div class="img-content">
                            <input type="file" accept="image/*" class="fileInp" style="display: none" />
                            <span class="add" style="display: none">+</span>
                            <img src="${productApplication.descriptionPic8}" alt="" class="img-responsive" style="" />
                            <input type="hidden"  value="${productApplication.descriptionPic8}"/>
                            <span class="cancel">&#88;</span>
                        </div>
                    </div>
				</c:if>

				<c:if test="${not empty productApplication.descriptionPic9}">
					<div class="col-xs-6 col-sm-2 col-lg-6">
                        <div class="img-content">
                            <input type="file" accept="image/*" class="fileInp" style="display: none" />
                            <span class="add" style="display: none">+</span>
                            <img src="${productApplication.descriptionPic9}" alt="" class="img-responsive" style="" />
                            <input type="hidden"  value="${productApplication.descriptionPic9}"/>
                            <span class="cancel">&#88;</span>
                        </div>
                    </div>
				</c:if>
				
				<c:if test="${not empty productApplication.descriptionPic10}">
					<div class="col-xs-6 col-sm-2 col-lg-6">
                        <div class="img-content">
                            <input type="file" accept="image/*" class="fileInp" style="display: none" />
                            <span class="add" style="display: none">+</span>
                            <img src="${productApplication.descriptionPic10}" alt="" class="img-responsive" style="" />
                            <input type="hidden"  value="${productApplication.descriptionPic10}"/>
                            <span class="cancel">&#88;</span>
                        </div>
                    </div>
				</c:if>

               <%--  <c:if test="${empty productApplication.descriptionPic10}">
                    <!-- [[添加图片 -->
                    <div class="col-xs-6 col-sm-2 col-lg-6">
                        <div class="img-content add-content">
                            <input type="file" accept="image/*" class="fileInp"/>
                            <span class="add">&#43;</span>
                            <img src="" alt="" class="img-responsive" />
                            <input type="hidden"  value=""/>
                              <span class="cancel">&#88;</span>
                        </div>
                    </div><!-- 添加图片]] -->
				</c:if> --%>
                </div>
            </div><!-- 商品配图]] -->
            
            <div class="form-group">
                <label class="control-label col-xs-12 col-lg-2">
                  	  png图
                </label>
                <div class="col-sx-12 col-lg-9 imgArea" id="pngPicture">
                 <c:if test="${!empty productApplication.productPngPic}">
               	 <div class="col-xs-6 col-sm-2 col-lg-6">
                        <div class="img-content">
                            <input type="file" accept="image/*" class="fileInp" style="display: none" />
                            <span class="add" style="display: none">+</span>
                            <img src="${productApplication.productPngPic}" alt="" class="img-responsive" style="" />
                            <input type="hidden"  value="${productApplication.productPngPic}"/>
                            <span class="cancel">&#88;</span>
                        </div>
                    </div>
                  </c:if>
	            <c:if test="${empty productApplication.productPngPic}">
	            <!-- [[商品配图 -->
	                    <!-- [[添加图片 -->
	                    <div class="col-xs-6 col-sm-2 col-lg-6">
	                        <div class="img-content add-content">
	                            <input type="file" class="fileInp"/>
	                            <span class="add">&#43;</span>
	                            <img src="" alt="" class="img-responsive" />
	                            <input type="hidden"  value=""/>
	                              <span class="cancel">&#88;</span>
	                        </div>
	                    </div><!-- 添加图片]] -->
	            </c:if>
                </div>
            </div><!-- 商品配图]] -->
			
             <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*出厂价</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="text" class="form-control" name="originUnitPrice" value="${productApplication.originUnitPrice}" oninput="unitPrice1()"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*业务员提成（%）</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="text" class="form-control" value="<fmt:formatNumber value="${product.spreadPercent*100}" pattern="0.##"/>" id="spreadPercent" name="spreadPercent" oninput="unitPrice1();changePrice()"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*平台提成（%）</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="text" class="form-control" value="<fmt:formatNumber value="${product.platformPercent*100}" pattern="0.##" />" id="platformPercent" name="platformPercent" oninput="unitPrice1();changePrice()"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*出厂价(加点后)</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="text" class="form-control" onchange="changePlatformPercent(this.value);halfPrice(this.value);" name="unitPrice" value="${product.unitPrice}" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*原价</label>	
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="text" class="form-control" name="costPrice" value="${product.costPrice}"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">木架费（元）</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="text" class="form-control" value="${product.woodenFee}" name="woodenFee" oninput="changePrice()"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">物流费（元）</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="text" class="form-control" value="${product.freight}" name="freight" oninput="changePrice()"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">上门安装费（元）</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="text" class="form-control" value="${product.installPrice}" name="installPrice" oninput="changePrice()"/>
                </div>
            </div>
             <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">售后服务费（元）</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="text" class="form-control" value="${product.servicePrice}" name="servicePrice" oninput="changePrice()"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">分佣金额（元）</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="text" class="form-control" value="${product.shoperSpreadMoney}" name="shoperSpreadMoney" oninput="changePrice()"/>
                </div>
            </div>
            
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">全国建议零售价（元）</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="text" class="form-control" value="${product.retailPrice }" id="retailPrice"  disabled/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-2 col-lg-2">*收货地址</label>
                <div class="col-xs-12 col-lg-8 input-group">
                <select class="form-control" name="receiveAddress" id="type">
                    <c:forEach items="${addressList}" var="address">
                    	<option <c:if test="${product.receiveAddress==address.receiveAddress.receiveAddressId }">selected</c:if> value="${address.receiveAddress.receiveAddressId}">${address.receiveAddress.receivePerson}-${address.receiveAddress.contactNumber}-${address.province }${address.city }${address.area }${address.receiveAddress.addressDetail }</option>
                    </c:forEach>
                </select>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-2 col-lg-2">货型</label>
                <div class="radio-inline">
                    <label>
                        <input type="radio" name="productKind" value="1" <c:if test="${productApplication.productKind eq 1}">checked="checked"</c:if>> 现货
                    </label>
                </div>
                <div class="radio-inline">
                    <label>
                        <input type="radio" name="productKind" value="0"  <c:if test="${product.productKind eq 0}">checked="checked"</c:if>> 订货
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-2 col-lg-2">*状态</label>
            	<div class="radio-inline">
                    <label>
                        <input type="radio" name="productTag" value="" <c:if test="${empty product.productTag }">checked="checked"</c:if>> 无
                    </label>
                </div>
            	<div class="radio-inline">
                    <label>
                        <input type="radio" name="productTag" value="爆款" <c:if test="${product.productTag eq '爆款'}">checked="checked"</c:if>> 爆款
                    </label>
                </div>
                 <div class="radio-inline">
                    <label>
                        <input type="radio" name="productTag" value="新品" <c:if test="${product.productTag eq '新品'}">checked="checked"</c:if>> 新品
                    </label>
                </div>
                 <div class="radio-inline">
                    <label>
                        <input type="radio" name="productTag" value="活动" <c:if test="${product.productTag eq '活动'}">checked="checked"</c:if>> 活动
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">类型</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <select class="form-control" name="productType" id="type">
                    <c:forEach items="${typeList}" var="propertyValue">
                    	<option value="${propertyValue.propertyValueId}" <c:if test="${propertyValue.propertyValueId eq productApplication.productType}">selected="selected"</c:if>>${propertyValue.propertyValue}</option>
                    </c:forEach>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">风格</label>
                <div class="col-xs-12 col-lg-8 input-group">
                	<select class="form-control" name="productStyle" id="style">
                    	<c:forEach items="${styleList}" var="propertyValue">
                    		<option value="${propertyValue.propertyValueId}" <c:if test="${propertyValue.propertyValueId==productApplication.productStyle}">selected="selected"</c:if>>${propertyValue.propertyValue}</option>
                    	</c:forEach>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*形状</label>
                <div class="col-xs-12 col-lg-8 input-group">
                	<select class="form-control" name="productShape" id="shape">
                    	<c:forEach items="${shapeList}" var="propertyValue">
                    		<option value="${propertyValue.propertyValueId}" <c:if test="${propertyValue.propertyValueId==productApplication.productShape}">selected="selected"</c:if>>${propertyValue.propertyValue}</option>
                    	</c:forEach>
                    </select>
                </div>
            </div>
             <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">材质</label>
                <div class="col-xs-12 col-lg-8 input-group" id="materialDiv">
                	<input type="hidden" name="productMaterial"/>
                    <c:forEach items="${materilList}" var="propertyValue">
                  		<input type="checkbox" name="material" value="${propertyValue.propertyValueId }" <c:forEach items="${fn:split(productApplication.productMaterial, ';')}" var="materil"><c:if test="${materil==propertyValue.propertyValueId }">checked</c:if></c:forEach>>${propertyValue.propertyValue}
                  	</c:forEach>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">空间</label>
                <div class="col-xs-12 col-lg-8 input-group" id="spaceDiv">
                	<input type="hidden" name="productSpace"/>
                     <c:forEach items="${spaceList}" var="propertyValue">
                     	<input type="checkbox" name="space" value="${propertyValue.propertyValueId }"  <c:forEach items="${fn:split(productApplication.productSpace, ';')}" var="space"><c:if test="${space==propertyValue.propertyValueId }">checked</c:if></c:forEach>>${propertyValue.propertyValue}
                   	</c:forEach>
                </div>
            </div>
             <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">品牌</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="text" class="form-control"  value="${product.productBrand}" name="productBrand" value="众享照明"/>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">颜色</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="text" class="form-control" value="${productApplication.productColor}" name="productColor"/>
                </div>
            </div>
           
           
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">光源类型</label>
                <div class="col-xs-12 col-lg-8 input-group">
                	<select class="form-control" name="lightType">
                		<%-- <option <c:if test="${product.lightType=='LED'}">selected</c:if>>LED</option>
                		<option <c:if test="${product.lightType=='E27'}">selected</c:if>>E27</option>
                		<option <c:if test="${product.lightType=='E14'}">selected</c:if>>E14</option>
                		<option <c:if test="${product.lightType=='GU10'}">selected</c:if>>GU10</option>
                		<option <c:if test="${product.lightType=='MR16'}">selected</c:if>>MR16</option>
                		<option <c:if test="${product.lightType=='G4'}">selected</c:if>>G4</option>
                		<option <c:if test="${product.lightType=='G9'}">selected</c:if>>G9</option>
                		<option <c:if test="${product.lightType=='E40'}">selected</c:if>>E40</option>
                		<option <c:if test="${product.lightType=='其他'}">selected</c:if>>其他</option> --%>
                		<c:forEach items="${lightTypeList}" var="propertyValue">
                			<option value="${propertyValue.propertyValueId}" <c:if test="${propertyValue.propertyValueId==productApplication.lightType}">selected="selected"</c:if>>${propertyValue.propertyValue}</option>
                		</c:forEach>
                	</select>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">光源数量</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="text" class="form-control" value="${productApplication.lightNumber}" name="lightNumber" />
                </div>
            </div>
             <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">功率</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="text" class="form-control" value="${productApplication.productPower}" name="productPower" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">层数</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="text" class="form-control" value="${productApplication.productPlies}" name="productPlies" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">产品尺寸</label>
                <div class="col-lg-offset-2 col-xs-12 col-lg-8 input-group">
                    <span class="input-group-addon">长</span>
                    <input type="text" class="form-control" value="${productApplication.productLength}" name="productLength" />
                    <span class="input-group-addon">mm</span>
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-offset-2 col-xs-12 col-lg-8 input-group">
                    <span class="input-group-addon">宽</span>
                    <input type="text" class="form-control" value="${productApplication.productWidth}" name="productWidth"/>
                    <span class="input-group-addon">mm</span>
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-offset-2 col-xs-12 col-lg-8 input-group">
                    <span class="input-group-addon">高</span>
                    <input type="text" class="form-control"  value="${productApplication.productHeight}"  name="productHeight" />
                    <span class="input-group-addon">mm</span>
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-offset-2 col-xs-12 col-lg-8 input-group">
                    <span class="input-group-addon">直径</span>
                    <input type="text" class="form-control" value="${productApplication.productDiameter}"  name="productDiameter"/>
                    <span class="input-group-addon">mm</span>
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-offset-2 col-xs-12 col-lg-8 input-group">
                    <span class="input-group-addon">净重</span>
                    <input type="text" class="form-control" value="${productApplication.productWeight}" name="productWeight" />
                    <span class="input-group-addon">kg</span>
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-offset-2 col-xs-12 col-lg-8 input-group">
                    <span class="input-group-addon">其他</span>
                    <input type="text" class="form-control" value="${productApplication.productSize}" name="productSize" />
                    <span class="input-group-addon"></span>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">包装尺寸</label>
                <div class="col-lg-offset-2 col-xs-12 col-lg-8 input-group">
                    <span class="input-group-addon">长(L)</span>
                    <input type="text" class="form-control" value="${productApplication.packageLength}" name="packageLength" />
                    <span class="input-group-addon">cm</span>
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-offset-2 col-xs-12 col-lg-8 input-group">
                    <span class="input-group-addon">宽(W)</span>
                    <input type="text" class="form-control" value="${productApplication.packageWidth}" name="packageWidth"/>
                    <span class="input-group-addon">cm</span>
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-offset-2 col-xs-12 col-lg-8 input-group">
                    <span class="input-group-addon">高(D)</span>
                    <input type="text" class="form-control"  value="${productApplication.packageHeight}"  name="packageHeight" />
                    <span class="input-group-addon">cm</span>
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-offset-2 col-xs-12 col-lg-8 input-group">
                    <span class="input-group-addon">毛重</span>
                    <input type="text" class="form-control" value="${productApplication.packageWeight}" name="packageWeight" />
                    <span class="input-group-addon">kg</span>
                </div>
            </div>
			<div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*上线时间</label>
                <div class="col-xs-12 col-lg-8 input-group">
                    <input type="date"  class="form-control" value="<c:if test="${product.productStatus==2}"><%=new SimpleDateFormat("yyyy-MM-dd").format(new Date()) %></c:if><c:if test="${product.productStatus!=2 }"><fmt:formatDate value="${product.onlineTime}" pattern="yyyy-MM-dd" /></c:if>" name="productOnlineTime" />
                </div>
            </div>
            
            </div>
        <!--==============================】  -->
            <!-- [[提交按钮-->
            <div class="form-group">
                <label class="control-label  col-sm-5 col-lg-5"></label>
                <div class="col-sm-9 col-lg-4 input-group">
                	<c:if test="${productApplication.applicationStatus==0 }">
           	      	 <input type="button" class="btn btn-primary" onclick="passProduct()" value="通过审核"/>
           	      	 <input type="button" class="btn btn-primary" onclick="dispassProduct()" value="不通过审核"/>
           	      	 </c:if>
                </div>
            </div>
            <!-- 提交按钮]]-->

        </form>
        
    </div><!-- 商品详情操作区 -->

    </div><!-- rightConten右边区域]] -->

    </div><!-- mainBody页面主体]] -->

    <footer>
    </footer>
    <script src="<%=request.getContextPath()%>/resources/backStage/script/product.js"></script>
	<script src="<%=request.getContextPath() %>/resources/backStage/script/lrz.bundle.js"></script>

</body>
<script type="text/javascript">
	function changeBrand(){
		if($("select[name='userId']").val()!="")
			$("input[name='productBrand']").val($("select[name='userId']").find("option:selected").text());
		else
			$("input[name='productBrand']").val("");
	}

	
	function upload(parentId,maxNum,_this){
			var imgcontent = $(_this).parents(".img-content");
	    	var parent = imgcontent.parents(parentId);
	    	var data = new FormData();
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
    	upload("#illustration",10,this);
    });
	$('#pngPicture').on("change",".fileInp",function(){
		upload("#pngPicture",1,this);
	});
    
    function submitForm(){

		$("form").attr("action","<%=request.getContextPath()%>/platform/updateProduct");
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
		$("form").submit();
		
	}
    
	function addDom() {
		return '<div class="col-xs-6 col-sm-2 col-lg-6">'
				+ '<div class="img-content add-content">'
				+ '<input type="file" class="fileInp"/>'
				+ '<span class="add">&#43;</span>'
				+ '<img src="" alt="" class="img" style="display: none" />'
				+ '<input type="hidden"  value=""/>'
				+ '<span class="cancel" style="display: none;">&#88;</span>'
				+ '</div>' + '</div>';
	}
	
	function passProduct(){
		$("form").attr("action","<%=request.getContextPath()%>/platform/passProductApplication");
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
		$("form").submit();
	}
	
	function dispassProduct(){
		window.location.href="<%=request.getContextPath()%>/platform/dispassProductApplication?productApplicationId=${productApplication.productApplicationId}&buttonFlag=${buttonFlag}";
	}
	
	function changePrice(){
		var unitPrice=$("input[name='unitPrice']").val()==""?0:parseFloat($("input[name='unitPrice']").val().match(/\d+(\.\d+)?/g));
		var servicePrice=$("input[name='servicePrice']").val()==""?0:parseFloat($("input[name='servicePrice']").val().match(/\d+(\.\d+)?/g));
		var shoperSpreadMoney=$("input[name='shoperSpreadMoney']").val()==""?0:parseFloat($("input[name='shoperSpreadMoney']").val().match(/\d+(\.\d+)?/g));
		var freight=$("input[name='freight']").val()==""?0:parseFloat($("input[name='freight']").val().match(/\d+(\.\d+)?/g));
		var woodenFee=$("input[name='woodenFee']").val()==""?0:parseFloat($("input[name='woodenFee']").val().match(/\d+(\.\d+)?/g));
		$("#retailPrice").val((unitPrice+servicePrice+shoperSpreadMoney+freight+woodenFee).toFixed(2));
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
	

 	unitPrice1();
 	changePrice();
</script>
</html>