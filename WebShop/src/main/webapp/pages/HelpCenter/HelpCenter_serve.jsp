<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String tPath = request.getContextPath();
String tBasePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+tPath+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
body{margin:0px;
	padding:0px;
	background-color: #f9f9f9;
}
.bg-fff, .bg-white {
    background-color: #fff;
    overflow: hidden;
    *zoom: 1;
}
.pd-box-b20 {
    height: 290px;
}
.w {
    width: 990px;
    margin: 0 auto;
}
.mod-h01 {
    margin-bottom: 0;
}
.m, .sm {
    margin-bottom: 10px;
}
.m, .mt, .mc, .mb, .sm, .smt, .smc, .smb {
    overflow: hidden;
    *zoom: 1;
}
.mod-h01 .mt {
    height: 58px;
    line-height: 55px;
}
.mt, .smt {
    cursor: default;
}
.mod-h01 .mt .title {
    font-size: 18px;
    font-family: "microsoft yahei";
    color: #333;
    margin: 0;
	padding: 0;
}
.self-service-box .mc {
    height: 230px;
}
.self-service-list {
    float: left;
    padding-left: 20px;
    padding-right: 10px;
    width: 215px;
    margin-bottom: 30px;
}
.self-service-list .ds-icon {
    float: left;
    padding-right: 10px;
    position: relative;
}
.self-service-list .ds-content {
	margin-top: -16px;
}
.self-service-list .link-img {
    display: block;
    width: 61px;
    height: 61px;
}
.link-img01 {
    background-image: url("images/dsicon01.jpg");
}
.link-img02 {
    background-image: url("images/dsicon02.jpg");
}
.link-img03 {
    background-image: url("images/dsicon03.jpg");
}
.link-img04 {
    background-image: url("images/dsicon04.jpg");
}
.link-img05 {
    background-image: url("images/dsicon05.jpg");
}
.link-img06 {
    background-image: url("images/dsicon06.jpg");
}
.link-img07 {
    background-image: url("images/dsicon07.jpg");
}
.link-img08 {
    background-image: url("images/dsicon08.jpg");

}
a {
    color: #666;
    text-decoration: none;
}
.self-service-list .ds-name {
    font-size: 16px;
    font-family: "microsoft yahei";
    margin-bottom: -10px;
}
.self-service-list .text {
    color: #b4b7ae;
	font-size:14px;
    height: 40px;
    overflow: hidden;
}
.w-center {
    width: 100%;
    height: 600px;
    background: #f9f9f9;
}
.w {
    width: 990px;
    margin: 0 auto;
}
.all-selfservice-box {
    margin-bottom: 60px;
}
.mod-h01 .mt {
    height: 58px;
    line-height: 55px;
}
.mt, .smt {
    cursor: default;
}
.all-selfservice-box .lump01 {
    margin-bottom: 10px;
}
.all-selfservice-box .lump02 .smt {
    background-position: -41px 0;
}
.all-selfservice-box .lump03 .smt {
    background-position: -82px 0;
}
.all-selfservice-box .smt {
    float: left;
    width: 21px;
    padding-left: 12px;
    padding-right: 8px;
    height: 106px;
    background-image: url("images/self-tit.gif");
    font-size: 16px;
    color: #fff;
    font-family: "microsoft yahei";
    text-align: center;
    padding-top: 62px;
}
.mt, .smt {
    cursor: default;
}
.all-selfservice-box .smc {
    float: left;
}
.all-selfservice-box .lump-list {
    float: left;
    width: 235px;
    padding-right: 2px;
    margin: 0px;
}
.all-selfservice-box .lump-title {
    background-color: #eaeaea;
    height: 33px;
    line-height: 33px;
    font-weight: bold;
    font-size: 14px;
    padding-left: 15px;
    color: #666;
}
.all-selfservice-box .lump-cnt {
    padding: 15px 10px;
    line-height: 20px;
    overflow: hidden;
    margin:0px;
    background-color: #fff;
    height: 105px;
}
ol, ul {
    list-style: none;
    margin: 0px;
    padding: 0px;
}
.all-selfservice-box .list-normal a {
    color: #999;
    font-size: 12px;
}

