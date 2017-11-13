<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
	.body{
		height:100%;
		overflow:hidden;
	}
	.filterDiv{
		width:100%;
		height:100%;
		position:fixed;
		top:0;
		right:0px;
		z-index:10000;
		display:none;
		font-family:"微软雅黑";
		background-color:#F2F2F2;
		overflow-y:auto;
	}
	.filterDiv .filterSearch{
	    background-color: #E3E3E3;
	    padding: 0.2rem 6% 0.2rem 6%;
	    position: fixed;
	    z-index: 9999;
	    left: 0;
	    top: 0;
	    width: 100%;
	    text-align:center;
	    background-color:#D23232;
	}
	.filterDiv .filterSearch  #filterKeyword{
	    display: inline-block;
	    vertical-align:middle;
	    width: 75%;
	    height: 1rem;
	    border-radius:0px 5px 5px 0px;
	    border:1px solid #eee;
	    border-right:0px;
	    padding-right:.2rem;
	    padding-left:.2rem;
	    font-family:"微软雅黑";
	    float:left;
	    box-sizing:border-box;
	    -webkit-appearance: none;
	}
	.filterDiv .filterSearch .findProductBtn{
	    width: 13%;
	    height: 1rem;
	    background-color: #fff;
	    border: 1px solid #eee;
	    -webkit-border-radius: 5px;
	    -moz-border-radius: 5px;
	    border-radius: 5px 0 0 5px;
	    vertical-align:middle;
	    font-family:"微软雅黑";
	    float:left;
	}
	.filterDiv .filterMain {
	    padding-top: 1.4rem;/* 
	    padding-left: 0.4rem; */
	    height: 557px;
	}
	.filterDiv .filterMain .filterProperty {
		padding:0 10px 10px;
		border-bottom:1px solid #CFCFCF;
	}
	.filterDiv .filterMain .filterProperty:last-child{
		margin-bottom:100px;
	}
	.filterDiv .filterMain .filterProperty span{
		font-size:18px;
		display:block;
		margin-top:10px;
		color:#979797;
		text-align:center;
	}
	.filterDiv .filterMain .filterProperty ul{
		overflow:hidden;
		margin-right: -10px;
	}
	.filterDiv .filterMain .filterProperty li{
		display: block;
	    float: left;
	    width: 33.33%;
	    margin-top: 15px;
	}
	.filterDiv .filterMain .filterProperty li:nth-child(n<3){
	    margin-top: 0px;
	}
	.filterDiv .filterMain .filterProperty li a{
	    position: relative;
	    display: block;
	    height: 29px;
	    line-height: 29px;
	    margin-right: 10px;
	    font-size: 12px;
	    text-align: center;
	 	border:1px solid #CFCFCF;
	 	border-radius:5px;
	 	color:#929292;
	}
	.filterDiv .filterMain .filterProperty li .active{
	 	border:1px solid #F00;
	}
	.filterDiv .filterFooter{
		position:fixed;
		bottom:0;
		left:0;
		width:100%;
		background-color:#FAFAFA;
		text-align:center;
		padding: 6px 0px;
	}
	.filterDiv .filterFooter>button{
		padding: 8px 5px;
	    border-radius: 3px;
	    width: 60px;
	    line-height: normal;
	    font-size: .5rem;
	}
	.filterDiv .filterFooter .clearBtn{
		background-color: #FFF;
	    color: #6A6A6A;
	    border: 1px solid #6A6A6A;
	    width:20%;
	    margin-right:5%;
	}
	.filterDiv .filterFooter .cancelBtn{
		background-color: #FFF;
	    color: #6A6A6A;
	    border: 1px solid #6A6A6A;
	    width:20%;
	    margin-right:5%;
	}
	.filterDiv .filterFooter .sureBtn{
	    background-color: red;
	    color: #fff;
	    border: 1px solid red;
	    font-family: "微软雅黑";
	    width:40%;
	}
	.filterDiv .filterMain .propertyMain{
		width:75%;
		overflow-y:scroll;
		height:557px;
		display:block;
		float:right;
	}
	.filterDiv .filterMain .propertyList{
		width:25%;
		height:100%;
		overflow-y:auto;
		float:left;
		font-size:.5rem;
	    border:1px solid #E1E1E1;
	    box-sizing:border-box;
	}
	.filterDiv .filterMain .propertyList li{
		text-align:center;
		display:block;	
		height:1.4rem;
		line-height:1.4rem;
		border:1px solid #DFDFDF;
	}
	.filterDiv .filterMain .propertyList .active{
		color:red;
		border-left:2px solid red;
	}
	::-webkit-scrollbar{width:0;height:0}
