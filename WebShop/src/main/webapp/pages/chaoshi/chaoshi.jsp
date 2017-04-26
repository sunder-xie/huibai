<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String tPath = request.getContextPath();
String basePath = request.getScheme() + "://"
        + request.getServerName() + ":" + request.getServerPort()
        + tPath + "/";
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>"></base>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>乐汇百材－综合材料首选－正品低价、品质保证、轻松购物</title>
	<!-- website -->
    <link rel="stylesheet" type="text/css" href="assets/css/web/web_frame.css">
    <link rel="stylesheet" type="text/css" href="assets/css/web/web_nhead.css">
	<!-- Bootstrap -->
    <link rel="stylesheet" type="text/css" href="assets/plugs/bootstrap/css/bootstrap.min.css" >
    <!-- 个性化-->
	<link rel="stylesheet" type="text/css" href="assets/css/index.css">
	<link rel="stylesheet" type="text/css" href="assets/css/global_nav.css">
	
	<meta name="keywords" content="汇百（hbaicai.com）、乐汇百材、hbaicai、汇百官网、全民开店、农村电商、在线购物、汇百app、汇百客服、汇百应用、汇百网站注册、汇百公益" id="keywords"/>

    <meta name="description" content="国内购物平台乐汇百材网,基于高频流量入口和资本,发展以建材为核心,国内和跨境电商并行的“一体两翼”模式,并全力构建小微企业的超级孵化器,打造社交化和移动电商为主体的交易平台的闭环。目前,乐汇百材网会员数近1亿,入驻48万余商家。乐汇百材，您身边的建材专家！" id="description"/>
	<script src="assets/js/comm.js"></script>
	<link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
</head>
<body>
	<!-- site_frame start -->
	<div class="site_frame">
	  <!-- site_frame_top start -->
		<jsp:include page="pages/HomePages/home_topbar.jsp" />
		
	  	<%@ include file="pages/HomePages/home_headtools.jsp" %>
	  	
	  	<div class="site_frame_main">
	  	    <div class="index_banner">
		    <%@ include file="pages/HomePages/home_nav.jsp" %>
		    <jsp:include page="pages/HomePages/home_banner.jsp" />
		    </div>
		    <div class="site_frame_wrap">
		  	<%@ include file="pages/HomePages/home_special.jsp" %>
		  	<jsp:include page="pages/HomePages/home_floor.jsp" />
		  	</div>	
	  	</div>
	  	<!-- <div class="site_frame_foot">
	  	     <div class="site_foot"> -->
	  		<jsp:include page="pages/HomePages/home_footerbar.jsp" />
	  		<!-- </div>
  	    </div> -->
	  	<div id="rightbar">
	  		<jsp:include page="pages/HomePages/home_rightbar.jsp" />
	    </div>
    </div>
</body>

<!--加载第三方js jquery bootstrap-->
<script src="assets/plugs/jquery/jquery-1.11.3.min.js"></script>
<script src="assets/plugs/bootstrap/js/bootstrap.min.js"></script>
<script src="assets/js/lazyload/jquery.lazyload.js?v=1.9.1"></script>
<script src="assets/js/index.js"></script>
</html>