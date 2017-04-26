var basepath=null; /*根目录*/
var user_id = null ;/*用户编号*/

var setAllDomain = function(){
	basepath=getRootPath();	
	//user_id =GetQueryString("user_id");
	user_id =$("#LoginUser").attr('loginUserId');
}

$(function(){
    setAllDomain();
    getUserMenu(basepath,user_id);
    queryCustomerInfo();
});

function queryCustomerInfo() {
	var param = {
			userId:user_id,
			bindType:"01"
		};
	var url =  basepath+"/Customer/GetRegCustomerInfo.action";
	$.post(url,param,function(data){
//		alert(JSON.stringify(data));
		if(data.rspCode=="000000"){
			$("#custId").html(data.objs[0].custId);
			$("#custNm").html(data.objs[0].custNm);
			$("#certNo").html(data.objs[0].certNo);
		}
		else{
			showTips(".ws_tips_box");
		}
	},"json");
}


function showTips(id){
    var x=$("body").width()+"px";
    var y=$("body").height()+"px";
    $(id+",.over_layer").fadeIn(500);
    $(".over_layer").css({"width":x,"height":y});
}

function hideTips(id){
	$(id+",.over_layer,#user_shadow").fadeOut(500);
}


$(".confirm").on('click', function (e) {
	hideTips(".ws_tips_box");
	$("#modifyBaseInfo").hide();
	$("#saveBaseInfo").show();
    $("#cancleBaseInfo").show();
    $("#custId").html('<input id="custIdInput" class="text" type="text" value="' + $("#custId").html() + '">');
    $("#custNm").html('<input id="custNmInput" class="text" type="text" value="' + $("#custNm").html() + '">');
    $("#certNo").html('<input id="certNoInput" class="text" type="text" value="' + $("#certNo").html() + '">');
});

//修改个人基本信息
$("#modifyBaseInfo").bind('click',function(e){
    var $this = $(this);
    $this.hide();
    $("#saveBaseInfo").show();
    $("#cancleBaseInfo").show();
    $("#custId").html('<input id="custIdInput" class="text" type="text" value="' + $("#custId").html() + '">');
    $("#custNm").html('<input id="custNmInput" class="text" type="text" value="' + $("#custNm").html() + '">');
    $("#certNo").html('<input id="certNoInput" class="text" type="text" value="' + $("#certNo").html() + '">');
});
//个人基本信息
$("#cancleBaseInfo").bind('click',function(e){
    var $this = $(this);
    $this.hide();
    $("#saveBaseInfo").hide();
    $("#modifyBaseInfo").show();
    queryCustomerInfo();
});
//保存个人信息
$("#saveBaseInfo").bind('click',function(e){
	var $this = $(this);
	var custId = transferStr($("#custIdInput").val());
	var custNm = transferStr($("#custNmInput").val());
	var certNo = transferStr($("#certNoInput").val());
	if(!isNull(custId))
	{
		var url =  basepath+"/Customer/UpdateCustomerInfo.action";
		var param={
				userId:user_id,
				"custId":custId,
				"custNm":custNm,
				"certNo":certNo,
				bindType:"01"
		};
	}else
	{
		var url =  basepath+"/Customer/SaveCustomerInfo.action";
		var param={
				userId:user_id,
				"custNm":custNm,
				"certNo":certNo,
				bindType:"01"
		};
	}
	$.post(url,param,function(data){
		if("000000"==data.rspCode) {
			$this.hide();
			$("#modifyBaseInfo").show();
		    $("#cancleBaseInfo").hide();
		    queryCustomerInfo();
		} else {
			alert(data.rspMsg);
		}
	},"json");
});

function transferStr(value) {
	return value == null ? "" : value;
}

