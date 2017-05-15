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
<script charset="utf-8" src="js/userCenter.js?"></script>
<title>会员中心</title>
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
<div class="container">
	<div class="row">
					<div class="member_top member_top_1">
					 
					  <a href="pages/User/userInfo.jsp?userId=<%=userinfo.getId() %>" style="display:block">
						<div class="member_top_bg">
							<img src="images/member_bg.png">
						</div>
						
						<div class="member_m_pic member_m_pic_1">
							<%if(userinfo.getPortrait() == null){%>
								<img class="img-circle"/>
							<%}else{ %>
								<img class="img-circle" src="<%=userinfo.getPortrait() %>" />
							<%} %>
						</div>
						
						<div class="member_m_z member_m_z_1">
							<div class="member_m_x">
							<em><%=userinfo.getNickName() %></em>
							</div>
						</div>
						<div class="member_m_hy">
							<div class="member_m_hy_x">普通会员</div>
						</div>
					 </a>
					 <div class="member_m_r" style="top: 9px;">
						<a href="pages/merchnt/merCenter.jsp">我要开店&gt;</a></div>
						<div class="member_m_r">
						<a href="pages/User/userSetting.jsp">设置&gt;</a></div>
					</div>
				
				<div class="member_mp_img" data-toggle="modal" style="display:none"
					data-target="#myModalmin" data-title="我的名片" data-tpl="mp">
					<img src="images/member_mp_img.png">
				</div>

			<div class="list-group mb10 member_list_group clearfix">
					<a href="pages/User/InterGoods.jsp" class="list-group-item col-xs-6">
						<div class="m_img"><img src="images/order_bg_5.png"></div>
						<p class="m_name">关注商品</p>
						<!-- <span class="red">0</span> -->
					</a>
					<a href="pages/User/InterShop.jsp" class="list-group-item col-xs-6">
						<div class="m_img"><img src="images/order_bg_8.png"></div>
						<p class="m_name">关注店铺</p>
						<!-- <span class="red">&nbsp;&nbsp;</span> -->
					</a>
					<!-- <a href="/p/inbox" class="list-group-item col-xs-4">
						<div class="m_img"><img src="images/order_bg_4.png"></div>
						<p class="m_name">收件箱</p>
						<span class="red">&nbsp;&nbsp;</span>
					</a>
		
					<a href="/p/systemMessages" class="list-group-item col-xs-4">
						<div class="m_img"><img src="images/order_bg_7.png"></div>
						<p class="m_name">系统消息</p>
						<span class="red">&nbsp;&nbsp;</span>
					</a> -->
			</div> 

			<div class="list-group mb10">
					<a href="pages/User/userOrder.jsp" class="list-group-item tip">
						<div class="list_group_img">
							<img src="images/member_img16.png">
						</div> 我的订单 <span class="gary pull-right">查看全部</span>
					</a>
					<div class="list-group-item p0 clearfix">
						<div class="col-xs-3 p0">
							<a class="order_tab_link" href="pages/User/userOrder.jsp?ord_sta=01"> <em
								class="order_img"> <img src="images/order_bg_3.png"></em>待付款

							</a>
						</div>
						<div class="col-xs-3 p0">
							<a class="order_tab_link" href="pages/User/userOrder.jsp?ord_sta=02"> <em
								class="order_img"> <img src="images/order_bg_2.png"></em>待发货
							</a>
						</div>
						<div class="col-xs-3 p0">
							<a class="order_tab_link" href="pages/User/userOrder.jsp?ord_sta=03"> <em
								class="order_img"> <img src="images/order_bg_1.png"></em>待收货
							</a>
						</div>
						<div class="col-xs-3 p0">
							<a class="order_tab_link" href="pages/User/userOrder.jsp?ord_sta=04"> <em
								class="order_img"> <img src="images/order_bg.png"></em>已完成
							</a>
						</div>
					</div>
				</div>
				
		<!-- <div class="list-group mb10">
			<a href="/p/help" class="list-group-item tip">
				<div class="list_group_img"><img src="images/order_bg_10.png"></div>
				常见问题
			</a>
			<a href="/p/feedbacks" class="list-group-item tip">
				<div class="list_group_img"><img src="images/order_bg_9.png"></div>
				意见反馈
			</a>
		</div>  -->
		
	</div>
</div>

<div class="clear"></div>

<div class="list-group mt50 mb50">
	<div style="text-align:center;padding: 0 40px;">
		<button type="button" class="btn btn-danger btn-block"
			onclick="userLogout();" tabindex="5">退 出 登 录</button>
	</div>
</div>
<div style="display: none;" class="modal fade" id="myModalmin" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
      	<form class="form-horizontal" role="form" data-method="formAjax">
	         <div class="modal-header member_tc_top">
	            <button type="button" class="close member_tc_xx" data-dismiss="modal" aria-hidden="true">×</button>
	            <h4 class="modal-title" id="myModalLabel">&nbsp;&nbsp;</h4>
	         </div>
			 <div style="overflow:hidden;width: 100%;padding-top: 20px;">
				<div style="">
					 <div class="member_mp_t_img" >
					 	<img src="images/noavatar.png">
		        			</div>
					 <div class="member_mp_t_m">萧雅哲</div>
					 <div class="member_mp_t_m_m">
						  	  <img src="img/1.jpg">
						  </div>
						  <div class="member_mp_t_tit">用微信扫一扫二维码，成为我的粉丝</div>
					  </div>
			 </div>
			 <div style="height:60px;"></div>
         </form>
      </div>
	</div>
</div>
<jsp:include page="../common/index_footerbar.jsp" />
</div>
</body>
</html>
