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
<meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1,user-scalable=no;">
<%@ include file="../common/base.jsp" %>
<base href="<%=tBasePath%>"></base>
<title>授权登录中...</title>
<script type="text/javascript">
		var error = '';
		$(function(){
			var code = GetQueryString("code");
			var authType =GetQueryString("AuthType"); // :wap 授权
			var loginMode = GetQueryString("LoginMode"); /*微信登录*/
			var param = 
			{
					AuthType:authType,
					LoginMode:loginMode,
					Code:code
			};
			$.post("OAuth2/AuthLogin.action",param,function(data){
			//	alert(JSON.stringify(data));
				if(data.rspCode=="000000"){
					window.location = "pages/User/userCenter.jsp";
				}else{
					floatNotify.simple(data.rspMsg);
				}
			},"json");
		});
</script>
</head>
<body>

</body>
</html>