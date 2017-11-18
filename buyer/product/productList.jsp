<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="thumbnail" uri="/WEB-INF/tld/thumbnailTag.tld"%>

<!DOCTYPE html>
<meta name="viewport"
      content="width=device-width,height=device-height, user-scalable=no,initial-scale=1, minimum-scale=1, maximum-scale=1">
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>金明同达灯饰</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/customer/assets/css/fung.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/customer/assets/css/addtocart.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/customer/assets/js/vue.js"></script>
    <style type="text/css">

        .topbar {
            width: 100%;
            position: fixed;
            top: 0;
            height: 2.5rem;
            line-height: 2.5rem;
            z-index: 10;
            display: inline-flex;
            background: #fff;
        }

        .topbar_change {
            width: 100%;
            position: fixed;
            top: 0;
            height: 2.5rem;
            line-height: 2.5rem;
            z-index: 10;
            display: inline-flex;
        }

        .topbarbutton {
            width: 1.5rem;
            height: 1.5rem;
            margin: 0.5rem 0.6rem;
        }

        .middlebox {
            flex-grow: 1;
            display: inline-flex;
            height: 1.8rem;
            margin: 0.35rem;
            background-color: rgba(255, 255, 255, 0.8);
            border-radius: 0.9rem;
            border: 1px lightgray solid;
        }

        .search_img {
            height: 1.2rem;
            margin: 0.3rem 0 0.3rem 0.5rem;
        }

        .search_input {
            flex-grow: 1;
            height: 1.2rem;
            margin: 0.3rem;
            border: 0;
            background-color: rgba(255, 255, 255, 0);
        }

        .search_button {
            height: 1.2rem;
            width: 3rem;
            margin: 0.3rem auto;
            font-size: 0.8rem;
            background-color: rgba(255, 255, 255, 0);
            border: 0;
            border-left: 1px darkgray solid;
        }

        .topbar2 {
            border-top: 1px lightgray solid;
            top: 2.5rem;
        }

        .menu {
            width: 100%;
            height: 2.5rem;
            border-collapse: collapse;
            display: flex;
        }

        .menuselection {
            width: 33.333%;
            text-align: center;
            height: 2.4rem;
            border-bottom: 0.1rem #fff solid;
        }

        .menuselection_selected {
            border-bottom-color: #29a2f5;
            color: #29a2f5;
        }

        .dir {
            line-height: 1rem;
            font-size: 0.2rem;
            vertical-align: middle;
        }

        .goods_in2 {
            background-color: #fff;
            display: inline-block;
            width: 47%;
            float: left;
            margin-top: 0.5rem;
            margin-left: 2%;
            border-radius: 0.2rem;
        }

        .hotsale_img {
            width: auto;
            height: auto;
            max-width: 100%;
            max-height: 100%;
            vertical-align: middle;
            border-radius: 0.2rem;
        }

        .hotsalepicture {
            text-align: center;
        }

        .hotsaletitle {
            font-size: 1rem;
            height: 2.8rem;
            line-height: 1.4rem;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            vertical-align: middle;
            white-space: normal;
        }

        .hotsaledetail {
            font-size: 0.6rem;
            color: #898989;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .hotsaleprice {
            font-size: 1.2rem;
            color: #f55c19;
            line-height: 1.8rem;
        }

        .addtocart_img {
            float: right;
            width: 1.4rem;
            height: 1.4rem;
            margin: 0.2rem 0.5rem;
        }

        .classificationpage {
            height: 100%;
            width: 100%;
            position: fixed;
            top: 0;
            left: 0;
            background-color: #eee;
            z-index: 1000;
        }

        .bottom {
            width: 100%;
            white-space: nowrap;
        }

        .left {
            display: inline-block;
            width: 30%;
            height: auto;
            background-color: #fff;
            vertical-align: top;
            overflow: auto;
            float: left;
        }

        .right {
            display: inline-block;
            width: 70%;
            height: auto;
            float: left;
            vertical-align: top;
            overflow: auto;
        }

        .leftoption {
            height: 3rem;
            line-height: 3rem;
            font-size: 1.2rem;
            width: 100%;
            border-left: 2px #fff solid;
            text-align: center;
            border-bottom: 1px lightgray solid;
        }

        .leftoption_selected {
            background-color: #f2f2f2;
            border-left-color: #29a2f5;
        }

        .selectedAll {
            color: #000;
            background-color: #fff;
            border: 1px #fff solid;
            width: 95%;
            height: 3rem;
            line-height: 3rem;
            text-align: center;
            margin-left: 2.5%;
            margin-top: 0.5rem;
            border-radius: 0.5rem;
        }

        .rightoption {
            color: #000;
            background-color: #fff;
            border: 1px #fff solid;
            width: 30%;
            text-align: center;
            margin-left: 2%;
            margin-top: 0.5rem;
            border-radius: 0.5rem;
            float: left;
        }

        .rightoption_in2 {
            color: #000;
            background-color: #fff;
            border: 1px #fff solid;
            width: 45%;
            height: 2rem;
            line-height: 2rem;
            text-align: center;
            margin-left: 3%;
            margin-top: 0.5rem;
            border-radius: 0.5rem;
            float: left;
            font-size: 1rem;
        }

        .rightoption_selected {
            color: #29a2f5;
            border-color: #29a2f5;
        }

        .img_div {
            text-align: center;
            width: 70%;
            margin: 0 15%;
        }

        .img_div img {
            width: auto;
            height: auto;
            max-width: 100%;
            max-height: 100%;
            vertical-align: middle;
        }

        .hidden {
            display: none;
        }

        .bottomBar {
            height: 3rem;
            width: 100%;
            border-top: 1px darkgray solid;
            line-height: 3rem;
            text-align: center;
            position: fixed;
            bottom: 3rem;
            left: 0;
            background-color: #fff;
            z-index:10000;
        }

        .bottom_button {
            height: 2rem;
            background-color: #fff;
            border: 1px lightgray solid;
            color: gray;
            border-radius: 0.5rem;
            width: 20%;
            font-size: 1rem;
            margin: 2%;
        }

        #lowprice, #highprice {
            border: 0;
        }

    </style>
