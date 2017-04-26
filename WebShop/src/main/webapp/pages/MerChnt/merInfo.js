var basepath=null; /*根目录*/
var user_id = null ;/*用户编号*/
var shop_id = null;

$(function(){
    setAllDomain();
    getMerMenu(basepath,shop_id,user_id);
    getShopInfo(shop_id);
});

var setAllDomain = function(){
	basepath=getRootPath();	
	user_id =$("#LoginUser").attr('loginUserId');
//	user_id =GetQueryString("user_id");
	shop_id =GetQueryString("shop_id");
}

var getShopInfo = function(shop_id){
	var param = {shopId:shop_id};
//	alert(JSON.stringify(param));
    $.post(basepath+'Shop/GetShopInfo.action',param,function(data){
//	alert(JSON.stringify(data));
	if(data.rspCode=="000002"||data.rspCode=="000001"){
	}else{
		$("#shopId").html(data.objs[0].shopId);
		$("#shopname").html(data.objs[0].shopNm);
		if(data.objs[0].type==2)
		{
			$("#shoptype").html("个人");
		}
		else if(data.objs[0].type==1)
		{
			$("#shoptype").html("企业");
		}
		else
		{
			$("#shoptype").html('未知');
		}
		$("#shopaddr").html(data.objs[0].address);
		$("#shoptel").html(data.objs[0].shopTel);
		$("#shopsales").html(data.objs[0].sales);
		$("#shopcont").html(data.objs[0].content);
	}
    },"json");
}	


//修改个人基本信息
$("#modifyBaseInfo").bind('click',function(e){
    var $this = $(this);
    $this.hide();
    $("#saveBaseInfo").show();
    $("#cancleBaseInfo").show();
    $("#shopId").html('<input id="shopIdInput" class="text" type="text" value="' + $("#shopId").html() + '">');
    $("#shopname").html('<input id="shopnameInput" class="text" type="text" value="' + $("#shopname").html() + '">');
//    $("#shoptype").html('<input id="shoptypeInput" class="text" type="email" value="' + $("#shoptype").html() + '">');
    $("#shopaddr").html('<input id="shopaddrInput" class="text" type="text" value="' + $("#shopaddr").html() + '">'); 
    $("#shoptel").html('<input id="shoptelInput" class="text" type="text" value="' + $("#shoptel").html() + '">');
    $("#shopsales").html('<input id="shopsalesInput" class="text" type="text" value="' + $("#shopsales").html() + '">');
    $("#shopcont").html('<input id="shopcontInput" class="text" type="phone" value="' + $("#shopcont").html() + '">');

});
//个人基本信息
$("#cancleBaseInfo").bind('click',function(e){
    var $this = $(this);
    $this.hide();
    $("#saveBaseInfo").hide();
    $("#modifyBaseInfo").show();
//    alert($("#shopIdInput").val());
    getShopInfo($("#shopIdInput").val());
});
//保存个人信息
$("#saveBaseInfo").bind('click',function(e){
	var $this = $(this);
	var shopname = transferStr($("#shopnameInput").val());
//	var shoptype = transferStr($("#shoptypeInput").val());
	var shopaddr = transferStr($("#shopaddrInput").val());
	var shoptel = transferStr($("#shoptelInput").val());
	var shopsales = transferStr($("#shopsalesInput").val());
	var shopcont = transferStr($("#shopcontInput").val());
	
	var url = basepath+"Shop/UpdateShopInfo.action";
	var param = {
			shopId:$("#shopIdInput").val(),
	        sales:	shopsales,
	        address:shopaddr,
	        shopTel:shoptel,
	        content:shopcont,
	        shopNm:shopname
	};
	
//	var param={"username":username,"nickname":nickname,"useremail":useremail,"usertell":usertell};
	$.post(url,param,function(data){
		if("000000"==data.rspCode) {
			$this.hide();
			$("#modifyBaseInfo").show();
		    $("#cancleBaseInfo").hide();
		    getShopInfo($("#shopIdInput").val());
		} else {
			alert(data.rspMsg);
		}
	},"json");
});

function transferStr(value) {
	return value == null ? "" : value;
}
