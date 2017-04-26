<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8"></meta>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta name="description" content="乐汇百材-发布商品" />
	<meta name="author" content="hlb" />
			<%@ include file="../common/path.jsp" %>
	<%@ include file="../common/base.jsp" %>
    <base href="<%=tBasePath%>"></base>
	<title>乐汇百材-发布商品</title>
	<!-- website -->
    <link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/web/web_frame.css">
    <link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/web/web_manger_header.css">
    <link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/web/web_manger_menu.css">
    
	<link rel="stylesheet" href="<%=tPath%>/assets/css/fonts/linecons/css/linecons.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/bootstrap.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/xenon-core.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/xenon-forms.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/jquery.jscrollpane.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/jquery.fileupload.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/jquery.fileupload-ui.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/base.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/MerChnt.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/pubGoods.css">
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
				   <span class="orange">商品管理</span>&nbsp;&nbsp;&gt;&nbsp;&nbsp;商品发布
				</div>
                <div id="main">
      
        <!-- page one -->
        <div id="ut305" class="goodsRelease-main">
            <div id="ut306" class="common-title"><strong id="ut307">发布商品</strong></div>
            <div id="ut308" class="gr-search-main" style="display: none;">
                <div id="ut309" class="gr-search-box">
                    <input id="ut91" placeholder="请输入商品名称/类目名称进行搜索" type="text">
                </div>
                <div id="ut310" class="gr-search-btn">搜索类目</div>
            </div>
            <div id="ut311" class="gr-recentUse-main">
                <div id="ut312" class="gr-recentUse-class">
                    <p id="ut313">您最近使用的类目</p>
                    <div id="ut314">
                        <p id="ut315">暂无</p>
                        <img id="ut316" src="<%=tPath%>/images/combo_down.png">
                    </div>
                </div>
                <ul id="ut317" style="display: none;">
              <!--   <li id="ut318" dirid="105102102101">电脑&gt;电脑整机&gt;平板电脑&gt;平板电脑</li> -->
                </ul>
            </div>

            <div id="ut328" class="gr-filterWrap">
                <div id="ut329" class="gr-filterMain">
                    <div id="ut330" class="gr-filter">
                        <img id="ut331" src="<%=tPath%>/images/search.jpg">
                        <input id="ut92" class="gr-filterSubCate" placeholder="输入名称搜索" type="text">
                    </div>
                    <div id="ut332" class="gr-filter">
                        <img id="ut333" src="<%=tPath%>/images/search.jpg">
                        <input id="ut93" class="gr-filterSubCate" placeholder="输入名称搜索" type="text">
                    </div>
                    <div id="ut334" class="gr-filter">
                        <img id="ut335" src="<%=tPath%>/images/search.jpg">
                        <input id="ut94" class="gr-filterSubCate" placeholder="输入名称搜索" type="text">
                    </div>
                    <div id="ut336" class="gr-filter" style="border-right: 1px solid #dedede;">
                        <img id="ut337" src="<%=tPath%>/images/search.jpg">
                        <input id="ut95" class="gr-filterSubCate" placeholder="输入名称搜索" type="text">
                    </div>
                </div>
                <div id="ut338" class="grCategoryListMain">
									<div tabindex="0" id="ut339"
										style="overflow: hidden; padding: 0px; width: 218px;"
										class="grCategoryList jspScrollable">
										<ul id="ut342" class="grGetListOne">
										</ul>
									</div>

									<div id="ut484"
										style="overflow: hidden; padding: 0px; width: 218px;"
										class="grCategoryList">
										<ul id="ut487" class="grGetListTwo">
										</ul>
									</div>

									<div id="ut488"
										style="overflow: hidden; padding: 0px; width: 218px;"
										class="grCategoryList">
										<ul id="ut491" class="grGetListThree">
										</ul>
									</div>
									<div id="ut492" class="grCategoryList"
										style="border-right: 1px solid rgb(222, 222, 222); overflow: hidden; padding: 0px; width: 218px;">
										<ul id="ut495" class="grGetListFour">
										</ul>
									</div>
								</div>
            </div>
            <div id="ut496" class="gr-category-nav">
                <div id="ut497" class="gr-triangle"></div>
                <p id="ut498">
                    <span id="ut499">您当前选择的是：</span>
                    <span id="ut500" class="gr-category-one"></span>
                    <span id="ut501" style="display:none;">&gt;</span>
                    <span id="ut502" class="gr-category-two"></span>
                    <span id="ut503" style="display:none;">&gt;</span>
                    <span id="ut504" class="gr-category-three"></span>
                    <span id="ut505" style="display:none;">&gt;</span>
                    <span id="ut506" class="gr-category-four"></span>
                </p>
            </div>
            <div id="ut507" class="dt qr-notice">
                <img id="ut508" src="<%=tPath%>/images/qr-chooseCheckbox.png" class="im">
                <p id="ut509" class="im">已阅读<a id="ut96" href="#" target="_blank" style="text-decoration: underline;">“发布须知”</a></p>
            </div>
            <div id="ut510" class="qr-release-btn">已阅读发布规则，发布商品</div>
        </div>

        <!-- page two -->
        <div id="ut511" class="fillProInfo-main" style="display: none;">
            <div id="ut512" class="fpi-rightNav">
                <ul id="ut513">
                    <div id="ut514">发布助手</div>
                    <li id="ut515"><a id="ut97" href="#fpi-goCategory">商品类目</a></li>
                    <li id="ut516"><a id="ut98" href="#fpi-goProName">商品名称</a></li>
                    <li id="ut517"><a id="ut99" href="#fpi-goProPoint">商品卖点</a></li>
                    <li id="ut518"><a id="ut100" href="#fpi-goPic">商品图片</a></li>
                    <li id="ut519"><a id="ut101" href="#fpi-goSpec">商品规格</a></li>
                    <li id="ut520"><a id="ut102" href="#fpi-goStock">库存</a></li>
                    <li id="ut521"><a id="ut103" href="#fpi-goPrice">价格</a></li>
                    <li id="ut522"><a id="ut104" href="#fpi-goWeight">重量</a></li>
                    <li id="ut523"><a id="ut105" href="#fpi-goVolume">体积</a></li>
                    <li id="ut524"><a id="ut106" href="#fpi-goFreight">运费模板</a></li>
                    <li id="ut525"><a id="ut107" href="#fpi-goDescribe">商品描述</a></li>
                </ul>
            </div>
            <div id="ut526" class="common-title"><strong id="ut527">填写商品信息</strong></div>
            <div class="fpi-category-nav fpi-list-main" id="fpi-goCategory">
                <p id="ut528" class="fpi-tit"><span id="ut529">*</span>商品类目</p>
                <div id="ut530" class="fpi-nav">
                    <span id="ut531" class="fpi-nav-one"></span>
                    <span id="ut532" style="display:none;">&gt;</span>
                    <span id="ut533" class="fpi-nav-two"></span>
                    <span id="ut534" style="display:none;">&gt;</span>
                    <span id="ut535" class="fpi-nav-three"></span>
                    <span id="ut536" style="display:none;">&gt;</span>
                    <span id="ut537" class="fpi-nav-four"></span>
                </div>
                <div id="ut538" class="fpi-edit">编辑</div>
            </div>
            <!-- submit -->
            <div class="fpi-proName fpi-list-main" id="fpi-goProName">
                <p id="ut539" class="fpi-tit"><span id="ut540">*</span>商品名称</p>
                <div id="ut541">
                    <input placeholder="请简要说明这是什么商品，限30字" maxlength="30" name="spuName" id="spuName" type="text">
                </div>
                <p id="ut542" class="fpi-tip">还能输入<span id="ut543">30</span>个字</p>
            </div>
            <div class="fpi-proPoint fpi-list-main" id="fpi-goProPoint">
                <p id="ut544" class="fpi-tit">商品卖点</p>
                <textarea placeholder="请简要描述您的商品，对应商品名称下面部分。" name="fpiadvertorial" id="fpiadvertorial"></textarea>
                <p id="ut545" class="fpi-tip">还能输入<span id="ut546">60</span>个字</p>
            </div>
           <%--  <div class="fpi-brand-main" id="fpi-goBrand">
                <div id="ut547" class="fpi-brand fpi-list-main">
                    <p id="ut548" class="fpi-tit">品牌</p>
                    <div id="ut549" class="fpi-brand-btn">
                        <p id="ut550">请选择品牌</p>
                        <img id="ut551" src="<%=tPath%>/images/downa.png">
                    </div>
                </div>
                <ul id="ut552" style="">
                    <li id="ut553">耐克</li>
                    <li id="ut554">阿迪达斯</li>
                    <li id="ut555">李宁</li>
                    <li id="ut556">其他</li>
                </ul>
            </div> --%>
           <div class="fpi-pic fpi-list-main" id="fpi-goPic">
                <p class="fpi-tit"><span>*</span>商品图片</p>
                <div class="fpi-pic-main">
                    <p>( 请至少上传一张商品图片 )</p>
                    <ul class="product-list">

                    </ul>
                    <div style="width:570px;">
                        <div class="fpi-pic-btn">
                            本地上传
                            <input type="file" name="file" id="filedata" />
                        </div>
                        <p class="fpi-pic-tip">请上传1-9张图片，建议尺寸800*800px以上，支持1M内的jpg、png、bmp图片，无品牌LOGO和其他网站水印。
                        同时指定一张为商品封面图。</p>
                    </div>

                </div>
            </div>
            <div class="fpi-specifications fpi-list-main" id="fpi-goSpec">
                <p id="ut565" class="fpi-tit"><span id="ut566">*</span>商品规格</p>
                <ul id="ut567">
                    <li id="ut568" >
                        默认规格
                        <img id="ut569" src="../../images/fpi-guige-choose.png">
                    </li>
                    <li id="ut570" class="fpi-speActive">
                        单层规格
                        <img id="ut571" src="../../images/fpi-guige-choose.png">
                    </li>
                </ul>
                <p id="ut574" class="fpi-tip">最终发布时以当前选中规格为准</p>
            </div>
            <div id="ut575" class="fpi-layerMain">
               
                <!-- 单层规格 -->
                <div id="ut576" class="fpi-singleLayer" style="">
                    <div id="ut577" class="fpi-singleLayer-name">
                        <p id="ut578">自定义规格名称</p>
                        <div id="ut579">

                            <div id="ut580" class="fpi-sl-input">
                                <input id="ut108" placeholder="限30个字" maxlength="30" type="text">
                            </div>
                            <div id="ut581" class="fpi-sl-add">添加</div>
                        </div>
                    </div>
                    <div id="ut582" class="fpi-sl-info">
                        <div id="ut583" class="fpi-sl-infoTit">
                            <p id="ut584" style="width:190px;">规格</p>
                            <p id="ut585" style="width:210px;"><span id="ut586">*</span>价格（元）</p>
                            <p id="ut587" style="width:100px;"><span id="ut588">*</span>库存</p>
                        </div>
                        <div id="ut589" class="fpi-sl-listMain"></div>
                        <div id="ut590" class="fpi-sl-oneKey">
                            <p id="ut591">一键填写</p>
                            <div id="ut592" class="fpi-oneKey-price">
                                <p id="ut593">价格</p>
                                <div id="ut594">
                                    <input id="ut109" defval="price" type="text">
                                </div>
                                <p id="ut595">元</p>
                            </div>
                            <div id="ut596" class="fpi-oneKey-stock">
                                <p id="ut597">库存</p>
                                <div id="ut598">
                                    <input id="ut110" defval="stock" type="text">
                                </div>
                            </div>
                            <div id="ut599" class="fpi-oneKey-btn">确认</div>
                        </div>
                    </div>
                    <p id="ut600" class="fpi-sl-tip">规格图片建议尺寸800*800px以上，支持1M内的jpg、png、bmp图片。</p>
                </div>
                
                <!-- 默认规格 -->
                <div style="display:none;" id="ut632" class="fpi-defaultLayer">
                    <div class="fpi-stock fpi-list-main" id="fpi-goStock">
                        <p id="ut633" class="fpi-tit"><span id="ut634">*</span>库存</p>
                        <div id="ut635">
                            <input id="ut115" placeholder="1-9999" defval="stock" type="text">
                        </div>
                        <span id="ut636" class="fpi-errorTip">
                            <img id="ut637" src="<%=tPath%>/images/fpi-errorpic.png">
                            <p id="ut638">请填写正确的库存，只能为1－9999的整数</p>
                        </span>
                    </div>
                    <div class="fpi-price fpi-list-main" id="fpi-goPrice">
                        <p id="ut639" class="fpi-tit"><span id="ut640">*</span>价格</p>
                        <div id="ut641">
                            <div id="ut642">
                                <input id="ut116" defval="price" type="text">
                            </div>
                        </div>
                        <p id="ut643" class="fpi-tip">元</p>
                        <span id="ut644" class="fpi-errorTip">
                            <img id="ut645" src="<%=tPath%>/images/fpi-errorpic.png">
                            <p id="ut646">请填写正确的价格，只能为0.01－999999999.99的数字</p>
                        </span>

                    </div>
                </div>
               
            </div>
          
            <div class="fpi-freight-main" id="fpi-goFreight">
                <div id="ut660" class="fpi-freight fpi-list-main">
                    <p id="ut661" class="fpi-tit"><span id="ut662">*</span>运费模板</p>
                    <div id="ut663" class="fpi-freight-btn">
                        <p id="ut664">请选择运费模板</p>
                        <img id="ut665" src="<%=tPath%>/images/combo_down.png">
                    </div>
                   <!--  <span id="ut666" class="fpi-freight-addBtn">新增运费模板</span>
                    <p id="ut667" class="fpi-freight-reload">刷新</p> -->
                </div>
                <ul style="" id="ut668"><li feeid="false" id="724425">包邮</li></ul>
            </div>
            <div class="fpi-describe fpi-list-main" id="fpi-goDescribe">
                <p id="ut673" class="fpi-tit"><span id="ut674">*</span>商品描述</p>
                <div id="ut675" class="fpi-describe-main">
                    <p id="ut676" class="fpi-describe-tit">电脑端</p>
                    <div id="ut677">
                        <p id="ut678">1、图片宽度建议不超过750px，否则系统会自行调整</p>
                        <p id="ut679">2、禁止引用外部CSS，不支持JS、FLASH、IFRAM</p>
                        <p id="ut680">3、禁止引用本站以外的网络图片和网络超链接</p>
                        <p id="ut681"> 4、不可出现售价、其他网站等信息</p>
                    </div>
                    <div>
                        <textarea id="description" name="file" resize="no" class="product-description"></textarea>
                         </div>
                    <div class="fpi-preview-btn">预览</div>
                    <div class="fpi-examine-btn">提交审核</div>
                </div>
            </div>
        </div>
				
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
    </div>
    
    <div style="margin-left: 0px; display: none;" id="error_tip" class="error-tip"></div>
    <!-- footer -->
 <jsp:include page="../HomePages/home_footerbar.jsp" />
 </div>
