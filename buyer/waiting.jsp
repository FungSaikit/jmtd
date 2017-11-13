<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/common/font/iconfont.css">
<style>
	.waitingPanel{
		width:100%;
	    position: fixed;   
	    top: 40%;
	    display:none;
	    z-index:1003;
	}
	.waitingDiv {
	    text-align: center;
	    background-color: rgba(0,0,0,.5);
	    left: 0;
	    width: 100px;	
	    height: 100px;	
	    margin:0 auto;
	    vertical-align:center;
	}
	.waitingDiv>i {
	    color: #fff;
	    font-size: 50px;
	    width: 50px;
	    height: 50px;
	    -webkit-transform-origin: 50% 50%;
	    -moz-transform-origin: 50% 50%;
	    transform-origin: 50% 50%;
	}
	.waitingDiv>i {
	    display: inline-block;
	    top:25px;
	    position:relative;
	    animation: rotate 2s linear 0;
	    animation-iteration-count: infinite;
	    animation-play-state: running;
	    -webkit-animation: rotate 2s linear 0;
	    -webkit-animation-iteration-count: infinite;
	    -webkit-animation-play-state: running;
	}
	@keyframes rotate {
	  0%{
	    transform: rotate(0deg);
	    -webkit-transform: rotate(0deg);
	    -moz-transform: rotate(0deg);
	  }
	  100%{
	    transform: rotate(360deg);
	    -webkit-transform: rotate(360deg);
	    -moz-transform: rotate(360deg);
	  }
	}
	@-webkit-keyframes rotate {
	  0%{
	    transform: rotate(0deg);
	    -webkit-transform: rotate(0deg);
	    -moz-transform: rotate(0deg);
	  }
	  100%{
	    transform: rotate(360deg);
	    -webkit-transform: rotate(360deg);
	    -moz-transform: rotate(360deg);
	  }
	}
</style>

<div class="waitingPanel">
	<div class="waitingDiv"><i class="iconfont">&#xe605;</i><span></span></div>
</div>
<script>
	function showLoading(){
		document.getElementsByClassName("waitingPanel")[0].style.display="block";
	}
	
	function hideLoading(){
		document.getElementsByClassName("waitingPanel")[0].style.display="none";
	}
</script>