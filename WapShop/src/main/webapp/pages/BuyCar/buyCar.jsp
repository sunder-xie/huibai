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
<title>购物车</title>
<link rel="stylesheet" href="css/bootstrap.css?v=01291">
<link rel="stylesheet" href="css/style.css?v=1?v=01291">
<link rel="stylesheet" href="css/member.css?v=01291">
<link rel="stylesheet" href="css/order3.css?v=01291">

<!-- <link rel="stylesheet" href="css/msg.css?v=01291"> -->

<script charset="utf-8" src="js/bootstrap.min.js?v=01291"></script>
<script charset="utf-8" src="js/global.js?v=01291"></script>
<script charset="utf-8" src="js/template.js?v=01291"></script>
<script charset="utf-8" src="js/shopCart.js?v=01291"></script>


<!-- <script charset="utf-8" src="js/msg.js?v=01291"></script> -->
</head>
<body>
<div class="fanhui_cou">
	<div class="fanhui_1"></div>
	<div class="fanhui_ding">顶部</div>
</div>
 <header class="header header_1">
    <div class="fix_nav">
        <div class="nav_inner">
            <a class="nav-left back-icon" href="javascript:history.back();">返回</a>
            <div class="tit">购物车</div>
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
						<input name="Skeyword" id="Skeyword" placeholder="搜索商品" type="text"
							value=""> <span class="pro_sou" style="cursor: pointer;"
							onclick="searchproduct();"><img src="images/Search.png"></span>
						<div></div>
					</form>
				</div>
			</div>
		</div>
	</div>
<div class="container mb50">
		<input id="ListTotal" value="" type="hidden">
    			<div class="row rowcar" id="rowcar">
				
				 </div>	
					<div id="ajax_loading" style="width:300px;margin: 10px  auto 15px;text-align:center;display: none;">
			 			<img src="images/loading.gif">
					</div>
				<div id="nodata" style="display: none;" class="mb50">
							<div class="notice-search">
								<div class="ns-wrap clearfix info">
									<div class="ns-content">
										<span>----------没有更多数据了！----------</span>
									</div>
								</div>
							</div>
					</div>
					<form id="list_form" action="" method="post">
						<input type="hidden" id="curPageNO" name="curPageNO" value="" /> 
						<input type="hidden" id="categoryId" name="categoryId" value="" />
						<input type="hidden" id="orders" name="orders" value="" />
						<input type="hidden" id="hasProd" name="hasProd" value="" />
						<input type="hidden" id="keyword" name="keyword" value="" />
						<input type="hidden" id="shopId" name="shopId" value="" /> 
						<input type="hidden" id="prop" name="prop" value="" />
					</form>
					
		   
</div>
<div class="clear"></div>
<div class="fixed-foot footer">
<div class="fixed_inner">
    <div class="pay-point">
       <!--  <div class="icheck pull-left mr10">
            <input type="checkbox" id="buy-sele-all" value="1">
            <label for="buy-sele-all">
                <span class="mt10"></span>全选
            </label>
        </div> -->
         <p>合计：<em class="red f22">¥<span id="totalPrice">0.00</span></em></p>
    </div>
    <div class="buy-btn-fix">
        <a href="javascript:submitShopCart();" class="btn btn-danger btn-buy">去结算</a>
    </div>
</div>
</div>

<textarea id="goodsInfo" class="hide"> 
		<li class="list-group-item hproduct clearfix" id="{seqId}">
			<div class="icheck buy-car-check">
                   <input type="checkbox" class="ids" prodStatus="1"  itemkey="{seqId}" shopId="{shopId}"/>
                         <label class="checkLabel"> <span></span> </label>
			</div>
		    <div class="buy-car-goods">
		            <div class="p-pic">
		            <a href="{goodsUrl}">
		            <img class="img-responsive" src="{imgUrl}">
		            </a>
		            </div>
		            <div class="p-info">
		                <a href="{goodsUrl}">
		                <p class="p-title">{goodsNm}</p>
		                </a>
		               	<p class="p-attr"><span>{typeNm}</span></p>
		                <a class="close p-close" onclick="deleteShopCart('{goodsId}','{typeId}')" href="javascript:void(0);" style="margin-top: -30px;">×</a>
		               	<p class="p-origin">
		                    <em class="price">¥{price}</em>
		                </p>
		                <div class="btn-group btn-group-sm control-num">
		                   <a onclick="disDe(this)" href="javascript:void(0);" class="btn btn-default"><span class="glyphicon glyphicon-minus gary"></span></a>
		                   <input type="tel" class="btn gary2 Amount" readonly="readonly" value="1" maxlength="4" itemkey="{buyCarId}" shopId="{shopId}" goodsId="{goodsId}" typeId="{typeId}">
		                   <a onclick="increase(this)" href="javascript:void(0);" class="btn btn-default"><span class="glyphicon glyphicon-plus gary"></span></a>
		            	</div>
		            </div>
            </div>
       </li>
</textarea> 

<textarea id="shopInfo" class="hide"> 
		<ul class="list-group" id="{shopId}">
	        <li class="list-group-item text-primary">
	            <div class="icheck pull-left mr5">
	                   <input type="checkbox" class="top-ids" prodStatus="1"  itemkey="{shopId}"/>
                       <label class="shopcheckLabel"> <span></span> </label>
	            </div>{shopNm}
	            </li> 
		</ul>
</textarea> 
<script type="text/javascript">
var contextPath = '';
</script>
</body></html>