</style>
<script type="text/javascript" src="<%=tPath%>/assets/js/jquery-1.11.0.js"></script>
<script type="text/javascript">
$(function (){
	$(".ds-icon").hover(
		function(){
			$(this).children().css("opacity","0.7");	
		},
		function(){
			$(this).children().css("opacity","1");
		}
	);
	$(".self-service-list .ds-name a").hover(
			function(){
				$(this).css("color","#8fc7f9");	
			},
			function(){
				$(this).css("color","#666");
			}
		);
	$(".sm.lump01 .lump-list").hover(
			function(){
				$(this).children().eq(0).css("background-color","#f2cf62");	
			},
			function(){
				$(this).children().eq(0).css("background-color","#eaeaea");	
			}
		);
	$(".sm.lump02 .lump-list").hover(
			function(){
				$(this).children().eq(0).css("background-color","#8fc7f9");	
			},
			function(){
				$(this).children().eq(0).css("background-color","#eaeaea");	
			}
		);
	$(".sm.lump03 .lump-list").hover(
			function(){
				$(this).children().eq(0).css("background-color","#9ad9a4");	
			},
			function(){
				$(this).children().eq(0).css("background-color","#eaeaea");	
			}
		);
	$(".mc a").hover(
			function(){
				$(this).css("color","red");	
			},
			function(){
				$(this).css("color","#999");	
			}
		);
	
});

</script>
</head>
<body>
<div style="width:100%">
	<jsp:include page="../HomePages/home_topbar.jsp" />
	<jsp:include page="header.jsp" />
</div>
<div class="bg-white pd-box-b20">
    <div class="w">
    <div class="m mod-h01 self-service-box">
    <div class="mt">
        <h3 class="title">
            常用自助服务
        </h3>
    </div>
    <div class="mc">
        <dl class="self-service-list">
            <dt class="ds-icon">
                <a class="link-img link-img01" href="//order.jd.com/center/list.action" target="_blank"></a>
            </dt>
            <dd class="ds-content">
                <h3 class="ds-name">
                    <a href="//order.jd.com/center/list.action" target="_blank">查询订单</a>
                </h3>
                <p class="text">
                    快速查看订单详情、配送进度、确认收货等
                </p>
            </dd>
        </dl>
        <dl class="self-service-list">
            <dt class="ds-icon">
                <a class="link-img link-img02" href="//myjd.jd.com/reminder/reminderlist.action" target="_blank"></a>
            </dt>
            <dd class="ds-content">
                <h3 class="ds-name">
                    <a href="//myjd.crm.jd.com/reminder/reminderlist.action" target="_blank">我要催单</a>
                </h3>
                <p class="text">
                    催发货、催配送、1小时快速答复
                </p>
            </dd>
        </dl>
        <dl class="self-service-list">
            <dt class="ds-icon">
                <a class="link-img link-img03" href="//help.jd.com/user/issue/103-983.html" target="_blank"></a>
            </dt>
            <dd class="ds-content">
                <h3 class="ds-name">
                    <a href="//help.jd.com/user/issue/103-983.html" target="_blank">查询配送服务</a>
                </h3>
                <p class="text">
                    查看您所在地址支持的配送服务类型和时效
                </p>
            </dd>
        </dl>
        <dl class="self-service-list">
            <dt class="ds-icon">
                <a class="link-img link-img04" href="//help.jd.com/user/issue/321-981.html" target="_blank" clstag="pageclick|keycount|service_201502105|4"></a>
            </dt>
            <dd class="ds-content">
                <h3 class="ds-name">
                    <a href="//help.jd.com/user/issue/321-981.html" target="_blank" clstag="pageclick|keycount|service_201502105|4">查询售后政策</a>
                </h3>
                <p class="text">
                    查看退换货/维修规则、处理流程
                </p>
            </dd>
        </dl>
        <dl class="self-service-list">
            <dt class="ds-icon">
                <a class="link-img link-img05" href="//myjd.jd.com/repair/orderlist.action" target="_blank" clstag="pageclick|keycount|service_201502105|5"></a>
            </dt>
            <dd class="ds-content">
                <h3 class="ds-name">
                    <a href="//myjd.jd.com/repair/orderlist.action" target="_blank" clstag="pageclick|keycount|service_201502105|5">申请退换货</a>
                </h3>
                <p class="text">
                    快速提交退换货/维修申请查看处理进度、退款记录
                </p>
            </dd>
        </dl>
        <dl class="self-service-list">
            <dt class="ds-icon">
                <a class="link-img link-img06" href="//mymoney.jd.com/finance/recently.action" target="_blank" clstag="pageclick|keycount|service_201502105|6"></a>
            </dt>
            <dd class="ds-content">
                <h3 class="ds-name">
                    <a href="//mymoney.jd.com/finance/recently.action" target="_blank">查询余额</a>
                </h3>
                <p class="text">
                    查询账户余额、消费记录、退款明细、余额充值
                </p>
            </dd>
        </dl>
        <dl class="self-service-list">
            <dt class="ds-icon">
                <a class="link-img link-img07" href="//order.jd.com/center/list.action" target="_blank" clstag="pageclick|keycount|service_201502105|7"></a>
            </dt>
            <dd class="ds-content">
                <h3 class="ds-name">
                    <a href="//order.jd.com/center/list.action" target="_blank" clstag="pageclick|keycount|service_201502105|7">取消订单</a>
                </h3>
                <p class="text">
                    申请取消订单、终止发货（限自营商品）
                </p>
            </dd>
        </dl>
        <dl class="self-service-list">
            <dt class="ds-icon">
                <a class="link-img link-img08" href="//safe.jd.com/user/paymentpassword/safetyCenter.action" target="_blank" clstag="pageclick|keycount|service_201502105|8"></a>
            </dt>
            <dd class="ds-content">
                <h3 class="ds-name">
                    <a href="//safe.jd.com/user/paymentpassword/safetyCenter.action" target="_blank" clstag="pageclick|keycount|service_201502105|8">账户安全</a>
                </h3>
                <p class="text">
                    修改密码、绑定手机、提高账户安全等
                </p>
            </dd>
        </dl>
    </div>
