<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html>
  <head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>管理后台</title>
    <link rel="icon" type="image/x-icon" href="<%=request.getContextPath() %>/resources/image/favicon.ico" />

    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/common/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/backStage/css/index.css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/backStage/css/systemManager.css">
  </head>
  
  <body>
  	<jsp:include page="/jsp/platform/header.jsp"></jsp:include>
	<jsp:include page="/jsp/platform/navigation.jsp"></jsp:include>
		<div class="area">
                <!-- [[上传说明 -->
                <label>上传图片尺寸要求为2:1</label>
                <c:forEach items="${payQrCodeList }" var="payQrCode">
                <div class="row indexCarousel">
                    <form style="border:0px;" class="col-sm-5 img-form" action="<%=request.getContextPath()%>/platform/setPayQrCode" >
                        <img class="payQrCode" src="${payQrCode.payQrCodePic}" alt=""/>
                        <div class="oprate clearfix" style="bottom:-10px;">
                             <span class="col-md-4">
                                  <button class="col-md-4 btn btn-info uploadImgBtn" >
                                      <input type="file" class="selFile" />
                                      <input type="hidden" name="payQrCodePic" value="${payQrCode.payQrCodePic }"/>
                                      <input type="hidden" name="payQrCodeId" value="${payQrCode.payQrCodeId }"/>
                                      <input type="hidden" name="payQrCodeUserId" value="${payQrCode.payQrCodeUserId }"/>
                                      <span class="glyphicon glyphicon-cloud-upload">上传</span> 
                                  </button>
                             </span>
                            <span class="col-md-4 text-right">
                                <button class="btn btn-danger updateImgBtn"  type="button" onclick="deleteCarousel(this)">删除</button>
                            </span>
                        </div>
                        <p></p>
                    </form>
                </div>
                </c:forEach>
                
            </div>
            
                
           

    </div><!-- 页面主体的右边]] -->
    </div><!-- 页面主体]] -->
    <script>
	    $(function(){
	    	$(".payQrCode").height($(".payQrCode").width());
	    })
	    
	    $(".selFile").change(function(){
			var url="<%=request.getContextPath()%>/file/uploadPayQrPic";
			var formData = new FormData();
			formData.append("file", this.files[0]);
			var that=this;
			$.ajax({
				  url: url ,  
		          type: 'POST',  
		          data:formData, 
				  processData : false,  
		          contentType : false,  
		          success: function (data){ 
		        	  $(that).next().val(data.data);
		        	  $(that).parents(".img-form").find("img").attr("src",data.data);/* 
		        	  addCarousel($(that).parents(".img-form").find(".updateImgBtn")[0]); */
		        	  $(that).parents("form").submit();
		          },  
		          error: function (data){  
		          }  			
			});
		});
		
		function addCarousel(obj){
			var form = $(obj).parents(".img-form");
			var carouselId=form.find("input[name='payQrCodeId']").val();
			var carouselPic=form.find("input[name='payQrCodePic']").val();
			var carouselLink=form.find("input[name='carouselLink']").val();
			var url="<%=request.getContextPath()%>/platform/addPayQrCode?carouselId="+carouselId;
			var params={carouselPic:carouselPic,carouselLink:carouselLink};
			doAjax("GET",url,params,success,fail,false,false);
		}
		
		
		function success(data){
			//alert("success");
		}
		
		function fail(data){
			alert("fail");
		}
		
		function deleteCarousel(obj){
			<%-- var form = $(obj).parents(".img-form");
			var carouselId=form.find("input[name='carouselId']").val();
			var url="<%=request.getContextPath()%>/platform/deleteCarousel";
			var params={carouselId:carouselId};
			doAjax("GET",url,params,successDelete,fail,false,false); --%>
			window.location.href="<%=request.getContextPath()%>/platform/deletePayQrCode?payQrCodeId=${payQrCode.payQrCodeId}"
		}
		
		function successDelete(data){
			$("form[data-value='"+data.data+"']").find("img").attr("src","#");
		}
    </script>
  </body>
</html>
