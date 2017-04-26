<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<title>乐汇百材-用户中心</title>
<!-- website -->
    <link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/web/web_frame.css">
    <link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/web/web_manger_header.css">
    <link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/web/web_manger_menu.css">
    
    <link rel="stylesheet"
	href="<%=tPath%>/assets/css/fonts/linecons/css/linecons.css">
<link rel="stylesheet" href="<%=tPath%>/assets/css/bootstrap.css">
<link rel="stylesheet" href="<%=tPath%>/assets/css/bootstrap-table.css">
<link rel="stylesheet" href="<%=tPath%>/assets/css/xenon-core.css">
<link rel="stylesheet" href="<%=tPath%>/assets/css/xenon-forms.css">
<link rel="stylesheet" href="<%=tPath%>/assets/css/base.css">
<link rel="stylesheet" href="<%=tPath%>/assets/css/user.css">
<style type="text/css">
</style>
</head>
<body>
	<div class="site_frame">
    <jsp:include page="../HomePages/home_topbar.jsp" />
    <jsp:include page="userHeader.jsp" />

    <div class="site_frame_main">
    
    <div class="site_frame_wrap cmMiddle">
         <div class="site_frame_menus">
              <div id="menu"></div>
         </div>
         <div class="site_frame_cont">
         		<div class="bussiness-crumbs" style="position:static">
				   您的位置：
				   <span class="orange">用户中心</span>&nbsp;&nbsp;&gt;&nbsp;&nbsp;
				   <span class="orange">订单管理</span>&nbsp;&nbsp;&gt;&nbsp;&nbsp;我的订单
				</div>
				<div id="main">
					<div class="err-content">
						<p style="display: none;" id="common_errors"
							class="alert alert-danger"></p>
					</div>

					<div class="uc-content">
						<div class="data-title" style="margin-bottom: 20px">
							<h2 >修改登录密码</h2>
						</div>

						<div class="form">
						    <div class="form-group " style="display:none">
								<label class="label"><span 
									class="required">*</span>用户编号</label>
								<div class="controls">
									<div class="placeHolderWrap">
										<input class="control text-control w248"  id="userId">
									</div>
								</div>
							</div>
							<div class="form-group ">
								<label class="label"><span id="ut215"
									class="required">*</span>原密码</label>
								<div class="controls">
									<div class="placeHolderWrap">
										<input class="control text-control w248" type="password" placeholder="请输入原密码" id="oldpwd">
									</div>
								</div>
							</div>

							<div class="form-group ">
								<label class="label"><span id="ut215"
									class="required">*</span>新密码</label>
								<div class="controls">
									<div class="placeHolderWrap">
										<input class="control text-control w248" type="password" placeholder="请输入新密码" id="newpwd">
									</div>
								</div>
							</div>

							<div class="form-group ">
								<label class="label"><span id="ut215"
									class="required">*</span>确认新密码</label>
								<div class="controls">
									<div class="placeHolderWrap">
										<input class="control text-control w248" type="password" placeholder="再次输入新密码" id="newpwd1">
									</div>
								</div>
							</div>

							<div class="form-group">
								<label class="label"></label>
								<div class="controls">
									<a class="btn btn-r"
										style="margin-left: 50px" href="javascript:void(0);">确定</a> <a
										 class="btn btn-g" href="javascript:void(0);">取消</a>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="backpanel-inner">
					<div class="bp-item" id="bp-research">
						<a class="research" target="_blank" href="#"><b></b>调查问卷</a>
					</div>
					<div class="bp-item" id="bp-gotop">
						<a title="使用快捷键T也可返回顶部哦！" class="gotop" href="#" target="_self"><b></b>返回顶部</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- footer -->
	<jsp:include page="../HomePages/home_footerbar.jsp" />
	</div>
</body>
<script src="<%=tPath%>/assets/plugs/bootstrap/js/bootstrap.min.js"></script>
<script src="<%=tPath%>/pages/User/changePin.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
<script src="<%=tPath%>/pages/User/userMenu.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
</html>