</head>

<body>

<!--<div class="topbar">
    <img class="topbar_img" src="<%=request.getContextPath()%>/resources/customer/assets/images/details/back.png" alt="返回">
    <span class="topbartitle">产品列表</span>
    <img class="topbar_img" src="<%=request.getContextPath()%>/resources/customer/assets/images/details/cart.png" alt="购物车">
</div>-->
<div class="topbar" id="topbar">
    <%--<img src="<%=request.getContextPath()%>/resources/customer/assets/images/top_bar/back.png" class="topbarbutton" onclick="window.location.href='<%=request.getContextPath()%>/buyer/index'">--%>    <div class="middlebox" onclick="displayClassification()">
        <img src="<%=request.getContextPath()%>/resources/customer/assets/images/search_bar/search_black.png" class="search_img">
        <div class="search_input"><span
                style="font-size: 0.8rem; color: ${empty productParam.keyword?'lightgray':'dimgray'}; vertical-align: top; line-height: 1.2rem">${empty productParam.keyword?'输入产品名':productParam.keyword}</span>
        </div>
    </div>
    <img onclick="window.location.href='<%=request.getContextPath() %>/shopcart/myShopcart'" src="<%=request.getContextPath()%>/resources/customer/assets/images/top_bar/cart.png" class="topbarbutton" onclick="window.location.href = ''">
</div>

<div class="topbar topbar2" id="sortbar">
    <div class="menu">
        <div class="menuselection" :class="{menuselection_selected: selected[0]}" @click="sortDefault()">默认</div>
        <div class="menuselection" :class="{menuselection_selected: selected[1]}"
             style="border-left: 1px lightgray solid; border-right: 1px lightgray solid;" @click="sortByPrice()">
            	价格
            <span class='dir'>{{words}}</span>
        </div>
        <div class="menuselection" onclick="displayClassification()">筛选</div>
    </div>
</div>

