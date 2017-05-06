<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="yes" name="apple-touch-fullscreen">
<meta content="telephone=no" name="format-detection">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1,user-scalable=no;">
<%@ include file="../common/base.jsp" %>
<base href="<%=tBasePath%>"></base>
<title>客户端下载页</title>
<link rel="stylesheet" href="css/bootstrap.css?v=01291">
<link rel="stylesheet" href="css/style.css?v=1?v=01291">
<link rel="stylesheet" href="css/app.css?v=1?v=01291">
<script charset="utf-8" src="js/bootstrap.min.js?v=01291"></script>
<script charset="utf-8" src="js/global.js?v=01291"></script>
<script charset="utf-8" src="js/template.js?v=01291"></script>
</head>
<body>
<header class="header">
	<div class="fix_nav">
		<div class="nav_inner">
			<a class="nav-left back-icon" href="javascript:history.go(-1);">返回</a>
			<div class="tit">下载</div>
		</div>
	</div>
</header>

<div class="container" id="container">

	<div id="ajax_loading" style="width:300px;margin: 10px  auto 15px;text-align:center;display: none;">
 		<img src="images/loading.gif">
	</div>
	
	<div class="row">
		<div class="list-group-item red-bg">
			
			<div class="app-download-img">
				<img src="images/download.png"/>
			</div>
			
			<h2 class="font-center white">下载手机版乐汇百材</h2>
			
			<ul class="download">
				<li><a href="http://app.hbaicai.com/download/huibai.apk"><span class="white android"><em>android版请下载</em></span></a></li>
				<li><a ><span class="white iphone"><em>iPhone版开发中</em></span></a></li>
			</ul>
		</div>
	</div>
</div>
</body>
</html>