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
<title>HTML</title>
<style type="text/css">
body{margin:0px;
	padding:0px;
}
.content {
    width: 770px;
    float: left;
    background-color: #fff;
    min-height: 760px;
}
#faq-tabs {
margin-top:-16px;
}
#faq-tabs .tab-list {
    background-color: #f9f9f9;
	margin-left:-40px;
}
.tabs .tab-list {
    font-family: "microsoft yahei";
}
ol, ul {
    list-style: none;
}
#faq-tabs .tab-list .list-item {
    color: #999;
    font-size: 14px;
    font-weight: normal;
    height: 35px;
    line-height: 35px;
    width: 120px;
}
.tabs .tab-list .list-item {
    float: left;
    height: 45px;
    line-height: 45px;
    margin-right: 12px;
    background-color: #e9e9e9;
    color: #585858;
    font-size: 16px;
    width: 150px;
    text-align: center;
    font-weight: bold;
    cursor: default;
}
#faq-tabs .tab-list .list-item.current {
    color: #fff;
}
.tabs .tab-list .list-item.current {
    background-color: #f3b701;
    color: #fff;
    position: relative;
}
.tabs .tab-list::after {
    display: block;
    clear: both;
    height: 0;
    font-size: 0;
    overflow: hidden;
}
#faq-tabs .tab-list .list-item.current .icon01 {
    left: 54px;
}
.tabs .tab-list .list-item.current .icon01 {
    width: 12px;
    height: 7px;
    position: absolute;
    left: 70px;
    bottom: -7px;
    background: url("images/icon02.png") no-repeat 0 bottom;
    line-height: 0;
}
.tabs .tabcons {
    padding-top: 36px;
    background-color: #fff;
}
.tabs .tabcon {
    padding-bottom: 10px;
}
.list-tab-float {
    padding-left: 28px;
    padding-right: 28px;
    overflow: hidden;
    *zoom: 1;
}
.list-tab-float .list-item01 {
    float: left;
    width: 49%;
    line-height: 28px;
}
#faq-tabs .list-item01 a {
    display: block;
    padding-left: 10px;
    font-size: 14px;
}
.list-tab-float .list-item01 a {
    color: #999;
}
.bg-icon {
    background: url("images/icon01.png") 0 -14px no-repeat;
}
a {
    color: #666;
    text-decoration: none;
}
.faq-list-box {
    overflow: hidden;
    padding-left: 10px;
	margin-top:-20px;
}
.faq-list-box a{
font-size:12px;
}
.m, .sm {
    margin-bottom: 10px;
}
.faq-list-mod {
    float: left;
    width: 350px;
    margin-right: 13px;
    overflow: hidden;
}
.fore01.faq-list-mod .in-tit {
    border-color: #4db7eb;
}
.faq-list-mod .in-tit {
    font-size: 14px;
    font-family: "microsoft yahei";
    margin-bottom: 10px;
    border-left: 4px solid;
    padding-left: 5px;
    height: 13px;
    line-height: 15px;
}
.faq-list-mod .in-cnt {
    padding-left: 0px;
    margin-bottom: 35px;
	margin-left:0px;
}
.faq-list-mod .list-item {
    width: 33%;
    line-height: 25px;
}
.list-float {
    overflow: hidden;
	margin-left:0px;
	padding-left:0px;
}
.list-float .list-item {
    float: left;
}
.faq-list-mod a {
    color: #4db7eb;
}.fore02.faq-list-mod .in-tit {
    border-color: #f8bb00;
}
.faq-list-mod .in-tit {
    font-size: 14px;
    font-family: "microsoft yahei";
    margin-bottom: 10px;
    border-left: 4px solid;
    padding-left: 5px;
    height: 13px;
    line-height: 15px;
}
.fore03.faq-list-mod .in-tit {
    border-color: #85b716;
}
.faq-list-mod .in-tit {
    font-size: 14px;
    font-family: "microsoft yahei";
    margin-bottom: 10px;
    border-left: 4px solid;
    padding-left: 5px;
    height: 13px;
    line-height: 15px;
}

