var basepath='';
var prodType ;
var currProdId = '';
var currShopId = '';
var currTypeId='';
var currTypeNm ='';
var allSelected = false;


var contextPath = '';
var prodName= '艾吉贝2015新款多层收纳真皮单肩斜挎包女包头层牛皮斜跨小包包女';
var skuDtoList = eval('[{"amountDetail":{"cash":179,"num":1,"price":162,"promotionPrice":159,"totalAmount":145},"name":"艾吉贝2015新款多层收纳真皮单肩斜挎包女包头层牛皮斜跨小包包女","price":179,"properties":"208:636","skuId":1358,"status":1},{"amountDetail":{"cash":179,"num":1,"price":179,"promotionPrice":179,"totalAmount":179},"name":"艾吉贝2015新款多层收纳真皮单肩斜挎包女包头层牛皮斜跨小包包女","price":179,"properties":"208:661","skuId":1359,"status":1},{"amountDetail":{"cash":179,"num":1,"price":179,"promotionPrice":179,"totalAmount":179},"name":"艾吉贝2015新款多层收纳真皮单肩斜挎包女包头层牛皮斜跨小包包女","price":179,"properties":"208:635","skuId":1360,"status":1}]');
var propValueImgList = eval('[{"imgList":["img/d15bbf94-615d-4b11-9ed8-cb9e2365f12b.jpg","img/f77cb899-e3a5-4ecd-a5dc-af5e2037935f.jpg","img/30259b99-d6ce-44a8-acb8-d6a64278bc88.jpg","img/d2cd16e6-71f0-4c42-b57e-30e417e8a28f.jpg","img/2c06d677-b2ac-459e-8dd0-1c16437333fe.jpg"],"valueId":635},{"imgList":["img/ed971163-f1bf-45e8-b63a-50cf514df3e1.jpg","img/c8117d09-63bc-4e96-adce-89dc7d2017a3.jpg","img/30259b99-d6ce-44a8-acb8-d6a64278bc88.jpg","img/d2cd16e6-71f0-4c42-b57e-30e417e8a28f.jpg","img/01de5ef6-3763-4cfe-bda8-c412266e14c7.jpg"],"valueId":661},{"imgList":["img/53698282-4ff7-4daa-bb4c-4bcaa14b00fc.jpg","img/d2cd16e6-71f0-4c42-b57e-30e417e8a28f.jpg","img/78743cc9-5d29-4289-b0a1-0d5df79e63c7.jpg","img/1c9cc5cf-4ef5-4474-b4ae-7b2f1efa88f0.jpg","img/01de5ef6-3763-4cfe-bda8-c412266e14c7.jpg"],"valueId":636}]');

var prodLessMsg = '商品缺货';
var failedOwnerMsg = '您是商品主人, 不能购买此商品。';
var failedBasketMaxMsg = '已达到购物车最大数量, 不能购买此商品。';
var failedBasketErrorMsg = '购物车错误, 不能购买此商品。';
var photoPath = "";
var distUserName = '';

$(function(){
	
	setAllDomain();
	getGoodsInfo();
	getShopInfo();
	getGoodsType();
	getGoodsPicList();
	 
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
	
	 $("#sousou").click(function(){
		   $(".order_top_count").show();
	   });
	   
	   $("#nav-left_ll").click(function(){
		   $(".order_top_count").hide();
	   });
	   
	// 购买数量减少
	$('.details_con .minus,.cart_count .minus').click(function(){
		var _index=$(this).parent().parent().index()-1;
		var _count=$(this).parent().find('.count');
		var _val=_count.val();
		if(_val>1){
			_count.val(_val-1);
			$('.details_con .selected span').eq(_index).text(_val-1);
			
		}
		if(_val<=2){
			$(this).addClass('disabled');
		}
		
	});

	// 购买数量添加
	$('.details_con .add,.cart_count .add').click(function(){
		var _index=$(this).parent().parent().index()-1;
		var _count=$(this).parent().find('.count');
		var _val=_count.val();
		$(this).parent().find('.minus').removeClass('disabled');
		var buyNum = _val-0+1;
		
		var aa=$("#choose_0 .check").data('typeid');
		
		var len = prodType.length;
		for(i=0;i<len;i++)
		{
			if(prodType[i].typeId == aa)
			{
				var store=prodType[i].store;
				if(buyNum>store)
				{
					floatNotify.simple("超过最大数量");
					return;
				}
			}
		}
		_count.val(buyNum);
		
		//$('.details_con .selected span').eq(_index).text(_val-0+1);
		
	});

//	//详情属性选择
//	$('.details_con ul li dd').click(function(e) {
//		clickChoose(this);
//	});
	
//	//处理默认选中的
//	$('.details_con ul li dd[class="check"]').each(function(){
//		clickChoose(this);
//	});
});


