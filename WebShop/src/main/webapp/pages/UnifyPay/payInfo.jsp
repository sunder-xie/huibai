<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8"></meta>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta name="description" content="乐汇百材-用户中心" />
	<meta name="author" content="hlb" />
			<%@ include file="../common/path.jsp" %>
	<%@ include file="../common/base.jsp" %>
    <base href="<%=tBasePath%>"></base>
	<title>乐汇百材-支付中心</title>
	<!-- website -->
    <link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/web/web_frame.css">
    <link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/web/web_manger_header.css">
    
	<link rel="stylesheet" href="<%=tPath%>/assets/css/fonts/linecons/css/linecons.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/bootstrap.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/xenon-core.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/xenon-forms.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/pay.css">
	
	<link rel="shortcut icon" href="<%=tPath%>/favicon.ico" type="image/x-icon"/>
	<style type="text/css">
    </style>
</head>
<body>
	<div class="site_frame">
    <jsp:include page="../HomePages/home_topbar.jsp" />
    <jsp:include page="payHeader.jsp" />
   <!-- main -->
    <div  class="site_frame_main">
	    <div class="site_frame_wrap">
	        <!--mask-->
	    <div  class="paycon">
	      <div >
	        <!--订单详情-->
	        <div class="payfloor">
	        <div class="title_left">订单提交成功，请尽快付款。</div>
	        <div class="title_right">
	        应付金额：&nbsp;&nbsp;<span></span>&nbsp;&nbsp;元
	        </div>
	        </div>
	        <div  class="orderinfo">
	          <div  class="orderinfo-title">
	          <span >订单信息</span>
	          <a name="" href="javascript:void(0)" class="moreorderinfo" style="float: right;">收起</a>
	          </div>
	          <div  class="orderinfo-detail">
	              <dl>
	                <dd id="order_id">订单编号：<span></span></dd>
	                <dd id="order_shop">店铺名称：<span></span></dd>
	              </dl>
	          </div>
	          <div id="ut168" class="clearfix"></div>
	        </div>
	        <!--商品列表-->
	        <div class= "paytool">
	          <div class="paytool-title">
	            需支付 &nbsp;&nbsp;<span></span>&nbsp;&nbsp;元
	          </div>
			  
	          <div class="paytool_detail">
	          
		          <div class="paytool_head_bd" now-pay-tool="0">
						<ul>
							<li class="active">微信支付</li>
							<li>支付宝</li>
						</ul>
				  </div>
				  
				  <div class="paytool_body_bd">
		            <div class="tab_aera weixin" style="display:">
		                <p>
		                 提示：点击“下一步”后，请打开手机微信的“扫一扫”，扫描二维码 
		                </p>
		            </div>
		            
		            <div class="tab_aera alipay" style="display:none">
		                <p>
		                 正在接入中，请等待。。。
		                </p>
		            </div>
		            
		        </div>
			  
			    <div class="paytool_button">
						<button class="pay_next_btn">下一步</button>
				  </div>
	          </div>
	          
	          
	        </div>
	      </div>
	    </div>
	    
	   
	    <!--正文部分结束-->
	    </div>
  </div>
  
    <!-- footer -->
     <jsp:include page="../HomePages/home_footerbar.jsp" />
     </div>
</body>
<script src="<%=tPath%>/assets/plugs/jquery/jquery-1.11.3.min.js"></script>
	<script src="<%=tPath%>/assets/plugs/bootstrap/js/bootstrap.min.js"></script>
	<script src="<%=tPath%>/pages/UnifyPay/payInfo.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
	<script src="<%=tPath%>/assets/js/comm.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
</html>