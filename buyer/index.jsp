<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="thumbnail" uri="/WEB-INF/tld/thumbnailTag.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="zh">
<head>
    <meta name="viewport"
          content="width=device-width,height=device-height, user-scalable=no,initial-scale=1, minimum-scale=1, maximum-scale=1">
    <meta charset="UTF-8">
    <title>金明同达灯饰</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/customer/assets/css/fung.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/customer/assets/css/swiper-3.4.2.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/customer/assets/css/index.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/customer/assets/js/vue.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/common/swiper-3.4.2.min.js"></script>

</head>
<body>
<div id="topnavibar">
    <div class="topbar topnavibar" style="background-color:#fafafa;">
        <div :class="{hidden: detailsIsShow}">
            <div class="topnavibar_class"
                 onclick="window.location.href='<%=request.getContextPath()%>/product/productList?showFilter=0'">
                今日推荐
            </div>
            <div class="topnavibar_class"
                 onclick="window.location.href='<%=request.getContextPath()%>/product/productList?typeId=&styleId=215;&spaceId=&materialId=&keyword=&fromPrice=&toPrice='">
                客厅灯
            </div>
            <div class="topnavibar_class"
                 onclick="window.location.href='<%=request.getContextPath()%>/product/productList?typeId=&styleId=226;&spaceId=&materialId=&keyword=&fromPrice=&toPrice='">
                餐吊灯
            </div>
            <div class="topnavibar_class"
                 onclick="window.location.href='<%=request.getContextPath()%>/product/productList?typeId=&styleId=214;&spaceId=&materialId=&keyword=&fromPrice=&toPrice='">
                卧室灯
            </div>
            <div class="topnavibar_class"
                 onclick="window.location.href='<%=request.getContextPath()%>/product/productList?typeId=&styleId=225;&spaceId=&materialId=&keyword=&fromPrice=&toPrice='">
                楼梯灯
            </div>
            <div class="topnavibar_class"
                 onclick="window.location.href='<%=request.getContextPath()%>/product/productList?typeId=180;&styleId=&spaceId=&materialId=&keyword=&fromPrice=&toPrice='">
                鸟笼灯
            </div>
            <div class="topnavibar_class"
                 onclick="window.location.href='<%=request.getContextPath()%>/product/productList?typeId=180;&styleId=&spaceId=&materialId=&keyword=&fromPrice=&toPrice='">
                风扇灯
            </div>
            <div class="topnavibar_class"
                 onclick="window.location.href='<%=request.getContextPath()%>/product/productList?typeId=&styleId=223;&spaceId=&materialId=&keyword=&fromPrice=&toPrice='">
                户外灯
            </div>
            <div class="topnavibar_class">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</div>
        </div>
        <div :class="{hidden: !detailsIsShow}" style="color: gray; margin-left: 0.5rem;">
            请选择
        </div>
        <div class="show_topnavi_details" v-if="!detailsIsShow" @click="showOrHideDetails()"><img
                src="<%=request.getContextPath()%>/resources/customer/assets/images/top_bar/show.png"></div>
        <div class="show_topnavi_details" v-if="detailsIsShow" @click="showOrHideDetails()"><img
                src="<%=request.getContextPath()%>/resources/customer/assets/images/top_bar/hide.png"></div>
    </div>
    <div class="topnavidetails" :class="{hidden: !detailsIsShow} ">
        <div class="topnavidetails_class"
             onclick="window.location.href='<%=request.getContextPath()%>/product/productList?typeId=&styleId=215;&spaceId=&materialId=&keyword=&fromPrice=&toPrice='">
            <div>
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/top_bar/0.png">
            </div>
            <span>客厅灯</span>
        </div>
        <div class="topnavidetails_class"
             onclick="window.location.href='<%=request.getContextPath()%>/product/productList?typeId=&styleId=226;&spaceId=&materialId=&keyword=&fromPrice=&toPrice='">
            <div>
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/top_bar/1.png">
            </div>
            <span>餐吊灯</span>
        </div>
        <div class="topnavidetails_class"
             onclick="window.location.href='<%=request.getContextPath()%>/product/productList?typeId=&styleId=214;&spaceId=&materialId=&keyword=&fromPrice=&toPrice='">
            <div>
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/top_bar/2.png">
            </div>
            <span>卧室灯</span>
        </div>
        <div class="topnavidetails_class"
             onclick="window.location.href='<%=request.getContextPath()%>/product/productList?typeId=&styleId=225;&spaceId=&materialId=&keyword=&fromPrice=&toPrice='">
            <div>
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/top_bar/3.png">
            </div>
            <span>楼梯灯</span>
        </div>
        <div class="topnavidetails_class"
             onclick="window.location.href='<%=request.getContextPath()%>/product/productList?typeId=180;&styleId=&spaceId=&materialId=&keyword=&fromPrice=&toPrice='">
            <div>
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/top_bar/4.png">
            </div>
            <span>鸟笼灯</span>
        </div>
        <div class="topnavidetails_class"
             onclick="window.location.href='<%=request.getContextPath()%>/product/productList?typeId=180;&styleId=&spaceId=&materialId=&keyword=&fromPrice=&toPrice='">
            <div>
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/top_bar/5.png">
            </div>
            <span>风扇灯</span>
        </div>
        <div class="topnavidetails_class"
             onclick="window.location.href='<%=request.getContextPath()%>/product/productList?typeId=&styleId=223;&spaceId=&materialId=&keyword=&fromPrice=&toPrice='">
            <div>
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/top_bar/6.png">
            </div>
            <span>户外灯</span>
        </div>
    </div>
</div>
<script type="text/javascript">
    var topNaviBar = new Vue({
        el: "#topnavibar",
        data: {
            detailsIsShow: false
        },
        methods: {
            showOrHideDetails: function () {
                this.detailsIsShow = !this.detailsIsShow;
            }
        }
    })
