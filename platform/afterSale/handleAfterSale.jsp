<%@ page language="java" import="java.util.*,com.alphaking.constant.*,com.alphaking.model.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>管理后台</title>
    <link rel="icon" type="image/x-icon" href="../image/favicon.ico" />

    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/common/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/backStage/css/index.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/backStage/css/product.css" />
	
	
	
</head>
<body>
		<jsp:include page="/jsp/platform/header.jsp"></jsp:include>
		<jsp:include page="/jsp/platform/navigation.jsp"></jsp:include>
		<div class="order">
			<h3 style="text-align:center">处理售后</h3>
            <form class="form" action="<%=request.getContextPath()%>/platform/handleAfterSale" onsubmit="return checkForm();">
	    	<input type="hidden" name="afterSaleId" value="${afterSaleId }"/>
	        <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*解决方式</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text" class="form-control" name="afterSaleHandleDescription" />
                </div>
            </div>
	        <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*花费金额</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text" class="form-control" name="afterSaleMoney" />
                </div>
            </div>
	        <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*建议打木架</label>
                <div class="col-xs-12 col-lg-4 input-group">
	            <input type="checkbox" id="organization" name="suggestWooden" class="form-control radio"/>
                </div>
            </div>
	        
	        <div class="form-group">
                <label class="control-label col-xs-12 col-lg-2">
                    *说明图片
                </label>
                <div class="col-xs-12 col-lg-9 imgArea" id="carouselImg">
					
                    <!-- [[添加图片 -->
                    <div class="col-xs-6 col-sm-2 col-lg-2">
                        <div class="img-content add-content">
                            <input type="file"  class="fileInp"/>
                            <span class="add">&#43;</span>
                            <img src="" alt="" class="img-responsive" />
                            <input type="hidden" name="afterSaleHandlePic1"  value=""/>
                            <span class="cancel" >&#88;</span>
                        </div>
                    </div><!-- 添加图片]] -->

                </div>
            </div>
            
			<div class="form-group">
                <label class="control-label  col-sm-2 col-lg-2"></label>
                <div class="col-sm-9 col-lg-4 input-group">
                    <input type="submit" class="btn btn-primary" value="保存"/>
                </div>
            </div>
	    </form>
		</div>

    </div><!-- 页面主体的右边]] -->

    </div><!-- 页面主体]] -->

    <footer>

    </footer>
    
    <script src="<%=request.getContextPath()%>/resources/backStage/script/product.js"></script>
    <script>
    function upload(parentId,maxNum,_this){
		var imgcontent = $(_this).parents(".img-content");
		var parent = imgcontent.parents(parentId);
		var data = new FormData();
		imgcontent.find('.fileInp').remove();
		data.append("file",_this.files[0])
		$.ajax({
			type : "post",
			url : "<%=request.getContextPath()%>/file/uploadAfterSalePic",
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
					var index = parent.find('.img-content').length;

					if(index < maxNum) {
	                	parent.append(addDom());
	                	var imgContainer = $(".img-content");
	    				var oWidth = imgContainer.width();
	    				imgContainer.height( oWidth );
	    				imgContainer.css("line-height", oWidth + "px");
	           		}
					
				}
			},
			error : function(data){
				alert("----error----");
			}
		});
	
	}
	
	$('#carouselImg').on("change",".fileInp",function(){
		upload("#carouselImg",1,this);
	});
    </script>
</body>


</html>
