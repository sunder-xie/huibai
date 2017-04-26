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
	<title>乐汇百材-商家中心</title>
	<!-- website -->
    <link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/web/web_frame.css">
    <link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/web/web_manger_header.css">
    <link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/web/web_manger_menu.css">
    
	<link rel="stylesheet" href="<%=tPath%>/assets/css/fonts/linecons/css/linecons.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/bootstrap.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/xenon-core.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/xenon-forms.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/base.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/MerChnt.css">
</head>
<body>
    <div class="site_frame">
    <jsp:include page="../HomePages/home_topbar.jsp" />
    <jsp:include page="merHeader.jsp" />

    <div class="site_frame_main">
    
    <div class="site_frame_wrap cmMiddle">
         <div class="site_frame_menus">
              <div id="menu"></div>
         </div>
         <div class="site_frame_cont">
				<!-- 商户中心界面sta -->
                        <div class="cmMiddleMain">
                        	<div id="sellerInfoMod" class="user-info-mod white-bd pd-50">
                        	  <div class="user-info" style="display: block;">
								<div class="avatar">
									<div id="shoplogo" class="img margin-auto">
										<img src="#">
									</div>
								</div>
								<div class="info">
									<div class="item">
										<span id="shopname" class="lb name"></span>
									</div>
									<div class="item">
										<span class="lb">安全等级：</span>
										<div class="lines high">
											<div class="line">
												<b></b>
											</div>
											高
										</div>
									</div>
									<div id="shopUrl" class="item access">
									<!-- 	<a href="/merchantUser/shopManage.html">店铺设置</a> -->
										 <a target="_new"
											href="#">店铺首页</a>
									</div>
									<div class="item">

									<!-- 	<a href="#" class="btn-bg">申请认证</a> 
										<a data-href="#"
											title="申请o2o门店"
											href="#"
											data-o2o-btn="" class="btn-bg">申请o2o门店</a>
 -->

									</div>
								</div>
							</div>
							<div class="user-access" style="display: block;">
								<div class="tit">
									总资产
								</div>
								<div class="des">
									<p>
										<span class="num">0.00</span>元
									</p>
									<p>
										<span class="num qbq">0</span>乐券
									</p>
									
								</div>
							</div>
						</div>
                        	<div class="mod">
                        		<div class="main">
								<div id="order_mod" class="child-mod white-bd">
									<div class="tit">订单</div>
									<div class="access">
										<a class="btn-pay"
											href="http://oc.hbaicai.com/order/seller/orderList.html?status=2&amp;sellerId=3731143">待付款<strong>0</strong></a>
										<a class="btn-receive"
											href="http://oc.hbaicai.com/order/seller/orderList.html?status=3&amp;sellerId=3731143">待收货<strong>0</strong></a>
										<a class="btn-delivery"
											href="http://oc.hbaicai.com/order/seller/orderList.html?status=1&amp;sellerId=3731143">待发货<strong>0</strong></a>
										<a class="btn-back"
											href="http://oc.hbaicai.com/portle/refundList.html?_merchant_user_id_=3731143">退货/退款<strong>0</strong></a>
									</div>
								</div>

								<div id="goods_mod" class="child-mod white-bd">
									<div class="tit">商品</div>
									<div class="access">
										<a class="btn-check"
											href="http://goods.hbaicai.com/goodsManage/toIndex.html?_merchant_user_id_=3731143&amp;auditState=1&amp;publishState=-1">待审核<strong>0</strong></a>
										<a class="btn-sale"
											href="http://goods.hbaicai.com/goodsManage/toIndex.html?_merchant_user_id_=3731143&amp;auditState=2&amp;publishState=1">出售中<strong>0</strong></a>
										<a class="btn-saleto"
											href="http://goods.hbaicai.com/goodsManage/toIndex.html?_merchant_user_id_=3731143&amp;auditState=2&amp;publishState=2">待上架<strong>0</strong></a>
										<a class="btn-reject"
											href="http://goods.hbaicai.com/goodsManage/toIndex.html?_merchant_user_id_=3731143&amp;auditState=3&amp;publishState=2">已驳回<strong>0</strong></a>
									</div>
								</div>
                        		</div>
                        		<div class="aside">
                        			<div id="anno_mod" class="child-mod white-bd">
                        				<div class="tit">商家公告<a target="_blank" href="http://www.hbaicai.com/announcement/announce-list.htm" class="more">查看全部 &gt;</a></div>
									<ul class="list">
									    <li style="display: list-item;">
											<p class="item">
												暂无公告</p> <span class="time"></span>
										</li>
										<!-- <li style="display: list-item;">
											<p class="item">
												<a target="_blank"
													href="http://www.hbaicai.com/announcement/announce-detail.htm?id=101987">宝购专题活动及单品报名操作指导</a>
											</p> <span class="time">8-02</span>
										</li>

										<li style="display: list-item;">
											<p class="item">
												<a target="_blank"
													href="http://www.hbaicai.com/announcement/announce-detail.htm?id=101983">宝购优选商品准入规则</a>
											</p> <span class="time">7-18</span>
										</li>

										<li style="display: list-item;">
											<p class="item">
												<a target="_blank"
													href="http://www.hbaicai.com/announcement/announce-detail.htm?id=101935">关于宝购商品下架政策调整的通知</a>
											</p> <span class="time">7-01</span>
										</li>

										<li style="display: list-item;">
											<p class="item">
												<a target="_blank"
													href="http://www.hbaicai.com/announcement/announce-detail.htm?id=101484">商家们！根据品类找组织啦！</a>
											</p> <span class="time">2-29</span>
										</li>

										<li style="display: list-item;">
											<p class="item">
												<a target="_blank"
													href="http://www.hbaicai.com/announcement/announce-detail.htm?id=101369">宝购频道收费细则公告</a>
											</p> <span class="time">1-15</span>
										</li> -->
									</ul>
								</div>

                        			<div id="quest_mod" class="child-mod white-bd">
                        				<div class="tit">常见问题<a target="_blank" href="http://help.hbaicai.com/hc/list.html?t=3" class="more">查看全部 &gt;</a></div>
									<ul class="list">
									<li style="display: list-item;">
											<p class="item">
												暂无问题</p> 
										</li>
										<!-- <li style="display: list-item;">
											<p class="item">
												<a target="_blank"
													href="http://help.hbaicai.com/hc/content/437.html">买家申请退货，但迟迟不退还，如何申请仲裁？</a>
											</p>
										</li>

										<li style="display: list-item;">
											<p class="item">
												<a target="_blank"
													href="http://help.hbaicai.com/hc/content/436.html">如何拒绝买家退货退款申请？</a>
											</p>
										</li>

										<li style="display: list-item;">
											<p class="item">
												<a target="_blank"
													href="http://help.hbaicai.com/hc/content/435.html">如何拒绝买家退款申请？</a>
											</p>
										</li>

										<li style="display: list-item;">
											<p class="item">
												<a target="_blank"
													href="http://help.hbaicai.com/hc/content/434.html">如何同意买家退货退款申请？</a>
											</p>
										</li>

										<li style="display: list-item;">
											<p class="item">
												<a target="_blank"
													href="http://help.hbaicai.com/hc/content/433.html">如何同意买家退款申请？</a>
											</p>
										</li>

										<li style="display: list-item;">
											<p class="item">
												<a target="_blank"
													href="http://help.hbaicai.com/hc/content/431.html">如何进行发货？</a>
											</p>
										</li> -->
									</ul>
								</div>
                        			
                        		</div>
                        		<div class="clear"></div>
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
	</div>
   <!-- 商户中心界面end -->
    <!-- footer -->
   
 <jsp:include page="../HomePages/home_footerbar.jsp" />
 
 </div>
</body>
    <script src="<%=tPath%>/assets/plugs/jquery/jquery-1.11.3.min.js"></script>
	<script src="<%=tPath%>/assets/plugs/bootstrap/js/bootstrap.min.js"></script>
	<script src="<%=tPath%>/pages/MerChnt/MerCenter.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
	<script src="<%=tPath%>/pages/MerChnt/merComm.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
	<script src="<%=tPath%>/assets/js/comm.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
</html>