</script>

<div style="height: 2.5rem;"></div>

<div :class="topbar_class" id="topbar">
    <img :src="left_pic_directory" class="topbarbutton"
         onclick="showLeftBar()">
    <div class="middlebox">
        <img :src="search_directory" class="search_img">
        <input type="text" class="search_input" placeholder="输入产品名" v-model="keyword">
        <button class="search_button" @click="search">搜索</button>
    </div>
    <img :src="right_pic_directory" onclick="closeWindow()" class="topbarbutton">
</div>
<script type="text/javascript">

    var body = document.getElementsByTagName('body')[0];

    var topBar = new Vue({
        el: '#topbar',
        data: {
            topbar_class: "topbar",
            left_pic_directory: "<%=request.getContextPath()%>/resources/customer/assets/images/search_bar/menu.png",
            right_pic_directory: "<%=request.getContextPath()%>/resources/customer/assets/images/search_bar/cs.png",
            search_directory: "<%=request.getContextPath()%>/resources/customer/assets/images/search_bar/search_black.png",
            keyword: ""
        },
        methods: {
            search: function () {
                window.location.href = "<%=request.getContextPath()%>/product/productList?keyword=" + this.keyword;
            }
        }
    })

    /*window.onscroll = function () {
        var top = document.documentElement.scrollTop || document.body.scrollTop;
        if (top <= 0) {
            topBar.topbar_class = "topbar";
            topBar.left_pic_directory = "<%=request.getContextPath()%>/resources/customer/assets/images/search_bar/class_white.png";
            topBar.right_pic_directory = "<%=request.getContextPath()%>/resources/customer/assets/images/search_bar/cs_white.png";
            topBar.topbar_style = "background-color: rgba(255, 255, 255, 0)";
        } else if (top > 0 && top < 100) {
            topBar.topbar_class = "topbar_change";
            topBar.left_pic_directory = "<%=request.getContextPath()%>/resources/customer/assets/images/search_bar/class_black.png";
            topBar.right_pic_directory = "<%=request.getContextPath()%>/resources/customer/assets/images/search_bar/cs_black.png";
            topBar.topbar_style = "background-color: rgba(255, 255, 255, " + (0.3 + top * 0.6 / 100) + ")";
        } else {
            topBar.topbar_style = "background-color: rgba(255, 255, 255, 0.9)";
        }
    }*/

</script>

<div class="swiper-container" id="swiperbox">
    <div class="swiper-wrapper">
        <c:forEach items="${carouselList}" var="carousel">
            <c:if test="${!empty carousel.carouselPic}">
                <a class="swiper-slide" href="${carousel.carouselLink}">
                    <img class="swiper_img" src="${carousel.carouselPic}">
                </a>
            </c:if>
        </c:forEach>
    </div>
    <div class="swiper-pagination"></div>
</div>

<script type="text/javascript">

    var deviceWidth = window.screen.width;
    var swiper = document.getElementById('swiperbox');
    swiper.style.height = deviceWidth * 450 / 1080 + 'px';
    document.getElementsByClassName('swiper-wrapper')[0].style.lineHeight = deviceWidth * 450 / 1080 + 'px';

    var swiper = new Swiper('.swiper-container', {
        loop: true,
        pagination: '.swiper-pagination',
        autoplay: 3000,
        loop: true,
        autoplayDisableOnInteraction: false
    });

</script>

<div class="hotline flex">
    <div class="hotlinetitle">灯饰头条</div>
    <div class="hotlinecomment flex-grow">热烈庆祝金明同达灯饰微信商城正式上线！</div>
</div>

<div class="lightblock">
    <div class="lightblock_line">
        <div onclick="window.location.href='<%=request.getContextPath()%>/product/productList?type=180'">
            <div class="lightblockimg">
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/light/0-pendant.png">
            </div>
            <div class="lightblockspan">
                <span>吊灯</span>
            </div>
        </div>
        <div onclick="window.location.href='<%=request.getContextPath()%>/product/productList?type=185'">
            <div class="lightblockimg">
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/light/0-ceiling.png">
            </div>
            <div class="lightblockspan"><span>吸顶灯</span></div>
        </div>

        <div onclick="window.location.href='<%=request.getContextPath()%>/product/productList?type=181'">
            <div class="lightblockimg">
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/light/0-wall.png">
            </div>
            <div class="lightblockspan"><span>壁灯</span></div>
        </div>

        <div onclick="window.location.href='#'">
            <div class="lightblockimg">
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/light/0-tablelamp.png">
            </div>
            <div class="lightblockspan">
                <span>台灯</span>
            </div>
        </div>

        <div onclick="window.location.href='<%=request.getContextPath()%>/product/productList?type=659'">
            <div class="lightblockimg">
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/light/0-floorlamp.png">
            </div>
            <div class="lightblockspan">
                <span>落地灯</span>
            </div>
        </div>
    </div>
    <div class="lightblock_line">
        <div onclick="window.location.href='<%=request.getContextPath()%>/product/productList?material=190'">
            <div class="lightblockimg">
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/light/1-cupric.png">
            </div>
            <div class="lightblockspan">
                <span>全铜</span>
            </div>
        </div>

        <div onclick="window.location.href='<%=request.getContextPath()%>/product/productList?material=206'">
            <div class="lightblockimg">
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/light/1-ferric.png">
            </div>
            <div class="lightblockspan">
                <span>铁艺</span>
            </div>
        </div>

        <div onclick="window.location.href='<%=request.getContextPath()%>/product/productList?material=193'">
            <div class="lightblockimg">
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/light/1-zincic.png">
            </div>
            <div class="lightblockspan">
                <span>锌合金</span>
            </div>
        </div>

        <div onclick="window.location.href='<%=request.getContextPath()%>/product/productList?material=203'">
            <div class="lightblockimg">
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/light/1-wooden.png">
            </div>
            <div class="lightblockspan">
                <span>木艺</span>
            </div>
        </div>

        <div onclick="window.location.href='<%=request.getContextPath()%>/product/productList'">
            <div class="lightblockimg">
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/light/1-more.png">
            </div>
            <div class="lightblockspan">
                <span>更多</span>
            </div>
        </div>
    </div>
