<%@page import="com.app.bean.TblUserInfo"%>
<%@page import="com.app.common.utils.LTConstant"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
TblUserInfo userinfo =  (TblUserInfo)session.getAttribute(LTConstant.userInfo);
%>
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
    
	<link rel="stylesheet" href="<%=tPath%>/assets/css/fonts/linecons/css/linecons.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/bootstrap.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/xenon-core.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/xenon-forms.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/base.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/user.css">
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
                <div class="cmMiddleMain">
                    <!--home-media 首页响应式布局 start-->
                    <div class="lyt-c-0">
						<!-- 用户信息 -->
                        <div id="user-info" class="user-info">
							<div class="info-lcol">
								<div class="u-pic">
									<img alt="用户头像"
										src="<%=userinfo.getPortrait() %>">
									<a id="accountImg" href="#"><div class="mask"></div></a>
								</div>
								<div class="info-m">
									<div class="u-name">
										<a href="#" target="_blank">
											<%if(userinfo == null){%>
												您还未登录，请登录！
											<%}else{ %>
												欢迎您，<%=userinfo.getUsername() %>
											<%} %>
										</a>
									</div>
									<div class="u-level">
										<span class="rank r3"> <s></s><a href="#"
											target="_blank">银牌会员</a>
										</span>
									</div>
									<div class="u-safe">
										<a id="accountSafe" href="#"><span>账户安全：</span></a> <i
											id="cla" class="safe-rank01"></i> <strong id="rank-text"
											class="rank-text ftx-01">低</strong> <a id="up" href="#">提升</a>
									</div>
									<div class="info-line">
										<span class="top-icon"></span> <span class="bottom-icon"></span>
										<span class="left-icon"></span>
									</div>
								</div>
							</div>
							<div class="info-rcol">
								<div class="user-counts">
									<ul>
										<li>
											<div class="count-item">
												<a href="＃" target="_self"
													> <i
													class="count-icon count-icon01"></i> 待付款 <em id="waitPay">0</em>
												</a>
											</div>
										</li>
										<li>
											<div class="count-item">
												<a href="＃" target="_self"> <i
													class="count-icon count-icon02"></i> 待收货 <em
													id="waitReceive">0</em>
												</a>
											</div>
										</li>
										<li>
											<div class="count-item">
												<a href="＃" target="_self"> <i
													class="count-icon count-icon03"></i> 待自提 <em id="waitPick">0</em>
												</a>
											</div>
										</li>
										<li>
											<div class="count-item">
												<a href="＃"> <i class="count-icon count-icon04"></i>
													待评价 <em id="productCount">0</em>
												</a>
											</div>
										</li>
									</ul>
								</div>

								<div class="acco-info">
                                    <ul>
                                        <li class="fore1">
                                            <div class="acco-item">
                                                <div>
                                                    <label>余额：</label>
                                                    <a href="＃" id="BalanceCount" >0.00</a>
                                                </div>
                                                <!-- <div>
                                                    <label>京豆：</label>
                                                    <a href="＃" id="JingdouCount" >0.0</a>
                                                </div>
                                                <div>
                                                    <label>京东卡/E卡：</label>
                                                    <a href="＃" id="LipinkaCount" >0.0</a>
                                                </div>
                                                <div>
                                                    <label>优惠券：</label>
                                                    <a href="＃" id="CouponCount" >0</a>
                                                </div> -->
                                            </div>
                                        </li>
                                        <li class="fore2 hide">
                                            <div class="acco-item">
                                                <div id="baitiao-info" class="baitiao-info">

                                                    <div>白条额度</div>
                                                    <div><a href="＃" target="_blank"><span class="baitiao-limit">?元</span></a>
                                                    </div>
                                                    <div><a class="alink" href="＃" target="_blank" clstag="wdjd|btjhg">激活白条，0元购物</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                        <li class="fore3">
                                            <div class="acco-item">
                                                <div id="jinku-info" class="jinku-info">
                                                    <div id="income">昨天收益<span class="ftx03">（元）</span>
                                                    </div>
                                                    <div class="ftx01 profit"><a class="ftx01" href="＃">0.00</a>
                                                    </div>
                                                    <div id="balance"><a href="＃">小金库</a>：<a href="＃"><em>0.00</em></a>
                                                    </div>
                                                    <div id="xjk0" style="display: block;"><a class="alink" target="_blank" href="＃">转入小金库，马上赚钱</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                </div>

                            </div>
                        </div>
                       
                    </div>
                    <div class="lyt-c-0">
                        <!-- 我的订单 -->
                        <div class="mod-main">
                            <div class="mt">
                                <h3>我的订单</h3>
                                <div class="extra-r"><a href="＃" target="_self" >查看全部订单</a>
                                </div>
                            </div>
                            <div class="mc">
                                <div id="tb-order" class="tb-order">

                                    <table width="100%" cellspacing="0" cellpadding="0" border="0"></table>
                                    <div class="nocont-box nocont-order"><b class="icon-order"></b>您买的东西太少了，这里都空空的，快去挑选合适的商品吧！</div>

                                </div>
                            </div>
                        </div>
                     
                    </div>
                   <!--  <div class="lyt-c-2">
                        <div class="lyt-c-7">
                            <div class="lyt-c-5">
                                我的足迹
                                <div class="mod-main" id="history">
                                    <div class="mt">
                                        <h3>我的足迹</h3>
                                        <div class="extra-r">
                                        	<a href="#" target="_blank">查看更多</a>
                                        </div>
                                    </div>
                                    <div class="mc">
                                        <div class="nocont-box nocont-history">
                                            <p>您还未在乐汇百材留下足迹哦，快快开启您的乐汇百材之旅吧~</p>
                                            <b class="history-icon"></b>
                                        </div>
                                    </div>
                                </div>
                               
                            </div>

                        </div>
                    </div> -->
                   <!--  <div class="lyt-c-9">
                        <div id="fol-goods" class="mod-main fol-goods">
                            <div class="mt">
                                <h3>我关注的商品</h3>
                                <ul class="extra-l">
                                    <li>
                                    	<a target="_self" href="#">
                                    	降价商品
										<em class="ftx03">0</em>
										</a>
                                    </li>
                                    <li>
                                    	<a target="_self" href="#">
                                    	促销商品
                                    	<em class="ftx03">0</em>
										</a>
                                    </li>
                                    
                                </ul>
                                <div class="extra-r">
                                	<a target="_self" href="#">
                                		查看更多
                                	</a>
                                </div>
                            </div>
                            <div class="mc">
                                <div class="nocont-box nocont-fol">
                                    <div>您还没有关注任何商品，看到感兴趣的就果断关注吧！</div>
                                </div>
                                <div id="fol-p-con" class="follow">
                                </div>
                            </div>
                        </div>
                    </div>
                </div> -->
				
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
<script src="<%=tPath%>/assets/plugs/jquery/jquery-1.11.3.min.js"></script>
	<script src="<%=tPath%>/assets/plugs/bootstrap/js/bootstrap.min.js"></script>
	<script src="<%=tPath%>/assets/js/comm.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
	<script src="<%=tPath%>/pages/User/userCenter.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
	<script src="<%=tPath%>/pages/User/userMenu.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
</html>