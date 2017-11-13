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
        
    	
    	<table data-toggle="table" id="table" data-search="true" data-search-on-enter-key="true"
    		 data-pagination="true" >
		    <thead>
		        <tr>
		            <th data-field="userNickname" data-sortable="true" >昵称</th>
		            <th data-fieLd="legalPersonName">姓名</th>
		            <th data-fieLd="pageVisit">访问次数</th>
		            <th data-fieLd="orderMoney">下单量</th>
		            <th data-fieLd="lowUser">下级数</th>
		            <th data-fieLd="shopcartNum">购物车产品数</th>
		        </tr>
		    </thead>
		    <tbody>
		       
		    </tbody>
		</table>
    
    </div><!-- 页面主体的右边]] -->

    </div><!-- 页面主体]] -->
 
 	
    <footer>

    </footer>
	<script src="<%=request.getContextPath()%>/resources/common/bootstrap-table.min.js"></script>
    <script type="text/javascript">
   		
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
   			var url="<%=request.getContextPath()%>/platform/userAnalysisData";
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

        
        
   		function success(data){
	       
	        var xA=new Array();
	        var signNum=new Array();
	        var pageVisit=new Array();
	        var orderMoney=new Array();
	        var dataOverview=[];
	        for(var i=0;i<data.length;i++){
	        	var o={addressName:data[i].userNickname,signNum:data[i].role,
	        			pageVisit:data[i].upperUserId,
	        			orderMoney:data[i].userId};
	        	dataOverview.push(o);
	        }/*  
	        console.log(dataOverview); */
        	maxSignUpNumber=data[0].maxSignUpNumber;
	        maxPageVisit=data[0].maxPageVisit;
	        maxOrderMoney=data[0].maxOrderMoney;
	        
	        
	        
	        $('#table').bootstrapTable('load', dataOverview);
	        
	        
	        
   		}
   		

   		function fail(data){
   			console.log("fail");
   		}
   		
   		function queryParams(params) {

   			return {
	   			offset: params.offset,
	
	   			limit: params.limit,
	
	   			UserName: 4

   			};

		}
   		
   		$("#table").bootstrapTable({
   			method: "get",  //使用get请求到服务器获取数据
   			url: "<%=request.getContextPath()%>/platform/userAnalysisData",
   			pagination: true, //启动分页  
   			pageSize: 10,  //每页显示的记录数  
   			pageNumber:1, //当前第几页  
   			search: true,  //是否启用查询  
   		 	sidePagination: "server",
   		 	queryParams: queryParams,
   		 	
   		});
    </script> 
</body>
</html>