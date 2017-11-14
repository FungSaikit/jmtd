<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="thumbnail" uri="/WEB-INF/tld/thumbnailTag.tld" %>

<!DOCTYPE html>
<html lang="zh">
<head>
    <meta name="viewport"
          content="width=device-width,height=device-height, user-scalable=no,initial-scale=1, minimum-scale=1, maximum-scale=1">
    <meta charset="UTF-8">
    <title>金明同达灯饰</title>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/customer/assets/js/vue.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/common/swiper-3.4.2.min.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/customer/assets/css/fung.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/customer/assets/css/swiper-3.4.2.min.css">
    <style type="text/css">

        .block {
            margin-top: 0.5rem;
            border-bottom: 1px lightgray solid;
        }

        .header {
            height: 3rem;
            line-height: 3rem;
            width: 100%;
            display: flex;
            background-color: #fff;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 10;
            border-bottom: 1px lightgray solid;
        }

        .header img {
            height: 1.2rem;
            width: 1.2rem;
            margin: auto 1rem;
        }

        .mid_button {
            flex-grow: 1;
            text-align: center;
        }

        .topbaroption {
            display: inline-block;
            height: 2.8rem;
            width: 3rem;
            border-bottom: 0.2rem #fff solid;
        }

        .block {
            margin: 0;
            padding: 0;
        }

        .topbaroption_selected {
            color: #29a2f5;
            border-bottom-color: #29a2f5;
        }

        .swiper-container {
            height: 6rem;
            width: 100%;
        }

        .swiper-wrapper {
            text-align: center;
            font-size: 0;
        }

        .swiper-slide {
            font-size: 0;
        }

        .swiper_img {
            width: 100%;
            height: 100%;
            vertical-align: middle;
        }

        .detailsbox {
            padding: 0.5rem;
        }

        .title {
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            vertical-align: middle;
        }

        .details {
            font-size: 0.8rem;
            color: gray;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 1;
            -webkit-box-orient: vertical;
            vertical-align: middle;
        }

        .price_nso {
            color: #f55f0a;
        }

        #page2 {
            margin-top: 0.5rem;
            padding: 1rem;
        }

        .detailstable {
            width: 100%;
            border-collapse: collapse;
        }

        .detailstable tr {
            height: 3rem;
            border-bottom: 1px #eee solid;
        }

        .detailstable th {
            text-align: left;

        }

        .detailstable td {
            text-align: left;
            color: #9a9a9a;
        }

        .uppull {
            margin-top: 0.5rem;
            width: 100%;
            height: 2rem;
            line-height: 2rem;
            text-align: center;
            color: #9a9a9a;
            font-size: 0.8rem;
        }

        .uppull span {
            vertical-align: middle;
        }

        .pull_img {
            height: 1rem;
            width: 1rem;
            vertical-align: middle;
        }

        #page3 {
            margin-top: 0.5rem;
            padding: 1rem
        }

        .bottomBar {
            width: 100%;
            height: 3rem;
            line-height: 3rem;
            background-color: #fff;
            display: flex;
            position: fixed;
            bottom: 0;
            left: 0;
            color: #000;
            text-align: center;
            border-top: 1px lightgray solid;
        }

        .contect_cs {
            width: 30%;
        }

        .addtocartbutton {
            width: 35%;
            color: #fff;
            background-color: gray;
        }

        .buynow {
            width: 35%;
            color: #fff;
            background-color: #29a2f5;
        }

        .addtocart {
            position: fixed;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.8);
            z-index: 11;
            color: #000;
        }

        .a2c_details {
            background-color: #fff;
            height: 85%;
            padding: 0.5rem;
            display: flex;
            flex-direction: column;
            position: relative;
        }

        .a2c_top {
            height: 9rem;
            padding: 0.5rem;
            display: flex;
            border-bottom: 1px #f3f3f3 solid;
        }

        .a2c_img {
            height: 6rem;
            width: 6rem;
            margin-right: 0.5rem;
        }

        .a2c_title_nso {
            flex-grow: 1;
        }

        .a2c_title {
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            vertical-align: middle;
            height: 3rem;
            color: #000;
        }

        .a2c_model {
            font-size: 0.8rem;
            color: #999;
            height: 1rem;
        }

        .a2c_salenumber {
            color: #000;
        }

        .a2c_price {
            color: #f38200;
            height: 2rem;
            line-height: 2rem;
        }

        .a2c_salenumber {
            height: 2rem;
            line-height: 2rem;
            font-size: 0.8rem;
            float: right;
            color: #9f9f9f;
        }

        .selectionblock {
            width: 100%;
            margin-top: 0.5rem;
            border-bottom: 1px #f3f3f3 solid;
        }

        .selectionblock:after {
            content: '';
            clear: both;
            display: block;
            padding-bottom: 0.5rem;
        }

        .option_title {
            color: #434343;
            font-size: 0.8rem;
            margin-left: 0.5rem;
        }

        .option {
            background-color: #f3f3f3;
            display: inline-block;
            width: 46%;
            height: 2rem;
            line-height: 2rem;
            margin: 0.5rem 0 0 2%;
            float: left;
            text-align: center;
            font-size: 0.8rem;
            color: #444;
            border: 1px #f3f3f3 solid;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .option_selected {
            border: 1px #29a2f5 solid;
            color: #29a2f5;
            background-color: #fff;
        }

        .a2c_middle {
            flex-grow: 1;
            overflow: auto;
            margin-bottom: 0.5rem;
        }

        .a2c_bottom {
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 3rem;
            line-height: 3rem;
            background-color: #fff;
            border-top: 1px #f3f3f3 solid;
        }

        .a2c_right {
            display: inline-block;
            background-color: #f28f29;
            height: 100%;
            width: 8rem;
            text-align: center;
            color: #fff;
            float: right;
        }

        .a2c_left {
            display: inline-block;
        }

        .a2c_left td {
            border-left: 1px #f3f3f3 solid;
            border-right: 1px #f3f3f3 solid;
        }

        .waiting_span {
            display: inline-block;
            text-align: center;
            width: 10rem;
            height: 2rem;
            position: fixed;
            top: 0;
            bottom: 0;
            left: 0;
            right: 0;
            margin: auto;
            font-size: 0.8rem;
            color: gray;
        }

        #number_input {
            font-size: 1rem;
            height: 2rem;
            text-align: center;
            width: 4rem;
            border: 0;
        }

        .closecart {
            position: absolute;
            top: 0;
            right: 0;
            width: 1.5rem;
            height: 1.5rem;
            padding: 0.2rem;
        }

        .detailstitle {
            white-space: nowrap;
        }

    </style>