var setAllDomain = function(){
	basepath='';	
	currProdId=GetQueryString("goods_id");
	currShopId=GetQueryString("shop_id");
	if(isWeiXinBrowse())
	{
		InitHeader();
	}
}

var InitHeader =function(){
	$('.header').hide();
}

var getGoodsInfo = function(){
	
	var param = {
		goodsId : currProdId
	};
//	alert(JSON.stringify(param));
	var url = basepath+'Goods/GetGoodsInfo.action';
    $.post(url,param,function(data){
	//alert(JSON.stringify(data));
	if(data.rspCode=="000000"){
		var prodName = data.objs.goodsNm;
		var price = data.objs.amount;
		var shop_id = data.objs.shopId;
		var cash=Number(price)/100;
		var oldcash = cash;
		
		$("#prodName").html(prodName);
		$("#oldProdCash").html(oldcash.toFixed(2));
		$("#prodCash").html(cash.toFixed(2));
		
//		//picurl=data.objs[0].mainPicUrl;
//		$("#goodsname").html('<h1>'+data.objs.goodsNm+'</h1>'+'<h2>'+data.objs.special+'</h2>');
//		//$("#lhbc-price").html('￥'+data.objs[0].amount);
//		//$("#preview").html('<span class="jqzoom"><img jqimg="'+picurl+'" src="'+picurl+'" /></span>');
//		$("#goods-content").html(data.objs.content);
		
		var str = '<div class="prop-area" style="min-height:300px;overflow: hidden;">';
		str+=	data.objs.content;
		str+='</div>';
		var strCounts ='';
		strCounts +='<li >图文详情</li>';
//		strCounts +='<li >参数</li>';
//		strCounts +='<li >评价</li>';
		$("#goodsContent .bd ul").eq(0).html(str);
		$("#goodsContent .hd ul").html(strCounts);
		
		var scrollTop = 0;
		TouchSlide({
			slideCell:"#goodsContent",
			startFun:function(i,c){
				var prodId = $("#prodId").val();
				if(i==1){//规格参数
					var th = jQuery("#goodsContent .bd ul").eq(i);
					if(!th.hasClass('hadGoodsContent')){				
						queryParameter(th,prodId);
					}

					if($(window).scrollTop() > scrollTop){
						$(window).scrollTop(scrollTop);
					}
						
				}else if(i==2){//评价
					var th = jQuery("#goodsContent .bd ul").eq(i);

					if(!th.hasClass('hadConments')){
						queryProdComment(th,prodId);
					}

					if($(window).scrollTop() > scrollTop){
						$(window).scrollTop(scrollTop);
					}
				}else{
					if(scrollTop == 0){
						$(window).scrollTop(scrollTop);
						var hd_fav = $('.hd_fav');
						var position = hd_fav.position();
						
						scrollTop = position.top;
					}
				}
			},
		});
		
		//getShopInfo(shop_id);
		
	}else{
		
	}
    },"json");
}

var getShopInfo = function(){
	
	var param = {
			shopId:currShopId
	};
//	alert(JSON.stringify(param));
    $.post(basepath+'Shop/GetShopInfo.action',param,function(data){
//	alert(JSON.stringify(data));
	if(data.rspCode=="000000"){
	
		var shopid=data.objs[0].shopId;
		var shopnm =data.objs[0].shopNm;
		var addr=data.objs[0].address;
		var sales = data.objs[0].sales;
		var logourl =data.objs[0].logourl;
		var totalscore = data.objs[0].totalscore;
		var shopscore = data.objs[0].shopscore;
		var serverscore = data.objs[0].serverscore;
		var expresscore = data.objs[0].expresscore;
		var shopsign = data.objs[0].shopsign;
		var server = data.objs[0].server;
		var shoptel = data.objs[0].shopTel;
		var shopurl = basepath+'pages/Shop/shopInfo.jsp?shop_id='+shopid;	
		
		var shoplogo = '<a href="'+shopurl+'"><img src="'+logourl+'" > </a>';
		
		var shopNm= '<a href="'+shopurl+'">'+shopnm+'</a>';
		
		$("#shop-logo").html(shoplogo);
		$("#shopName").html(shopNm);
		$("#shopSale").append(sales);
	}
	
},"json");
}

