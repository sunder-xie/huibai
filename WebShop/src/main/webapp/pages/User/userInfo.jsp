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
    <base href="<%=tBasePath%>"></base>
<title>乐汇百材-用户信息</title>
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
<script src="<%=tBasePath%>/assets/plugs/jquery/jquery-1.11.3.min.js" type="text/javascript"></script>
<script src="<%=tBasePath%>/assets/js/comm.js" type="text/javascript"></script>
<link rel="shortcut icon" href="<%=tPath%>/favicon.ico" type="image/x-icon"/>
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
				   <span class="orange">账户管理</span>&nbsp;&nbsp;&gt;&nbsp;&nbsp;我的资料
				</div>
				<div id="main">
					<div class="row">
						<div class="col-md-12">
							
							<!-- Default panel -->
							<div class="panel panel-default">
								<div class="panel-heading">
									<h3 class="panel-title">用 户 信 息</h3>
									<div class="panel-options">
										<a id="modifyBaseInfo" class="fr infoEdit" title="编辑" href="javascript:void(0);" style="display: block;">编辑</a>
										<a id="saveBaseInfo" class="fr ml10 dn" href="javascript:void(0);" style="display: none;">保存</a>
										<a id="cancleBaseInfo" class="fr btn_cal dn" href="javascript:void(0);" style="display: none;"> 取消</a>
									</div>
								</div>
								<div class="panel-body">
									<table width="100%" cellspacing="0" cellpadding="0">
						                <tbody>
							                <tr class="even">
							                    <th width="100">昵称：<span>*</span></th>
							                    <td width="320" id="nickname" type="text"></td>
							                    <th width="130">用户名：</th>
							                    <td id="userName" type="text"></td>
							                </tr>
							                <tr>
							                    <th>邮箱：<span>*</span></th>
							                    <td id="useremail" type="email"></td>
							                    <th>电话号码：</th>
							                    <td id="usertell" type="text"></td>
							                </tr>
						                </tbody>
						            </table>
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
<script src="<%=tPath%>/pages/User/userInfo.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
<script src="<%=tPath%>/pages/User/userMenu.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
<script src="<%=tPath%>/assets/js/comm.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
</html>