</head>
<body>

<div class="header" id="topbar">
    <img src="<%=request.getContextPath()%>/resources/customer/assets/images/details/back.png" alt="返回"
         onclick="history.go(-1)">
    <div class="mid_button">
        <div class="topbaroption" :class="{topbaroption_selected: selected[0]}" @click="selectThis(0)">商品</div>
        <div class="topbaroption" :class="{topbaroption_selected: selected[1]}" @click="selectThis(1)">参数</div>
        <div class="topbaroption" :class="{topbaroption_selected: selected[2]}" @click="selectThis(2)">详情</div>
    </div>
    <img onclick="window.location.href='<%=request.getContextPath()%>/shopcart/myShopcart'"
         src="<%=request.getContextPath()%>/resources/customer/assets/images/details/cart.png" alt="购物车">
</div>

<div class="placeholder" id="jumppage1"></div>

<div class="block" id="page1" style="padding-bottom: 0.5rem;">
    <div class="swiper-container" id="swiperbox">
        <div class="swiper-wrapper">
            <c:if test="${!empty product.product.cover1 }">
                <a class="swiper-slide" href="#">
                    <img class="swiper_img" src="${product.product.cover1 }">
                </a>
            </c:if>
            <c:if test="${!empty product.product.cover2 }">
                <a class="swiper-slide" href="#">
                    <img class="swiper_img" src="${product.product.cover2}">
                </a>
            </c:if>
            <c:if test="${!empty product.product.cover3 }">
                <a class="swiper-slide" href="#">
                    <img class="swiper_img" src="${product.product.cover3}">
                </a>
            </c:if>
            <c:if test="${!empty product.product.cover4 }">
                <a class="swiper-slide" href="#">
                    <img class="swiper_img" src="${product.product.cover4}">
                </a>
            </c:if>
            <c:if test="${!empty product.product.cover5 }">
                <a class="swiper-slide" href="#">
                    <img class="swiper_img" src="${product.product.cover5}">
                </a>
            </c:if>
        </div>
        <div class="swiper-pagination"></div>
    </div>
    <div class="detailsbox">
        <div class="title" id="productName">${product.product.productName }</div>
        <div class="details productPower">功率:${product.product.productPower }</div>
        <div class="price_nso">¥ <span class="productPrice">${product.product.retailPrice }</span> <span
                style="float: right; font-size: 0.8rem; color: gray;"
                class="productSales">销量：${product.product.productSales }</span></div>
        <div class="modelselect">
            <div>
                产品规格：
                <div id="seeprice" style="float: right;" onclick="seePrice()">+</div>
                <div id="hiddenprice" style="float: right; color: #f38200; font-size: 0.8rem" onclick="hidePrice()"
                     hidden>
                    <del style="color: #000;">原价:9999.9</del>
                    活动价:9999.0
                </div>
            </div>
            <div class="option option_selected">型号1</div>
            <div class="option">型号2</div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var body = document.getElementsByTagName('body')[0];
    var seePriceButton = document.getElementById("seeprice");
    var hiddenPriceButton = document.getElementById("hiddenprice");

    function seePrice() {
        seePriceButton.hidden = true;
        hiddenPriceButton.hidden = false;
    }

    function hidePrice() {
        hiddenPriceButton.hidden = true;
        seePriceButton.hidden = false;
    }

    var winHeight, winWidth;
    if (window.innerHeight) winHeight = window.innerHeight;
    else if ((document.body) && (document.body.clientHeight)) winHeight = document.body.clientHeight;
    if (window.innerWidth) winWidth = window.innerWidth;
    else if ((document.body) && (document.body.clientWidth)) winWidth = document.body.clientWidth;
    var page1 = document.getElementById('page1');
    var topBar = document.getElementById('topbar');
    var mainImgDiv = document.getElementById('swiperbox');
    mainImgDiv.style.height = mainImgDiv.offsetWidth + 'px';
    var swiper = new Swiper('.swiper-container', {
        loop: true,
        pagination: '.swiper-pagination',
        autoplay: 3000,
        autoplayDisableOnInteraction: false
    });

