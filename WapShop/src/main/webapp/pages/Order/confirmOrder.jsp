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
<title>订单信息</title>
<link rel="stylesheet" href="css/bootstrap.css?v=01291">
<link rel="stylesheet" href="css/style.css?v=1?v=01291">
<link rel="stylesheet" href="css/member.css?v=01291">
<link rel="stylesheet" href="css/order3.css?v=01291">

<script charset="utf-8" src="js/bootstrap.min.js?v=01291"></script>
<script charset="utf-8" src="js/global.js?v=01291"></script>
<script charset="utf-8" src="js/template.js?v=01291"></script>
<script charset="utf-8" src="js/confirmOrder.js?v=01291"></script>

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
            <div class="tit">确认订单</div>
        </div>
    </div>
</header>

<div class="container mb50">
	<div class="row mb10" id="address">
		
	</div>	
	
	<div class="row mb10 list-group" id="noAddr" style="display:none">
		 <a href="javascript:addAddr()" class="list-group-item tip">
				<span style="font-size:20px">还未添加地址，请添加</span>
		  </a>
	</div>	
	
	<div id="ajax_loading" style="width:300px;margin: 10px  auto 15px;text-align:center;display: none;">
 		<img src="images/loading.gif">
	</div>
	
 	<div class="row order" id="order">
	
	</div>	
	
	<div class="row list-group">
			<a href="javascript:void(0)" class="list-group-item tip">
				店铺优惠<span class="gary pull-right">暂无优惠</span>
			</a>
			<a href="javascript:void(0)" class="list-group-item tip">
				配送方式：<span class="gary pull-right">快递：包邮</span>
			</a>
			<div class="list-group-item addAddr">
			买家留言：
				 <textarea id="BuyMsg" maxlength="100" placeholder="选填：对本次交易的说明"></textarea>
			</div>
    </div> 
    
    
</div>
<div class="clear"></div>
<div class="fixed-foot footer">
<div class="fixed_inner">
    <div class="pay-point">
         <p>合计：<em class="red f22">¥<span id="totalPrice">0.00</span></em></p>
    </div>
    <div class="buy-btn-fix">
        <a href="javascript:submitOrder();" class="btn btn-danger btn-buy">提交订单</a>
    </div>
</div>
</div>

<textarea id="addr" class="hide">
		<a href="javascript:chooseAddr();" class="list-group-item tip">
				<label class="addr-label"> 
				<span></span>
				</label>
				<div class="addr-info">
					<p class="addr-first">
	               		<span class="tel pull-right">联系电话：
	               		<em id="addr-tel">{tel}</em></span>
	                    收货人：
	                    <em class="addr-person" id="addr-person">{name}</em>
	                </p>
					<p class="addr-second">收货地址：
					<em id="addr-cont">{address}</em></p>
				</div>
	    </a>
</textarea> 
<textarea id="goodsInfo" class="hide"> 
		<li class="list-group-item hproduct clearfix" id="{goodsId}">
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
		               	<p class="p-origin">
		               		<span class="gary pull-right">x{buyNum}</span>
		                    <em class="price">¥{price}</em>
		                </p>
		            </div>
            </div>
       </li>
</textarea> 

<textarea id="shopInfo" class="hide"> 
		<ul id="{shopId}">
	        <li class="list-group-item text-primary">{shopNm}</li> 
		</ul>
</textarea> 
<script type="text/javascript">
var contextPath = '';
</script>
</body></html>