</style>
<div class="filterDiv" id="filterDiv">
	<div class="filterSearch">
		<button class="findProductBtn" onclick="searchByKeywordFilter()" ><i class="icon iconfont">&#xe610;</i></button>
        <input type="text" placeholder="请输入关键字搜索" id="filterKeyword"/>
    </div>
    <div class="filterMain">
    	<div class="propertyList">
    		<ul>
    			<li data-property="space" class="active">空间</li>
    			<li data-property="type">类型</li>
    			<li data-property="style">风格</li>
    			<li data-property="material">材质</li>
    			<li data-property="shape">形状</li>
    			<li data-property="plies">层数</li>
    			<li data-property="diameter">直径</li>
    			<li data-property="length">长度</li>
    			<li data-property="height">高度</li>
    			<li data-property="price">价格</li>
    			<li data-property="lightType">光源类型</li>
    		</ul>
    	</div>
    	<div class="propertyMain" id="propertyMain">
	    	<div class="filterProperty mainProperty" data-property="space" data-id="40">
	    		<span>空间</span>
	    		<div><ul></ul></div>
	    	</div>
	    	<div class="filterProperty mainProperty" data-property="type" data-id="37">
	    		<span>类型</span>
	    		<div><ul></ul></div>
	    	</div>
	    	<div class="filterProperty mainProperty" data-property="style" data-id="39">
	    		<span>风格</span>
	    		<div><ul></ul></div>
	    	</div>
	    	<div class="filterProperty mainProperty" data-property="material" data-id="38">
	    		<span>材质</span>
	    		<div><ul></ul></div>
	    	</div>
	    	<div class="filterProperty mainProperty" data-property="shape" data-id="54">
	    		<span>形状</span>
	    		<div><ul></ul></div>
	    	</div>
	    	<div class="filterProperty mainProperty" data-property="plies" data-id="56">
	    		<span>层数</span>
	    		<div><ul></ul></div>
	    	</div>
	    	<div class="filterProperty oneProperty" data-property="diameter">
	    		<span>直径</span>
	    		<div><ul></ul></div>
	    	</div>
	    	<div class="filterProperty oneProperty" data-property="length">
	    		<span>长度</span>
	    		<div><ul></ul></div>
	    	</div>
	    	<div class="filterProperty oneProperty" data-property="height">
	    		<span>高度</span>
	    		<div><ul></ul></div>
	    	</div>
	    	<div class="filterProperty oneProperty" data-property="price">
	    		<span>价格</span>
	    		<div><ul></ul></div>
	    	</div>
	    	<div class="filterProperty mainProperty" data-property="lightType" data-id="55">
	    		<span>光源类型</span>
	    		<div><ul></ul></div>
	    	</div>
	    	<c:if test="${sessionScope.openId=='oQO-Qwu4DMV2DEOeacxdIKS6cVRQ'||sessionScope.openId=='oQO-QwkFyoLYu4nB6a4Lk3lamsW4'
	   		 ||sessionScope.openId=='oQO-QwnsaSsL6c0QM8GyXRHzJInI'||sessionScope.openId=='oQO-QwsNw46NjP13S9vhlzvDxOZM'
	   		 ||sessionScope.openId=='oQO-Qwml3yWRbjpPalYXKWDesYTI'||sessionScope.openId=='oQO-QwvpAID9vBcUQ8xnWuJjWCPY'
	   		 ||sessionScope.openId=='oQO-QwvVOUHiDGupj1o8lcOhflkA'||sessionScope.openId=='oQO-QwgrqQExIsRRw-8OfO4OSZmo'
	   		 ||sessionScope.openId=='oQO-QwmeRlMdo42ujI45178jkoEM'||sessionScope.openId=='oQO-QwsOrNAG3ssdY-Xlxo4jisSU'}">
		    	<div class="filterProperty mainProperty" data-property="brand">
		    		<span>品牌</span>
		    		<div><ul></ul></div>
		    	</div>
	    	</c:if>
	    </div>
	    <div class="filterFooter">
	    	<button class="clearBtn">重置</button>
	    	<button class="cancelBtn">取消</button>
	    	<button class="sureBtn">确定</button>
	    </div>
	 </div>