</script>

<script type="text/javascript">

    var topBar = new Vue({
        el: '#topbar',
        data: {
            selected: [
                true,
                false,
                false
            ]
        },
        methods: {
            selectThis: function (num) {
                for (var i = 0; i < this.selected.length; i++) {
                    this.selected[i] = (num == i);
                }
                switch (num) {
                    case 0:
                        window.location.href = '#jumppage1';
                        break;
                    case 1:
                        window.location.href = '#jumppage2';
                        break;
                    case 2:
                        window.location.href = '#jumppage3';
                        break;
                    default:
                        break;
                }
                this.selected.push(0);
                this.selected.pop();
            }
        }
    });

</script>

<div class="uppull" id="jumppage2">
    <img class="pull_img" src="<%=request.getContextPath()%>/resources/customer/assets/images/details/pull.png" alt="">
    <span>上拉查看产品参数</span>
</div>

<div class="block" id="page2">
    <h1 style="font-size: 1.2rem; margin-bottom: 1rem; border-bottom: 1px lightgray solid;">产品参数</h1>
    <table class="detailstable" id="detailstable">
        <tr>
            <th class="detailstitle">产品规格：</th>
            <td id="productSize"><c:if test="${!empty product.product.productLength }"><fmt:formatNumber
                    value=" ${product.product.productLength }" pattern="#0"/>*</c:if>
                <c:if test="${!empty product.product.productWidth }"><fmt:formatNumber
                        value=" ${product.product.productWidth }" pattern="#0"/>*</c:if>
                <c:if test="${!empty product.product.productHeight }"><fmt:formatNumber
                        value="${product.product.productHeight }" pattern="#0"/><c:if
                        test="${!empty product.product.productDiameter }">*</c:if></c:if>
                <c:if test="${!empty product.product.productDiameter }"><fmt:formatNumber
                        value=" ${product.product.productDiameter}" pattern="#0"/></c:if></td>
        </tr>
        <tr>
            <th class="detailstitle">包装规格：</th>
            <td id="packageSize"><c:if test="${!empty product.product.packageLength }"><fmt:formatNumber
                    value="${product.product.packageLength }" pattern="#0"/>*</c:if>
                <c:if test="${!empty product.product.packageWidth }"><fmt:formatNumber
                        value="${product.product.packageWidth }" pattern="#0"/>*</c:if>
                <c:if test="${!empty product.product.packageHeight }"><fmt:formatNumber
                        value=" ${product.product.packageHeight }" pattern="#0"/>cm</c:if>
            </td>
        </tr>
        <tr>
            <th class="detailstitle">适用空间：</th>
            <td id="space">${product.space }</td>
        </tr>
        <tr>
            <th class="detailstitle">产品材质：</th>
            <td id="material">${product.material }</td>
        </tr>
        <tr>
            <th class="detailstitle">光源类型：</th>
            <td id="lightType">${product.lightType }</td>
        </tr>
        <tr>
            <th class="detailstitle">光源数量：</th>
            <td id="lightNumber">${product.product.lightNumber }</td>
        </tr>
        <tr>
            <th class="detailstitle">功率：<br>(自带光源)</th>
            <td id="productPower">${product.product.productPower }</td>
        </tr>
    </table>