var getGoodsType = function(){
	
	var param = {goodsId:currProdId};
//	alert(JSON.stringify(param));
    $.post(basepath+'GoodsType/GetGoodsTypeInfo.action',param,function(data){
//	alert(JSON.stringify(data));
    if(data.rspCode=="000000"){
    	var len = data.objs.length;
		var typelist ='';
		var typeNm='';
		
		typelist+='<label id="propName" propname="颜色">型号：</label>';
		typelist+='<dl>';
		
		prodType = data.objs;
		for(var i=0;i<len;i++)
		{
			typeNm =data.objs[i].typeNm;
			typeid=data.objs[i].typeId;
			typelist+='<dd data-typeid="'+typeid+'" data-typenm="'+typeNm+'">'+typeNm+'<span></span></dd>';
		}
		typelist+='</dl>';
		$("#choose_0").append(typelist);
		
		//属性选择
		$('.details_con ul li dd').click(function(e) {
			//clickChoose(this);
			clickChooseType(this);
		});
	}
    },"json");
}

var getGoodsPicList = function(){
	
	var param = {
			goodsId:currProdId
	};
//	alert(JSON.stringify(param));
	var url = basepath+'Goods/GetGoodsPicInfo.action';
    $.post(url,param,function(data){
//	alert(JSON.stringify(data));
	if(data.rspCode=="000000"){
		var len = data.objs.length;
		var picurl='';
		var str = "";
		var strCounts = "";
		for(var i=0;i<len;i++)
		{
		    picurl=data.objs[i].url;
		    str+= '<li >';
			str+= '<a><img src="'+picurl+'"></a>';
			str+= '</li>';
			  
			strCounts+= '<li></li>';
		}
	    
		  $("#slide .bd ul").html(str);
		  $("#slide .hd ul").html(strCounts);
		  
		//插件：图片轮播
		 TouchSlide({
		  	slideCell:"#slide",
		  	titCell:".hd ul", //开启自动分页 autoPage:true ，此时设置 titCell 为导航元素包裹层
		  	mainCell:".bd ul",
		  	effect:"left",
		  	autoPlay:false,//自动播放
		  	autoPage:true, //自动分页
		  	switchLoad:"_src" //切换加载，真实图片路径为"_src"
		  });
	}
    },"json");
}

//获取属性值图片
function getPropValImgs(valId){
	 for(var i=0;i<propValueImgList.length;i++){
		  if(propValueImgList[i].valueId==valId){
			  var imgList = propValueImgList[i].imgList;
			  var str = "";
			  var strCounts = "";
			  for(var j=0;j<imgList.length;j++){

				  str+= '<li style="display: table-cell; vertical-align: middle; max-width: 768px;">';
				  str+= '<a href="#"><img style="max-width:100vw;max-height:80vw;margin:auto;" src="'+photoPath+imgList[j]+'"></a>';
				  str+= '</li>';
				  
				  strCounts+= '<li></li>';
			  }
			  
			  $("#slide .tempWrap ul").html(str);
			  $("#slide .hd ul").html(strCounts);
			  
			//插件：图片轮播
			 TouchSlide({
			  	slideCell:"#slide",
			  	titCell:".hd ul", //开启自动分页 autoPage:true ，此时设置 titCell 为导航元素包裹层
			  	mainCell:".bd ul",
			  	effect:"left",
			  	autoPlay:false,//自动播放
			  	autoPage:true, //自动分页
			  	switchLoad:"_src" //切换加载，真实图片路径为"_src"
			  });

			  break;
		  }
	  }
}

//选中属性
function clickChoose(object){
	//---------------------------------------------------------------------- 输出语句
	//console.debug("clickChoose 被调用到。");
	
	if (!$(object).hasClass('attr_sold_out')) {
		$(object).addClass('check').siblings().removeClass('check');
	}
	
	var chooseCount = $(object).parents("li").attr("index");
	
    getSku($(object).attr("key"),chooseCount);
    
    //getPropValImgs($(object).attr("valId")); //获取属性图片
}

