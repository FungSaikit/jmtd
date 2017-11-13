<%@ page language="java" import="java.util.*,java.text.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!doctype html>
<html>

	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width,height=device-height, initial-scale=1.0,maximum-scale=1.0, user-scalable=no" />

		<title>佐为照明</title>

		<!-- mobile_desktop icon --><%-- 
		<link rel="app-touch-icon" href="../image/79灯Logo.jpg" />
		<link rel="icon" href="<%=request.getContextPath() %>/resources/index/image/79icon.jpg"> --%>
		<link href="<%=request.getContextPath() %>/resources/common/swiper.min.css" rel="stylesheet">
		<!-- 样式文件 -->
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/customer/assets/css/upload.css" />
		<style>
			.wrapper  .tip{
				display:none;
				background-color:#fff;
			}
			html{
				background-color:#fff;
			}
		</style>
	</head>

	<body>
		 <%
		     String date=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	     %>
		<header class="header">
			<button class="navBtn prevBtn icon-cross-circle" id="prevPage"><!-- <i class="iconfont">&#xe63a;</i> -->退出</button>
			<h1 class="hTitle" id="hTitle">发布需求</h1>
			<button class="navBtn nextBtn"  id="nextPage">下一步</button>
		</header>
		
		<form action="<%=request.getContextPath()%>/demand/addDemand" method="post"  enctype="multipart/form-data" id="frm">
		<input type="hidden" name="legalPersonName"/>
		<input type="hidden" name="phoneNumber"/>
		<div class="swiper-container wrapper wrapper3" id="container">
			<div class="swiper-wrapper page0  ">
				<!-- 说明页 -->
				<!-- <div class="swiper-slide protocal ">
					<div class="page_title">说明</div>
					<div class="show_protocal">
						所上传的数据必须属实，但凡发现有人通过恶意上传数据扰乱站点秩序的行为，我们将注销该账号以识惩戒，情节严重者将移送法办。 </div>
					<button class="lgBtn" id="agreeBtn" type="button">我同意</button>
				</div> -->

				<!-- 基本参数页 -->
				<div class="swiper-slide page page1 swiper-no-swiping">
					<div class="reg_content">
						<div><span class="intro">说明：上传的第一张图作为需求的封面图片</span></div>
						<div class="pageWrapper1">
							<div class="upload_imgDiv" id="imgDiv">
								<div class="imgDiv">
									<img src="" alt="" />
									<span class='icon-cross closeStyle'></span>
									<span class="icon-plus addImgIcon"><i class="iconfont">&#xe628;</i></span>
								</div>
							</div>
							<p class="tip">
								<!-- <span class="icon-circle-cross"></span> 请至少上传一张图片作为封面图 -->
							</p>
						</div>
					</div>

					<!-- 全屏显示图片 -->
				
				</div>

				<!-- 筛选参数页 -->
				<div class="swiper-slide page page2 swiper-no-swiping">
					<div class="reg_content">
						<div class="pageWrapper">
							<div>
								<label><b>*</b>标题：</label>
								<div>
									<input type="text" class="form-control" name="demandName"/>
									<span class="icon-circle-check"></span>
									<p class="tip" typeName="标题">
										<!-- <span class="icon-circle-cross"></span> 请填写需求名 -->
									</p>
								</div>
							</div>
							<div>
								<label><b></b>价格区间：</label>
								<div>
									<input type="tel" class="form-control jg_down" name="demandPriceDown" placeholder="请输入数字" style="width:48%"/> -
									<input type="tel" class="form-control jg_up" name="demandPriceUp" placeholder="请输入数字"  style="width:47%"/>
									<!-- <span class="icon-circle-check"></span>
									<p class="tip" typeName="价格区间">
										<span class="icon-circle-cross"></span> 价格最多两位小数,左小右大
									</p> -->
								</div>
							</div>
							<div>
								<label><b>*</b>需求量：</label>
								<div>
									<input type="tel" class="form-control kucun" placeholder="请输入数字" name="demandNumber" class="kucun" />
									<span class="icon-circle-check"></span>
									<p class="tip" typeName="需求量">
										<!-- <span class="icon-circle-cross"></span> 请填写需求量,必须为整数，不小于1。 -->
									</p>
								</div>
							</div>
							<div>
								<label><b>*</b>截止日期：</label>
								<div>
									<input type="date" class="form-control riqi" name="dateTime" />
									<span class="icon-circle-check"></span>
									<p class="tip" typeName="截止日期">
										<!-- <span class="icon-circle-cross"></span>请输入一个未来时间作为截止日期 -->
									</p>
								</div>
							</div>
							<div>
								<label><!-- <b>*</b> -->需求描述：</label>
								<div>
									<textarea rows="5" class="form-control" name="demandContent"></textarea>
									<span class="icon-circle-check"></span>
									<!-- <p class="tip" typeName="需求描述">
										<span class="icon-circle-cross"></span> 请填写需求描述
									</p> -->
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- 附加参数页 -->
				<div class="swiper-slide page page3 swiper-no-swiping">
					<div class="reg_content">
						<div class="pageWrapper">
							<div>
								<label><b>*</b>类别：</label>
								<div>
									<select id="type" name="demandType" onchange="updateProperty();updateStyle()" class="form-control">
										<option value="">请选择</option>
											<c:forEach items="${typeList}" varStatus="st" var="l">
										<option value="${l.propertyValueId }">${l.propertyValue }</option>
										</c:forEach>
									</select>
									<span class="icon-circle-check"></span>
									<p class="tip" typeName="类别">
										<!-- <span class="icon-circle-cross"></span> 请选择类别 -->
									</p>
								</div>
							</div>
							<div id="styleDiv">
								<label><b>*</b>风格：</label>
								<div>
									<select class="form-control spec_select" name="demandStyle" >
									    <option value="">--请选择--</option>
										<c:forEach items="${styleList }" varStatus="st" var="s">
											<option value="${s.propertyValueId}">${s.propertyValue}</option>					
										</c:forEach>
									</select>
									<span class="icon-circle-check"></span>
									<p class="tip" typeName="风格">
										<!-- <span class="icon-circle-cross"></span> 请选择一种风格 -->
									</p>
								</div>
							</div>
							<div class="checkArea">
								<label><b>*</b>材质：</label>
								<div>
									<input type="text" id="material_input" value="--请选择1~3种材质--" class="form-control style_select" readonly/>
									<input type="hidden" id="material_input2" class="form-control style_select" name="demandMaterial"/>							
									<span class="icon-circle-check"></span>
									<p class="tip checkbox_tip" typeName="材质">
										<!-- <span class="icon-circle-cross"></span> 请选择1~3种材质 -->
									</p>
								</div>
							</div>
							<div class="checkArea">
								<label><b>*</b>适用空间：</label>
								<div>
									<input type="text" value="--请选择1~3种适用空间--" id="suit_input" readonly class="form-control"/>
									<input type="hidden" value="" id="suit_input2" readonly class="form-control" name="demandSpace"/>
									<span class="icon-circle-check"></span>
									<p class="tip" typeName="适用空间">
										<!-- <span class="icon-circle-cross"></span> 请选择1~3种适用空间 -->
									</p>
								</div>
							</div>
							<!-- <div>
								<label>品牌：</label>
								<div>
									<input type="text" class="form-control" name="brand"/>
								</div>
							</div> -->
						</div>
					</div>
				</div>

				<!-- 上传图片 -->
				<div class="swiper-slide page4 swiper-no-swiping">
					<div class="reg_content">
						<div class="pageWrapper">
							<!-- <div>
								<label>型号：</label>
								<div>
									<input type="text" class="form-control" name="demandCode" id="demandCode"/>
								</div>
							</div> -->
							<div>
								<label>颜色：</label>
								<div>
									<input type="text" class="form-control" name="demandColor"/>
								</div>
							</div>
							<div>
								<label>尺寸：</label>
								<div>
									<input name="demandLength" type="tel" class="form-control size_text size_text1 length" placeholder="长(cm)"/>
									<input name="demandWidth" type="tel" class="form-control size_text size_text2 width" placeholder="宽(cm)"/>
									<input name="demandHeight" type="tel" class="form-control height_text height" placeholder="高(cm)" />
									<input name="demandDiameter" type="tel" class="form-control size_text size_text1 diameter" placeholder="直径(cm)" />
									<input type="tel" class="form-control size_text size_text2 weight" placeholder="重量(kg)" />
									<input type="hidden" name="demandFormat" id="productFormat"/>
									<font style="color:red">请输入数字</font>
								</div>
							</div>
						</div>
						<div class="pageWrapper" id="property"></div>
					</div>
				</div>				
			</div>			
		</div>
		</form>
		<!-- end wrapper -->
		
		<!-- 图片全屏查看 -->
		<div class="swiper-container" id="fullscreen_container">
			<header class="full_screen_header">
				<span class="icon-chevron-left fl full_screen_back"></span>
				<p>3/4</p>
				<span class="icon-trash-o fr" id="imgDel"></span>
			</header>
			<div class="swiper-wrapper" id="fullscreen_wrapper">
					
				
			</div>
		</div>
		
		<!-- 等待加载 -->
		<div class="shade load_shade" id="load_shade">
			<div class="load_block">
				<span class="icon-spinner6 icon_load"></span>
				<span>需求上传中...</span>
			</div>
		</div>
		
		<div class="multi-shade" id="material_shade">
			<div class="multi-menu" >
				<div class="multi-btn">
					<button id="btn1">确定</button>
				</div>
				<div class="multi-wrap">
					<c:forEach items="${materialList}" varStatus="st" var="ml">
						<p data-id="${ml.propertyValueId}"><span class="ckbox"></span>${ml.propertyValue}</p>
					</c:forEach>
				</div>
			</div>
		</div>
		<div class="multi-shade" id="suit_shade">
			<div class="multi-menu" >
				<div class="multi-btn">
					<button id="btn2">确定</button>
				</div>
				<div class="multi-wrap">
					<c:forEach items="${spaceList }" varStatus="st" var="sl">
						<p data-id="${sl.propertyValueId}"><span class="ckbox"></span>${sl.propertyValue}</p>						
					</c:forEach>
				</div>
			</div>
		</div>
		
		<div class="black_pop" id="warn"></div>		
		
		<!-- confirm弹出框 -->
		<div class="shade full_shade" id="reminder_shade">
			<div class="pop_box reminder">
				<header class="reminder_header">
					<span>警告</span><span class="pop_close icon-cross cancel_reminder"></span>
				</header>
				<div class="reminder_content">
					
				</div>
				<div class="reminder_buttons">
					<button class="cancel_reminder">取消</button>
					<button class="sure_reminder">确定</button>
				</div>
			</div>
		</div>
		<!-- 信息输入框 -->
		<div class="shade full_shade" id="information_shade">
			<div class="pop_box reminder">
				<header class="reminder_header">
					<span>输入联系方式</span><span class="pop_close icon-cross cancel_reminder"></span>
				</header>
				<div class="reminder_content">
					<input type="text" placeHolder="输入联系人" id="legalPersonName" style="border:1px solid #B2B2B2;margin-bottom:10px"/>
					<input type="text" placeHolder="输入电话" id="phoneNumber" style="border:1px solid #B2B2B2;"/>
				</div>
				<div class="reminder_buttons">
					<button class="" id="sureBtn">确定</button>
				</div>
			</div>
		</div>

		<!-- 屏幕遮罩 -->
		<div class="shade" id="home_shade"></div>
		<div class="black_pop" id="warn"></div>

		<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
		<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
		<script src="<%=request.getContextPath() %>/resources/common/fx.js"></script>
		<script src="<%=request.getContextPath() %>/resources/common/fx_methods.js"></script>
		
		<!-- 表单验证需要用到 -->
		<script src="<%=request.getContextPath() %>/resources/common/selector.js"></script>

		<!-- swiper -->
		<script src="<%=request.getContextPath() %>/resources/common/swiper.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resources/customer/assets/js/upload.js"></script>
		<c:if test="${!empty noPhone }">
		<script>
			$('#information_shade').show();
			
			$("#sureBtn").tap(function(){
				$('#information_shade').hide();
				$("input[name='phoneNumber']").val($("#phoneNumber").val());
				$("input[name='legalPersonName']").val($("#legalPersonName").val());
			});
		</script>
		</c:if>
		<script>
			// 同意按钮
			$('#agreeBtn').tap(function(){ 
				toNext();
			})
			// 下一步按钮
			$('#nextPage').tap(function(){
				if(mySwiper.activeIndex ==0 ) {
					// 第2页的验证
					testImg();
					var warmLen = $(".page1").find(".tip:visible").length;
					if( !warmLen ){
						//上传图片的ajax代码
						toNext();
					}else{
						setTimeout(function(){
							$("#warn").html("至少上传一张需求图片");
							$("#warn").fadeIn('fast');
						},500);
						setTimeout(function(){
							$("#warn").fadeOut();
						},2000);
					} 
				}else if(mySwiper.activeIndex ==1 ) {	
					// 第3页的验证
					$('.page2 input,.page2 textarea').trigger('keyup');
					$('.page2 input,.page2 textarea').trigger('change');
					check($(".page2"));
				}else if(mySwiper.activeIndex ==2 ) {
					// 第4页的验证
					$('.page3 select.spec_select').trigger('change');
					$('#material_input,#suit_input').trigger('testCheckbox');
					if($("#type").val()==""){
						$("#type").siblings(".tip").show();
						$("#type").siblings(".icon-circle-check").hide();
					}
					/* if($("input[name='brand']").val().trim()==''){
						$("input[name='brand']").val("无");
					} */
					var flag=check($(".page3"));
					if(flag){
						$("#frm").submit();
						$("#load_shade").show();
					}
				}else if(mySwiper.activeIndex == 3 ) {
					// 第5页的验证
					$('.page4 input').each(function(index){
						if($(this).val().trim()=='' && !$(this).is(".height_text") && !$(this).is(".size_text"))
							$(this).val("无");
					});
					
					var str="";
					if($.trim($(".length").val())!="")
						str+="*长"+$(".length").val();
					if($.trim($(".width").val())!="")
						str+="*宽"+$(".width").val();
					if($.trim($(".height").val())!="")
						str+="*高"+$(".height").val();
					if($.trim($(".diameter").val())!="")
						str+=" 直径:"+$(".diameter").val()+"cm";
					if($.trim($(".weight").val())!="")
						str+=" 重量:"+$(".weight").val()+"kg";
					$('.page4 input[name="demandFormat"]').val(str.substring(1));
					if(str=="")
						$('.page4 input[name="demandFormat"]').val("无");
					
				}
			});
			// 表单验证是否通过
			function check(obj) {
				var warn=obj.find(".tip:visible");
				var warmLen = warn.length;
				if( warmLen ){
					setTimeout(function(){
						$("#warn").html(warn.eq(0).attr("typeName")+"输入不正确")
						$("#warn").fadeIn('fast');
					},500);
					setTimeout(function(){
						$("#warn").fadeOut();
					},2000);
					return false;
				}else {
					// 滑动到下一页
					if(obj.hasClass("page3"))
						return true;
					else
						toNext();
				}
			}
	
			// 上一步按钮
			$('#prevPage').tap(function(){
				if( mySwiper.isBeginning ) {
					$('#reminder_shade').find('.reminder_content').text("确定要退出发布需求么？");
					$('#reminder_shade').show();
				}
				toPrev();
			});
	
			function sure_reminder(){
				window.location.href="<%=request.getContextPath()%>/demand/demandList";
			}
			
			function updateProperty()
		    {
		    	var type=document.getElementById("type").value;
		    	if(type==''){
					document.getElementById("property").innerHTML='';
					$("#type").siblings(".tip").show();
					$("#type").siblings(".icon-circle-check").hide();
				}else
					{
						$("#type").siblings(".tip").hide();
						$("#type").siblings(".icon-circle-check").show();
						var urlStr='<%=request.getContextPath()%>/product/updateProperty/'+type;
						$.ajax({
							method:'POST',
							url:urlStr,
							success:function(data,status,jqXHR)
							{
								str="";
								var str1="<option value='无'>--请选择--</option><option>LED</option><option>E27</option><option>E14</option><option>GU10</option>"
									+"<option>MR16</option><option>G4</option><option>G9</option><option>E40</option>";
								for(var i=0;i<data.length;i++)	
									if(data[i].propertyValue=="光源数量")
										str+="<div><label>"+data[i].propertyValue+"：</label><div><input type='tel' class='form-control' name='property'/></div></div></div>";
									else if(data[i].propertyValue="光源类型")
										str+="<div><label>"+data[i].propertyValue+"：</label><div><select class='form-control spec_select' name='property'>"+str1+"</select></div></div></div>";
									else	
										str+="<div><label>"+data[i].propertyValue+"：</label><div><input type='text' class='form-control' name='property'/></div></div></div>"
								
								$("#property").html(str);
					
							}
						});
				  }
		    }
			
			var preType="吊灯";
			function updateStyle(){
				type=$("#type").find("option:selected").text();
				//alert(type);
				if(preType!=type && (((type!='户外照明'||type!='照明光源'||type!='开关插座'||type!='其他')&&(preType=='户外照明'||preType=='照明光源'||preType=='开关插座'||preType=='其他'))
						|| ((type=='户外照明'||type=='照明光源'||type=='开关插座'||type=='其他')&&(preType!='户外照明'||preType!='照明光源'||preType!='开关插座'||preType!='其他')))){				
					preType=type;
					var urlStr="<%=request.getContextPath()%>/search/changeSelectStyle?type="+type;
					//alert(urlStr);
					$.ajax({
						url:urlStr,
						method:"post",
						success:function(data,status,jqXHR){
						
							var html="<tbody>";
							var div = $("#styleDiv");
							if(type=="开关插座" || type=="其他"){
								div.css("display","none");
							}else{
								html+="<option value=''>--请选择--</option>";
								div.css("display","inline-block");
							}
							for(var i=0;i<data.length;i++){
								html+="<option value='"+data[i].propertyValueId+"'>"+data[i].propertyValue+"</option>";
							}
								
							div.find("select").html(html);
							
						}
					});
				}
			}
			
			var failImg;
			var localIds;
			var imageIndex;
			var imgLength;
			function chooseImg(leftImgNum) {
				failImg="";
				imageIndex=0;
				<%--测试时去掉--%>
				$("#load_shade").find("span").eq(1).html("请稍候...");
				$("#load_shade").show();

				 var urlStr = "<%=request.getContextPath()%>/wechat/signature?url="+location.href.split('#')[0];
				//alert("Before Call:"+urlStr);
				$.ajax({
					method: "GET",
					url: urlStr,
					success:function(data,status,jqXHR){
						//alert(data.appId+","+data.signature+","+data.timeStamp+","+data.nonceStr);
						var result=data;
						var appId=result.appId;
						var signature = result.signature;
						var timeStamp = result.timeStamp;
					    var nonceStr = result.nonceStr;		 
					    
					    wx.config({
					        debug: false,// 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
					        appId: appId, // 必填，公众号的唯一标识
					        timestamp:timeStamp , // 必填，生成签名的时间戳
					        nonceStr: nonceStr, // 必填，生成签名的随机串
					        signature: signature,// 必填，签名，见附录1
					        jsApiList: ['chooseImage','uploadImage'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
					    });
					    wx.error(function(res){
	//				        config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。
	// 						var urlStr = "<%=request.getContextPath()%>/wechat/getJspTicket";
	// 						$.ajax({
	// 							method: "GET",
	// 							url: urlStr,
	// 							success:function(data,status,jqXHR){
	//								alert(data.appId+","+data.signature+","+data.timeStamp+","+data.nonceStr);
	// 								chooseImg(leftImgNum);
	// 								return"";
	// 							}    
	// 						});	    
					    });
					    wx.ready(function(){
					    	$("#load_shade").hide();
					        // config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行
							//。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
					    	wx.chooseImage({
					    	    count: 6-parseInt(leftImgNum), // 默认9
					    	    sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
					    	    sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
					    	    success: function (res) {
					    	    	localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
					    	        count=localIds.length;
					    	        imgLength=localIds.length;
					    	        chooseUpload();
					    	    
					    	    }
					    	});
					    });
					} 
				}); // end ajax
				
				function chooseUpload(){
					var image = $("<img />");
		        	
		        	var div = $("<div class='imgDiv'></div>");
		        	var input = $("<input type='hidden' name='fileId' class='imgInput'>");
		        	
		        	image.appendTo(div);
		        	input.appendTo(div);
		        	
		        	
					$(".addImgIcon").parent().before(div);
					
					getImageWidth(image,localIds[imageIndex]);
					
					var fullImage="<div class='swiper-slide fullscreen_slide'><img src='"+localIds[imageIndex]+"'/></div>";
					fullscreenSwiper.appendSlide(fullImage);
					
					var index = $(".imgDiv img").index(image); 
					uploadImg(image,localIds[imageIndex],index); 
					
			        if($(".imgInput").length==6)
			        	$(".addImgIcon").parent().hide();
				}
				
				function uploadImg(image,localIds,index){
					 
		        	 wx.uploadImage({
		        		 localId: localIds, // 需要上传的图片的本地ID，由chooseImage接口获得
		        		 isShowProgressTips: 1, // 默认为1，显示进度提示
		        		 success: function(res) {
		        		 //返回图片的服务器端ID res.serverId,然后调用wxImgCallback函数进行下载图片操作
		        			image.next().val(res.serverId);
		        		 	count--;
		        		 	imageIndex++;
		        		 	if(imageIndex<imgLength)
		        		 		chooseUpload();
		        		 			 	
		        		 	if(count==0){
		        		 		if(failImg!=""){	 			
		        		 			$("#uploadSpan").html("上传完成,第"+failImg.substring(0,failImg.length-1)+"张图片上传失败");
			        		 		$("#uploadSpan").show();
			        		 		setTimeout(function(){
			        		 			$("#upload_shade").hide();
			        		 		},1500);
		        		 		}	
		        		 	}	
		        		 },
	   	        		 fail: function(res) {      			
	   	        		 	image.parent().remove();
	   	        			fullscreenSwiper.removeSlide(index);
	   	        			
		 	 				faileImg=(index+1)+",";
		 	 				count--;
		 	 				imageIndex++;
		 	 				if(imageIndex<imgLength)
		        		 		chooseUpload();
		 	 				
		 	 				if(count==0){
		        		 		if(failImg!=""){	
		        		 			$("#uploadSpan").html("上传完成,第"+failImg.substring(0,failImg.length-1)+"张图片上传失败");
		        		 			$("#uploadSpan").show();
			        		 		setTimeout(function(){
			        		 			$("#upload_shade").hide();
			        		 		},1500);
		        		 		}	
		        		 	}	
	   	        		 }
		        	});
				}
			}
		
		</script>
	<script src="<%=request.getContextPath() %>/resources/common/jweixin-1.0.0.js"></script>
	</body>
</html>
