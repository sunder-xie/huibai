<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String tPath = request.getContextPath();
String tBasePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+tPath+"/";
tBasePath = tPath;
%>
<style type="text/css">	
body {
	margin: 0px;
	padding: 0px;
}

.footer_box{

background: #f5f5f5;
border-top: 1px solid #e7e7e7;
}
.footer_box_center{
width: 1200px;
margin: 0 auto;
overflow: hidden;
}
.footer_box_top{
	width: 1200px;
	height:80px;
	border-bottom: 1px solid #eaeaea;
}
.footer_box_top dl{
float: left;
width: 240px;
overflow: hidden;
height: 48px;
margin-top: 16px;
}
.footer_box_top dt{
float: left;
width: 48px;
height: 48px;
background: url(<%=tPath%>/images/npbg.png) no-repeat;
overflow: hidden;
margin-right: 8px;
}
.footer_box_top .zheng{
background-position: 0 0;
}
.footer_box_top .jisu{
background-position: -48px 0;
}
.footer_box_top .wuyou{
background-position: -96px 0;
}
.footer_box_top .te{
background-position: -144px 0;
}
.footer_box_top .help{
background-position: -191px 0;
}
.footer_box_top dd{
float: left;
height: 48px;
width: 180px;
margin: 0;
padding: 0;
}
.footer_box_top dd p{
line-height: 24px;
width: 100%;
margin: 0;
padding: 0;
}
.footer_box_top dd p a{
font-size:14px;
color: #545454;
}
.footer_box_help{
float: left;
width: 1200px;
height: 180px;
}
.footer_box_help dl{
margin: 0;
padding: 0;
float: left;
height: 160px;
width:171px;
}
.footer_box_help dt{
width: 100%;
line-height: 40px;
font-weight: 700;
color: #545454;
height: 35px;
font-size: 14px;
overflow: hidden;
}
.footer_box_help dd{
margin: 0;
padding: 0;
width: 100%;
line-height: 22px;
}
.footer_box_help dd a{
color: #545454;
font-size: 12px;
}
.footer_pro{
	position: relative;
	height: 125px;
	background: #33302b;
	min-width: 1200px;
}