function clickChooseType(object){
	//---------------------------------------------------------------------- 输出语句
	//console.debug("clickChoose 被调用到。");
	
	if (!$(object).hasClass('attr_sold_out')) {
		$(object).addClass('check').siblings().removeClass('check');
	}
	
	var chooseCount = $(object).parents("li").attr("index");
	
	var aa=$(object).data("typeid");
	var len = prodType.length;
	for(i=0;i<len;i++)
	{
		if(prodType[i].typeId == aa)
		{
			var cash=Number(prodType[i].price)/100;
			$("#prodCash").html(cash.toFixed(2));
			allSelected=true;
			currTypeId = prodType[i].typeId;
			currTypeNm = prodType[i].typeNm;
			break;
		}
	}
	
}


function getSelectedSkus(propIndex){
	var selectedLiList = [];
	  var selIndex = 0;
	  for(var h=0;h<=propIndex;h++){
		  if($("#choose_"+h+" .check").length!=0){
			  selectedLiList[selIndex]=$("#choose_"+h+" .check").get(0);
			  selIndex++;
		  }
	  }
	  
	  var index = 0;
	  var newSkus = [];
	  for(var i=0;i<skuDtoList.length;i++){
		  var has = true;
		  for(var j=0;j<selectedLiList.length;j++){
			  var kv = $(selectedLiList[j]).attr("key");
			  if(skuDtoList[i].properties.indexOf(kv)<0){
				  has = false;
				  break;
			  }
		  }
		  if(has){
			  newSkus[index]=skuDtoList[i];
			  index++;
		  }
	  }
	  return newSkus;
}

//获取sku
function getSku(kv,chooseIndex){
	//---------------------------------------------------------------------- 输出语句
	//console.debug("getsku 被调用到。kv:"+kv+"; chooseIndex:"+chooseIndex);
	
	propIndex = Number(chooseIndex);
	
	  var id = Number(propIndex);
	  while($("#choose_"+id).length!=0){
		  var aList = $("#choose_"+id+" dd").get();
		  for(var i=0;i<aList.length;i++){
			  var kv = $(aList[i]).attr("key");
			  var has = false;
			  var newSkus = getSelectedSkus(id-1);
			  for(var j=0;j<newSkus.length;j++){
				  if(newSkus[j].properties.indexOf(kv)>=0 && newSkus[j].status==1){
					  has = true;
					  break;
				  }
			  }
			  if(!has){
				  $(aList[i]).removeClass("check");
				  $(aList[i]).addClass("tb-out-of-stock");
			  }else{
				  $(aList[i]).removeClass("tb-out-of-stock");
			  }
		  }
		  id++;
	  }
	
	 $(".details_con ul li").removeClass("no-selected");
	
	var propLiCount = $("li[id^='choose_']").length;
	
	 if($(".check").length == propLiCount){
			var kvList = [];
			var checkList = $(".check").get();
			for(var k=0;k<checkList.length;k++){
				kvList[k]=$(checkList[k]).attr("key");
			}
			for(var i=0;i<skuDtoList.length;i++){
				var isT = true;
				for(var j=0;j<kvList.length;j++){
					if(skuDtoList[i].properties.indexOf(kvList[j])<0){
						isT = false;
						break;
					}
				}
				if(isT){
					//console.debug("选中的sku ："+ JSON.stringify(skuDtoList[i]));
					$("#currSkuId").val(skuDtoList[i].skuId);
					if(skuDtoList[i].name!=null && skuDtoList[i].name!=''){
						$("#prodName").html(skuDtoList[i].name);
					}else{
						$("#prodName").html(prodName);
					}
					
					var promotionPrice=Number(skuDtoList[i].amountDetail.promotionPrice);
					var cash=Number(skuDtoList[i].amountDetail.cash);
					if(promotionPrice<=cash){ //说明有折扣
						$("#prodCash").html(promotionPrice.toFixed(2));
					}else{
						$("#prodCash").html(cash.toFixed(2));
					}
					//$("#prodCash").html(skuDtoList[i].price.toFixed(2));
					break;
				}
			}
			allSelected=true;
		}else{
			//floatNotify.simple("请选中 属性！");
			var dlList = $("li[id^='choose_'] dl").get();
			for(var i=0;i<dlList.length;i++){
				if($(dlList[i]).find(".check").length==0){
					$(dlList[i]).parent().addClass("no-selected");
				}
			}
			allSelected = false;
		}
	  
}


//加入购物车
function addShopCart() {
	if (!allSelected) {//是否全部选中
		floatNotify.simple("请添加属性！");
		return;
	}
	var prodCount = $("#prodCount").val();//购买数量
	
	var param = {
			 	goodsId:currProdId,
			 	shopId:currShopId,
			 	typeId:currTypeId,
			 	"buyNum" : parseInt(prodCount),
			 	channel:'1'		
	 	};
	$.post('BuyCar/AddGoodsInBuyCar.action',param,function(data){
//			alert(JSON.stringify(data));
			if(data.rspCode=="000000"){
				floatNotify.simple("添加购物车成功");
			}else if(data.rspCode=="100001"){
				window.location = "pages/Login/userLogin.jsp";
			}else{
				
			}
		},"json");
}

