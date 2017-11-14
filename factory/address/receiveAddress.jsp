<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib prefix="thumbnail" uri="/WEB-INF/tld/thumbnailTag.tld"%>

<!DOCTYPE html>
<html class="balanceHtml">
<head>
    <meta charset="UTF-8"> 
    <meta name="format-detection" content="telephone=no">	
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0,minimum-scale=1,maximum-scale=1">
    <title>金明同达灯饰</title>
    <link href="<%=request.getContextPath() %>/resources/common/swiper.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/common/weui.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath() %>/resources/customer/assets/css/orderCart.css" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/config.js"></script>
	<script>
		var _hmt = _hmt || [];
		(function() {
		  var hm = document.createElement("script");
		  hm.src = "hm.baidu.com/hm.js?ea9f5249df91cf955c80e4937e70e9ce";
		  var s = document.getElementsByTagName("script")[0]; 
		  s.parentNode.insertBefore(hm, s);
		})();
  </script>	
</head>
<body class="balanceBody">
<c:set var="SALES_SORT" value="<%=ProductSortType.SALES_SORT%>" />
<c:set var="NEW_SORT" value="<%=ProductSortType.NEW_SORT%>" />
<c:set var="PRICE_SORT" value="<%=ProductSortType.PRICE_SORT%>" />
<c:set var="CUSTOMER" value="<%=UserType.CUSTOMER%>" />
<c:set var="AUTHENTICATION_SUCCESS" value="<%=UserCheckStatus.AUTHENTICATION_SUCCESS%>" />
<div class="balance">
	<div class="swiper-container payContainer">
        <div class="swiper-wrapper">
           <div class="swiper-slide swiper-no-swiping addressSlider">
				<div class="title"><i class="iconfont prevPage normalPrev">&#xe624;</i>管理收货地址</div>
				<div class="addressList">
					
				</div>
				<div class="emptyAddress empty">
				    <i class="iconfont">&#xe639;</i>
				    <p>还没有添加地址哦！</p>
			    </div>
				<button class="addButton"><span><i class="iconfont">&#xe628;</i></span>新增收货地址</button>
			</div>
			<div class="swiper-slide swiper-no-swiping addAddressSlider">
				<div class="title"><i class="iconfont prevPage normalPrev" >&#xe624;</i>
					<span id="addressTitle">新增收货地址</span></div>
				<form>
					<input type="hidden" name="receiveAddressId"/>
					<input type="hidden" name="userId"/>
					<input type="hidden" name="defaultFlag"/>
					<table class="formTable">
						<tr>
							<td>联系人</td>
							<td><input id="contactName" name="receivePerson" type="text" value="" data-name="联系人"/></td>
						</tr>
						<tr>
							<td>联系电话</td>
							<td><input type="text" name="contactNumber" value="" data-name="联系电话"/></td>
						</tr>
						<tr>
							<td>选择省份</td>
							<td>
								<select name="provinceId" onchange="queryCity(this.value)" data-name="省份">
									<option>--请选择省份--</option>
									<c:forEach items="${provinceList}" var="province">
										<option value="${province.addressId }">${province.addressName}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<td>选择市区</td>
							<td>
								<select name="cityId" onchange="queryArea(this.value)" data-name="市区">
									<option>--请选择市区--</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>选择区/县</td>
							<td>
								<select name="areaId" data-name="区/县">
									<option>--请选择区/县--</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>详细地址</td>
							<td><input type="text" name="addressDetail" value="" data-name="详细地址"/></td>
						</tr>
					</table>
					<div class="defaultAddress"><span><i class="iconfont">&#xe611;</i></span>设为默认地址</div>
				</form>
					<button class="submit">保　存</button>
					<button class="delete" data-id="1">删　除</button>
			</div>
		</div>
	</div>
</div>


<!--[[遮罩层-->
<div class="shadow" style="display: none;"></div>
<!--遮罩层]]-->
<!-- 开始确认框 -->
<div class="confirmDiv" id="delete">
	<div class="confirmTop">
		<span>温馨提醒</span>
		<span id="closeConfirm">X</span>
	</div>
	<p>确定删除？</p>
	<div class="confirmBottom">
		<span id="cancel">取消</span>
		<span id="confirm">确定</span>
	</div>
</div>
<!-- 结束确认框 -->
<!--[[地址选择-->
<!-- <div class="balance-address">
   
</div> -->
<!--地址选择]]-->

