<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="yes" name="apple-touch-fullscreen">
<meta content="telephone=no" name="format-detection">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1;user-scalable=no;">
 <%@ include file="../common/base.jsp" %>
 <base href="<%=tBasePath%>"></base>
<title>会员登录</title>
<link rel="stylesheet" href="css/bootstrap.css?v=01291">
<link rel="stylesheet" href="css/style.css?v=1?v=01291">
<link rel="stylesheet" href="css/member.css?v=01291">
<link rel="stylesheet" href="css/order3.css?v=01291">
<script charset="utf-8" src="js/global.js?v=01291"></script>
<script charset="utf-8" src="js/bootstrap.min.js?v=01291"></script>
<script charset="utf-8" src="js/template.js?v=01291"></script>
<script charset="utf-8" src="js/randomimage.js?v=01291"></script>
<script type="text/javascript">
		var error = '';
		$(function(){
			var param = 
			{
					loginMode:'1',
					type:2,
					menuType:2,
					wechatUserId:1,
					redirect:'a'
			};
			$.post("OAuth2/auth.action",param,function(data){
//				alert(JSON.stringify(data));
				if(data.rspCode=="000000"){
					window.location = "pages/User/userhome.jsp";
				}else{
					floatNotify.simple(data.rspMsg);
				}
			},"json");
		});
		
</script>
</head>
<body class="" style="background-color:#fff">

</body>
</html>