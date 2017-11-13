<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html lang="en">
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
	<div class="wrapper">
		<jsp:include page="/jsp/platform/header.jsp"></jsp:include>
		<jsp:include page="/jsp/platform/navigation.jsp"></jsp:include>
            <div class="area">
                <!-- [[上传说明 -->
                <label>上传图片尺寸要求为2:1</label>
                <div class="row indexCarousel">
                    <form class="col-sm-5 img-form" data-value="${welcomePic.welcomePicId }">
                        <img src="${welcomePic.welcomePicUrl}" alt=""/>
                        <div class="oprate clearfix">
                             <span class="col-md-4">
                                  <button class="col-md-4 btn btn-info uploadImgBtn">
                                      <input type="file" accept="image/*" class="selFile" />
                                      <input type="hidden" name="welcomePicUrl" value="${welcomePic.welcomePicUrl }"/>
                                      <input type="hidden" name="welcomePicId" value="${welcomePic.welcomePicId }"/>
                                      <span class="glyphicon glyphicon-cloud-upload">上传</span> 
                                  </button>
                             </span>
                            <span class="col-md-4 text-center">图${i.index+1 }</span>
                            <span class="col-md-4 text-right">
                                <button class="btn btn-danger updateImgBtn"  type="button" onclick="deleteCarousel(this)">删除</button>
                            </span>
                        </div>
                        <p></p>
                       	 轮播图链接：<input type="text" name="welcomePicLink" value="${welcomePic.welcomePicLink}" style="width:200px"/>&nbsp;
                        <button class=" updateImgBtn"  type="button" onclick="updateCarousel(this)">更新</button>
                   		
                    </form>
                </div>
            </div>

        </div>

    </div><!-- rightConten右边区域]] -->

    </div><!-- mainBody页面主体]] -->

    <footer>
    </footer>
	<script>
		$(".selFile").change(function(){
			var url="<%=request.getContextPath()%>/file/uploadWelcomePic";
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
		        	  $(that).parents(".img-form").find("img").attr("src",data.data);
		        	  addCarousel($(that).parents(".img-form").find(".updateImgBtn")[0]);
		          },  
		          error: function (data){  
		          }  			
			});
		});
		
		function addCarousel(obj){
			var form = $(obj).parents(".img-form");
			var welcomePicId=form.find("input[name='welcomePicId']").val();
			var welcomePicUrl=form.find("input[name='welcomePicUrl']").val();
			var welcomePicLink=form.find("input[name='welcomePicLink']").val();
			var url="<%=request.getContextPath()%>/platform/addWelcomePic?welcomePicId="+welcomePicId;
			var params={welcomePicUrl:welcomePicUrl,welcomePicLink:welcomePicLink};
			doAjax("GET",url,params,success,fail,false,false);
		}
		
		function updateCarousel(obj){
			var form = $(obj).parents(".img-form");
			var welcomePicId=form.find("input[name='welcomePicId']").val();
			var welcomePicUrl=form.find("input[name='welcomePicUrl']").val();
			var welcomePicLink=form.find("input[name='welcomePicLink']").val();
			var url="<%=request.getContextPath()%>/platform/updateWelcomePic?welcomePicId="+welcomePicId;
			var params={welcomePicUrl:welcomePicUrl,welcomePicLink:welcomePicLink};
			doAjax("GET",url,params,success,fail,false,false);
		}
		
		
		function success(data){
			//alert("success");
			location.reload();
		}
		
		function fail(data){
			alert("fail");
		}
		
		function deleteCarousel(obj){
			var form = $(obj).parents(".img-form");
			var welcomePicId=form.find("input[name='welcomePicId']").val();
			var url="<%=request.getContextPath()%>/platform/deleteWelcomePic";
			var params={welcomePicId:welcomePicId};
			doAjax("GET",url,params,successDelete,fail,false,false);
		}
		
		function successDelete(data){
			$("form[data-value='"+data.data+"']").find("img").attr("src","#");
			location.reload();
		}
	</script>
</body>
</html>