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
    <style type="text/css">

        .chatlist {
            display: flex;
            flex-direction: column;
            width: 100%;
        }

        .menu_line {
            height: 4rem;
            width: 100%;
            display: flex;
            overflow: hidden;
            padding: 0.5rem 0;
        }

        .menu_line img {
            height: 4rem;
            width: 4rem;
            margin: 0 0.5rem;
            border-radius: 0.5rem;
        }

        .img_n_number {
            position: relative;
        }

        .corner_number {
            margin-right: 0.5rem;
            display: inline-block;
            font-size: 0.8rem;
            background-color: red;
            color: #fff;
            height: 1rem;
            line-height: 1rem;
            padding-left: 0.3rem;
            padding-right: 0.3rem;
            border-radius: 1rem;
            position: absolute;
            top: -.2rem;
            right: -.2rem;
        }

        .detail_info {
            flex-grow: 1;
            line-height: 2rem;
            color: dimgray;
            display: flex;
            flex-direction: column;
        }

        .username {
            color: #000;
        }

        .lastmessage {
            font-size: 0.8rem;
            height: 2rem;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 1;
            -webkit-box-orient: vertical;
            vertical-align: middle;
        }

        .lasttime {
            color: gray;
            font-size: 0.8rem;
            float: right;
            margin-right: 0.5rem;
        }

        .hidden {
            display: none;
        }

    </style>
</head>
<body>

<div class="navibar">
    <img onclick="history.go(-1);" src="<%=request.getContextPath()%>/resources/customer/assets/images/top_bar/back_white.png" alt="" class="topbar_button">
    <div class="topbarmiddle">消息</div>
    <img onclick="window.location.href='<%=request.getContextPath()%>/information/clientList'" src="<%=request.getContextPath()%>/resources/customer/assets/images/personal_center/client.png" style="float: right;" class="topbar_button">
</div>

<div class="placeholder" style="height: 2.5rem;"></div>
<div class="chatlist" id="chatlist">

    
    <div class="menu_line loading" style="height: 1.5rem;line-height: 1.5rem;display: block; text-align: center;">点击加载更多</div>

</div>

<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>

<script type="text/javascript">
	//开始加载中
	var canLoad=true;
	var noDate=false;
	var wiwH=$(window).height();
	var load=$(".loading");
	var time;
	var offset1=0;
	$(document).scroll(function(){
		//获取该元素最近的被定位的父元素的坐标!  
		if(load.offset().top-$(window).scrollTop()<wiwH){
	    	console.log("true");
			if(canLoad&&!noDate){
				canLoad=false;
				informationList();
			}
		}/* else{
			window.clearTimeout(time);
			$("#jiazai").html("加载中...");
			load.css("visibility","hidden");
			$(".loading>i").css("animation-play-state","running");
		} */
		
	});
	//结束加载中
	
	informationList();
	/* var iInterval = setInterval("informationList()",2000); */
	var flag=false;//决定是否滚到底部
	
	function informationList(){
		var url="<%=request.getContextPath()%>/information/informationListAjax";
		var params={offset:offset1};
		doAjax("GET",url,params,getSuccess,fail,true,false);
	}
	
	function getSuccess(data){
		var list = data.data.list;
		var html="";
		for(var i=0;i<list.length;i++){
			html+='<div class="menu_line" data-id="'+list[i].user.userId+'">';
			html+='<div class="img_n_number">';
			html+='<img src="'+list[i].user.userProtraitPic+'">';
			if(list[i].newInfoNumber>0)
				html+='<span class="corner_number">'+list[i].newInfoNumber+'</span>';
			html+='</div>';
			html+='<div class="detail_info">';
			html+='<div class="username">'+list[i].user.userNickname+'<span class="lasttime">'+FormatDate(list[i].infoTime)+'</span></div>';
			html+='<div class="lastmessage">'+list[i].firstInfo+'</div>';
			html+='</div>';
			html+='</div>';
		}
		$(html).insertBefore(".loading");
		if((parseInt(offset1)+10)>=data.data.count){
			noDate=true;
			$(".loading").html("已经到底了");
		}
		if(i>9&&i>=data.data.count){
			noDate=true;
			$(".loading").html("已经到底了");
		}
		offset1=data.data.after;
		canLoad=true;
	}
	
	function fail(data){
		console.log("fail");
	}
	
	function FormatDate (strTime) {
	    var date = new Date(strTime);
	    if(isToday(date))
	    	return date.Format("hh:mm");
	    else
	    	return date.Format("MM月dd日");
	}
	
	function isToday(date){
	    var today=new Date();
	    return date.getFullYear()==today.getFullYear()
	    	&& date.getMonth()==today.getMonth() && date.getDate()==today.getDate();
	}
	
	function deadLine(visitTime){
		console.log(visitTime)
		if(visitTime==null){
			return "离线";
		}else{
			var time = visitTime+2*24*60*60*1000-new Date().getTime();
			if(time<0)
				return "离线";
			else
				if(${user.role==2})
					return "还有"+Math.round(time/1000.0/60.0/60.0)+"小时后过期";
				else
					return "在线";//+Math.round(time/1000.0/60.0/60.0)+"小时后过期";
		}
	}
	
	$(document).on("click",".menu_line",function(){
		if(!$(this).hasClass("loading"))
			window.location.href="<%=request.getContextPath()%>/information/userInformation?fromUserId="
				+$(this).attr("data-id");
	});
	
	Date.prototype.Format = function (fmt) { //author: meizz 
        var o = {
            "M+": this.getMonth() + 1, //月份 
            "d+": this.getDate(), //日 
            "h+": this.getHours(), //小时 
            "m+": this.getMinutes(), //分 
            "s+": this.getSeconds(), //秒 
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
            "S": this.getMilliseconds() //毫秒 
        };
        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    }

</script>
</body>
</html>