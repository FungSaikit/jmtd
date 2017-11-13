<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!doctype html>
<html>

	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />

		<title>佐为照明</title>
		
		<!-- mobile_desktop icon -->
		<link rel="app-touch-icon" href="<%=request.getContextPath() %>/resources/index/image/79灯Logo.jpg" />
		<link rel="icon" href="<%=request.getContextPath() %>/resources/index/image/79icon.jpg">
		<!-- 样式文件 -->
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/customer/assets/css/myNewsList.css" />
		<style>
	      .scroll {
	        background-color: #f5f5f5;
	        min-height: 100%;
	      }
	      .tabWrapper {
	        padding: 10px 30px;
	      }
	      .tab {
	        display: inline-block;
	        padding: 2px 4px;
	        background-color: red;
	        border-radius: 4px;
	        color: #fff;
	        margin-bottom: 10px;
	      }
	      .listWrapper {
	        background-color: #fff;
	        padding: 0 10px;
	      }
	      .list {
	        padding: 6px 0px 6px 6px;/* 
	        line-height: 1.8; */
	        border-bottom: 1px solid #ececec;
	        width: 98%;
	      }
	      .order, .content {
	        display: table-cell;
	        vertical-align: top;
	      }
	      .order {
	        width: 20px;
	      }
	      .productName {
	        color: #38c;
	      }
	      .date {
	        color: #ababab;
	      }
	      .del {
	        float: right;
	        color: orange;
	      }
	      .more {
				text-align: center;
				color: #ababab;
				line-height: 3;
				list-style: none;
				border-bottom: 1px solid #ececec;
			}
			/* 颜色设置 */
			.distributor {
				color: #222;
			}
			.no_result {
				color: #555;
				font-size: 0.48rem;
				text-align: center;
				margin-top: 0.34rem;
			}
			.list {
            	margin-top: 0.4rem;
           		border-top: 1px solid #ececec;
	        } 
	        .list-bottom {
	            background-color: #fff;
	            padding: .8rem 1.2rem;
	            font-size: 1.2rem;
	            color: #727272;
	            border-bottom: 1px solid #ececec;
	        }
	        .tag {
	            color: #8593B0;
	            display: inline-block;
	            margin-right: .6rem;
	            font-size: 1.4rem;
	            margin-top: .2rem;
	        }
	        .detail{
	        	color:red;	
	        	padding-top:.2rem;
	        	padding-right:.2rem;
	        }
    	</style>
	</head>
	<body>
        <div class="subscribe">
			<div class="title">
		    	<i class="iconfont prevPage">&#xe624;</i>订阅消息
		    </div>
        <div class="wrapper" id="wrapper">
			<div class="scroll" id="scroll">
	        <div class="tabWrapper">
	        	<c:forEach items="${subscribeProperty}" var="sp">
					<c:if test="${sp.subscribePropertyValue!='不限'}"><span class="tab">${sp.subscribePropertyValue }</span></c:if>
				</c:forEach>
				
	        </div>
			
	             <li class="more" onclick="loadMore()" id="more">
	                 	更多...
	             </li>
	      </div>
	
		</div>
	</div>
	<!-- 进入订购提醒 -->
		<div class="shade full_shade" id="product_shade">
			<div class="pop_box reminder">
				<header class="reminder_header">
					<span>订阅</span><span class="pop_close icon-cross" onclick="$('#product_shade').hide()"></span>
				</header>
				<div class="reminder_content" style="text-align:left"><p id="reminder_content">该产品已下架，详情可联系卖家</p>
				<div class="reminder_buttons">
					<button id="demand_publish" onclick="$('#product_shade').hide()">关闭</button>
					<button id="add_subscribe" onclick="toSellShop()">联系卖家</button>
				</div>
			</div>
		</div>
		<!-- 屏幕遮罩 -->
		<div class="shade" id="home_shade"></div>

		
		<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
		<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
		<script>
			var pageNo=0;
			loadMore();
			function loadMore(){
				var urlStr = "<%=request.getContextPath()%>/demand/subscribeDemandListAjax?subscribeId=${subscribeId}&pageNo="+pageNo;
				$.ajax({
					method: "GET",
					url: urlStr,
					success:function(result,status,jqXHR){
						//alert(data);   
						console.log(result);
						var data = result.data.list;
						var html="";
						
						for(var i=0;i<data.length;i++){
							html+="<li class='list shopList' data-id='"+data[i].pushDemand.demandId+"'><a class='distributor'>";
							html+="<img src='"+data[i].demandCover+"' alt='' class='listImg'></a>";
							html+="<div class='listMid'><a class='distributor' >";
							html+="<p class='listName inaline'>"+data[i].demandName+"</p></a>";
							html+="<p class='what'><span class='whatIcon icon-edit'></span>发布时间 </p><p class='listDate'>"+new Date(data[i].pushDemand.pushTime).format("yyyy-MM-dd hh:mm:ss")+"</p>";
							html+="</div>";
							if(data[i].demandStatus==0||data[i].demandStatus==1)
								html+="<span class='detail'>查看详情</span>";
							else
								html+="<span class='detail'>已失效</span>";	
							
							if(data[i].demandOfferStatus==0)
								html+="<span class='detail'>已提交</span>";
							else if(data[i].demandOfferStatus==1)
								html+="<span class='detail'>已采用</span>";
							else if(data[i].demandOfferStatus==2)
								html+="<span class='detail'>未采用</span>";
								
							html+="</li>";
						}
						$(html).insertBefore("#more");
						console.log(result.data.after)
						if(pageNo+10>=result.data.count){
							$("#more").hide();
		    			}
						if(result.data.after==0){
							$('<p class="no_result">暂时没有消息哦~<br><br></p>').insertBefore($("#more"));
						}
						pageNo=result.data.after;
					}	
				});
				
			}		
		
			$(document).on("tap",".shopList",function(){
				window.location.href="<%=request.getContextPath()%>/demand/demandDetail?demandId="+$(this).attr("data-id");
			});
				
			function showDate(str){
				var date = new Date(str);
				return date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate()+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds();
			}
			
			var shopId;
			function getProductStatus(productId){
				
				var urlStr="<%=request.getContextPath()%>/product/getProductStatus?productId="+productId;
				$.ajax({
					url:urlStr,
					method:"get",
					success:function(data,status,jqXHR){
						if(data.productStatus==1)
							window.location.href="<%=request.getContextPath()%>/product/intoPro/"+data.productId;
						else{
							$("#reminder_content").html("该产品已下架，详情可联系卖家");
							$("#product_shade").show();
							shopId=data.shopId;
						}
					}
				});
			}
			
			function getDemandStatus(demandId){
				var urlStr="<%=request.getContextPath()%>/demand/getDemandStatus?demandId="+demandId;
				$.ajax({
					url:urlStr,
					method:"get",
					success:function(data,status,jqXHR){
						if(data.productStatus==1)
							window.location.href="<%=request.getContextPath()%>/demand/intoDem/"+data.demandId;
						else{
							$("#reminder_content").html("该需求已下架，详情可联系卖家");
							$("#product_shade").show();
							shopId=data.shopId;
						}
					}
				});
			}
			
			function toSellShop(){
				window.location.href="<%=request.getContextPath()%>/shop/contactUs?shopId="+shopId;
			}
			
			Date.prototype.format = function(format) {
	            var date = {
	                   "M+": this.getMonth() + 1,
	                   "d+": this.getDate(),
	                   "h+": this.getHours(),
	                   "m+": this.getMinutes(),
	                   "s+": this.getSeconds(),
	                   "q+": Math.floor((this.getMonth() + 3) / 3),
	                   "S+": this.getMilliseconds()
	            };
	            if (/(y+)/i.test(format)) {
	                   format = format.replace(RegExp.$1, (this.getFullYear() + '').substr(4 - RegExp.$1.length));
	            }
	            for (var k in date) {
	                   if (new RegExp("(" + k + ")").test(format)) {
	                          format = format.replace(RegExp.$1, RegExp.$1.length == 1
	                                 ? date[k] : ("00" + date[k]).substr(("" + date[k]).length));
	                   }
	            }
	            return format;
	     }
			
		$(".prevPage").tap(function(){
			history.go(-1);
		});
		</script>
	</body>
</html>