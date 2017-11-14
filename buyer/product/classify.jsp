<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <meta charset="UTF-8">
    <title>金明同达灯饰</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/customer/assets/css/search_bar_white.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/customer/assets/css/classification.css">
</head>
<body>

<div class="search">
    <img src="<%=request.getContextPath() %>/resources/customer/assets/images/classification/dfbt.png" onclick="window.location.href = '<%=request.getContextPath()%>/buyer/index'">
    <div class="searchframe" style="width: 5rem;flex-grow: 1; background-color:#f2f2f2;">
        <img style="height: 50%; margin-top: 0.6rem;" class="search_icon" src="<%=request.getContextPath() %>/resources/customer/assets/images/search_bar/search_black.png"
             alt="搜索">
        <input class="search_input" id="keyword" type="text" placeholder="请输入要查找的内容"
               style="width: 5rem; flex-grow: 1;background-color:#f2f2f2;">
        <img style="height: 50%;margin-top: 0.6rem;" class="icon" src="<%=request.getContextPath() %>/resources/customer/assets/images/search_bar/clear_black.png" alt="删除"
             onclick="clearSearch()">
    </div>
    <img src="<%=request.getContextPath() %>/resources/customer/assets/images/search_bar/cs_black.png" onclick="askForClientService()">
</div>

<div style="display: flex; width: 100%; height: 100%;">
    <div class="left">
        <button class="class" id="selectedclass_button" onclick="selectClass(this, 0)">类型</button>
        <button class="class" onclick="selectClass(this, 1)">风格</button>
        <button class="class" onclick="selectClass(this, 2)">空间</button>
        <button class="class" onclick="selectClass(this, 3)">材质</button>
        <button class="class" onclick="selectClass(this, 4)">价格</button>
    </div>
    <div class="right">

        <div class="typeclass subclass">
            <button class="alloption classoptionselected" id="type" onclick="selectAll(this)">全部类型</button>
            <c:forEach items="${typeList}" var="property">
	            <button class="classoption typeoption" onclick="selectOption(this)" data-id="${property.propertyValueId }">
	                <img class="classimg" src="${property.propertyDesc }">
	                <br>
	               		 ${property.propertyValue}
	            </button>
			</c:forEach>
        </div>
        <div class="styleclass subclass" hidden>
            <button class="alloption classoptionselected" id="style" onclick="selectAll(this)">全部风格</button>
            <c:forEach items="${styleList}" var="property">
	            <button class="classoption styleoption" onclick="selectOption(this)" data-id="${property.propertyValueId }">
	                <img class="classimg" src="${property.propertyDesc }">
	                <br>
	               		 ${property.propertyValue}
	            </button>
			</c:forEach>
        </div>
        <div class="spaceclass subclass" hidden>
            <button class="alloption classoptionselected" id="space" onclick="selectAll(this)">全部空间</button>
            <c:forEach items="${spaceList}" var="property">
	            <button class="classoption spaceoption" onclick="selectOption(this)" data-id="${property.propertyValueId }">
	                <img class="classimg" src="${property.propertyDesc }">
	                <br>
	               		 ${property.propertyValue}
	            </button>
			</c:forEach>
        </div>
        <div class="materialclass subclass" hidden>
            <button class="alloption classoptionselected" id="material" onclick="selectAll(this)">全部材质</button>
            <c:forEach items="${materialList}" var="property">
	            <button class="classoption materialoption" onclick="selectOption(this)" data-id="${property.propertyValueId }">
	                <img class="classimg" src="${property.propertyDesc }">
	                <br>
	               		 ${property.propertyValue}
	            </button>
			</c:forEach>
        </div>
        <div class="priceclass subclass" hidden>
            <button class="alloption classoptionselected" id="price" onclick="selectAll(this)">全部价格</button>
            <button class="priceoption" onclick="selectMoney(this)" data-to="500">500元以下</button>
            <button class="priceoption" onclick="selectMoney(this)" data-from="500" data-to="1000">500-1000元</button>
            <button class="priceoption" onclick="selectMoney(this)" data-from="1000" data-to="2000">1000-2000元</button>
            <button class="priceoption" onclick="selectMoney(this)" data-from="2000" data-to="4000">2000-4000元</button>
            <button class="priceoption" onclick="selectMoney(this)" data-from="4000" data-to="6000">4000-6000元</button>
            <button class="priceoption" onclick="selectMoney(this)" data-from="6000" data-to="8000">6000-8000元</button>
            <button class="priceoption" onclick="selectMoney(this)" data-from="8000" data-to="10000">8000-10000元</button>
            <button class="priceoption" onclick="selectMoney(this)" data-from="10000">10000元以上</button>
            &nbsp
            <hr>

            <div class="diytitle">自定义价格(元)</div>
            <input class="money_input" id="fromPrice" type="number" onfocus="this.parentNode.childNodes[1].click()" placeholder="最低价">
            <input class="money_input" id="toPrice" type="number" onfocus="this.parentNode.childNodes[1].click()" placeholder="最高价">
        </div>

    </div>
</div>


<div class="bottomBar">
    <button class="bottom_button" onclick="reset()">重置</button>
    <button class="bottom_button" onclick="window.location.href = '<%=request.getContextPath()%>/buyer/index'">取消</button>
    <button class="bottom_button" onclick="searchProduct()"
    	style="background-color: #f38200; color: white; border-color: #f38200; width: 40%;">
        确定
    </button>