</div>

<div class="uppull" id="jumppage3">
    <img class="pull_img" src="<%=request.getContextPath()%>/resources/customer/assets/images/details/pull.png" alt="">
    <span>上拉查看图文详情</span>
</div>

<div class="block" id="page3">
    <h1 style="font-size: 1.2rem; margin-bottom: 1rem; border-bottom: 1px lightgray solid;">图文详情</h1>
    <div style="font-size: 0;">
        <c:if test="${!empty product.product.descriptionPic1 }"><img src="${product.product.descriptionPic1 }"
                                                                     style="width:100%;height:100%;"/></c:if>
        <c:if test="${!empty product.product.descriptionPic2 }"><img src="${product.product.descriptionPic2 }"
                                                                     style="width:100%;height:100%;"/></c:if>
        <c:if test="${!empty product.product.descriptionPic3 }"><img src="${product.product.descriptionPic3 }"
                                                                     style="width:100%;height:100%;"/></c:if>
        <c:if test="${!empty product.product.descriptionPic4 }"><img src="${product.product.descriptionPic4 }"
                                                                     style="width:100%;height:100%;"/></c:if>
        <c:if test="${!empty product.product.descriptionPic5 }"><img src="${product.product.descriptionPic5 }"
                                                                     style="width:100%;height:100%;"/></c:if>
        <c:if test="${!empty product.product.descriptionPic6 }"><img src="${product.product.descriptionPic6 }"
                                                                     style="width:100%;height:100%;"/></c:if>
        <c:if test="${!empty product.product.descriptionPic7 }"><img src="${product.product.descriptionPic7 }"
                                                                     style="width:100%;height:100%;"/></c:if>
        <c:if test="${!empty product.product.descriptionPic8 }"><img src="${product.product.descriptionPic8 }"
                                                                     style="width:100%;height:100%;"/></c:if>
        <c:if test="${!empty product.product.descriptionPic9 }"><img src="${product.product.descriptionPic9 }"
                                                                     style="width:100%;height:100%;"/></c:if>
        <c:if test="${!empty product.product.descriptionPic10 }"><img src="${product.product.descriptionPic10 }"
                                                                      style="width:100%;height:100%;"/></c:if>
        <c:if test="${!empty product.product.descriptionPic11 }"><img src="${product.product.descriptionPic11 }"
                                                                      style="width:100%;height:100%;"/></c:if>
        <c:if test="${!empty product.product.descriptionPic12 }"><img src="${product.product.descriptionPic12 }"
                                                                      style="width:100%;height:100%;"/></c:if>
        <c:if test="${!empty product.product.descriptionPic13 }"><img src="${product.product.descriptionPic13 }"
                                                                      style="width:100%;height:100%;"/></c:if>
        <c:if test="${!empty product.product.descriptionPic14 }"><img src="${product.product.descriptionPic14 }"
                                                                      style="width:100%;height:100%;"/></c:if>
        <c:if test="${!empty product.product.descriptionPic15 }"><img src="${product.product.descriptionPic15 }"
                                                                      style="width:100%;height:100%;"/></c:if>
        <c:if test="${!empty product.product.descriptionPic16 }"><img src="${product.product.descriptionPic16 }"
                                                                      style="width:100%;height:100%;"/></c:if>
        <c:if test="${!empty product.product.descriptionPic17 }"><img src="${product.product.descriptionPic17 }"
                                                                      style="width:100%;height:100%;"/></c:if>
        <c:if test="${!empty product.product.descriptionPic18 }"><img src="${product.product.descriptionPic18 }"
                                                                      style="width:100%;height:100%;"/></c:if>
        <c:if test="${!empty product.product.descriptionPic19 }"><img src="${product.product.descriptionPic19 }"
                                                                      style="width:100%;height:100%;"/></c:if>
        <c:if test="${!empty product.product.descriptionPic20 }"><img src="${product.product.descriptionPic20 }"
                                                                      style="width:100%;height:100%;"/></c:if>
    </div>
