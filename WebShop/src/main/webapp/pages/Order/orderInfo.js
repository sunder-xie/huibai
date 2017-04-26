var basepath=null; /*根目录*/
var user_id = null ;/*用户编号*/
var orderInfoUrl ={};
var startpagenum =1;
var offset =10;

$(function(){
    setAllDomain();
    getUserAddr(startpagenum,offset);
    chageadress.init();
    chageadress.updown();
    chageadress.chosetype();
    getGoodsInfo();
});
 
var setAllDomain = function(){
	basepath=getRootPath();	
	user_id =$("#LoginUser").attr('loginUserId');
	orderInfoUrl={
			userAddr : "Address/GetAddressInfo.action?userId="+user_id,
	}
}

//loading
var loading=function(){
  float('','loading');
}

//unloading
var unloading=function(){
$('.loading').hide();
$('.float').hide();
}
//浮窗
var float=function(m,clas){
    var width=$(window).width();
    var height=$(window).height();
    var width1=$('.'+clas).width();
    var height1=$('.'+clas).height();
    var h=$(document.body).height();
    var heights=0;
     var top=(height-height1)/2;
     var left=(width-width1)/2;
     $('.'+clas).css({
       'top':top+'px',
       'left':left+'px'
     });
     
     heights=height>h? height:h;
     $('.float').css({
        'height':heights+'px'
     });
    $('.'+clas).show();
}	 

$('#refreshAddr').on('click',function() {
    loading();
    getUserAddr(startpagenum,offset);
});

$(".orderadress-more").delegate("input:radio[name='fare54']","click",function(){
    var $loopitem=$(this).parent().parent();
    $loopitem.addClass('selectadress').siblings().removeClass('selectadress');
});
var getUserAddr=function(pagenumber,offsize){
	var map={
	};
	var param = {
		start:pagenumber,
		offset:offsize,			
		conditions:map
	};
		
	var url = basepath + orderInfoUrl.userAddr;
	
	$.post(url,param,function(data){
//		alert(JSON.stringify(data));
		var datatable='';
		if("000000"==data.rspCode) {
		
		var flag =0;
	    var num= data.result.length < data.offset ? data.result.length :data.offset;
	    $('.orderadress-more').empty();
//	    alert(num);
		for (var i=0;i<num;i++)
		{
			var addrId= data.result[i].addrId;
			var name = data.result[i].consignee;
			var cityId = data.result[i].city;
			var addr1='';
			if(data.result[i].zone=='0')
			{
				addr1=data.result[i].provice+data.result[i].city;
			}
			else
			{
				addr1=data.result[i].provice+data.result[i].city+data.result[i].zone;
			}
			var addr2= data.result[i].address;
			var mobile = data.result[i].mobile;
			var isMain = data.result[i].isMain;
			if(isMain=='Y')
			{
				flag=1;
			}
			if((isMain=='N'&& i==num-1 && flag==0)
					||isMain=='Y')
			{
				$("#name").html(name);
				$("#mobile").html(mobile);
				$("#address").html(addr1+addr2);
			}
		  var mod = $('.addrmod').clone();
		  mod.find('.selectadress-now').find('span:eq(0)').text(name);
		  mod.find('.selectadress-now').find('span:eq(1)').text(mobile);
		  mod.find('.selectadress-now').find('dd:eq(1)').text(addr1+addr2);
		  mod.find('input').attr('cityId',cityId);
		  mod.find('input').attr('addrId',addrId);
		  //if (pointer.isDefault == 'y') {
		  if (i==0) {
		     mod.find('>div:eq(1)').addClass('selectadress');
		     mod.find('input').attr('checked','checked');
		  }
		  $('.orderadress-more').append(mod.html());
	    }
		} else {
			$('.selectadress-now-user').empty();
			datatable+= '<dl><dd ><span>还没有添加地址，请</span><a href="../User/address.jsp" target="_blank" ">添加收货地址!</a> </dd> </dl>';
			$('.selectadress-now-user').append(datatable);
			$('#editStoreAddr').hide();
		}
		unloading();
	},"json");
	
}

