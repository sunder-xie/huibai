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
<script charset="utf-8" src="js/userAddr.js"></script>

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
			<div class="tit">选择收货地址</div>
		</div>
	</div>
</header>
	<div class="container">
		
		<input id="ListTotal" value="" type="hidden">
		<div class="row mb10" id="address">
		
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

<div class="clear"></div>

<textarea id="addr" class="hide">
		<a href="javascript:chooseAddr('{addrId}')" class="list-group-item tip">
				<label class="addr-label"> 
				<span></span>
				</label>
				<div class="addr-info">
					<p class="addr-first">
	               		<span class="tel pull-right">联系电话：{tel}</span>
	                    <em class="addr-person">收货人：{name}</em>
	                </p>
					<p class="addr-second">收货地址：{address}</p>
				</div>
	    </a>
</textarea> 
</body>
</html>