</div>

<script type="text/javascript">

    var page2 = document.getElementById('page2');
    page2.style.height = "auto";
    page2.style.minHeight = (winHeight - parseInt(window.getComputedStyle(document.documentElement)["fontSize"]) * 8) + "px";
    var page3 = document.getElementById('page3');
    page3.style.height = "auto";
    page3.style.minHeight = (winHeight - parseInt(window.getComputedStyle(document.documentElement)["fontSize"]) * 8) + "px";


</script>

<div class="placeholder"></div>

<div class="bottomBar">
    <div class="contect_cs" onclick="closeWindow();">联系客服</div>
    <div class="addtocartbutton" onclick="addGoodsToCart(1,1);">加入购物车</div>
    <!-- addGoodsToCart(goodsid, func) func==1为加入购物车，2为直接购买-->
    <div class="buynow" onclick="addGoodsToCart(1, 2);">立即购买</div>
</div>

<script type="text/javascript">

    var swiperBox = document.getElementById('swiperbox');
    var page2Table = document.getElementById('detailstable');

    //滚动条高度+视窗高度 = 可见区域底部高度
    var visibleBottom = window.scrollY + document.documentElement.clientHeight;
    //可见区域顶部高度
    var visibleTop = window.scrollY;

    var oldOnscroll = window.onscroll;
    window.onscroll = function () {
        if (typeof oldOnscroll == 'function') {
            oldOnscroll();
        }


        if (swiperBox.offsetTop + winWidth - window.scrollY > 0) {
            /*topBar.selected.splice(0, 0, true);
            topBar.selected.splice(0, 0, false);
            topBar.selected.splice(2, 0, false);*/
            topBar.selected = [true, false, false];
        } else if (page2Table.offsetTop + winWidth - window.scrollY > 0) {
            /*topBar.selected.splice(0, 0, false);
            topBar.selected.splice(0, 0, true);
            topBar.selected.splice(2, 0, false);*/
            topBar.selected = [false, true, false];

        } else {
            topBar.selected = [false, false, true];

        }
    }

</script>


