<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<!DOCTYPE HTML>
<html>
  <head>
  <style>
  	.icon-text .b{
		    display: block;
		    font-size: 15px;
		    font-weight: 600;
		    margin-bottom: 4px;
		    margin-bottom: 10px
  	}
  	.icon-text p{
  			padding-bottom: 10px;
  	}
  	.icon-06 .iconimg{
		    width: 110px;
		    text-align: center;
		    margin-left: 45px;
  	}
  	.icon-01 {padding-left: 95px;}
  </style>
  </head>
  
  <body>
    <!--footer-->
		<div class="btm">
			<div class="icon-area md clear">
				<div class="icon-gp icon-01 fl">
					<!-- <div class="icon"></div> -->
					<div class="icon-text">
						<p class="b">联系电话</p>
						<p>18933441929</p>
						<p>0760-89839330</p>
						<p>座机服务：09:00 - 22:00</p>
						<!-- <p>手机上班时间：欢迎随时来电</p> -->
					</div>
				</div>
				<div class="icon-gp icon-02 fl">
					<!-- <div class="icon"></div> -->
					<div class="icon-text">
						<p class="b">微信</p>
						<p>18923318554</p>
						<p>18933441929</p>
						<p>手把手教你进驻</p>
					</div>
				</div>
				<div class="icon-gp icon-03 fl">
					<!-- <div class="icon"></div> -->
					<div class="icon-text">
						<p class="b">QQ</p>
						<p>215951213</p>
						<p>297411183</p>
						<p>建议使用微信联系</p>
						<!-- <p>QQ回复可能会有点延迟哦！</p> -->
					</div>
				</div>
				<div class="icon-gp icon-04 fl">
					<!-- <div class="icon"></div> -->
					<div class="icon-text">
						<p class="b">合作伙伴</p>
						<p>鹰皇灯饰</p>
						<p>银泉酒店</p>
					</div>
				</div>
				<div class="icon-gp icon-06 fl">
					<!-- <div class="icon"></div> -->
					<div class="icon-text">
						<p class="b">扫码关注公众号</p>
						<p class="iconimg"><img src="<%=request.getContextPath() %>/resources/index/image/scan.jpg" width="100%"/></p>
					</div>
				</div>
			</div>
			<div class="copyright">
				<p>Copyright © 中山市伙丁网络科技有限公司 All Rights Reserved 粤ICP备16001343号-2</p>
				<!-- <p><a href="javascript:void(0)">粤ICP备16001343号-1</a> 许可证：粤ICP备16001343号</p> -->
			</div>
		</div>
		
		<!--contact & tool-->
		<div class="contact clear">
			<div class="contact-l fl">
				<p><i class="fa fa-phone"></i>联系我们</p>
			</div>
			<div class="contact-r fl">
				<ul>
					<li>
						<span>客服电话：</span>
						<p>18933441929</p>
					</li>
					<li>
						<span>服务时间：</span>
						<p>周一至周五&nbsp;9:00-19:30<br />
							周六至周日&nbsp;9:00-18:00</p></li>
					<li> 
						<span>客服QQ：</span>
						<p>297411183</spanp>
					</li>
					<li>
						<span>微信公众号：</span>
						<div>
							<img src="<%=request.getContextPath()%>/resources/index/image/scan.jpg" width="100%" alt=""/>
						</div>
					</li>
				</ul>
			</div>
		</div>
		<div id="fullBg"></div>
		<div id="feedbackDialog" class="dialog">
			<form action="<%=request.getContextPath()%>/feedback/add" method="POST" id="frm2" class="fbForm">
				<div class="feedback">
					<h2>我要留言(<b class="fbCount"></b>/<b class="fbMax"></b>)</h2>
					<div class="feedbackInput feedbackArea">
						<textarea class="fbArea" id="content2" name="content"></textarea>
						<span class="fbWarn">请填写您的留言。</span>
						<span class="fbMuch">字数超过限制，请重新编辑。</span>
					</div>
					<div class="feedbackInput clear">
						<label class="fl">您的姓名：</label><input type="text" class="fbName fl" id="name" name="name"/>
						<span class="fbWarn">请填写您的姓名，如：张三、李小姐。</span>
					</div>
					<div class="feedbackInput clear">
						<label class="fl">联系方式：</label>
						<select class="fbSelt fl" id="typeFB" name="type">
							<option value="0">手机号</option>
							<option value="1">QQ号</option>
							<option value="2">微信号</option>
						</select>
						<input type="text" class="fbFind fl" id="wayFB" name="way" />
						<span class="fbWarn">请填写您的联系方式。</span>
						<span class="fbPhno">请填写正确的手机号。</span>
					</div>
				</div>

			</form>
							<button type="submit" class="fbSubm">提交</button>
			<span class="close fa fa-close"></span>
		</div>
		<div id="submitDialog">
			<div class="fbSucs">
				<h1>提交成功！感谢您的留言！</h1>
				<span>该窗口将在2秒后自动关闭……</span>
			</div>
		</div>
		
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
				
				str=$("#frm2").serialize();
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