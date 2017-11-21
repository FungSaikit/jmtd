<%@ page language="java" import="java.util.*,com.alphaking.constant.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib prefix="thumbnail" uri="/WEB-INF/tld/thumbnailTag.tld"%>
<%@ taglib prefix="ppt" uri="/WEB-INF/tld/productPriceTag.tld"%>

<!DOCTYPE html>
<html lang="zh">
<head>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <meta charset="UTF-8">
    <title>金明同达灯饰</title>

    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/customer/assets/css/topbar.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/customer/assets/css/cart.css">

</head>

<body>
<c:set var="SALES_SORT" value="<%=ProductSortType.SALES_SORT%>" />
<c:set var="NEW_SORT" value="<%=ProductSortType.NEW_SORT%>" />
<c:set var="PRICE_SORT" value="<%=ProductSortType.PRICE_SORT%>" />
<c:set var="CUSTOMER" value="<%=UserType.CUSTOMER%>" />
<c:set var="RETAIL_SALES" value="<%=UserType.RETAIL_SALES%>" /> 
<c:set var="AUTHENTICATION_SUCCESS" value="<%=UserCheckStatus.AUTHENTICATION_SUCCESS%>" />
<div class="topbar">
    <span class="topbar_left">&nbsp&nbsp&nbsp&nbsp</span>
    <span class="topbar_middle">购物车</span>
    <a href="#" onclick="editMode()" id="changeMode"><span class="topbar_right">编辑</span></a>
</div>

<div class="placeholder">
    什么都没有了哦
</div>

<div class="cart_list">
	<c:forEach items="${shopcartList}" var="shopcart">
	<c:forEach items="${shopcart.shopcartItemList}" var="shopcartItem">
    <div class="goods" data-id="${shopcartItem.shopcartItem.itemId}" id="${shopcartItem.shopcartItem.itemId}">
        <div class="goods_top">
            <table>
                <tr>
                    <td>
                        <div class="goods_cb">
                            <input class="check_goods" type="checkbox" checked onchange="count()">
                        </div>
                    </td>
                    <td>
                        <div class="goods_pic">
                            <img class="goods_pic_img" src="<thumbnail:date value="${shopcartItem.product.cover1}"/>" alt="图片">
                        </div>
                    </td>
                    <td>
                        <table class="goods_dt">
                            <tr>
                                <td class="goods_tt">${shopcartItem.product.productName}</td>
                            </tr>
                            <tr>
                                <td class="goods_md">型号：${shopcartItem.product.productCode}</td>
                            </tr>
                            <tr>
                                <td class="goods_prz">￥<span class="price" id="price_0"><ppt:date percent="${percent}" role="${(user.role==CUSTOMER||user.role==RETAIL_SALES||user.checkStatus!=AUTHENTICATION_SUCCESS)}" 
    					productPrice="${(user.role==CUSTOMER||user.role==RETAIL_SALES||user.checkStatus!=AUTHENTICATION_SUCCESS)?shopcartItem.product.retailPrice:(shopcartItem.product.unitPrice+shopcartItem.product.woodenFee)}" productNumber="1" productOriginPrice="${shopcartItem.product.unitPrice}"></ppt:date></span></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <div class="goods_bottom">
            <div class="number_div">
                <table class="number_table">
                    <tr>
                        <td class="minus_td"><a href="javascript:void(0)" onclick="minusOne(this)">&nbsp-&nbsp</a></td>
                        <td class="number_td"><input class="number" type="number" value="${shopcartItem.shopcartItem.productNumber}" onchange="checkInput(this)">
                        </td>
                        <td class="plus_td"><a href="javascript:void(0)" onclick="plusOne(this)">&nbsp+&nbsp</a></td>
                    </tr>
                </table>
            </div>
           <!--  <div class="color_div">
                <select class="color_option" id="color_0" onchange="changeColor(this)">
                    <option value="0" price="10">10元 4头48瓦 LED吸顶</option>
                    <option value="1" price="12">12元 4头48瓦 LED吸顶</option>
                    <option value="2" price="15" selected>15元 4头48瓦 LED吸顶</option>
                </select>
            </div> -->
        </div>
    </div>
    </c:forEach>
    </c:forEach>
</div>

<div class="placeholder"></div>