//进入店铺
function inShop() {
	window.location = "pages/Shop/shopInfo.jsp?shop_id="+currShopId;
}
//立即购买
function buyNow(){
	if (!allSelected) {//是否全部选中
		floatNotify.simple("请添加属性！");
		return;
	}
	var prodId = currProdId;
	var prodCount = $("#prodCount").val();//购买数量
	
	var param = {
		 	'GoodsId':currProdId,
		 	'ShopId':currShopId,
		 	'SkuId':currTypeId,
		 	"BuyNum" : parseInt(prodCount),
		 	'SendChannel':wapChannel		
 	};
	
	$.post('Goods/CheckBuyGoods.action',param,function(data){
		//alert(JSON.stringify(data));
		if(data.rspCode=="000000"){
			window.location.href = contextPath+"pages/Order/confirmOrder.jsp?GoodsId="+currProdId+"&ShopId="+currShopId+"&SkuId="+currTypeId+"&SkuNm="+currTypeNm+"&BuyNum="+prodCount;
		}else if(data.rspCode=="100001"){
			window.location = "pages/Login/userLogin.jsp";
		}else{
			floatNotify.simple(data.rspMsg);
		}
	},"json");
}

/** 收藏商品 **/
function addInterest(obj){
	
	 var _this = $(obj);
	 var param = {
			 	goodsId:currProdId,
			 	channel:'1'		
	 	};
//	 alert(JSON.stringify(param));
	 if(_this.find("i").hasClass("i-fav-active"))
	 {
		 $.post('InterestGoods/DelInterestGoods.action',param,function(data){
//				alert(JSON.stringify(data));
				if(data.rspCode=="000000"){
					//更换样式
					_this.find("i").removeClass("i-fav-active");
					floatNotify.simple("取消收藏成功");
				}else if(data.rspCode=="100001"){
					window.location = "pages/Login/userLogin.jsp";
				}else{
					
				}
			},"json");
	 }
	 else{
		 $.post('InterestGoods/AddInterestGoods.action',param,function(data){
//				alert(JSON.stringify(data));
				if(data.rspCode=="000000"){
					//更换样式
					_this.find("i").addClass("i-fav-active");
					floatNotify.simple("收藏成功");
				}else if(data.rspCode=="100001"){
					window.location = "pages/Login/userLogin.jsp";
				}else{
					
				}
			},"json");
	 }
}

//获取参数页面
var paramResult;
function queryParameter(element,prodId){
	
	if(paramResult!=undefined){
		element.find('.desc-area').html(paramResult);
	}else{
		$.ajax({
			url: contextPath+"/queryDynamicParameter", 
			data: {"prodId":prodId},
			type:'post', 
			async : true, //默认为true 异步   
			error:function(data){
			},   
			success:function(data){
				paramResult=data;
				element.find('.desc-area').html(paramResult);
			}   
		});         
	}
	
	element.addClass('hadGoodsContent');
 }
 
//获取评论
function queryProdComment(element,prodId){
  var data = {
    "curPageNO": $("#prodCommentCurPageNO").val(),
	"prodId":prodId
  };
  jQuery.ajax({
	url:contextPath+"/comments",
	data: data,
	type:'post', 
	async : true, //默认为true 异步   
	error: function(jqXHR, textStatus, errorThrown) {
 		 //alert(textStatus, errorThrown);
	},
	success:function(result){
		element.html(result);
	}
  });
  element.addClass('hadGoodsContent');
}

//获取下一页评价
function next_comments(curPageNO,obj){
	var th = jQuery("#goodsContent .bd ul").eq(2);
	var page = parseInt(curPageNO)+1;
	var prodId = $("#prodId").val();
	var data = {
		    "curPageNO": page,
			"prodId":prodId
		};
	var _this = $(obj);
	jQuery.ajax({
		url:contextPath+"/comments",
		data: data,
		type:'post', 
		async : true, //默认为true 异步   
		error: function(jqXHR, textStatus, errorThrown) {
	 		 //alert(textStatus, errorThrown);
		},
		success:function(result){
			th.append(result);
			_this.remove();
		}
	  });
}