<!--[[底部-->
<%-- <jsp:include page="/jsp/buyer/footer.jsp"></jsp:include> --%>
<!--底部]]-->
<div class="tip"></div>
<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/swiper.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
<script>
	$(".addButton").show();
	var swiper = new Swiper('.payContainer',{
		noSwiping : true,
	});
	$("#title").tap(function(){
		swiper.slideNext();
	});
	//开始结算页面
	$(".install").tap(function(){
		if($(this).hasClass("active")){
			$(this).removeClass("active");
			$("input[name='isInstall']").val("0");
			$("#moneySpan").html(parseFloat($("#moneySpan").html())-parseFloat($("#installMoney").html()));
		}else{
			$(this).addClass("active");
			$("input[name='isInstall']").val("1");
			$("#moneySpan").html(parseFloat($("#moneySpan").html())+parseFloat($("#installMoney").html()));
		}
	});
	$(document).on("tap",".shopName",function(e){
		if(!$(e.target).closest("a").length!=0){
			if($(this).find(".show").hasClass("rotate")){
				$(this).find(".show").removeClass("rotate");
				$(this).parent().find(".commodity").css("display","block");
			}else{
				$(this).find(".show").addClass("rotate");
				$(this).parent().find(".commodity").css("display","none");
			}
		}
	});
	$(".payAddress").tap(function(){
		swiper.slideNext();
		queryReceiveAddress();
	});
	//结束结算页面
	//开始地址管理
	function textAddress(){
		if($(".oneAddress").length==0){
			$(".addressList").hide();
			$(".emptyAddress").show();
			$(".balanceBody").css("background-color","#fff");
		}else{
			$(".addressList").show();
			$(".emptyAddress").hide();
			$(".balanceBody").css("background-color","#f3f3f3");
		}
	}
	textAddress();
	
	function checkForm(){
		var flag=true;
		$(".formTable input,.formTable select").each(function(){
			if($(this).val()==""||$(this).val()=="--请选择省份--"||$(this).val()=="--请选择市区--"||$(this).val()=="--请选择区/县--"){
				flag=false;
				showTip($(this).attr("data-name")+"不能为空");
				return false;
			}
		});
		return flag;
	}
	
	$(document).on("tap",".check",function(){
		//ajax设置默认地址
		$(".check").removeClass("active");
		$(this).addClass("active");
		setDefault($(this).parents(".oneAddress").attr("data-id"));
	});
	
	var data_id;
	$(document).on("tap",".delIcon",function(){
		data_id=$(this).parent().parent().attr("data-id");
		$("#delete").show();
		$(".shadow").show();
	});
	$("#confirm").tap(function(){
		/* 用ajax将此数据删除*/
		deleteAddress();
	});
	$(".shadow").tap(function(){
		$("#delete").hide();
		$(this).hide();
	});
	$("#closeConfirm").tap(function(){
		$("#delete").hide();
		$(".shadow").hide();
	});
	$("#cancel").tap(function(){
		$("#delete").hide();
		$(".shadow").hide();
	});
	
	$(".addButton").tap(function(){
		swiper.slideNext();
		$("#addressTitle").html("添加收货地址");
		$(".addAddressSlider input,select").each(function(){
			$(this).val("");
		});
		$("select[name='cityId']").html("");
		$("select[name='areaId']").html("");
		$(".defaultAddress").show();
	});
	$(document).on("tap",".editIcon",function(){
		$(".delete").css("display","block");
		swiper.slideNext();
		$("#addressTitle").html("修改收货地址");
		getReceiveAddress($(this).parents(".oneAddress").attr("data-id"));
	});
	//结束地址管理
	//开始添加地址
	$(".normalPrev").tap(function(){
		if(swiper.activeIndex==0)
			history.go(-1);
		$(".delete").css("display","none");
		swiper.slidePrev();
	});
	$(".defaultAddress").tap(function(){
		if($(this).hasClass("active")){
			$(this).removeClass("active");
		}else{
			$(this).addClass("active");
		}
	});
	$(".delete").tap(function(){
		data_id=$("input[name='receiveAddressId']").val();
		$("#delete").show();
		$(".shadow").show();
	});
	//结束添加地址
	
	
	$(".submit").tap(function(){
		if(checkForm()){
			if($("#addressTitle").html()=="修改收货地址")
				updateAddress();
			else
				addAddress();
		}
	});
	
	$(function(){
		queryReceiveAddress();
	});
	
	//查询地址
	function queryReceiveAddress(){
		var url="<%=request.getContextPath()%>/address/queryReceiveAddress";
		var params={};
		doAjax("GET",url,params,querySuccess,fail,true,false);
	}
	
	function querySuccess(data){
		var html="";
		var addressList = data.data;
		for(var i=0;i<addressList.length;i++){
			html+='<div class="oneAddress" data-id="'+addressList[i].receiveAddress.receiveAddressId+'">';
			html+='<div class="addressTop">';
			html+='<div class="namePhone">';
			html+='<span class="name">'+addressList[i].receiveAddress.receivePerson+'</span>';
			html+='<span class="phone">'+addressList[i].receiveAddress.contactNumber+'</span>';
			html+='</div>';
			html+='<div class="address">';
			html+='<span class="province">'+addressList[i].province+'</span>';
			html+='<span class="city">'+addressList[i].city+'</span>';
			html+='<span class="area">'+addressList[i].area+'</span>';
			html+='<span class="addressDetail">'+addressList[i].receiveAddress.addressDetail+'</span>';
			html+='</div></div>';
			html+='<div class="addressBottom">';
			html+='<span class="check'+(addressList[i].receiveAddress.defaultFlag==1?' active':'')+'"><i class="iconfont">&#xe611;</i>设为默认地址</span>';
			html+='<span class="delIcon"><i class="iconfont">&#xe603;</i>删除</span>';
			html+='<span class="editIcon"><i class="iconfont">&#xe602;</i>编辑</span>';
			html+='</div></div>';
		}
		$(".addressList").html(html);
		if(addressList.length>0){
			$(".addressList").show();
			$(".emptyAddress").hide();
		}else{
			$(".addressList").hide();
			$(".emptyAddress").show();
		}
	}
	
	//查询单个地址详情
	function getReceiveAddress(receiveAddressId){
		var url="<%=request.getContextPath()%>/address/toUpdateAddress";
		var params={receiveAddressId:receiveAddressId};
		doAjax("GET",url,params,getSuccess,fail,true,false);
	}
	
	function getSuccess(data){
		var address = data.data;
		$("input[name='receiveAddressId']").val(address.receiveAddressId);
		$("input[name='userId']").val(address.userId);
		$("input[name='defaultFlag']").val(address.defaultFlag);
		if(address.defaultFlag==1)
			$(".defaultAddress").hide();
		else
			$(".defaultAddress").show();
		$("input[name='receivePerson']").val(address.receivePerson);	
		$("input[name='contactNumber']").val(address.contactNumber);
		$("select[name='provinceId']").val(address.provinceId);
		queryCity(address.provinceId);
		queryArea(address.cityId);
		$("select[name='cityId']").val(address.cityId);
		$("select[name='areaId']").val(address.areaId);
		$("input[name='addressDetail']").val(address.addressDetail);
		
	}
	
	function updateAddress(){
		if($(".defaultAddress").hasClass("active")){
			$("input[name='defaultFlag']").val(1);
		}else{
			if($(".defaultAddress").attr("style")!="display: none;"){
				$("input[name='defaultFlag']").val(0);
			}
		}
		var url="<%=request.getContextPath()%>/address/updateAddress";
		var params=$("form").serialize();
		doAjax("GET",url,params,updateSuccess, fail,true,false);
	}
	
	function updateSuccess(data){
		swiper.slidePrev();
		queryReceiveAddress();
	}
	
	function addAddress(){
		if($(".defaultAddress").hasClass("active")){
			$("input[name='defaultFlag']").val(1);
		}else{
			$("input[name='defaultFlag']").val(0);
		}
		var url="<%=request.getContextPath()%>/address/addReceiveAddress";
		var params=$("form").serialize();
		doAjax("GET",url,params,addSuccess, fail,true,false);
	}
	
	function addSuccess(data){
		swiper.slidePrev();
		queryReceiveAddress();
	}
	
	function deleteAddress(){
		var url="<%=request.getContextPath()%>/address/deleteAddress";
		var params={receiveAddressId:data_id};
		doAjax("GET",url,params,deleteSuccess,fail,true,false);
	}
	
	function deleteSuccess(){
		$(".oneAddress[data-id='"+data_id+"']").remove(); 
		textAddress();
		$("#delete").hide();
		$(".shadow").hide();
		if(swiper.activeIndex==2){
			swiper.slideTo(1);
		}
	}
	

	function setDefault(receiveAddressId){
		var url="<%=request.getContextPath()%>/address/setDefault";
		var params={receiveAddressId:receiveAddressId};
		doAjax("GET",url,params,setDefaultSuccess,fail,true,false);
	}
	
	function setDefaultSuccess(data){
		
	}
	
	function fail(data){
		alert(fail);
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
		$("select[name='cityId']").html(option);
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
		$("select[name='areaId']").html(option);
	}
	
    
    $(function(){
    	var installPrice=0;
    	var totalMoney=0;
    	$(".commodity").each(function(){
    		installPrice+=parseFloat($(this).attr("data-installPrice"));
    		totalMoney+=parseFloat($(this).attr("data-money"));
    	});
    	$("#installMoney").html(installPrice.toFixed(2));
    	$("#moneySpan").html(totalMoney.toFixed(2));
    });
    
    function showTip(content){
		$(".tip").html(content);
		$(".tip").css("opacity","0.8");
		setTimeout(function(){
			$(".tip").html("");
			$(".tip").css("opacity","0");
		},1000);
	}
</script>
</body>
</html>