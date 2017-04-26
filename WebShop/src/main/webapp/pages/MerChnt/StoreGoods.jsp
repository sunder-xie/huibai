<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8"></meta>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta name="description" content="乐汇百材-仓库中的商品" />
	<meta name="author" content="hlb" />
			<%@ include file="../common/path.jsp" %>
	<%@ include file="../common/base.jsp" %>
    <base href="<%=tBasePath%>"></base>
	<title>乐汇百材-仓库中的商品</title>
	<!-- website -->
    <link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/web/web_frame.css">
    <link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/web/web_manger_header.css">
    <link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/web/web_manger_menu.css">
    
    <link rel="stylesheet" href="<%=tPath%>/assets/css/fonts/linecons/css/linecons.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/bootstrap.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/xenon-core.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/xenon-forms.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/jquery-ui.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/base.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/Manage.css">
	<link href="<%=tPath%>/assets/css/Pager.css" rel="stylesheet" type="text/css" />  
	<link rel="shortcut icon" href="<%=tPath%>/favicon.ico" type="image/x-icon"/>
	<style type="text/css">
    </style>
</head>
<body>
    <div class="site_frame">
    <jsp:include page="../HomePages/home_topbar.jsp" />
    <jsp:include page="merHeader.jsp" />
   <div class="site_frame_main">
    
    <div class="site_frame_wrap cmMiddle">
         <div class="site_frame_menus">
              <div id="menu"></div>
         </div>
         <div class="site_frame_cont">
				<div class="bussiness-crumbs" style="position:static">
				   您的位置：
				   <span class="orange">商家平台</span>&nbsp;&nbsp;&gt;&nbsp;&nbsp;
				   <span class="orange">商品管理</span>&nbsp;&nbsp;&gt;&nbsp;&nbsp;仓库中的商品
				</div>
                <div id="main">
              <!--商品管理-->
            <div class="bussiness-container-box">
                <div class="bussiness-container-wrap clearfix">
                    <div class="common-title">商品管理</div>
                    <div class="fl goodsManageR">
                        <div class="goodsManageSearch">
                            <form id="goodsForm" name="goodsForm" action="/goodsManage/toIndex.html">
                                <ul class="clearfix">
                                    <li class="fl">
                                        <em>商品名称</em>
                                        <div class="select" style="width:160px;">
                                            <input type="text" name="spuName" class="goodsname" maxlength="30"
                                        value=""/>
                                        </div>
                                    </li>
                                   
                                    <li class="fl">
                                        <em>审核状态</em>

                                        <div class="select" >
                                        <div class="select_btn" style="width:132px;position:relative;height:36px;line-height:36px;z-index:4;">
                                            <input type="text" class="auditState" id="goodsManageAudit" readOnly="true" style="width:90px;"/>
                                            <input type="hidden" name="auditState" id="auditState" value="-1"/>
                                            <input type="hidden" name="publishState" id="publishState" value="-1"/>
                                            <i id="goodsManageSelectAuditBtn"><!--下拉按钮--></i>
                                        </div>

                                        <ul id="goodsManageSelectAuditUl" class="goodsManageSelectAuditUl"></ul>
                                        </div>
                                    </li>
                                    <li class="fl">
                                        <em>上架时间</em>

                                        <div class="select">
                                        <input type="text" id="startTime" readonly name="sTimeStr" class="upGoodsDate"
                                        value="" style="width:110px;"/>
                                        </div>
                                        <span class="dateTo">-</span>

                                        <div class="select">
                                        <input type="text" id="endTime" readonly name="eTimeStr" class="upGoodsDate"
                                        value="" style="width:110px;"/>
                                        </div>
                                    </li>
                                    <li class="fl goodsManageSearchBtn">
                                    <a href="javascript:void(0)" id="goodsManageSearchBtn">查询</a>
                                    <a href="javascript:void(0)" id="goodsManagereset">重置</a>
                                    </li>
                                </ul>
                            </form>
                        </div>
                        <div id="goodsOperation" class="goodsOperation clearfix">
                        <span class="fl"><a href="javascript:void(0)" class="batchOperation" id="putaway">批量上架</a></span>
                        <!-- <span class="fl"><a href="javascript:void(0)" class="batchOperation" id="soldout">批量下架</a></span> -->
                        <span class="fl" style="margin-top: 15px;">
                                <em style="color:#ff1515;font-style:inherit">成功发布的商品信息会有3分钟延迟生效</em>
                        </span>
                        <span class="fr"><a href="javascript:void(0)" onclick="turnToEditPage(0);">发布商品</a></span>
                        </div>
                        <div id="listResult">
                        
                        <ul class="goodsHeader clearfix">
                            <li class="w88 allSelect"><input id="all" type="checkbox" name="ckAll"/>全选</li>
                            <li class="w115">商品图片</li>
                            <li class="w200">商品信息</li>
                            <li class="w115">价格（元）</li>
                            <li class="w115">库存</li>
                            <li class="w115">审核状态</li>
                            <li class="w172">操作</li>
                        </ul>
                        <ul class="goodsList" id="goodsList">
                            
                        </ul>
                        
                        </div>
                         <div class="paginator-info">
							<div id="J_bottomPage" style="margin-top: -40px;"></div>
					    </div>
                    </div>
                   
                </div>
            </div>
    </div>
        <!--商品管理 End-->
				
				<div class="backpanel-inner">
					<div class="bp-item" id="bp-research">
						<a class="research" target="_blank" href="#"><b></b>调查问卷</a>
					</div>
					<div class="bp-item" id="bp-gotop">
						<a title="使用快捷键T也可返回顶部哦！" class="gotop" href="#" target="_self"><b></b>返回顶部</a>
					</div>
				</div>
            </div>
        </div>
    </div>
    
    
   <!--查看原因-->
