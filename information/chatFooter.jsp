	<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="<%=request.getContextPath() %>/resources/common/zepto.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/swiper.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/touch.js"></script>
<script src="<%=request.getContextPath() %>/resources/interactive.js"></script>
<script src="<%=request.getContextPath() %>/resources/common/jweixin-1.0.0.js"></script>

<!--[[底部-->
<div class="footer">
	<ul>
		<li <c:if test="${active==0 }">class="active"</c:if>>
			<a href="<%=request.getContextPath()%>/information/informationList">
				<p class="badge"><i class="iconfont icon-xiaoxi"></i><span></span></p>
				<p>消息</p>
			</a>
		</li>
		<li <c:if test="${active==1 }">class="active"</c:if>>
			<a href="<%=request.getContextPath()%>/information/lowUserList">
				<i class="iconfont icon-tianjia01"></i>
				<p>客户列表</p>
			</a>
		</li>
		<li <c:if test="${active==2 }">class="active"</c:if>>
			<a href="<%=request.getContextPath()%>/information/setting">
				<i class="iconfont icon-shezhi"></i>
				<p>设置</p>
			</a>
		</li>
		<li>
			<a href="<%=request.getContextPath()%>/buyer/index">
				<i class="iconfont icon-wangzhan"></i>
				<p>商城首页</p>
			</a>
		</li>
	</ul>
</div>
<!-- 等待加载 -->
<div class="waiting"><i class="iconfont">&#xe602;</i></div>
<div class="shade"></div>
<!--提示框 -->
<div class="tip"></div>
<script>

	$(".fa").tap(function(){
		window.location.href=$(this).attr("data-href");
	});
	
	function showTip(content){
		$(".tip").html(content);
		$(".tip").css("opacity","0.8");
		setTimeout(function(){
			$(".tip").html("");
			$(".tip").css("opacity","0");
		},1000);
	}
	
	function countNewInfoNumber(){
		var url="<%=request.getContextPath()%>/information/countNewInfoNumber";
		var params = {};
		doAjax("GET",url,params,countSuccess,fail,true,false);
	}
	
	function countSuccess(data){
		if(data.data>0){
			$(".footer .badge span").html(data.data);
			$(".footer .badge span").show();
		}else{
			$(".footer .badge span").hide();
		}
	}
	function showTip(content,func){
		$(".tip").html(content);
		$(".tip").css("opacity","0.8");
		setTimeout(function(){
			$(".tip").html("");
			$(".tip").css("opacity","0");
			func();
		},1000);
	}
</script>
<!--底部]]-->
<script src="<%=request.getContextPath()%>/resources/common/count.js"></script>
