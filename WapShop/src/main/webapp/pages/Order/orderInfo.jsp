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
<script charset="utf-8" src="js/orderInfo.js?v=01291"></script>

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
            <div class="tit">订单详情</div>
        </div>
    </div>
</header>

<div class="container mb50">

    <div class="row mb10 order-status" id="orderSta">
			<!-- <h2 class="p5 ml50 white">交易成功</h2>
			<h5 class="p5 ml50 white">5填自动收货</h5> -->
	</div>	
	
	<div class="row mb10" id="wuliu">
		<a class="list-group-item tip">
				<label class="wuliu-label"> 
				<span></span>
				</label>
				<div class="wuliu-info">
				    <p class="addr-first">
	                    暂无物流
	                    <!-- <em class="addr-person"></em> -->
	                </p>
					<p class="addr-second">请稍后再查。。。
					<!-- <em id="addr-cont">{address}</em> --></p>
				</div>
	    </a>
	</div>
	
	<div class="row mb10" id="address">
		
	</div>	
	
	<div id="ajax_loading" style="width:300px;margin: 10px  auto 15px;text-align:center;display: none;">
 		<img src="images/loading.gif">
	</div>
	
 	<div class="row order mb10" id="order">
	
	</div>	
	
	<div class="row">
		<div class="list-group-item addAddr">
		买家留言：
			 <textarea id="BuyMsg" maxlength="100"></textarea>
		</div>
    </div> 
    <div class="row mb10" id="pay">
	
	</div>	
	
	<div class="row mb10">
		<div class="pay-info white-bg p10 list-group-item" id="orderDtCont">
	    </div>
	</div>	
    
</div>
<div class="clear"></div>
<div class="fixed-foot footer">
<div class="fixed_inner white-bg_2">
    <div class="buy-btn-fix" id="opertion">
    </div>
</div>
</div>


<textarea id="opertion-text" class="hide"> 
			<a href="javascript:toDo('{orderId}','{mode}');" class="btn btn-danger btn-buy">{content}</a>
		</textarea> 
		
<textarea id="payinfo-text" class="hide"> 
	<div class="pay-info white-bg p10 list-group-item">
           	<p class="p-attr">商品总价：<span class="pull-right">{goodsAmt}</span></p>
           	<p class="p-attr">运费：<span class="pull-right">{yfAmt}</span></p>
           	<p class="p-origin">订单总价：
                <em class="pull-right">¥{totalAmt}</em>
            </p>
    </div>
    <div class="list-group-item">
		实付款：<span class="price pull-right">¥{payAmt}</span>
	</div>
</textarea> 

<textarea id="clock" class="hide">
	<span class="counter p5 ml50 white">
		<i class="clock"></i>
		<span class="timecounter">
		<span class="d" id="day_show"><em></em>天</span>
		<span class="h" id="hour_show"><em></em>时</span>
		<span class="m" id="minute_show"><em></em>分</span>
		<span class="s" id="second_show"><em></em>秒</span>
		</span>后系统自动{status}
	</span>
</textarea> 

<textarea id="orderinfo-text" class="hide">
       <p class="p-attr">{content}：<span >{goodsAmt}</span></p>
        	<!-- <p class="p-attr">创建时间：<span>{yfAmt}</span></p> -->
</textarea> 

<textarea id="addr" class="hide">
		<a class="list-group-item">
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
	        <li class="list-group-item text-primary tip">
	        <a href="{shopUrl}">{shopNm}</a>
	        </li> 
		</ul>
</textarea> 


<script type="text/javascript">
var contextPath = '';
</script>
</body></html>