<div class="addtocart" id="addtocart_waiting" hidden>
    <div style="height: 15%"></div>
    <div class="a2c_details">
        <span class="waiting_span">正在加载……</span>
        <img src="<%=request.getContextPath()%>/resources/customer/assets/images/cart/close.png" alt="关闭"
             class="closecart" onclick="closeCart()">
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
            <div class="a2c_right" id="add_n_buy" onclick="confirmToAdd()">加入购物车</div>
        </div>
        <img src="<%=request.getContextPath()%>/resources/customer/assets/images/cart/close.png" alt="关闭"
             class="closecart" onclick="closeCart()">
    </div>
</div>

<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/jweixin-1.0.0.js"></script>
<script type="text/javascript">

    var addAndBuy = document.getElementById('add_n_buy');


    function addGoodsToCart(goodsId, func) {
        /*在本页显示添加到购物车界面*/
        this.event.stopPropagation();
        var waiting_div = document.getElementById('addtocart_waiting');
        body.style.overflow = "hidden";
        body.style.height = "100%";
        waiting_div.hidden = false;
        console.log(addAndBuy);
        getGoodsInfo(goodsId, func);
    }

    function getGoodsInfo(goodsId, func) {

        /* ajax  请求产品数据 */

        /* setTimeout(function () { */
        var box1 = document.getElementById('addtocart');
        var box2 = document.getElementById('addtocart_waiting');
        var addAndBuy = document.getElementById('add_n_buy');
        box1.hidden = false;
        box2.hidden = true;
        if (func == 1) {
            addAndBuy.innerHTML = "加入购物车";
            addAndBuy.setAttribute('onclick', 'addMe()');
        } else if (func == 2) {
            addAndBuy.innerHTML = "立即购买";
            addAndBuy.setAttribute('onclick', 'buyMe()');
        }
        /*
                }, 1000); */
    }

    var productId = ${product.product.productId};

    function changeProduct(productId) {
        var url = "<%=request.getContextPath()%>/product/getProductAjax";
        var params = {productId: productId};
        doAjax("GET", url, params, changeSuccess, fail, true, false);
    }

    var percent = "${percent}";

    function changeSuccess(data) {
        var product = data.data;
        swiper.removeAllSlides();
        if (product.product.cover1 != null)
            swiper.appendSlide('<a class="swiper-slide" href="#"><img class="swiper_img" src="' + product.product.cover1 + '"></a>');
        if (product.product.cover2 != null)
            swiper.appendSlide('<a class="swiper-slide" href="#"><img class="swiper_img" src="' + product.product.cover2 + '"></a>');
        if (product.product.cover3 != null)
            swiper.appendSlide('<a class="swiper-slide" href="#"><img class="swiper_img" src="' + product.product.cover3 + '"></a>');
        if (product.product.cover4 != null)
            swiper.appendSlide('<a class="swiper-slide" href="#"><img class="swiper_img" src="' + product.product.cover4 + '"></a>');
        if (product.product.cover5 != null)
            swiper.appendSlide('<a class="swiper-slide" href="#"><img class="swiper_img" src="' + product.product.cover5 + '"></a>');

        if (percent != "") {
            product.product.unitPrice = (product.product.unitPrice + Math.ceil(product.product.unitPrice * parseFloat(percent))).toFixed(2);
        }

        addToCart.title = product.product.productName;
        addToCart.model = product.product.productCode;
        addToCart.price = product.product.retailPrice;
        addToCart.saleNumber = product.product.productSales;
        addToCart.picture = changePath(product.product.cover1);

        $("#productName").html(product.product.productName);
        $(".productPower").html("功率:" + (product.product.productPower == null ? '' : product.product.productPower));
        $(".productPrice").html(product.product.retailPrice);
        $(".productSales").html("销量：" + product.product.productSales);
        $("#lightNumber").html(product.product.lightNumber);
        $("#space").html(product.space);
        $("#productColor").html(product.product.productColor);
        //$("#productCode").html(product.product.productCode);


        var productSize = "";
        if (product.product.productLength != null) {
            productSize += "" + product.product.productLength + "*";
        }
        if (product.product.productWidth != null) {
            productSize += "" + product.product.productWidth + "*";
        }
        if (product.product.productHeight != null) {
            productSize += "" + product.product.productHeight + ((product.product.productDiameter != null) ? "*" : "");
        }
        if (product.product.productDiameter != null) {
            productSize += "" + product.product.productDiameter;
        }
        $("#productSize").html(productSize + "mm");

        $("#productWeight").html(product.product.productWeight);

        var packageSize = "";
        if (product.product.packageLength != null) {
            packageSize += "" + product.product.packageLength + "*";
        }
        if (product.product.packageWidth != null) {
            packageSize += "" + product.product.packageWidth + "*";
        }
        if (product.product.packageHeight != null) {
            packageSize += "" + product.product.packageHeight;
        }
        $("#packageSize").html(packageSize + "cm");

        $("#packageWeight").html(product.product.packageWeight);

        productId = product.product.productId;

    }

    function fail(data) {
        cosole.log("fail");
    }


    //更改图片路径，读取缩略图
    function changePath(path) {
        var i = path.lastIndexOf("/");
        return path.substring(0, i + 1) + "thumbnailImage/" + path.substring(i + 1);
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
            title: "${product.product.productName}",
            model: "${product.product.productCode}",
            price: "${product.product.retailPrice}",
            picture: "<thumbnail:date value='${product.product.cover1}'/>",
            saleNumber: '${product.product.productSales}',
            selections: [
                {
                    title: '型号',
                    option: [
                        <c:forEach items="${seriesList}" var="seriesProduct">
                        {
                            id: '${seriesProduct.productId}',
                            name: '${seriesProduct.productCode}',
                            option_selected: ${seriesProduct.productId==product.product.productId}
                        },
                        </c:forEach>
                    ]
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
    });

    function buyMe() {
        /*直接购买产品*/
        buyImmediately();
        closeCart();
    }

    function addMe() {
        /*加入购物车*/
        addShopcart();
    }

    //加入购物车
    function addShopcart() {
        var url = "<%=request.getContextPath()%>/shopcart/addShopcart";
        var params = {productId: productId, num: $("#number_input").val()};
        doAjax("GET", url, params, addShopcartSuccess,
            function (data) {
                console.log(data);
                console.log("加入购物车失败");
            }, true, false);
    }

    //加入购物车成功
    function addShopcartSuccess(data) {
        alert("添加到购物车！");
        closeCart();
    }

    function buyImmediately() {
        window.location.href = '<%=request.getContextPath() %>/buyer/buyImmediately?productId=' + productId +
            '&num=' + $("#number_input").val();
    }

    function closeWindow() {
        var url = location.href.split('#')[0].replace(/&/g, "-");
        var urlStr = "<%=request.getContextPath()%>/wechat/signature?url=" + url;
        //alert("Before Call:"+urlStr);
        $.ajax({
            method: "GET",
            url: urlStr,
            success: function (data, status, jqXHR) {
                //alert(data.appId+","+data.signature+","+data.timeStamp+","+data.nonceStr);
                var result = data;
                var appId = result.appId;
                var signature = result.signature;
                var timeStamp = result.timeStamp;
                var nonceStr = result.nonceStr;

                wx.config({
                    debug: false,// 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                    appId: appId, // 必填，公众号的唯一标识
                    timestamp: timeStamp, // 必填，生成签名的时间戳
                    nonceStr: nonceStr, // 必填，生成签名的随机串
                    signature: signature,// 必填，签名，见附录1
                    jsApiList: ['closeWindow'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
                });
                wx.error(function (res) {

                });
                wx.ready(function () {
                    url = "<%=request.getContextPath()%>/buyer/sendWarnMessage";
                    var params = {};
                    doAjax("GET", url, params, function (data) {
                    }, function (data) {
                        console.log(fail);
                    }, true, false);
                    wx.closeWindow();
                });
            }
        }); // end ajax
    }
</script>


</body>
</html>
