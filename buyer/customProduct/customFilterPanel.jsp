<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
	.body{
		height:100%;
		overflow:hidden;
	}
	.customFilterDiv{
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
	.customFilterDiv .filterSearch{
	    background-color: #E3E3E3;
	    padding: 0.2rem 6% 0.2rem 6%;
	    position: fixed;
	    z-index: 9999;
	    left: 0;
	    top: 0;
	    width: 100%;
	    text-align:center;
	}
	.customFilterDiv .filterSearch  #customFilterKeyword{
	    display: inline-block;
	    vertical-align:middle;
	    width: 75%;
	    height: 1rem;
	    border-radius:5px 0 0 5px;
	    border:1px solid #eee;
	    border-right:0px;
	    padding-right:.2rem;
	    padding-left:.2rem;
	    font-family:"微软雅黑";
	    float:left;
	    box-sizing:border-box;
	    -webkit-appearance: none;
	}
	.customFilterDiv .filterSearch .findProductBtn{
	    width: 13%;
	    height: 1rem;
	    background-color: #fff;
	    border: 1px solid #eee;
	    -webkit-border-radius: 5px;
	    -moz-border-radius: 5px;
	    border-radius: 0 5px 5px 0;
	    vertical-align:middle;
	    font-family:"微软雅黑";
	    float:left;
	}
	.customFilterDiv .filterMain {
	    padding-top: 1.4rem;/* 
	    padding-left: 0.4rem; */
	    height: 100%;
	}
	.customFilterDiv .filterMain .filterProperty {
		padding:0 10px 10px;
		border-bottom:1px solid #CFCFCF;
	}
	.customFilterDiv .filterMain .filterProperty:last-child{
		margin-bottom:100px;
	}
	.customFilterDiv .filterMain .filterProperty span{
		font-size:18px;
		display:block;
		margin-top:10px;
		color:#979797;
	}
	.customFilterDiv .filterMain .filterProperty ul{
		overflow:hidden;
		margin-right: -10px;
	}
	.customFilterDiv .filterMain .filterProperty li{
		display: block;
	    float: left;
	    width: 25%;
	    margin-top: 15px;
	}
	.customFilterDiv .filterMain .filterProperty li:nth-child(n<3){
	    margin-top: 0px;
	}
	.customFilterDiv .filterMain .filterProperty li a{
	    position: relative;
	    display: block;
	    height: 29px;
	    line-height: 29px;
	    margin-right: 10px;
	    font-size: 12px;
	    text-align: center;
	 	border:1px solid #CFCFCF;
	 	border-radius:5px;
	}
	.customFilterDiv .filterMain .filterProperty li .active{
	 	border:1px solid #F00;
	}
	.customFilterDiv .filterFooter{
		position:fixed;
		bottom:0;
		left:0;
		width:100%;
		background-color:#FAFAFA;
		text-align:center;
		padding: 6px 0px;
	}
	.customFilterDiv .filterFooter>button{
		padding: 8px 5px;
	    border-radius: 3px;
	    width: 60px;
	    line-height: normal;
	    font-size: .5rem;
	}
	.customFilterDiv .filterFooter .cancelBtn{
		background-color: #FFF;
	    color: #6A6A6A;
	    border: 1px solid #6A6A6A;
	    width:40%;
	    margin-right:10%;
	}
	.customFilterDiv .filterFooter .sureBtn{
	    background-color: red;
	    color: #fff;
	    border: 1px solid red;
	    font-family: "微软雅黑";
	    width:40%;
	}
</style>
<div class="customFilterDiv" id="customFilterDiv">
	<div class="filterSearch">
        <input type="text" placeholder="请输入关键字搜索" id="customFilterKeyword"/>
        <button class="findProductBtn" onclick="searchByKeywordFilter()" ><i class="icon iconfont">&#xe610;</i></button>
    </div>
    <div class="filterMain">
    	<div class="filterProperty mainProperty" data-property="productClassify">
    		<span>分类</span>
    		<div>
    			<ul>
    				<c:forEach items="${classifyList}" var="classify">
    					<li data-id="${classify.customClassifyId}"><a>${classify.customClassifyName}</a></li>
    				</c:forEach>
    			</ul>
    		</div>
    	</div>
    </div>
    <div class="filterFooter">
    	<button class="cancelBtn">取消</button>
    	<button class="sureBtn">确定</button>
    </div>
</div>
<script>	
	function showCustomFilter(){
		$(".customFilterDiv").show();
		$("body").addClass("body");
	}
	$(".cancelBtn").tap(function(){
		$(".customFilterDiv").hide();
		$("body").removeClass("body");
	});
	
	$(".sureBtn").tap(function(){
		searchByKeywordFilter();
	});
	
	function searchByKeywordFilter(){
		$(".mainProperty").each(function(){
			var property=$(this).attr("data-property");
			var propertyValue="";
			$(this).find("a[class='active']").each(function(){
				propertyValue+=$(this).parent().attr("data-id")+";";
			});
			console.log(property)
			$("input[name='"+property+"']").val(propertyValue);
		});
		
		$("input[name='keyword']").val($("#customFilterKeyword").val());
		$("#customProductForm").submit();
	}
</script> 
