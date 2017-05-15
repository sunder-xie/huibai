<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="yes" name="apple-touch-fullscreen">
<meta content="telephone=no" name="format-detection">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1;user-scalable=no;">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../common/base.jsp" %>
<base href="<%=tBasePath%>"></base>
<title>会员注册</title>
<link rel="stylesheet" href="css/bootstrap.css?v=10.09">
<link rel="stylesheet" href="css/style.css?v=10.09">
<link rel="stylesheet" href="css/app.css?v=10.09">

<script charset="utf-8" src="js/global.js?v=10.09"></script>
<script charset="utf-8" src="js/bootstrap.min.js?v=10.09"></script>
<script charset="utf-8" src="js/template.js?v=10.09"></script>
<script charset="utf-8" src="js/register.js?v=10.09"></script>


<!-- fixes the bug Bootstrap 3 Modals and the iOS Virtual Keyboard -->
<script charset="utf-8">
$(document).ready(function(){
//iOS check...ugly but necessary
if( navigator.userAgent.match(/iPhone|iPad|iPod/i) ) {

    $('.modal').on('show.bs.modal', function() {

        // Position modal absolute and bump it down to the scrollPosition
        $(this)
            .css({
                position: 'absolute',
                marginTop: $(window).scrollTop() + 'px',
                bottom: 'auto'
            });

        // Position backdrop absolute and make it span the entire page
        //
        // Also dirty, but we need to tap into the backdrop after Boostrap 
        // positions it but before transitions finish.
        //
        setTimeout( function() {
            $('.modal-backdrop').css({
                position: 'absolute', 
                top: 0, 
                left: 0,
                width: '100%',
                height: Math.max(
                    document.body.scrollHeight, document.documentElement.scrollHeight,
                    document.body.offsetHeight, document.documentElement.offsetHeight,
                    document.body.clientHeight, document.documentElement.clientHeight
                ) + 'px'
            });
        }, 0);

    });

}
});
</script>



</head>

<body style="background-color:#fff">

<form id="form" name="form" class="form-horizontal" role="form" action="/register" method="post"><input type="hidden" value="" name="parentUserName" id="parentUserName">
<div class="maincontainer">
	<div class="container itemdetail mini-innner">
	    <div class="row">
	      <header class="header" style="height:44px;">
	        <div class="fix_nav">
	            <div style="max-width:768px;margin:0 auto;background:#000000;position: relative;">
	                <a class="nav-left back-icon" href="pages/Login/userLogin.jsp">返回</a>
	                <div class="tit">会员注册</div>
	            </div>
	        </div>
	    </header>
	    </div>
	    <div class="row mt20"></div>
	    <div class="row">
	        <div class="col-md-12">
	              <div class="form-group">
	                <label for="name" class="col-xs-3 control-label p0">账号：</label>
	                <div class="col-sm-7 col-xs-8">
	                  <input type="text" name="username" maxlength="20" class="form-control" id="username" placeholder="请输入账号">
	                </div>
	              </div>
	              <div class="form-group">
	                <label for="phone" class="col-xs-3 control-label p0">手机：</label>
	                <div class="col-sm-7 col-xs-8">
	                  <input type="text" name="mobile" maxlength="11" class="form-control" id="mobile" placeholder="请输入您的手机号码">
	                </div>
	              </div>
	              <div class="form-group">
	                <label for="phone" class="col-xs-3 control-label p0">密码：</label>
	                <div class="col-sm-7 col-xs-8">
	                  <input type="password" name="password" class="form-control" id="password" placeholder="请输入您的登录密码" autocomplete="off">
	                </div>
	              </div>
	              <div class="form-group">
	                <label for="phone" class="col-xs-3 control-label p0">重复密码：</label>
	                <div class="col-sm-7 col-xs-8">
	                  <input type="password" name="repassword" class="form-control" id="repassword" placeholder="请再次输入您的登录密码" autocomplete="off">
	                </div>
	              </div>
	              <!-- <div class="form-group">
	                <input type="hidden" value="-1" name="sex" id="sex">
	                <label for="sex" class="col-xs-offset-1 col-xs-2 control-label p0">性别：</label>
	                <div class="col-sm-2 col-xs-3 pr0">
	                    <label class="qb_mr10">
	                        <i class="qb_icon icon_checkbox" id="gradenameboy"></i>男
	                    </label>
	                </div>
	                <div class="col-sm-2 col-xs-3 pr0">
	                    <label class="qb_mr10">
	                        <i class="qb_icon icon_checkbox" id="gradenamegirl"></i>女
	                    </label>
	                </div>
	              </div> -->
	             <!--  <div class="form-group">
	                <label for="code" class="col-xs-offset-1 col-xs-2 control-label p0">图形验证码：</label>
	                <div class="col-sm-7 col-xs-9">
	                  <input type="text" name="randNum" class="form-control" id="randNum" placeholder="请输入图形验证码" style="width:32%;float:left;">
	                 <img id="randImage" name="randImage" onclick="javascript:changeRandImg('')" src="/validCoder.random?v=10.09" width="95" height="38" style="vertical-align: middle;float:left;margin-left:10px;" />
	                </div>
	              </div> -->
	              
	             <div class="form-group">
	                <label for="code" class="col-xs-3 control-label p0">验证码：</label>
	                <div class="col-sm-4 col-xs-4 pr0">
	                  <input type="text" name="mobile_code" class="form-control" id="mobile_code" placeholder="请输入手机验证码">
	                  <input type="text" name="sms_id" class="hide" id="sms_id" value="">
	                </div>
	                <div class="col-sm-3 col-xs-5">
	                  <input type="button" class="form-control btn btn-primary get_mobile_code" value="获取手机验证码" style="padding:0px;">
	                </div>
	              </div>
				<div class="form-group">
					<label class="checkbox col-xs-10 control-label p0">
					<input id="readagreebtn"
						name="readagreebtn" type="checkbox"/>同意<a class="red" href="pages/agreement/regAgreement.jsp">乐汇百材用户注册协议、用户隐私政策</a>
					</label>
				</div>
	              <div class="form-group">
	               <div class="col-xs-11 mt10">
	              	<button type="button" class="btn btn-info btn-block"
						onclick="userReg();">立刻注册</button>
						</div>
	              </div>
	        </div>
	    </div>
	</div>
</div>
<div>
</div></form>
<script type="text/javascript">

</script>
</body>
</html>

