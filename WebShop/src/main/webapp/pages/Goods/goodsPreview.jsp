<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<title>乐汇百材-商品预览</title>
<!-- website -->
 <link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/web/web_frame.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/assets/css/fonts/linecons/css/linecons.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/assets/css/bootstrap.css">
<%-- <link rel="stylesheet"
	href="<%=request.getContextPath()%>/assets/css/xenon-core.css"> --%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/assets/css/xenon-forms.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/assets/css/index.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/assets/css/global_nav.css">
<link rel="shortcut icon" href="<%=tPath%>/favicon.ico" type="image/x-icon"/>
<link href="<%=tPath%>/assets/css/Pager.css" rel="stylesheet"
	type="text/css" />
<link href="<%=tPath%>/assets/css/goods.css" rel="stylesheet"
	type="text/css" />
</head>
<body style="width: 100%">
	<div class="site_frame">
	    <jsp:include page="../HomePages/home_topbar.jsp" />
	    <%@ include file="../HomePages/home_headtools.jsp" %>
	    <div class="site_frame_main">
			<%@ include file="../GlobalPages/global_nav.jsp" %>
	      	<div class="site_frame_wrap">
				<div id="root-nav">
					<div class="w">
						<div class="breadcrumb">
							<!-- <strong><a href="//shouji.jd.com">手机</a></strong><span>&nbsp;&gt;&nbsp;<a
								href="//channel.jd.com/shouji.html">手机通讯</a>&nbsp;&gt;&nbsp;<a
								href="//list.jd.com/list.html?cat=9987,653,655">手机</a>&nbsp;&gt;&nbsp;
							</span> <span><a
								href="//list.jd.com/list.html?cat=9987,653,655&amp;ev=exbrand_14026">Apple</a>&nbsp;&gt;&nbsp;<a
								href="//item.jd.com/1861095.html">APPLEiPhone 6s Plus</a></span> -->
						</div>
					</div>
				</div>
	<div id="p-box">
		<div class="w">
			<div id="product-intro" class="m-item-grid clearfix">
				<div id="pic_preview">
					<div id="preview" class="spec-preview">
						<%-- <span class="jqzoom" >
						<img jqimg="<%=request.getContextPath()%>/assets/images/pic_jqzoom/b1.jpg"
							src="<%=request.getContextPath()%>/assets/images/pic_jqzoom/s1.jpg" /></span>  --%>
					</div>
					<!--缩图开始-->
					<div class="spec-scroll">
						<a class="prev">&lt;</a> <a class="next">&gt;</a>
						<div class="items" id="preview_items">
							<%-- <ul>
								<li><img alt="佳能"
									bimg="<%=request.getContextPath()%>/assets/images/pic_jqzoom/b1.jpg"
									src="<%=request.getContextPath()%>/assets/images/pic_jqzoom/s1.jpg"
									onmousemove="preview(this);"></li>
								<li><img alt="佳能"
									bimg="<%=request.getContextPath()%>/assets/images/pic_jqzoom/b2.jpg"
									src="<%=request.getContextPath()%>/assets/images/pic_jqzoom/s2.jpg"
									onmousemove="preview(this);"></li>
								<li><img alt="佳能"
									bimg="<%=request.getContextPath()%>/assets/images/pic_jqzoom/b3.jpg"
									src="<%=request.getContextPath()%>/assets/images/pic_jqzoom/s3.jpg"
									onmousemove="preview(this);"></li>
								<li><img alt="佳能"
									bimg="<%=request.getContextPath()%>/assets/images/pic_jqzoom/b1.jpg"
									src="<%=request.getContextPath()%>/assets/images/pic_jqzoom/s1.jpg"
									onmousemove="preview(this);"></li>
								<li><img alt="佳能"
									bimg="<%=request.getContextPath()%>/assets/images/pic_jqzoom/b3.jpg"
									src="<%=request.getContextPath()%>/assets/images/pic_jqzoom/s3.jpg"
									onmousemove="preview(this);"></li>
								<li><img alt="佳能"
									bimg="<%=request.getContextPath()%>/assets/images/pic_jqzoom/b1.jpg"
									src="<%=request.getContextPath()%>/assets/images/pic_jqzoom/s1.jpg"
									onmousemove="preview(this);"></li>
							</ul> --%>
						</div>
					</div>
				</div>

				<div class="m-item-inner">
					<div id="itemInfo">
						<div id="goodsname">
							<h1></h1>
						</div>
						<div id="summary">
							<div id="summary-price">
								<div class="dt">商 城 价：</div>
								<div class="dd">
									<strong class="p-price" id="lhbc-price">￥6199.00</strong>
								</div>
							</div>

						</div>
						<div id="choose" class="clearfix p-choose-wrap">
							<div id="choose-type" class="li p-choose">
								<!-- <div class="dt">型 号：</div>
								<div class="dd">
									<div class="item  selected">
										<b></b><a href="javascript:;" title="金色"><i>金色</i></a>
									</div>
									<div class="item">
										<b></b><a href="javascript:;" title="银色"><i>银色</i></a>
									</div>
									<div class="item">
										<b></b><a href="javascript:;" title="深空灰"><i>深空灰</i></a>
									</div>
									<div class="item">
										<b></b><a href="javascript:;" title="玫瑰金"><i>玫瑰金</i></a>
									</div>
								</div> -->
							</div>
						</div>
						<div class="proinfo-num">
							<dl id="buycount" style="">
								<dt>商品数量：</dt>
								<dd>
									<a href="javascript:void(0);" class="minus"></a> 
									<input id="buyNum" value="1" max="979" type="text"> 
									<a href="javascript:void(0);" class="plus"></a> 
									<span class="tip" id ="store">库存<em></em>件</span>
									 <span class="moreby"><em>*请输入正确的数字</em></span>
								</dd>
							</dl>
						</div>
						<div class="mainbtns clearfix">
						    <input id="goodstype" value="" data-type="" type="text" class="hide"> 
							<a id="buynow" class="btn-order" href="javascript:void(0)">立即购买</a>
						</div>
					</div>
				</div>

				<div class="m-item-ext">
					<div class="extInfo" >
						<div class="brand-logo" id="shoplogo">
						</div>
						<div class="seller-infor" id="shopname">
						</div>
						<div class="customer-service clearfix">
							<div class="pop-shop-enter">
								<div class="seller-phone" id="shoptel">
								</div>
								<div class="clearfix" id="shopinfo">
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
		<div class="w">
			<div class="ser_nav">
				<ul class="nav">
					<li>商品详情</li>
				</ul>
			</div>

			<div class="show_list">
				<div class="ser_image" id="goods-content">
					<!-- <img src="image/tubiao.jpg" alt="" />
					<img src="image/da2.jpg" alt="" /> 
					<img src="image/tubiao.jpg" alt="" /> 
					<img src="image/da3.jpg" alt="" /> 
					<img src="image/tubiao.jpg" alt="" />
					<img src="image/da4.jpg" alt="" /> 
					<img src="image/da5.jpg" alt="" /> -->
				</div>
			</div>


		</div>
</div>
</div>
		</div>
		<jsp:include page="../HomePages/home_footerbar.jsp" />
		</div>
</body>
<script src="<%=tPath%>/assets/plugs/jquery/jquery-1.11.3.min.js"
	type="text/javascript"></script>
<script src="<%=tPath%>/assets/plugs/bootstrap/js/bootstrap.min.js"
	type="text/javascript"></script>
<script src="<%=tPath%>/assets/plugs/jquery/jquery.jqzoom.js"
	type="text/javascript"></script>
<script src="<%=tPath%>/assets/plugs/jquery/jquery.pager.js"
	type="text/javascript"></script>
<script src="<%=tPath%>/assets/js/global_nav.js" type="text/javascript"></script>
<script src="<%=tPath%>/assets/js/comm.js?rnd=<%=Math.random()%>"
	type="text/javascript"></script>
<script src="<%=tPath%>/pages/Goods/goodsPreview.js?rnd=<%=Math.random()%>"
	type="text/javascript"></script>
<script
	src="<%=tPath%>/pages/Goods/goodimgtab.js?rnd=<%=Math.random()%>"
	type="text/javascript"></script>
</html>