<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8"></meta>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta name="description" content="乐汇百材-我的订单" />
	<meta name="author" content="hlb" />
	<%@ include file="../common/path.jsp" %>
	<%@ include file="../common/base.jsp" %>
    <base href="<%=tBasePath%>"></base>
	<title>乐汇百材-我的订单</title>
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
	<link rel="stylesheet" href="<%=tPath%>/assets/css/order.css">
	<link href="<%=tPath%>/assets/css/Pager.css" rel="stylesheet" type="text/css" />  
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
				   <span class="orange">订单管理</span>&nbsp;&nbsp;&gt;&nbsp;&nbsp;我的订单
				</div>
				<div id="main">
                <div class="mt20 exChange">
				    <ul  class="Js_tabContent">
				        <!-- 商品订单 -->
				        <li id="ut184" class="tabItem">
				            <div id="ut185" class="autoList cm-mercOrder mt20">
				                <table id="ut186" class="tc auto_listTitle" border="1" cellpadding="0" cellspacing="0" width="100%">
				                    <thead id="ut187">
				                        <tr id="ut188" class="order_herad">
				                          <th id="ut189" class="tc" width="50%">商品信息</th>
				                          <th id="ut190" class="tc" width="15%">单价(元)</th>
				                          <th id="ut191" class="tc" width="10%">数量</th>
				                          <th id="ut191" class="tc" width="15%">商品总价(元)</th>
				                          <th id="ut192" class="tc" width="20%">订单状态</th>
				                          <!-- <th id="ut193" class="tc" width="13%">操作</th> -->
				                        </tr>
				                    </thead>
				                </table>
				                <ul id="ut194" class="cTablea">
				                  <li></li>
				                </ul>
				            </div>
				            <div class="paginator-info">
								<div id="J_bottomPage" style="margin-top: -40px;"></div>
							</div>
				            
				        </li>
				    </ul>
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
	<script type="text/javascript" src="<%=tPath%>/assets/js/jquery.cityselect.js"></script>
	<script src="<%=tPath%>/pages/User/userOrder.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
	<script src="<%=tPath%>/pages/User/userMenu.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
	<script src="<%=tPath%>/assets/plugs/jquery/jquery.pager.js" type="text/javascript"></script>    
</html>