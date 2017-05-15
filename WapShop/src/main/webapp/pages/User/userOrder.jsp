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
<script charset="utf-8" src="js/userOrder.js"></script>

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

<title>我的订单</title>
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
			<div class="tit">我的订单</div>
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
					<form id="searchform" name="searchform" action=""
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
					<li id="default" class="active"><a
						href="javascript:void(0);">全部</a></li>
					<li id="waitbuy"><a
						href="javascript:void(0);">待付款
					</a></li>
					<li id="waitSend"><a 
						href="javascript:void(0);">待发货
					</a></li>
					<li id="waitRecv"><a 
						href="javascript:void(0);">待收货
					</a></li>
				</div>
			</ul>
		
		<input id="ListTotal" value="" type="hidden">
		<div id="container">
		</div>
		<div id="ajax_loading" style="width:300px;margin: 10px  auto 15px;text-align:center;display: none;">
			 <img src="images/loading.gif">
		</div>
		<div id="nodata" style="display: none;">
				<div class="notice-search">
					<div class="ns-wrap clearfix info">
						<div class="ns-content">
							<span>----------没有更多数据了！！----------</span>
						</div>
					</div>
				</div>
		</div>
		
		<form id="list_form" action="/m_search/prodlist" method="post">
				<input type="hidden" id="curPageNO" name="curPageNO" value="" /> 
				<input type="hidden" id="categoryId" name="categoryId" value="" />
				<input type="hidden" id="ord_sta" name="ord_sta" value="" />
				<input type="hidden" id="hasProd" name="hasProd" value="" />
				<input type="hidden" id="keyword" name="keyword" value="" />
				<input type="hidden" id="shopId" name="shopId" value="" /> 
				<input type="hidden" id="prop" name="prop" value="" />
			</form>
		</div>
</div>
	<textarea id="orderInfo" class="hide">  
		<ul class="list-group" id="{orderId}">
		            <li class="list-group-item clearfix">
		            	<div>
		                    <a href="{shopUrl}"><span class="gary">{shopNm} ></span></a>
		                	<em class="red pull-right">{status}</em>
		                </div>
		            </li>
		            
		            <li class="list-group-item clearfix">
		                <div class="pull-right mt5">
		                    <span class="gary">共{totalNum}件商品</span>
		                	<span class="gary">合计：</span>
		                	<em class="red productTotalPrice">¥{totalPrice}</em>
		                </div>
					</li>
					<li class="list-group-item clearfix">
		                <div class="pull-right mt5">{orderOption}</div>
					</li>
			</ul>
</textarea> 
<textarea id="goodsInfo" class="hide"> 
	<li class="list-group-item hproduct clearfix">
	     <a href="{orderUrl}">
         <div class="p-pic">
          	<img class="img-responsive" src="{imgUrl}">
         </div>
         <div class="p-info">
             	<p class="p-title">{goodsNm}</p>
            	<p class="p-attr">
             		<span>型号：{type}；</span></p>
            	<p class="p-origin">
                 <span class="gary pull-right">x{buyNum}</span>
                 <em class="price">¥{price}</em>
             </p>
         </div>
         </a>
    </li>
</textarea> 
<div class="clear"></div>

<jsp:include page="../common/index_footerbar.jsp" />
</body>
</html>
