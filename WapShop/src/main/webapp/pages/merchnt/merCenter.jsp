<%@page import="com.app.bean.TblUserInfo"%>
<%@page import="com.app.common.utils.LTConstant"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
TblUserInfo userinfo =  (TblUserInfo)session.getAttribute(LTConstant.userInfo);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="yes" name="apple-touch-fullscreen">
<meta content="telephone=no" name="format-detection">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1,user-scalable=no">
<%@ include file="../common/base.jsp" %>
<base href="<%=tBasePath%>"></base>
<link rel="stylesheet" href="css/bootstrap.css?v=01291">
<link rel="stylesheet" href="css/style.css?v=1?v=01291">
<link rel="stylesheet" href="css/member.css?v=01291">
<link rel="stylesheet" href="css/order3.css?v=01291">

<script charset="utf-8" src="js/global.js?v=01291"></script>
<script charset="utf-8" src="js/bootstrap.min.js?v=01291"></script>
<script charset="utf-8" src="js/template.js?v=01291"></script>
<script charset="utf-8" src="js/merCenter.js?"></script>
<title>商家中心</title>
<script type="text/javascript">
$(document).ready(function(){
	var attr = parseInt($(".member_m_pic_1").height());
	var attr3 = parseInt($(".member_m_z_1").height());
	var h = attr - attr3;
	var clientWidth=document.body.clientWidth;
	$(".member_mp_t_img img").css("width",clientWidth*0.3);
	$(".member_mp_t_img img").css("height",clientWidth*0.3);
	
	handleUserPic();
});

function handleUserPic(){
	var th = $(".member_m_pic").outerHeight(true);
	if(th<60){
		setTimeout("handleUserPic",500);
	}else{
		$(".member_m_pic .img-circle").css("height",th*0.9);
		$(".member_m_pic .img-circle").css("width",th*0.9);
	}
}
</script>
</head>
<body>
<div class="maincontainer">
	<div class="container" style="max-width:768px;margin:0 auto;">
			<div class="row">
					<div class="member_top member_top_1">
					  <a href="pages/User/userInfo.jsp?userId=<%=userinfo.getId() %>" style="display:block">
						<div class="member_top_bg">
							<img src="images/member_bg.png">
						</div>
						<div class="member_m_pic member_m_pic_1">
							<img class="img-circle" id="shopLogo" src="">
						</div>
						<div class="member_m_z member_m_z_1">
							<div class="member_m_x" id="shopNm"></div>
						</div>
						<div class="member_m_hy">
							<div class="member_m_hy_x">普通商家</div>
						</div>
					 </a>
					 <div class="member_m_r" style="top: 9px;">
						<a href="pages/User/userCenter.jsp">我是买家&gt;</a></div>
						<div class="member_m_r">
						<a href="pages/User/userSetting.jsp">设置&gt;</a></div>
					</div>
				
				<div class="member_mp_img" data-toggle="modal" style="display:none"
					data-target="#myModalmin" data-title="我的名片" data-tpl="mp">
					<img src="images/member_mp_img.png">
				</div>

			<div class="list-group mb10">
					<a href="javascript:goOrderPage('99');" class="list-group-item tip">
						<div class="list_group_img">
							<img src="images/member_img16.png">
						</div> 我的订单 <span class="gary pull-right">查看全部</span>
					</a>
					<div class="list-group-item p0 clearfix">
						<div class="col-xs-3 p0">
							<a class="order_tab_link" href="javascript:goOrderPage('01');"> <em
								class="order_img"> <img src="images/order_bg_3.png"></em>待付款
							</a>
						</div>
						<div class="col-xs-3 p0">
							<a class="order_tab_link" href="javascript:goOrderPage('02');"> <em
								class="order_img"> <img src="images/order_bg_2.png"></em>待发货
							</a>
						</div>
						<div class="col-xs-3 p0">
							<a class="order_tab_link" href="javascript:goOrderPage('03');"> <em
								class="order_img"> <img src="images/order_bg_1.png"></em>待收货
							</a>
						</div>
						<div class="col-xs-3 p0">
							<a class="order_tab_link" href="javascript:goOrderPage('04');"> <em
								class="order_img"> <img src="images/order_bg.png"></em>已完成
							</a>
						</div>
					</div>
				</div>
		
	</div>
	
	<div class="list-group mt50 mb50">
		<div style="text-align:center;padding: 0 40px;">
			<button type="button" class="btn btn-danger btn-block"
				onclick="userLogout();" tabindex="5">退 出 登 录</button>
		</div>
	</div>
</div>
<div class="clear"></div>
<jsp:include page="../common/index_footerbar.jsp" />
</div>
</body>
</html>