var getGoodsInfo = function(){
	var key ; //关键词
	//alert(window.location.href);
	key=GetQueryString("goods_id");
	var param = {
			goodsId:key
		};
	var shopinfo ='';
	var goodpic ='';
	var goodinfo ='';
	var shopUrl = '';
	var goodUrl = '';
//	alert(JSON.stringify(param));
    $.post(basepath+'Goods/GetGoodsShortInfo.action',param,function(data){
//	alert(JSON.stringify(data));
	if(data.rspCode=="000000"){
		//shop-name
		shopId=data.objs[0].shopId;
		shopNm=data.objs[0].shopNm;
		goodsId=data.objs[0].goodsId;
		picUrl=data.objs[0].mainPicUrl;
		goodsNm=data.objs[0].goodsNm;
		
		shopUrl = basepath+'pages/Shop/shopInfo.jsp?shop_id=' +shopId; 
		goodUrl = basepath+'pages/Goods/goodsInfo.jsp?goods_id='+goodsId;
		shopinfo+='<img src="../../images/enter_icon.png" height="15" width="17">';
		shopinfo+='<a id="shopname" href="'+shopUrl+'" target="_blank">'+shopNm+'</a>'
		
		$(".shop-name").append(shopinfo);
		$("#shopinfo").attr('shopname',shopNm);
		$("#shopinfo").attr('shopid',shopId);
		
		goodpic+='<a href="'+goodUrl+'" target="_blank" name="icart1_goods_pic">';
		goodpic+='<img src="'+picUrl+'" alt=""></a>'
		$(".good-pic").append(goodpic);
        
		
		goodinfo+='<a href="'+goodUrl+'" target="_blank" class="good-title">'; 
		goodinfo+='<span>'+goodsNm+'</span>';
		goodinfo+='<span typeid=""></span>';
		goodinfo+='</a>';
        
        $(".good-info").append(goodinfo);
        $("#goodsinfo").attr('goodsname',goodsNm);
		$("#goodsinfo").attr('goodsid',goodsId);
		
		getGoodsType();
	}else{
		
	}
    },"json");
}

var getGoodsType = function(){
	var key ; //关键词
	//alert(window.location.href);
	key=GetQueryString("goods_id");
	var type=GetQueryString("type_id");
	var buynum=GetQueryString("buynum");
	var param = {
			goodsId:key,
			typeId:type
			};
	var shopinfo ='';
	var goodpic ='';
	var goodinfo ='';
	var allprice =0;
//	alert(JSON.stringify(param));
    $.post(basepath+'GoodsType/GetGoodsTypeInfo.action',param,function(data){
//	alert(JSON.stringify(data));
	if(data.rspCode=="000002"||data.rspCode=="000001"){
		
	}else{
		var price=AmtToDecimal2(data.objs[0].price);
		var typenm=data.objs[0].typeNm;
		var typenId=data.objs[0].typeId;
//		$("#goodstype").html('型号：'+typenm);
//		$(".good-title").find('span').eq(1).text(typenm);
		$(".good-title").find('span:eq(1)').attr('typeid',typenId);
		$(".good-title").find('span:eq(1)').text(typenm);
		$(".goodallprize").find('span:eq(0)').text(allprice);
//		$("#goodstype").html(typenm);
		$("#unit-price").html(price);
		$(".proinfo-num").html(buynum);
		allprice = AmtToDecimal2(data.objs[0].price*buynum);
		$(".goodallprize").find('span:eq(0)').text(allprice);
		$(".paydetail-prize").find('dd:eq(0)').text(allprice);
		$("#total").find('em:eq(0)').text(buynum);
		$("#totalPrice").find('em:eq(0)').text(allprice);
	}
    },"json");
}
var chageadress = chageadress || {};
chageadress.init = function() {
  $(".orderadress-more").hide();
  $("input[name=fare54][checked]").val();
};

chageadress.updown = function() {
  $(".moreadress").unbind().click(function() {
    $(".orderadress-more").slideToggle();
	if($(this).attr('name')==1){
      loading();
	  preservation($(this));
	  return;
	}else{
    $(this).attr('name',1);
    $('.moreadress').text('确认配送信息');
	  return;
	}
});
};

chageadress.chosetype = function() {
	  $("input:radio[name='fare54']").change(function() {
	    $(this).parent().parent().addClass('selectadress ').siblings().removeClass('selectadress');
	  });
	};
	
//选中地址，后续根据城市从后台获取邮费信息，目前不用获取邮费信息
var preservation=function(_this){
//	var cartNumber=$('#shops').attr('name');
//	var cityId=$('.selectadress').find('input').attr('cityid');
    var consigneeId=$('.selectadress').find('input').attr('addrId');
	var consigneeName=$('.selectadress').find('.selectadress-now').find('span').eq(0).text();
	var consigneeMob=$('.selectadress').find('.selectadress-now').find('span').eq(1).text();
	var consigneeAddr=$('.selectadress').find('.selectadress-now').find('dd').eq(1).text();
	unloading();
	if ($('.selectadress-now-user').find('dl').length == 0)
		$('.selectadress-now-user')
				.html(
						'<dl><dd><span id="name"></span><span id="mobile"></span></dd><dd id="address"></dd></dl>');
	var loopitem = $('.selectadress div.selectadress-now');
	var name = loopitem.find('span:eq(0)').text();
	var phone = loopitem.find('span:eq(1)').text();
	var addr = loopitem.find('dd:eq(1)').text();
	$('.selectadress-now-user span:eq(0)').text(name);
	$('.selectadress-now-user span:eq(1)').text(phone);
	$('.selectadress-now-user dd:eq(1)').text(addr);
	_this.attr('name', '');
	$('.moreadress').text('切换地址');
}