<script type="text/javascript">

    var body = document.getElementsByTagName('body')[0];
    var menu = new Vue({
        el: '#sortbar',
        data: {
            selected: [true, false],
            sortStatus: 0, //0为默认排序，1为从低到高，2为从高到低
            words: ""
        },
        methods: {
            sortDefault: function () {
                if (this.sortStatus == 1 || this.sortStatus == 2) {
                    this.selected = [true, false];
                    this.sortStatus = 0;
                    this.words = "";
                    /*此处ajax请求获取默认排序数据*/
                    $("input[name='orderBy']").val(1);
                    $("input[name='offset']").val(0);
                    noData=false;
                    mayLike.items=[];
                    loadProduct();
                }
            },
            sortByPrice: function () {
                if (this.sortStatus == 0) {//如果当前为默认排序
                    this.selected = [false, true];
                    this.sortStatus = 1;
                    this.words = "▲";
                    /*此处ajax请求获取价格从低到高排序数据*/
                    $("input[name='orderBy']").val(2);
                    $("input[name='offset']").val(0);
                    noData=false;
                    mayLike.items=[];
                    loadProduct();
                } else if (this.sortStatus == 1) {
                    this.sortStatus = 2;
                    this.words = "▼";
                    
                    /*此处ajax请求获取价格从低到高排序数据*/
                    $("input[name='orderBy']").val(3);
                    $("input[name='offset']").val(0);
                    noData=false;
                    mayLike.items=[];
                    loadProduct();
                } else if (this.sortStatus == 2) {
                    this.sortStatus = 1;
                    this.words = "▲";
                    
                    $("input[name='orderBy']").val(2);
                    $("input[name='offset']").val(0);
                    noData=false;
                    mayLike.items=[];
                    loadProduct();
                }
            }
        }
    })

</script>

<div class="placeholder" style="height: 5rem;"></div>

<div class="block" id="maylike">

    <div class="goods_in2" v-for="item in items" onclick="goodsDetails(this.getAttribute('gid'))" :gid="item.id">
        <div class="hotsalepicture"><img class='hotsale_img' :src='item.picDir'></div>
        <div class='hotsaletitle'>{{item.title}}</div>
        <div class='hotsaledetail'>{{item.details}}</div>
        <div class='hotsaleprice'>
            ¥{{item.price}}
            <img onclick="addGoodsToCart(this.parentNode.parentNode.getAttribute('gid'))" src="<%=request.getContextPath()%>/resources/customer/assets/images/recommend/cart.png"
                 class="addtocart_img">
        </div>
    </div>

</div>
<script type="text/javascript">

    var mayLike = new Vue({
        el: '#maylike',
        data: {
            items: [
            ]
        }
    });

    function goodsDetails(id) {
        /*跳转到详情页*/
        window.location.href = "<%=request.getContextPath()%>/product/productDetail?productId=" + id;
        /* alert('父元素的事件'); */
    }

    function getDocumentTop() {
        var scrollTop, bodyScrollTop = 0, documentScrollTop = 0;
        if (document.body) {
            bodyScrollTop = document.body.scrollTop;
        }
        if (document.documentElement) {
            documentScrollTop = document.documentElement.scrollTop;
        }
        scrollTop = (bodyScrollTop > documentScrollTop) ? bodyScrollTop : documentScrollTop;
        return scrollTop;
    }

    //可视窗口高度
    function getWindowHeight() {
        windowHeight = document.compatMode == 'CSS1Compat' ? document.documentElement.clientHeight : document.body.clientHeight;
        return windowHeight;
    }

    //滚动条滚动高度
    function getScrollHeight() {
        var scrollHeight = 0, bodyScrollHeight = 0, documentScrollHeight = 0;
        if (document.body) {
            bodyScrollHeight = document.body.scrollHeight;
        }
        if (document.documentElement) {
            documentScrollHeight = document.documentElement.scrollHeight;
        }
        scrollHeight = (bodyScrollHeight > documentScrollHeight) ? bodyScrollHeight : documentScrollHeight;
        return scrollHeight;
    }

    var oldOnscroll = window.onscroll;
    window.onscroll = function () {
        if(typeof oldOnscroll == 'function')
        	oldOnscroll();
        
        if (getScrollHeight()-20 <= getWindowHeight() + getDocumentTop()) {
            console.log("已经到底啦");
            if(canLoad && !noData){
        		canLoad=false;
            	loadProduct();
            }
        }
    }