</style>
<script type="text/javascript" src="<%=tPath%>/assets/js/jquery-1.11.0.js"></script>
<script type="text/javascript">
$(function (){		
	$(".faq-list-box a").hover(
			function () {
				$(this).css("color","#FF9900");
				 },
			function () {
				$(this).css("color","");
					}
			);
	$(".tabcons a").hover(
			function () {
				$(this).css("color","#FF9900");
				 },
			function () {
				$(this).css("color","");
					}
			);
	$("#faq-tabs .tab-list .list-item").mousemove (
		function (){
			$(".list-item.current").attr("class","list-item");	
			$(this).attr("class","list-item current");

			$(".tabcon.ui-switchable-panel-selected").attr("style","display:none;");
			$(".tabcon.ui-switchable-panel-selected").attr("class","tabcon");
			$(".tabcons .tabcon").eq($(this).attr("name")).attr("class","tabcon ui-switchable-panel-selected");
			$(".tabcons .tabcon").eq($(this).attr("name")).attr("style","display:block;");						
		}
	);		
			
	
	});
</script>
</head>
<body>
 <div class="content">
        
<div class="tabs" id="faq-tabs">
    <ul class="tab-list">
        <li class="list-item current" name="0">
            购买咨询<strong class="icon01"></strong>
        </li>
        <li class="list-item" name="1">
            配送查询<strong class="icon01"></strong>
        </li>
        <li class="list-item" name="2">
            付款及退款<strong class="icon01"></strong>
        </li>
        <li class="list-item" name="3">
            售后规则<strong class="icon01"></strong>
        </li>
        <li class="list-item" name="4">
            账户与资产<strong class="icon01"></strong>
        </li>
    </ul>
    <div class="tabcons">
        <div class="tabcon ui-switchable-panel-selected" style="display:block;">
            <ul class="list-tab-float">
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/75-244.html" target="_blank" clstag="pageclick|keycount|issue_201502104|1">下单后可以修改订单吗？</a>
                </li>
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/64-245.html" target="_blank" clstag="pageclick|keycount|issue_201502104|2">订单如何取消？</a>
                </li>
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/45-246.html" target="_blank" clstag="pageclick|keycount|issue_201502104|3">无货商品几天可以到货？</a>
                </li>
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/248-283.html" target="_blank" clstag="pageclick|keycount|issue_201502104|4">合约机是什么？</a>
                </li>
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/248-286.html" target="_blank" clstag="pageclick|keycount|issue_201502104|5">合约机资费如何计算？</a>
                </li>
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/44-248.html" target="_blank" clstag="pageclick|keycount|issue_201502104|6">如何联系商家？</a>
                </li>
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/263-247.html" target="_blank" clstag="pageclick|keycount|issue_201502104|7">可以开发票吗？</a>
                </li>
            </ul>
        </div>
        <div class="tabcon" style="display:none;">
            <ul class="list-tab-float">
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/264-249.html" target="_blank" clstag="pageclick|keycount|issue_201502104|8">收到的商品少了/发错货了怎么办？</a>
                </li>
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/102-250.html" target="_blank" clstag="pageclick|keycount|issue_201502104|9">我的包裹几天可以收到？</a>
                </li>
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/56-276.html" target="_blank" clstag="pageclick|keycount|issue_201502104|10">订单怎么一直显示正在出库？</a>
                </li>
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/103-255.html" target="_blank" clstag="pageclick|keycount|issue_201502104|11">配送和快递方式有哪些？</a>
                </li>
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/103-254.html" target="_blank" clstag="pageclick|keycount|issue_201502104|12">能否送货上门？</a>
                </li>
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/104-253.html" target="_blank" clstag="pageclick|keycount|issue_201502104|13">我的包裹现在到哪里了？</a>
                </li>
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/104-252.html" target="_blank" clstag="pageclick|keycount|issue_201502104|14">我能指定一个快递公司送货吗？</a>
                </li>
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/100-251.html" target="_blank" clstag="pageclick|keycount|issue_201502104|15">自提点在哪里？</a>
                </li>
            </ul>
        </div>
        <div class="tabcon" style="display:none;">
            <ul class="list-tab-float">
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/130-256.html" target="_blank" clstag="pageclick|keycount|issue_201502104|16">取消订单/退货后怎么退款给我？</a>
                </li>
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/197-257.html" target="_blank" clstag="pageclick|keycount|issue_201502104|17">白条怎么开通？怎么激活？</a>
                </li>
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/231-258.html" target="_blank" clstag="pageclick|keycount|issue_201502104|18">支付方式有哪些？如何支付？</a>
                </li>
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/130-259.html" target="_blank" clstag="pageclick|keycount|issue_201502104|19">退款多久可以到账？</a>
                </li>
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/130-264.html" target="_blank" clstag="pageclick|keycount|issue_201502104|20">余额提现怎么操作？</a>
                </li>
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/130-263.html" target="_blank" clstag="pageclick|keycount|issue_201502104|21">退款怎么查询？</a>
                </li>
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/265-261.html" target="_blank" clstag="pageclick|keycount|issue_201502104|22">京东E卡如何绑定？</a>
                </li>
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/200-260.html" target="_blank" clstag="pageclick|keycount|issue_201502104|23">白条怎么使用？怎么还款？</a>
                </li>
            </ul>
        </div>
        <div class="tabcon" style="display:none;">
            <ul class="list-tab-float">
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/127-273.html" target="_blank" clstag="pageclick|keycount|issue_201502104|24">什么情况下可以退货/换货/维修？</a>
                </li>
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/118-265.html" target="_blank" clstag="pageclick|keycount|issue_201502104|25">如何申请退货/换货？</a>
                </li>
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/119-272.html" target="_blank" clstag="pageclick|keycount|issue_201502104|26">退货/换货/维修分别需要多长时间？</a>
                </li>
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/131-271.html" target="_blank" clstag="pageclick|keycount|issue_201502104|27">退货/换货运费怎么算？</a>
                </li>
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/239-274.html" target="_blank" clstag="pageclick|keycount|issue_201502104|28">大家电可以上门安装吗？</a>
                </li>
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/124-269.html" target="_blank" clstag="pageclick|keycount|issue_201502104|29">退货/换货地址是哪里？</a>
                </li>
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/239-275.html" target="_blank" clstag="pageclick|keycount|issue_201502104|30">大家电安装费用怎么算？</a>
                </li>
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/123-268.html" target="_blank" clstag="pageclick|keycount|issue_201502104|31">已经提交退货/换货申请，在哪里能查看到进度？</a>
                </li>
            </ul>
        </div>
        <div class="tabcon" style="display:none;">
            <ul class="list-tab-float">
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/164-278.html" target="_blank" clstag="pageclick|keycount|issue_201502104|32">如何修改密码？</a>
                </li>
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/164-279.html" target="_blank" clstag="pageclick|keycount|issue_201502104|33">如何验证手机？如何绑定手机？</a>
                </li>
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/164-280.html" target="_blank" clstag="pageclick|keycount|issue_201502104|34">支付密码如何开启？</a>
                </li>
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/164-281.html" target="_blank" clstag="pageclick|keycount|issue_201502104|35">如何提高账户安全等级？</a>
                </li>
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/165-282.html" target="_blank" clstag="pageclick|keycount|issue_201502104|36">忘记账户或昵称怎么办？</a>
                </li>
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/169-266.html" target="_blank" clstag="pageclick|keycount|issue_201502104|37">优惠券怎么使用？</a>
                </li>
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/169-267.html" target="_blank" clstag="pageclick|keycount|issue_201502104|38">在哪里查询优惠券？</a>
                </li>
                <li class="list-item01">
                    <a class="bg-icon" href="//help.jd.com/user/issue/170-277.html" target="_blank" clstag="pageclick|keycount|issue_201502104|39">我的余额怎么查看？白条怎么查看？</a>
                </li>
            </ul>
        </div>
    </div>
