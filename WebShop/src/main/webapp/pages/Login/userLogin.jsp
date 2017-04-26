<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta name="description" content="乐汇百材用户登录" />
	<meta name="author" content="hlb" />
		<%@ include file="../common/path.jsp" %>
	<%@ include file="../common/base.jsp" %>
    <base href="<%=tBasePath%>"></base>
	<title>乐汇百材-用户登录</title>
	<!-- website -->
    <link rel="stylesheet" type="text/css" href="<%=tBasePath%>/assets/css/web/web_frame.css">
    <link rel="stylesheet" type="text/css" href="<%=tBasePath%>/assets/css/web/web_nhead.css">
    <!-- Bootstrap -->
	<link rel="stylesheet" href="<%=tBasePath%>/assets/css/fonts/linecons/css/linecons.css">
	<link rel="stylesheet" href="<%=tBasePath%>/assets/css/bootstrap.css">
	<%-- <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/xenon-core.css"> --%>
	<link rel="stylesheet" href="<%=tBasePath%>/assets/css/xenon-forms.css">
	<link rel="stylesheet" href="<%=tBasePath%>/assets/css/common.css">
	<style type="text/css">
	
	.login-wrap {
    position: relative;
    height: 450px;
    padding: 27px 0 35px;
    font-family: "微软雅黑";
    font-size: 12px;
    overflow: hidden;
    }

    .banner {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    overflow: hidden;
    height: 450px;
    }

	.banner > div > a {
	    display: block;
	    width: 100%;
	    height: 450px;
	    background-position: center center;
	    background-repeat: no-repeat;
	}
	
	.banner > div > a img{
	    width: 100%;
	    height:100%
	}

	
    .login-model { 
	 position: absolute;
	right: 170px;
	width: 420px;
	height: 420px;
	padding: 25px 20px 30px;
	background: #fff;
	border-radius: 8px;
	z-index: 1; 
	}
	
	.login-wrap .login-model {
	    margin: 0 auto;
	}

	.login-model .form-cont {
	    position: relative;
	    margin: 30px 24px 0;
	    height: 420px;
	    z-index: 101;
	}

    .login-model .form-cont .login-title { height:40px; line-height:40px; }
   .login-model .form-cont .login-title > a { float:right; text-decoration:none; color:#e77d00; }
   .login-model .form-cont .login-title > h2 { overflow:hidden; font-weight:normal; }
   .login-model .form-cont .login-content fieldset { border:0; padding-top:4px; }
   .login-model .form-cont .login-content legend { display:none; }
   .login-model .form-cont .login-content { padding:16px 30px 0; border-top:1px dashed #e4dcd0; }
   .login-model .form-cont .login-content ul > li { position:relative; width:100%; padding:10px 0; float:left; }
   .login-model .form-cont .login-content ul input[type="text"],.login-content ul input[type="password"] { position:relative; width:235px; height:14px; line-height:14px; padding:12px 9px; border:1px solid #dedede; background:transparent; }
   .login-model .form-cont .login-content ul input.short { float:left; width:125px; }
   .login-model .form-cont .login-content ul b { float:right; font-weight:normal; }
   .login-model .form-cont .login-content .tip { position:absolute; left:10px; top:24px; color:#888; }
   .login-model .form-cont .loginKeybord { position: absolute; top:20px; right:116px; width:25px; height:20px; background:url(../images/user/uc_icon_key.png) no-repeat 0 0; }
   .login-model .form-cont .loginKeybord:hover { background-position:0 -22px; }
    
    .login-model .form-cont .error-information { display:; min-height:16px; line-height:16px; }
	.login-model .form-cont .error-information span { no-repeat 0 0;display: inline-block; height: 16px;vertical-align: middle;width: 16px; }
		
    .login-model .form-cont .login-btn-info{width:91%;}
        
    .login-model .form-cont .code{
		background-image:url(111.jpg);
		font-family:Arial,宋体;
		font-style:italic;
		color:green;
		border:0;
		padding:2px 3px;
		letter-spacing:3px;
		font-weight:bolder;
		}
		.unchanged {
		border:0;
		}
.login-model .form-cont .net-cooperation {
    position: absolute;
    right: 0;
    color: #999;
}
.login-model .form-cont .net-cooperation .show-text {
    height: 1px;
    background: url(images/spritesheet.png) -144px 0 no-repeat;
    text-align: center;
    margin-top: 50px;
}

.login-model .form-cont .net-cooperation .show-text span {
    position: relative;
    top: -7px;
}
.login-model .form-cont .net-cooperation .account-list {
    margin-top: 20px;
}

.login-model .form-cont .net-cooperation .account-list .weixin {
    margin-left: 8px;
    background-position: 0 0;
}

.login-model .form-cont .net-cooperation .account-list .qq {
    background-position: -24px 0;
}
.login-model .form-cont .account-list .vip {
    background-position: -48px 0;
}
.login-model .form-cont .net-cooperation .account-list .yfb {
    background-position: -72px 0;
}

.login-model .form-cont .net-cooperation .account-list .hl {
    background-position: -96px 0;
}
.login-model .form-cont .net-cooperation .account-list .pptv {
    background-position: -120px 0;
    margin-right: 0;
}
.login-model .form-cont .net-cooperation .account-list a {
    float: left;
    display: block;
    width: 24px;
    height: 24px;
    margin-right: 36px;
    background: url(images/spritesheet.png) no-repeat;
    cursor: pointer;
    opacity: .5;
    filter: alpha(opacity=50);
}

.login-model .form-code {
    display: none;
    position: absolute;
    top: -186px;
    left: 181px;
    width: 338px;
    height: 402px;
    background-color: #fff;
    box-shadow: 0 0 4px rgba(187,187,187,.7);
    -webkit-transform: scale(0,0);
    transform: scale(0,0);
    -webkit-transition: -webkit-transform 500ms linear;
    transition: transform 500ms linear;
    overflow: hidden;
    z-index: 102;
}

.login-model .form-code .code-title {
    margin: 20px;
    font-size: 20px;
}

.login-model .form-code .qrcode-area {
    position: relative;
    height: 245px;
    z-index: 200;
}

.login-model .form-code .qrcode-area .qrcode-block {
    position: absolute;
    top: 48px;
    left: 96px;
    width: 140px;
    height: 140px;
    z-index: 201;
}

.login-model .form-code .qrcode-area .qrcode {
    position: absolute;
    top: 0;
    left: 0;
    height: 140px;
    width: 140px;
    z-index: 300;
}
.login-model .form-code .qrcode-area .qrcode-way {
    position: absolute;
    top: -36px;
    left: 0;
    width: 133px;
    height: 200px;
    opacity: 0;
    filter: alpha(opacity=0);
    z-index: 299;
}
.tc {
    text-align: center;
}
.mb10 {
    margin-bottom: 10px;
}
.mb10 {
    margin-bottom: 10px !important;
}

.login-model .form-code .down-link {
    margin: 0 auto;
    width: 110px;
    line-height: 1.5;
}

.login-model .form-code .down-link a, .lg-b .form .ok-msg a {
    color: #2272c8;
}

.login-model .form-code .down-link a, .lg-b .form .ok-msg a  {
    color: #2272c8;
}
.ico-down {
    height: 14px;
    background: url(images/spritesheet.png) -179px -1px no-repeat;
}
.ico-down {
    display: block;
    float: left;
    margin-right: 5px;
    width: 18px;
}

.login-model .check-arrow, .login-model .check-pc {
    position: absolute;
    right: 0;
    top: 0;
    height: 55px;
    width: 55px;
    background: url(images/spritesheet.png) 0 -24px;
    z-index: 100;
}

.login-model .check-pc {
    display: none;
    background: url(images/spritesheet.png) -55px -24px;
    z-index: 101;
}

	</style>
</head>
<body onLoad="createCode();">
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
						<a href="＃" target="_self" class="fore2">用户登录</a> 
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
    	<!-- 新版登录注册，动态banner 2014-11-5 -->
        <div class="login-wrap">
            <div class="banner">
                <div id="images-list">
                    <!-- 默认的图片 -->
                </div>
            </div>
    <div class="login-model">
	   <div class="form-cont">
		<div class="login-title">
			<a href="<%=request.getContextPath()%>/pages/Login/userRegister.jsp">免费注册></a>
			<h2>
				<img src="images/login.png">
			</h2>
		</div>
		
		<div class="login-content">
			<p style="display: none;" id="common_errors"
				class="alert alert-danger"></p>
		</div>
		<div class="row">
			<div class="col-md-11">
				<div class="form-group">
					<div class="input-group">
						<div class="input-group-addon">
							<i class="linecons-user"></i>
						</div>
						<input type="text" class="form-control" name="username"
							id="username" placeholder="用户名／手机号／邮箱" />
					</div>
				</div>
			</div>
		</div>
		<div class="row">

			<div class="col-md-8">
				<div class="form-group">
					<div class="input-group">
						<div class="input-group-addon">
							<i class="linecons-lock"></i>
						</div>
						<input type="password" class="form-control" name="password"
							id="password" placeholder="请输入用户密码" />
					</div>
				</div>
			</div>

			<div>
				<div>
					<div>
						<a class="forgetPassword" href="<%=request.getContextPath()%>">忘记密码？</a>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-8">
				<div class="form-group">
					<div class="input-group">
						<div class="input-group-addon">
							<i class="linecons-lock"></i>
						</div>
						<input type="text" class="form-control" name="yanzhengma"
							id="yanzhengma" placeholder="请输入验证码" />
					</div>
				</div>
			</div>

			<div>
				<div>
					<div>
						<input type="button" id="checkCode" class="code"
							style="width: 80px; height:32px" onClick="createCode()" />
						
					</div>
				</div>
			</div>
		</div>

		<div class="div_button">
			<button type="button" class="btn btn-info login-btn-info"
				id="loginBtn">登录</button>
		</div>

		<div class="net-cooperation">
			<p class="show-text">
				<span>用合作网站帐号登录</span>
			</p>
			<p class="account-list clearfix">
				<a href="javascript:void(0);"
					onclick="javascript:weixinLogin(); return false;" class="weixin"
					title="微信" name="Logon_index_denglu026"></a> <a
					href="javascript:void(0);"
					onclick="javascript:qqLogin(); return false;" class="qq" title="qq"
					name="Logon_index_denglu027"></a> <a href="javascript:void(0);"
					onclick="javascript:memberCardLogin(); return false;" class="vip"
					title="会员卡" name="Logon_index_denglu012"></a> <a
					href="javascript:void(0);"
					onclick="javascript:eppLogin(); return false;" class="yfb"
					title="易付宝" name="Logon_index_denglu017"></a> <a
					href="javascript:void(0);"
					onclick="javascript:hulianLogin(); return false;" class="hl"
					title="互联" name="Logon_index_denglu013"></a> <a
					href="javascript:void(0);"
					onclick="javascript:pptvLogin(); return false;" class="pptv"
					title="PPTV" name="Logon_index_denglu015"></a>
			</p>
		</div>
		</div>
		<div id="form-code" class="form-code" style="">
               <p class="code-title" >手机扫码，安全登录</p>
               <div id="qrCodeErrorDiv" class="err-msg hide">
                   <p><i class="tip-icon tip-error"></i><span></span></p>
               </div>
               <div class="qrcode-area">
               	<div class="qrcode-block">
                   	<img id="qrCodesId" class="qrcode" src=""/>
                   	<img class="qrcode-way" src="images/qrcode-way.png" alt=""/>
	</div>
               </div>
               <p class="mb10 tc">请使用手机客户端扫描二维码登录
               </p>
               <p class="down-link"><a id="DOWNLOAD_APP" target="_blank" href="" name="Logon_index_denglu019"><span class="ico-down" ></span>下载手机客户端</a></p>
           </div>
           
           <span class="check-arrow" id="qrCodeLogin" name="Logon_index_denglu018"></span>
           <span class="check-pc"  id="normalLogin"></span>

	</div>
   <!--  <div id="login-banner" class="main_content"></div> -->

	</div>
   </div>
	
		
	<!-- Bottom Scripts -->
	<script src="<%=request.getContextPath()%>/assets/plugs/bootstrap/js/bootstrap.min.js"></script>
	<script type="text/javascript">
	var passport_domain   = "https://#";
	//下载appURL
	var downLoadApp_Url = "http://#";
	 $(function(){
	    	setAllDomain();
	    	//enterSumbit();
	    	getLoginBannerImg();
	    	
	 });
	 
	var setAllDomain = function(){
		//下载客户端
	//	$("#DOWNLOAD_APP").attr("href",downLoadApp_Url);
		$("#qrCodeLogin").click(function(){
			setLogonStylebyImage();
        });
		$("#normalLogin").click(function(){
			//clearInterval(timeOutId);
			normallogin();
        });
		
		checkInputEvent();
    }
	
	function checkInputEvent(){
		$("#yanzhengma").keypress(onNormalLogonKeyPress);
	}
	
	//普通登录处理回车事件
	function onNormalLogonKeyPress(evt) {
	  	//兼容IE和Firefox获得keyBoardEvent对象
		evt = (evt) ? evt : ((window.event) ? window.event : "")
		//兼容IE和Firefox获得 keyBoardEvent对象的键值
		var keyCode = evt.keyCode?evt.keyCode:evt.which;
		if(keyCode==13) {
			userLogin();
		}
	}
	//采用扫描登陆方式进行登录
	/* function setLogonStylebyImage(){
		
		if(typeof(timeOutId) != "undefined"){
			clearInterval(timeOutId);
		}
		showScanInit();
		setQRCodes();
		//实时扫描
		timeOutId = setInterval(checkQRCodesValidate,2000);
	} */
    function setLogonStylebyImage(){
		
		if(typeof(timeOutId) != "undefined"){
			clearInterval(timeOutId);
		}
		showScanInit();
		setQRCodes();
		$(".check-pc").show();
	    $(".check-arrow").hide();
		$("#form-code").attr("style","opacity: 1; display: block; left: 45px; top: 15px; transform: scale(1);");
	} 
	
    function normallogin(){
		
		$(".check-pc").hide();
	    $(".check-arrow").show();
		$("#form-code").attr("style","");
	} 
	//设置二维码信息
	function setQRCodes(){
		//var qrCodesURL = passport_domain+"/ids/qrLoginUuidGenerate.htm?image=true" + "&yys=" + new Date().getTime();
		var qrCodesURL = "images/hbaicai.png";
		$("#qrCodesId").attr("src",qrCodesURL);
		return false;
	}
	
	//实时的探测二维码信息  0：起始状态  1：已有手机扫描了二维码； 2：手机确认授权； 3：uuid不存在或过期；4：系统异常
	function checkQRCodesValidate(){
		/* $.ajax( {
			type : 'POST',
			url  : passport_domain+'/ids/qrLoginStateProbe',
			data : 'uuid='+ login.getCookie("ids_qr_uuid"),
			dataType : 'jsonp',
			success : function(data) {
				if(data&& data.state){
					if(data.state == 1){
						//进行成功的跳转
						showScanOK();
					}else if(data.state == 2){
						//手机确认授权
						clearInterval(timeOutId);
						window.location = goUrl;
					}else if(data.state == 3){
						//过期：切换登陆方式
						clearInterval(timeOutId);
						showScanError('二维码已失效，请<a href="javascript:void(0);" onclick="javascript:setLogonStylebyImage();">刷新</a>后重新扫描登录！');
					}else if(data.state == 4){
						//系统异常
						showScanError();
					}
				}else{
					//系统异常
					showScanError();
				}
			},
			error : function(data) {
				//系统异常
				showScanError();
			}
		}); */
	}
	function showScanInit(){
		$("#qrCodeErrorDiv").hide();
	}
	function showScanOK(){
		$("#qrCodeErrorDiv").find("span").html("扫描成功，请按手机的提示操作，请勿刷新");
		$("#qrCodeErrorDiv").find("i").removeClass("tip-error").addClass("tip-ok");
		$("#qrCodeErrorDiv").removeClass("err-msg").addClass("ok-msg");
		$("#qrCodeErrorDiv").show();
	}
	function showScanError(msg){
		$("#qrCodeErrorDiv").find("i").removeClass("tip-ok").addClass("tip-error");
		$("#qrCodeErrorDiv").removeClass("ok-msg").addClass("err-msg");
		if(msg){
			$("#qrCodeErrorDiv").find("span").html(msg);
			$("#qrCodeErrorDiv").show();
		}else{
			$("#qrCodeErrorDiv").find("span").html('系统繁忙，请<a href="javascript:void(0);" onclick="javascript:setLogonStylebyImage();">刷新</a>后重新扫描登录！');
			$("#qrCodeErrorDiv").show();
		}
	}
	
	var getLoginBannerImg = function(){
        var b_type='0002' ; //banner类型
		var param = {Type:b_type};
		$.post('Banner/GetBannerInfo.action',param,function(data){
			//alert(JSON.stringify(data));
			var len = data.objs.length;
			var title=data.objs[0].title;
			var imgurl = data.objs[0].imgUrl;
			var url = data.objs[0].url;
			var banner='';
			banner +='<a href="'+url+'" title="'+title+'" target="_blank" >';
			banner +='<img alt="'+title+'" src="'+imgurl+'">';
			banner +=' </a>';
			$("#images-list").append(banner);
		},"json");
	}
	
	
		$(function(){
			$("#loginBtn").click(function(){
				userLogin();
			});
		});
		
		function userLogin(){
			$("#loginBtn").html("登录中...");
			var username = $("#username").val();
			var password = $("#password").val();
			var yanzhengma = $("#yanzhengma").val();
			if(username==""){
				showInfos("用户名为空！");
				$("#username").focus;
				return;
			}
			if(password==""){
				showInfos("密码为空！");
				$("#password").focus;
				return;
			}
			if(password.length < 6){
				showInfos("密码长度最小6位！");
				$("#password").focus;
				return;
			} 
			if(yanzhengma==""){
				showInfos("验证码为空！");
				$("#yanzhengma").focus;
				return;
			}
			var inputCode=yanzhengma.toUpperCase();
		    if(inputCode != code ){				  
			   showInfos("验证码输入错误！");
				$("#yanzhengma").focus;					
				createCode();
			   return false;
			}				
			
			var param = {username:username,password:password};
			$.post("user/Login.action",param,function(data){
				if(data.rspCode=="000000"){
					setTimeout(goToHomePage, 0);
				}else{
					showInfos(data.rspMsg);
				}
			},"json");
		}
		function showInfos(str){
			$("#common_errors").html(str);
			$("#common_errors").slideDown();
			setTimeout(hiddenUserRegTips,3000);
			$("#loginBtn").html("登录");
		}
		
		function hiddenUserRegTips(){
			$("#common_errors").slideUp();
		}
		
		function goToHomePage(){
			//window.location = "<%=request.getContextPath()%>";
			window.location = "<%=request.getContextPath()%>"+"/pages/User/userCenter.jsp";
		}
		function refreshSec(){
			var sec = $("#second_id").html();
			$("#second_id").html((sec-1));
		}
		
		var code ; //在全局 定义验证码
		function createCode(){ 
		code = new Array();
		var codeLength = 4;//验证码的长度
		var checkCode = document.getElementById("checkCode");
		checkCode.value = "";

		var selectChar = new Array(2,3,4,5,6,7,8,9,'A','B','C','D','E','F','G','H','J','K','L','M','N','P','Q','R','S','T','U','V','W','X','Y','Z');

		for(var i=0;i<codeLength;i++) {
		   var charIndex = Math.floor(Math.random()*32);
		   code +=selectChar[charIndex];
		}
		if(code.length != codeLength){
		   createCode();
		}
		checkCode.value = code;
		}
		
	</script>
	<jsp:include page="../HomePages/home_footerbar.jsp" />
	</div>
</body>
</html>