<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html>

	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />

		<title>金明同达灯饰</title>
		
		<!-- mobile_desktop icon -->
		<link rel="app-touch-icon" href="<%=path %>/resources/index/image/79灯Logo.jpg" />
		<link rel="icon" href="<%=request.getContextPath() %>/resources/index/image/79icon.jpg">
		<!-- 样式文件 -->
		<link rel="stylesheet" type="text/css" href="<%=path %>/resources/customer/assets/css/filter.css" />
	</head>

	<body>

		<div class="subscribe">
			<div class="title"><!-- 
			  <i class="iconfont prevPage normalPrev">&#xe624;</i> -->添加订阅
			</div>

		<div class="wrapper">
			<div class="scroll">
				<ul class="filter_panel">
				<c:forEach items="${list}" var="l" varStatus="st">
				<c:if test="${l.typeName!='品牌'&&l.typeName!='空间'&&l.typeName!='类型' }">
				<li <c:if test="${l.typeName=='风格' }">id="styleList"</c:if>>
				<p class="filter_list">${l.typeName}<span class="icon-chevron-down"></span>
					
				</p>
					<table class="filter_table" id="table${st.index}">
						<tbody>
					<c:forEach items="${valueList}" var="value" varStatus="i" begin="${st.index }" end="${st.index }">
						<c:forEach items="${l.propertyValueList}" var="pvl" varStatus="st2">
							<c:if test="${pvl.propertyValue!='其他' }">
							<c:choose>
							<c:when test="${st2.index%3==0&&!st2.last}">
								<tr>
									<td><a href="javascript:select('${st.index}','${pvl.propertyValue}','${l.typeName}')" class="filter_tap <c:if test="${value==pvl.propertyValue }">table_a_active</c:if>">${pvl.propertyValue}</a></td>
							</c:when>
							<c:when test="${st2.index%3==2}">
									<td><a href="javascript:select('${st.index}','${pvl.propertyValue}','${l.typeName}')" class="filter_tap <c:if test="${value==pvl.propertyValue }">table_a_active</c:if>" >${pvl.propertyValue}</a></td>
								</tr>
							</c:when>
							<c:when test="${st2.index%3==0&&st2.last}">
								<tr>
									<td><a href="javascript:select('${st.index}','${pvl.propertyValue}','${l.typeName}')" class="filter_tap <c:if test="${value==pvl.propertyValue }">table_a_active</c:if>" >${pvl.propertyValue}</a></td>
								</tr>
							</c:when>
							<c:when test="${st2.index%3!=0&&st2.last}">
									<td><a href="javascript:select('${st.index}','${pvl.propertyValue}','${l.typeName}')" class="filter_tap <c:if test="${value==pvl.propertyValue }">table_a_active</c:if>">${pvl.propertyValue}</a></td>
								</tr>
							</c:when>
							<c:otherwise>
									<td><a href="javascript:select('${st.index}','${pvl.propertyValue}','${l.typeName}')" class="filter_tap <c:if test="${value==pvl.propertyValue }">table_a_active</c:if>">${pvl.propertyValue}</a></td>
							</c:otherwise>
							</c:choose>
							</c:if>
						</c:forEach>
						<c:if test="${l.typeName=='价格'}">
							<tr class="custom"><td colspan="4">
								<input type="text" id="low" onKeyUp="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" />--<input type="text" id="high" onKeyUp="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" />
								<input type="button" value="确定" onClick="checkPrice('${st.index}')"/>
							</td></tr>
						</c:if>
						</c:forEach>
						</tbody>
					</table>
				</li>
				</c:if>
				</c:forEach>
				<form id="addForm" action="<%=request.getContextPath()%>/demand/addSubscribe" onsubmit="return checkForm();">
				<!-- <li class="area">
					产地
					<select class="province" data-value="广东省" id="province" onchange="queryCity(this.value)"></select>	
					<select class="city" name="cityId" id="city" ></select>
				</li> -->
				</ul>

				<div class="filter_sure">
					<button class="btn btn_mid reset" type="button" style="border:0;">重置</button>
					<button class="btn btn_mid sure" style="border:0;">确定</button>
				</div>

			</div>
		</div>
		
			<input type="hidden" name="property" id="property"/>
			
		</form>
		</div>
		
		
		<div class="tip" id="error">请至少添加一项订阅项</div>
		<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
		<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
		<script src="<%=request.getContextPath() %>/resources/common/fx.js"></script>
		<script src="<%=request.getContextPath() %>/resources/common/fx_methods.js"></script>
		<script src="<%=request.getContextPath() %>/resources/customer/assets/js/subscribe.js"></script>
		
		<script type="text/javascript">
		function checkForm(){
			var list = $(".selection");
			var property="";
		
			for(var i=0;i<list.length;i++){
				var type = list.eq(i).attr("name").split(":")[0];
				var value = list.eq(i).html().split("<")[0];
				property+=type+":"+value;
				if(i==0 || i!=list.length-1)
					property+=",";
			}
			

			if(list.length==0 ){
				$("#error").fadeIn('fast');
		  		setTimeout(function(){
		  			$("#error").fadeOut();
		  		},1000);
				return false;
			}else{
				$("#property").val(property);
			}	
			/* alert(property) */
			
		}
		
		function select(demo,value,type)
		{
			if(type=="类型")
				findStyle(value);
			
			var p = $("#table"+demo).siblings("p");
			p.children("label").remove();
			var label=$("<label class='selection' name='"+type+":"+demo+"'>"+value+"</label>");
			var span=$("<span class='icon-cross tabDel'></span>");
			span.appendTo(label);
			label.appendTo(p);
			
			if(type=='价格'&&!flag){
				$("#high").val("");$("#low").val("");
			}
			flag=false;
			
			$(".selection").tap(function(e){
				var id=$(this).attr("name").split(":")[1];
				$("#table"+id+" a").removeClass("table_a_active");
				if($(this).attr("name").split(":")[0]=='价格'){
					$("#high").val("");$("#low").val("");
				}
				$(this).remove();
				e.stopPropagation();
			});
		}
		
		var flag=false;
		function checkPrice(id){
			var low = $("#low").val();
			var high = $("#high").val();
			var price="";
			flag=true;
			if(low==""&&high!=""){
				price = high+"以下";
				select(1,price,'价格');
			}
			if(low!=""&&high==""){
				price = low+"以上";
				select(1,price,'价格');
			}
			if(low!=""&&high!=""){
				if(parseInt(low)>=parseInt(high))
					price = high+"-"+low;
				else if(parseInt(low)<parseInt(high))
					price = low+"-"+high;
				select(id,price,'价格');
			}
			
			
		} 
		
		function sub()
		{
			$("#frm").submit();
		}
		
		function queryCity(obj){
			var urlStr = "<%=request.getContextPath()%>/address/queryCity?provinceId="+obj;
			//alert("Before Call:"+urlStr);
			$.ajax({
				method: "GET",
				url: urlStr,
				success:function(data,status,jqXHR){
					//alert(data);
					$("#city").html("");
				
					for(var i=0;i<data.length;i++){
						$("#city").append("<option value="+data[i].cityId+">"+data[i].cityName+"</option>");
					}
				}
			}); // end ajax 
		}
		
		$(function(){
			var urlStr = "<%=request.getContextPath()%>/receiveAddress/getProvinceList";
			//alert("Before Call:"+urlStr);
			$.ajax({
				method: "GET",
				url: urlStr,
				success:function(data,status,jqXHR){
					$("#province").append("<option value=''>请选择</option>");
					for(var i=0;i<data.length;i++){
						$("#province").append("<option value='"+data[i].provinceId+"'>"+data[i].provinceName+"</option>");	
					}
				}	
			}); // end ajax 
			
		
			//当show的值为1时显示提示信息
			<c:if test="${show==1}">
				if (!$.fn.cookie('subReminder')) {	
					$("#reminder_shade").show();
				}
				
			    $("#no_reminder").bind("tap", function () {
					$.fn.cookie('subReminder', true, {  expires: 1000});  
			        
			    });
			</c:if>    

			
		})
		
		var preType="吊灯";
		function findStyle(type){
			if(preType!=type && (((type!='户外照明'||type!='照明光源'||type!='开关插座'||type!='其他')&&(preType=='户外照明'||preType=='照明光源'||preType=='开关插座'||preType=='其他'))
					|| ((type=='户外照明'||type=='照明光源'||type=='开关插座'||type=='其他')&&(preType!='户外照明'||preType!='照明光源'||preType!='开关插座'||preType!='其他')))){				
				preType=type;
				var urlStr="<%=request.getContextPath()%>/search/changeStyle?type="+type;
				//alert(urlStr);
				$.ajax({
					url:urlStr,
					method:"post",
					success:function(data,status,jqXHR){
						var html="<tbody>";
						var table = $("#styleList").find("table");
						var index=table.attr("id").split("table")[1];//索引值，用来记录要更改那一块input框
						$("#styleList").find("label").remove();
						var id="#input"+index; 
						$(id).val("全部");
						if(type=="开关插座"||type=="其他"){
							$("#styleList").find("span").css("display","none");
							$("#styleList").find(".filter_list").attr("data-flag","true");
						}else{
							$("#styleList").find("span").css("display","inline-block");
							$("#styleList").find(".filter_list").removeAttr("data-flag");
						}
						for(var i=0;i<data.length;i++){
							if(i%3==0)
								html+="<tr>";
							if(data[i].propertyValue!="其他")
								html+="<td><a href='javascript:select(\""+index+"\",\""+data[i].propertyValue+"\",\"风格\" )' class='filter_tap'>"+data[i].propertyValue+"</td>";
							if(i%3==2||i==data.length-1)
								html+="</tr>";
						}
						html+="</tbody>";		
						table.html(html);
						
					}
				});
			}
		}
		
		var $pop_close = $('.pop_close');
	    var $no_reminder = $('#no_reminder');
	    var $sure_reminder = $('#sure_reminder');
	    var $reminder_shade = $('#reminder_shade');

	     $reminder_shade.on('touchstart',function(e){
	     	e.preventDefault();
	     });

	    $pop_close.tap(function(){
			$reminder_shade.hide();
	    });

	    $no_reminder.tap(function(){
			$reminder_shade.hide();
	    });

	    $sure_reminder.tap(function(){
			$reminder_shade.hide();
	    });
		</script>
	</body>
</html>