.footer_pro_center{
	width: 1200px;
margin: 0px auto;
overflow: hidden;
}
.footer_pro .footer_pro_center dl{
float: left;
height: 100px;
width: 400px;
border-right: 1px dotted #8d8d8d;
border-color: #444;
margin-top: 12px;
}
.footer_pro .footer_pro_center dt{
margin: 0;
padding: 0;
float: left;
height: 80px;
width: 80px;
margin-right: 20px;
margin-top: 5px;
}
.footer_pro .footer_pro_center dd{
margin: 0;
padding: 0;
float: left;
height: 100px;
width: 224px;
}
.footer_pro .footer_pro_center dd .ng-title{
margin: 0;
padding: 0;
line-height: 25px;
font-size: 14px;
font-weight: 700;
color: #eee;
}
.footer_pro .footer_pro_center dd .ng-intro{
margin: 0;
padding: 0;
line-height: 18px;
font-size: 12px;
color: #eee;
}
.footer_pro .footer_pro_center dd .srh-btn{
display: block;
height: 25px;
width: 105px;
margin-top: 5px;
text-indent: -999em;
overflow: hidden;
background: url(<%=tPath%>/images/npbg.png) -140px -49px no-repeat;
}
.footer_pro .footer_pro_center a{
color: #eee;
}
.footer_bottom{
width: 100%;
min-width: 990px;
padding-top: 15px;
background: #33302b;
}
.footer_bottom_cen{
width: 1200px;
min-width: 1200px;
height: 125px;
margin: 0 auto;
}
.footer_bottom_cen p a{
color: #f9f9f9;
font-size: 12px;
}
.footer_bottom_cen span{
color: #888;
padding: 0 8px;
}
.footer_bottom_cen .ng-url-list{
margin: 0;
padding: 0;
line-height: 25px;
height: 25px;
}
.footer_bottom_cen .ng-copyright{
color: #999;
font-size: 12px;
margin-top: 10px;
}
.footer_bottom_bar{
height: 25px;
margin-top: 5px;
}
a {
    text-decoration: none;
}
</style>
<%-- <script src="<%=tPath%>assets/plugs/jquery/jquery-1.11.3.min.js"></script>  --%>
<script type="text/javascript">
$(function (){		
	//获取底部菜单栏菜单
	var b_type='NB' ; 
	var b_sysid='web';
	var param = {type:b_type,sysId:b_sysid};
	$.post('<%=tPath%>'+'/base/menu/getMenuNav.action',param,function(data){
		var items='';
		var maxa=0;
		for(var i=0;i<data.length;i++){
			if(data[i].level==1){			
				items+='<dl><dt>'+data[i].name+'</dt>';
				items+=getBottomChildren(data,data[i].id);
				items+='</dl>';
				maxa+=1;
				if(maxa==5){
					break;
				}
			}
		}
		$("#appendbefore").before(items);
	},'json');

	$(".footer_box_center").on('mouseover mouseout',"a",function(event){
		if(event.type == "mouseover"){
			$(this).css("color","red");
		}else if(event.type == "mouseout"){
			$(this).css("color","");
		 }
	}); 
});
function getBottomChildren(data,pid){
	var items='';
	var maxa=0;
	for(var i=0;i<data.length;i++){
		if(data[i].parentid == pid){
			items+='<dd><a href="'+data[i].url+'" target="_blank">'+data[i].name+'</a></dd>';
			maxa+=1;
			if(maxa==6){
				break;
			}
		}
	}
	return items;
}
</script>
   <div class="site_frame_foot">
	  	     <div class="site_foot">
	<div class="footer_box">
		<div class="footer_box_center">
			<div class="footer_box_top">
				<dl>
					<dt class="zheng"></dt>
					<dd>
						<p><strong><a href="" target="_blank">正品保障</a></strong></p>
						<p>正品保障，提供发票</p>
					</dd>
				</dl>
				<dl>
					<dt class="jisu"></dt>
					<dd>
					<p><strong><a href="" target="_blank">急速物流</a></strong></p>
					<p>急速物流，急速送达</p>
					</dd>
				</dl>
				<dl>
					<dt class="wuyou"></dt>
					<dd>
					<p><strong><a href="" target="_blank">无忧售后</a></strong></p>
					<p>7天无理由退换货</p>
					</dd>
				</dl>
				<dl>
					<dt class="te"></dt>
					<dd>
					<p><strong><a href="" target="_blank" >特色服务</a></strong></p>
					<p>私人定制家电套餐</p>
					</dd>
				</dl>
				<dl>
					<dt class="help"></dt>
					<dd>
					<p><strong><a href="" target="_blank">帮助中心</a></strong></p>
					<p>您的购物指南</p>
					</dd>
				</dl>				
			</div>
			<div class="footer_box_help ">
				
				<dl id="appendbefore">
					<dt>手机客户端</dt>
					<a href="" target="_blank">
						<img src="<%=tPath%>/images/qrcode/app_qrcode.png" alt="汇百百材APP二维码" height="87" width="87">
					</a>
				</dl>
				<dl >
					<dt>微信公众号</dt>
					<a href="" target="_blank">
						<img src="<%=tPath%>/images/qrcode/weixin_qrcode_258x258.jpg" alt="汇百百材APP二维码" height="87" width="87">
					</a>
				</dl>
			</div>
		</div>
	</div>
	
	<div class="footer_pro">
	        <div class="footer_pro_center">
			<dl>
				<dt><a href="" target="_blank"><img src="<%=tPath%>/images/f1.png" height="80" width="80"></a>
				</dt>
				<dd>
					<p class="ng-title"><a href="">政企采购</a></p>
					<p class="ng-intro"><a href="">为企业用户量身定做的采购平台，优选汇百全站商品，为企业采购提供专业化的一站式采购解决方案。</a></p>
				</dd>
			</dl>
			
			<dl style="margin-left:20px">
				<dt><a href="" target="_blank"><img src="<%=tPath%>/images/f2.png" height="80" width="80"></a>
				</dt>
				<dd>
					<p class="ng-title"><a href="">汇百众包</a></p>
					<p class="ng-intro"><a href="">以汇百全渠道包销为主要特点，整合全社会众包资源，扶持创新企业，推广创新产品。</a></p>
				</dd>
			</dl>
			
			<dl style="width: 350px; border-right: none; margin-left: 20px;">
				<dt style="background: url(<%=tPath%>/images/npbg.png) -40px -60px no-repeat;">
				</dt>
				<dd>
					<p class="ng-title">身边汇百</p>
					<p class="ng-intro">全国300个城市1600家门店3000个服务点为您提供最贴心的服务！</p>
					<a class="srh-btn" href="../../Banner/GetHome_FooterBarInfo.action" target="_blank"></a>
				</dd>
			</dl>
			</div>
	</div>
	<div class="footer_bottom">
		<div class="footer_bottom_cen">
			<p class="ng-url-list">
				<a href="" target="_blank">汇百云商</a><span>|</span>
				<a href="" target="_blank">汇百互联</a><span>|</span>
				<a href="" target="_blank">汇百金融</a><span>|</span>
				<a href="" target="_blank">汇百物流</a><span>|</span>
				
				<a href="" target="_blank">手机汇百</a>
			</p>
			<p class="ng-url-list">
				<a href="" target="_blank">关于汇百</a><span>|</span>
				<a href="" target="_blank">联系我们</a><span>|</span>
				<a href="" target="_blank">诚聘英才</a><span>|</span>
				<a href="" target="_blank">供应商入驻</a><span>|</span>
				<a href="" target="_blank">汇百联盟</a><span>|</span>
				<a href="" target="_blank">汇百招标</a><span>|</span>
				<a href="" target="_blank">友情链接</a><span>|</span>
				<a href="" target="_blank">法律申明</a><span>|</span>
				<a href="" target="_blank">用户体验提升计划</a><span>|</span>
				<a href="" target="_blank">股东会员认证</a>
			</p>
			<p class="ng-copyright">
				Copyright© 2016 ，内蒙古汇百科技有限公司版权所有
				<a href="" target="_blank" style="color:#999">蒙ICP备16004629号</a>
			</p>
			<div class="footer_bottom_bar">
				<a href="" target="_blank">
				<img src="<%=tPath%>/images/chengxin.png" alt="诚信网站" height="24" width="76">
				</a>
			</div>
		</div>
	</div>
	
	</div>
	</div>