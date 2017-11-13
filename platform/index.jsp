<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>管理后台</title>
    <link rel="icon" type="image/x-icon" href="<%=request.getContextPath() %>/resources/backStage/image/favicon.ico" />

    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/common/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/backStage/css/index.css" /> 
</head>
<body>
		<jsp:include page="/jsp/platform/header.jsp"></jsp:include>
		<jsp:include page="/jsp/platform/navigation.jsp"></jsp:include>
        <!-- [[首页链接 -->
        <div class="row">
            <div class="col-xs-6 col-sm-4">
                <a class="indexBlock indexBlock1">
                    <i class="icon iconfont">&#xe603;</i>
                    累计消费${consumseMoney}
                </a>
            </div>
            <div class="col-xs-6 col-sm-4" onclick="window.location.href='<%=request.getContextPath()%>/platform/platformDetail'">
                <a class="indexBlock indexBlock2">
                    <i class="icon iconfont">&#xe604;</i>
                    平台流动资产${platformFlowMoney}
                </a>
            </div>
            <div class="col-xs-6 col-sm-4">
                <a class="indexBlock indexBlock3">
                    <i class="icon iconfont">&#xe601;</i>
                    平台待结算资产${platformPenddingMoney}
                </a>
            </div>
            <div class="col-xs-6 col-sm-4">
                <a class="indexBlock indexBlock4">
                    <i class="icon iconfont">&#xe605;</i>
                    用户流动资产
                </a>
            </div>
            <div class="col-xs-6 col-sm-4">
                <a class="indexBlock indexBlock5">
                    <i class="icon iconfont">&#xe600;</i>
                    用户待结算资产
                </a>
            </div>
            <div class="col-xs-6 col-sm-4">
                <a class="indexBlock indexBlock6">
                    <i class="icon iconfont">&#xe602;</i>
                   ${withdrawMoney1} 用户已提现资产${withdrawMoney}
                </a>
            </div>
        </div>

        <!-- 首页链接]] -->

        </div><!-- rightConten右边区域]] -->

    </div><!-- mainBody页面主体]] -->

    <footer>

    </footer>

</body>
</html>
