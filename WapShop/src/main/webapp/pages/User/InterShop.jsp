<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="yes" name="apple-touch-fullscreen">
<meta content="telephone=no" name="format-detection">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1;user-scalable=no;">
<%@ include file="../common/base.jsp" %>
<base href="<%=tBasePath%>"></base>
<link rel="stylesheet" href="css/bootstrap.css?v=10.09">
<link rel="stylesheet" href="css/style.css?v=10.09">
<link rel="stylesheet" href="css/member.css?v=10.09">
<link rel="stylesheet" href="css/order3.css?v=10.09">
<link rel="stylesheet" href="css/app.css?v=10.09">

<script charset="utf-8" src="js/global.js?v=10.09"></script>
<script charset="utf-8" src="js/bootstrap.min.js?v=10.09"></script>
<script charset="utf-8" src="js/template.js?v=10.09"></script>
<script charset="utf-8" src="js/jquery.form.js?v=10.09"></script>
<script charset="utf-8" src="js/interestShop.js"></script>
<title>收藏店铺</title>
</head>
<body>
<div class="fanhui_cou">
	<div class="fanhui_1"></div>
	<div class="fanhui_ding">顶部</div>
</div>
<header class="header">
	<div class="fix_nav">
		<div class="nav_inner">
			<a class="nav-left back-icon" href="javascript:history.back();">返回</a>
			<div class="tit">关注店铺</div>
			<div class="sousuo" id="sousou"><img src="images/sou.png"></div>
		</div>
	</div>
</header>
	<div style="overflow: hidden; position: fixed; width: 100%; z-index: 10000; top: 0px;">
		<div class="order_top_count" style="display: none;">
			<div class="order_top">
				<div class="order_a_l">
					<div id="nav-left_ll">
						<img src="images/order_top_l.png">
					</div>
				</div>
				<div class="order_sou">
					<form id="searchform" name="searchform" action="/m_search/list"
						method="get">
						<input name="keyword" id="keyword" placeholder="搜索商品" type="text"
							value="1"> <span class="pro_sou" style="cursor: pointer;"
							onclick="searchproduct();"><img src="images/Search.png"></span>
						<div></div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="container" id="container2">
	<div class="row">
		<input id="ListTotal" value="" type="hidden">
		<div class="item-list" id="container" rel="2" status="0">
			
		</div>
		
		<div id="nodata" style="display: none;">
				<div class="notice-search">
					<div class="ns-wrap clearfix info">
						<div class="ns-content">
							<span>----------没有更多数据了！----------</span>
						</div>
					</div>
				</div>
		</div>
		
		<div id="ajax_loading" style="width:300px;margin: 10px  auto 15px;text-align:center;display: none;">
			 <img src="images/loading.gif">
		</div>
		
		<form id="list_form" action="/m_search/prodlist" method="post">
				<input type="hidden" id="curPageNO" name="curPageNO" value="" /> 
				<input type="hidden" id="categoryId" name="categoryId" value="" />
				<input type="hidden" id="orders" name="orders" value="" />
				<input type="hidden" id="hasProd" name="hasProd" value="" />
				<input type="hidden" id="keyword" name="keyword" value="" />
				<input type="hidden" id="shopId" name="shopId" value="" /> 
				<input type="hidden" id="prop" name="prop" value="" />
			</form>
		</div>
</div>
<div class="clear"></div>

<jsp:include page="../common/index_footerbar.jsp" />
</body>
</html>