</div>

<div class="block">
    <div class="blocktitle">
        <div class="flex-grow"></div>
        <div class="br_line"></div>
        人气商品
        <div class="br_line"></div>
        <div class="flex-grow"></div>
    </div>
    <div>
        <%--<div class="wid"></div>--%>
        <%--<c:forEach items="${spreadProductList }" var="product">
            <div class="narrowbox">
                <img onclick="goodsDetails(${product.productId})" class="full_img" src="${product.cover1 }">
            </div>
        </c:forEach>--%><%--旧的人气商品--%>
        <div class="flex" style="margin-bottom: 0.2rem">
            <div style="width: 0.2rem; flex-grow: 2; margin-right:0.2rem; font-size: 0;">
                <img style="width: 100%;"
                     src="<%=request.getContextPath()%>/resources/customer/assets/images/hot_sale/0.jpg">
            </div>
            <div class="flex-column" style="width: 0; flex-grow: 1;">
                <img style="width: 100%; margin-bottom: 0.2rem;"
                     src="<%=request.getContextPath()%>/resources/customer/assets/images/hot_sale/1.jpg">
                <img style="width: 100%;"
                     src="<%=request.getContextPath()%>/resources/customer/assets/images/hot_sale/2.jpg">
            </div>
        </div>
        <div class="flex">
            <div class="flex-grow" style="width: 0;margin-right: 0.2rem;">
                <img style="width: 100%;"
                     src="<%=request.getContextPath()%>/resources/customer/assets/images/hot_sale/3.jpg">
            </div>
            <div class="flex-grow" style="width: 0;margin-right: 0.2rem;">
                <img style="width: 100%;"
                     src="<%=request.getContextPath()%>/resources/customer/assets/images/hot_sale/4.jpg">
            </div>
            <div class="flex-grow" style="width: 0;">
                <img style="width: 100%;"
                     src="<%=request.getContextPath()%>/resources/customer/assets/images/hot_sale/5.jpg">
            </div>
        </div>
    </div>
</div>

<div class="block">
    <div class="blocktitle">
        <div class="flex-grow"></div>
        <div class="br_line"></div>
        空间精选
        <div class="br_line"></div>
        <div class="flex-grow"></div>
    </div>
    <div class="flex">
        <div class="recommend_in2"
             onclick="window.location.href = '<%=request.getContextPath()%>/product/productList?typeId=&styleId=215;&spaceId=&materialId=&keyword=&fromPrice=&toPrice='">
            <img class="recommend_pic"
                 src="<%=request.getContextPath()%>/resources/customer/assets/images/recommend/space0.jpg">
        </div>
        <div class="recommend_in2"
             onclick="window.location.href = '<%=request.getContextPath()%>/product/productList?typeId=&styleId=214;217;&spaceId=&materialId=&keyword=&fromPrice=&toPrice='">
            <img class="recommend_pic"
                 src="<%=request.getContextPath()%>/resources/customer/assets/images/recommend/space1.jpg">
        </div>
    </div>
    <div class="flex">
        <div class="recommend_in2"
             onclick="window.location.href = '<%=request.getContextPath()%>/product/productList?typeId=&styleId=226;&spaceId=&materialId=&keyword=&fromPrice=&toPrice='">
            <img class="recommend_pic"
                 src="<%=request.getContextPath()%>/resources/customer/assets/images/recommend/space2.jpg">
        </div>
        <div class="recommend_in4"
             onclick="window.location.href = '<%=request.getContextPath()%>/product/productList?typeId=&styleId=214;217;&spaceId=&materialId=&keyword=&fromPrice=&toPrice='">
            <img src="<%=request.getContextPath()%>/resources/customer/assets/images/recommend/space3.jpg">
        </div>
        <div class="recommend_in4" style="margin-left: 0.5%;"
             onclick="window.location.href = '<%=request.getContextPath()%>/product/productList?typeId=&styleId=218;&spaceId=&materialId=&keyword=&fromPrice=&toPrice='">
            <img src="<%=request.getContextPath()%>/resources/customer/assets/images/recommend/space4.jpg">
        </div>
    </div>
</div>