</script>

<div class="addtocart" id="addtocart_waiting" hidden>
    <div style="height: 15%"></div>
    <div class="a2c_details">
        <span class="waiting_span">正在加载……</span>
        <img src="<%=request.getContextPath()%>/resources/customer/assets/images/cart/close.png" alt="关闭" class="closecart" onclick="closeCart()">
    </div>
</div>


<div class="addtocart" id="addtocart" hidden>
    <div style="height: 15%" onclick="closeCart()"></div>
    <div class="a2c_details">
        <div class="a2c_top">
            <img class="a2c_img" :src="picture">
            <div class="a2c_title_nso">
                <div class="a2c_title">
                    {{title}}
                </div>
                <div class="a2c_model">
                    型号:{{model}}
                </div>
                <div class="a2c_price_nso"><span class="a2c_price">¥{{price}}</span><span
                        class="a2c_salenumber">销量:{{saleNumber}}</span></div>
            </div>
        </div>
        <div class="a2c_middle" id="a2c_middle">
            <div class="selectionblock" v-for="(selection,index1) in selections">
                <div class="option_title">{{selection.title}}</div>
                <div class="option" v-for="(opt,index2) in selection.option"
                     :class="{option_selected: opt.option_selected}" :data-id="opt.id"
                     @click="selectOption(index1, index2)">{{opt.name}}
                </div>
            </div>
            <div class="placeholder"></div>
        </div>
        <div class="a2c_bottom">
            <table class="a2c_left">
                <tr>
                    <td style="font-size: 1.5rem;" onclick="minusOne()">&nbsp-&nbsp</td>
                    <td>
                        <input id="number_input" type="number"
                               onchange="numberOnchange()" value="1">
                    </td>
                    <td style="font-size: 1.5rem;" onclick="addOne()">&nbsp+&nbsp</td>
                </tr>
            </table>
            <div class="a2c_right" onclick="confirmToAdd()">加入购物车</div>
        </div>
        <img src="<%=request.getContextPath()%>/resources/customer/assets/images/cart/close.png" alt="关闭" class="closecart" onclick="closeCart()">
    </div>
</div>

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
   	<input type="hidden" name="offset" value="0"> 