</div>

<div class="m faq-list-box">
    <dl class="faq-list-mod fore01">
        <dt class="in-tit">
            购物指南
        </dt>
        <dd class="in-cnt">
            <ul class="list-float">
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-28.html" target="_blank">交易条款</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-29.html" target="_blank">购物流程</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-30.html" target="_blank">促销咨询</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-31.html" target="_blank">商品咨询</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-297.html" target="_blank">生活旅行/团购</a>
                </li>
            </ul>
        </dd>
    </dl>
    <dl class="faq-list-mod fore02">
        <dt class="in-tit">
            订单百事通
        </dt>
        <dd class="in-cnt">
            <ul class="list-float">
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-48.html" target="_blank">提交订单</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-47.html" target="_blank">订单查询</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-49.html" target="_blank">订单修改</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-50.html" target="_blank">订单取消</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-51.html" target="_blank">晒单评价</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-52.html" target="_blank">订单锁定/解锁</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-53.html" target="_blank">订单拆分</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-54.html" target="_blank">订单异常</a>
                </li>
            </ul>
        </dd>
    </dl>
    <dl class="faq-list-mod fore03">
        <dt class="in-tit">
            特色服务
        </dt>
        <dd class="in-cnt">
            <ul class="list-float">
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-132.html" target="_blank">价格保护</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-133.html" target="_blank">夺宝岛</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-134.html" target="_blank">DIY装机</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-135.html" target="_blank">京东卡/京东E卡</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-136.html" target="_blank">大家电服务</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/42-69.html" target="_blank">大家电常见问题</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-138.html" target="_blank">合约计划</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-139.html " target="_blank">售后到家</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-139.html" target="_blank">电器管家</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-141.html" target="_blank">延保通</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-142.html" target="_blank">定期送</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-143.html" target="_blank">二手图书</a>
                </li>             
            </ul>
        </dd>
    </dl>
    <dl class="faq-list-mod fore04">
        <dt class="in-tit">
            支付及发票
        </dt>
        <dd class="in-cnt">
            <ul class="list-float">
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-171.html" target="_blank">支付流程</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-172.html" target="_blank">货到付款</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-173.html" target="_blank">在线支付</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-174.html" target="_blank">邮局汇款</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-175.html" target="_blank">公司转账</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-176.html" target="_blank">分期付款</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-177.html" target="_blank">京东白条</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-178.html" target="_blank">支票支付</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-179.html" target="_blank">扫码支付</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-180.html" target="_blank">合包支付</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-181.html" target="_blank">异常情况</a>
                </li>
            </ul>
        </dd>
    </dl>

    <dl class="faq-list-mod fore05">
        <dt class="in-tit">
            配送方式
        </dt>
        <dd class="in-cnt">
            <ul class="list-float">
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-80.html" target="_blank">发货与签收</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-81.html" target="_blank">京东配送服务</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-82.html" target="_blank">配送服务查询</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-83.html" target="_blank">配送时效</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-84.html" target="_blank">配送异常</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-85.html" target="_blank">配送运费</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-86.html" target="_blank">商家配送服务</a>
                </li>
            </ul>
        </dd>
    </dl>
    <dl class="faq-list-mod fore06">
        <dt class="in-tit">
            售后服务
        </dt>
        <dd class="in-cnt">
            <ul class="list-float">
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-112.html" target="_blank">售后政策（自营）</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-113.html" target="_blank">返修/退换货申请</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-117.html" target="_blank">售后政策（卖家）</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-115.html" target="_blank">商品返回</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-116.html" target="_blank">退款说明</a>
                </li>
                <li class="list-item">
                    <a href="//help.jd.com/user/issue/list-114.html" target="_blank">服务单查询与修改</a>
                </li>
            </ul>
        </dd>
    </dl>
</div>
    </div>
</div>
</body>

</html>