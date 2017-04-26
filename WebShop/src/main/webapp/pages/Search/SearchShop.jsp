<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8"></meta>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta name="description" content="乐汇百材-商品搜索" />
	<meta name="author" content="hlb" />
			<%@ include file="../common/path.jsp" %>
	<%@ include file="../common/base.jsp" %>
    <base href="<%=tBasePath%>"></base>
	<title>乐汇百材-商品搜索</title>
	<!-- website -->
    <link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/web/web_frame.css">
    
	<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/fonts/linecons/css/linecons.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/bootstrap.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/xenon-core.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/xenon-forms.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/assets/css/index.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/assets/css/global_nav.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/assets/css/search.css">
	<link href="<%=tPath%>/assets/css/Pager.css" rel="stylesheet" type="text/css" />   
	<link rel="shortcut icon" href="<%=tPath%>/favicon.ico" type="image/x-icon"/>
</head>
<body >
   <div class="site_frame">
    <jsp:include page="../HomePages/home_topbar.jsp" />
    <%@ include file="../HomePages/home_headtools.jsp" %>
    <div class="site_frame_main">
	<%@ include file="../GlobalPages/global_nav.jsp" %>
      <div class="site_frame_wrap">
	<div id="SearchWrap" class="SearchWrap">
     <!--  <div class="flow-wrap clearfix">
 
	<div class="flow-item first"> 
      <a href="supplier.php?suppId=45" class="flow-datu" title="腾威官方旗舰店"> 
        <img style="display: block;" title="广州腾威科技官方旗舰店" alt="" data-original="/data/street_logo/supplier45/original45_220x220.jpg" src="/data/street_logo/supplier45/original45_220x220.jpg" height="150" width="150">
      </a>
      <div class="flow-content">
      	<h4 class="flow-title">
        	<a href="supplier.php?suppId=45" title="广州腾威科技官方旗舰店"><span>广州腾威科技官方旗舰店</span></a>
                </h4>
        
	  	<p class="flow-desc">
        	<span>卖家：</span>
            <a href="supplier.php?suppId=45" title="腾威官方旗舰店管理员" target="_blank"></a>
            <a href="http://wpa.qq.com/msgrd?v=3&amp;uin=315960265&amp;site=qq&amp;menu=yes" target="_blank" alt="点击这里联系我" title="点击这里联系我" class="flow-qq"><img src="http://wpa.qq.com/pa?p=1:315960265:4" alt="QQ" height="16" border="0"></a>
            <a href="http://amos1.taobao.com/msg.ww?v=2&amp;uid=&amp;s=2" target="_blank" class="flow-qq"><img src="http://amos1.taobao.com/online.ww?v=2&amp;uid=&amp;s=2" alt="淘宝旺旺" height="16" border="0" width="16"></a>
        </p>
         
        <p class="flow-desc">
        	<span>所在地：</span>广东,广州</p>
        <p class="flow-desc">
        	<a href="supplier.php?suppId=45" title="进入店铺，查看所有的商品">共<strong>42</strong>件宝贝&gt;&gt;</a>
        </p>
      </div>
      <div class="flow-score">
      	<h3>店铺动态评分</h3>
        <p>描述相符：<span>5</span></p>
        <p>服务态度：<span>5</span></p>
        <p>发货速度：<span>5</span></p>
      </div>
	  <div class="flow-main">
      	<div class="picMarquee-left">
			<div class="bda">
		 		<div class="picListta">
			<ul>
							<li>
					<a href="goods.php?id=1445" title="无机色粉" target="_blank" class="img"><img src="images/201511/thumb_img/1445_thumb_G_1446509699404.jpg"> <span>￥14.30</span> </a> 
					<a href="goods.php?id=1445" title="无机色粉" target="_blank" class="name">无机色粉</a> 
				</li>
							<li>
					<a href="goods.php?id=1444" title="S-13胶粘剂" target="_blank" class="img"><img src="images/201511/thumb_img/1444_thumb_G_1446509632616.jpg"> <span>￥22.00</span> </a> 
					<a href="goods.php?id=1444" title="S-13胶粘剂" target="_blank" class="name">S-13胶粘剂</a> 
				</li>
							<li>
					<a href="goods.php?id=1443" title="高渗透封闭底漆" target="_blank" class="img"><img src="images/201511/thumb_img/1443_thumb_G_1446509571599.jpg"> <span>￥24.20</span> </a> 
					<a href="goods.php?id=1443" title="高渗透封闭底漆" target="_blank" class="name">高渗透封闭底漆</a> 
				</li>
							<li>
					<a href="goods.php?id=1442" title="彩色防滑路面面层" target="_blank" class="img"><img src="images/201511/thumb_img/1442_thumb_G_1446509502086.jpg"> <span>￥30.80</span> </a> 
					<a href="goods.php?id=1442" title="彩色防滑路面面层" target="_blank" class="name">彩色防滑路面面层</a> 
				</li>
						</ul>
               </div>
	       			</div>
		</div>
      </div>	
	
	
</div>   
   
    </div>  -->
    </div>
	<div class="seller-chosen" id="sellerSelect">
		<h2>
			<strong class="seller-title">卖家精选</strong><!-- <span
				class="seller-keywords adRelatedSearch"><a target="_blank"
				title="苹果保护壳" href="#">苹果保护壳</a><a target="_blank" title="苹果5s"
				href="#">苹果5s</a><a target="_blank" title="苹果6s plus" href="#">苹果6s
					plus</a><a target="_blank" title="苹果6s" href="#">苹果6s</a><a
				target="_blank" title=" iphone SE" href="#"> iphone SE</a><a
				target="_blank" title="苹果6 plus" href="#">苹果6 plus</a></span> -->
		</h2>
		<div class="seller-chosen-list" id="seller-chosen-list">
			
		</div>
	</div>
	</div>
	</div>
	<jsp:include page="../HomePages/home_footerbar.jsp" />
</div>
</body>
    <script type="text/javascript" src="<%=request.getContextPath()%>/assets/plugs/jquery/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/assets/plugs/bootstrap/js/bootstrap.min.js"></script>
	<script src="<%=tPath%>/assets/plugs/jquery/jquery-1.11.3.min.js"></script>
	<script src="<%=tPath%>/assets/plugs/bootstrap/js/bootstrap.min.js"></script>
	<script src="<%=tPath%>/assets/plugs/jquery/jquery.pager.js" type="text/javascript"></script>    
	<script src="<%=tPath%>/assets/js/comm.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
	<script src="<%=tPath%>/pages/Search/searchShop.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
    <script src="<%=tPath%>/assets/js/global_nav.js"></script>
</html>