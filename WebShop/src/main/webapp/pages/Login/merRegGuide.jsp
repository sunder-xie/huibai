<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta name="description" content="乐汇百材-商家入驻" />
	<meta name="author" content="hlb" />
		<%@ include file="../common/path.jsp" %>
	<%@ include file="../common/base.jsp" %>
    <base href="<%=tBasePath%>"></base>
	<title>乐汇百材-商家入驻</title>
	<!-- website -->
    <link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/web/web_frame.css">
    <link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/web/web_nhead.css">
    
	<link rel="stylesheet" href="<%=tPath%>/assets/css/fonts/linecons/css/linecons.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/bootstrap.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/xenon-core.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/xenon-forms.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/common.css">
	
	<style type="text/css">
		body{background: none;}

		.main_content{
		height: 450px;position: relative;width: 100%;
		overflow: hidden;
		}
		.process_item{width: 25%;height: 40px; line-height: 33px;font-size: 16px; float: left; text-align: center;
		background-color: #fff;border-left: 1px solid #eee;cursor: pointer;}
		.blockquote-info{line-height: 24px; padding:30px 30px;font-size: 12px;margin: 1px;}
		.div_button{height: 40px;text-align: center;padding: 20px 0;}
		.row{margin: 0px;}
		.rowitem{margin: 0 0 30px 0;}
		.merInfoFlow{height: 220px;background: #fff;}
		.merInfoFlow span{display: block; float: left;}
		.title{font-size: 16px; margin: 0px;border-bottom: 1px #000 dotted;padding:20px;}
		.merInfoFlow .detail{padding: 30px 0;
height: 200px;
margin: 0 130px;}
		.merInfoFlow .step{width: 80px; height: 80px;background:url("<%=request.getContextPath()%>/images/merInfo/merFlow.png") no-repeat;padding-top: 80px;text-align: center;margin: 0 40px;}
		.guide-arrow{ background:url("<%=request.getContextPath()%>/images/merInfo/merFlow.png") no-repeat -410px -40px;height:22px; margin: 0 41px;width: 14px;margin-top: 40px;}
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
						<div class="nav-r">
							
							<div class="div_button">
								<button type="button" class="btn btn-info" data-nextitem="item_2"
									id="Eprise_Enter_btn">企业进驻</button>
								<button type="button" class="btn btn-info" data-nextitem="item_2"
									id="Person_Enter_btn">个人进驻</button>
								<button type="button" class="btn btn-info" data-nextitem="item_2"
									id="Enter_Process_btn">进度查询</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
    <div class="site_frame_main">
	<div id="merReg-banner" class="main_content"></div>
	
	<div class="site_frame_wrap">
	<!-- 入驻流程 -->
	<div class="merInfoFlow row">
		<h1 class="title">入驻流程&nbsp;⬇️</h1>
		<div class="detail">
			<span class="step" data-step="a" style="background-position: 0 -40px;">签署入驻协议</span>
			<span class="guide-arrow"></span>
	
			<span class="step" data-step="b" style="background-position: -80px -40px;">商家信息提交</span>
			<span class="guide-arrow"></span>
			
			<span class="step" data-step="c" style="background-position: -160px -40px;">平台审核资质</span>
			<span class="guide-arrow"></span>
			
			<!-- <span class="step" data-step="d" style="background-position: -240px -40px;">商家缴纳费用</span>
			<span class="guide-arrow"></span> -->
	
			<span class="step" data-step="e" style="background-position: -320px -40px;">店铺开通</span>
		</div>
	</div>
	
	<!--进度条-->
	<div class="row" style="background: #fff;">
		<h1 class="title">入驻指南&nbsp;⬇️</h1>
		
		<div class="process_item" data-item="item_1" style="border-left: none;">
			招商方向
			<span class="badge badge-info">1</span>
		</div>
		<div class="process_item" data-item="item_2">
			招商标准
			<span class="badge badge-default">2</span>
		</div>
		<div class="process_item" data-item="item_3">
			资质要求
			<span class="badge badge-default">3</span>
		</div>
		<div class="process_item" data-item="item_4">
			资费标准
			<span class="badge badge-default">4</span>
		</div>
	</div>
	<!--招商方向-->
	<div class="row rowitem" id="item_1">
		<blockquote class="blockquote blockquote-info RegistrationAgreement">
			
			<p>
乐汇百材开放平台招商方向<br/>

1.    品牌<br/>

       国际国内知名品牌<br/>
       开放平台将一如既往的最大程度地维护卖家的品牌利益，尊重品牌传统和内涵，欢迎优质品牌旗

舰店入驻，请参见《乐汇百材开放平台重点招募品牌》。<br/>

2.    货品<br/>
       
       能够满足用户群体优质、有特色的货品。<br/>
       根据类目结构细分的货品配置。类目规划详见《乐汇百材开放平台类目一览表》。<br/>
3.   垂直电商<br/>

      开放平台欢迎垂直类电商入驻。开放平台愿意和专业的垂直电商企业分享其优质用户群体，<br/>

并且欢迎垂直电商为用户提供该领域专业的货品及服务。<br/>
			</p>
		</blockquote>
	</div>
	<!--用户信息-->
	<div class="row rowitem" style="display:none;" id="item_2">
		<blockquote class="blockquote blockquote-info">
			<p>
			本标准适用于除虚拟业务（包括但不限于旅游、酒店、票务、充值、彩票）外的乐汇百材开放平台所有卖家。<br/>

第一章 入驻<br/>
1.1    乐汇百材开放平台暂未授权任何机构进行代理招商服务，入驻申请流程及相关的收费说明均以乐汇百材开放平台官方招商页面为准。<br/>
1.2    乐汇百材开放平台有权根据包括但不限于品牌需求、公司经营状况、服务水平等其他因素退回卖家申请。<br/>
1.3    乐汇百材开放平台有权在申请入驻及后续经营阶段要求卖家提供其他资质。<br/>
1.4    乐汇百材开放平台将结合各行业发展动态、国家相关规定及消费者购买需求，不定期更新招商标准。<br/>
1.5    卖家必须如实提供资料和信息：<br/>
1.5.1 请务必确保申请入驻及后续经营阶段提供的相关资质和信息的真实性、完整性、有效性（若卖家提供的相关资质为第三方提供，
包括但不限于商标注册证、授权书 等，请务必先行核实文件的真实有效完整性），一旦发现虚假资质或信息的，
乐汇百材开放平台将不再与卖家进行合作并有权根据乐汇百材开放平台规则及与卖家签署的相关 协议之约定进行处理；<br/>
1.5.2  卖家应如实提供其店铺运营的主体及相关信息，包括但不限于店铺实际经营主体、代理运营公司等信息；<br/>
1.5.3  乐汇百材开放平台关于卖家信息和资料变更有相关规定的从其规定，但卖家如变更1.5.2项所列信息，应提前十日书面告知平台；
如未提前告知平台，平台将根据乐汇百材开放平台规则进行处理。<br/>
1.6    乐汇百材开放平台暂不接受个体工商户的入驻申请，卖家须为正式注册企业，亦暂时不接受非中国大陆注册企业的入驻申请。<br/>
1.7    乐汇百材开放平台暂不接受未取得国家商标总局颁发的商标注册证或商标受理通知书的品牌开店申请，亦不接受纯图形类商标的入驻申请。
卖家提供商标受理通知书（TM状态商标）的，注册申请时间须满六个月。<br/>

第二章 平台店铺类型及相关要求<br/>
2.1     旗舰店，卖家以自有品牌（商标为R或TM状态），或由权利人出具的在乐汇百材开放平台开设品牌旗舰店的授权文件（授权文件中应明确排他性、不可撤销性），
入驻乐汇百材开放平台开设的店铺。<br/>
2.1.1  旗舰店，可以有以下几种情形：<br/>
经营一个自有品牌（商标为R或TM状态）商品入驻乐汇百材开放平台的卖家旗舰店，
（自有品牌是指商标权利归卖家所有，自有品牌的子品牌可以放入旗舰店，主、子品牌的商标权利人应为同一实际控制人）；<br/>
经营已获得明确排他性授权的一个品牌商品入驻乐汇百材开放平台的卖家旗舰店；<br/>
卖场型品牌（服务类商标）商标权人开设的旗舰店；<br/>
2.1.2  开店主体必须是品牌（商标）权利人或持有权利人出具的开设乐汇百材开放平台旗舰店排他性授权文件的被授权企业。<br/>
2.2     专卖店，卖家持他人品牌（商标为R或TM状态）授权文件在乐汇百材开放平台开设的店铺。<br/>
2.2.1  专卖店类型：经营一个或多个授权品牌商品（多个授权品牌的商标权人应为同一实际控制人）但未获得旗舰店排他授权入驻乐汇百材开放平台的卖家专卖店；<br/>
2.2.2   品牌（商标）权利人出具的授权文件不应有地域限制。<br/>
2.3     专营店，经营乐汇百材开放平台相同一级经营类目下两个及以上他人或自有品牌（商标为R或TM状态）商品的店铺。<br/>
2.3.1  专营店，可以有以下几种情形：<br/>
相同一级类目下经营两个及以上他人品牌商品入驻乐汇百材开放平台的卖家专营店；<br/>
相同一级类目下既经营他人品牌商品又经营自有品牌商品入驻乐汇百材开放平台的卖家专营店。<br/>
2.4     各类型店铺命名详细说明，请见《乐汇百材开放平台卖家店铺命名规则》。<br/>

第三章 平台申请入驻资质标准<br/>
3.1    乐汇百材开放平台申请入驻资质标准详见《乐汇百材开放平台招商资质标准细则》。<br/>

第四章 开店入驻限制<br/>
4.1    品牌入驻限制：<br/>
4.1.1 与平台平台已有的自有品牌、频道、业务、类目等相同或相似名称的品牌；<br/>
4.1.2  包含行业名称或通用名称的品牌；<br/>
4.1.3  包含知名人士、地名的品牌；<br/>
4.1.4  与知名品牌相同或近似的品牌。<br/>
4.2     经营类目限制，卖家开店所经营的类目应当符合乐汇百材开放平台的相关标准，详细请参考《乐汇百材开放平台经营类目资费一览表》。<br/>
4.3同一主体入驻的店铺限制：<br/>
4.3.1  单个店铺只可对应一种经营模式。各经营模式内容请参考与卖家签署的对应合同；<br/>
4.3.2  同一主体开设若干店铺的，经营模式总计不得超过两种，且须在开展第二种经营模式时提前10日向平台进行书面申请；<br/>
4.3.3  商品重合度：要求店铺间经营的品牌及商品不得重复4.3.2项下经过平台审批的店铺不受此项约束。<br/>
4.4     同一主体重新入驻乐汇百材开放平台限制：<br/>
4.4.1  严重违规、资质造假被平台清退的，永久限制入驻；<br/>
4.4.2  若卖家一自然年内主动退出2次，则自最后一次完成退出之日起12个月内限制入驻。<br/>
4.5     续签限制：须在每年3月1日18时之前完成续签申请的提交，每年3月20日18时之前完成平台使用费的缴纳，
如果上一年及下一年资费及资料未补足，平台将在每年3月31日24时终止店铺服务并下架商品。<br/>

第五章 乐汇百材开放平台保证金/平台使用费/费率标准<br/>
5.1     保证金：卖家向平台缴纳的用以保证店铺规范运营及对商品和服务质量进行担保的金额。当卖家发生违约、违规行为时，
平台可以依照与卖家签署的协议中相关约定及乐汇百材开放平台规则扣除相应金额的保证金作为违约金或给予买家的赔偿。<br/>
5.1.1  保证金的补足、退还、扣除等依据卖家签署的相关协议及乐汇百材开放平台规则约定办理；<br/>
5.1.2  乐汇百材开放平台各经营类目对应的保证金标准详见《乐汇百材开放平台经营类目资费一览表》。<br/>
5.2     平台使用费：卖家依照与平台签署的相关协议使用乐汇百材开放平台各项服务时缴纳的固定技术服务费用。
乐汇百材开放平台各经营类目对应的平台使用费标准详见《乐汇百材开放平台经营类目资费一览表》。
续签卖家的续展服务期间对应平台使用费须在每年3月20日18时前一次性缴纳；新签卖家须在申请入驻获得批准时一次性缴纳相应服务期间的平台使用费。<br/>
5.2.1   平台使用费结算：<br/>
5.2.1.1卖家主动要求停止店铺服务的不返还平台使用费；<br/>
5.2.1.2卖家因违规行为或资质造假被清退的不返还平台使用费；<br/>
5.2.1.3每个店铺的平台使用费依据相应的服务期计算并缴纳。服务开通之日在每月的1日至15日（含）间的，开通当月按一个月收取平台使用费，
服务开通之日在每月的16日（含）至月底最后一日间的，开通当月不收取平台使用费；<br/>
5.2.1.4拥有独立店铺ID的为一个店铺，若卖家根据经营情况须开通多个店铺的，须按照店铺数量缴纳相应的平台使用费。<br/>
5.3     费率：卖家根据经营类目在达成每一单交易时按比例（该比例在与卖家签署的相关协议中称为“技术服务费费率”或“毛利保证率”）向平台缴纳的费用。
乐汇百材开放平台各经营模式各经营类目对应的费率标准详见《乐汇百材开放平台经营类目资费一览表》。<br/>

第六章 店铺服务期<br/>
6.1     卖家每个店铺的第一个服务期自服务开通之日起至最先到达的3月31日止，第二个服务期自4月1日起至次年3月31日止，第三个、第四个……服务期以此类推，
以一年为周期，除非店铺或与卖家签署的相关协议提前终止。<br/>
6.2     卖家每个店铺的服务开通之日以平台通知或系统记录的时间为准。<br/>
6.3     卖家应在店铺每个服务期届满前30日向甲方提出续展的申请，缴纳续展服务期的平台使用费和提交其经营所需的全部有效资质，并经平台审核。<br/>
6.4     卖家未提出续展申请或申请未通过平台审核的，自店铺服务期满之日起，乐汇百材开放平台将不再向卖家提供该店铺的任何服务。<br/><br/>


乐汇百材开放平台招商资质标准细则<br/>
			</p>
		</blockquote>
	</div>
	<!--注册结果-->
	<div class="row rowitem" style="display:none;" id="item_3">
		<blockquote class="blockquote blockquote-info" >
			<p>
			平台开放平台招商资质标准细则<br/>
 
本标准适用于除虚拟业务（包括但不限于旅游、酒店、票务、充值、彩票）外的平台开放平台所有卖家。<br/>

第一章 入驻<br/>
1.1    平台开放平台暂未授权任何机构进行代理招商服务，入驻申请流程及相关的收费说明均以平台开放平台官方招商页面为准。<br/>
1.2    平台开放平台有权根据包括但不限于品牌需求、公司经营状况、服务水平等其他因素退回卖家申请。<br/>
1.3    平台开放平台有权在申请入驻及后续经营阶段要求卖家提供其他资质。<br/>
1.4    平台开放平台将结合各行业发展动态、国家相关规定及消费者购买需求，不定期更新招商标准。<br/>
1.5    卖家必须如实提供资料和信息：<br/>
1.5.1 请务必确保申请入驻及后续经营阶段提供的相关资质和信息的真实性、完整性、有效性（若卖家提供的相关资质为第三方提供，
包括但不限于商标注册证、授权书 等，请务必先行核实文件的真实有效完整性），一旦发现虚假资质或信息的，
平台开放平台将不再与卖家进行合作并有权根据平台开放平台规则及与卖家签署的相关 协议之约定进行处理；<br/>
1.5.2  卖家应如实提供其店铺运营的主体及相关信息，包括但不限于店铺实际经营主体、代理运营公司等信息；<br/>
1.5.3  平台开放平台关于卖家信息和资料变更有相关规定的从其规定，但卖家如变更1.5.2项所列信息，应提前十日书面告知平台；
如未提前告知平台，平台将根据平台开放平台规则进行处理。<br/>
1.6    平台开放平台暂不接受个体工商户的入驻申请，卖家须为正式注册企业，亦暂时不接受非中国大陆注册企业的入驻申请。<br/>
1.7    平台开放平台暂不接受未取得国家商标总局颁发的商标注册证或商标受理通知书的品牌开店申请，亦不接受纯图形类商标的入驻申请。
卖家提供商标受理通知书（TM状态商标）的，注册申请时间须满六个月。<br/>

第二章 平台店铺类型及相关要求<br/>
2.1     旗舰店，卖家以自有品牌（商标为R或TM状态），或由权利人出具的在平台开放平台开设品牌旗舰店的授权文件（授权文件中应明确排他性、不可撤销性），
入驻平台开放平台开设的店铺。<br/>
2.1.1  旗舰店，可以有以下几种情形：<br/>
经营一个自有品牌（商标为R或TM状态）商品入驻平台开放平台的卖家旗舰店，（自有品牌是指商标权利归卖家所有，自有品牌的子品牌可以放入旗舰店，主、子品牌的商标权利人应为同一实际控制人）；<br/>
经营已获得明确排他性授权的一个品牌商品入驻平台开放平台的卖家旗舰店；<br/>
卖场型品牌（服务类商标）商标权人开设的旗舰店；<br/>
2.1.2  开店主体必须是品牌（商标）权利人或持有权利人出具的开设平台开放平台旗舰店排他性授权文件的被授权企业。<br/>
2.2     专卖店，卖家持他人品牌（商标为R或TM状态）授权文件在平台开放平台开设的店铺。<br/>
2.2.1  专卖店类型：经营一个或多个授权品牌商品（多个授权品牌的商标权人应为同一实际控制人）但未获得旗舰店排他授权入驻平台开放平台的卖家专卖店；<br/>
2.2.2   品牌（商标）权利人出具的授权文件不应有地域限制。<br/>
2.3     专营店，经营平台开放平台相同一级经营类目下两个及以上他人或自有品牌（商标为R或TM状态）商品的店铺。<br/>
2.3.1  专营店，可以有以下几种情形：<br/>
相同一级类目下经营两个及以上他人品牌商品入驻平台开放平台的卖家专营店；<br/>
相同一级类目下既经营他人品牌商品又经营自有品牌商品入驻平台开放平台的卖家专营店。<br/>
2.4     各类型店铺命名详细说明，请见《平台开放平台卖家店铺命名规则》。<br/>

第三章 平台申请入驻资质标准<br/>
3.1    平台开放平台申请入驻资质标准详见《平台开放平台招商资质标准细则》。<br/>

第四章 开店入驻限制<br/>
4.1    品牌入驻限制：<br/>
4.1.1 与平台平台已有的自有品牌、频道、业务、类目等相同或相似名称的品牌；<br/>
4.1.2  包含行业名称或通用名称的品牌；<br/>
4.1.3  包含知名人士、地名的品牌；<br/>
4.1.4  与知名品牌相同或近似的品牌。<br/>
4.2     经营类目限制，卖家开店所经营的类目应当符合平台开放平台的相关标准，详细请参考《平台开放平台经营类目资费一览表》。<br/>
4.3同一主体入驻的店铺限制：<br/>
4.3.1  单个店铺只可对应一种经营模式。各经营模式内容请参考与卖家签署的对应合同；<br/>
4.3.2  同一主体开设若干店铺的，经营模式总计不得超过两种，且须在开展第二种经营模式时提前10日向平台进行书面申请；<br/>
4.3.3  商品重合度：要求店铺间经营的品牌及商品不得重复4.3.2项下经过平台审批的店铺不受此项约束。<br/>
4.4     同一主体重新入驻平台开放平台限制：<br/>
4.4.1  严重违规、资质造假被平台清退的，永久限制入驻；<br/>
4.4.2  若卖家一自然年内主动退出2次，则自最后一次完成退出之日起12个月内限制入驻。<br/>
4.5     续签限制：须在每年3月1日18时之前完成续签申请的提交，每年3月20日18时之前完成平台使用费的缴纳，
如果上一年及下一年资费及资料未补足，平台将在每年3月31日24时终止店铺服务并下架商品。<br/>

第五章 平台开放平台保证金/平台使用费/费率标准<br/>
5.1     保证金：卖家向平台缴纳的用以保证店铺规范运营及对商品和服务质量进行担保的金额。
当卖家发生违约、违规行为时，平台可以依照与卖家签署的协议中相关约定及平台开放平台规则扣除相应金额的保证金作为违约金或给予买家的赔偿。<br/>
5.1.1  保证金的补足、退还、扣除等依据卖家签署的相关协议及平台开放平台规则约定办理；<br/>
5.1.2  平台开放平台各经营类目对应的保证金标准详见《平台开放平台经营类目资费一览表》。<br/>
5.2     平台使用费：卖家依照与平台签署的相关协议使用平台开放平台各项服务时缴纳的固定技术服务费用。
平台开放平台各经营类目对应的平台使用费标准详见《平台开放平台经营类目资费一览表》。续签卖家的续展服务期间对应平台使用费须在每年3月20日18时前一次性缴纳；
新签卖家须在申请入驻获得批准时一次性缴纳相应服务期间的平台使用费。<br/>
5.2.1   平台使用费结算：<br/>
5.2.1.1卖家主动要求停止店铺服务的不返还平台使用费；<br/>
5.2.1.2卖家因违规行为或资质造假被清退的不返还平台使用费；<br/>
5.2.1.3每个店铺的平台使用费依据相应的服务期计算并缴纳。服务开通之日在每月的1日至15日（含）间的，开通当月按一个月收取平台使用费，
服务开通之日在每月的16日（含）至月底最后一日间的，开通当月不收取平台使用费；<br/>
5.2.1.4拥有独立店铺ID的为一个店铺，若卖家根据经营情况须开通多个店铺的，须按照店铺数量缴纳相应的平台使用费。<br/>
5.3     费率：卖家根据经营类目在达成每一单交易时按比例（该比例在与卖家签署的相关协议中称为“技术服务费费率”或“毛利保证率”）向平台缴纳的费用。
平台开放平台各经营模式各经营类目对应的费率标准详见《平台开放平台经营类目资费一览表》。<br/>

第六章 店铺服务期<br/>
6.1     卖家每个店铺的第一个服务期自服务开通之日起至最先到达的3月31日止，第二个服务期自4月1日起至次年3月31日止，
第三个、第四个……服务期以此类推，以一年为周期，除非店铺或与卖家签署的相关协议提前终止。<br/>
6.2     卖家每个店铺的服务开通之日以平台通知或系统记录的时间为准。<br/>
6.3     卖家应在店铺每个服务期届满前30日向甲方提出续展的申请，缴纳续展服务期的平台使用费和提交其经营所需的全部有效资质，并经平台审核。<br/>
6.4     卖家未提出续展申请或申请未通过平台审核的，自店铺服务期满之日起，平台开放平台将不再向卖家提供该店铺的任何服务。<br/>
			
			</p>
		</blockquote>
	</div>
	
	<!--资费标准-->
	<div class="row rowitem" style="display:none;" id="item_4">
		<blockquote class="blockquote blockquote-info" >
			<p>
			乐汇百材开放平台目前免费入驻。
			</p>
		</blockquote>
	</div>
	</div>
	</div>
	<!-- Bottom Scripts -->
	
	<script type="text/javascript">
	
	var basepath=null; /*根目录*/
	
	$(function(){
		setAllDomain();
		getMerRegBanner();
		/*获取是否注册过商家*/
		//getShopInfo();
		
		$("#Eprise_Enter_btn").click(function(){
			window.location = basepath+"pages/MerChnt/merRegister.jsp";
		});
		
		$("#Person_Enter_btn").click(function(){
			window.location = basepath+"pages/MerChnt/personReg.jsp";
		});
		
		$("#Enter_Process_btn").click(function(){
			var step = $(this).data("item");
			$(".badge").removeClass("badge-info");
			$(".badge").addClass("badge-default");
			$(this).children("span").removeClass("badge-default");
			$(this).children("span").addClass("badge-info");
			$(".rowitem").slideUp();	
			$("#"+step).slideDown();
		});
		
	});
	
	var setAllDomain = function(){
		basepath=getRootPath();	
	}
	function getShopInfo(){
		var modevalue='02' ; //绑定类型：账号与店铺账号对应类型
		var param = {mode:modevalue};
		/*  alert(JSON.stringify(param));*/
		$.post(basepath+'Bind/GetBindInfo.action',param,function(data){
		//alert(JSON.stringify(data));
		if(data.rspCode=="000000"){
			window.location = basepath+"pages/MerChnt/MerCenter.jsp?shop_id="+data.objs[0].keyB;
		}
		else
		{
			getMerRegBanner();
		}
		
	},"json");
	}
	function getMerRegBanner(){
		var b_type='0003' ; //banner类型
		var param = {Type:b_type};
		$.post(basepath+'Banner/GetBannerInfo.action',param,function(data){
		/* alert(JSON.stringify(data)); */
		var len = data.objs.length;
		var title = data.objs[0].title;
		var imgurl = data.objs[0].imgUrl;
		var url =data.objs[0].url;
		var banner;
		banner='<div id="merreg-carousel" class="carousel slide" data-ride="carousel">';
		banner+='<ol class="carousel-indicators">';
		banner+='<li data-target="#merreg-carousel" data-slide-to="0" class="active"></li>';
		for(var i=1;i<len;i++)
		{
			banner+='<li data-target="#merreg-carousel" data-slide-to="'+i+'"></li>';
		}
		banner+='</ol>';
		banner+='<div class="carousel-inner" role="listbox">';
		banner+='<div class="item active">';
		banner+='<a target="_blank" href="'+url+'"> <img src="'+imgurl+'" alt="'+title+'" style="height:450px"></a>';
		banner+='<div class="carousel-caption">'+'</div></div>';

		for(var j=1;j<len;j++){
			title = data.objs[j].title;
			imgurl = data.objs[j].imgUrl;
			url = data.objs[j].url;			
			banner+='<div class="item">';
			banner+='<a target="_blank" href="'+url+'"> <img src="'+imgurl+'" alt="'+title+'" style="height:450px"></a>';
			banner+='<div class="carousel-caption">'+'</div></div>';
		}
		banner+='</div>';
		
		banner+='<a class="left carousel-control" href="#merreg-carousel" role="button" data-slide="prev">';
		banner+='<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>';
		banner+='<span class="sr-only">Previous</span>';
		banner+='</a>';
		banner+='<a class="right carousel-control" href="#merreg-carousel" role="button" data-slide="next">';
		banner+='<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>';
		banner+='<span class="sr-only">Next</span>';
		banner+='</a>';
		banner+='</div>';
		$("#merReg-banner").append(banner);
	},"json");
	}
		$(function(){
			$(".process_item").click(function(){
				var step = $(this).data("item");
				$(".badge").removeClass("badge-info");
				$(".badge").addClass("badge-default");
				$(this).children("span").removeClass("badge-default");
				$(this).children("span").addClass("badge-info");
				$(".rowitem").slideUp();	
				$("#"+step).slideDown();
			});
			
		});
		
		function goToHomePage(){
			window.location = basepath;
		}
		
	</script>
	
	 <jsp:include page="../HomePages/home_footerbar.jsp" />	
	 </div>
</body>
     <script src="<%=tPath%>/assets/plugs/bootstrap/js/bootstrap.min.js"></script>
</html>