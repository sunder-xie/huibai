<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="yes" name="apple-touch-fullscreen">
<meta content="telephone=no" name="format-detection">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1,user-scalable=no;">
<%@ include file="../common/base.jsp" %>
<base href="<%=tBasePath%>"></base>
<title>分类</title>
<link rel="stylesheet" href="css/bootstrap.css?v=01291">
<link rel="stylesheet" href="css/style.css?v=1?v=01291">
<link rel="stylesheet" href="css/swiper-3.2.5.min.css">
<link rel="stylesheet" href="css/order3.css?v=01291">
<link rel="stylesheet" href="css/catagory.css?v=01291">

<script charset="utf-8" src="js/global.js?v=01291"></script>
<script charset="utf-8" src="js/bootstrap.min.js?v=01291"></script>
<script charset="utf-8" src="js/template.js?v=01291"></script>
<script charset="utf-8" src="js/category.js?v=01291"></script>
<script type="text/javascript" src="js/swiper-3.2.5.min.js"></script>
</head>
<body>
<header class="header">
	<div class="fix_nav">
		<div class="nav_inner">
			<a class="nav-left back-icon" href="javascript:history.go(-1);">返回</a>
			<div class="tit">分类</div>
		</div>
	</div>
</header>
<div class="fix-top-search">
	<div class="nav-serach-white">
		<div class="navbar-search left-search">
				<input type="text" placeholder="搜索商品" class="form-control" onclick="javascript:openSearch();"/>
		</div>
	</div>
</div>
<div id="sbox" style="display: none">
	<div class="nav-serach-white">
			<form id="searchform" name="searchform" action="" onsubmit="return false;">
				<div class="navbar-search left-search-white">
						<input type="search" id="searchKey" name="keyword" value="" placeholder="搜索商品" class="form-control"/>
				</div>
				<div class="nav-right-white">
					<a href="javascript:cancelSearch();"><span class="pull-right red mt5">取消</span></a>
				</div>
			</form>
	</div>
	
	<div class="container mb50">
		<div class="row mb10 search-keyword">
				<div class="list-group-item">
					最近搜索： <a><span class="pull-right opertion">删除</span></a>
				</div>
				<div class="list-group-item keyword-row">
					<ul class="tags">
						<li class="keyword"><a href="javascript:search('环氧')">环氧</a></li>
					</ul>
				</div>
				
				<div class="list-group-item">
					热门搜索： <a><span class="pull-right opertion">换一批</span></a>
				</div>
				<div class="list-group-item keyword-row">
				<ul class="tags">
						<li class="keyword"><a href="javascript:search('环氧')">环氧</a></li>
						<li class="keyword"><a href="javascript:search('固化剂')">固化剂</a></li>
					</ul>
				</div>
			</div>
	</div>	
</div>

<div class="container " id="container">
	<div class="row">
		<aside>
			<div class="menu-left scrollbar-none mb50" id="sidebar">
				<ul>
				</ul>
			</div>
		</aside>
		<div id="right-list">
		</div>
	</div>
</div>
<textarea id="List1" class="hide"> 
	<section class="menu-right padding-all j-content mb50" id="{classify}">
		<h5>{TopName}</h5>
		<ul></ul>
	</section>
</textarea> 

<textarea id="List2" class="hide"> 
	<li class="w-3"><a href="{url}"></a>
	<img src="{imgUrl}" /><span>{SecondNm}</span></li>
</textarea> 
<div class="clear"></div>

<jsp:include page="../common/index_footerbar.jsp" />
</body>
</html>