<div class="block">
    <div class="blocktitle">
        <div class="flex-grow"></div>
        <div class="br_line"></div>
        风格精选
        <div class="br_line"></div>
        <div class="flex-grow"></div>
    </div>
    <div class="flex" style="height: 15rem;">
        <div class="styleblock1 style_item">
            <div style="width: auto; margin-top: 10%">
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/recommend/style0.png"
                     class="style_img">
            </div>
            <div class="styleblock_title">现代简约</div>
            <div class="styleblock_content">精致优雅 品味生活</div>
        </div>
        <div class="styleblock2">
            <div class="style_item" style="height: 50%;">
                <div class="flex" style="height: 80%; width: 100%;">
                    <div style="height: 100%; line-height: 2rem;text-align: center; width: 4rem;">
                        <div style="height: 30%;"></div>
                        <div class="styleblock_title">欧式</div>
                    </div>
                    <div style="flex-grow: 1; text-align: right; margin-top: 5%; width: 1rem; flex-grow: 1; text-align: center;">
                        <img src="<%=request.getContextPath()%>/resources/customer/assets/images/recommend/style1.png"
                             class="style_img">
                    </div>
                </div>
                <div class="styleblock_content" style="height: 20%;">高端典雅 晶莹剔透</div>
            </div>
            <div class="flex flex-grow">
                <div class="style_item flex-grow flex-column" style="text-align: center; width: 1rem;">
                    <div class="styleblock_title" style="margin-top: 0.5rem;">美式</div>
                    <div class="styleblock_content">精致优雅 品味生活</div>
                    <div class="flex-grow">
                        <img style="max-width: 60%"
                             src="<%=request.getContextPath()%>/resources/customer/assets/images/recommend/style2.png"
                             class="style_img">
                    </div>
                </div>
                <div class="style_item flex-grow flex-column" style="text-align: center; width: 1rem;">
                    <div class="styleblock_title" style="margin-top: 0.5rem;">中式</div>
                    <div class="styleblock_content">传世经典 韵成于心</div>
                    <div class="flex-grow">
                        <img src="<%=request.getContextPath()%>/resources/customer/assets/images/recommend/style3.png"
                             class="style_img">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="flex styleblock3">
        <div class="style_item flex-grow flex-column" style="width: 1rem;">
            <div class="styleblock_title" style="margin-top: 0.5rem;">艺术个性</div>
            <div class="styleblock_content">点亮你的生活</div>
            <div class="flex-grow style_img_placeholder">
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/recommend/style4.png"
                     class="style_img">
            </div>
        </div>
        <div class="style_item flex-grow flex-column" style="width: 1rem;">
            <div class="styleblock_title" style="margin-top: 0.5rem;">儿童卡通</div>
            <div class="styleblock_content">童趣·纯真童年</div>
            <div class="flex-grow style_img_placeholder">
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/recommend/style5.png"
                     class="style_img">
            </div>
        </div>
        <div class="style_item flex-grow flex-column" style="width: 1rem;">
            <div class="styleblock_title" style="margin-top: 0.5rem;">法式</div>
            <div class="styleblock_content">传承品质 铸就经典</div>
            <div class="flex-grow style_img_placeholder">
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/recommend/style6.png"
                     class="style_img">
            </div>
        </div>
        <div class="style_item flex-grow flex-column" style="width: 1rem;">
            <div class="styleblock_title" style="margin-top: 0.5rem;">田园</div>
            <div class="styleblock_content">浪漫温馨 品味生活</div>
            <div class="flex-grow style_img_placeholder">
                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/recommend/style7.png"
                     class="style_img">
            </div>
        </div>
    </div>
</div>

<div class="block" style="overflow: hidden;">
    <div class="blocktitle">
        <div class="flex-grow"></div>
        <div class="br_line"></div>
        热销排行榜
        <div class="br_line"></div>
        <div class="flex-grow"></div>
    </div>
    <%--<div style="width: 100%;white-space: nowrap; overflow-x: auto; overflow-y: hidden;">
        <c:forEach items="${hotProductList}" var="product">
            <div class="goods" gid="${product.productId }" onclick="goodsDetails(this.getAttribute('gid'))">
                <div class="hotsalepicture"><img class='hotsale_img'
                                                 src='<thumbnail:date value="${product.cover1 }"/>'>
                </div>
                <div class='hotsaletitle'>${product.productName }</div>
                <div class='hotsaledetail'>${product.productCode }</div>
                <div class='hotsaleprice'>
                    ¥<fmt:formatNumber groupingUsed="false" type="number" value="${product.retailPrice }"
                                       maxFractionDigits="0"/>
                    <img src="<%=request.getContextPath()%>/resources/customer/assets/images/recommend/cart.png"
                         class="addtocart_img"
                         onclick="addGoodsToCart(this.parentNode.parentNode.getAttribute('gid'), this)">
                </div>
            </div>
        </c:forEach>
        <div id="morehotsale">
            <div onclick="window.location.href='<%=request.getContextPath()%>/product/productList?orderBy=0'">
                <img style="width: 2rem; height: 2rem; vertical-align: middle;"
                     src="<%=request.getContextPath()%>/resources/customer/assets/images/hot_sale/hotsale.png">
                <span style="vertical-align: middle;">发现更多</span>
            </div>
        </div>
    </div>--%><%--这里是滑动列表的代码--%>
    <div class="couponswiper-container">
        <div class="swiper-wrapper">
            <div class="swiper-slide flex">
                <div class="goods_in3">
                    <div class="hotsalepicture"><img class='hotsale_img' src='http://lanmao.zhuanlitou.com:8080/findeng/picture/product/thumbnailImage/15063927864480.jpg'></div>
                    <div class='hotsaletitle'>灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯</div>
                    <div class='hotsaledetail'>规格: 哈哈哈哈哈哈哈哈哈哈</div>
                    <div class='hotsaleprice'>
                        ¥ 100
                        <img onclick="addGoodsToCart(this.parentNode.parentNode.getAttribute('gid'))"
                             src="<%=request.getContextPath()%>/resources/customer/assets/images/recommend/cart.png"
                             class="addtocart_img">
                    </div>
                </div>
                <div class="goods_in3">
                    <div class="hotsalepicture"><img class='hotsale_img' src='http://lanmao.zhuanlitou.com:8080/findeng/picture/product/thumbnailImage/15063927864480.jpg'></div>
                    <div class='hotsaletitle'>灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯</div>
                    <div class='hotsaledetail'>规格: 哈哈哈哈哈哈哈哈哈哈</div>
                    <div class='hotsaleprice'>
                        ¥ 100
                        <img onclick="addGoodsToCart(this.parentNode.parentNode.getAttribute('gid'))"
                             src="<%=request.getContextPath()%>/resources/customer/assets/images/recommend/cart.png"
                             class="addtocart_img">
                    </div>
                </div>
                <div class="goods_in3">
                    <div class="hotsalepicture"><img class='hotsale_img' src='http://lanmao.zhuanlitou.com:8080/findeng/picture/product/thumbnailImage/15063927864480.jpg'></div>
                    <div class='hotsaletitle'>灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯灯</div>
                    <div class='hotsaledetail'>规格: 哈哈哈哈哈哈哈哈哈哈</div>
                    <div class='hotsaleprice'>
                        ¥ 100
                        <img onclick="addGoodsToCart(this.parentNode.parentNode.getAttribute('gid'))"
                             src="<%=request.getContextPath()%>/resources/customer/assets/images/recommend/cart.png"
                             class="addtocart_img">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">

    var goodSwiper = new Swiper('.couponswiper-container', {
        loop: true,
        autoplay: 3000,
        autoplayDisableOnInteraction: false
    });

    /*var pic = document.getElementsByClassName('hotsalepicture');
    var moreHotSale = document.getElementById('morehotsale');
    for (var i = 0; i < pic.length; i++) {
        pic[i].style.height = pic[i].clientWidth + 'px';
        pic[i].style.lineHeight = pic[i].clientWidth + 'px';
    }
    moreHotSale.style.height = document.getElementsByClassName('goods')[0].offsetHeight + 'px';
    moreHotSale.style.lineHeight = document.getElementsByClassName('goods')[0].offsetHeight + 'px';*/

    function goodsDetails(id) {
        /*跳转到详情页*/
        //window.location.href = "" + object.getAttribute('gid');
        window.location.href = "<%=request.getContextPath()%>/product/productDetail?productId=" + id;
    }

    function getGoodsInfo(goodsId) {

        var waiting_div = document.getElementById('addtocart_waiting');
        var addToCart_div = document.getElementById('addtocart');

        /* ajax  请求数据 */

        $("footer").hide();
        changeProduct(goodsId);
    }

    function addGoodsToCart(goodsId, e) {
        this.event.stopPropagation();//阻止事件传递
        /*在本页显示添加到购物车界面*/
        var waiting_div = document.getElementById('addtocart_waiting');
        body.style.overflow = "hidden";
        body.style.height = "100%";
        waiting_div.hidden = false;
        getGoodsInfo(goodsId);
    }