<div id="pay_menu" class="cart_menu">
    <div class="menu_sub_div select_all_div">
        <input class="select_all_checkbox" onchange="selectAllGoods(self)" checked  type="checkbox">
        <span class="select_all_span" onclick="selectAllGoods_1()">全选</span>
    </div>
    <div id="total_div" class="menu_sub_div">
        <span>合计：￥ <span id="total_price"></span></span>
    </div>
    <div id="pay_div" class="menu_sub_div">
        <a id="pay_button" href="javascript:void(0)" onclick="pay()">结算</a>
    </div>
</div>

<div class="cart_menu" id="edit_menu" hidden>
    <div class="menu_sub_div select_all_div">
        <input class="select_all_checkbox" onchange="deleteAllGoods(self)" type="checkbox">
        <span class="select_all_span" onclick="deleteAllGoods_1()">全选</span>
    </div>
    <div>
        <a id="delete_button" class="delete_button" href="javascript:void(0)" onclick="deleteRequest()">删除</a>
    </div>
</div>


<div class="emptycart" hidden>
    <img src="<%=request.getContextPath() %>/resources/customer/assets/images/cart/empty_cart.png" alt="empty_cart">
    <div>购物车空空如也</div>
    <button onclick="window.location.href = '<%=request.getContextPath()%>/buyer/index'">去逛逛吧</button>
</div>

<div class="pay_wait" hidden>
    <div class="center">
        <img src="<%=request.getContextPath() %>/resources/customer/assets/images/cart/wait.gif" alt="请等待">
        <span>正在结算，请稍等</span>
    </div>
</div>
<jsp:include page="/jsp/buyer/footer.jsp"></jsp:include>
<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>

</body>