</div>
<script>
	function show(){/* 
		$(".filterDiv").addClass("show"); */
		$(".filterDiv").show();
		$("body").addClass("body");
	}

	<c:if test="${!empty showFilter }">
			show();
	</c:if>
	
	$(".cancelBtn").tap(function(){
		$(".filterDiv").hide();
		$("body").removeClass("body");
	});
	
	$(".sureBtn").tap(function(){
		$(".mainProperty").each(function(){
			var property=$(this).attr("data-property");
			var propertyValue="";
			$(this).find("a[class='active']").each(function(){
				propertyValue+=$(this).parent().attr("data-id")+";";
			});
			console.log(property)
			$("input[name='"+property+"']").val(propertyValue);
		});
		
		var propertyValueId=$(".filterProperty[data-property='price']").find("a[class='active']").parent().attr("data-id");
		if(propertyValueId!=undefined&&propertyValueId!=""){
			var a =propertyValueId.split("-");
			if(propertyValueId!="全部"){
				if(a.length>=2){
					$("input[name='fromPrice']").val(a[0]);
					$("input[name='toPrice']").val(a[1]);
				}else{
					$("input[name='fromPrice']").val(propertyValueId.match(/\d+(\.\d+)?/g));
				}
			}
		}else{
			$("input[name='fromPrice']").val("");
			$("input[name='toPrice']").val("");
		}
		
		propertyValueId=$(".filterProperty[data-property='diameter']").find("a[class='active']").parent().attr("data-id");
		if(propertyValueId!=undefined&&propertyValueId!=""){
			var a =propertyValueId.split("-");
			if(propertyValueId!="全部"){
				if(a.length>=2){
					$("input[name='fromDiameter']").val(a[0]);
					$("input[name='toDiameter']").val(a[1]);
				}else{
					$("input[name='fromDiameter']").val(propertyValueId.match(/\d+(\.\d+)?/g));
				}
			}
		}else{
			$("input[name='fromDiameter']").val("");
			$("input[name='toDiameter']").val("");
		}
		
		propertyValueId=$(".filterProperty[data-property='length']").find("a[class='active']").parent().attr("data-id");
		if(propertyValueId!=undefined&&propertyValueId!=""){
			var a =propertyValueId.split("-");
			if(propertyValueId!="全部"){
				if(a.length>=2){
					$("input[name='fromLength']").val(a[0]);
					$("input[name='toLength']").val(a[1]);
				}else{
					$("input[name='fromLength']").val(propertyValueId.match(/\d+(\.\d+)?/g));
				}
			}
		}else{
			$("input[name='fromLength']").val("");
			$("input[name='toLength']").val("");
		}	
		
		propertyValueId=$(".filterProperty[data-property='height']").find("a[class='active']").parent().attr("data-id");
		if(propertyValueId!=undefined&&propertyValueId!=""){
			var a =propertyValueId.split("-");
			if(propertyValueId!="全部"){
				if(a.length>=2){
					$("input[name='fromHeight']").val(a[0]);
					$("input[name='toHeight']").val(a[1]);
				}else{
					$("input[name='fromHeight']").val(propertyValueId.match(/\d+(\.\d+)?/g));
				}
			}
		}else{
			$("input[name='fromHeight']").val("");
			$("input[name='toHeight']").val("");
		}
		
		$("input[name='keyword']").val($("#filterKeyword").val());
		$("#productForm").submit();
	});

	$(document).on("tap",".filterProperty a",function(){
		if($(this).hasClass("active")){
			$(this).removeClass("active");
		}else{
			if($(this).parents(".filterProperty").hasClass("oneProperty")){
				$(this).parents("ul").find("a[class='active']").each(function(){
					$(this).removeClass("active");
				})
			}
			$(this).addClass("active");
		}
	});
	
	getProductProperty();
	function getProductProperty(){
		var url="<%=request.getContextPath()%>/product/getProductParamList";
		var params={};
		doAjax("GET",url,params,function(data){
			var propertyList=data.data['type'];
			for(var i=0;i<propertyList.length;i++){
				$(".filterProperty[data-property='type'] ul").append('<li data-id="'+propertyList[i].propertyValueId+'"><a>'+propertyList[i].propertyValue+'</a></li>')
			}
			propertyList=data.data['style'];
			for(var i=0;i<propertyList.length;i++){
				$(".filterProperty[data-property='style'] ul").append('<li data-id="'+propertyList[i].propertyValueId+'"><a>'+propertyList[i].propertyValue+'</a></li>')
			}
			propertyList=data.data['material'];
			for(var i=0;i<propertyList.length;i++){
				$(".filterProperty[data-property='material'] ul").append('<li data-id="'+propertyList[i].propertyValueId+'"><a>'+propertyList[i].propertyValue+'</a></li>')
			}
			propertyList=data.data['space'];
			for(var i=0;i<propertyList.length;i++){
				$(".filterProperty[data-property='space'] ul").append('<li data-id="'+propertyList[i].propertyValueId+'"><a>'+propertyList[i].propertyValue+'</a></li>')
			}
			propertyList=data.data['shape'];
			for(var i=0;i<propertyList.length;i++){
				$(".filterProperty[data-property='shape'] ul").append('<li data-id="'+propertyList[i].propertyValueId+'"><a>'+propertyList[i].propertyValue+'</a></li>')
			}
			propertyList=data.data['lightType'];
			for(var i=0;i<propertyList.length;i++){
				$(".filterProperty[data-property='lightType'] ul").append('<li data-id="'+propertyList[i].propertyValueId+'"><a>'+propertyList[i].propertyValue+'</a></li>')
			}
			propertyList=data.data['plies'];
			for(var i=0;i<propertyList.length;i++){
				if(parseInt(propertyList[i].propertyValue)<4)
					$(".filterProperty[data-property='plies'] ul").append('<li data-id="'+propertyList[i].propertyValue+'"><a>'+propertyList[i].propertyValue+'层</a></li>');
				else
					$(".filterProperty[data-property='plies'] ul").append('<li data-id="'+propertyList[i].propertyValue+'"><a>4层及以上</a></li>');
					
			}
			propertyList=data.data['price'];
			for(var i=0;i<propertyList.length;i++){
				$(".filterProperty[data-property='price'] ul").append('<li data-id="'+propertyList[i].propertyValue+'"><a>'+propertyList[i].propertyValue+'</a<</li>');
			}
			
			propertyList=data.data['diameter'];
			for(var i=0;i<propertyList.length;i++){
				$(".filterProperty[data-property='diameter'] ul").append('<li data-id="'+propertyList[i].propertyValue+'"><a>'+propertyList[i].propertyValue+'</a<</li>');
			}
			
			propertyList=data.data['length'];
			for(var i=0;i<propertyList.length;i++){
				$(".filterProperty[data-property='length'] ul").append('<li data-id="'+propertyList[i].propertyValue+'"><a>'+propertyList[i].propertyValue+'</a<</li>');
			}
			
			propertyList=data.data['height'];
			for(var i=0;i<propertyList.length;i++){
				$(".filterProperty[data-property='height'] ul").append('<li data-id="'+propertyList[i].propertyValue+'"><a>'+propertyList[i].propertyValue+'</a<</li>');
			}
			
			propertyList=data.data['brand'];
			for(var i=0;i<propertyList.length;i++){
				$(".filterProperty[data-property='brand'] ul").append('<li data-id="'+propertyList[i]+'"><a>'+propertyList[i]+'</a></li>');
			}

			initActive();
		},function(data){console.log(data);},true,false);
	}
	
	function searchByKeywordFilter(){
		$("input[name='keyword']").val($("#filterKeyword").val());
		$(".mainProperty").each(function(){
			var property=$(this).attr("data-property");
			var propertyValue="";
			$(this).find("a[class='active']").each(function(){
				propertyValue+=$(this).parent().attr("data-id")+";";
			});
			console.log(property)
			$("input[name='"+property+"']").val(propertyValue);
		});
		
		var propertyValueId=$(".filterProperty[data-property='price']").find("a[class='active']").parent().attr("data-id");
		if(propertyValueId!=undefined&&propertyValueId!=""){
			var a =propertyValueId.split("-");
			if(propertyValueId!="全部"){
				if(a.length>=2){
					$("input[name='fromPrice']").val(a[0]);
					$("input[name='toPrice']").val(a[1]);
				}else{
					$("input[name='fromPrice']").val(propertyValueId.match(/\d+(\.\d+)?/g));
				}
			}
		}else{
			$("input[name='fromPrice']").val("");
			$("input[name='toPrice']").val("");
		}
		
		propertyValueId=$(".filterProperty[data-property='diameter']").find("a[class='active']").parent().attr("data-id");
		if(propertyValueId!=undefined&&propertyValueId!=""){
			var a =propertyValueId.split("-");
			if(propertyValueId!="全部"){
				if(a.length>=2){
					$("input[name='fromDiameter']").val(a[0]);
					$("input[name='toDiameter']").val(a[1]);
				}else{
					$("input[name='fromDiameter']").val(propertyValueId.match(/\d+(\.\d+)?/g));
				}
			}
		}else{
			$("input[name='fromDiameter']").val("");
			$("input[name='toDiameter']").val("");
		}
		
		propertyValueId=$(".filterProperty[data-property='length']").find("a[class='active']").parent().attr("data-id");
		if(propertyValueId!=undefined&&propertyValueId!=""){
			var a =propertyValueId.split("-");
			if(propertyValueId!="全部"){
				if(a.length>=2){
					$("input[name='fromLength']").val(a[0]);
					$("input[name='toLength']").val(a[1]);
				}else{
					$("input[name='fromLength']").val(propertyValueId.match(/\d+(\.\d+)?/g));
				}
			}
		}else{
			$("input[name='fromLength']").val("");
			$("input[name='toLength']").val("");
		}	
		
		propertyValueId=$(".filterProperty[data-property='height']").find("a[class='active']").parent().attr("data-id");
		if(propertyValueId!=undefined&&propertyValueId!=""){
			var a =propertyValueId.split("-");
			if(propertyValueId!="全部"){
				if(a.length>=2){
					$("input[name='fromHeight']").val(a[0]);
					$("input[name='toHeight']").val(a[1]);
				}else{
					$("input[name='fromHeight']").val(propertyValueId.match(/\d+(\.\d+)?/g));
				}
			}
		}else{
			$("input[name='fromHeight']").val("");
			$("input[name='toHeight']").val("");
		}
		
		$("input[name='keyword']").val($("#filterKeyword").val());
		$("#productForm").submit();
	}
	
	$(".propertyList li").tap(function(){
		$(this).addClass("active").siblings().removeClass("active");
		document.getElementById('propertyMain').scrollTop=
			$(".propertyMain .filterProperty[data-property='"+
			$(this).attr('data-property')+"']")[0].offsetTop-60;
	});
	

	$(".propertyMain").scroll(function(){
		var i=0;
		var that=$(".propertyList li").eq(0);
		$(".propertyList li").each(function(){
			if($(".propertyMain").scrollTop()-$(".propertyMain .filterProperty[data-property='"+$(this).attr("data-property")+"']")[0].offsetTop+59>-2){
				//$(this).addClass("active").siblings().removeClass("active");
				if($(".propertyMain .filterProperty[data-property='"+$(this).attr("data-property")+"']")[0].offsetTop>
					$(".propertyMain .filterProperty[data-property='"+that.attr("data-property")+"']")[0].offsetTop)
					that=$(this);
			}
		});
		that.addClass("active").siblings().removeClass("active");
	});
	function initActive(){
		var url = location.href;
		if(url.indexOf("productList")>=0){
			var search = window.location.search==""?"":unescape(window.location.search.split("?")[1]);
			
			var arr=search.split("&"); //各个参数放到数组里
		    for(var i=0;i < arr.length;i++){ 
			    num=arr[i].indexOf("="); 
			    if(num>0){ 
				     name=arr[i].substring(0,num);
				     value=arr[i].substr(num+1);
				     if(value!=""){
				    	 var ids=value.split(";");
				    	 for(var j=0;j<ids.length;j++){
				    		 $(".filterDiv li[data-id='"+ids[j]+"'] a").addClass("active");
				    	 }
				     }
		    	}
		    }
			var fromLength=GetQueryString("fromLength");
			var toLength=GetQueryString("toLength");
			if(toLength!=""){
				$(".filterProperty[data-property='length'] li[data-id='"+fromLength+"-"+toLength+"'] a").addClass("active");
			}else{
				$(".filterProperty[data-property='length'] li[data-id='"+fromLength+"以上'] a").addClass("active");
			}
			var fromDiameter=GetQueryString("fromDiameter");
			var toDiameter=GetQueryString("toDiameter");
			if(toDiameter!=""){
				$(".filterProperty[data-property='diameter'] li[data-id='"+fromDiameter+"-"+toDiameter+"'] a").addClass("active");
			}else{
				$(".filterProperty[data-property='diameter'] li[data-id='"+fromDiameter+"以上'] a").addClass("active");
			}
			var fromHeight=GetQueryString("fromHeight");
			var toHeight=GetQueryString("toHeight");
			if(toHeight!=""){
				$(".filterProperty[data-property='height'] li[data-id='"+fromHeight+"-"+toHeight+"'] a").addClass("active");
			}else{
				$(".filterProperty[data-property='height'] li[data-id='"+fromHeight+"以上'] a").addClass("active");
			}
			var fromPrice=GetQueryString("fromPrice");
			var toPrice=GetQueryString("toPrice");
			if(toPrice!=""){
				$(".filterProperty[data-property='price'] li[data-id='"+fromPrice+"-"+toPrice+"'] a").addClass("active");
			}else{
				$(".filterProperty[data-property='price'] li[data-id='"+fromPrice+"以上'] a").addClass("active");
			}
		}
	}
	

	function GetQueryString(name){
	     var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
	     var r = window.location.search.substr(1).match(reg);
	     if(r!=null)return  unescape(r[2]); return null;
	}
	
	$(".clearBtn").click(function(){
		$(".filterDiv .propertyMain li a").removeClass("active");
	});
