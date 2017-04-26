var basepath=null; /*根目录*/
var user_id = null ;/*用户编号*/
var shop_id = null;

$(function(){
    setAllDomain();
    //getMerMenu(basepath);
    getShop();
});
 
var setAllDomain = function(){
	basepath=getRootPath();	
	user_id =$("#LoginUser").attr('loginUserId');
	//user_id =GetQueryString("user_id");
	shop_id =GetQueryString("shop_id");
}

var getBindInfo =function(){
	var modevalue='02' ; //绑定类型：账号与店铺账号对应类型
	var param = {mode:modevalue};
  //  alert(JSON.stringify(param));
	$.post(basepath+'Bind/GetBindInfo.action',param,function(data){
//	alert(JSON.stringify(data));
	if(data.rspCode=="000000"){
//		alert(data.objs[0].keyB);
		shop_id = data.objs[0].keyB;
		getShopInfoByShopId();
	}
	else
	{
		window.location = basepath;
	}	
	},"json");
}
var getShop = function(){
    /*如果店铺编号为空，则通过user_id 获取店铺信息*/
	if(!isNull(shop_id))
	{
		getShopInfoByShopId();
	}else if(isNull(user_id))
	{
		getBindInfo();
	}
	else
	{
		getShopInfoByUserId();
	}
	
}

var getShopInfoByUserId = function(){
	var param = {userId:user_id};
//	alert(JSON.stringify(param));
    $.post(basepath+'Shop/GetShopInfoByUserId.action',param,function(data){
	//alert(JSON.stringify(data));
	if(data.rspCode=="000000"){
		var shoplogo='<img src="'+data.objs[0].logourl+'" style="height: 90px;width: 90px;">';
		var shopname = data.objs[0].shopNm;
		shop_id=data.objs[0].shopId;
		var shopurl = basepath+'pages/Shop/shopInfo.jsp?shop_id='+shop_id;
		$("#shoplogo").html(shoplogo);
		$("#shopname").html(shopname);
		var content = ' <a target="_new" href="'+shopurl+'">店铺首页</a>';
		$("#shopUrl").html(content);
		getMerMenu(basepath,shop_id,user_id);
	}else{
		window.location = basepath+"pages/Login/merRegGuide.jsp";
	}
    },"json");
}	

var getShopInfoByShopId = function(){
	var param = {shopId:shop_id};
//	alert(JSON.stringify(param));
    $.post(basepath+'Shop/GetShopInfo.action',param,function(data){
//	alert(JSON.stringify(data));
	if(data.rspCode=="000002"||data.rspCode=="000001"){
	}else{
		var shoplogo='<img src="'+basepath+data.objs[0].logourl+'" style="height: 90px;width: 90px;">';
		var shopname = data.objs[0].shopNm;
		shop_id=data.objs[0].shopId;
		var shopurl = basepath+'pages/Shop/shopInfo.jsp?shop_id='+shop_id;
		$("#shoplogo").html(shoplogo);
		$("#shopname").html(shopname);
		var content = ' <a target="_new" href="'+shopurl+'">店铺首页</a>';
		$("#shopUrl").html(content);
		getMerMenu(basepath,shop_id,user_id);
	}
    },"json");
}	
