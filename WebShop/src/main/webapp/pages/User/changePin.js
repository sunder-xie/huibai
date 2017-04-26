var basepath=null; /*根目录*/
var user_id = null ;/*用户编号*/

function queryUserInfo() {
	var url = basepath+"user/queryUserInfo.action";
	$.post(url,function(data){
//		alert(JSON.stringify(data));
		$("#userId").val(data.objs.id);
	},"json");
}

$(function(){
    setAllDomain();
    getUserMenu(basepath,user_id);
    queryUserInfo();
});

var setAllDomain = function(){
	basepath=getRootPath();	
	user_id =GetQueryString("user_id");
}

function showInfos(str){
	$("#common_errors").html(str);
	$("#common_errors").slideDown();
	setTimeout(hiddenUserRegTips,3000);
}
function hiddenUserRegTips(){
	$("#common_errors").slideUp();
}

$(".btn-r").bind('click',function(e){
	var $this = $(this);
	var oldpwd = $("#oldpwd").val();
	var newpwd = $("#newpwd").val();
	var newpwd1 =$("#newpwd1").val();
	
	if(oldpwd=='')
	{	showInfos("请输入旧密码！");
		$("#oldpwd").focus;
		return;
	}
	
	if(newpwd=='')
	{	showInfos("请输入新密码！");
		$("#newpwd").focus;
		return;
	}
	
	if(newpwd1=='')
	{	showInfos("请再次输入新密码！");
		$("#newpwd1").focus;
		return;
	}
	
	if(newpwd.length<6 ||newpwd1.length<6 )
	{
		showInfos("密码最小长度为6位！");
		$("#newpwd1").focus;
		return;
	}
	if(newpwd!=newpwd1)
	{
		showInfos("两次输入密码不一致！");
		$("#newpwd").val('');
		$("#newpwd1").val('');
		$("#newpwd").focus;
		return;
	}
	
	var userId= $("#userId").val();
	var url = basepath+"user/updateUserPwd.action";
	var param={"userId":userId,"oldpwd":oldpwd,"newpwd":newpwd};
	$.post(url,param,function(data){
		if("000000"==data.rspCode) {
			$("#oldpwd").val('');
			$("#newpwd").val('');
			$("#newpwd1").val('');
			alert("密码修改成功啦");
		} else {
			alert(data.rspMsg);
		}
	},"json");
});


$(".btn-g").bind('click',function(e){
	window.location = basepath +"pages/User/userCenter.jsp";
});
