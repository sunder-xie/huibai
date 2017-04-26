var basepath=null; /*根目录*/
var addrId ='';
var currGoodsId ='';
var currShopId ='';
var currSkuId = '';
var currSkuNm = '';
var currBuyNum = 0;
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
	currGoodsId = getQueryStringByName('GoodsId');
	currShopId = getQueryStringByName('ShopId');
	currSkuId = getQueryStringByName('SkuId');
	currSkuNm = getQueryStringByName('SkuNm');
	currBuyNum = parseInt(getQueryStringByName('BuyNum'))
	addrId = getQueryStringByName('addrId');
}

function sendData(){
	$('#ajax_loading').show();
	getGoodsInfo();
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
function getGoodsInfo(){
	
	var GoodsList='';
	var param = {
		 	'goodsId':currGoodsId
 	};
	//alert(JSON.stringify(param));
	$.post('Goods/GetGoodsShortInfo.action',param,function(data){
		//alert(JSON.stringify(data));
			if(data.rspCode=="000000"){
				var len = data.objs.length;
				$("#order").html(""); 
				for(var j=0;j<len;j++){
					goods = data.objs[j];
					genGoodsInfo(goods);
			    }
				calculateTotal();
			}else if(data.rspCode=="100001"){
				window.location = "pages/Login/userLogin.jsp";
			}else{
			}
		},"json");

}


var genGoodsInfo = function(goodsInfo){
	
	var goodsid,goodsnm,amount,shopid,imgurl,typeid,typenm,buynum,goodsurl;
	goodsid = goodsInfo.goodsId;
	goodsnm = goodsInfo.goodsNm;
	amount  = AmtToDecimal2(goodsInfo.amount);
	shopid  = goodsInfo.shopId;
	shopnm  = goodsInfo.shopNm;
	imgurl  = goodsInfo.mainPicUrl;
	typeid =  currSkuId;
	typenm =  currSkuNm;
	buynum =  currBuyNum;
	
	/*首先构建商家信息*/
	var empty = $('#shopInfo').val();
	$('#order').append(empty.template(shopid,shopnm));
	
	goodsurl = basepath+'pages/Goods/goodsInfo.jsp?goods_id='+goodsid+'&shop_id='+shopid;	
	var empty = $('#goodsInfo').val();
	$('#'+shopid+' li').eq(0).after(empty.template(goodsid,goodsurl,imgurl,goodsurl,goodsnm,typenm,buynum,amount));
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
	
	var shopNm = $('#'+currShopId+' li').eq(0).html();
	var goodsNm =  $('#'+currGoodsId).find("p[class='p-title']").html();
	var price =  $('#'+currGoodsId).find("em[class='price']").html().substring(1);
	var addrTel = $('#addr-tel').html();
	var addrPerson = $('#addr-person').html();
	var address = $('#addr-cont').html();
	var totalAmt = Decimal2ToAmt($('#totalPrice').html())+'';
	var BuyMsg = $('#BuyMsg').val();
	if(BuyMsg=='')
	{	
		BuyMsg='无';
	}
	var param = {
		 	'ShopId':currShopId,
		 	'ShopNm':shopNm,
		 	'GoodsId':currGoodsId,
		 	'GoodsNm':goodsNm,
		 	'TypeId':currSkuId,
		 	'TypeNm':currSkuNm,
		 	'Price':Decimal2ToAmt(price),
		 	'BuyNum':Number(currBuyNum),
		 	'Person':addrPerson,
		 	'Mobile':addrTel,
		 	'Address':address,
		 	'YfAmt':'0',
		 	'TotalNum':Number(currBuyNum),
		 	'TotalAmt':totalAmt,
		 	'PayAmt':totalAmt,
		 	'SendChannel':wapChannel,
		 	'BuyMsg':BuyMsg
 	};
	$.post('Order/BuyOrderSubmit.action',param,function(data){
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