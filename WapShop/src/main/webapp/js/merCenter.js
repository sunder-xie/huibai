var basepath=null; /*根目录*/
var user_id = null ;/*用户编号*/
var shop_id =null;
$(function(){
    setAllDomain();
    getShop();
});
 
var setAllDomain = function(){
	basepath='';	
}


function userLogout(){
	$.post('user/Logout.action',function(data){
		if(data.rspCode=="000000"){
			window.location  = 'pages/Login/userLogin.jsp';
		}
	});
	
}

var getShop = function(){
		getShopInfoByUserId();
}

var getShopInfoByUserId = function(){
	var param = {userId:''};
//	alert(JSON.stringify(param));
    $.post(basepath+'Shop/GetShopInfoByLoginUser.action',param,function(data){
//	alert(JSON.stringify(data));
	if(data.rspCode=="000000"){
		var shoplogo=data.objs[0].logourl;
		var shopname = data.objs[0].shopNm;
		shop_id=data.objs[0].shopId;
		var shopurl = basepath+'pages/Shop/shopInfo.jsp?shop_id='+shop_id;
		$("#shopLogo").attr('src',shoplogo);
		$("#shopNm").html(shopname);
	}else{
		
		window.location = basepath+"pages/User/userCenter.jsp";
	}
    },"json");
}	

var goOrderPage = function(oraSta){
	window.location = basepath+"pages/merchnt/merOrder.jsp?ord_sta="+ oraSta +"&shop_id=" +shop_id;
}