</script>


<script type="text/javascript">

    var wideBoxs = document.getElementsByClassName('widebox');
    var narrowBoxs = document.getElementsByClassName('narrowbox');
    for (var i = 0; i < wideBoxs.length; i++) {
        wideBoxs[i].style.height = 0.3 * deviceWidth + 'px';
    }
    for (var i = 0; i < narrowBoxs.length; i++) {
        narrowBoxs[i].style.height = 0.3 * deviceWidth + 'px';
    }
</script>

<div class="block" id="maylike">
    <div class="blocktitle">
        <div class="flex-grow"></div>
        <div class="br_line"></div>
        你可能喜欢
        <div class="br_line"></div>
        <div class="flex-grow"></div>
    </div>

    <div class="goods_in2" v-for="item in items" onclick="goodsDetails(this.getAttribute('gid'))" :gid="item.id">
        <div class="hotsalepicture"><img class='hotsale_img' :src='item.picDir'></div>
        <div class='hotsaletitle'>{{item.title}}</div>
        <div class='hotsaledetail'>{{item.details}}</div>
        <div class='hotsaleprice'>
            ¥{{item.price}}
            <img onclick="addGoodsToCart(this.parentNode.parentNode.getAttribute('gid'))"
                 src="<%=request.getContextPath()%>/resources/customer/assets/images/recommend/cart.png"
                 class="addtocart_img">
        </div>
    </div>

</div>
<div class="block loading" id="loading">
    <div class="blocktitle">
        正在加载更多……
    </div>
</div>
<script type="text/javascript">

    var mayLike = new Vue({
        el: '#maylike',
        data: {
            items: []
        }
    });

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

    /*var oldOnscroll = window.onscroll;
    window.onscroll = function () {
        oldOnscroll();
        if (getScrollHeight() == getWindowHeight() + getDocumentTop()) {
            console.log("已经到底啦");
            /!*!/!*setTimeout(function () {
                mayLike.items.push(
                    {
                        id: 1,
                        picDir: '<%=request.getContextPath()%>/resources/customer/assets/images/light/2-narrow0.jpg',
                        title: '满怀激动和喜悦之情，上海各界热烈庆贺十九大召开谈体会表心声',
                        details: '原标题：满怀激动和喜悦之情，上海各界热烈庆贺十九大召开谈体会表心声—— 不忘初心牢记使命，站上新起点',
                        price: 1000
                    },
                    {
                        id: 2,
                        picDir: '<%=request.getContextPath()%>/resources/customer/assets/images/light/2-narrow1.jpg',
                        title: '满怀激动和喜悦之情，上海各界热烈庆贺十九大召开谈体会表心声',
                        details: '原标题：满怀激动和喜悦之情，上海各界热烈庆贺十九大召开谈体会表心声—— 不忘初心牢记使命，站上新起点',
                        price: 1111
                    }
                );
            }, 2000)*!/!*!/

        }
    }*/

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
    <div style="height: 15%"></div>
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
        <img src="<%=request.getContextPath()%>/resources/customer/assets/images/cart/close.png" alt="关闭"
             class="closecart" onclick="closeCart()">
    </div>
