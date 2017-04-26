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
<title>乐汇百材-店铺信息</title>
<link rel="stylesheet" href="css/bootstrap.css?v=01291">
<link rel="stylesheet" href="css/style.css?v=1?v=01291">
<link rel="stylesheet" href="css/member.css?v=01291">
<link rel="stylesheet" href="css/order3.css?v=01291">

<script charset="utf-8" src="js/global.js?v=01291"></script>
<script charset="utf-8" src="js/bootstrap.min.js?v=01291"></script>
<script charset="utf-8" src="js/template.js?v=01291"></script>
<script charset="utf-8" src="js/TouchSlide.js?v=01291"></script>
<script charset="utf-8" src="js/shopInfo.js?v=01291"></script>

<style type="text/css">
.details_con li .tb-out-of-stock{
border: 1px dashed #bbb;
color:#bbb;
cursor: not-allowed;
}
.no-selected{
background: #ffe8e8 none repeat scroll 0 0;
border: 2px solid #be0106;
margin: -1px;
}
</style>
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
			<div class="tit">店铺首页</div>
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

<div class="container">
<div class="row">
    <div class="member_top member_top_1">
			<div class="member_top_bg">
				<img src="images/member_bg.png">
			</div>
			<div class="member_m_pic member_m_pic_1" id="shop-logo">
				<!-- <img class="img-circle" src="images/noavatar.png"> -->
			</div>
			<div class="member_m_z member_m_z_1">
				<div class="member_m_x" id="shop-nm"></div>
			</div>
			<div class="member_m_hy">
				<div class="member_m_hy_x" id="shop-type"></div>
			</div>
			<div class="member_m_r">
			     <a class="member_m_r_x"  onclick="addInterest(this);" href="javascript:void(0);" flag="0" id="guanzhu">关注店铺</a>
			</div>
	</div>
	
	<input id="ListTotal" value="" type="hidden">
	<div id="shopContent" class="shop-content white-bg">
            <div class="hd hd_fav">
                <ul>
                    <li class="on" id="index">店铺首页</li>
                    <li class="" id="all">全部宝贝</li>
                    <li class="" id="new">新品上架</li> 
                    <li class="" id="message">商家动态</li> 
                </ul>
            </div>
             <div class="bd">
				<ul>
					 <div class="white-bg">
					        <div id="slide"> 
					            <div class="hd">
					                <ul></ul>
					            </div>
					            <div class="bd">
					                <ul></ul>
					            </div>
					        </div>
					    </div>
					    
					    <div class="mt10 white-bg mb10">
								<h4 class="shop-tit text-center" >今日必抢</h4>
								<div class="shop-goods-arae" id="shop-goods-arae">
									<ul>
									<div id="ajax_loading_index" style="margin: 10px  auto 15px;text-align:center;"> 
							 			<img src="images/loading.gif" style="width: auto; display: block;  margin: auto;">
							 		</div>
									</ul>
								</div>
						</div> 
			 	</ul>
			 	<ul>
				 	<div>
				 		<ul class="mod-filter clearfix">
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
							</ul>
					</div>
					<div id="ajax_loading_all" style="margin: 10px  auto 15px;text-align:center;"> 
			 			<img src="images/loading.gif" style="width: auto; display: block;  margin: auto;">
			 		</div>
			 		<div class="shop-goods-arae" id="all-goods-arae">
						<ul>
						</ul>
					</div>
					<div id="allnodata" style="display: none;">
						<div class="notice-search">
							<div class="ns-wrap clearfix info">
								<div class="ns-content">
									<span>----------没有更多数据了！----------</span>
								</div>
							</div>
						</div>
					</div>
			 	</ul>
			 	<ul>
			 		<div id="ajax_loading_new" style="margin: 10px  auto 15px;text-align:center;"> 
			 			<img src="images/loading.gif" style="width: auto; display: block;  margin: auto;">
			 		</div>
			 		<div class="shop-goods-arae" id="new-goods-arae">
						<ul>
						</ul>
					</div>
					<div id="newnodata" style="display: none;">
						<div class="notice-search">
							<div class="ns-wrap clearfix info">
								<div class="ns-content">
									<span>----------没有更多数据了！----------</span>
								</div>
							</div>
						</div>
					</div>
			 	</ul>
			 	<ul>
			 		<div id="newnodata" class="mt10">
						<div class="notice-search">
							<div class="ns-wrap clearfix info">
								<div class="ns-content">
									<span>----------暂无动态！----------</span>
								</div>
							</div>
						</div>
					</div>
			 	</ul>
			</div> 
	</div>
	
   
		
	<form id="list_form" >
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
<textarea id="goodsInfo" class="hide"> 
		<li>
			<div class="s-g-pic" style="height:{heigth}px">
	                <a href="{goodsUrl}">
	                	<img src="{imgUrl}">
	                </a>
                </div>
               <div class="s-g-info" >
                   <a href="{goodsUrl}">
                   	<p class="p-title">{goodsNm}</p>
                   </a>
                  	<p class="p-origin">
                       <em class="price">¥{price}</em>
                   </p>
               </div>
		</li>
</textarea> 
<div class="clear"></div>
<jsp:include page="../common/index_footerbar.jsp" />
</body>
</html>