<script type="text/javascript">

    var deleteArray;
    var goodsCheckbox = document.getElementsByClassName('check_goods');
    var selectAllButton = document.getElementsByClassName("select_all_checkbox")[0];
    var deleteAllButton = document.getElementsByClassName("select_all_checkbox")[1];
    var changeModeButton = document.getElementById("changeMode");
    var payMenu = document.getElementById("pay_menu");
    var editMenu = document.getElementById("edit_menu");

    window.onload = function () {
        getPrice();
        count();
    }


    function selectAllGoods() {
        for (var i = 0; i < goodsCheckbox.length; i++) {
            goodsCheckbox[i].checked = selectAllButton.checked;
        }
        count();
    }

    function selectAllGoods_1() {
        selectAllButton.checked = !selectAllButton.checked;
        for (var i = 0; i < goodsCheckbox.length; i++) {
            goodsCheckbox[i].checked = selectAllButton.checked;
        }
        count();
    }

    function deleteAllGoods() {
        for (var i = 0; i < goodsCheckbox.length; i++) {
            goodsCheckbox[i].checked = deleteAllButton.checked;
        }
    }

    function deleteAllGoods_1() {
        deleteAllButton.checked = !deleteAllButton.checked;
        for (var i = 0; i < goodsCheckbox.length; i++) {
            goodsCheckbox[i].checked = deleteAllButton.checked;
        }
    }

    function editMode() {
        payMenu.hidden = true;
        editMenu.hidden = false;
        changeModeButton.innerHTML = "<span class=\"topbar_right\">完成</span>";
        changeModeButton.onclick = payMode;
    }

    function payMode() {
        payMenu.hidden = false;
        editMenu.hidden = true;
        changeModeButton.innerHTML = "<span class=\"topbar_right\">编辑</span>";
        changeModeButton.onclick = editMode;
    }

    function count() {
        var number = document.getElementsByClassName('number');
        var price = document.getElementsByClassName('price');
        var total = document.getElementById('total_price');
        var result = 0;
        for (var i = 0; i < price.length; i++) {
            if (goodsCheckbox[i].checked) {
                result += parseInt(number[i].value) * parseFloat(price[i].innerText);
            }

        }
        total.innerHTML = result;
        isEmpty();//每次修改需要重新计数时，判断购物车是否为空
    }

    function getPrice() {
        var colorSelectArray = document.getElementsByClassName("color_option");
        var priceArray = document.getElementsByClassName("price")
        for (var i = 0; i < colorSelectArray.length; i++) {
            priceArray[i].innerHTML = colorSelectArray[i].childNodes[2 * colorSelectArray[i].value + 1].getAttribute("price");
        }
    }
    
    function isEmpty() {
        if (goodsCheckbox.length) {//如果购物车里面没有货物，则显示
            document.getElementsByClassName("emptycart")[0].hidden = true;
        } else {
            document.getElementsByClassName("emptycart")[0].hidden = false;
        }
    }

    function plusOne(object) {
        var number = object.parentNode.previousSibling.previousSibling.childNodes[0].value;
        if (parseInt(number)) {
            object.parentNode.previousSibling.previousSibling.childNodes[0].value = parseInt(number) + 1;
            changeShopcartNum($(object).parents(".goods").attr("data-id"),parseInt(number) + 1);
        } else {
            object.parentNode.previousSibling.previousSibling.childNodes[0].value = 1;
            changeShopcartNum($(object).parents(".goods").attr("data-id"),1);
        }
        count();
    }

    function minusOne(object) {
        var number = object.parentNode.nextSibling.nextSibling.childNodes[0].value;
        if (parseInt(number)) {
            if (number > 1) {
                object.parentNode.nextSibling.nextSibling.childNodes[0].value = parseInt(number) - 1;
                changeShopcartNum($(object).parents(".goods").attr("data-id"),parseInt(number) - 1);
            } else {
                alert("不能再小了");
            }
        } else {
            object.parentNode.nextSibling.nextSibling.childNodes[0].value = 1;
            changeShopcartNum($(object).parents(".goods").attr("data-id"),1);
        }
        count();
    }

    function checkInput(object) {
        console.log(parseInt(object.value))
        if (isNaN(object.value)) {
            alert("出入有误请重新输入");
            object.focus();
        } else {
        	if(object.value<1){
        		object.value=1;
        	}
            object.value = parseInt(object.value);
            changeShopcartNum($(object).parents(".goods").attr("data-id"),object.value);
        }
        count();
    }

    function changeColor(object) {
        document.getElementById("price_" + object.id.substr(6)).innerHTML = object.childNodes[2 * object.value + 1].getAttribute("price");
        count();
    }

    function deleteRequest() {
        deleteArray = [];
        for (var i = 0; i < goodsCheckbox.length; i++) {
            if (goodsCheckbox[i].checked) {
                deleteArray.push(goodsCheckbox[i].parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.getAttribute("data-id"));
            }
        }
        if (confirm("是否删除这" + deleteArray.length + "项?")) {
            //deleteGoods();
        	deleteShopcartList(deleteArray);
        }
    }

    function deleteGoods() {
        for (var i = 0; i < deleteArray.length; i++) {
            var thisNode = document.getElementById(deleteArray[i]);
            thisNode.parentNode.removeChild(thisNode);
        }
        count();
        payMode();
    }

    function pay() {
        var checkIsEmpty = true;
        for (var i = 0; i < goodsCheckbox.length; i++) {
            if (goodsCheckbox[i].checked) {
                checkIsEmpty = false;
            }
        }
        if (checkIsEmpty) {
            alert("您还没有选好需要购买的商品哦！");
        } else {
        	 var sArray = [];
             for (var i = 0; i < goodsCheckbox.length; i++) {
                 if (goodsCheckbox[i].checked) {
                	 sArray.push(goodsCheckbox[i].parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.getAttribute("data-id"));
                 }
             }
            showLoading();
            window.location.href='<%=request.getContextPath()%>/buyer/toSettleAccount?shopcartIdList='+sArray.toString();
            /* body.style.overflow = "hidden";
            body.style.height = "100%";
            payWait.hidden = false; */
        }
        
    }
    
    //改变购物车数量
    function changeShopcartNum(itemId,number){
		var url="<%=request.getContextPath()%>/shopcart/changeShopcartNumber";
		var params={itemId:itemId,num:number};
		doAjax("GET",url,params,changeSuccess,function(data){
			console.log("fail");
		},false,false);
    }
    
    function changeSuccess(data){
    	console.log("changeShopcartSuccess");
    }
    
    function deleteShopcartList(itemIds){  //删除选中的购物车
    	
		/* 
		itemIds = itemIds.substring(0,itemIds.length-1); */
		var url="<%=request.getContextPath()%>/shopcart/deleteShopcarts";
		var params={itemIds:itemIds.toString()};
		doAjax("GET",url,params,deleteListSuccess,function(data){
			console.log("deleteFail");
		},true,false);
	}
	
	function deleteListSuccess(data){
		var itemArray = data.data.split(",");
		for(var i=0;i<itemArray.length;i++){
			if($(".commodity[data-id='"+itemArray[i]+"']").parent().find(".commodity").length==1){
				$(".commodity[data-id='"+itemArray[i]+"']").parent().remove();
				if($(".oneShop").length==0){
					//购物车已被清空，页面跳转至购物车为空的页面
					$(".chooseAll").removeClass("active");
					location.reload();
				}
			}else{
				$(".commodity[data-id='"+itemArray[i]+"']").remove();
			}
		}
		deleteGoods();
	}
	
</script>

</html>