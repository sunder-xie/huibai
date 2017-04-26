<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String tPath = request.getContextPath();
String tBasePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+tPath+"/";
%>

<style type="text/css">
body{margin:0px;padding:0px;
}
a {
    color: #666;
    text-decoration: none;
}
#service-2014 .slogen {
    position: relative;
    height: 54px;
    padding: 10px 0;
    margin-bottom: 4px;
    background: #F5F5F5;
    text-align: center;
}
#service-2014 .slogen .fore1 {
    margin-left: -490px;
}
#service-2014 .slogen .item {
    display: inline-block;
    position: absolute;
    left: 50%;
    top: 20px;
    width: 245px;
    height: 54px;
    text-align: left;
    vertical-align: middle;
    font: 400 18px/50px;
}
#service-2014 .slogen .fore1 i {
    background-image: url(//misc.360buyimg.com/jdf/1.0.0/unit/service/1.0.0/i/service_items_1.png);
}
#service-2014 .slogen .item i {
    display: block;
    position: absolute;
    top: 0;
    left: 10px;
    width: 220px;
    height: 54px;
    background-repeat: no-repeat;
    background-position: 0 0;
}
em, i, u {
    font-style: normal;
}
#service-2014 .slogen .item b {
    padding: 0 10px;
    font-size: 24px;
    color: #C81623;
}
#service-2014 .slogen .fore2 {
    margin-left: -245px;
}
#service-2014 .slogen .fore3 {
    margin-left: 0;
}
#service-2014 .slogen .fore4 {
    margin-left: 245px;
}
.w {
    width: 990px;
    margin: 0 auto;
}
#service-2014 dl {
    float: left;
    width: 222px;
}
#service-2014 dt {
    padding: 6px 0;
    font-size: 16px;
}
#service-2014 dd div{
margin-top: 4px;
}
#service-2014 dd {
    line-height: 20px;
	margin-left:0px;
	font-size:14px;
}
#service-2014 dl.fore5 {
    width: 100px;
}
.clr {
    display: block;
    overflow: hidden;
    clear: both;
    height: 0;
    line-height: 0;
    font-size: 0;
}
#footer-2014 {
    border-top: 1px solid #E5E5E5;
    padding: 20px 0 0px;
    text-align: center;
}
#footer-2014 .links a {
    margin: 0 10px;
}

