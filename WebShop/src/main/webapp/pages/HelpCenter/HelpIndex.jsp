<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% String path=request.getContextPath(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head lang="en">
<title></title>
<style>
body {
	font-size: 12px;
	margin: 0;
	padding: 0;
	text-align: center;
	background-color:#f9f9f9;
}

a {
	text-decoration: none;
}

a:hover {
	color: red;
}

li a:hover {
	color: red;
}

.header-first, .continer-first, .foot {
	width: 980px;
	margin: 0 auto;
}

.foot {
	float: left;
}

.continer {
	float: left;
	margin-left: -200px;
	padding: 0 200px;
	width: 980px;
	background-color: #85b716;
	width: 980px;
}

.header-logo {
	float: left;
	margin-left: 10px;
}

.head-navigation ul li {
	float: left;
	list-style-type: none;
	padding: 0 10px;
	line-height: 52px;
	height: 52px;
}

.head-navigation {
	float: right;
}

.search-gg {
	width: 980px;
	color: #ffffff;
	margin: 15px 0 20px 0;
	float: left;
}

.search-gg ul li, .search-gg a {
	margin-left: 10px;
	color: #ffffff;
	float: left;
	list-style-type: none;
}

.search-more {
	color: #fff;
	float: right;
}

.search-question {
	height: 155px;
}

.search-box {
	clear: left;
	float: left;
	padding: 8px;
	height: 50px;
	width: 650px;
	background-color: #ffe400;
}

.search-box .content {
	border: none;
	height: 47px;
	width: 551px;
}

.search-box .answer {
	height: 40px;
	width: 80px;
	background-color: #ffe400;
	border: none;
	font-size: 20px;
	color: #9a6e11;
}

.order-box {
	clear: right;
	float: right;
	margin-right: 10px;
	height: 66px;
	width: 285px;
	background-color: #ffffff;
	display: inline-block;
}

.order-box .text {
	color: #b9b9b9;
}

.text {
	font-weight: bold;
	display: inline-block;
	margin-left: 10px;
	line-height: 20px;
	width: 190px;
	height: 36px;
	font-size: 12px;
}

.btn-01 a {
	position: relative;
	top: -10px;
	color: #fff;
	width: 80px;
	height: 27px;
	margin: -10px 0 10px -10px;
	padding: 10px;
	font-size: 12px;
	background-color: #229ad7;
}

.mt {
	width: 980px;
	height: 55px;
	font-size: 18px;
	float: left;
}

.title {
	float: left;
}

.mc {
	float: left;
}

.xiangqing {
	width: 242px;
	height: 61px;
	float: left;
}

.xiangqing dt {
	width: 61px;
	height: 61px;
	float: left;
}

.xiangqing dd a, .xiangqing dd p {
	width: 165px;
	color: #b4b7ae;
	float: right;
}

.xiangqing dd a {
	margin-left: 7px;
	color: #666;
	font-size: 18px;
	color: #666;
}

.xiangqing dd a:hover {
	color: yellow;
}

.show {
	width: 100px;
	height: 50px;
	background-repeat: no-repeat;
	position: absolute;
	margin-left: 32px;
	margin-top: -45px;
}

.hidden {
	width: 100px;
	height: 50px;
	background-color: inherit;
	position: absolute;
	margin-left: 32px;
	margin-top: -45px;
}
.details-con .con-question li{
	float:left;
	list-style-type:none;
	font-size:25px;
	margin-left:5px;
	padding:1px 25px;
	line-height:40px;
	background-color:#e9e9e9;
}
.details-cons{
	width:980px;
	height:227px;
	background-color:white;
	float:left;
	text-align:left;
	font-size:20px;
}
.details-hidden{
	display:none;
}
.details-cons a{
	color:#585858;
}
.con-question li:hover{
	background-color:yellow;
}
.cons-left,.cons-right{
	float:left;
	text-align:left;
	color:green;
	line-height:35px;
}
.cons-right{
	margin-left:80px;
}

.shopping-nav{
	margin-bottom:10px;
	margin-right:20px;
	float:left;
	width:280px;
	height:186px;
	padding-left:20px;
	background-color:#eaeaea;
}
.shopping-title{
	width:980px;
	height:25px;	
	float:left;
	font-size:14px;
	text-align:left;
	font-weight: normal;
	color:#204d74;
}
.shopping-ul{
	float:left;
	padding:0;
}
.shopping-list{
	float:left;
	width:50%;
	margin-top:10px;
	list-style-type:none;
	text-align:left;
}
.shopping-list a{
	color:#4db7eb;
}
</style>
<script type="text/javascript" src="<%=path %>/assets/js/jquery-1.11.0.js"></script>
<script>
	/*$(document).ready(function() {
		$("#show").hover(
				  function () {
				    $(this).attr("class", "hidden");
				  },
				  function () {
				    $(this).attr("class", "show");
				  }
				);
		/*$("#show").mouseover(function() {
			$("#show").attr("class", "hidden");
		});

		$("#show").mouseout(function() {
			$("#show").attr("class", "show");
		});

		
	})*/
</script>
</head>
<body>
	<div style="width:100%">
	<jsp:include page="header.jsp" />
	</div>
	<div class="header-first">
		<div class="header">
			<div class="header-logo">
				<a href="#"><img src="<%=path %>/assets/images/ltlogo.png" alt="logo"></a> <b
					id="show" class="show"></b>
			</div>
			<div class="head-navigation">
				<ul>
					<li style="background-color: #69bb76"><a href="#">首页</a></li>
					<li><a href="problems.jsp?navclass=2">常见问题</a></li>
					<li><a href="#">自助服务</a></li>
					<li><a href="#">联系客服</a></li>
					<li><a href="#">新手指南</a></li>
				</ul>
			</div>
		</div>
	</div>
	<div class="continer-first">
		<div class="continer">
			<div class="search-question">
				<div class="search-gg">
					<ul>
						<span style="float: left">公告:</span>
						<li><a href="#">李健推荐:围巾电视新品发布</a></li>
						<li><a href="#">科龙空调暖春大促</a></li>
						<li><a href="#">方太闹元宵,赢限量好礼</a></li>
					</ul>
					<div class="search-more">
						<a href="#"><%=path %> 更多></a>
					</div>
				</div>
				<div class="search-box">
					<form action="#" method="post">
						<input type="text" class="content" name=""
							placeholder="在这里输点什么好呢?" /> <input type="submit" class="answer"
							value="提问" />
					</form>
				</div>
				<div class="order-box">
					<p class="text">
						<span>您好!</span> <br> 想了解您订单的相关帮助吗?
					</p>
					<span class="btn-01"><a href="#">请选择订单</a></span>
				</div>
			</div>
		</div>
		<div class="continer-bottom">
			<div class="mt">
				<h3 class="title">常用自助服务</h3>
			</div>
			<div class="mc">
				<dl class="xiangqing">
					<dt>
						<a href="#"><img src="<%=path %>/assets/images/helpimage/yan-1.png" alt="" /></a>
					</dt>
					<dd>
						<a href="#">查询订单</a>
						<p class="">快速查看订单详情丶配送进度丶确认收货等</p>
					</dd>
				</dl>
				<dl class="xiangqing">
					<dt>
						<a href="#"><img src="<%=path %>/assets/images/helpimage/yan-2.png" alt="" /></a>
					</dt>
					<dd>
						<a href="#">查询订单</a>
						<p class="">快速查看订单详情丶配送进度丶确认收货等</p>
					</dd>
				</dl>
				<dl class="xiangqing">
					<dt>
						<a href="#"><img src="<%=path %>/assets/images/helpimage/yan-3.png" alt="" /></a>
					</dt>
					<dd>
						<a href="#">查询订单</a>
						<p class="">快速查看订单详情丶配送进度丶确认收货等</p>
					</dd>
				</dl>
				<dl class="xiangqing">
					<dt>
						<a href="#"><img src="<%=path %>/assets/images/helpimage/yan-4.png" alt="" /></a>
					</dt>
					<dd>
						<a href="#">查询订单</a>
						<p class="">快速查看订单详情丶配送进度丶确认收货等</p>
					</dd>
				</dl>
				<dl class="xiangqing">
					<dt>
						<a href="#"><img src="<%=path %>/assets/images/helpimage/yan-5.png" alt="" /></a>
					</dt>
					<dd>
						<a href="#">查询订单</a>
						<p class="">快速查看订单详情丶配送进度丶确认收货等</p>
					</dd>
				</dl>
				<dl class="xiangqing">
					<dt>
						<a href="#"><img src="<%=path %>/assets/images/helpimage/yan-6.png" alt="" /></a>
					</dt>
					<dd>
						<a href="#">查询订单</a>
						<p class="">快速查看订单详情丶配送进度丶确认收货等</p>
					</dd>
				</dl>
				<dl class="xiangqing">
					<dt>
						<a href="#"><img src="<%=path %>/assets/images/helpimage/yan-7.png" alt="" /></a>
					</dt>
					<dd>
						<a href="#">查询订单</a>
						<p class="">快速查看订单详情丶配送进度丶确认收货等</p>
					</dd>
				</dl>
				<dl class="xiangqing">
					<dt>
						<a href="#"><img src="<%=path %>/assets/images/helpimage/yan-8.png" alt="" /></a>
					</dt>
					<dd>
						<a href="#">查询订单</a>
						<p class="">快速查看订单详情丶配送进度丶确认收货等</p>
					</dd>
				</dl>
			</div>
		</div>
		<div>
			<div class="hot">
				<div class="mt">
					<h3 class="title">热点问题</h3>
				</div>
				<div class="details">
					<div class="details-con">
						<ul class="con-question">
							<li id="con-01">购买咨询</li>
							<li id="con-02">配送查询</li>
							<li id="con-03">付款及退款</li>
							<li id="con-04">售后规则</li>
							<li id="con-05">账户与资产</li>
							<li id="con-06">其它</li>
						</ul>
						<div class="details-cons">
							<div class="cons-left">
								<ul>
									<li><a href="">下单后可以修改订单吗?1</a></li>
									<li><a href="">无货商品几天可以到货?</a></li>
									<li><a href="">合约机资费如何计算</a></li>
									<li><a href="">可以开发票吗?</a></li>
								</ul>
							</div>
							<div class="cons-right">
								<ul>
									<li><a href="">订单如何取消?</a></li>
									<li><a href="">合约机是什么</a></li>
									<li><a href="">如何联系商家</a></li>
								</ul>
							</div>
						</div>
						<div class="details-cons" style="display:none">
							<div class="cons-left">
								<ul>
									<li><a href="">下单后可以修改订单吗?2</a></li>
									<li><a href="">无货商品几天可以到货?</a></li>
									<li><a href="">合约机资费如何计算</a></li>
									<li><a href="">可以开发票吗?</a></li>
								</ul>
							</div>
							<div class="cons-right">
								<ul>
									<li><a href="">订单如何取消?</a></li>
									<li><a href="">合约机是什么</a></li>
									<li><a href="">如何联系商家</a></li>
								</ul>
							</div>
						</div>	
					</div>
					<div class="shopping">
						<div class="shopping-nav">
							<div class="shopping-title"><h3>购物指南</h3></div>
							<ul class="shopping-ul">
								<li class="shopping-list"><a href="#">交易条款</a></li>
								<li class="shopping-list"><a href="#">商品咨询</a></li>
								<li class="shopping-list"><a href="#">购物流程</a></li>
								<li class="shopping-list"><a href="#">促销咨询</a></li>
								<li class="shopping-list"><a href="#">生活旅行/团购</a></li>
								<li class="shopping-list"><a href="#">大家电常见问题</a></li>
							</ul>
						</div>
						<div class="shopping-nav">
							<div class="shopping-title"><h3>购物指南</h3></div>
							<ul class="shopping-ul">
								<li class="shopping-list"><a href="#">交易条款</a></li>
								<li class="shopping-list"><a href="#">商品咨询</a></li>
								<li class="shopping-list"><a href="#">购物流程</a></li>
								<li class="shopping-list"><a href="#">促销咨询</a></li>
								<li class="shopping-list"><a href="#">生活旅行/团购</a></li>
								<li class="shopping-list"><a href="#">大家电常见问题</a></li>
							</ul>
						</div>
						<div class="shopping-nav">
							<div class="shopping-title"><h3>购物指南</h3></div>
							<ul class="shopping-ul">
								<li class="shopping-list"><a href="#">交易条款</a></li>
								<li class="shopping-list"><a href="#">商品咨询</a></li>
								<li class="shopping-list"><a href="#">购物流程</a></li>
								<li class="shopping-list"><a href="#">促销咨询</a></li>
								<li class="shopping-list"><a href="#">生活旅行/团购</a></li>
								<li class="shopping-list"><a href="#">大家电常见问题</a></li>
							</ul>
						</div>
						<div class="shopping-nav">
							<div class="shopping-title"><h3>购物指南</h3></div>
							<ul class="shopping-ul">
								<li class="shopping-list"><a href="#">交易条款</a></li>
								<li class="shopping-list"><a href="#">商品咨询</a></li>
								<li class="shopping-list"><a href="#">购物流程</a></li>
								<li class="shopping-list"><a href="#">促销咨询</a></li>
								<li class="shopping-list"><a href="#">生活旅行/团购</a></li>
								<li class="shopping-list"><a href="#">大家电常见问题</a></li>
							</ul>
						</div>
						<div class="shopping-nav">
							<div class="shopping-title"><h3>购物指南</h3></div>
							<ul class="shopping-ul">
								<li class="shopping-list"><a href="#">交易条款</a></li>
								<li class="shopping-list"><a href="#">商品咨询</a></li>
								<li class="shopping-list"><a href="#">购物流程</a></li>
								<li class="shopping-list"><a href="#">促销咨询</a></li>
								<li class="shopping-list"><a href="#">生活旅行/团购</a></li>
								<li class="shopping-list"><a href="#">大家电常见问题</a></li>
							</ul>
						</div>
						<div class="shopping-nav">
							<div class="shopping-title"><h3>购物指南</h3></div>
							<ul class="shopping-ul">
								<li class="shopping-list"><a href="#">交易条款</a></li>
								<li class="shopping-list"><a href="#">商品咨询</a></li>
								<li class="shopping-list"><a href="#">购物流程</a></li>
								<li class="shopping-list"><a href="#">促销咨询</a></li>
								<li class="shopping-list"><a href="#">生活旅行/团购</a></li>
								<li class="shopping-list"><a href="#">大家电常见问题</a></li>
							</ul>
						</div>
						
					</div>					
				</div>
			</div>
		</div>
	</div>
	<div class="foot">kong</div>
</body>
</html>