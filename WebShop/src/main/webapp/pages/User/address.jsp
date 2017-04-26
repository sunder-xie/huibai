<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8"></meta>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta name="description" content="乐汇百材-用户中心" />
	<meta name="author" content="hlb" />
		<%@ include file="../common/path.jsp" %>
	<%@ include file="../common/base.jsp" %>
    <base href="<%=tBasePath%>"></base>
	<title>乐汇百材-用户中心</title>
	<!-- website -->
    <link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/web/web_frame.css">
    <link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/web/web_manger_header.css">
    <link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/web/web_manger_menu.css">
    
    <link rel="stylesheet"
	href="<%=tPath%>/assets/css/fonts/linecons/css/linecons.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/bootstrap.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/bootstrap-table.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/xenon-core.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/xenon-forms.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/base.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/user.css">
	<link href="<%=tPath%>/assets/css/Pager.css" rel="stylesheet" type="text/css" />  
	<style type="text/css">
    </style>
</head>
<body>
    <div class="site_frame">
    <jsp:include page="../HomePages/home_topbar.jsp" />
    <jsp:include page="userHeader.jsp" />

    <div class="site_frame_main">
    
    <div class="site_frame_wrap cmMiddle">
         <div class="site_frame_menus">
              <div id="menu"></div>
         </div>
         <div class="site_frame_cont">
         		<div class="bussiness-crumbs" style="position:static">
				   您的位置：
				   <span class="orange">用户中心</span>&nbsp;&nbsp;&gt;&nbsp;&nbsp;
				   <span class="orange">账户管理</span>&nbsp;&nbsp;&gt;&nbsp;&nbsp;我的资料
				</div>
                <div id="main">

					<div class="err-content">
						<p style="display: none;" id="common_errors"
							class="alert alert-danger"></p>
					</div>

					<div id="addhtml" class="uc-content" style="display:none">
                <div id="ut192" class="data-title" style="margin-bottom: 20px">
							<h2 id="ut193">新增收货地址</h2>
							
						</div>
     
      <div id="ut193" class="form">
        <!--<div class="form-group">
                        <label class="label"></label>
                        <div class="controls">
                            <span class="control info">电话号码、手机号选填一项,其余均为必填项</span>
                        </div>
                    </div>-->
        <div id="ut194" class="form-group">
         <label id="ut195" class="label"><span id="ut196" class="required">*</span>所在地区</label>
         <div id="addselect" class="controls">
	  		<select id ="addprov" class="prov control combo w88"></select> 
	    	<select id ="addcity" class="city control combo w146" disabled="disabled"></select>
	        <select id ="adddist" class="dist control combo w146" disabled="disabled"></select>
         </div>
     </div>
        
        <!-- <div id="ut194" class="form-group">
          <label id="ut195" class="label"><span id="ut196" class="required">*</span>所在地区</label>
          <div id="ut197" class="controls">
            <div id="p" class="control combo w88"><div id="ut198" class="input placeHolder">请选择</div></div>
            <div id="c" class="control combo w146"><div id="ut199" class="input placeHolder">请选择</div></div>
            <div id="a" class="control combo w146"><div id="ut200" class="input placeHolder">请选择</div></div>
          </div>
        </div>  -->
        <div id="ut201" class="form-group">
          <label id="ut202" class="label"><span id="ut203" class="required">*</span>详细地址</label>
          <div id="ut204" class="controls">
            <div id="ut205" class="placeHolderWrap">
            <textarea id="address" maxlength="100" class="control text-control w378" placeholder="建议您如实填写详细收货地址，例如街道名称，门牌号码，楼层和房间号等信息"></textarea>
           <!-- <div id="address" style="height: 60px; width: 394px;" class="placeHolder">建议您如实填写详细收货地址，例如街道名称，门牌号码，楼层和房间号等信息</div> -->
            </div>
          </div>
        </div>
        <div id="ut207" class="form-group ">
          <label id="ut208" class="label"><span id="ut209" class="required">*</span>收件人姓名</label>
          <div id="ut210" class="controls">
            <div id="ut211" class="placeHolderWrap">
            <input id="consignee" class="control text-control w282" maxlength="25" placeholder="长度不超过25个字符">
            <!-- <div id="ut212" style="height: 15px; width: 282px;" class="placeHolder">长度不超过25个字符</div> -->
            </div>
          </div>
        </div>
        <div id="ut213" class="form-group ">
          <label id="ut214" class="label"><span id="ut215" class="required">*</span>手机号码</label>
          <div id="ut216" class="controls">
            <div id="ut217" class="placeHolderWrap">
            <input class="control text-control w248" maxlength="11" data-int="true" data-placeholder="" id="phoneNum">
            <!-- <div id="ut218" style="height: 15px; width: 248px;" class="placeHolder"></div> -->
            </div>
          </div>
        </div>
        <div id="ut219" class="form-group ">
          <label id="ut220" class="label"></label>
          <div id="ut221" class="controls">
            <input class="control" id="isDefault" type="checkbox">
            <span id="ut222" class="control" style="color:#888">设置为默认收货地址</span>
          </div>
        </div>
        <div id="ut223" class="form-group">
          <label id="ut224" class="label"></label>
          <div id="ut225" class="controls">
            <a id="ut51" class="btn btn-r addconfirm" style="margin-left: 100px" href="javascript:void(0);">确定</a>
            <a id="ut52" class="btn btn-g" href="javascript:void(0);">取消</a>
          </div>
        </div>
      </div>
    </div>
    
    <div id="modifyhtml" class="uc-content" style="display:none">
     <div id="ut192" class="data-title" style="margin-bottom: 20px">
							<h2 id="ut193">编辑收货地址</h2>
							
						</div>
      
      <div id="ut193" class="form">
        <!--<div class="form-group">
                        <label class="label"></label>
                        <div class="controls">
                            <span class="control info">电话号码、手机号选填一项,其余均为必填项</span>
                        </div>
                    </div>-->
         <div id="ut194" class="form-group " style="display: none;">
          <label id="ut195" class="label"><span id="ut196" class="required"> * </span>地址编号</label>
           <div id="ut210" class="controls">
         <div id="ut211" class="placeHolderWrap">
            <input id="addrId_m" class="control text-control w282" >
            </div>
          </div>
        </div>
        <div id="ut194" class="form-group ">
          <label id="ut195" class="label"><span id="ut196" class="required"> * </span>所在地区</label>
          
          <div id="modifyselect" class="controls">
	  		<select id ="modifyprov" class="prov control combo w88"></select> 
	    	<select id ="modifycity" class="city control combo w146" disabled="disabled"></select>
	        <select id ="modifydist" class="dist control combo w146" disabled="disabled"></select>
         </div>
         
        </div>
        <div id="ut201" class="form-group">
          <label id="ut202" class="label"><span id="ut203" class="required"> * </span>详细地址</label>
          <div id="ut204" class="controls">
            <div id="ut205" class="placeHolderWrap">
            <textarea id="address_m" maxlength="100" class="control text-control w378" placeholder="建议您如实填写详细收货地址，例如街道名称，门牌号码，楼层和房间号等信息"></textarea>
            </div>
          </div>
        </div>
        <div id="ut207" class="form-group ">
          <label id="ut208" class="label"><span id="ut209" class="required"> * </span>收件人姓名</label>
          <div id="ut210" class="controls">
            <div id="ut211" class="placeHolderWrap">
            <input id="consignee_m" class="control text-control w282" maxlength="25" placeholder="长度不超过25个字符">
            </div>
          </div>
        </div>
        <div id="ut213" class="form-group ">
          <label id="ut214" class="label"><span id="ut215" class="required"> * </span>手机号码</label>
          <div id="ut216" class="controls">
            <div id="ut217" class="placeHolderWrap">
            <input class="control text-control w248" maxlength="11" data-int="true" placeholder="" id="phoneNum_m">
            <div id="ut218" style="height: 15px; width: 248px;" class="placeHolder"></div>
            </div>
          </div>
        </div>
        <div id="ut219" class="form-group ">
          <label id="ut220" class="label"></label>
          <div id="ut221" class="controls">
            <input checked="checked" class="control" id="isDefault_m" type="checkbox">
            <span id="ut222" class="control" style="color:#888">设置为默认收货地址</span>
          </div>
        </div>
        <div id="ut223" class="form-group ">
          <label id="ut224" class="label"></label>
          <div id="ut225" class="controls">
            <a id="ut51" class="btn btn-r confirm_modify" style="margin-left: 100px" href="javascript:void(0);">确定</a>
            <a id="ut52" class="btn btn-g" href="javascript:void(0);">取消</a>
          </div>
        </div>
      </div>
    </div>
					<div id="addrlist" class="uc-content">
						<div id="ut192" class="data-title" style="margin-bottom: 20px">
							<h2 id="ut193">地址管理</h2>
							<button id="ut194" class="btn-add fr"
								onclick="addAddress()">增加地址</button>
						</div>
						<div id="ut195" class="data-table">
							<table id="ut196" border="0" cellpadding="0" cellspacing="0">
								<thead id="ut197">
									<tr id="ut198">
										<th id="ut199">收货人</th>
										<th id="ut200">所在地区</th>
										<th id="ut201">详细地址</th>
										<th id="ut202">电话</th>
										<th id="ut203">操作</th>
									</tr>
								</thead>
								<tbody id="data-table-body">
								<tr>
								<td ></td>
								<td >还没有地址信息！</td>
								</tr>
									
								</tbody>
							</table>
							<div class="paginator-info">
							    <div id="J_bottomPage" style="margin-top: -40px;"></div>
							</div>
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
    <!-- footer -->
 <jsp:include page="../HomePages/home_footerbar.jsp" />
  </div>
</body>
	<script src="<%=tPath%>/assets/plugs/bootstrap/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=tPath%>/assets/js/jquery.cityselect.js"></script>
	<script src="<%=tPath%>/pages/User/address.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
	<script src="<%=tPath%>/pages/User/userMenu.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
	<script src="<%=tPath%>/assets/plugs/jquery/jquery.pager.js" type="text/javascript"></script>    
</html>