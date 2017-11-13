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
            <form class="form" action="<%=request.getContextPath()%>/platform/setAfterSaleRepair" onsubmit="return checkForm();">
	    	<input type="hidden" name="afterSaleId" value="${afterSaleId }"/>
	        <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*配件名称</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text" class="form-control" name="afterSaleRepairName" />
                </div>
            </div>
	        <div class="form-group">
                <label class="control-label  col-xs-12 col-lg-2">*配件数量</label>
                <div class="col-xs-12 col-lg-4 input-group">
                    <input type="text" class="form-control" name="afterSaleNumber" />
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
  
    </script>
</body>


</html>
