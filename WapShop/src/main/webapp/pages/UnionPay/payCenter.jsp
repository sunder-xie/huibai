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
<title>收银台</title>
<link rel="stylesheet" href="css/bootstrap.css?v=01291">
<link rel="stylesheet" href="css/style.css?v=1?v=01291">
<link rel="stylesheet" href="css/member.css?v=01291">
<link rel="stylesheet" href="css/order3.css?v=01291">

<!-- <link rel="stylesheet" href="css/msg.css?v=01291"> -->

<script charset="utf-8" src="js/bootstrap.min.js?v=01291"></script>
<script charset="utf-8" src="js/global.js?v=01291"></script>
<script charset="utf-8" src="js/template.js?v=01291"></script>
<script charset="utf-8" src="js/payCenter.js?v=01291"></script>


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
            <div class="tit">收银台</div>
        </div>
    </div>
</header>

<div class="container mb50">
 	<div class="row order" id="payinfo">
		
	</div>		
	<div class="row">
		<div class="list-group mb10 member_list_group clearfix">
			<div class="list-group-item">
				<h3>支付方式</h3>
			</div> 
			<dl class="" id="payChannle">
				
			</dl> 
		</div> 
	</div>	
	<div id="ajax_loading" style="width:300px;margin: 10px  auto 15px;text-align:center;display: none;">
 			<img src="images/loading.gif">
	</div>
				
</div>
<div class="clear"></div>
<div class="fixed-foot footer">
<div class="fixed_inner">
    <div class="buy-btn-fix">
        <a href="javascript:submitPay();" class="btn btn-danger btn-buy">提交</a>
    </div>
</div>
</div>

<textarea id="payinfo-text" class="hide"> 
	<div class="pay-info white-bg mb10 p10">
           	<p class="p-attr">订单编号：<span>{orderId}</span></p>
           	<p class="p-attr">订单摘要：<span>{orderDesc}</span></p>
           	<p class="p-attr">创建时间：<span>{orderDt}</span></p>
           	<p class="p-origin">订单金额：
                ¥<em class="price">{orderAmt}</em>
              </p>
    </div>
</textarea> 

<textarea id="payChannle-text" class="hide"> 
		<dd class="list-group-item col-xs-6" channle-id="{channle}">
			<img alt="" src="{payImg}">
			<span></span>
		</dd>
</textarea> 
<script type="text/javascript">
var contextPath = '';
</script>
</body></html>

