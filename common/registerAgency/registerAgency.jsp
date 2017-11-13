<%@ page language="java" import="java.util.*,com.alphaking.constant.*,com.alphaking.model.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>佐为照明</title>
    <link href="<%=request.getContextPath() %>/resources/common/bootstrap.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/customer/assets/css/personCenter.css?12" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
    <style>
		.fileInp {
		    width: 100%;
		    height: 100%;
		    cursor: pointer;
		    -ms-filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=0);
		    filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=0);
		    opacity: 0;
		    position: absolute;
		    left: 0;
		    top: 0;
		    z-index: 200;
		}
	</style>
</head>
<body>
<c:set var="UNAUTHORIZED" value="<%=UserCheckStatus.UNAUTHORIZED%>" />
<c:set var="AUTHORIZING" value="<%=UserCheckStatus.AUTHORIZING%>" />
<c:set var="AUTHENTICATION_FAILURE" value="<%=UserCheckStatus.AUTHENTICATION_FAILURE%>" />
<c:set var="AUTHENTICATION_SUCCESS" value="<%=UserCheckStatus.AUTHENTICATION_SUCCESS%>" />
<c:set var="AGENCY" value="<%=UserType.AGENCY%>" />
<c:set var="FACILITATOR" value="<%=UserType.FACILITATOR%>" />
<div class="distributor">
    <div class="title">认证申请</div>
	
    <form class="form-horizontal form" action="<%=request.getContextPath()%>/user/registerAgency">
    	<input type="hidden" name="userId" value="${user.userId }"/>
     	<div class="form-group">
            <label for="organization" class="col-xs-5 control-label text-right" >微信昵称：</label>
            <div class="col-xs-6">
                ${user.userNickname }
            </div>
        </div>
        <div class="form-group">
            <label>公司名</label>
            <input type="text" id="organization" name="companyName" class="form-control" autofocus <c:if test="${!empty application }">value="${application.companyName}"</c:if>/>
        </div>
        <div class="form-group">
            <label>公司简称</label>
            <input type="text" id="organization" name="shortCompanyName" class="form-control" <c:if test="${!empty application }">value="${application.shortCompanyName}"</c:if>/>
        </div>
        <div class="form-group">
            <label>营业执照号</label>
            <input type="text" id="code" name="businessLicenceNumber" class="form-control" <c:if test="${!empty application }">value="${application.businessLicenceNumber}"</c:if>/>
        </div>
        <div class="form-group">
            <label>企业法人</label>
            <input type="text" id="contact-man" name="legalPerson" class="form-control" <c:if test="${!empty application }">value="${application.legalPerson}"</c:if>/>
        </div>
        <div class="form-group">
            <label>注册手机号</label>
            <input type="text" id="contact-type" name="contact" class="form-control" <c:if test="${!empty application }">value="${application.contact}"</c:if>/>
        </div>
        <div class="form-group">
            <label>省</label>
            <select name="provinceId" onchange="queryCity(this.value)" id="province" class="form-control"><option></option>
	           	<c:forEach items="${provinceList }" var="province">
	           		<option value="${province.addressId}" >${province.addressName }</option>
	           	</c:forEach>
           	</select>
        </div>
        <div class="form-group">
            <label>市</label>
            <select name="cityId" id="city" onchange="queryArea(this.value)" class="form-control"></select>
        </div>
        <div class="form-group">
            <label>区</label>
            <select name="areaId" id="area" class="form-control"></select>
        </div>
        <div class="form-group">
            <label>详细地址</label>
            <input type="text" id="contact-type" name="companyAddressDetail" class="form-control" <c:if test="${!empty application }">value="${application.companyAddressDetail}"</c:if>/>
        </div>
        
         <div class="imgDiv">
             <div class="imgContent notEmpty">
                 <input type="hidden" class="imgUrl" value="${application.businessLicencePic}" name="businessLicencePic"/>
                 <img src="<c:if test='${!empty application }'>${application.businessLicencePic}</c:if>" alt="" <c:if test='${empty application }'>style="display: none;"</c:if>/>
                 <span class="add" <c:if test='${!empty application }'>style="display: none;"</c:if>><i class="iconfont">&#xe628;</i></span>
                 <input type="file" class="fileInp"/>
             </div>
             <div class="imgTitle">营业执照</div>
         </div>
          <div class="imgDiv">
             <div class="imgContent">
                <input type="hidden" class="imgUrl" value="${application.lpHandheldIdcardPic}" name="lpHandheldIdcardPic"/>
                <img src="<c:if test='${!empty application }'>${application.lpHandheldIdcardPic}</c:if>" alt="" <c:if test='${empty application }'>style="display: none;"</c:if>/>
                <span class="add" <c:if test='${!empty application }'>style="display: none;"</c:if>><i class="iconfont">&#xe628;</i></span>
                <input type="file" class="fileInp"/>
            </div>
            <div class="imgTitle">法人手持身份证</div>
         </div>
        <div class="imgDiv">
            <div class="imgContent">
                <input type="hidden" class="imgUrl" value="${application.lpIdcardFrontPic}" name="lpIdcardFrontPic"/>
                <img src="<c:if test='${!empty application }'>${application.lpIdcardFrontPic}</c:if>" alt="" <c:if test='${empty application }'>style="display: none;"</c:if>/>
                <span class="add" <c:if test='${!empty application }'>style="display: none;"</c:if>><i class="iconfont">&#xe628;</i></span>
                <input type="file" class="fileInp"/>
            </div>
            <div class="imgTitle">法人身份证正面</div>
        </div>
        <div class="imgDiv">
            <div class="imgContent">
                <input type="hidden" class="imgUrl" value="${application.lpIdcardBackPic}" name="lpIdcardBackPic"/>
                <img src="<c:if test='${!empty application }'>${application.lpIdcardBackPic}</c:if>" alt="" <c:if test='${empty application }'>style="display: none;"</c:if>/>
                <span class="add" <c:if test='${!empty application }'>style="display: none;"</c:if>><i class="iconfont">&#xe628;</i></span>
                <input type="file" class="fileInp"/>
            </div>
            <div class="imgTitle">法人身份证反面</div>
        </div>
        <div class="imgDiv">
            <div class="imgContent notEmpty">
                <input type="hidden" class="imgUrl" value="${application.jcv}" name="jcv"/>
                <img src="<c:if test='${!empty application }'>${application.jcv}</c:if>" alt="" <c:if test='${empty application }'>style="display: none;"</c:if>/>
                <span class="add" <c:if test='${!empty application }'>style="display: none;"</c:if>><i class="iconfont">&#xe628;</i></span>
                <input type="file" class="fileInp"/>
            </div>
            <div class="imgTitle">店面实景图</div>
        </div>
		
		<c:if test="${empty application||application.checkStatus==AUTHENTICATION_SUCCESS||application.isUpdate==1 }">
           <input type="submit" class="submit" value="提　交"/>
       
        </c:if>
    </form>
