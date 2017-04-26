<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8"></meta>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta name="description" content="乐汇百材-店铺装修" />
	<meta name="author" content="hlb" />
			<%@ include file="../common/path.jsp" %>
	<%@ include file="../common/base.jsp" %>
    <base href="<%=tBasePath%>"></base>
	<title>乐汇百材-店铺装修</title>
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
	<link rel="stylesheet" href="<%=tPath%>/assets/css/merDeco.css">
	<link href="<%=tPath%>/assets/css/Pager.css" rel="stylesheet" type="text/css" />  
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
				   <span class="orange">店铺管理</span>&nbsp;&nbsp;&gt;&nbsp;&nbsp;店铺装修
				</div>
                <div id="main">
               <div class="bussiness-container-wrap clearfix">
                    <div class="banner-manage">
                           <div id="disable" style="display:none;">
                                <h1>您当前是普通商家，完成认证后可以装修店铺！</h1>
                            </div>
                            <div class="tabs">
                                <ul>
                                    <li class="pc menu active" type="web">pc店铺装修</li>
                                   <!--  <li class="app menu" type="wap">app店铺装修</li>
                                    <li style="width: 70%"></li> -->
                                </ul>
                            </div>
                            
                            <div class="head_decorate clearfix">
								<div id="shopLogo" class="speate">
									<h3 class="shop_title">店铺标志</h3>
									 <div id="disable-logo" class="disable"></div>
	                                    <div class="upload-wrap">
	                                        <div class="upload-image-name"></div>
	                                        <div class="upload-shadow"></div>
	                                        <div class="upload-image-option">
	                                            <span>重新上传</span>
	                                            <input id="reshop-logo" type="file" name="file" value="" class="upload-banner">
	                                        </div>
	                                        <input id="shop-logo" type="file" name="file" value="" class="upload-banner" />
	                                    </div>
										<p class="prompt">（请点击图片上传，建议尺寸 800*800，支持1M以内jpg，png，bmp图片）</p>
										<!-- <p class="fs_audit hide">
											审核状态：<span id="sh-status" class="shtg">审核通过</span>
										</p> -->
								</div>
							</div>
							
                            <div class="head_decorate clearfix">
	                            <div id="shopCover" class="speate">
	                                    <h3 class="cover_title">店铺招牌</h3>
	                                    <div style="" class="upload-wrap">
	                                        <div class="upload-image-name"></div>
	                                        <div class="upload-shadow"></div>
	                                        <div class="upload-image-option">
	                                            <span>重新上传</span>
	                                            <input id="recov" name="file" type="file" value="" class="upload-banner" >
	                                        </div>
	                                        <input id="cov" name="file" type="file" value="" class="upload-banner">
	                                    </div>
	                                    <p id="app-size" style="display: none;">（请点击图片上传，建议尺寸 640*260，支持1M以内jpg，png，bmp图片）</p>
	                                    <p style="display: block;" id="pc-size" class="prompt">（请点击图片上传，建议尺寸 1920*110 ，支持1M以内jpg，png，bmp图片）</p>
	                                </div>
 							</div>

							<div id="bannerList">
								<h3>banner 管理</h3>
								 <div class="add-btn-wrap">
				                    <input id="addBannerBtn" class="dialog-btn use-btn" value="增加" type="button" bannernum="0">
				                </div>
								
								
								<table>
									<thead>
										<tr>
											<th class="banner-sort ">序号</th>
											<th class="banner-id hide">banner编号</th>
											<th class="banner-image">banner图片</th>
											<th class="banner-product">关联商品</th>
											<!-- <th class="banner-check">审核状态</th> -->
											<th class="banner-option">操作</th>
										</tr>
									</thead>
									<tbody>

									</tbody>
								</table>
							</div>
							<p>&nbsp;</p>
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
    </div>
    
    <textarea id="addBanner" class="hide">        
       <tr have="ok">
            <td >{sort}</td>
            <td class="hide">{bid}</td>
            <td>
                <div class="upload-wrap {havebanner}">
                    <div class="upload-image-name" img-res-id ="{resid}">
                        <img src="{img}" />
                    </div>
                    <div class="upload-shadow"></div>
                    <div class="upload-image-option" key="0">
                        <span>重新上传</span>
                        <input id="reBannerUpload{i}" type="file" name="file" value="" class="upload-banner reupload" />
                    </div>
                </div>
                <p class="upload-tip">（建议尺寸：480*200）</p>
            </td>
            <td>
                <div class="join-product" key="0" id ="{goodsid}">
                    <div class="join-image">
                        <div>
                            <div class="image-box">
                                <img src="{joinImg}"/>
                            </div>
                        </div>
                        {btn}
                    </div>
                    <div class="join-info">
                        {joinproduct}
                    </div>
                </div>
            </td>
            <!-- <td>{result}</td> -->
            <td>
            <input class="tool-btn use-btn deleteBtn" type="button" name="" value="删除" style="margin-top:20px" /></td>
        </tr>
    </textarea> 
    
    <textarea id="nullBanner" class="hide">        <tr have="no">
            <td >{sort}</td>
            <td class="hide"></td>
            <td>
                <div class="upload-wrap">
                    <div class="upload-image-name" key="0">
                        <img src="../../images/addbanner.jpg" alt="添加图片" />
                    </div>
                    <div class="upload-shadow"></div>
                    <div class="upload-image-option">
                        <span>重新上传</span>
                        <input id="reBannerUpload{i}" type="file" name="file" value="" class="upload-banner reupload" />
                    </div>
                    <input id="BannerUpload{i}" type="file" name="file" value="" class="upload-banner empty-upload" />
                </div>
                <p class="upload-tip">（建议尺寸：480*200）</p>
            </td>
            <td>
                <div class="join-product" key="0">
                    <div class="join-image">
                        <div></div>
                        <input class="tool-btn use-btn join-btn" type="button" name="" value="添加" />
                    </div>
                    <div class="join-info">
                        <h3></h3>
                        <p></p>
                    </div>
                </div>
            </td>
            <!-- <td></td> -->
            <td>
            <!-- disabled="disabled" -->
                <input class="tool-btn save-btn"  type="button" name="" value="保存" />
            </td>
        </tr>
    </textarea>
    
  <!--   <textarea id="addBanner" class="hide">        
       <tr have="ok">
            <td >{sort}</td>
            <td class="hide">{bid}</td>
            <td>
                <div class="upload-wrap {havebanner}">
                    <div class="upload-image-name">
                        <img src="{img}" />
                    </div>
                    <div class="upload-shadow"></div>
                    <div class="upload-image-option" key="0">
                        <span>重新上传</span>
                        <input type="file" name="reupload{i}" value="" class="upload-banner reupload" />
                    </div>
                </div>
                <p>
				<label> <input type="button" id="bannerUpload{i}" class="btn" value="上传" style=""/></label>
				<label> <input type="file" id="{i}" name="file" class="form-control uploadFile" style="padding: 0px;"/>
					</label>
				</p>
                <p class="upload-tip">（建议尺寸：480*200）</p>
            </td>
            <td>
                <div class="join-product" key="0">
                    <div class="join-image">
                        <div>
                            <div class="image-box">
                                <img src="{joinImg}"/>
                            </div>
                        </div>
                        {btn}
                    </div>
                    <div class="join-info">
                        {joinproduct}
                    </div>
                </div>
            </td>
            <td>{result}</td>
            <td>
            <input class="tool-btn use-btn deleteBtn" type="button" name="" value="删除" style="margin-top:20px" /></td>
        </tr>
    </textarea>  -->
   <!--   <textarea id="nullBanner" class="hide">        <tr have="no">
            <td >{sort}</td>
            <td class="hide"></td>
            <td>
                <div class="upload-wrap">
                    <div class="upload-image-name" key="0">
                        <img src="../../images/addbanner.jpg" alt="添加图片" />
                    </div>
                    <div class="upload-shadow"></div>
                    <div class="upload-image-option">
                        <span>重新上传</span>
                        <input type="file" name="reupload{i}" value="" class="upload-banner reupload" />
                    </div>
                    <input type="file" name="file{i}" value="" class="upload-banner empty-upload" />
                    
                     <p>
				<label> <input type="button" id="bannerUpload{i}" class="btn" value="上传" style=""/></label>
					<label> <input type="file" id="bannerid{i}" name="file" class="form-control uploadFile" style="padding: 0px;"/>
					</label>
				</p>
                </div>
                <p class="upload-tip">（建议尺寸：480*200）</p>
            </td>
            <td>
                <div class="join-product" key="0">
                    <div class="join-image">
                        <div></div>
                        <input class="tool-btn use-btn join-btn" type="button" name="" value="添加" />
                    </div>
                    <div class="join-info">
                        <h3></h3>
                        <p></p>
                    </div>
                </div>
            </td>
            <td></td>
            <td>
            disabled="disabled"
                <input class="tool-btn save-btn"  type="button" name="" value="保存" />
            </td>
        </tr>
    </textarea> -->
    <textarea id="productTemp" class="hide">       
     	<tr>
            <tr>
                <td>
                    <input type="radio" name="radio" />
                </td>
                <td>
                    <div class="image-box">
                        <img src="{imgPath}" />
                    </div>
                </td>
                <td>
                    <div class="product-detail">
                        <h4>{pName}</h4>
                        <div class="product-id">ID:<span>{pID}</span>
                        </div>
                    </div>
                </td>
                <td>
                    <span>{pPrice}</span>
                </td>
                <!-- <td>
                    <span>{pNum}</span>
                </td> -->
                <td>
                    <h5>已上架</h5>
                    <!-- <div class="check-time">{pTime}</div> -->
                </td>
            </tr>
        </tr>
    </textarea>
    <div style="margin-top: -280px; display: none;" class="dialog" id="contanPro">
        <div class="dialog-wrap">
            <div class="dialog-title">
                <h2>关联商品</h2>
            </div>
            <div class="dialog-content">
                <div class="content-wrap" id="mainContent">
                    <div class="dialog-search">
                        <label>查询</label>
                        <span>
                            <em class="select-search" key="name">商品名称</em>
                            <dl>
                                <dd value="name">商品名称</dd>
                                <dd value="id">商品ID</dd>
                            </dl>
                        </span>
                        <input id="productCondition" maxlength="10" value="" type="text">
                        <button id="searchBtn" class="tool-btn use-btn">搜索</button>
                    </div>
                    <table>
                        <thead>
                            <tr><th class="select-checkbox"></th>
                            <th class="select-image">商品图片</th>
                            <th class="select-info">商品信息</th>
                            <th class="select-price">价格（元）</th>
                            <!-- <th class="select-num">库存</th> -->
                            <th>审核状态</th>
                        </tr></thead>
                        <tbody>
                        </tbody>
                    </table>
					<div class="paginator-info">
						<div id="J_bottomPage" style="margin-top: -40px;"></div>
					</div> 
				</div>
				
			    
                <div class="btn-wrap">
                    <input id="confirmBtn" class="dialog-btn use-btn" value="确定" type="button">
                    <input class="dialog-btn disable-btn cancle-btn" value="取消" type="button">
                </div>
            </div>
        </div>
        <div class="dialog-close">close</div>
    </div>
    <input id="bannerSelect" bannerid="0" value="" type="hidden">
    <div style="" class="shadow"></div>
    <!-- footer -->
 <jsp:include page="../HomePages/home_footerbar.jsp" />
</body>
    <script src="<%=tPath%>/assets/plugs/jquery/jquery-1.11.3.min.js"></script>
	<script src="<%=tPath%>/assets/plugs/bootstrap/js/bootstrap.min.js"></script>
	<script src="<%=tPath%>/assets/js/comm.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
	<%-- <script src="<%=tPath%>/assets/js/upload/ajaxfileupload.js"></script> --%>
    <script src="<%=tPath%>/assets/js/upload/vendor/jquery.ui.widget.js"></script>
    <script src="<%=tPath%>/assets/js/upload/jquery.iframe-transport.js"></script>
    <script src="<%=tPath%>/assets/js/upload/jquery.fileupload.js"></script>
	<script src="<%=tPath%>/pages/MerChnt/merDeco.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
	<script src="<%=tPath%>/pages/MerChnt/merComm.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
	<script src="<%=tPath%>/assets/plugs/jquery/jquery.pager.js" type="text/javascript"></script>
	
</html>