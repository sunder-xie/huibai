<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8"></meta>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta name="description" content="乐汇百材-公告内容" />
	<meta name="author" content="whb" />
			<%@ include file="../common/path.jsp" %>
	<%@ include file="../common/base.jsp" %>
    <base href="<%=tBasePath%>"></base>
	<title>乐汇百材-公告内容</title>
	<!-- website -->
    <link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/web/web_frame.css">
    
	<link rel="stylesheet" href="<%=tPath%>/assets/css/fonts/linecons/css/linecons.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/bootstrap.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/xenon-forms.css">
	<link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/index.css">
	<link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/global_nav.css">
    <link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/notice.css">
	<link rel="shortcut icon" href="<%=tPath%>/favicon.ico" type="image/x-icon"/>
	
</head>
<body>
<div class="site_frame">
    <jsp:include page="../HomePages/home_topbar.jsp" />
    <%@ include file="../HomePages/home_headtools.jsp" %>
    <div class="site_frame_main">
	<%@ include file="../GlobalPages/global_nav.jsp" %>
      <div class="site_frame_wrap">

		<div class="announce-main">
				<div class=cm-sidebar>
					<div class=cm-sideBox>
						<div class=side-title>
							<h2>最新公告</h2>
						</div>
						<div class="side-main side-announceList" id="side-announceList">
						</div>
					</div>
					<div class="cm-sideBox hide">
							<div class=side-title>
								<h2>联系方式</h2>
							</div>
							<div class=side-main>
								<div class=side-contact>
									<p>
										联系电话:<br> <a href=#>40080000000</a>
									</p>
									<br>
									<p>
										联系邮箱： <a href=#>kefu@hbaicai.com</a>
									</p>
								</div>
							</div>
				  </div>
		
				</div>
				
				<div class="cm-rightBox md-listDetail" id="annoDetail">
					
				</div>
				</div>
		</div>
	</div>
	 <jsp:include page="../HomePages/home_footerbar.jsp" />
</div>
</body>
	<script type="text/javascript" src="<%=tPath%>/assets/plugs/jquery/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="<%=tPath%>/assets/plugs/bootstrap/js/bootstrap.min.js"></script>
	<script src="<%=tPath%>/pages/announce/annoDetail.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
	<script src="<%=tPath%>/assets/js/comm.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
	<script src="<%=tPath%>/assets/js/global_nav.js"></script>
</html>