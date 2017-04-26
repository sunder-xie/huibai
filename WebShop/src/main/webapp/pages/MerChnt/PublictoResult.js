var basepath=null; /*根目录*/
var user_id = null ;/*用户编号*/
var shop_id =null;

var setAllDomain = function(){
	basepath=getRootPath();	
	shop_id=GetQueryString("shop_id");
	user_id =GetQueryString("user_id");
}

function toList() {
    window.location.href = basepath + 'pages/MerChnt/SaleGoods.jsp?shop_id='+shop_id+'&user_id='+user_id;
}

function toPublish() {
    window.location.href = basepath + 'pages/MerChnt/pubGoods.jsp?shop_id='+shop_id+'&user_id='+user_id;
}

$(function() {
	setAllDomain();
    getMerMenu(basepath,shop_id,user_id);
});