</div>
<jsp:include page="/jsp/buyer/footer.jsp"></jsp:include>
<script type="text/javascript">

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
        $("footer").show();
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
            picture: '',
            selections: [
                {
                    title: '规格',
                    option: [],
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

    function confirmToAdd() {
        addShopcart();
    }


    var canLoad = true;
    var noDate = false;
    var offset = 0;
    var wiwH = $(window).height();
    var load = $(".loading");
    loadProduct();

    /*加载产品*/
    function loadProduct() {
        var url = "";
        var params;

        if (sessionStorage.getItem("pageNo") > 0) {
            url = "<%=request.getContextPath()%>/buyer/indexProductBatch";
            params = {offset: sessionStorage.getItem("pageNo")};
            sessionStorage.removeItem("pageNo");
            doAjax("GET", url, params, function (data) {
                loadProductSuccess(data);
                document.body.scrollTop = sessionStorage.getItem("scrollTop");
            }, fail, true, false);
        } else {
            url = "<%=request.getContextPath()%>/buyer/indexProduct";
            params = {offset: offset};
            doAjax("GET", url, params, loadProductSuccess, fail, true, false);
            sessionStorage.removeItem("scrollTop");
        }
    }

    function loadProductBatch(pageNo) {
        var url = $("#path").val() + "/buyer/indexProductBatch";
        var params = {offset: pageNo, style: styleId}
        doAjax("GET", url, params, function (data) {
            loadProductSuccess(data);
        }, fail, true, false);
    }

    var percent = $("#percent").val();

    function loadProductSuccess(data) {
        var productList = data.list;
        var html = "";
        var i;
        for (i = 0; i < productList.length; i++) {
            mayLike.items.push({
                id: productList[i].productId,
                picDir: changePath(productList[i].cover1),
                title: productList[i].productName,
                details: productList[i].productCode,
                price: productList[i].retailPrice
            });
        }

        if ((parseInt(offset) + 10) >= data.count) {
            noDate = true;
        }
        if (i > 9 && i >= data.count) {
            noDate = true;
        }
        offset = data.after;
        canLoad = true;
    }

    function fail(data) {
        console.log("fail");
    }

    function changePath(path) {
        var i = path.lastIndexOf("/");
        return path.substring(0, i + 1) + "thumbnailImage/" + path.substring(i + 1);
    }

    $(document).scroll(function () {
        if (load.offset().top - $(window).scrollTop() < wiwH) {
            load.css("visibility", "visible");
            if (canLoad && !noDate) {
                load.css("visibility", "visible");
                canLoad = false;
                loadProduct();
            }
            if (noDate) {
                load.find(".blocktitle").html("<a href='" + $("#path").val() + "/product/productList'>点击查看更多产品</a>");
                load.css("visibility", "visible");
            }
        }
    });

    //切换产品
    var productId;

    function changeProduct(productId) {
        var url = "<%=request.getContextPath()%>/product/getProductAjax";
        var params = {productId: productId};
        doAjax("GET", url, params, changeSuccess, fail, true, false);
    }

    var percent = "${percent}";

    function changeSuccess(data) {
        var product = data.data;
        if (percent != "") {
            product.product.unitPrice = (product.product.unitPrice + Math.ceil(product.product.unitPrice * parseFloat(percent))).toFixed(2);
        }

        addToCart.title = product.product.productName;
        addToCart.model = product.product.productCode;
        addToCart.price = product.product.retailPrice;
        addToCart.saleNumber = product.product.productSales;
        addToCart.picture = changePath(product.product.cover1);

        addToCart.selections[0].option = [];
        for (var i = 0; i < product.seriesProductList.length; i++) {
            addToCart.selections[0].option.push(
                {
                    id: product.seriesProductList[i].productId, name: product.seriesProductList[i].productName,
                    option_selected: product.seriesProductList[i].productId == product.product.productId
                });
        }
        var waiting_div = document.getElementById('addtocart_waiting');
        var addToCart_div = document.getElementById('addtocart');
        addToCart_div.hidden = false;
        waiting_div.hidden = true;

        productId = product.product.productId;

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
        alert("添加成功！");
        closeCart();
    }
</script>

<%--左侧边栏--%>
<div class="leftbar_bg" onclick="showLeftBar()" hidden></div>
<div class="leftbar" onclick="event.stopPropagation()" hidden>
    <div class="leftbar_recommend">
        <div>
            <div class="leftbar_recommend_left">新</div>
            新品推荐
        </div>
        <div>
            <div class="leftbar_recommend_left">热</div>
            热卖推荐
        </div>
        <div>
            <div class="leftbar_recommend_left">工</div>
            工程款推荐
        </div>
        <div>
            <div class="leftbar_recommend_left">套</div>
            套餐搭配
        </div>
    </div>
    <div class="leftbar_block">
        <div class="leftbar_block_title leftbar_selected" onclick="selectLeftBarAll(this)">
            全部类型
        </div>
        <div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/0-0.png">
                </div>
                <div class="leftbar_block_itemtitle">吊灯</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/0-1.png">
                </div>
                <div class="leftbar_block_itemtitle">吸顶灯</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/0-2.png">
                </div>
                <div class="leftbar_block_itemtitle">台灯</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/0-3.png">
                </div>
                <div class="leftbar_block_itemtitle">落地灯</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/0-4.png">
                </div>
                <div class="leftbar_block_itemtitle">壁灯</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/0-5.png">
                </div>
                <div class="leftbar_block_itemtitle">镜前灯</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/0-6.png">
                </div>
                <div class="leftbar_block_itemtitle">户外灯</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/0-7.png">
                </div>
                <div class="leftbar_block_itemtitle">过道灯</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/0-8.png">
                </div>
                <div class="leftbar_block_itemtitle">蜡烛灯</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/0-9.png">
                </div>
                <div class="leftbar_block_itemtitle">辅灯</div>
            </div>
        </div>
    </div>
    <div class="leftbar_block">
        <div class="leftbar_block_title leftbar_selected" onclick="selectLeftBarAll(this)">全部空间</div>
        <div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/1-0.png">
                </div>
                <div class="leftbar_block_itemtitle">卧室</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/1-1.png">
                </div>
                <div class="leftbar_block_itemtitle">客厅</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/1-2.png">
                </div>
                <div class="leftbar_block_itemtitle">餐厅</div>

            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/1-3.png">
                </div>
                <div class="leftbar_block_itemtitle">厨房</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/1-4.png">
                </div>
                <div class="leftbar_block_itemtitle">儿童房</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/1-5.png">
                </div>
                <div class="leftbar_block_itemtitle">楼梯/拐角</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/1-6.png">
                </div>
                <div class="leftbar_block_itemtitle">玄关/过道</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/1-7.png">
                </div>
                <div class="leftbar_block_itemtitle">户外</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/1-8.png">
                </div>
                <div class="leftbar_block_itemtitle">高层</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/1-9.png">
                </div>
                <div class="leftbar_block_itemtitle">低户型</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/1-10.png">
                </div>
                <div class="leftbar_block_itemtitle">视听室</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/1-11.png">
                </div>
                <div class="leftbar_block_itemtitle">衣帽间</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/1-12.png">
                </div>
                <div class="leftbar_block_itemtitle">阳台</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/1-13.png">
                </div>
                <div class="leftbar_block_itemtitle">卫浴间</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/1-14.png">
                </div>
                <div class="leftbar_block_itemtitle">书房</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/1-15.png">
                </div>
                <div class="leftbar_block_itemtitle">棋牌室</div>
            </div>
        </div>
    </div>
    <div class="leftbar_block">
        <div class="leftbar_block_title leftbar_selected" onclick="selectLeftBarAll(this)">全部风格</div>
        <div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/2-0.png">
                </div>
                <div class="leftbar_block_itemtitle">简约欧式</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/2-1.png">
                </div>
                <div class="leftbar_block_itemtitle">古典欧式</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/2-2.png">
                </div>
                <div class="leftbar_block_itemtitle">新概念</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/2-3.png">
                </div>
                <div class="leftbar_block_itemtitle">现代简约</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/2-4.png">
                </div>
                <div class="leftbar_block_itemtitle">美式田园</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/2-5.png">
                </div>
                <div class="leftbar_block_itemtitle">日式</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/2-6.png">
                </div>
                <div class="leftbar_block_itemtitle">简约美式</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/2-7.png">
                </div>
                <div class="leftbar_block_itemtitle">后奢华</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/2-8.png">
                </div>
                <div class="leftbar_block_itemtitle">古典美式</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/2-9.png">
                </div>
                <div class="leftbar_block_itemtitle">工业风</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/2-10.png">
                </div>
                <div class="leftbar_block_itemtitle">法式田园</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/2-11.png">
                </div>
                <div class="leftbar_block_itemtitle">法式宫廷</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/2-12.png">
                </div>
                <div class="leftbar_block_itemtitle">儿童护眼</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/2-13.png">
                </div>
                <div class="leftbar_block_itemtitle">东南亚</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/2-14.png">
                </div>
                <div class="leftbar_block_itemtitle">蒂凡尼</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/2-15.png">
                </div>
                <div class="leftbar_block_itemtitle">地中海</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/2-16.png">
                </div>
                <div class="leftbar_block_itemtitle">北欧简约</div>
            </div>
        </div>
    </div>
    <div class="leftbar_block">
        <div class="leftbar_block_title leftbar_selected" onclick="selectLeftBarAll(this)">全部材质</div>
        <div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/3-0.png">
                </div>
                <div class="leftbar_block_itemtitle">铜艺</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/3-1.png">
                </div>
                <div class="leftbar_block_itemtitle">铁艺</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/3-2.png">
                </div>
                <div class="leftbar_block_itemtitle">锌合金</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/3-3.png">
                </div>
                <div class="leftbar_block_itemtitle">玉石</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/3-4.png">
                </div>
                <div class="leftbar_block_itemtitle">仿羊皮</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/3-5.png">
                </div>
                <div class="leftbar_block_itemtitle">亚克力</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/3-6.png">
                </div>
                <div class="leftbar_block_itemtitle">云石</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/3-7.png">
                </div>
                <div class="leftbar_block_itemtitle">竹</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/3-8.png">
                </div>
                <div class="leftbar_block_itemtitle">陶瓷</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/3-9.png">
                </div>
                <div class="leftbar_block_itemtitle">塑料</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/3-10.png">
                </div>
                <div class="leftbar_block_itemtitle">水泥</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/3-11.png">
                </div>
                <div class="leftbar_block_itemtitle">水晶</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/3-12.png">
                </div>
                <div class="leftbar_block_itemtitle">树脂</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/3-13.png">
                </div>
                <div class="leftbar_block_itemtitle">木艺</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/3-14.png">
                </div>
                <div class="leftbar_block_itemtitle">铝材</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/3-15.png">
                </div>
                <div class="leftbar_block_itemtitle">仿玉石</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/3-16.png">
                </div>
                <div class="leftbar_block_itemtitle">布艺</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/3-17.png">
                </div>
                <div class="leftbar_block_itemtitle">不锈钢</div>
            </div>
            <div class="leftbar_block_item" onclick="selectLeftBar(this)">
                <div class="leftbar_block_item_imgblock">
                    <img class="leftbar_block_item_img"
                         src="<%=request.getContextPath()%>/resources/customer/assets/images/left_bar/3-18.png">
                </div>
                <div class="leftbar_block_itemtitle">玻璃</div>
            </div>
        </div>
    </div>
    <div class="leftbar_block">
        <div class="leftbar_block_title leftbar_selected" id="allprice"
             style="width: 97%; margin: 1rem 1% 0.2rem 1%; border: 1px solid white;" onclick="selectLeftBarAll(this)">
            全部价格
        </div>
        <div>
            <div class="leftbar_price_div" onclick="selectLeftBar(this)">500元以下</div>
            <div class="leftbar_price_div" onclick="selectLeftBar(this)">500-1000元</div>
            <div class="leftbar_price_div" onclick="selectLeftBar(this)">1000-2000元</div>
            <div class="leftbar_price_div" onclick="selectLeftBar(this)">2000-4000元</div>
            <div class="leftbar_price_div" onclick="selectLeftBar(this)">4000-6000元</div>
            <div class="leftbar_price_div" onclick="selectLeftBar(this)">6000-8000元</div>
            <div class="leftbar_price_div" onclick="selectLeftBar(this)">8000-10000元</div>
            <div class="leftbar_price_div" onclick="selectLeftBar(this)">10000元以上</div>
            <div class="leftbar_price_div" style="width: 97%; margin-top: 1rem;">自定义价格</div>
            <input type="number" class="leftbar_price_div" id="lowprice" onchange="priceOnChange()" placeholder="最低价(元)">
            <input type="number" class="leftbar_price_div" id="highprice" onchange="priceOnChange()" placeholder="最高价(元)">
            <div class="leftbar_price_div" style="width: 27%; color: #5f6678;" onclick="clearAllLeftBar()">重置</div>
            <div class="leftbar_price_div" style="width: 67%; background-color: #8c9093;">确定</div>
        </div>
        <br>
    </div>
    <br>

</div>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/common/zepto.min.js"></script>
<script type="text/javascript">

    var fontSize = window.getComputedStyle(document.documentElement)["fontSize"];
    var winHeight, winWidth;
    if (window.innerHeight)
        winHeight = window.innerHeight;
    else if ((document.body) && (document.body.clientHeight))
        winHeight = document.body.clientHeight;
    if (window.innerWidth)
        winWidth = window.innerWidth;
    else if ((document.body) && (document.body.clientWidth))
        winWidth = document.body.clientWidth;
    var leftBarInner = document.getElementsByClassName("leftbar")[0];
    //leftBarInner.style.height = winHeight + "px";
    var leftBar = document.getElementsByClassName("leftbar_bg")[0];
    var topBar = document.getElementById("topbar");
    var lightBlock = document.getElementsByClassName("lightblock")[0];
    var swiperBlock = document.getElementById("swiperbox");
    var allBlock = document.getElementsByClassName("block");
    var allPrice = document.getElementById("allprice");
    var lowPrice = document.getElementById("lowprice");
    var highPrice = document.getElementById("highprice");
    topBar.style.width = winWidth + "px";
    lightBlock.style.width = winWidth + "px";
    swiperBlock.style.width = winWidth + "px";
    for (var i = 0; i < allBlock.length; i++) {
        allBlock[i].style.width = winWidth - 0.4 * parseInt(fontSize) + "px";
    }

    function showLeftBar() {
        if (leftBar.hidden) {
            leftBarInner.hidden = false;
            leftBarInner.scrollTop = 0;
            body.style.overflow = "hidden";
            body.style.position = "fixed";
            leftBarInner.style.animation = "showLeftBar 0.5s";
            var timeout = setTimeout(function () {
                leftBar.hidden = false;
            }, 500);
        } else {
            leftBar.hidden = true;
            leftBarInner.style.animation = "hideLeftBar 0.5s";
            var timeout = setTimeout(function () {
                leftBarInner.hidden = true;
                body.style.overflow = "auto";
                body.style.position = "";
                clearTimeout(timeout);
            }, 500);
        }
    }

    function isAllInative(object) {
        var allOptionInThisBlock = object.parentNode.childNodes;
        for (var i = 0; i < allOptionInThisBlock.length; i++) {
            if (allOptionInThisBlock[i].nodeType == 1) {
                if (allOptionInThisBlock[i].className.indexOf("leftbar_selected") >= 0) {
                    return false;
                }
            }
        }
        return true;
    }


    function selectLeftBar(object) {
        if (object.className.indexOf("leftbar_price_div") >= 0) {
            if (object.className == "leftbar_price_div") {
                object.className = "leftbar_price_div leftbar_selected";
                object.parentNode.previousSibling.previousSibling.className = "leftbar_block_title";
            } else {
                object.className = "leftbar_price_div";
                if (isAllInative(object)) {
                    object.parentNode.previousSibling.previousSibling.className += " leftbar_selected";
                }
            }
        } else if (object.className.indexOf("leftbar_block_item") >= 0) {
            if (object.className == "leftbar_block_item") {
                object.className = "leftbar_block_item leftbar_selected";
                object.parentNode.previousSibling.previousSibling.className = "leftbar_block_title";
            } else {
                object.className = "leftbar_block_item";
                if (isAllInative(object)) {
                    object.parentNode.previousSibling.previousSibling.className += " leftbar_selected";
                }
            }
        }
    }

    function selectLeftBarAll(object) {
        if (object.className.indexOf("leftbar_selected") < 0) {
            console.log(object.innerHTML);
            if (object.innerHTML.indexOf("全部价格") >=0 ) { //如果是价格块
                object.className = "leftbar_block_title leftbar_selected";
                var allOptionInThisBlock = object.nextSibling.nextSibling.childNodes;
                for (var i = 0; i < allOptionInThisBlock.length; i++) {
                    if (allOptionInThisBlock[i].nodeType == 1) {
                        allOptionInThisBlock[i].className = "leftbar_price_div";
                    }
                }
            } else {
                object.className = "leftbar_block_title leftbar_selected";
                var allOptionInThisBlock = object.nextSibling.nextSibling.childNodes;
                for (var i = 0; i < allOptionInThisBlock.length; i++) {
                    if (allOptionInThisBlock[i].nodeType == 1) {
                        allOptionInThisBlock[i].className = "leftbar_block_item";
                    }
                }
            }
        }
    }

    function priceOnChange() {
        allPrice.click();
    }
    
    function clearAllLeftBar() {
        if (confirm("确定要消除所有选项吗？")) {
            var allTitle = document.getElementsByClassName("leftbar_block_title");
            for (var i = 0; i < allTitle.length; i++) {
                allTitle[i].click();
            }
            leftBarInner.scrollTop = 0;
            lowPrice.value = "";
            highPrice.value = "";
        }
    }

</script>

<%--左侧边栏--%>


</body>


</html>