</form>
<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
<script type="text/javascript">


    function getGoodsInfo(goodsId) {
       

        /* ajax  请求数据 */
		changeProduct(goodsId);

    }

    function addGoodsToCart(goodsId) {
        /*在本页显示添加到购物车界面*/
        this.event.stopPropagation();
        var waiting_div = document.getElementById('addtocart_waiting');
        body.style.overflow = "hidden";
        body.style.height = "100%";
        waiting_div.hidden = false;
        getGoodsInfo(goodsId);
    }

    var middleBox = document.getElementById('a2c_middle');
    middleBox.onscroll = function (e) {
        e.preventDefault()
    }

    function closeCart() {
        var box1 = document.getElementById('addtocart');
        var box2 = document.getElementById('addtocart_waiting');
        box1.hidden = true;
        box2.hidden = true;
        body.style.overflow = 'auto';
    }

    function numberOnchange() {
        var numberInput = document.getElementById('number_input');
        if (parseInt(numberInput.value) <= 0) {
            alert("只能输入大于0的值");
            numberInput.value = 1;
        }
    }

    function minusOne() {
        var numberInput = document.getElementById('number_input');
        if (numberInput.value > 1) {
            numberInput.value = parseInt(numberInput.value) - 1;
        } else {
            alert('已经是最小啦！')
        }
    }

    function addOne() {
        var numberInput = document.getElementById('number_input');
        numberInput.value = parseInt(numberInput.value) + 1;
    }

    var addToCart = new Vue({
        el: "#addtocart",
        data: {
            title: "女孩因没见到偶像急哭 Angelababy降临安慰合照 女孩因没见到偶像急哭 Angelababy降临安慰合照 女孩因没见到偶像急哭 Angelababy降临安慰合照",
            model: "Subaru BRZ",
            price: "666",
            saleNumber: '1688',
            picture:"",
            selections: [
                {
                    title: '规格',
                    option: [
                        {name: '选项1', option_selected: true}
                    ],
                }
                
            ]
        },
        methods: {
            selectOption: function (indexSelection, indexOption) {
                for (var i = 0; i < this.selections[indexSelection].option.length; i++) {
                    this.selections[indexSelection].option[i].option_selected = false;
                }
                this.selections[indexSelection].option[indexOption].option_selected = true;
                changeProduct(this.selections[indexSelection].option[indexOption].id);
            }
        }
    })

    function confirmToAdd(){
    	addShopcart();
    }
    
    loadProduct();
    
    var canLoad=true;      //滚动加载时是否可以查询后台
    var noData=false;	   //数据是否全部加载完
    function loadProduct(){
    	var url="<%=request.getContextPath()%>/product/productListAjax";
    	var params = $("#productForm").serialize();
    	doAjax("GET",url,params,loadProductSuccess,fail,true,false);
    }
    
    //加载产品回调函数
    function loadProductSuccess(data){
    	var productList = data.list;
		var html="";
		for(var i=0;i<productList.length;i++){
			console.log(productList[i])
			mayLike.items.push(
               {
                   id: productList[i].productId,
                   picDir: changePath(productList[i].cover1),
                   title: productList[i].productName,
                   details: productList[i].productCode,
                   price: productList[i].retailPrice
               }
           	);
		}
		
		
		if((parseInt($("input[name='offset']").val())+10)>=data.count){
			noData=true;
		}
		$("input[name='offset']").val(data.after);
		canLoad=true; 
    }
    
    function fail(data){
    	console.log(data);
    }
    
    //更改图片路径，读取缩略图
    function changePath(path){
		var i=path.lastIndexOf("/");
		return path.substring(0,i+1)+"thumbnailImage/"+path.substring(i+1);
	}

</script>