</div>

<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
<script src="<%=request.getContextPath() %>/resources/backStage/script/lrz.bundle.js"></script>
<script>
	function submitForm(){
		if($("#default").is(':checked')){
			$("#defaultFlag").val(1)
		}
		$("#form").submit();
	}
	
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
	
	function fail(){
		alert("fail");
	}
	
	$(function(){
		queryCity(${application.provinceId});
		queryArea(${application.cityId});
		$("#province").val(${application.provinceId});
		$("#city").val(${application.cityId});
		$("#area").val(${application.areaId});
	})
	
	$(document).on("change",".fileInp",function(){
		upload(this);
	});
	
	function upload(_this){
		var imgcontent = $(_this).parents(".imgContent");
    	var data = new FormData();
    	data.append("file",_this.files[0]);
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
    				
    				
    				var oWidth = imgcontent.width();
    				imgcontent.find("img").height( oWidth );
    				imgcontent.find("img").css("line-height", oWidth + "px");
    			}
    		},
    		error : function(data){
    			alert("----error----");
    		}
    	});
    }

	
	
	$(document).on("tap",".cancel",function(){
		var imgContent=$(this).parents(".imgContent");
		imgContent.find("img").attr("src","");
	  	imgContent.find("input[class='img-url']").val("");
	  	imgContent.find(".add").show();
	  	imgContent.find(".cancel").hide();
	  	imgContent.find("img").hide();
	});
	
	function updateInfo(){
		$("#qrCode").hide();
		$("#updateBtn").hide();
		$(".form").show();
	}
	
	function checkForm(){
		var flag=true;
		$(".form-control").each(function(){
			if($(this).val().trim()==""){
				alert($(this).parents(".form-group").find(".control-label").html().replace("：","不能为空"));
				flag=false;
				return false;
			}
		});
		
		$(".notEmpty").each(function(){
			if($(this).find(".img-url").val().trim()==""){
					alert($(this).parent().find(".img-title").html()+"不能为空");
					flag=false;
					return false;
			}
		});
		return flag;
	}
</script>
</body>
</html>
