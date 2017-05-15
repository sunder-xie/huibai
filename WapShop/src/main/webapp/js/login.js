$(function(){
	
	if(isWeiXinBrowse())
	{
		InitHeader();
		$('#weixinLogin').show();
	}
	
	checkInputEvent();
});

var InitHeader =function(){
	$('.header').hide();
}

function checkInputEvent(){
	$("#pwd").keypress(onNormalLogonKeyPress);
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

function WeiXinLogin(){
	
	var authType ='1' ;  /*wap 授权*/
	var loginMode = '1'; /*微信登录*/
	var param = 
	{
			AuthType:authType,
			LoginMode:loginMode,
			redirect_url:'http://m.hbaicai.com/pages/auth/weixin.jsp?AuthType='+authType+'&LoginMode='+loginMode
	};
	$.post("OAuth2/GetAuthUrl.action",param,function(data){
		//alert(JSON.stringify(data));
		if(data.rspCode=="000000"){
			var url = data.objs;
			window.location = url;
		}else{
			floatNotify.simple(data.rspMsg);
		}
	},"json");
} 

function userLogin(){
	var flag =true;
	var postData={};
	
	$("#theForm").find("input").each(function(){
		var $obj=$(this);
		var message=$obj.attr("message");
		if(isNull($obj.val()) && $obj.attr("required") == "required"){
			floatNotify.simple(message+'不能为空');
			flag=false;
			return false;
		}
	})
		
	if(flag){
		//$("#theForm").submit();
		var param = getFormJson("#theForm");
		$.post("user/Login.action",param,function(data){
//			alert(JSON.stringify(data));
			if(data.rspCode=="000000"){
				window.location = "pages/User/userCenter.jsp";
			}else{
				floatNotify.simple(data.rspMsg);
			}
		},"json");
	}
}

function userReg(){
	
	window.location.href='pages/Login/userReg.jsp';
}
