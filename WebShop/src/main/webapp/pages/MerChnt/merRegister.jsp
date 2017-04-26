<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="description" content="乐天商城用户注册" />
<meta name="author" content="hlb" />
		<%@ include file="../common/path.jsp" %>
	<%@ include file="../common/base.jsp" %>
    <base href="<%=tBasePath%>"></base>
<title>乐汇百材-商户注册</title>
<!-- website -->
<link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/web/web_frame.css">
<link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/web/web_nhead.css">
<link rel="stylesheet" href="<%=tPath%>/assets/css/jquery-ui.css">
<link rel="stylesheet"
	href="<%=tPath%>/assets/css/fonts/linecons/css/linecons.css">
<link rel="stylesheet" href="<%=tPath%>/assets/css/bootstrap.css">
<link rel="stylesheet" href="<%=tPath%>/assets/css/xenon-core.css">
<link rel="stylesheet" href="<%=tPath%>/assets/css/xenon-forms.css">
<link rel="stylesheet" href="<%=tPath%>/assets/css/common.css">

<style type="text/css">
body {
	background: none;
}

.site_frame > .site_frame_main > .site_frame_wrap {
    margin: 40px auto;
}
.process_item {
	width: 25%;
	height: 40px;
	line-height: 33px;
	font-size: 16px;
	float: left;
	text-align: center;
	background-color: #fff;
	border-left: 1px solid #eee;
}

.RegistrationAgreement {
	line-height: 24px;
	padding: 0 30px;
	font-size: 12px;
	margin: 1px;
	overflow: scroll;
	overflow-x: hidden;
	padding-bottom: 40px;
}

.RegShopInfo {
	line-height: 24px;
	padding: 0 30px;
	font-size: 12px;
	margin: 1px;
	overflow: scroll;
	overflow-x: hidden;
	padding-bottom: 40px;
}

.RegEpriseInfo {
	line-height: 24px;
	padding: 30px 30px;
	font-size: 12px;
	margin: 1px;
	overflow: scroll;
	overflow-x: hidden;
	padding-bottom: 40px;
}



.RegResult{
line-height: 24px;
	padding: 0 30px;
	font-size: 12px;
	margin: 1px;
	overflow: scroll;
	overflow-x: hidden;
	padding-bottom: 40px;
}

.div_button {
	height: 40px;
	text-align: center;
	margin: 30px auto;
}

.row {
	margin: 10px 0 0 0;
}
.uploadbutton{
margin: -47px -420px 0 0;
height: 32px;
}

.form-group .control-label{
float: left;
font-size: 16px;
width: auto;
text-align: right;
padding: 5px 1px;
min-width: 180px;
margin: 0 20px 0 0;
}

.input-group .form-control {
    display: table-cell;
    z-index:1;
}

.col-md-6 {
    width: 60%;
    margin: 0 0 0 30px;
}

