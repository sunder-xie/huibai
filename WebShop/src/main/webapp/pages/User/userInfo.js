var basepath=null; /*根目录*/
var user_id = null ;/*用户编号*/

var setAllDomain = function(){
	basepath=getRootPath();	
	user_id =$("#LoginUser").attr('loginUserId');
}

$(function(){
    setAllDomain();
    getUserMenu(basepath,user_id);
    queryUserInfo();
});

function queryUserInfo() {
	var url =  basepath+"/user/queryUserInfo.action";
	$.post(url,function(data){
		$("#nickname").html(data.objs.nickName);
		$("#userName").html(data.objs.username);
		$("#useremail").html(data.objs.userEmail);
		$("#usertell").html(data.objs.userTel);
	},"json");
}

//修改个人基本信息
$("#modifyBaseInfo").bind('click',function(e){
    var $this = $(this);
    $this.hide();
    $("#saveBaseInfo").show();
    $("#cancleBaseInfo").show();
    $("#nickname").html('<input id="nicknameInput" class="text" type="text" value="' + $("#nickname").html() + '">');
    $("#useremail").html('<input id="useremailInput" class="text" type="email" value="' + $("#useremail").html() + '">');
    $("#usertell").html('<input id="usertellInput" class="text" type="phone" value="' + $("#usertell").html() + '">');
});
//个人基本信息
$("#cancleBaseInfo").bind('click',function(e){
    var $this = $(this);
    $this.hide();
    $("#saveBaseInfo").hide();
    $("#modifyBaseInfo").show();
    queryUserInfo();
});
//保存个人信息
$("#saveBaseInfo").bind('click',function(e){
	var $this = $(this);
	var username = $("#userName").html();
	var nickname = transferStr($("#nicknameInput").val());
	var useremail = transferStr($("#useremailInput").val());
	var usertell = transferStr($("#usertellInput").val());
	
	var url =  basepath+"/user/updateUserInfo.action";
	var param={"username":username,"nickname":nickname,"useremail":useremail,"usertell":usertell};
	$.post(url,param,function(data){
		if("00"==data.rspCode) {
			$this.hide();
			$("#modifyBaseInfo").show();
		    $("#cancleBaseInfo").hide();
		    queryUserInfo();
		} else {
			alert(data.rspMsg);
		}
	},"json");
});

function transferStr(value) {
	return value == null ? "" : value;
}