<div class="classificationpage" id="classificationpage" <c:if test="${empty showFilter }">style="display: none;"</c:if>>
    <div class="topbar" id="topbar_search" style="border-bottom: 1px lightgray solid; position: static;">
        <img src="<%=request.getContextPath()%>/resources/customer/assets/images/top_bar/back.png" class="topbarbutton" onclick="backToList()">
        <div class="middlebox">
            <img src="<%=request.getContextPath()%>/resources/customer/assets/images/search_bar/search_black.png" class="search_img">
            <input class="search_input" id="keyword" placeholder="输入产品名" value="${productParam.keyword }">
        </div>
        <img src="<%=request.getContextPath()%>/resources/customer/assets/images/top_bar/cart.png" class="topbarbutton" onclick="window.location.href = '<%=request.getContextPath()%>/shopcart/myShopcart'">
    </div>
    <div class="bottom">
        <div class="left">
            <div class="leftoption" v-for="(item, index) in leftOption" :class="{leftoption_selected: item.selected}"
                 @click="changeLeft(index)">
                {{item.title}}
            </div>
        </div>
        <div class="right" :class="{hidden: !leftOption[0].selected}">
            <div class="selectedAll rightoption_selected" onclick="selectedAll(this)">全部类型</div>
            <c:forEach items="${typeList}" var="property">
	            <div class="rightoption typeoption" onclick="selectedOption(this)" data-id="${property.propertyValueId}">
	                <div class="img_div">
	                    <img src="${property.propertyDesc }">
	                </div>
	                <span class="option_name">${property.propertyValue}</span>
	            </div>
            </c:forEach>
        </div>
        <div class="right" :class="{hidden: !leftOption[1].selected}">
            <div class="selectedAll rightoption_selected" onclick="selectedAll(this)">全部风格</div>
            <c:forEach items="${styleList}" var="property">
	            <div class="rightoption styleoption" onclick="selectedOption(this)" data-id="${property.propertyValueId}">
	                <div class="img_div">
	                    <img src="${property.propertyDesc }">
	                </div>
	                <span class="option_name">${property.propertyValue}</span>
	            </div>
            </c:forEach>
        </div>
        <div class="right" :class="{hidden: !leftOption[2].selected}">
            <div class="selectedAll rightoption_selected" onclick="selectedAll(this)">全部空间</div>
            <c:forEach items="${spaceList}" var="property">
	            <div class="rightoption spaceoption" onclick="selectedOption(this)" data-id="${property.propertyValueId}">
	                <div class="img_div">
	                    <img src="${property.propertyDesc }">
	                </div>
	                <span class="option_name">${property.propertyValue}</span>
	            </div>
            </c:forEach>
        </div>
        <div class="right" :class="{hidden: !leftOption[3].selected}">
            <div class="selectedAll rightoption_selected" onclick="selectedAll(this)">全部材质</div>
            <c:forEach items="${materialList}" var="property">
	            <div class="rightoption materialoption" onclick="selectedOption(this)" data-id="${property.propertyValueId}">
	                <div class="img_div">
	                    <img src="${property.propertyDesc }">
	                </div>
	                <span class="option_name">${property.propertyValue}</span>
	            </div>
            </c:forEach>
        </div>
        <div class="right" :class="{hidden: !leftOption[4].selected}">
            <div>
                <div class="selectedAll rightoption_selected" id="selectallprice" onclick="selectedAll(this)">全部价格</div>
                <div class="rightoption_in2 priceoption" onclick="selectedMoneyOption(this)" data-to="100">100以下</div>
                <div class="rightoption_in2 priceoption" onclick="selectedMoneyOption(this)" data-from="100" data-to="200">100-200元</div>
                <div class="rightoption_in2 priceoption" onclick="selectedMoneyOption(this)" data-from="200" data-to="500">200-500元</div>
                <div class="rightoption_in2 priceoption" onclick="selectedMoneyOption(this)" data-from="500" data-to="1000">500-1000元</div>
                <div class="rightoption_in2 priceoption" onclick="selectedMoneyOption(this)" data-from="1000" data-to="2000">1000-2000元</div>
                <div class="rightoption_in2 priceoption" onclick="selectedMoneyOption(this)" data-from="2000" data-to="3000">2000-3000元</div>
                <div class="rightoption_in2 priceoption" onclick="selectedMoneyOption(this)" data-from="3000" data-to="5000">3000-5000元</div>
                <div class="rightoption_in2 priceoption" onclick="selectedMoneyOption(this)" data-from="5000" data-to="8000">5000-8000元</div>
                <div class="rightoption_in2 priceoption" onclick="selectedMoneyOption(this)" data-from="8000">8000元以上</div>
            </div>
            <div class="selectedAll" style="float: left; margin-top: 2rem;">自定义价格(元)</div>
            <input type="number" id="lowprice" class="rightoption_in2" placeholder="最低价" value="" onchange="inputMoney()">
            <input type="number" id="highprice" class="rightoption_in2" placeholder="最高价" value="" onchange="inputMoney()">
        </div>
        <div class="placeholder" style="height: 3rem;"></div>
        <div class="bottomBar">
            <button class="bottom_button" onclick="clearAll()">重置</button>
            <button class="bottom_button" onclick="backToList()">取消</button>
            <button class="bottom_button" onclick="searchProduct()"
                    style="background-color: #29a2f5; color: white; border-color: #29a2f5; width: 40%;">
                确定
            </button>
        </div>
    </div>

</div>

<jsp:include
        page="/jsp/buyer/footer.jsp"></jsp:include>