function GenGoodsList(){
	var GoodsListData="";
	var str02="";
	var goodsNm = [],goodsId=[],shopId=[],shopNm=[],
    buyNum =[],goodsPrice=[],goodsTotalAmt=[],
    typeId=[],typeNm=[];
	for( var m=0;m<1;m++ ){
		shopId.push($("#shopinfo").attr('shopid'));
    	shopNm.push($("#shopinfo").attr('shopname'));
    	goodsNm.push ($("#goodsinfo").attr('goodsname'));
    	goodsId.push($("#goodsinfo").attr('goodsid'));
    	buyNum.push($(".proinfo-num").html());
        goodsPrice.push(Decimal2ToAmt($("#unit-price").html()));
        goodsTotalAmt.push(Decimal2ToAmt($(".goodallprize").find('span').eq(0).text()));
        typeId.push($(".good-title").find('span:eq(1)').attr('typeid'));
        typeNm.push($(".good-title").find('span').eq(1).text());
        str02 +=  '{"shopId":"'+ shopId[m] +'","shopNm":"'+ shopNm[m]+'","goodsNm":"'+ goodsNm[m] +'","goodsId":"'+ goodsId[m] +
        			  '","goodsPrice":"'+ goodsPrice[m] +'","buyNum":"'+ buyNum[m]+'","goodsTotalAmt":"'+ goodsTotalAmt[m]+
        			  '","typeId":"'+ typeId[m] +'","typeNm":"'+ typeNm[m]+
        			  '"},';
    	}
    
    GoodsListData = "["+ str02 +"]";
    GoodsListData = GoodsListData.substring(0,GoodsListData.length-2)+"]";
    return GoodsListData;
}

$('#creatOrder').bind('click',function(e){
    loading();         
    var 
      $selectadress = $('.selectadress-now-user'),
      consignee = $selectadress.find('span:eq(0)').text(),
      phoneNum = $selectadress.find('span:eq(1)').text(),
      address = $selectadress.find('dd:eq(1)').text()
       ;

    if (consignee == "" || phoneNum == "" || address == "") {
      alert('请先添加收货地址!');
      unloading();
      return false;
    }

    var display = $('.orderadress-more').css('display');
    if (display != 'none') {
      alert('请保存收货地址!');
      unloading();
      return;
    }
    
//    var aa = [{
//      "buyerMessage": encodeURI(text),
//      "shopId": shopId
//    }];
    
    var userId = $("#LoginUser").attr('loginUserId');
    
    var url =basepath+ "Order/OrderAdd.action?userId="+userId;
    
    var GoodsListData = "",ShopListData="",str01 ="",str02 ="";
    var shopId=[],shopNm=[],totalNum=[],goodsAmt=[],yfAmt=[],totalAmt=[],payAmt=[];
    var orderTotalAmt= "";
    var orderTotalNum= "";
    var goodsInfo ="";
    var buyerMsg =[];
    /*店铺列表*/
    for( var m=0;m<1;m++ ){
    	shopId.push($("#shopinfo").attr('shopid'));
    	shopNm.push($("#shopinfo").attr('shopname'));
    	buyerMsg.push($(".c-store-message").val());
    	totalNum.push($(".proinfo-num").html());
    	goodsAmt.push(Decimal2ToAmt($(".goodallprize").find('span').eq(0).text()));
    	yfAmt.push('0');
    	totalAmt.push(Decimal2ToAmt($(".goodallprize").find('span').eq(0).text()));
    	payAmt.push(Decimal2ToAmt($(".goodallprize").find('span').eq(0).text()));
        str01 +=  '{"shopId":"'+ shopId[m] +'","shopNm":"'+ shopNm[m]+'","totalNum":"'+ totalNum[m]+'","goodsAmt":"'+ goodsAmt[m] +'","yfAmt":"'+ yfAmt[m]+'","totalAmt":"'+ [totalAmt]
        +'","buyerMsg":"'+buyerMsg[m]+'","payAmt":"'+payAmt[m];
        str01 +=  '"},';
    }
    ShopListData = "["+ str01 +"]";
    ShopListData = ShopListData.substring(0,ShopListData.length-2)+"]";
//    alert(ShopListData);
    
    GoodsListData +=  GenGoodsList();
    
    orderTotalAmt = Decimal2ToAmt($("#totalPrice").find('em:eq(0)').text());
	var param = {
			"orderShop":ShopListData,
			"orderGoods":GoodsListData,
			"addrs":address,
			"person":consignee,
			"mobile":phoneNum,
			"OrdSta":'01',
			"paySta":'01'
			};
//	alert(JSON.stringify(param));
//	return;
	$.post(url,param,function(data){
//		alert(JSON.stringify(data));
		if("000000"==data.rspCode) {
			unloading();
			var orderId=data.objs.orderId;
			var shopNm =data.objs.shopNm;
			var payAmt =data.objs.payAmt;
			var orderDesc = $("#goodsinfo").attr('goodsname');
			window.location = basepath+"pages/UnifyPay/payCenter.jsp?orderId="+orderId+"&&shopNm="+shopNm+"&&payAmt="+payAmt+"&&orderDesc="+orderDesc;
		} else {
			 unloading();
			 alert(data.rspMsg);
		}
	},"json");
});