</div>
    </div>
</div>

<div class="w-center">
<div class="w">
    <div class="m mod-h01 all-selfservice-box">
    <div class="mt">
        <h3 class="title">
            全部自助服务
        </h3>
    </div>
    <div class="mc">
        <div class="sm lump01">
            <div class="smt">
                账户管理
            </div>
            <div class="smc">
                <dl class="lump-list">
                    <dt class="lump-title">
                        注册登录
                    </dt>
                    <dd class="lump-cnt">
                        <ul class="list-normal">
                            <li class="list-item">
                                <a href="//reg.jd.com/reg/person?ReturnUrl=http%3A%2F%2Fwww.jd.com" target="_blank" clstag="pageclick|keycount|service_201502105|9">注册账户</a>
                            </li>
                            <li class="list-item">
                                <a href="//safe.jd.com/findPwd/index.action" target="_blank" clstag="pageclick|keycount|service_201502105|10">找回登录密码</a>
                            </li>
                            <li class="list-item">
                                <a href="//safe.jd.com/user/paymentpassword/findByPin.action" target="_blank" clstag="pageclick|keycount|service_201502105|11">开启支付密码</a>
                            </li>
                            <li class="list-item">
                                <a href="//reg.jd.com/reg/company" target="_blank" clstag="pageclick|keycount|service_201502105|12">注册企业用户</a>
                            </li>
                        </ul>
                    </dd>
                </dl>
                <dl class="lump-list">
                    <dt class="lump-title">
                        安全中心
                    </dt>
                    <dd class="lump-cnt">
                        <ul class="list-normal">
                            <li class="list-item">
                                <a href="//safe.jd.com/user/paymentpassword/safetyCenter.action" target="_blank" clstag="pageclick|keycount|service_201502105|13">我的安全级别</a>
                            </li>
                            <li class="list-item">
                                <a href="//safe.jd.com/validate/updatePassword" target="_blank" clstag="pageclick|keycount|service_201502105|14">修改登录密码</a>
                            </li>
                            <li class="list-item">
                                <a href="//safe.jd.com/user/paymentpassword/findByPin.action" target="_blank" clstag="pageclick|keycount|service_201502105|15">修改支付密码</a><em class="icon-hot">hot</em>
                            </li>
                            <li class="list-item">
                                <a href="//safe.jd.com/validate/updateMail" target="_blank" clstag="pageclick|keycount|service_201502105|16">修改邮箱</a>
                            </li>
                            <li class="list-item">
                                <a href="//safe.jd.com/validate/updateMobile" target="_blank" clstag="pageclick|keycount|service_201502105|17">修改手机</a>
                            </li>                          
                        </ul>
                    </dd>
                </dl>
                <dl class="lump-list">
                    <dt class="lump-title">
                       		 个人信息
                    </dt>
                    <dd class="lump-cnt">
                        <ul class="list-normal">
                            <li class="list-item">
                                <a href="//i.jd.com/user/info" target="_blank" clstag="pageclick|keycount|service_201502105|19">基本信息</a>
                            </li>
                            <li class="list-item">
                                <a href="//usergrade.jd.com/user/grade" target="_blank" clstag="pageclick|keycount|service_201502105|20">我的级别</a>
                            </li>
                            <li class="list-item">
                                <a href="//vip.jd.com/" target="_blank" clstag="pageclick|keycount|service_201502105|21">京东会员</a><em class="icon-hot">hot</em>
                            </li>
                            <li class="list-item">
                                <a href="//easybuy.jd.com/address/getEasyBuyList.action" target="_blank" clstag="pageclick|keycount|service_201502105|22">收货地址</a>
                            </li>
                            <li class="list-item">
                                <a href="//easybuy.jd.com/address/getEasyBuyList.action" target="_blank" clstag="pageclick|keycount|service_201502105|23">轻松购</a>
                            </li>
                        </ul>
                    </dd>
                </dl>
                <dl class="lump-list">
                    <dt class="lump-title">
                        消息订阅
                    </dt>
                    <dd class="lump-cnt">
                        <ul class="list-normal">
                            <li class="list-item">
                                <a href="//edm.jd.com/front/subscribe/index.aspx" target="_blank" clstag="pageclick|keycount|service_201502105|25">邮件订阅</a>
                            </li>
                            <li class="list-item">
                                <a href="//share.jd.com/share/index.html" target="_blank" clstag="pageclick|keycount|service_201502105|26">分享设置</a>
                            </li>
                            <li class="list-item">
                                <a href="//joycenter.jd.com/msgCenter/queryHistoryMessage.action" target="_blank" clstag="pageclick|keycount|service_201502105|27">消息精灵</a>
                            </li>
                            <li class="list-item">
                                <a href="//luck.jd.com/myjd/myJoinActivity.html" target="_blank" clstag="pageclick|keycount|service_201502105|28">我的活动</a>
                            </li>
                            <li class="list-item">
                                <a href="//t.jd.com/home/follow" target="_blank" clstag="pageclick|keycount|service_201502105|29">我的关注</a>
                            </li>
                        </ul>
                    </dd>
                </dl>
            </div>
        </div>
        <div class="sm lump02">
            <div class="smt">
                交易管理
            </div>
            <div class="smc">
                <dl class="lump-list">
                    <dt class="lump-title">
                        我的订单
                    </dt>
                    <dd class="lump-cnt">
                        <ul class="list-normal">
                            <li class="list-item">
                                <a href="//myjd.jd.com/reminder/reminderlist.action" target="_blank" clstag="pageclick|keycount|service_201502105|30">我要催单</a><em class="icon-hot">hot</em>
                            </li>
                            <li class="list-item">
                                <a href="//order.jd.com/center/list.action" target="_blank" clstag="pageclick|keycount|service_201502105|31">查询订单</a>
                            </li>
                            <li class="list-item">
                                <a href="//order.jd.com/center/list.action" target="_blank" clstag="pageclick|keycount|service_201502105|32">取消订单</a><em class="icon-hot">hot</em>
                            </li>
                            <li class="list-item">
                                <a href="//club.jd.com/mycomments.aspx" target="_blank" clstag="pageclick|keycount|service_201502105|33">评价/晒单</a>
                            </li>
                            <li class="list-item">
                                <a href="//usergrade.jd.com/user/consume" target="_blank" clstag="pageclick|keycount|service_201502105|34">消费记录</a>
                            </li>
                        </ul>
                    </dd>
                </dl>
                <dl class="lump-list">
                    <dt class="lump-title">
                        我的资产
                    </dt>
                    <dd class="lump-cnt">
                        <ul class="list-normal">
                            <li class="list-item">
                                <a href="//mymoney.jd.com/finance/recently.action" target="_blank" clstag="pageclick|keycount|service_201502105|35">余额查询</a>
                            </li>
                            <li class="list-item">
                                <a href="//bean.jd.com/myJingBean/list" target="_blank" clstag="pageclick|keycount|service_201502105|36">京豆明细</a><em class="icon-hot">hot</em>
                            </li>
                            <li class="list-item">
                                <a href="//quickpay.jd.com/bankCard.action" target="_blank" clstag="pageclick|keycount|service_201502105|37">快捷支付管理</a>
                            </li>
                            <li class="list-item">
                                <a href="//baitiao.jd.com/creditUser/record" target="_blank" clstag="pageclick|keycount|service_201502105|38">白条还款/明细</a>
                            </li>
                            <li class="list-item">
                                <a href="//jinku.pay.jd.com/xjk/income.action" target="_blank" clstag="pageclick|keycount|service_201502105|39">我的小金库</a>
                            </li>
                        </ul>
                    </dd>
                </dl>
                <dl class="lump-list">
                    <dt class="lump-title">
                        优惠券/京东E卡
                    </dt>
                    <dd class="lump-cnt">
                        <ul class="list-normal">
                            <li class="list-item">
                                <a href="//quan.jd.com/user_quan.action" target="_blank" clstag="pageclick|keycount|service_201502105|40">查询优惠券</a>
                            </li>
                            <li class="list-item">
                                <a href="//quan.jd.com/user_quan_active.action" target="_blank" clstag="pageclick|keycount|service_201502105|41">实体券激活</a>
                            </li>
                            <li class="list-item">
                                <a href="//active.coupon.jd.com/ilink/ex/change_index.action" target="_blank" clstag="pageclick|keycount|service_201502105|42">优惠券兑换</a>
                            </li>
                            <li class="list-item">
                                <a href="//giftcard.jd.com/giftcard/index.action" target="_blank" clstag="pageclick|keycount|service_201502105|43">京东E卡绑定/查询</a>
                            </li>
                            <li class="list-item">
                                <a href="//giftcard.jd.com/giftcard/bindingClosedList.action#bindingClosedList" target="_blank" clstag="pageclick|keycount|service_201502105|44">京东E卡消费记录</a>
                            </li>
                        </ul>
                    </dd>
                </dl>
                <dl class="lump-list">
                    <dt class="lump-title">
                        特色订单
                    </dt>
                    <dd class="lump-cnt">
                        <ul class="list-normal">
                            <li class="list-item">
                                <a href="//yushou.jd.com/member/qualificationList.action" target="_blank" clstag="pageclick|keycount|service_201502105|45">预约/预售</a>
                            </li>
                            <li class="list-item">
                                <a href="//life.jd.com/localOrder/iniOrder.do" target="_blank" clstag="pageclick|keycount|service_201502105|46">本地生活订单</a>
                            </li>
                            <li class="list-item">
                                <a href="//ding.jd.com/plan/showPlans.action" target="_blank" clstag="pageclick|keycount|service_201502105|47">定期送</a>
                            </li>
                            <li class="list-item">
                                <a href="//tuan.jd.com/myjph/orderList.html" target="_blank" clstag="pageclick|keycount|service_201502105|48">团购订单</a>
                            </li>
                            <li class="list-item">
                                <a href="//dujia.jd.com/order/orderList.html" target="_blank" clstag="pageclick|keycount|service_201502105|49">旅行订单</a>
                            </li>
                        </ul>
                    </dd>
                </dl>
            </div>
        </div>
        <div class="sm lump03">
            <div class="smt">
                客户服务
            </div>
            <div class="smc">
                <dl class="lump-list">
                    <dt class="lump-title">
                        新手教学
                    </dt>
                    <dd class="lump-cnt">
                        <ul class="list-normal">
                            <li class="list-item">
                                <a href="//help.jd.com/user/guide.html" target="_blank" clstag="pageclick|keycount|service_201502105|51">如何注册</a>
                            </li>
                            <li class="list-item">
                                <a href="//help.jd.com/user/guide.html" target="_blank" clstag="pageclick|keycount|service_201502105|52">如何搜索商品</a>
                            </li>
                            <li class="list-item">
                                <a href="//help.jd.com/user/guide.html" target="_blank" clstag="pageclick|keycount|service_201502105|53">如何下单购买</a>
                            </li>
                            <li class="list-item">
                                <a href="//help.jd.com/user/guide.html" target="_blank" clstag="pageclick|keycount|service_201502105|54">如何在线支付</a>
                            </li>
                            <li class="list-item">
                                <a href="//help.jd.com/user/guide.html" target="_blank" clstag="pageclick|keycount|service_201502105|55">如何评价晒单</a>
                            </li>
                        </ul>
                    </dd>
                </dl>
                <dl class="lump-list">
                    <dt class="lump-title">
                        订单服务
                    </dt>
                    <dd class="lump-cnt">
                        <ul class="list-normal">
                            <li class="list-item">
                                <a href="//sitepp-fm.jd.com/" target="_blank" clstag="pageclick|keycount|service_201502105|56">申请价保</a>
                            </li>
                            <li class="list-item">
                                <a href="//myjd.jd.com/afs/list/financeInfoList.action" target="_blank" clstag="pageclick|keycount|service_201502105|57">退款查询</a><em class="icon-hot">hot</em>
                            </li>
                            <li class="list-item">
                                <a href="//rps.fm.jd.com/rest/refund/refundList" target="_blank" clstag="pageclick|keycount|service_201502105|58">取消订单记录</a>
                            </li>
                            <li class="list-item">
                                <a href="//myjd.jd.com/opinion/orderList.action" target="_blank" clstag="pageclick|keycount|service_201502105|59">意见建议</a>
                            </li>
                            <li class="list-item">
                                <a href="//club.jd.com/myjd/userConsultationList_1.html" target="_blank" clstag="pageclick|keycount|service_201502105|60">购买咨询</a>
                            </li>
                        </ul>
                    </dd>
                </dl>
                <dl class="lump-list">
                    <dt class="lump-title">
                        配送服务
                    </dt>
                    <dd class="lump-cnt">
                        <ul class="list-normal">
                            <li class="list-item">
                                <a href="//order.jd.com/center/list.action" target="_blank" clstag="pageclick|keycount|service_201502105|61">配送进度查询</a>
                            </li>
                            <li class="list-item">
                                <a href="//help.jd.com/user/issue/103-983.html" target="_blank" clstag="pageclick|keycount|service_201502105|62">配送服务查询</a><em class="icon-hot">hot</em>
                            </li>
                            <li class="list-item">
                                <a href="//help.jd.com/help/question-897.html" target="_blank" clstag="pageclick|keycount|service_201502105|63">自提站点查询</a>
                            </li>
                            <li class="list-item">
                                <a href="//help.jd.com/user/issue/109-188.html" target="_blank" clstag="pageclick|keycount|service_201502105|64">配送费查询</a>
                            </li>
                            <li class="list-item">
                                <a href="//www.jd-ex.com/" target="_blank" clstag="pageclick|keycount|service_201502105|71">运单查询</a><em class="icon-hot">hot</em>
                            </li>
                        </ul>
                    </dd>
                </dl>
                <dl class="lump-list">
                    <dt class="lump-title">
                        售后服务
                    </dt>
                    <dd class="lump-cnt">
                        <ul class="list-normal">
                            <li class="list-item">
                                <a href="//help.jd.com/user/issue/321-981.html" target="_blank" clstag="pageclick|keycount|service_201502105|65">查询售后政策</a>
                            </li>
                            <li class="list-item">
                                <a href="//myjd.jd.com/repair/orderlist.action" target="_blank" clstag="pageclick|keycount|service_201502105|66">申请退换货/维修</a>
                            </li>
                            <li class="list-item">
                                <a href="//myjd.jd.com/afs/list/allRepairs.action" target="_blank" clstag="pageclick|keycount|service_201502105|67">售后进度查询</a>
                            </li>
                            <li class="list-item">
                                <a href="//fuwu.jd.com/" target="_blank" clstag="pageclick|keycount|service_201502105|68">服务管家</a>
                            </li>
                            <li class="list-item">
                                <a href="//help.jd.com/user/issue/319-980.html" target="_blank" clstag="pageclick|keycount|service_201502105|69">售后到家</a>
                            </li>
                        </ul>
                    </dd>
                </dl><span style="line-height: 0px; display: none;" id="_baidu_bookmark_start_1"></span>
            </div>
        </div>
    </div>
</div>
</div>
</div>
	<div style="width:100%">
	<jsp:include page="footer.jsp" />
	</div>
</body>
</html>