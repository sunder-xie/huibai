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
<script charset="utf-8" src="js/searchGoods.js"></script>

<script type="text/javascript">	
		
</script>

<!-- fixes the bug Bootstrap 3 Modals and the iOS Virtual Keyboard -->
<script charset="utf-8">
$(document).ready(function(){
//iOS check...ugly but necessary
if( navigator.userAgent.match(/iPhone|iPad|iPod/i) ) {

    $('.modal').on('show.bs.modal', function() {

        // Position modal absolute and bump it down to the scrollPosition
        $(this)
            .css({
                position: 'absolute',
                marginTop: $(window).scrollTop() + 'px',
                bottom: 'auto'
            });

        // Position backdrop absolute and make it span the entire page
        //
        // Also dirty, but we need to tap into the backdrop after Boostrap 
        // positions it but before transitions finish.
        //
        setTimeout( function() {
            $('.modal-backdrop').css({
                position: 'absolute', 
                top: 0, 
                left: 0,
                width: '100%',
                height: Math.max(
                    document.body.scrollHeight, document.documentElement.scrollHeight,
                    document.body.offsetHeight, document.documentElement.offsetHeight,
                    document.body.clientHeight, document.documentElement.clientHeight
                ) + 'px'
            });
        }, 0);

    });

}
});
</script>

<title>商品列表</title>
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
			<div class="tit">产品列表</div>
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
		<ul class="mod-filter clearfix">
				<div class="white-bg_2 bb1">
					<li id="default" class="active"><a title="默认排序"
						href="javascript:void(0);">默认</a></li>
					<li id="buys"><a title="点击按销量从高到低排序"
						href="javascript:void(0);">销量 <i class='icon_sort'></i>
					</a></li>
					<li id="comments"><a title="点击按评论数从高到低排序"
						href="javascript:void(0);">评论数 <i class='icon_sort'></i>
					</a></li>
					<li id="cash"><a title="点击按价格从高到低排序"
						href="javascript:void(0);">价格 <i class='icon_sort'></i>
					</a></li>
				</div>
			</ul>
		
		<div class="item-list" id="container" rel="2" status="0">
			<input id="ListTotal" value="" type="hidden">
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

<script type="text/javascript">
	/*  var keyword='';
	 var rspCode = '${pager}';
	// alert(rspCode);
	 var data=$('#listdata').val();  
	alert(data); */
	// alert(data.rspCode);
	/*  var jsonObj =JSON.parse(data); //jsonObj就是一个json对象了。 
	 alert(jsonObj.rspCode); */
	/*  var jsonObj =eval('('+data+')');//jsonObj就是一个json对象了。 
	 alert(jsonObj.rspCode);
	 if(rspCode=='000000')
     { 
		var len = 1;
		 <a href="/views/660">
			<div class="hproduct clearfix" style="background:#fff;border-top:0px;">
				<div class="p-pic"><img style="max-height:100px;margin:auto;" class="img-responsive" src="/photoserver/images/0/2016/01/13/8a009458-f5df-407c-95ca-c2ee81bffbc2.jpg"></div>
				<div class="p-info">
					<p class="p-title">2015新款七匹狼男包 男士手包真皮软皮手拿包男商务大容量手抓包 </p>
					<p class="p-origin"><em class="price">¥239.00</em></p>
					<p class="mb0"><del class="old-price">¥479.00</del></p>
					</div>
			</div>
		</a> 
     }  */
	 
</script>
<div class="clear"></div>

<jsp:include page="../common/index_footerbar.jsp" />
</body>
</html>