.select {
    float: left;
    display: inline;
    height: 34px;
    border: #dedede 1px solid;
    position: relative;
    padding-top: 6px;
}
.select input {
    border: #fff 0px solid;
    z-index:20;
}
.select input {
    width: 194px;
    height: 100%;
    padding: 0 10px;
    font-size: 14px;
    color: #555555;
}
.dateTo {
    display: block;
    float: left;
    width: 14px;
    height: 34px;
    line-height: 32px;
    text-align: center;
    font-size: 14px;
    color: #888;
}
</style>
</head>
<body>
	<div class="site_frame">
	    <jsp:include page="../HomePages/home_topbar.jsp" />
	    
	<div class="site_frame_head">
	        <div class="site_nhead">
		        <div class="header">
					<div class="header_box clearfix">
						<a  href="<%=request.getContextPath()%>/index.jsp" class="logo_set">
						<img alt="logo" src="<%=request.getContextPath()%>/images/lhbclogo.png">
						</a>
					</div>
				    <div class="header_center clearfix">
						<a href="＃" target="_self" class="fore2">商家进驻</a> 
						<a href="<%=request.getContextPath()%>/index.jsp" target="_blank" class="fore3">返回乐汇首页</a>
					</div>
					<div class="header_right clearfix">
						<a  href="#" class="ad_set">
						  <img alt="新客有礼" src="<%=request.getContextPath()%>/images/index_ad.png">
						</a>
					</div>
				</div>
			</div>
	</div>
	<div class="site_frame_main">	
		<div class="site_frame_wrap">
			<!--进度条-->
			<div class="row">
				<div class="process_item" style="border-left: none" id="item_1">
					注册协议 <span class="badge badge-info">1</span>
				</div>
				<div class="process_item" id="item_2">
					填写店铺信息 <span class="badge badge-default">2</span>
				</div>
				<div class="process_item" id="item_3">
					填写企业信息 <span class="badge badge-default">3</span>
				</div> 
				<div class="process_item" id="item_4">
					注册成功 <span class="badge badge-default">4</span>
				</div>
			</div>
			<div style="display: none;" class="alert alert-danger" id="userRegTips"></div>
			<div class="hide" id="regflow" reg-flow="0" enter-id="" enter-type=""></div>
		<!--注册协议-->
		<div class="row item reg_item_1">
			<blockquote class="blockquote blockquote-info RegistrationAgreement">
				<p style="text-align: center;">
					<strong>乐汇百材注册协议</strong>
				</p>
				<p>
					为切实维护您的合法权益，特制订《乐汇百材注册协议》（以下简称“本协议”）。<br />
	
					请您务必审慎阅读、充分理解本协议各条款内容，特别是免除或者限制责任的条款，以及内蒙古汇百科技有限公司（以下简称“乐汇百材”）推出的各项活动的单独协议，并选择接受或不接受。<br />
	
					乐汇百材推出的各项活动的单独协议不在本协议中体现，但为本协议的组成部分，同样具有法律效力。<br />
	
					除非您已阅读并接受本协议所有条款，否则您无权申请成为乐汇百材会员。您申请成为乐汇百材会员的行为即视为您已阅读并同意受本协议的约束。<br />
	
					本协议不为格式合同，可以按照您的要求及双方协商的结果进行变更。本协议成立前，如您要求变更本协议，则您可本人亲自至乐汇百材进行商谈。乐汇百材同意您变更要求的，可与您另行达成有关协议。<br />
	
					本协议主要包括三部分内容，一是您与乐汇百材之间的委托合同成立生效前，您参加乐汇百材推出的各项活动及享受乐汇百材相应服务部分；二是您与乐汇百材之间的委托合同成立生效及履行部分；三是您与乐汇百材之间的委托合同生效后，您在具有乐汇百材受托人身份的同时，参加乐汇百材推出的各项活动并享受乐汇百材相应服务部分。<br />
	
					您经特定程序成为乐汇百材会员，但未与乐汇百材签订生效委托合同的，您仅具有“普通会员”身份。<br />
	
					您经特定程序成为乐汇百材会员，且与乐汇百材签订生效委托合同后，您具有“特定会员”身份。<br />
	
					为方便运营管理，乐汇百材可能在有关文件、公告等资料上统一称“普通会员”与“特定会员”为“会员”。您同意本协议的，视为您同意乐汇百材对您统一称谓的做法。请您根据自己“普通会员”或“特定会员”的身份参加乐汇百材推出的相应活动。<br />
	
					无论您是普通会员或特定会员，还是作为受托人履行受托义务，您均不得做出以下行为：<br />
	
					（1）发布、传送、传播、储存违反国家法律、危害国家安全统一、社会稳定、公序良俗、社会公德以及侮辱、诽谤、淫秽、暴力的内容； <br />
	
					（2）发布、传送、传播、储存侵害他人名誉权、肖像权、知识产权、商业秘密等合法权利的内容； <br />
	
					（3）虚构事实、隐瞒真相，误导、欺骗他人； <br /> （4）发表、传送、传播广告信息及垃圾信息； <br />
	
					（5）从事其他违反法律法规、政策及公序良俗、社会公德等的行为。<br /> 一、普通会员<br />
	
					1.1您经特定程序成为乐汇百材会员，但与乐汇百材之间不存在生效委托合同的情况下，您仅为普通会员。作为普通会员，您可以参加乐汇百材推出的相应活动并享受相应服务。<br />
	
					1.2普通会员参加相应活动的，应遵守乐汇百材关于相应活动的规则。<br />
	
					1.3对于普通会员参加的相应活动，乐汇百材有权随时变更相应活动的规则。对于变更后的活动规则，普通会员应予以遵守。<br />
	
					二、特定会员<br /> 2.1与乐汇百材签订生效委托合同的普通会员为特定会员。<br />
	
					2.2您按照本协议有关内容与乐汇百材签订的委托合同生效后，您取得特定会员的身份。为方便运营管理，乐汇百材可能在有关文件、公告等资料上统一称具有特定会员身份的您为“会员”。您同意本协议的，视为您同意乐汇百材对特定会员如此称谓的做法。<br />
	
					2.3本协议为乐汇百材向您发出的签订委托合同的要约邀请。<br />
	
					2.4成为普通会员后，如您通过乐汇百材身份认证程序向乐汇百材提交您的真实姓名、身份证号、并最终绑定您本人所有的真实银行卡帐号的，视为您按照本协议（要约邀请）的有关内容向乐汇百材发出签订委托合同的要约。<br />
	
					2.5您向乐汇百材发出签订委托合同的要约后，如乐汇百材向您发出“添加银行卡成功”，则表示乐汇百材对您签订委托合同的要约进行承诺。<br />
	
					2.6自乐汇百材对您签订委托合同的要约承诺之时起，您与乐汇百材之间的委托合同成立并生效。<br />
	
					2.7您具有以下情形之一的，不得向乐汇百材发出签订委托合同的要约：<br /> （1）未满10周岁；<br />
	
					（2）已满10周岁但未满18周岁，未经您监护人同意；<br />
					（3）已满16周岁但未满18周岁，且未以自己的劳动收入为主要生活来源；<br />
	
					（4）已满18周岁，但具有其他导致民事行为能力行使有障碍的情况。<br />
					2.8您与乐汇百材之间的委托合同生效后，您取得受托人身份。<br />
	
					2.9您取得受托人身份后，乐汇百材作为委托人，将委托您处理特定委托事务。<br />
	
					2.10特定委托事务即您按照乐汇百材的有关要求处理的事务。该有关要求由乐汇百材通过通知、公告、规则等方式向您做出委托。<br />
	
					2.11您作为受托人处理特定委托事务的，可能要根据委托事务的特点向乐汇百材缴纳一定数额的保证金，作为您全面履行受托义务的保证。保证金的数额由您自己决定。<br />
	
					2.12您同意乐汇百材以特定虚拟货币的方式支付相应委托报酬并保证不以任何理由对委托报酬支付方式提出异议。<br />
	
					2.13乐汇百材按照您完成特定委托事务的次数向您支付相应委托报酬。<br />
	
					2.14乐汇百材以实际支付的特定虚拟货币数额确定您每次处理委托事务的相应报酬。自您收受乐汇百材实际支付的特定数额的虚拟货币之日起3日内，您未以书面方式向乐汇百材提出异议的，视为您以默示方式同意委托报酬的支付数额。<br />
	
					2.15您与乐汇百材之间的委托合同受《中华人民共和国合同法》制约并保护。<br />
	
					2.16您有权随时解除与乐汇百材之间的委托合同。如您欲解除与乐汇百材之间的委托合同，则您应主动与乐汇百材联系，经乐汇百材特定程序后，您与乐汇百材之间的委托合同解除。<br />
	
					三、特定会员活动及相应规则<br /> 3.1您与乐汇百材之间的委托合同生效后，在具有乐汇百材受托人身份的同时，您取得特定会员的身份。<br />
	
					3.2作为特定会员，您可以参加乐汇百材推出的相应活动并享受相应服务。<br />
	
					3.3特定会员可以参加的相应活动的规则由乐汇百材制定、修改或补充。<br />
	
					3.4对于乐汇百材制定、修改或补充的规则，您作为特定会员应予以遵守。如您不同意该制定、修改或补充的规则，则您应于规则制定、修改或补充公告或通知之日起3日内至乐汇百材进行商谈。乐汇百材将根据与您的商谈结果做出处理。<br />
	
					3.5出现以下情形之一的，您不得参加只有特定会员才能参加的活动：<br /> （1）您未与乐汇百材订立生效的委托合同；<br />
	
					（2）您与乐汇百材之间的委托合同失效。<br />
	
					3.6您只能使用一个帐号参加只有特定会员才能参加的活动。如您使用两个以上帐号的，则乐汇百材有权中止或终止相关帐号的使用并没收您因违反乐汇百材有关活动规则而获得的特定虚拟货币。<br />
	
					3.7您的有关帐号被乐汇百材中止使用的，如您欲重新使用该中止帐号，则您应向乐汇百材提供被中止使用账号、该账号绑定的银行卡（彩色电子版本或扫描件）、与银行卡账户名一致的身份证复印件（彩色电子版本或扫描件）及手持照片。乐汇百材有权根据实际情况恢复该中止帐号的使用或终止该中止帐号的使用。<br />
	
					3.8出现以下情形之一的，乐汇百材有权随时中止或终止向您提供特定会员享有的服务而无需通知您：<br />
					（1）您提供的个人信息不真实；<br /> （2）您未全面履行与乐汇百材之间的委托合同；<br />
					（3）您未遵守乐汇百材制定、修改或补充的特定活动的规则。<br /> 四、隐私保护<br />
					4.1除本协议4.2条款情况外，乐汇百材保证不对外披露您的有关信息，但下列情况除外：<br /> （1）事先获得您的明确授权；<br />
					（2）根据有关的法律法规要求；<br /> （3）按照相关政府主管部门的要求；<br /> （4）为维护社会公众的利益；<br />
					（5）为维护乐汇百材的合法权益。<br />
	
					4.2乐汇百材可能会与第三方合作向您提供相应服务。在此情况下，如该第三方同意承担与乐汇百材同等的保护您隐私的责任，则乐汇百材可将您的有关信息提供给该第三方。<br />
	
					4.3乐汇百材有权对包括您在内的全部与乐汇百材签订生效委托合同的自然人的信息建立数据库并进行技术分析，并将分析结果用于乐汇百材经营所需。<br />
	
					4.4当您使用乐汇百材手机接入端口登录乐汇百材时，乐汇百材有权利用UDID来识别和收集手机使用者的信息，并对您参加乐汇百材各项活动的操作过程进行跟踪。<br />
	
					4.5乐汇百材有权通过调集GPS信号/收集wifi对您进行定位。<br />
	
					4.6您同意乐汇百材出现4.4、4.5条款规定情形的，不为对您隐私的侵犯。<br /> 五、免责条款<br />
	
					5.1您可能因乐汇百材不能控制的因素而导致不能及时享有相应服务或权利。对此，乐汇百材只需向您做出必要的解释，但并不承担相应责任。乐汇百材会尽最大努力保障您应享有的服务或权利<br />
	
					5.2乐汇百材有权接受第三方委托，在乐汇百材（www.hbaicai.com）的相应版块发布第三方提供的图片、文字及链接等可直观呈现的信息。由于该信息由第三方提供，故乐汇百材不保证信息的合法性或真实性，也不承担因信息不合法或不真实而导致的任何责任。如您发现第三方提供的信息不合法或不真实，请您主动联系乐汇百材。乐汇百材将根据实际情况做出处理。<br />
	
					5.3在您参加乐汇百材各项活动的过程中，乐汇百材不做以下保证：提供的服务将不受干扰、及时、安全可靠或不会出现差错。但乐汇百材会尽最大努力为您提供不受干扰、及时、安全可靠的服务。<br />
	
					5.4如因系统维护或升级的需要而暂停服务，乐汇百材不承担任何责任，但会尽可能事先向您告知。<br /> 六、其他<br />
	
					6.1本协议取代本协议发布前乐汇百材所制定发布的所有文件，且本协议效力在时间上追溯至乐汇百材各项业务开始之时刻。<br />
	
					6.2本协议发布前已经存在的乐汇百材会员请根据本协议明确自己是“普通会员”或是“特定会员”，并在明确的基础上参加相应的活动。<br />
	
					6.3本协议发布前，如您已通过乐汇百材实名认证，则自您通过实名认证之时起，您与乐汇百材之间的非书面委托合同成立生效。
					本协议作为委托合同的书面版本，对您与乐汇百材之前的委托合同权利义务予以明示。如您对此有异议，则您应于本协议发布之日起3日内至乐汇百材进行商谈。乐汇百材将根据与您的商谈结果做出处理。<br />
	
					6.4本协议发布后，请本协议发布前已经存在的乐汇百材会员按照本协议调整自己的行为，使之符合本协议有关规定。<br />
	
					6.5乐汇百材有权对本协议进行修改或补充并以公告的方式向您传达。如您不同意相关修改或补充，则您应于相关修改或补充公告之日起3日内至乐汇百材进行商谈。乐汇百材将根据与您的商谈结果做出处理。<br />
	
					6.6您违反有关法律法规或本协议任何条款而给乐汇百材或任何第三方造成损失的，您同意承担相应的损害赔偿责任。<br />
	
					6.7本协议的签订、履行、变更、解除、终止、溯及既往等均适用中华人民共和国法律。<br />
	
					6.8如您与乐汇百材就本协议的签订、履行、变更、解除、终止、溯及既往等发生争议的，您应与乐汇百材友好协商解决；协商不成时，任何一方均可向乐汇百材所在地的人民法院提起诉讼。<br />
	
					6.9您同意本协议条款意思的解释权在乐汇百材。<br /> 内蒙古汇百科技有限公司
				</p>
			</blockquote>
			<div class="div_button">
				<button type="button" class="btn btn-info" data-nextitem="item_2"
					id="RegistrationAgreement_btn">我已阅读条款</button>
			</div>
		</div>
	
		<!--店铺信息-->
		<div class="row item reg_item_2" style="display: none;">
			<blockquote class="blockquote blockquote-info RegShopInfo">
			       <div style="margin: 50px 0 0 0;">
			        <div class="row hide">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label" for="shopId">店铺编号:</label>
								<div class="input-group">
									<div class="input-group-addon">
										<i class="linecons-user"></i>
									</div>
									<input class="form-control" name="shopId" id="shopId"
										data-validate="required" placeholder="请输入店铺编号"
										maxlength="60" />
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label" for="shopNm">店铺名称:</label>
								<div class="input-group">
									<div class="input-group-addon">
										<i class="linecons-user"></i>
									</div>
									<input class="form-control" name="shopNm" id="shopNm"
										data-validate="required" placeholder="请输入店铺名称"
										maxlength="60" />
								</div>
							</div>
						</div>
					</div>
					<div class="row" style="display: none;">
						<div class="col-md-5">
							<div class="form-group">
								<label class="control-label" for="shopLogo">店铺logo:</label>
								<div class="input-group">
									<div class="input-group-addon">
										<i class="linecons-mail"></i>
									</div>
									<input class="form-control" name="shopLogo" id="shopLogo"
										data-validate="required,email" placeholder="请上传店铺logo图标" />
									
								</div>
							</div>
						<div class="div_button uploadbutton">
							<button type="button" class="btn btn-info" id="registerBtn">点击上传</button>
						</div>
					</div>
						
					</div>
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label" for="sales">店铺主营:</label>
								<div class="input-group">
									<div class="input-group-addon">
										<i class="linecons-user"></i>
									</div>
									<input type="text" class="form-control" name="shopSales"
										id="shopSales" data-validate="required,minlength[5]"
										data-message-minlength="用户名最小5个字符" placeholder="填写店铺主营" />
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label" for="shopAddr">店铺所在地:</label>
								<div class="input-group">
									<div class="input-group-addon">
										<i class="linecons-user"></i>
									</div>
									<input type="text" class="form-control" name="shopAddr"
										id="shopAddr" data-validate="required,minlength[5]"
										data-message-minlength="用户名最小5个字符" placeholder="填写店铺所在地" />
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label" for="shopTel">客服电话:</label>
								<div class="input-group">
									<div class="input-group-addon">
										<i class="linecons-mobile"></i>
									</div>
									<input type="text" class="form-control" name="shopTel"
										id="shopTel" data-validate="required,minlength[6]"
										placeholder="请输入手机或座机号" />
								</div>
							</div>
						</div>
					</div>
	
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label" for="shopCont">店铺简介:</label>
								<div class="input-group">
									<div class="input-group-addon">
										<i class="linecons-user"></i>
									</div>
									<input type="text" class="form-control" style="height:80px;" name="shopCont" 
										id="shopCont" data-validate="required,minlength[5]"
										data-message-minlength="用户名最小5个字符" placeholder="请填写店铺简介" />
								</div>
							</div>
						</div>
					</div>
				</div>
			</blockquote>
			
			<div class="div_button">
					<button type="button" class="btn btn-info" id="BackReadRegAgreement" data-lastitem="item_1">返回阅读协议</button>
					<button type="button" class="btn btn-info" id="submitShopBtn" data-nextitem="item_3">提交店铺信息</button>
				</div>
		</div>
		<!--商户信息-->
		 <div class="row item reg_item_3" style="display: none;">
			<blockquote class="blockquote blockquote-info RegEpriseInfo">
				
				  
				  <div style="margin: 50px 0 0 0;">
		            <div class="row hide">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label" for="street">企业编号:</label>
								<div class="input-group">
									<div class="input-group-addon">
										<i class="linecons-user"></i>
									</div>
									<input class="form-control" name="epriseId" id="epriseId"
										data-validate="required,minlength[5]" placeholder="请输入企业编号"
										maxlength="60" />
								</div>
							</div>
						</div>
						</div>
		                <div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label" for="street">企业名称:</label>
								<div class="input-group">
									<div class="input-group-addon">
										<i class="linecons-user"></i>
									</div>
									<input class="form-control" name="epriseNm" id="epriseNm"
										data-validate="required,minlength[5]" placeholder="请输入企业名称"
										maxlength="60" />
								</div>
							</div>
						</div>
						</div>
						
						<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label" for="street">工商营业执照注册号:</label>
								<div class="input-group">
									<div class="input-group-addon">
										<i class="linecons-user"></i>
									</div>
									<input class="form-control" name="LicenseId" id="LicenseId"
										data-validate="required,minlength[5]" placeholder="请输入工商营业执照注册号"
										maxlength="60" />
								</div>
							</div>
						</div>
						</div>
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label" for="door_no">成立日期:</label>
								<div class="input-group">
									<div class="input-group-addon">
										<i class="linecons-mail"></i>
									</div>
									    <div class="select">
	                                        <input type="text" id="BuildTime" readonly name="sTimeStr"
	                                        value="" placeholder="YYYY-MM-DD"/>
                                        </div>          
								</div>
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label" for="door_no">营业期限:</label>
								<div class="input-group">
									<div class="input-group-addon">
										<i class="linecons-mail"></i>
									</div>
									    <div class="select">
	                                        <input type="text" id="startTime" readonly name="sTimeStr" 
	                                        value="" placeholder="YYYY-MM-DD"/>
                                        </div>
                                        <span class="dateTo">-</span>

                                        <div class="select">
	                                        <input type="text" id="endTime" readonly name="eTimeStr"
	                                        value="" placeholder="YYYY-MM-DD"/>
                                        </div>         
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label" for="city">企业法人:</label>
								<div class="input-group">
									<div class="input-group-addon">
										<i class="linecons-user"></i>
									</div>
									<input type="text" class="form-control" name="legal"
										id="legal" data-validate="required,minlength[5]"
										data-message-minlength="用户名最小5个字符" placeholder="请填写法人" />
								</div>
							</div>
						</div>
						</div>
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label" for="state">联系方式:</label>
								<div class="input-group">
									<div class="input-group-addon">
										<i class="linecons-mobile"></i>
									</div>
									<input type="text" class="form-control" name="epriseTel"
										id="epriseTel" data-validate="required,minlength[6]"
										placeholder="手机/座机号" />
								</div>
							</div>
						</div>
					</div>
	
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label" for="city">经营范围:</label>
								<div class="input-group">
									<div class="input-group-addon">
										<i class="linecons-user"></i>
									</div>
									<input type="text" class="form-control" name="business" style="min-height:80px;"
										id="business" data-validate="required,minlength[5]"
										data-message-minlength="用户名最小5个字符" placeholder="请输入经营范围" />
								</div>
							</div>
						</div>
					</div>
		            
		            
		            
		        </div>
			</blockquote>
			<div class="div_button">
					<button type="button" class="btn btn-info" id="ModifyShopInfo" data-lastitem="item_2">修改店铺信息</button>
					<button type="button" class="btn btn-info" id="submitEpriseBtn" data-lastitem="item_4">提交企业信息</button>
				</div>
		</div> 
		<!--注册结果-->
		<div class="row item reg_item_4" style="display: none;">
			<blockquote class="blockquote blockquote-info RegResult" style="text-align: center;">
				<p style="font-size: 16px"><strong>资料提交成功，店铺审核通过&nbsp;&nbsp;&nbsp;&nbsp;</strong>
				</p>
				<p>
				<span id="second_id">5</span>秒后跳转到商家中心，<a href="javascript:void(0)" id="JumpMerCenter">点击直接跳转</a>
				</p>
			</blockquote>
		</div>
	</div>
	</div>

	 <jsp:include page="../HomePages/home_footerbar.jsp" />
	 </div>
</body>
<!-- Bottom Scripts -->
	<script src="<%=tPath%>/assets/plugs/jquery/jquery-1.11.3.min.js"></script>
	<script src="<%=tPath%>/assets/plugs/bootstrap/js/bootstrap.min.js"></script>
	<script src="<%=tPath%>/assets/plugs/jquery/jquery-ui.11.1.min.js"></script>
	<script src="<%=tPath%>/assets/plugs/jquery/jquery.ui.datepicker-zh-CN.js"></script>
	<script src="<%=tPath%>/assets/js/comm.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
	<script src="<%=tPath%>/pages/MerChnt/merReg.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
</html>