#footer-2014 .button {
    margin: 10px 0;
}
#footer-2014 .authentication a {
    margin: 0 5px;
    text-decoration: none;
	font-size:14px;
}
.he-footer a{
color:#333333;}
.links{
	font-size:13px;}
.button span{
	font-size:12px;
	color: #333333;
	margin-top: 4px;
}
</style>
<script type="text/javascript" src="<%=tPath%>/assets/js/jquery-1.11.0.js"></script>
<script type="text/javascript">
   $(function (){		
		$(".he-footer a").hover(
  			function () {
    				$(this).css("color","red");
 				 },
  			function () {
					$(this).css("color","");
  					}
				);
		
		
		});
</script>
	
      <div class="he-footer">
    <div id="service-2014">
	<div class="slogen">
		<span class="item fore1">
			<i></i><b>多</b>品类齐全，轻松购物
		</span>
		<span class="item fore2">
			<i></i><b>快</b>多仓直发，极速配送
		</span>
		<span class="item fore3">
			<i></i><b>好</b>正品行货，精致服务
		</span>
		<span class="item fore4">
			<i></i><b>省</b>天天低价，畅选无忧
		</span>
	</div>
	<div class="w">
		<dl class="fore1">
			<dt>购物指南</dt>
			<dd>
				<div><a rel="nofollow" target="_blank" href="http://help.jd.com/user/issue/list-29.html">购物流程</a></div>
				<div><a rel="nofollow" target="_blank" href="http://help.jd.com/user/issue/list-151.html">会员介绍</a></div>
				<div><a rel="nofollow" target="_blank" href="http://help.jd.com/user/issue.html">常见问题</a></div>
				<div><a rel="nofollow" target="_blank" href="http://help.jd.com/user/issue/list-136.html">大家电</a></div>
				<div><a rel="nofollow" target="_blank" href="http://help.jd.com/user/index.html">联系客服</a></div>
			</dd>
		</dl>
		<dl class="fore2">		
			<dt>配送方式</dt>
			<dd>
				<div><a rel="nofollow" target="_blank" href="http://help.jd.com/user/issue/list-81-100.html">上门自提</a></div>
				<div><a rel="nofollow" target="_blank" href="http://help.jd.com/user/issue/list-81.html">211限时达</a></div>
				<div><a rel="nofollow" target="_blank" href="http://help.jd.com/user/issue/103-983.html">配送服务查询</a></div>
				<div><a rel="nofollow" target="_blank" href="http://help.jd.com/user/issue/109-188.html">配送费收取标准</a></div>				
				<div><a target="_blank" href="http://en.jd.com/chinese.html">海外配送</a></div>
			</dd>
		</dl>
		<dl class="fore3">
			<dt>支付方式</dt>
			<dd>
				<div><a rel="nofollow" target="_blank" href="http://help.jd.com/user/issue/list-172.html">货到付款</a></div>
				<div><a rel="nofollow" target="_blank" href="http://help.jd.com/user/issue/list-173.html">在线支付</a></div>
				<div><a rel="nofollow" target="_blank" href="http://help.jd.com/user/issue/list-176.html">分期付款</a></div>
				<div><a rel="nofollow" target="_blank" href="http://help.jd.com/user/issue/list-174.html">邮局汇款</a></div>
				<div><a rel="nofollow" target="_blank" href="http://help.jd.com/user/issue/list-175.html">公司转账</a></div>
			</dd>
		</dl>
		<dl class="fore4">		
			<dt>售后服务</dt>
			<dd>
				<div><a rel="nofollow" target="_blank" href="http://help.jd.com/user/issue/321-981.html">售后政策</a></div>
				<div><a rel="nofollow" target="_blank" href="http://help.jd.com/user/issue/list-132.html">价格保护</a></div>
				<div><a rel="nofollow" target="_blank" href="http://help.jd.com/user/issue/130-978.html">退款说明</a></div>
				<div><a rel="nofollow" target="_blank" href="http://myjd.jd.com/repair/repairs.action">返修/退换货</a></div>
				<div><a rel="nofollow" target="_blank" href="http://help.jd.com/user/issue/list-50.html">取消订单</a></div>
			</dd>
		</dl>
		<dl class="fore5">
			<dt>关于我们</dt>
			<dd>		
				<div><a target="_blank" href="http://help.jd.com/user/issue/list-133.html">企业文化</a></div>
				<div><a target="_blank" href="http://help.jd.com/user/issue/list-134.html">我们是谁</a></div>
				<div><a rel="nofollow" target="_blank" href="http://fuwu.jd.com/">商家入驻</a></div>				
				<div><a rel="nofollow" target="_blank" href="http://mobile.jd.com/">全国售后网店</a></div>
			</dd>
		</dl>
		<span class="clr"></span>
	</div>
</div>
    <div class="w">
	<div id="footer-2014">
		<div class="links">
			<a rel="nofollow" target="_blank" href="http://www.jd.com/intro/about.aspx">关于我们</a>|
			<a rel="nofollow" target="_blank" href="http://www.jd.com/contact/">联系我们</a>|
			<a rel="nofollow" target="_blank" href="http://www.jd.com/contact/joinin.aspx">商家入驻</a>|
			<a rel="nofollow" target="_blank" href="http://jzt.jd.com">友情链接</a>|
			<a rel="nofollow" target="_blank" href="http://app.jd.com/">站点地图</a>|
			<a target="_blank" href="http://club.jd.com/links.aspx">手机商城</a>|
			<a target="_blank" href="http://media.jd.com/">销售联盟</a>|
			<a href="http://club.jd.com/" target="_blank">商城社区</a>|
			<a href="http://gongyi.jd.com" target="_blank">企业文化</a>|
			<a href="http://en.jd.com/" target="_blank">帮助中心</a>
		</div>
		<div class="button">
			<span>ICP备案证书号:沪ICP备XXXXXXXXXX号-2</span><br/>
			<span> © 2005-2016 乐汇百材电子商城 版权所有，并保留所有权利。 </span><br/>
			<span>上海市XXXXXXXXX Tel: 4008888888 E-mail: shangwu@lehuibaicai.com QQ 4008888888</span>
		</div>		
	</div>
</div>
</div>