</body>
    <script src="<%=tPath%>/assets/plugs/jquery/jquery-1.11.3.min.js"></script>
    <script src="<%=tPath%>/assets/plugs/jquery/jquery.jscrollpane.min.js"></script>
    <script src="<%=tPath%>/assets/plugs/jquery/jquery.mousewheel.js"></script>
    <script src="<%=tPath%>/assets/plugs/jquery/jquery.cookie.js"></script>
	<script src="<%=tPath%>/assets/plugs/bootstrap/js/bootstrap.min.js"></script>
	<script src="<%=tPath%>/assets/js/comm.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
	<script type="text/javascript" src="<%=tPath%>/assets/js/xheditor/xheditor-1.2.2.min.js"></script>
	<script type="text/javascript" src="<%=tPath%>/assets/js/xheditor/xheditor_lang/zh-cn.js"></script>
 	<script src="<%=tPath%>/assets/js/upload/vendor/jquery.ui.widget.js"></script>
    <script src="<%=tPath%>/assets/js/upload/jquery.iframe-transport.js"></script>
    <script src="<%=tPath%>/assets/js/upload/jquery.fileupload.js"></script>
  <%--   <script src="<%=tPath%>/assets/js/upload/ajaxfileupload.js"></script> --%>
	<script src="<%=tPath%>/pages/MerChnt/pubGoods.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
	<script src="<%=tPath%>/pages/MerChnt/merComm.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
</html>