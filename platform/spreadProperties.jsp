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
                    <form class="col-sm-5 img-form" action="<%=request.getContextPath()%>/platform/changeSpreadQrCodeConf" style="height:100%">
                        <p></p>
                       	 文字描述：<input type="text" name="content" value="${content}" style="width:200px"/>&nbsp;
                        <button class=" updateImgBtn"  >更新</button>
                   		
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
			var url="<%=request.getContextPath()%>/file/uploadPersonQrCodPic";
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
		          },  
		          error: function (data){  
		          }  			
			});
		});
		
		
	</script>
</body>
</html>