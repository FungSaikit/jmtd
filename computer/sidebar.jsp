<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<!DOCTYPE HTML>
<html>
  <head>
  </head>
  
  <body>
  			<!-- 12-26 -->
			<div class="tool" >
				<!-- <div class="tool-ul">
					<div class="tool-li">
						<span>个人中心</span>
						<i class="fa fa-home" onclick="skip('user/toUserInformation')"></i>
					</div>
				</div> -->
				<!-- <div class="tool-ul">
					<div class="tool-li">
						<span>发布需求</span>
						<i class="fa fa-pencil-square-o" onclick="skip('demand/goDemandAdd')"></i>
					</div>
				</div>
				<div class="tool-ul">
					<div class="tool-li">
						<span>上传产品</span>
						<i class="fa fa-cubes" onclick="skip1('product/goProductAdd?seriesId=0')"></i>
					</div>
				</div>
				<div class="tool-ul">
					<div class="tool-li sp">
						<span>补件服务</span>
						<i class="fa fa-gears"></i>
					</div>
				</div>
				<div class="supply" >
					<p>本站暂未开发补件服务的功能。</p>
				</div> -->
				<div class="tool-ul">
					<div class="tool-li weixinapp">
						<span>微信商城</span>
						<i class="fa fa-weixin"></i>
					</div>
				</div>
				<div class="dengapp">
					<img src="<%=request.getContextPath()%>/resources/index/image/scan.jpg" width="100%"/>
					<p>繁灯网公众号 </p>
				</div>
				<!-- <div class="tool-ul feedbackBtn">
					<div class="tool-li">
						<span>留言反馈</span>
						<i class="fa fa-envelope"></i>
					</div>
				</div> -->
				<div class="tool-ul goTop">
					<div class="tool-li">
						<span>回到顶部</span>
						<i class="fa fa-chevron-up"></i>
					</div>
				</div>
			</div>
			<!-- 12-26 -->
		
  </body>
  <script type="text/javascript">
		$(".fbSubm").click(function(){
			$(".fbForm :input, .fbArea").trigger("blur");
			var _warnN = $(".fbForm").find("span:visible").length;
			if(_warnN){
				return false;
			}else{
				$("#feedbackDialog").slideUp();
				$("#submitDialog, #fullBg").slideDown().delay(1500);
				$(".close").trigger("click");
				$(document).trigger("keyup");
				
				str=$("#frm").serialize();
				url="<%=request.getContextPath()%>/feedback/add?"+str;
				$.ajax({
					type:"post",
					url:url,
		    		success:function(data,status,jqXHR){
		    			$("#feedbackDialog").slideUp();
		    			$("#submitDialog, #fullBg").slideDown().delay(1500);
		    			$(".close").trigger("click");
		    			$(".fbForm :input, .fbArea").val("");
		    			$(document).trigger("keyup");
		    			$("#typeFB").val(0);
					}
				});
				return false;
			}
		});
		</script>
</html>
