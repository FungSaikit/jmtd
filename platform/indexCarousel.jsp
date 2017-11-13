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
                	<c:forEach items="${carouselList}" var="carousel" varStatus="i">
                    <form class="col-sm-5 img-form" data-value="${carousel.carouselId }">
                        <img src="${carousel.carouselPic}" alt=""/>
                        <div class="oprate clearfix">
                             <span class="col-md-4">
                                  <button class="col-md-4 btn btn-info uploadImgBtn">
                                      <input type="file" accept="image/*" class="selFile" />
                                      <input type="hidden" name="carouselPic" value="${carousel.carouselPic }"/>
                                      <input type="hidden" name="carouselId" value="${carousel.carouselId }"/>
                                      <span class="glyphicon glyphicon-cloud-upload">上传</span> 
                                  </button>
                             </span>
                            <span class="col-md-4 text-center">图${i.index+1 }</span>
                            <span class="col-md-4 text-right">
                                <button class="btn btn-danger updateImgBtn"  type="button" onclick="deleteCarousel(this)">删除</button>
                            </span>
                        </div>
                        <p></p>
                       	 轮播图链接：<input type="text" name="carouselLink" value="${carousel.carouselLink}" style="width:200px"/>&nbsp;
                        <button class=" updateImgBtn"  type="button" onclick="addCarousel(this)">更新</button>
                   		
                    </form>
                   </c:forEach>
                </div>
            </div>

        </div>

    </div><!-- rightConten右边区域]] -->

    </div><!-- mainBody页面主体]] -->

    <footer>
    </footer>
	<script>
		$(".selFile").change(function(){
			var url="<%=request.getContextPath()%>/file/uploadCarousel";
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
			var carouselId=form.find("input[name='carouselId']").val();
			var carouselPic=form.find("input[name='carouselPic']").val();
			var carouselLink=form.find("input[name='carouselLink']").val();
			var url="<%=request.getContextPath()%>/platform/addCarousel?carouselId="+carouselId;
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
			var form = $(obj).parents(".img-form");
			var carouselId=form.find("input[name='carouselId']").val();
			var url="<%=request.getContextPath()%>/platform/deleteCarousel";
			var params={carouselId:carouselId};
			doAjax("GET",url,params,successDelete,fail,false,false);
		}
		
		function successDelete(data){
			$("form[data-value='"+data.data+"']").find("img").attr("src","#");
		}
	</script>
</body>
</html>