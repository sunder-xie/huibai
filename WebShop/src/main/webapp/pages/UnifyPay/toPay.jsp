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
	    <div  class="paycon pay_weixin">
	      <p>
              支付金额<span class="price"></span>，<label id="tipMsg">请使用微信扫描下方二维码完成支付</label></p>
             <%--  <img src="<%=tPath%>/Pay/GetWeiXinQrcode.action?key=123" id="qrCode" alt="二维码" /> --%>
              <img src="" id="qrCode" alt="二维码" />
	    </div>
	    
	  	<input id="hidCheckSuccess" type="hidden" value="" />
        <input id="hidOrderID" type="hidden" value="" />
	    <!--正文部分结束-->
	    </div>
  </div>
  
    <!-- footer -->
     <jsp:include page="../HomePages/home_footerbar.jsp" />
     </div>
</body>
<script src="<%=tPath%>/assets/plugs/jquery/jquery-1.11.3.min.js"></script>
	<script src="<%=tPath%>/assets/plugs/bootstrap/js/bootstrap.min.js"></script>
	<script src="<%=tPath%>/pages/UnifyPay/toPay.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
	<script src="<%=tPath%>/assets/js/comm.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
</html>