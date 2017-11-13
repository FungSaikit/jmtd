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

    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/common/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/backStage/css/index.css" />
</head>
<body>
		<c:set var="SALESMAN" value="<%=UserType.SALESMAN%>" />
		<c:set var="CUSTOMER" value="<%=UserType.CUSTOMER%>" />
		<c:set var="AGENCY" value="<%=UserType.AGENCY%>" />
		<c:set var="FACTORY" value="<%=UserType.FACTORY%>" />
		<c:set var="DEMAND_FACTORY" value="<%=UserType.DEMAND_FACTORY%>" />
		<c:set var="FACILITATOR" value="<%=UserType.FACILITATOR%>" />
		<c:set var="UNAUTHORIZED" value="<%=UserCheckStatus.UNAUTHORIZED%>" />
		<c:set var="AUTHORIZING" value="<%=UserCheckStatus.AUTHORIZING%>" />
		<c:set var="AUTHENTICATION_FAILURE" value="<%=UserCheckStatus.AUTHENTICATION_FAILURE%>" />
		<c:set var="AUTHENTICATION_SUCCESS" value="<%=UserCheckStatus.AUTHENTICATION_SUCCESS%>" />
		<jsp:include page="/jsp/platform/header.jsp"></jsp:include>
		<jsp:include page="/jsp/platform/navigation.jsp"></jsp:include>
       <div class="area">
            <div class="base-info">
                <dl class="baseInfo-block baseInfo-left">
					
					<c:if test="${user.role==FACTORY || user.role==AGENCY|| user.role==FACILITATOR}"> 
						<dt class="baseinfo-item name">社会统一信用代码：</dt>
                    	<dd class="baseinfo-item valuse">${application.businessLicenceNumber }</dd>
                    	
                    	<dt class="baseinfo-item name">公司名：</dt>
                    	<dd class="baseinfo-item valuse">${application.companyName }</dd>
                    	
                    	<dt class="baseinfo-item name">公司简称：</dt>
                    	<dd class="baseinfo-item valuse">${application.shortCompanyName }</dd>
                    
                    	
                    </c:if>
					
                    <dt class="baseinfo-item name">姓名：</dt>
                    <dd class="baseinfo-item valuse">${application.legalPerson }</dd>


                    <dt class="baseinfo-item name">联系方式：</dt>
                    <dd class="baseinfo-item valuse">${application.contact }</dd>


                    <dt class="baseinfo-item name">可支配资金：</dt>
                    <dd class="baseinfo-item valuse moneyText">&#165; ${user.flowMoney }</dd>

                    <dt class="baseinfo-item name">待结算资金：</dt>
                    <dd class="baseinfo-item valuse moneyText">&#165; ${user.pendingMoney }</dd>

                </dl>
                <dl class="baseInfo-block baseInfo-right">
					<dt class="baseinfo-item name">角色：</dt>
                    <dd class="baseinfo-item valuse"><c:choose><c:when test="${user.role==SALESMAN}">业务员</c:when>
							  <c:when test="${user.role==AGENCY }">经销商</c:when>
							  <c:when test="${user.role==CUSTOMER }">消费者</c:when>
							  <c:when test="${user.role==FACTORY }">厂家</c:when>
							  <c:when test="${user.role==FACILITATOR }">服务商</c:when>
							  <c:when test="${user.role==DEMAND_FACTORY }">厂家</c:when></c:choose></dd>
							  
					
                    <dt class="baseinfo-item name">审核状态：</dt>
                    <dd class="baseinfo-item valuse">
                    	<c:choose>
                    		<c:when test="${application.checkStatus==UNAUTHORIZED }">未认证</c:when>
                    		<c:when test="${application.checkStatus==AUTHORIZING }">认证处理中</c:when>
                    		<c:when test="${application.checkStatus==AUTHENTICATION_FAILURE }">认证失败</c:when>
                    		<c:when test="${application.checkStatus==AUTHENTICATION_SUCCESS }">认证成功</c:when>
                    	</c:choose>
                    </dd>
                    <dt class="baseinfo-item name">申请时间：</dt>
                    <dd class="baseinfo-item valuse">${application.submitTime}</dd>

                    <dt class="baseinfo-item name">审核时间：</dt>
                    <dd class="baseinfo-item valuse"><c:choose><c:when test="${empty application.checkTime}">-</c:when><c:otherwise>${application.checkTime }</c:otherwise></c:choose></dd>
					
					<c:if test="${user.checkStatus==AUTHORIZING && user.role==FACTORY}">
		        		<dt class="baseinfo-item name">请选择厂家对应的业务员</dt>
	        			<dd class="baseinfo-item valuse">
	        			<select name="salesmanId" id="salesmanId">
	        				<option value="0">请选择</option>
	        				<c:forEach items="${salsemanList}" var="salseman">
	        					<option value="${salseman.userId }">${salseman.userNickname}</option>
	        				</c:forEach>
	        			</select>
	        			</dd>
		        	 </c:if>
		        	 <c:if test="${user.role==CUSTOMER||user.role==FACILITATOR||user.role==AGENCY}">
		        		<dt class="baseinfo-item name">绑定的客服</dt>
	        			<dd class="baseinfo-item valuse">
	        				${upUser.legalPersonName }
	        			</dd>
		        	 </c:if>
                </dl>

            </div><!-- base-info]] -->

            <!-- [[ 认证上传的图片 -->
            <div class="imgListWrap row">
				
				
                <c:if test="${user.role==FACTORY || user.role==AGENCY|| user.role==FACILITATOR || user.role==DEMAND_FACTORY}">
                <div class="col-sm-6 col-md-4 col-lg-2">
                    <div class="thumbnail">
                        <img src="${application.logoPic }" alt="厂家logo" data-click="show">
                        <div class="caption">
                            <h3>厂家logo</h3>
                        </div>
                    </div>
                </div>

                <div class="col-sm-6 col-md-4 col-lg-2">
                    <div class="thumbnail">
                        <img src="${application.businessLicencePic}" alt="营业执照"  data-click='show'>
                        <div class="caption">
                            <h3>营业执照</h3>
                        </div>
                    </div>
                </div>
                </c:if>

                <div class="col-sm-6 col-md-4 col-lg-2">
                    <div class="thumbnail">
                        <img src="${application.lpIdcardFrontPic }" alt="法人身份证正面" data-click="show">
                        <div class="caption">
                            <h3>法人身份证正面</h3>
                        </div>
                    </div>
                </div>

                <div class="col-sm-6 col-md-4 col-lg-2">
                    <div class="thumbnail">
                        <img src="${application.lpIdcardBackPic }" alt="法人身份证反面" data-click="show">
                        <div class="caption">
                            <h3>法人身份证反面</h3>
                        </div>
                    </div>
                </div>

                <div class="col-sm-6 col-md-4 col-lg-2">
                    <div class="thumbnail">
                        <img src="${application.lpHandheldIdcardPic }" alt="法人手持身份证" data-click="show">
                        <div class="caption">
                            <h3>法人手持身份证</h3>
                        </div>
                    </div>
                </div>
                
                <c:if test="${user.role==SALESMAN }">
                 <div class="col-sm-6 col-md-4 col-lg-2">
                    <div class="thumbnail">
                        <img src="${application.salesmanWorkCertify }" alt="业务员工作证明" data-click="show">
                        <div class="caption">
                            <h3>业务员工作证明</h3>
                        </div>
                    </div>
                </div>
                </c:if>
                
                <c:if test="${user.role==AGENCY || user.role==FACILITATOR}">
                 <div class="col-sm-6 col-md-4 col-lg-2">
                    <div class="thumbnail">
                        <img src="${application.jcv }" alt="店铺实景图" data-click="show">
                        <div class="caption">
                            <h3>店铺实景图</h3>
                        </div>
                    </div>
                </div>
                </c:if>
                
                <c:if test="${user.role==FACTORY }">
                 <div class="col-sm-6 col-md-4 col-lg-2">
                    <div class="thumbnail">
                        <img src="${application.jcv }" alt="厂区实景图" data-click="show">
                        <div class="caption">
                            <h3>厂区实景图</h3>
                        </div>
                    </div>
                </div>
                </c:if>
            </div><!-- [[ 认证上传的图片 -->
            
			
			<c:if test="${user.checkStatus==AUTHORIZING}">
            <div class="operateArea">
                <button type="submit" class="btn navActive" onclick="submitForm()">通过审核</button>
                <button type="submit" class="btn" onclick="window.location.href='<%=request.getContextPath()%>/platform/dispassApplication?applyId=${application.applyId }'">不通过审核</button>
            </div>
            </c:if>
            <c:if test="${user.checkStatus==AUTHENTICATION_FAILURE||(application.isUpdate==1&&application.checkStatus==AUTHORIZING)}">
            <div class="operateArea">
                <button type="submit" class="btn navActive" onclick="submitForm()">通过审核</button>
             </div>
            </c:if>
			<c:if test="${user.checkStatus==AUTHENTICATION_SUCCESS}">
            <div class="operateArea">
                <button type="submit" class="btn" onclick="window.location.href='<%=request.getContextPath()%>/platform/dispassApplication?applyId=${application.applyId }'">不通过审核</button>
            </div>
            </c:if>
        </div><!-- area]] -->
       

    </div><!-- 页面主体的右边]] -->

    </div><!-- 页面主体]] -->

    <footer>

    </footer>
</body>

<script>
	function submitForm(){
		if($("#salesmanId").val()!=undefined){
			if($("#salesmanId").val()==0)
				alert("请选择对应厂家业务员");
			else
				window.location.href='<%=request.getContextPath()%>/platform/passApplication?applyId=${application.applyId }&salesmanId='+$("#salesmanId").val();
		}else{
			window.location.href='<%=request.getContextPath()%>/platform/passApplication?applyId=${application.applyId }';
		}
	}
</script>
</html>
