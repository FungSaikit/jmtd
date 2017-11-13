<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>管理后台</title>
    <link rel="icon" type="image/x-icon" href="<%=request.getContextPath() %>/resources/image/favicon.ico" />

    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/common/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/backStage/css/index.css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/backStage/css/systemManager.css">
    <style>
		.waiting {
		    text-align: center;
		    position: fixed;
		    left: 0;
		    top: 40%;
		    width: 100%;
		    z-index: 1003;
		    line-height: 50px;
		    display: none;
		}
		
		.shade {
		    width: 100%;
		    height: 100%;
		    background-color: rgba(0,0,0,.5);
		    position: fixed;
		    left: 0;
		    top: 0;
		    z-index: 100;
		    display: none;
		}
		.table-div{background-color:#fff;padding-bottom: 20px}
		.table-div table{margin:0 auto}
		.table-tr td:first-child{padding: 9px 15px;border-right: 1px solid #e2e2e2;}
		.table-tr{border: 1px solid #e2e2e2;}
		.table-div table tr td img{width: 100px;height: 100px}
		.table-div table tr td{text-align: center;padding: 9px 15px;}
		.table-word{max-width:220px;}
		
		.imgdiv{margin-left: 9%;position: relative;display: flow-root;}
		.form-labe{float: left;display: block;padding: 2px 15px;font-weight: 400;text-align: right;width: 146px}
		.form-labe div{color: #999;font-size: 13px}
		.upload-file{opacity: .01;}
		.upbar{width: 16%;height: 100px;position: relative;}
		.upbar .add{font-size: 60px;font-weight: 600;display: inline-block;width: 100%;text-align: center;color: #ff0000;text-align: center;cursor: pointer;}
		.clearfix:after {content: ".";display: block;height: 0;clear: both;visibility: hidden;}
		.clearfix {zoom: 1;}
		.magbtm{margin-bottom: 20px}
		.magbtm textarea {width: 30%;}
		.fd-width input{padding: 6px 20px 6px 10px;width: 30%}
		.dress{display: inline-block;margin-right: 10px;margin-bottom: 2px;width: 7px;height: 22px;background: #3598DC;vertical-align: bottom;}
		.table-tr input{width:100%;}
	</style>
</head>
<body>
	<div class="wrapper">
		<jsp:include page="/jsp/platform/header.jsp"></jsp:include>
		<jsp:include page="/jsp/platform/navigation.jsp"></jsp:include>
            <div class="area">
                <!-- [[上传说明 -->
                
                <%-- <div class="row indexCarousel">
                    <form class="col-sm-5 img-form" action="<%=request.getContextPath()%>/platform/changePersonQrCodeConf" style="height:100%">
                        <img src="${picture}" alt="" />
                        <div class="oprate clearfix">
                             <span class="col-md-4">
                                  <button class="col-md-4 btn btn-info uploadImgBtn" style="position:absolute;margin-top:10px">
                                      <input type="file" accept="image/*" class="selFile" />
                                      <input type="hidden" name="picture" value="${picture}"/>
                                      <span class="glyphicon glyphicon-cloud-upload" style="display:inline">上传</span> 
                                  </button>
                             </span>
                        </div>
                        <p></p>
                       	 文字描述：<input type="text" name="content" value="${content}" style="width:200px;display:block;"/>&nbsp;
                       	标题：<input type="text" name="title" value="${title}" style="width:200px;display:block;"/>&nbsp;
                        <button class=" updateImgBtn"  style="display:block;float:right;">更新</button>
                   		
                    </form>
                </div> --%>
            <div>
		        <form action="<%=request.getContextPath()%>/platform/changePersonQrCodeConf" id="form">
            	<div class="clearfix magbtm">
                	<label class="form-labe">上传图片<div>尺寸要求为2:1</div></label>
                	<div class="imgdiv">
			                <div>
			                	<div class="upbar">
			                		<input type="file" name="file" class="upload-file" accept="image/*">
			                		<span class="">
	                                  <button class="btn btn-info uploadImgBtn">
	                                      <input type="file" accept="image/*" class="selFile" />
	                                      <input type="hidden" name="picture" value="${picture}"/>
	                                      <span class="glyphicon glyphicon-cloud-upload" style="display:inline">上传</span> 
	                                  </button>
	                             </span>
			                	</div>
			                	<div style="width: 300px"><img src="${picture}" alt="" width="100%" /></div>
			                </div>
	                </div>
                </div>
                <div class="clearfix magbtm">
                	 <label class="form-labe">文字描述</label>
	                 <div class="input-block ">
						<textarea  rows="5" placeholder="文字描述" name="content">${content }</textarea>
					</div>
				</div>
                <div class="clearfix magbtm">
                	 <label class="form-labe">标题</label>
	                 <div class="input-block fd-width ">
						<input type="text"  placeholder="请输入标题" value="${title}" name="title">
					 </div>
                </div>
                <div class="clearfix magbtm">
                	<button class=" updateImgBtn btn btn-default"  style="display:block;margin-left: 147px;margin-right: 16px;float: left;">更新</button>
                	<button class=" btn btn-default" onclick="massProduceQrCodePic()" type="button" style="display:block;margin-left: 147px;">群发</button>
                </div>
                </form>
            </div>
			<div class="table-div">
		<%-- 
			<c:forEach items="${productSpreadList}" var="ps">
				<tr>
					<td><img src="${ps.productSpreadPic }" style="width:100px;height:100px;"/></td>
					<td>${ps.productSpreadTitle }</td>
				</tr>
			</c:forEach>
		 --%>
		
			<table>
				<tr><td class="press-td" style="text-align: left;padding-left: 0;font-weight: 700;font-size: 18px;"><div class="dress"></div>每日推广列表</td></tr>
				<tr id="searchTr"><td colspan="2">
				
				<div style="">
					<form class="bs-example bs-example-form" role="form">
						<div class="row">
							<div class="col-lg-7" style="padding-left: 0;">
								<div class="input-group">
									<input type="text" id="keyword" class="form-control" placeholder="输入搜索信息">
									<span class="input-group-btn">
										<button class="btn btn-default" type="button" onclick="getProductSpreadRecordList()">
											<i class="glyphicon glyphicon-search" style="color: #ccc;"></i>
										</button>
									</span>
								</div>
							</div>
						</div>
					</form>
				</div>
				
				</td></tr>
				<c:forEach items="${productSpreadList}" var="ps" varStatus="i">
					<c:if test="${i.index%3==0 }">
					<tr class="table-tr">
					</c:if>
					<td style="float: ;margin: 0px;padding: 0px;" class="productSpreadPic" data-id="${ps.productSpreadRecordId }">
						<table>
							<tr>
								<td><img src="${ps.productSpreadPic }"/></td>
								<td class="table-word"><input type="text" value="${ps.productSpreadTitle }" onchange="changeProductSpreadTitle(this)"/></td>
							</tr>
						</table>
					</td>
					<c:if test="${(i.index+1)%3==0||i.index==productSpreadList.size() }">
					</tr>
					</c:if>
				</c:forEach>
			</table>
		</div>	
			<!-- <div style="text-align: center;padding: 10px 0">
				<button onclick="massProduceQrCodePic()" class="btn btn-default">群发</button>
			</div> -->
        </div>
			
    </div><!-- rightConten右边区域]] -->

    </div><!-- mainBody页面主体]] -->
	<!-- 等待加载 -->
	<div class="waiting"><i class="iconfont">&#xe62c;</i></div>
	<div class="shade"></div>
	<!-- 等待加载 -->
    <footer>
    </footer>
    <div class="tip"></div>
	<script>
		$(".selFile").change(function(){
			var url="<%=request.getContextPath()%>/file/uploadPersonQrCodPic";
			var formData = new FormData();
			formData.append("file", this.files[0]);
			var that=this;
			$.ajax({
				  url: url ,  
		          type: 'POST',  
		          data:formData, 
				  processData : false,  
		          contentType : false,  
		          success: function (data){ 
		        	  $(that).next().val(data.data);
		        	  $(that).parents(".imgdiv").find("img").attr("src",data.data);
		          },  
		          error: function (data){  
		          }  			
			});
		});
		
		function massProduceQrCodePic(){
			$(".waiting").show();
			$(".shade").show();
			var url="<%=request.getContextPath()%>/platform/massProductQrCode";
			$.ajax({
				  url: url ,  
		          type: 'POST',  
				  processData : false,  
		          contentType : false,  
		          success: function (data){ 
		  			$(".waiting").hide();
		  			$(".shade").hide();
		          },  
		          error: function (data){  
		  			$(".waiting").hide();
		  			$(".shade").hide();
			         alert("fail");
		          }  			
			});
		}
		
		function getProductSpreadRecordList(){
			var url="<%=request.getContextPath()%>/platform/productSpreadRecordList";
			var params={keyword:$("#keyword").val()};
			doAjax("GET",url,params,loadList,function(data){console.log("fail")},true,false);
		}
		
		function loadList(data){
			var html="";
			$("#searchTr").nextAll().remove();
			for(var i=0;i<data.length;i++){
				if(i%3==0)
					html+='<tr class="table-tr">';
				html+='<td data-id="'+data[i].productSpreadRecordId+'" class="productSpreadPic" style="float: ;margin: 0px;padding: 0px;">';
				html+='<table>';
				html+='<tr>';
				html+='<td><img src="'+data[i].productSpreadPic+'"/></td>';
				html+='<td class="table-word"><input type="text" value="'+(data[i].productSpreadTitle==null?'':data[i].productSpreadTitle)+'" onchange="changeProductSpreadTitle(this)"/></td>';
				html+='</tr>';
				html+='</table>';
				html+='</td>';
				if((i+1)%3==0||i==data.length-1)
					html+='</tr>';
			}
			$("#searchTr").after(html);
		}
		
		function changeProductSpreadTitle(obj){
			var url="<%=request.getContextPath()%>/platform/changeSpreadProductTitle";
			var params={productSpreadRecordId:$(obj).parents(".productSpreadPic").attr("data-id"),
					title:$(obj).val()};
			doAjax("GET",url,params,function(data){console.log(data)},function(data){console.log(data)},true,false);
		}
		
		$(document).on("dblclick",".productSpreadPic",function(){
			var url="<%=request.getContextPath()%>/platform/setSpreadProduct";
			var params={productSpreadRecordId:$(this).attr("data-id")};
			doAjax("GET",url,params,function(data){
				$(".imgdiv img").attr("src",data.data.productSpreadPic);
				$("textarea[name='content']").val(data.data.productSpreadText);
				$("input[name='title']").val(data.data.productSpreadTitle);
			},function(data){console.log(data)},true,false);
		});
	</script>
</body>
</html>
