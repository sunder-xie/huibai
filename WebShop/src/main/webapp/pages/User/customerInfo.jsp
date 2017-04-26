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
				   <span class="orange">安全管理</span>&nbsp;&nbsp;&gt;&nbsp;&nbsp;完善身份信息
				</div>
				<div id="main">
					<div class="row">
						<div class="col-md-12">
							
							<!-- Default panel -->
							<div class="panel panel-default">
								<div class="panel-heading">
									<h3 class="panel-title">客 户 信 息</h3>
									<div class="panel-options">
										<a id="modifyBaseInfo" class="fr infoEdit" title="编辑" href="javascript:void(0);" style="display: block;">编辑</a>
										<a id="saveBaseInfo" class="fr ml10 dn" href="javascript:void(0);" style="display: none;">保存</a>
										<a id="cancleBaseInfo" class="fr btn_cal dn" href="javascript:void(0);" style="display: none;"> 取消</a>
									</div>
								</div>
								<div class="panel-body">
									<table width="100%" cellspacing="0" cellpadding="0">
						                <tbody>
						                		<tr class="hide">
													<th width="40">客户编号:</th>
													<td width="320" id="custId" type="text"></td>
												</tr>
												<tr class="even">
													<th width="40">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名:</th>
													<td width="320" id="custNm" type="text"></td>
												</tr>
												<tr>
													<th width="40">身份证号:</th>
													<td id="certNo" type="text"></td>
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

		<div class="tips_box ws_tips_box">
			<div class="tips_head clearfix">
				<div class="fl">提示信息</div>
				<div class="clear fr"></div>
			</div>
			<div class="tips_content">
				<div>
					<p class="notice">还未完善身份信息，请完善！</p>
				</div>
				<div class="tips_btn clearfix">
					<a class="confirm" href="javascript:;" target="_self">确定</a>
				</div>
			</div>
		</div>
		<!-- footer -->
	<jsp:include page="../HomePages/home_footerbar.jsp" />
	</div>
</body>
<script src="<%=tPath%>/assets/plugs/bootstrap/js/bootstrap.min.js"></script>
<script src="<%=tPath%>/pages/User/customerInfo.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
<script src="<%=tPath%>/pages/User/userMenu.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
</html>