</script>
<form action="<%=request.getContextPath() %>/product/productList" id="productForm">
   	<input type="hidden" name="keyword" value="${productParam.keyword }">
   	<input type="hidden" name="type" value="${productParam.type}">
   	<input type="hidden" name="style" value="${productParam.style}">
   	<input type="hidden" name="material" value="${productParam.material}">
   	<input type="hidden" name="space" value="${productParam.space}">
   	<input type="hidden" name="fromPrice" value="${productParam.fromPrice}">
   	<input type="hidden" name="toPrice" value="${productParam.toPrice}">
   	<input type="hidden" name="province" value="${productParam.province}">
   	<input type="hidden" name="city" value="${productParam.city}">
   	<input type="hidden" name="area" value="${productParam.area}">
   	<input type="hidden" name="isPopular" value="${productParam.isPopular}">
   	<input type="hidden" name="orderBy" value="${productParam.orderBy}">
   	<input type="hidden" name="brand" value="${productParam.brand}">
   	<input type="hidden" name="shape" value="${productParam.shape}">
   	<input type="hidden" name="fromDiameter" value="${productParam.fromDiameter}">
   	<input type="hidden" name="toDiameter" value="${productParam.toDiameter}">
   	<input type="hidden" name="plies" value="${productParam.plies}">
   	<input type="hidden" name="lightType" value="${productParam.lightType}">
   	<input type="hidden" name="fromLength" value="${productParam.fromLength}">
   	<input type="hidden" name="toLength" value="${productParam.toLength}">
   	<input type="hidden" name="fromHeight" value="${productParam.fromHeight}">
   	<input type="hidden" name="toHeight" value="${productParam.toHeight}">
   	<input type="hidden" name="offset" value="0"> 
</form>  
