<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8"></meta>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta name="description" content="乐汇百材-店铺信息" />
	<meta name="author" content="hlb" />
			<%@ include file="../common/path.jsp" %>
	<%@ include file="../common/base.jsp" %>
    <base href="<%=tBasePath%>"></base>
	<title>乐汇百材-店铺信息</title>
	<!-- website -->
 	<link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/web/web_frame.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/fonts/linecons/css/linecons.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/bootstrap.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/xenon-core.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/xenon-forms.css">
	<link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/index.css">
	<link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/shop.css">
	<link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/search.css">
	<link href="<%=tPath%>/assets/css/Pager.css" rel="stylesheet" type="text/css" />    
	<link rel="shortcut icon" href="<%=tPath%>/favicon.ico" type="image/x-icon"/>

</head>
<body>
   <div class="site_frame">
	    <jsp:include page="../HomePages/home_topbar.jsp" />
	    <div class="site_frame_head">
			<div class="shop_header" id="shop_header">
			</div>
		</div>
		<div class="site_frame_main">
			<div class="sf-layoutList JS-head" id="shopsign"></div>
			<div class="sf-moduleList sf-noPadding"
				style="margin-bottom: 0px; z-index: 2;" id="shop_memuList"></div>

			<div id="merReg-banner" class="main_content"></div>
			<div class="site_frame_wrap">
				<div id="SearchWrap" class="SearchWrap"></div>
			</div>
		</div>
		<jsp:include page="../HomePages/home_footerbar.jsp" />
</div>
</body>
	<script src="<%=tPath%>/assets/plugs/jquery/jquery-1.11.3.min.js" type="text/javascript"></script>
	<script src="<%=tPath%>/assets/plugs/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="<%=tPath%>/assets/plugs/jquery/jquery.pager.js" type="text/javascript"></script>    
	<script src="<%=tPath%>/assets/js/comm.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
	<script src="<%=tPath%>/pages/Shop/shopInfo.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
</html>