<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="deadLine" uri="/WEB-INF/tld/deadLineTag.tld"%>

<!DOCTYPE html>
<html lang="zh">
<meta name="viewport"
      content="width=device-width,height=device-height, user-scalable=no,initial-scale=1, minimum-scale=1, maximum-scale=1">
<head>
    <meta charset="UTF-8">
    <title>佐为照明</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/customer/assets/css/fung.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/customer/assets/js/vue.js"></script>
    <style type="text/css">

        .topbar {
            width: 100%;
            position: fixed;
            top: 2.5rem;
            height: 2.5rem;
            line-height: 2.5rem;
            z-index: 10;
            display: inline-flex;
            background: #fff;
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

        /*.topbarbutton {
            height: 1.2rem;
            line-height: 1.2rem;
            margin: 0.3rem 0;
            padding: 0 1rem;
            font-size: 0.8rem;
            border-left: 1px lightgray solid;
        }*/

        .menu_line img {
            margin: 0.2rem 0.5rem 0.2rem 0;
            height: 2.6rem;
            width: 2.6rem;
        }

    </style>
</head>
<body>
<div id="clientlist">

    <div class="navibar">
        <img onclick="history.go(-1);" src="<%=request.getContextPath()%>/resources/customer/assets/images/top_bar/back_white.png" alt="" class="topbar_button">
        <div class="topbarmiddle">我的客户</div>
        <img onclick="window.location.href='<%=request.getContextPath() %>/information/informationList'" src="<%=request.getContextPath()%>/resources/customer/assets/images/personal_center/chat.png" style="float: right;" class="topbar_button">
    </div>

    <div class="placeholder" style="height: 5rem;"></div>
    <div class="topbar" id="topbar_search" style="border-bottom: 1px lightgray solid;">
        <div class="middlebox">
            <img src="<%=request.getContextPath()%>/resources/customer/assets/images/search_bar/search_black.png" class="search_img">
            <input class="search_input" placeholder="请输入客户名称" v-model="keyword">
            <!--<div class="topbarbutton">搜索</div>-->
        </div>
    </div>

    <div class="clientlist">
        <div class="menu_line" v-for="client in clients"
             v-if="client.name.toLowerCase().indexOf(keyword.toLowerCase())>=0" @click="chatWith(client.id)">
            <img :src="client.img">
            <span>{{client.name}}</span>
            <span style="color:red;right:1rem;position:absolute;">{{client.status}}</span>
        </div>
    </div>

</div>

</body>

<script type="text/javascript">

    var clientList = new Vue({
        el: "#clientlist",
        data: {
            keyword: "",
            clients: [
                      <c:forEach items="${userList}" var="user">
                      {id:"${user.userId}",name:"<c:out value='${user.userNickname}'/>",img:"${user.userProtraitPic}",status:'<deadLine:date value="${customer.rentVisitTime}" role="${user.role }"/>'},
                      </c:forEach>
                     ]
        },
        methods: {
            chatWith: function (id) {
              	window.location.href='<%=request.getContextPath()%>/information/userInformation?fromUserId='+id;
            }
        }
    });

</script>

<script type="text/javascript">
    window.onload = function () {
        /*此处将数据异步push进clientList.client中  如下*/
    }
</script>

</html>