<script type="text/javascript">
	var searchInput = document.getElementById("keyword");
	console.log(searchInput)
	<c:if test="${!empty showFilter}">searchInput.focus();</c:if>
	
    var classificationPage = new Vue({
        el: '#classificationpage',
        data: {
            leftOption: [
                {
                    title: "类型",
                    selected: true,
                },
                {
                    title: "风格",
                    selected: false
                },
                {
                    title: "空间",
                    selected: false
                },
                {
                    title: "材质",
                    selected: false
                },
                {
                    title: "价格",
                    selected: false
                }
            ]
        },
        methods: {
            changeLeft: function (id) {
                for (var i = 0; i < this.leftOption.length; i++) {
                    this.leftOption[i].selected = id == i ? true : false;
                }
            }
        }
    });

    var selectAll_button = document.getElementsByClassName('selectedAll');
    var lowPriceInput = document.getElementById('lowprice');
    var highPriceInput = document.getElementById('highprice');
    var firstLeftOption = document.getElementsByClassName('leftoption')[0];
    var classificationPage = document.getElementById('classificationpage');
    var imgBlock = document.getElementsByClassName('img_div');

    function clearAll() {
        for (var i = 0;i<selectAll_button.length;i++){
            selectAll_button[i].click();
        }
        lowPriceInput.value='';
        highPriceInput.value='';
        firstLeftOption.click();
    }

    function backToList() {
        clearAll();
        classificationPage.style.display = 'none';
    }

    function allNotSelected(list) {//全部没选返回true，选择了返回false
        for (var i = 0; i < list.length; i++) {
            if (list[i].nodeType == 1) {//如果是元素节点
                if (list[i].className.indexOf('rightoption_selected') >= 0) {
                    return false
                }
            }
        }
        return true
    }

    function selectedOption(object) {
        var tempArray;
        var selectAllButton = object.parentNode.childNodes[0];
        if (object.className.indexOf('rightoption_selected') < 0) { //没有被选择
            if (selectAllButton.className.indexOf('rightoption_selected') > 0) {
                tempArray = selectAllButton.className.split(' ');
                for (var i = 0; i < tempArray.length; i++) {
                    if (tempArray[i] == 'rightoption_selected') {
                        tempArray.splice(i, 1);
                        break;
                    }
                }
                selectAllButton.className = tempArray.join(' ');
            }
            tempArray = object.className.split(' ');
            tempArray.push('rightoption_selected');
            object.className = tempArray.join(' ');
        } else { //已经被选择
            tempArray = object.className.split(' ');
            for (var i = 0; i < tempArray.length; i++) {
                if (tempArray[i] == 'rightoption_selected') {
                    tempArray.splice(i, 1);
                    break;
                }
            }
            object.className = tempArray.join(' ');
            if (allNotSelected(object.parentNode.childNodes)) {
                selectAllButton.className += " rightoption_selected";
            }
        }
    }

    function selectedMoneyOption(object) {
    	var priceoption=document.getElementsByClassName("priceoption");
        for(var i=0;i<priceoption.length;i++){
	        priceoption[i].className = priceoption[i].className.replace('rightoption_selected','');
        }
        
        selectedOption(object);
        lowPriceInput.value = '';
        highPriceInput.value = '';
    }

    function selectedAll(object) {
        var tempArray;
        var brotherList = object.parentNode.childNodes;
        if (object.className.indexOf('rightoption_selected') < 0) {//如果没有被选
            for (var i = 0; i < brotherList.length; i++) {
                if (brotherList[i].nodeType == 1) {
                    if (brotherList[i].className.indexOf('rightoption_selected') >= 0) {
                        tempArray = brotherList[i].className.split(' ');
                        for (var j = 0; j < tempArray.length; j++) {
                            if (tempArray[j] == 'rightoption_selected') {
                                tempArray.splice(j, 1);
                            }
                        }
                        brotherList[i].className = tempArray.join(' ');
                    }
                }
            }
            object.className += " rightoption_selected";
        }
    }

    function inputMoney() {
        selectedAll(document.getElementById('selectallprice'));
    }


    var winHeight;
    if (window.innerHeight) winHeight = window.innerHeight;
    else if ((document.body) && (document.body.clientHeight)) winHeight = document.body.clientHeight;
    document.getElementsByClassName('left')[0].style.height = winHeight - parseInt(window.getComputedStyle(document.documentElement)["fontSize"]) * 5 + 'px';
    document.getElementsByClassName('right')[0].style.height = winHeight - parseInt(window.getComputedStyle(document.documentElement)["fontSize"]) * 5 + 'px';

    function displayClassification() {
        classificationPage.style.display='block';
        for (var i = 0; i < imgBlock.length; i++) {
            imgBlock[i].style.height = imgBlock[0].offsetWidth + 'px';
            imgBlock[i].style.lineHeight = imgBlock[0].offsetWidth + 'px';
        }
    }
    
    
    function searchProduct(){
    	var typeId="";
    	option=document.getElementsByClassName("typeoption");
    	for(var i=0;i<option.length;i++){
        	if(hasClass(option[i],'rightoption_selected')){
        		typeId+=option[i].getAttribute("data-id")+';';
        	}
        }
    	
    	var styleId='';
    	option=document.getElementsByClassName("styleoption");
    	for(var i=0;i<option.length;i++){
        	if(hasClass(option[i],'rightoption_selected')){
        		styleId+=option[i].getAttribute("data-id")+';';
        	}
        }
    	
    	var spaceId='';
    	option=document.getElementsByClassName("spaceoption");
    	for(var i=0;i<option.length;i++){
        	if(hasClass(option[i],'rightoption_selected')){
        		styleId+=option[i].getAttribute("data-id")+';';
        	}
        }
    	
    	var materialId='';
    	option=document.getElementsByClassName("materialoption");
    	for(var i=0;i<option.length;i++){
        	if(hasClass(option[i],'rightoption_selected')){
        		styleId+=option[i].getAttribute("data-id")+';';
        	}
        }
    	
    	option=document.getElementsByClassName("priceoption");
    	for(var i=0;i<option.length;i++){
    		if(hasClass(option[i],'rightoption_selected')){
    			document.getElementById("lowprice").value=option[i].getAttribute("data-from");
    			document.getElementById("highprice").value=option[i].getAttribute("data-to");
    		}
    	}
    	
    	window.location.href="<%=request.getContextPath()%>/product/productList?typeId="+typeId+
    			"&styleId="+styleId+"&spaceId="+spaceId+"&materialId="+materialId+
    			"&keyword="+document.getElementById("keyword").value+"&fromPrice="+
    			document.getElementById("lowprice").value+"&toPrice="+
    			document.getElementById("highprice").value;
    }
    
    function hasClass(obj, cls) {
        return obj.className.match(new RegExp('(\\s|^)' + cls + '(\\s|$)'));
    }
    
    var productId;
    function changeProduct(productId){
		var url="<%=request.getContextPath()%>/product/getProductAjax";
		var params={productId:productId};
		doAjax("GET",url,params,changeSuccess,fail,true,false);
	}

	var percent="${percent}";
	function changeSuccess(data){
		var product = data.data;
		if(percent!=""){
			product.product.unitPrice=(product.product.unitPrice+Math.ceil(product.product.unitPrice*parseFloat(percent))).toFixed(2);
		}
		
		addToCart.title=product.product.productName;
		addToCart.model=product.product.productCode;
		addToCart.price=product.product.retailPrice;
		addToCart.saleNumber=product.product.productSales;
		addToCart.picture=changePath(product.product.cover1);
		
		addToCart.selections[0].option=[];
		for(var i=0;i<product.seriesProductList.length;i++){
			addToCart.selections[0].option.push(
					{id:product.seriesProductList[i].productId,name: product.seriesProductList[i].productName, 
					option_selected: product.seriesProductList[i].productId==product.product.productId});
		}
		var waiting_div = document.getElementById('addtocart_waiting');
	    var addToCart_div = document.getElementById('addtocart');
	 	addToCart_div.hidden = false;
        waiting_div.hidden = true;
		
		productId=product.product.productId;

	}
	
	//加入购物车
    function addShopcart(){
    	var url = "<%=request.getContextPath()%>/shopcart/addShopcart";
		var params = {productId: productId,num:$("#number_input").val()};
		doAjax("GET", url, params, addShopcartSuccess, 
				function(data){console.log(data);console.log("加入购物车失败");}, true, false);
    }
    
    //加入购物车成功
    function addShopcartSuccess(data){ 
        alert("添加成功！");
        closeCart();
    }
	
</script>

</body>
</html>