</div>

</body>

<script type="text/javascript">

    var classButton = document.getElementsByClassName("class");
    var body = document.getElementsByTagName("body")[0];
    var searchBar = document.getElementsByClassName("search")[0];
    var searchInput = document.getElementsByClassName("search_input")[0];
    var subClassDiv = document.getElementsByClassName("subclass");
    var allSelectArray = document.getElementsByClassName("alloption");
    var classBar = document.getElementsByClassName("class");
    var moneyInput = document.getElementsByClassName("money_input")

    /*设置网页高度*/
    body.style.height = window.screen.height - (searchBar.clientHeight + 1) * 2 + "px";

    function clearSearch() {
        searchInput.value = "";
    }

    function askForClientService() {
        /*客服*/
    }

    function selectClass(object, num) {
        for (var i = 0; i < classButton.length; i++) {
            classButton[i].id = "";
        }
        object.id = "selectedclass_button";

        for (var i = 0; i < subClassDiv.length; i++) {
            subClassDiv[i].hidden = !(i == num);
        }
    }

    function selectAll(object) {
        var buttonArray = document.getElementsByClassName(object.id + "option");
        if (object.className.indexOf("classoptionselected") <= 0) {//如果没有被选
            for (var i = 0; i < buttonArray.length; i++) {
                buttonArray[i].className = "classoption " + object.id + "option";
            }
            object.className += " classoptionselected";
        }
    }

    function selectedNumber(objects) {
        var number = 0;
        for (var i = 0; i < objects.length; i++) {
            if (objects[i].className.indexOf("classoptionselected") >= 0) {
                ++number;
            }
        }
        return number;
    }

    function selectOption(object) {
        var selectAllButton = object.parentNode.childNodes[1];
        var thisClassArray = document.getElementsByClassName(object.parentNode.childNodes[1].id + "option");
        if (selectAllButton.className.indexOf("classoptionselected") >= 0) {//如果全选按钮被选了
            selectAllButton.className = "alloption";//取消全选按钮
        }

        if (object.className.indexOf("classoptionselected") >= 0) {//如果本按钮被选了
            var array = object.className.split(' ');
            object.className = "";
            array.forEach(function (t) {
                object.className += (t != "classoptionselected") ? (t + " ") : "";
            })
            if (!selectedNumber(thisClassArray)) {//如果取消掉最后一个，则自动点击全选
                object.parentNode.childNodes[1].click();
            }
        } else {//如果本按钮没有被选中
            object.className += " classoptionselected";
        }
    }

    function reset() {
        /*清除搜索栏*/
        searchInput.value = "";
        /*所有分类改为全选*/
        for (var i = 0; i < allSelectArray.length; i++) {
            allSelectArray[i].click();
        }
        /*返回第一个分类*/
        classBar[0].click();
        for (var i = 0; i < moneyInput.length; i++) {
            moneyInput[i].value = "";
        }
    }

    function selectMoney(object) {
    	var priceoption=document.getElementsByClassName("priceoption");
        for(var i=0;i<priceoption.length;i++){
        	priceoption[i].className = priceoption[i].className.replace('classoptionselected','');
        }
        selectOption(object);//执行选择方法
        
        /*清除两个moneyInput的数据*/
        for (var i = 0; i < moneyInput.length; i++) {
            moneyInput[i].value = "";
        }
    }
	
    function searchProduct(){
    	var typeId="";
    	option=document.getElementsByClassName("typeoption");
    	for(var i=0;i<option.length;i++){
        	if(hasClass(option[i],'classoptionselected')){
        		typeId+=option[i].getAttribute("data-id")+';';
        	}
        }
    	
    	var styleId='';
    	option=document.getElementsByClassName("styleoption");
    	for(var i=0;i<option.length;i++){
        	if(hasClass(option[i],'classoptionselected')){
        		styleId+=option[i].getAttribute("data-id")+';';
        	}
        }
    	
    	var spaceId='';
    	option=document.getElementsByClassName("spaceoption");
    	for(var i=0;i<option.length;i++){
        	if(hasClass(option[i],'classoptionselected')){
        		styleId+=option[i].getAttribute("data-id")+';';
        	}
        }
    	
    	var materialId='';
    	option=document.getElementsByClassName("materialoption");
    	for(var i=0;i<option.length;i++){
        	if(hasClass(option[i],'classoptionselected')){
        		styleId+=option[i].getAttribute("data-id")+';';
        	}
        }
    	
    	option=document.getElementsByClassName("priceoption");
    	for(var i=0;i<option.length;i++){
    		if(hasClass(option[i],'classoptionselected')){
    			document.getElementById("fromPrice").value=option[i].getAttribute("data-from");
    			document.getElementById("toPrice").value=option[i].getAttribute("data-to");
    		}
    	}
    	
    	window.location.href="<%=request.getContextPath()%>/product/productList?typeId="+typeId+
    			"&styleId="+styleId+"&spaceId="+spaceId+"&materialId="+materialId+
    			"&keyword="+document.getElementById("keyword").value+"&fromPrice="+
    			document.getElementById("fromPrice").value+"&toPrice="+
    			document.getElementById("toPrice").value;
    }
    
    function hasClass(obj, cls) {
        return obj.className.match(new RegExp('(\\s|^)' + cls + '(\\s|$)'));
    }
</script>


</html>