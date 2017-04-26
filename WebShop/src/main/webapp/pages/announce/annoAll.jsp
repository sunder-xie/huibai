<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8"></meta>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta name="description" content="乐汇百材-公告信息" />
	<meta name="author" content="hlb" />
			<%@ include file="../common/path.jsp" %>
	<%@ include file="../common/base.jsp" %>
    <base href="<%=tBasePath%>"></base>
	<title>乐汇百材-所有公告</title>
	<!-- website -->
    <link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/web/web_frame.css">
    
	<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/fonts/linecons/css/linecons.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/bootstrap.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/xenon-forms.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/assets/css/index.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/assets/css/global_nav.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/assets/css/notice.css">
	<link href="<%=request.getContextPath()%>/assets/css/Pager.css" rel="stylesheet" type="text/css" /> 
	<link rel="shortcut icon" href="<%=tPath%>/favicon.ico" type="image/x-icon"/>
</head>
<body>
<div class="site_frame">
    <jsp:include page="../HomePages/home_topbar.jsp" />
    <%@ include file="../HomePages/home_headtools.jsp" %>
    <div class="site_frame_main">
	<%@ include file="../GlobalPages/global_nav.jsp" %>
      <div class="site_frame_wrap">
			<div class=announce-main>
				<div class="md-listDetail">
					<div class="announce-title clearfix">
						<div class=announce-tag id=announce-tag>
							<h4>全部公告</h4>
						</div>
					</div>

					<div class=data-table id="anno-data-table"></div>

				</div>
			</div>
	</div>
	</div>
	 <jsp:include page="../HomePages/home_footerbar.jsp" />
</div>
</body>
	<script type="text/javascript" src="<%=tPath%>/assets/plugs/jquery/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="<%=tPath%>/assets/plugs/bootstrap/js/bootstrap.min.js"></script>
	<script src="<%=tPath%>/assets/plugs/jquery/jquery-1.11.3.min.js"></script>
	<script src="<%=tPath%>/assets/plugs/bootstrap/js/bootstrap.min.js"></script>
	<script src="<%=tPath%>/assets/plugs/jquery/jquery.pager.js" type="text/javascript"></script>   
	<script src="<%=tPath%>/assets/js/comm.js?rnd=<%=Math.random()%>" type="text/javascript"></script> 
	<script src="<%=tPath%>/assets/js/global_nav.js"></script>
	<script src="<%=tPath%>/pages/announce/annoAll.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
	
</html>