<div class="tips_box reason_tips_box">
    <div class="tips_head clearfix">
        <div class="fl">查看原因</div>
        <div class="clear_btn fr"></div>
    </div>
    <div class="tips_content">
        <div style="height: 100px;">
            <p class="notice">您确认删除该商品吗？</p>
        </div>
        <div class="tips_btn clearfix">
            <a class="confirm" href="javascript:;" target="_self" style="margin-left:80px;">我知道了</a>
        </div>
    </div>
</div>

<!-- 下架锁定提示 -->
<div id="tiplock" class="tip_p hide">
<div class="popBox">

<div class="pbnContent">
<h2>提示</h2>

<div class="tip_content" style="height:198px;overflow:scroll;">
<p id="tiplock_res">该商品参加了活动，暂时不能下架</p>
</div>
<div class="tip_btn">
<a href="#" class="md_basic_btn okBtn" on>确定</a>
</div>
</div>
<div class="pbnBottom popbotSmall"></div>
</div>
</div>
<!--所有种类商品下架-->
    <div class="tips_box xj_tips_box">
    <div class="tips_head clearfix">
    <div class="fl">下架确认</div>
    <div class="clear fr"></div>
    </div>
    <div class="tips_content">
    <div>
    <p class="notice">下架后商品将无法购买，确定下架该商品？</p>
    </div>
    <div class="tips_btn clearfix">
    <a class="cancel" href="javascript:;" target="_self">取消</a>
    <a class="confirm" href="javascript:;" target="_self">确定</a>
    </div>
    </div>
    </div>

    <div class="tips_box sj_tips_box">
    <div class="tips_head clearfix">
    <div class="fl">上架确认</div>
    <div class="clear fr"></div>
    </div>
    <div class="tips_content">
    <div>
    <p class="notice">上架后商品可以被购买，确认操作吗？</p>
    </div>
    <div class="tips_btn clearfix">
    <a class="cancel" href="javascript:;" target="_self">取消</a>
    <a class="confirm" href="javascript:;" target="_self">确定</a>
    </div>
    </div>
    </div>
    
    <!--商品删除-->
    <div class="tips_box delete_tips_box">
    <div class="tips_head clearfix">
    <div class="fl">删除确认</div>
    <div class="clear_btn fr"></div>
    </div>
    <div class="tips_content">
    <div>
    <p class="notice">您确认删除该商品吗？</p>
    </div>
    <div class="tips_btn clearfix">
    <a class="cancel" href="javascript:;" target="_self">取消</a>
    <a class="confirm" href="javascript:;" target="_self">确定</a>
    </div>
    </div>
    </div>
    <!-- footer -->
 <jsp:include page="../HomePages/home_footerbar.jsp" />
 </div>
</body>
    <script src="<%=tPath%>/assets/plugs/jquery/jquery-1.11.3.min.js"></script>
	<script src="<%=tPath%>/assets/plugs/bootstrap/js/bootstrap.min.js"></script>
	<script src="<%=tPath%>/assets/plugs/jquery/jquery-ui.11.1.min.js"></script>
	<script src="<%=tPath%>/assets/plugs/jquery/jquery.ui.datepicker-zh-CN.js"></script>
	<script src="<%=tPath%>/assets/js/comm.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
	<script src="<%=tPath%>/pages/MerChnt/StoreGoods.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
	<script src="<%=tPath%>/pages/MerChnt/merComm.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
	<script src="<%=tPath%>/assets/plugs/jquery/jquery.pager.js" type="text/javascript"></script>
</html>