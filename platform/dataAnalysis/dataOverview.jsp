<%@ page language="java" import="java.util.*,com.alphaking.constant.*,com.alphaking.model.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!doctype html>
<html lang="en">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport"
	          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
	    <title>管理后台</title>
	    <link rel="icon" type="image/x-icon" href="<%=request.getContextPath() %>/resources/backStage/image/favicon.ico" />
	
	    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/common/bootstrap.min.css" />
	    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/backStage/css/index.css" />
	    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/common/bootstrap-table.min.css" />
	
	    <style>
	    	.overview-card-title-container {
			    padding: 14px 15px 0;
			}
			.overview-card-title {
			    font-size: 14px;
			    color: #323437;
			    font-weight: 700;
			}
			.list {
			    border-collapse: collapse;
			    width: 100%;
			    font-size: 12px;
			}
			div.table-list {
			    padding: 6px 0px;
			    padding-right: 1px;
			    border: 1px solid #dedede;
			    background:#fff;
			    margin-bottom:6px;	
			}
			div.table-list table.list tr.title {
			    border-bottom: none;
			    height: 50px;
			    line-height: 50px;
			}
			div.table-list table.list th {
			    height: 16px;
			    line-height: 16px;
			    padding: 13px 20px 0 10px;
			    text-align: right;
			    color: #5b5d61;
			    white-space: nowrap;
			    font-weight: 400;
			}
			div.table-list table.list {
			    border-collapse: collapse;
			    width: 100%;
			    font-size: 12px;
			}
			div.table-list table.list tr.highlight td.normal {
			    padding-left: 20px;
			    font-size: 12px;
			    font-weight: 400;
			    text-align: left;
			}
			div.table-list table.list tr td.normal {
			    padding-left: 20px;
			    width: 85px;
			    text-align: left;
			    color: #323437;
			}
			div.table-list table.list tr.highlight td {
			    color: #111314;
			    font-size: 16px;
			    font-weight: bolder;
			}
			div.table-list table.list tr td {
			    border-left: 1px solid #f0f0f0;
			    padding: 6px 20px 6px 5px;
			    height: 17px;
			    line-height: 17px;
			    white-space: nowrap;
			    text-align: right;
			}
	    </style>
	</head>
	<body>
		<jsp:include page="/jsp/platform/header.jsp"></jsp:include>
		<jsp:include page="/jsp/platform/navigation.jsp"></jsp:include>
		
		<div class="table-list">
			<div class="overview-card-title-container"><label class="overview-card-title">概况</label></div>
			<table cellspacing="0" cellpadding="0" class="list" id="IndexPreviewTableList">
				<tbody>
					<tr class="title">
			            <th>关注量</th>
			            <th>注册量</th>
			            <th>访客数</th>
			            <th>浏览量</th>
			            <th>下单量</th>
			            <th>销售额</th>
					</tr>
					<tr class="highlight">
						<td class=""></td><td class=""></td><td class=""></td><td class=""></td>
						<td class=""></td><td class=""></td>
					</tr>
			</tbody></table>
		</div>
		<button onclick="sortBy=0;getData();" class="btn navActive">今天</button>
		<button onclick="sortBy=1;getData();" class="btn">昨天</button>
		<button onclick="recent(7)" class="btn">最近七天</button>
		<button onclick="recent(30)" class="btn">最近三十天</button>
		<button><input type="date" name="from"></button>
		<button><input type="date" name="to"></button>
		<button onclick="consult()" class="button">查询</button>
        
    	<div id="main" style="width: 100%;height:600px;"></div>
    	
    	<table data-toggle="table" id="table">
		    <thead>
		        <tr>
		            <th data-field="dataRange" data-sortable="true">日期</th>
		            <th data-field="signNum" data-sortable="true">关注量</th>
		            <th data-field="followNum" data-sortable="true">注册量</th>
		            <th data-field="visiter" data-sortable="true">访客数</th>
		            <th data-field="pageVisit" data-sortable="true">浏览量</th>
		            <th data-field="orderFormNumber" data-sortable="true">下单量</th>
		            <th data-field="orderMoney" data-sortable="true">销售额</th>
		        </tr>
		    </thead>
		    <tbody>
		       
		    </tbody>
		</table>
    
    </div><!-- 页面主体的右边]] -->

    </div><!-- 页面主体]] -->
 
 	
    <footer>

    </footer>
	 
	<script src="<%=request.getContextPath()%>/resources/common/echarts.js"></script>
	<script src="<%=request.getContextPath()%>/resources/common/bootstrap-table.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/common/china.js"></script>
    <script type="text/javascript">
    	var sortBy=0;
    	getData();
    	
   		function consult(){
    		sortBy=2;
    		getData();
    	}
   		
   		function recent(day){
    		sortBy=2;
   			var to=new Date();
   			$("input[name='to']").val(FormatDate(to));
   			
   			var from = to.getTime()-(day-1)*24*60*60*1000;
   			$("input[name='from']").val(FormatDate(from));
   			getData();
   		}
   		
   		function FormatDate (strTime) {
		    var date = new Date(strTime);
		    return date.Format("yyyy-MM-dd");
		}
    
   		function getData(){
   			var url="<%=request.getContextPath()%>/platform/getData";
   			doAjax("GET",url,{sortBy:sortBy,from:$("input[name='from']").val(),to:$("input[name='to']").val()},success,fail,true,false)
   		} 
   		
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

        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));
        
   		function success(data){
	       
	        var xA=new Array();
	        var signNum=new Array();
	        var followNum=new Array();
	        var visiter=new Array();
	        var pageVisit=new Array();
	        var orderFormNumber=new Array();
	        var orderMoney=new Array();
	        var dataOverview=[];
	        for(var i=0;i<data.length;i++){
	        	xA[i]=data[i].dataTime;
	        	signNum[i]={name:data[i].dataRange,value:data[i].signUpNumber};
	        	followNum[i]={name:data[i].dataRange,value:data[i].followNumber};
	        	visiter[i]={name:data[i].dataRange,value:data[i].visiter};
	        	pageVisit[i]={name:data[i].dataRange,value:data[i].pageVisit};
	        	orderFormNumber[i]={name:data[i].dataRange,value:data[i].orderFormNumber};
	        	orderMoney[i]={name:data[i].dataRange,value:data[i].orderMoney};
	        	var o={dataRange:data[i].dataRange,signNum:data[i].signUpNumber,followNum:data[i].followNumber,visiter:data[i].visiter,
	        			pageVisit:data[i].pageVisit,orderFormNumber:data[i].orderFormNumber,
	        			orderMoney:data[i].orderMoney};
	        	dataOverview.push(o);
	        }
	        $(".highlight td").eq(0).html(data[0].totalFollowNumber);
	        $(".highlight td").eq(1).html(data[0].totalSignUpNumber);
	        $(".highlight td").eq(2).html(data[0].totalVisiter);
	        $(".highlight td").eq(3).html(data[0].totalPageVisit);
	        $(".highlight td").eq(4).html(data[0].totalOrderFormNumber);
	        $(".highlight td").eq(5).html(data[0].totalOrderMoney);
	        console.log(dataOverview);
	        
	        // 指定图表的配置项和数据
	        var option = {
	            title: {
	                text: ''
	            },
	            tooltip: {
	                trigger: 'axis',
	                formatter: function (params) {
						var str='';
						str=params[0].data.name+'<br>';
						
						for(var i=0;i<params.length;i++){
		                    param = params[i];
		                    str+='<span style="display:inline-block;margin-right:5px;border-radius:10px;width:9px;height:9px;background-color:'+param.color
	                    	+';"></span>'+param.seriesName + ' : ' + param.data.value+'<br>';
						}
						
	                    return str;
	                    
	                },
	                axisPointer: {
	                }
	            },
	            legend: {
	                data:['关注量','注册量','访客数','浏览量','下单量','销售额']
	            },
	            xAxis: {
	            	type:'category',
	            	data: xA,
	            	boundaryGap:false,
	            },
	            yAxis: { 
	                splitLine: {
	                    show: false
	                }
	            },
	            series: [{
	                name: '关注量',
	                type: 'line',
	                data: followNum
	            },{
	                name: '注册量',
	                type: 'line',
	                data: signNum
	            },{
	                name: '访客数',
	                type: 'line',
	                data: visiter
	            },{
	                name: '浏览量',
	                type: 'line',
	                data: pageVisit
	            },{
	                name: '下单量',
	                type: 'line',
	                data: orderFormNumber
	            },{
	                name: '销售额',
	                type: 'line',
	                data: orderMoney
	            }]
	        };
			
	        
	        // 使用刚指定的配置项和数据显示图表。
	        myChart.setOption(option);
	        
	        $('#table').bootstrapTable('load', dataOverview);
   		}
   		
   		function fail(data){
   			console.log("fail");
   		}
   		
   		$(".btn").click(function(){
   			$(".btn").each(function(){
   				$(this).removeClass("navActive");
   			})
   			$(this).addClass("navActive");
   		});
   		
   		$(".button").click(function(){
   			$(".btn").each(function(){
   				$(this).removeClass("navActive");
   			})
   		})
    </script> 
</body>
</html>