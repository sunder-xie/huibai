var basepath=null; /*根目录*/
var offset = 8;
var CarIdList='';
var shopList='start,';/*存放购物车中商家列表*/
var addrId ='';
var currShopId ='';
$(document).ready(function(){
	
	setAllDomain();
	//获取订单信息
	sendData();
	//返回顶部
	$(window).scroll(function(){
		if($(this).scrollTop()>300){
			$(".fanhui_cou").fadeIn(1500);
			
		}else{
			$(".fanhui_cou").fadeOut(1500);
			
		}
	});
	$(".fanhui_cou").click(function(){
		$("body,html").animate({scrollTop:0},200);
		return false;
	});
	
});


var setAllDomain = function(){
	basepath='';	
	CarIdList = getQueryStringByName('seqList');
	addrId = getQueryStringByName('addrId');
}

function sendData(){
	$('#ajax_loading').show();
	getBuyCarInfo();
	getAddrInfo();
	$('#ajax_loading').hide();
}

function getAddrInfo(){
	
	var url='';
	var param = {
			
	};
	if(isNull(addrId))
	{
		url = 'Address/GetDefaultAddr.action';
	}else
	{
		url = 'Address/GetAddressInfoByAddrId.action';
		param={
			'addrId':addrId
		};
	}
	$.post(url,param,function(data){
		//alert(JSON.stringify(data));
		if(data.rspCode=="000000"){
			var addr= data.objs[0];
			var address = addr.provice + addr.city + addr.zone + addr.address;
			var mobile = addr.mobile;
			var consignee = addr.consignee;
			var empty = $('#addr').val();
			$('#address').append(empty.template(mobile,consignee,address));
		}else if(data.rspCode=="100001"){
			window.location = "pages/Login/userLogin.jsp";
			
		}else if(data.rspCode==NotFoundRecord){
			$('#noAddr').show();
		}else{
			
		}
	},"json");
}
function getBuyCarInfo(){
	
	var GoodsList='';
	var param = {
		 	'CarIdList':CarIdList,
		 	'channel':wapChannel	
 	};
	//alert(JSON.stringify(param));
	$.post('BuyCar/GetBuyCarListByCarId.action',param,function(data){
	//	alert(JSON.stringify(data));
			if(data.rspCode=="000000"){
				var len = data.objs.length;
				$("#order").html(""); 
				for(var j=0;j<len;j++){
					goods = data.objs[j];
					genGoodsInfo(goods,data.objs);
			    }
				calculateTotal();
			}else if(data.rspCode=="100001"){
				window.location = "pages/Login/userLogin.jsp";
			}else{
			}
		},"json");

}


var genGoodsInfo = function(goodsInfo,data){
	
	var seqid,goodsid,goodsnm,amount,shopid,imgurl,typeid,typenm,buynum,goodsurl;
	seqid = goodsInfo.seqId;
	goodsid = goodsInfo.goodsId;
	goodsnm = goodsInfo.goodsNm;
	amount  = AmtToDecimal2(goodsInfo.amount);
	shopid  = goodsInfo.shopId;
	shopnm  = goodsInfo.shopNm;
	imgurl  = goodsInfo.mainPicUrl;
	typeid =  goodsInfo.typeId;
	typenm =  goodsInfo.typeNm;
	buynum = goodsInfo.buyNum;
	goodsurl = basepath+'pages/Goods/goodsInfo.jsp?goods_id='+goodsid+'&shop_id='+shopid;
	
	currShopId = shopid;
	/*如果已经存在构建商家，则返回*/
	if(isContains(shopList,shopid))
	{
		return;
	}
	
	shopList+=shopid+',';
	/*首先构建商家信息*/
	var empty = $('#shopInfo').val();
	$('#order').append(empty.template(shopid,shopnm));
	
	/*构建商品信息，如果是同一家店铺，同时构建*/
	var len = data.length;
	var index =0;
	for(var i=0;i<len;i++)
	{
		var tempShopId = data[i].shopId;
		if(shopid==tempShopId)
		{
			seqid = data[i].seqId;
			goodsid = data[i].goodsId;
			goodsnm = data[i].goodsNm;
			amount  = AmtToDecimal2(data[i].amount);
			imgurl  = data[i].mainPicUrl;
			typeid =  data[i].typeId;
			typenm =  data[i].typeNm;
			buynum = data[i].buyNum;
			goodsurl = basepath+'pages/Goods/goodsInfo.jsp?goods_id='+goodsid+'&shop_id='+shopid;	
			var empty = $('#goodsInfo').val();
			$('#'+shopid+' li').eq(index).after(empty.template(seqid,goodsurl,imgurl,goodsurl,goodsnm,typenm,buynum,amount));
			index +=1;
		}
	}
}

//计算总价
function calculateTotal(){
	var allCash = 0;
	var list = $('#'+currShopId).find("li[class='list-group-item hproduct clearfix']").get();
	var allCash = 0;
	for(var i=0;i<list.length;i++){
			var cash = $(list[i]).find("em[class='price']").html().substring(1);//取单价
			var count = $(list[i]).find("span[class='gary pull-right']").html().substring(1);//取数量
			allCash += Number(cash)*Number(count);
	}
	allCash = Math.round(Number(allCash)*100)/100;
	var pos_decimal = allCash.toString().indexOf('.');
	if (pos_decimal < 0)
	{
		allCash += '.00';
	}
	$("#totalPrice").html(allCash);
}

function submitOrder(){
	
	var GoodsList='';
	var shopNm = $('#'+currShopId+' li').eq(0).html();
	var addrTel = $('#addr-tel').html();
	var addrPerson = $('#addr-person').html();
	var address = $('#addr-cont').html();
	var totalAmt = Decimal2ToAmt($('#totalPrice').html())+'';
	var param = {
		 	'CarIdList':CarIdList,
		 	'ShopId':currShopId,
		 	'ShopNm':shopNm,
		 	'Person':addrPerson,
		 	'Mobile':addrTel,
		 	'Address':address,
		 	'YfAmt':'0',
		 	'TotalAmt':totalAmt,
		 	'PayAmt':totalAmt,
		 	'SendChannel':wapChannel	
 	};
//	alert(JSON.stringify(param));
//	return;
	$.post('Order/OrderAddByCar.action',param,function(data){
		//alert(JSON.stringify(data));
			if(data.rspCode=="000000"){
				var order_id = data.objs.orderId;
				window.location = "pages/UnionPay/payCenter.jsp?order_id="+order_id;
			}else if(data.rspCode=="100001"){
				window.location = "pages/Login/userLogin.jsp";
			}else{
				floatNotify.simple("系统异常");
			}
		},"json");
}

function abstractForm(URL, shopCartIds){
	   var temp = document.createElement("form");        
	   temp.action = URL;        
	   temp.method = "post";        
	   temp.style.display = "none";        
	   var opt = document.createElement("textarea");        
	   opt.name = 'shopCartItems';        
	   opt.value = shopCartIds;        
	   temp.appendChild(opt);        
	   document.body.appendChild(temp);        
	   temp.submit();        
	   return temp;  
}

function chooseAddr(){
	var param ='flag=1&&'+ 'seqList='+CarIdList;
	var url= 'pages/User/userAddr.jsp?'+param;
	window.location = url;
}

function addAddr(){
	var param ='flag=1&&'+ 'seqList='+CarIdList;
	var url= 'pages/User/addAddr.jsp?'+param;
	window.location = url;
}