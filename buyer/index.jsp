<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="thumbnail" uri="/WEB-INF/tld/thumbnailTag.tld"%>

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

<div :class="topbar_class" id="topbar">
    <img :src="left_pic_directory" class="topbarbutton" onclick="window.location.href='<%=request.getContextPath()%>/product/productList?showFilter=1'">
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
            left_pic_directory: "<%=request.getContextPath()%>/resources/customer/assets/images/search_bar/class_white.png",
            right_pic_directory: "<%=request.getContextPath()%>/resources/customer/assets/images/search_bar/cs_white.png",
            search_directory: "<%=request.getContextPath()%>/resources/customer/assets/images/search_bar/search_black.png",
            keyword: ""
        },
        methods: {
            search: function () {
            	window.location.href="<%=request.getContextPath()%>/product/productList?keyword="+this.keyword;
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
    swiper.style.height = deviceWidth * 5 / 9 + 'px';
    document.getElementsByClassName('swiper-wrapper')[0].style.lineHeight = deviceWidth * 5 / 9 + 'px';

    var swiper = new Swiper('.swiper-container', {
        loop: true,
        pagination: '.swiper-pagination',
        autoplay: 3000,
        loop: true,
        autoplayDisableOnInteraction: false
    });

</script>

<div class="hotline">
    <table style="border-collapse: collapse;height: 2rem;">
        <tr>
            <td><span class="hotlinetitle">灯饰头条</span></td>
            <td><a href="#" class="hotlinecomment">热烈祝贺中共十九大召开热烈祝贺中共十九大召开热烈祝贺中共十九大召开热烈祝贺中共十九大召开热烈祝贺中共十九大召开</a>
            </td>
        </tr>
    </table>
</div>
<script type="text/javascript">

    document.getElementsByClassName('hotlinecomment')[0].style.width = deviceWidth - document.getElementsByClassName("hotlinetitle")[0].parentNode.clientWidth + 'px';

</script>

<div class="lightblock">
    <table>
        <tr>
            <td>
                <a href="<%=request.getContextPath()%>/product/productList?type=180">
                    <div class="lightblockimg">
                        <img src="<%=request.getContextPath()%>/resources/customer/assets/images/light/0-pendant.png">
                    </div>
                    <div class="lightblockspan">
                        <span>吊灯</span>
                    </div>
                </a>
            </td>
            <td>
                <a href="<%=request.getContextPath()%>/product/productList?type=185">
                    <div class="lightblockimg"><img src="<%=request.getContextPath()%>/resources/customer/assets/images/light/0-ceiling.png"></div>
                    <div class="lightblockspan"><span>吸顶灯</span></div>
                </a>
            </td>
            <td>
                <a href="<%=request.getContextPath()%>/product/productList?type=181">
                    <div class="lightblockimg"><img src="<%=request.getContextPath()%>/resources/customer/assets/images/light/0-wall.png"></div>
                    <div class="lightblockspan"><span>壁灯</span></div>
                </a>
            </td>
            <td>
                <a href="#">
                    <div class="lightblockimg">
                        <img src="<%=request.getContextPath()%>/resources/customer/assets/images/light/0-tablelamp.png">
                    </div>
                    <div class="lightblockspan">
                        <span>台灯</span>
                    </div>
                </a>
            </td>
            <td>
                <a href="<%=request.getContextPath()%>/product/productList?type=659">
                    <div class="lightblockimg">
                        <img src="<%=request.getContextPath()%>/resources/customer/assets/images/light/0-auxiliary.png">
                    </div>
                    <div class="lightblockspan">
                        <span>辅灯</span>
                    </div>
                </a>
            </td>
        </tr>
        <tr>
            <td>
                <a href="<%=request.getContextPath()%>/product/productList?material=190">
                    <div class="lightblockimg">
                        <img src="<%=request.getContextPath()%>/resources/customer/assets/images/light/1-cupric.png">
                    </div>
                    <div class="lightblockspan">
                        <span>铜灯</span>
                    </div>
                </a>
            </td>
            <td>
                <a href="<%=request.getContextPath()%>/product/productList?material=206">
                    <div class="lightblockimg">
                        <img src="<%=request.getContextPath()%>/resources/customer/assets/images/light/1-ferric.png">
                    </div>
                    <div class="lightblockspan">
                        <span>铁艺</span>
                    </div>
                </a>
            </td>
            <td>
                <a href="<%=request.getContextPath()%>/product/productList?material=203">
                    <div class="lightblockimg">
                        <img src="<%=request.getContextPath()%>/resources/customer/assets/images/light/1-wooden.png">
                    </div>
                    <div class="lightblockspan">
                        <span>木艺</span>
                    </div>
                </a>
            </td>
            <td>
                <a href="<%=request.getContextPath()%>/product/productList?material=193">
                    <div class="lightblockimg">
                        <img src="<%=request.getContextPath()%>/resources/customer/assets/images/light/1-zincic.png">
                    </div>
                    <div class="lightblockspan">
                        <span>锌合金</span>
                    </div>
                </a>
            </td>
            <td>
                <a href="<%=request.getContextPath()%>/product/productList">
                    <div class="lightblockimg">
                        <img style="max-width: 50%; max-height: 50%;" src="<%=request.getContextPath()%>/resources/customer/assets/images/light/1-more.png">
                    </div>
                    <div class="lightblockspan">
                        <span>更多</span>
                    </div>
                </a>
            </td>
        </tr>
    </table>
</div>

<script type="text/javascript">

    var imgBox = document.getElementsByClassName('lightblockimg');
    for (var i = 0; i < imgBox.length; i++) {
        imgBox[i].style.height = imgBox[i].offsetWidth + "px";
        imgBox[i].style.lineHeight = imgBox[i].offsetWidth + "px";
    }

</script>

<div class="block">
    <div class="blocktitle">———— 热销排行榜 ————</div>
    <div style="width: 100%;white-space: nowrap; overflow-x: auto; overflow-y: hidden;">
    	<c:forEach items="${hotProductList}" var="product">
	        <div class="goods" gid="${product.productId }" onclick="goodsDetails(this.getAttribute('gid'))">
	            <div class="hotsalepicture"><img class='hotsale_img' src='<thumbnail:date value="${product.cover1 }"/>'></div>
	            <div class='hotsaletitle'>${product.productName }</div>
	            <div class='hotsaledetail'>${product.productCode }</div>
	            <div class='hotsaleprice'>
	                ¥${product.retailPrice }
	                <img src="<%=request.getContextPath()%>/resources/customer/assets/images/recommend/cart.png" class="addtocart_img"
	                     onclick="addGoodsToCart(this.parentNode.parentNode.getAttribute('gid'), this)">
	            </div>
	        </div>
        </c:forEach>
        <div id="morehotsale">
            <div onclick="window.location.href='<%=request.getContextPath()%>/product/productList?orderBy=0'">
                <img style="width: 2rem; height: 2rem; vertical-align: middle;" src="<%=request.getContextPath()%>/resources/customer/assets/images/hot_sale/hotsale.png">
                <span style="vertical-align: middle;">发现更多</span>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">

    var pic = document.getElementsByClassName('hotsalepicture');
    var moreHotSale = document.getElementById('morehotsale');

    for (var i = 0; i < pic.length; i++) {
        pic[i].style.height = pic[i].clientWidth + 'px';
        pic[i].style.lineHeight = pic[i].clientWidth + 'px';
    }
    moreHotSale.style.height = document.getElementsByClassName('goods')[0].offsetHeight + 'px';
    moreHotSale.style.lineHeight = document.getElementsByClassName('goods')[0].offsetHeight + 'px';

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

<div class="block">
    <div class="blocktitle">
        ———— 精挑细选 ————
        <div>
        	<c:forEach items="${spreadProductList }" var="product">
            <div class="narrowbox">
                <img onclick="goodsDetails(${product.productId})" class="full_img" src="${product.cover1 }">
            </div>
            </c:forEach>
        </div>
    </div>
</div>
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
        ———— 你可能喜欢 ————
    </div>

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
<div class="block loading" id="loading">
    <div class="blocktitle">
        正在加载更多……
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
        <img src="<%=request.getContextPath()%>/resources/customer/assets/images/cart/close.png" alt="关闭" class="closecart" onclick="closeCart()">
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
        <img src="<%=request.getContextPath()%>/resources/customer/assets/images/cart/close.png" alt="关闭" class="closecart" onclick="closeCart()">
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
            picture:'',
            selections: [
                {
                    title: '规格',
                    option: [
                        
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

    function confirmToAdd() {
    	addShopcart();
    }
    

    var canLoad=true;
	var noDate=false;var offset=0;
	var wiwH=$(window).height();
	var load=$(".loading");
	loadProduct();
    /*加载产品*/
	function loadProduct(){
		var url="";
		var params;
	
		if(sessionStorage.getItem("pageNo")>0){
			url="<%=request.getContextPath()%>/buyer/indexProductBatch";
			params={offset:sessionStorage.getItem("pageNo")};
			sessionStorage.removeItem("pageNo");
			doAjax("GET",url,params,function(data){loadProductSuccess(data);
				document.body.scrollTop=sessionStorage.getItem("scrollTop");
			},fail,true,false);
		}else{
			url="<%=request.getContextPath()%>/buyer/indexProduct";
			params={offset:offset};
			doAjax("GET",url,params,loadProductSuccess,fail,true,false);
			sessionStorage.removeItem("scrollTop");
		}
	}
	
	function loadProductBatch(pageNo){
		var url = $("#path").val()+"/buyer/indexProductBatch";
		var params={offset:pageNo,style:styleId}
		doAjax("GET",url,params,function(data){loadProductSuccess(data);
			},fail,true,false);
	}
	
	var percent=$("#percent").val();
	function loadProductSuccess(data){
		var productList = data.list;
		var html="";
		var i;
		for(i=0;i<productList.length;i++){
			mayLike.items.push({
                id: productList[i].productId,
                picDir: changePath(productList[i].cover1),
                title: productList[i].productName,
                details: productList[i].productCode,
                price: productList[i].retailPrice
            });
		}
		
		if((parseInt(offset)+10)>=data.count){
			noDate=true;
		}
		if(i>9&&i>=data.count){
			noDate=true;
		}
		offset=data.after;
		canLoad=true;
	}
	
	function fail(data){
		console.log("fail");
	}
	
	function changePath(path){
		var i=path.lastIndexOf("/");
		return path.substring(0,i+1)+"thumbnailImage/"+path.substring(i+1);
	}
	
	 $(document).scroll(function(){
		 if(load.offset().top - $(window).scrollTop()<wiwH){
			load.css("visibility","visible");
			if(canLoad&&!noDate){
				load.css("visibility","visible");
				canLoad=false;
				loadProduct();
			}
			if(noDate){
				load.find(".blocktitle").html("<a href='"+$("#path").val()+"/product/productList'>点击查看更多产品</a>");
				load.css("visibility","visible");
			}
		}
     });
	 
	//切换产品
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