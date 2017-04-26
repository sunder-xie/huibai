<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="utf-8"></meta>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta name="description" content="乐汇百材-商品搜索" />
	<meta name="author" content="hlb" />
	<title>乐汇百材-商品搜索</title>
		<%@ include file="../common/path.jsp" %>
	<%@ include file="../common/base.jsp" %>
    <base href="<%=tBasePath%>"></base>
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
	 
	<script src="<%=tPath%>/assets/plugs/jquery/jquery-1.11.3.min.js"></script>
	<script src="<%=tPath%>/assets/js/comm.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
	<link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>

</head>
<body>
   <div class="site_frame">
    <jsp:include page="../HomePages/home_topbar.jsp" />
    <%@ include file="../HomePages/home_headtools.jsp" %>
    <div class="site_frame_main">
	<%@ include file="../GlobalPages/global_nav.jsp" %>
      <div class="site_frame_wrap">
        <div class="SearchWrap" id="NullResult">
        </div>
		<div class="SearchWrap" id="SearchResult"  style = "display:none">

             <div class="breadcrumb">
                <span class="sep">所有分类</span> 
				<span class="sep">></span> 
			</div>
			
			<div class="flagshop" id="RelateShop" style = "display:none">
			</div>
			
			<div class="selector" id="L_selector" style = "display:none">
			</div>
			
			<div id="J_main" class="g-main2">
			</div>
		<%-- 

		<div id="J_container" class="container">
			<%@ include file="selector.jsp" %>

			<div id="J_main" class="g-main2">
				<div class="m-list">
					<div class="ml-wrap">
						<div id="J_filter" class="filter">
							<div class="f-line top">
								<div class="f-sort">
									<a class="curr" href="javascript:;">综合排序<i></i>
									</a> <a class="" href="javascript:;">销量<i></i>
									</a> <a class="" href="javascript:;">价格<i></i>
									</a> <a class="" href="javascript:;">评论数<i></i>
									</a> <a class="" href="javascript:;">新品<i></i>
									</a>
								</div>
								
								<div id="J_topPage" class="f-pager">
									<span class="fp-text"> <b>1</b> <em>/</em> <i>100</i>
									</span> <a class="fp-prev disabled" href="javascript:;">&lt;</a> <a
										class="fp-next" href="javascript:;">&gt;</a>
								</div>
								<div class="f-result-sum">
									共<span id="J_resCount" class="num">18.0万</span>件商品
								</div>
								<span class="clr"></span>
							</div> 
							
						</div>
						<div id="J_goodsList" class="goods-list-v1 gl-type-3 J-goods-list">
						    <%@ include file="goodslist.jsp" %>
							
							<span class="clr"></span>
						</div>
						<div class="page clearfix">
							<div id="J_bottomPage" class="p-wrap"></div>
						</div>
					</div>
				</div>
				
				<div class="m-aside">
					<div class="mt">
						<strong class="mt-title">商品精选</strong>
					</div>
					<div class="aside-bar">
						 <%@ include file="../goodinfo/goodRec.jsp"%></div>
						
				</div>
				
			</div>
			
		</div> --%>
		
		<div class="page clearfix">
			<div id="J_bottomPage" class="p-wrap"></div>
		</div>
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
			<!-- <ul>
				<li><a target="_blank" href="#"><p
							class="chosen-product-pic">
							<img class="search-loading" src="#"
								title="越南红心火龙果肉质紫红清甜多汁2个装（约2.5斤）" alt="【搜农坊】越南红心火龙果 2个（约2.5斤）"
								height="160" width="160">
						</p>
						<p class="chosen-produc-title">
							【搜农坊】越南红心火龙果 2个（约2.5斤）<i class="sell">越南红心火龙果肉质紫红清甜多汁2个装（约2.5斤）</i>
						</p></a>
					<p class="prive-tag">
						<em class="prive"><b>¥</b><img src="#"></em>
					</p></li>
				
			</ul> -->
		</div>
		</div>
		</div>
	</div>
	<jsp:include page="../HomePages/home_footerbar.jsp" />
</div>
</body>
	<script src="<%=tPath%>/assets/plugs/bootstrap/js/bootstrap.min.js"></script>
	<script src="<%=tPath%>/pages/Search/searchGoods.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
	<script src="<%=tPath%>/assets/plugs/jquery/jquery.pager.js" type="text/javascript"></script>  
	<script src="<%=tPath%>/assets/js/lazyload/jquery.lazyload.js?v=1.9.1"></script>  
</html>