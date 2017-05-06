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
<meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1,user-scalable=no;">
<%@ include file="../common/base.jsp" %>
<base href="<%=tBasePath%>"></base>
<title>乐汇百材-商品信息</title>
<link rel="stylesheet" href="css/bootstrap.css?v=01291">
<link rel="stylesheet" href="css/style.css?v=1?v=01291">
<link rel="stylesheet" href="css/member.css?v=01291">
<link rel="stylesheet" href="css/order3.css?v=01291">
<link rel="stylesheet" href="css/productDetail.css?v=01291">

<script charset="utf-8" src="js/global.js?v=01291"></script>
<script charset="utf-8" src="js/bootstrap.min.js?v=01291"></script>
<script charset="utf-8" src="js/template.js?v=01291"></script>
<script charset="utf-8" src="js/TouchSlide.js?v=01291"></script>
<script charset="utf-8" src="js/prodDetail.js"></script>

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
			<div class="tit">商品详细</div>
		</div>
	</div>
</header>
<input id="prodId" value="" type="hidden" />
<input id="currSkuId" value="" type="hidden"/>
<div class="container">
    <div class="row white-bg">
        <div id="slide"> 
            <div class="hd">
                <ul></ul>
            </div>
            <div class="bd">
                <ul></ul>
            </div>
        </div>
    </div>
    <div class="row gary-bg">
         <div class="white-bg p10 details_con">
         	<h2 id="prodName"></h1>
         	<ul>
         			<li>
         			<span class="price">¥<span class="price" id="prodCash"></span></span>
         			</li>
					<li><label>价格：</label> 
					
					<span class="black">¥<span class="black" id="oldProdCash"></span></span>
					</li>
					<li id="choose_0" index="0">
						<!-- <label id="propName" propname="颜色">型号：</label>
						<dl>
							<dd key="208:635" valId="635">
								黑色<span></span>
							</dd>
							<dd class="check" key="208:636" valId="636">
								红色<span></span>
							</dd>
							<dd key="208:661" valId="661">
								黄色<span></span>
							</dd>
						</dl> -->
					</li>
					<li><label>数量：</label>
						<div class="count_div" style="height: 30px; width: 160px;">
							<a href="javascript:void(0);" class="minus"></a>
							<input type="text" class="count" value="1" id="prodCount"  /> 
							<a href="javascript:void(0);" class="add"></a>
						</div></li>
				</ul>
		</div>
		
		<div class="white-bg shop-info">
		  
		   <div class="shop-logo" id="shop-logo">
				 <!-- <a href=""><img src="" > </a> -->
		   </div>
		  
		   <div class="shop-right">
				<h1 class="item-name" id="shopName">
				<!-- <a href=""></a> -->
				</h1> 
				<div class="shop-sale" id="shopSale">
				   <label>主营：</label>
				</div>
		   </div>
		</div>
		
		<div class="white-bg shop-info-btn">
				<div class="shop-btn-fix">
				    <a class="btn btn-classify" onclick="inShop();" href="javascript:void(0);">全部分类</a>
				    <a class="btn btn-goshop" onclick="inShop();" href="javascript:void(0);">进店逛逛</a>
				</div>
		</div>
        <div id="goodsContent" class="goods-content white-bg">
			
            <div class="hd hd_fav">
                <ul>
                   <!--  <li class="on">图文详情</li>
                    <li class="">规格参数</li>
                    <li class="">评价</li> -->
                </ul>
            </div>
             <div class="bd">
				<ul >
			 	</ul>
			 	<!-- <ul >
			 	</ul>
			 	<ul >
			 	</ul> -->
			</div> 
            <!-- <div style="width: 2304px; position: relative; overflow: hidden; padding: 0px; margin: 0px; transition-duration: 200ms; transform: translateX(0px);" class="bd">
                <ul style="display: table-cell; vertical-align: top; max-width: 768px;width: 100%;" class="property">
                    <div class="prop-area" style="min-height:300px;overflow: hidden;">
                    	<img src="img/8a9740c7-7f8e-4f20-ba64-1e90dd596ebe.jpg" alt="" /></div>
                </ul>
                <ul class="txt-imgs" style="display: table-cell; vertical-align: top; max-width: 768px;width: 100%;">
                	<div class="desc-area" style="padding: 0px 10px 0 10px;">
	                <li style="height:30px;">
	                	<div id="ajax_loading" style="margin: 10px  auto 15px;text-align:center;"> <img src="images/loading.gif" style="width: auto; display: block;  margin: auto;"></div>
	                </li>
	                </div>
                </ul>
                <ul style="display: table-cell; vertical-align: top; max-width: 768px;width: 100%;" class="appraise" rel="1" status="1">
                	<div style="height:30px;">
	                	<div id="ajax_loading" style="margin: 10px  auto 15px;text-align:center;"> <img src="images/loading.gif" style="width: auto; display: block;  margin: auto;"></div>
	                </div>
                     <div class="wap_page" style="display: none;" onclick="next_comments(this)"><span>下一页</span></div>
                </ul>
            </div> -->
        </div>
    </div>
</div>
<div class="clear"></div>
<div class="fixed-foot">
	<div class="fixed_inner">
		<a class="btn-fav" href="javascript:void(0);" onclick="addInterest(this);">
		<i class="i-fav"></i><span>收藏</span>
		</a>
		<a class="cart-wrap" href="pages/BuyCar/buyCar.jsp">
			<i class="i-cart"></i>
			<span>购物车</span>
			<span class="add-num" id="totalNum">0</span>
		</a>
		<div class="buy-btn-fix">
		    <a class="btn btn-info btn-cart"  onclick="addShopCart();" href="javascript:void(0);">加入购物车</a>
		    <a class="btn btn-danger btn-buy" onclick="buyNow();" href="javascript:void(0);">立即购买</a>
		</div>
	</div>
</div>
</body>
</html>
