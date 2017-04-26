<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="yes" name="apple-touch-fullscreen">
<meta content="telephone=no" name="format-detection">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1;user-scalable=no;">
<%@ include file="../common/base.jsp" %>
<base href="<%=tBasePath%>"></base>
<link rel="stylesheet" href="css/bootstrap.css?v=01291">
<link rel="stylesheet" href="css/style.css?v=1?v=01291">
<link rel="stylesheet" href="css/member.css?v=01291">
<link rel="stylesheet" href="css/order3.css?v=01291">

<script charset="utf-8" src="js/global.js?v=01291"></script>
<script charset="utf-8" src="js/bootstrap.min.js?v=01291"></script>
<script charset="utf-8" src="js/template.js?v=01291"></script>
<title>个人资料</title>
</head>
<body>
<div class="fanhui_cou">
	<div class="fanhui_1"></div>
	<div class="fanhui_ding">顶部</div>
</div>
 <header class="header header_1">
    <div class="fix_nav">
        <div class="nav_inner">
            <a class="nav-left back-icon" href="javascript:history.back();">返回</a>
            <div class="tit">个人资料</div>
        </div>
    </div>
</header>
<div class="maincontainer">
	<div class="container" style="max-width:768px;margin:0 auto;">
		<div class="row">
			<div class="list-group mb10">
			    <div class="list-group-item">
					会员名
					<input id="username" class="text" type="text" value="" readonly="value">
				</div>
				<div class="list-group-item tip">
					头像
					<div class="member_m_hy_pic" id="userimg">
					<!-- <img class="img-circle"  src=""> -->
					</div>
				</div>
				<div class="list-group-item tip">
					昵称
					<input id="nickname" class="text" type="text" value="">
				</div>
				<!-- <div class="list-group-item tip">
					性别
					<input id="nickname" class="text" type="text" value="">
				</div> -->
			</div> 
		</div>
	</div>
</div>

<script type="text/javascript">
$(function(){
	var url = "user/queryUserInfo.action";
	$.post(url,function(data){
		//alert(JSON.stringify(data));
		if(data.rspCode=="000000"){
			$("#nickname").val(data.objs.nickName);
			$("#username").val(data.objs.username);
			$("#userimg").html('<img class="img-circle"  src="'+data.objs.portrait+'">');
		}else{
		}
		
	},"json");
});
</script>
<jsp:include page="../common/index_footerbar.jsp" />
</body>
</html>
