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
		
	    
	</head>
	<body>
		<jsp:include page="/jsp/platform/header.jsp"></jsp:include>
		<jsp:include page="/jsp/platform/navigation.jsp"></jsp:include>
		<button onclick="sortBy=0;getData();">今天</button>
		<button onclick="sortBy=1;getData();">昨天</button>
		<button onclick="recent(7)">最近七天</button>
		<button onclick="recent(30)">最近三十天</button>
		<button><input type="date" name="from"></button>
		<button><input type="date" name="to"></button>
		<button onclick="consult()">查询</button>
        
    	<div id="main" style="width: 100%;height:600px;"></div>
    	
    	<table data-toggle="table" id="table">
		    <thead>
		        <tr>
		            <th data-field="addressName" data-sortable="true">地区</th>
		            <th data-field="signNum" data-sortable="true">注册量</th>
		            <th data-field="pageVisit" data-sortable="true">浏览量</th>
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
    	var sortBy=2;
   		function consult(){
    		sortBy=2;
    		getData();
    	}
   		
   		var maxSignUpNumber=0;
   		var maxPageVisit=0;
   		var maxOrderMoney=0.0;
   		
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
   			var url="<%=request.getContextPath()%>/platform/userMapData";
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
	        var pageVisit=new Array();
	        var orderMoney=new Array();
	        var dataOverview=[];
	        for(var i=0;i<data.length;i++){
	        	xA[i]=data[i].dataTime;
	        	signNum[i]={name:data[i].addressName,value:data[i].signUpNumber};
	        	pageVisit[i]={name:data[i].addressName,value:data[i].pageVisit};
	        	orderMoney[i]={name:data[i].addressName,value:data[i].orderMoney};
	        	console.log(orderMoney[i]);
	        	var o={addressName:data[i].addressName,signNum:data[i].signUpNumber,
	        			pageVisit:data[i].pageVisit,
	        			orderMoney:data[i].orderMoney};
	        	dataOverview.push(o);
	        }/* 
	        console.log(dataOverview); */
        	maxSignUpNumber=data[0].maxSignUpNumber;
	        maxPageVisit=data[0].maxPageVisit;
	        maxOrderMoney=data[0].maxOrderMoney;
	        
	        // 指定图表的配置项和数据
	        var option = {
	            title: {
	                text: '地图'
	            },
	            tooltip: {
	                trigger: 'item'
	               
	            },
	            legend: {
	                data:['注册量','浏览量','销售额']
	            },
	            visualMap:{
	            	min:0,
	            	max:maxSignUpNumber+maxPageVisit+maxOrderMoney,
	            	left:'left',
	            	top:'bottom',
	            	text:['高','低'],
	                calculable: true,
            	 	inRange: {
                   	  color: ['white','yellow', 'orangered']
                	}
	            },
	            toolbox:{
	            	show:true,
	            	orient:'vertical',
	            	left:'right',
	            	top:'center',
	            	feature: {
	                    dataView: {readOnly: false},
	                    restore: {},
	                    saveAsImage: {}
	                }
	            },
	            
	            series: [{
	                name: '注册量',
	                type: 'map',
	                mapType: 'china',
	                roam: false,
	                label: {
	                    normal: {
	                        show: true
	                    },
	                    emphasis: {
	                        show: true
	                    }
	                },
	                data: signNum
	            },{
	                name: '浏览量',
	                type: 'map',
	                mapType: 'china',
	                roam: false,
	                label: {
	                    normal: {
	                        show: true
	                    },
	                    emphasis: {
	                        show: true
	                    }
	                },
	                data: pageVisit
	            },{
	                name: '销售额',
	                type: 'map',
	                mapType: 'china',
	                roam: false,
	                label: {
	                    normal: {
	                        show: true
	                    },
	                    emphasis: {
	                        show: true
	                    }
	                },
	                data: orderMoney
	            }]
	        };
			
	        
	        // 使用刚指定的配置项和数据显示图表。
	        myChart.setOption(option);
	        
	        $('#table').bootstrapTable('load', dataOverview);
	        
	        
	        myChart.on('legendselectchanged', function (params) {
	        	var max=0;
	        	if(params.selected.注册量)
	        		max+=maxSignUpNumber;
	        	if(params.selected.浏览量)
	        		max+=maxPageVisit;
	        	if(params.selected.销售额)
	        		max+=maxOrderMoney;
	        	
	   			option.visualMap.max=max;
		        myChart.setOption(option);
	   		});
   		}
   		

   		function fail(data){
   			console.log("fail");
   		}
   		
   		
    </script> 
</body>
</html>