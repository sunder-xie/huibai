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
<title>支付结果</title>
<link rel="stylesheet" href="css/bootstrap.css?v=01291">
<link rel="stylesheet" href="css/style.css?v=1?v=01291">
<link rel="stylesheet" href="css/member.css?v=01291">
<link rel="stylesheet" href="css/order3.css?v=01291">

<!-- <link rel="stylesheet" href="css/msg.css?v=01291"> -->

<script charset="utf-8" src="js/bootstrap.min.js?v=01291"></script>
<script charset="utf-8" src="js/global.js?v=01291"></script>
<script charset="utf-8" src="js/template.js?v=01291"></script>

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
            <div class="tit">支付结果</div>
        </div>
    </div>
</header>

<div class="container mb50">
 	<div class="row pub" id="payResutl">
		<div class="info">
            <span class=""></span>
            <h2></h2>
            <div class="btnDiv clearfix">
                <a class="btn btn0" onclick="toOrderList();">返回我的订单</a>
            </div>
        </div>
	</div>		
	<!-- <div id="ajax_loading" style="width:300px;margin: 10px  auto 15px;text-align:center;display: none;">
 			<img src="images/loading.gif">
	</div> -->
				
</div>
<div class="clear"></div>

<script type="text/javascript">
    
    var basepath=null; /*根目录*/
    var PayResult='';
    
   
    $(function(){
    	setAllDomain();
    	GetPayResult();
	});
    
    var setAllDomain = function(){
    	basepath='';	
    	PayResult = getQueryStringByName('result');
    	//PayResult = 'S';
    };
    
    var GetPayResult = function(){
    	
    	if(isNull(PayResult))
    	return;
    	if(PayResult=='S')
    	{
    		$('#payResutl .info span').addClass('ok');
    		$('#payResutl .info h2').html('恭喜，商品支付成功！');
    	}else if(PayResult=='F'){
    		$('#payResutl .info span').addClass('fail');
    		$('#payResutl .info h2').html('支付失败！');
    	}
    };
    
    var toOrderList = function(){
    	window.location = "pages/User/userOrder.jsp";
    };
</script>
</body></html>

