
var basepath=null; /*根目录*/
var goodsdata = null;
$(function(){
	 setAllDomain();
	 getGoodsInfo();
	 getShopInfo();
	 getGoodsType();
	 getGoodsPicList();
});

function strToJson(str){ 
	var json = eval('(' + str + ')'); 
	return json; 
	} 

var setAllDomain = function(){
	basepath=getRootPath();	
	goodsdata=decodeURI(GetQueryString("data"));
	//alert(goodsdata);
	goodsdata = strToJson(goodsdata);
	
}

$(function(){
	
	var e = $(".minus")
	, c = $(".plus")
	, d = $("#buyNum");
	e.click(function(){
	  parseInt($("#buyNum").attr("max")),
	  _buyinput = parseInt($("#buyNum").val()),
	  1 >= _buyinput || d.val(_buyinput - 1),
	  $(".moreby").hide()
	});
	
    c.click(function(){
    	var a = parseInt($("#buyNum").attr("max"));
    	var b = parseInt($("#buyNum").val());
    	b >= a ? (d.val(a)) : d.val(b + 1);
	});
    
    $("#buynow_f,#buynow").click(function() {
    	alert("抱歉，预览不能购买。");
    	return;
        var nums=$('#buyNum').attr('max');
        var num=$('#buyNum').val();
        if(nums - num <0){
        	alert("抱歉，购买数量不能大于库存数。");
//            APP.tips("warn", "抱歉，购买数量不能大于库存数。", 2e3);  
            return;
        }
        buy();
      })
});

var buy=function(){
	var num=$('#buyNum').val();
	var typeid = $('#goodstype').val();
	var typenm = $("#goodstype").data("type");
	var goods_id =GetQueryString("goods_id");
	window.location = basepath+"pages/Order/orderInfo.jsp?goods_id="+goods_id+"&&type_id="+typeid+"&&type_nm="+typenm+"&&buynum="+num;
	
}

var getGoodsInfo = function(){
    var goodsNm = goodsdata.spuName;	
    var goodsCont = goodsdata.detailDesc;
	var picurl=goodsdata.filmPhotos[0].filePath;
	var price = goodsdata.skuList[0].skuPriceYuan;
	$("#goodsname").html('<h1>'+goodsNm+'</h1>');
	$("#lhbc-price").html('￥'+price);
	$("#preview").html('<span class="jqzoom"><img jqimg="'+picurl+'" src="'+picurl+'" /></span>');
	$("#goods-content").html(goodsCont);
	
	$(".jqzoom").jqueryzoom({xzoom:350,yzoom:410});
	
}

var getGoodsType = function(){
	var len = goodsdata.skuList.length;
	var typelist ='';
	typelist+='<div class="dt">型 号：</div>';
	typelist+='<div class="dd">';
	for(var i=0;i<len;i++)
	{
		var typeId = goodsdata.skuList[i].skuStandard;
		var typeNm = goodsdata.skuList[i].specification;
		var store =goodsdata.skuList[i].stockNum;
		var price = goodsdata.skuList[i].skuPriceYuan;
		if(i==0)
		{
			typelist+='<div class="item selected">';
		}
		else
		{
			typelist+='<div class="item">';
		}
		typelist+='<b></b><a href="javascript:;" data-typeid="'+typeId+'" data-text="'+typeNm+'" data-store="'+store+'" data-price="'+price+'"><i>'+typeNm+'</i></a>';
		typelist+='</div>';
	}
	typelist+='</div>';
	$("#choose-type").append(typelist);
	
	var typeId = goodsdata.skuList[0].skuStandard;
	var typeNm = goodsdata.skuList[0].specification;
	var store =goodsdata.skuList[0].stockNum;
	var price = goodsdata.skuList[0].skuPriceYuan;
	
	 $("#lhbc-price").html('￥'+price);
	 $("#store").html('库存<em>'+store+'</em>件'); 
	 $('#buyNum').attr('max',store);
	 $('#buyNum').val('1');
	 $('#goodstype').val(typeId+'');
	
	$(".p-choose-wrap .item a").click(function(){
		$(".item").removeClass(" selected");
		 var e = $(this),t = e.parent();
		 t.addClass(" selected");
		 var price =  $(this).data("price");
		 var store = $(this).data("store");
		 var typeid = $(this).data("typeid");
		 var typenm= $(this).data("text");
//		 alert(type);
		 $("#lhbc-price").html(price);
		 $("#store").html('库存<em>'+store+'</em>件'); 
//		 $("#buyNum").max(store);
		 $('#buyNum').attr('max',store);
		 $('#buyNum').val('1');
		 $('#goodstype').val(typeid+'');
		 $('#goodstype').attr('data-type',typenm);;
	});
}

var getGoodsPicList = function(){
	var len = goodsdata.filmPhotos.length;
	var piclist ='';
	piclist+='<ul>';
	var picurl='';
	for(var i=0;i<len;i++)
	{
	    picurl=goodsdata.filmPhotos[i].filePath;
		piclist+='<li><img alt="" bimg="'+picurl+'" src="'+picurl+'" onmousemove="preview(this);"></li>';
	}
	piclist+='</ul>';

    $("#preview_items").html(piclist);
}

var getShopInfo = function(){
	var key ; //关键词
	//alert(window.location.href);
	key=GetQueryString("shop_id");
	var param = {shopId:key};
	//alert(JSON.stringify(param));
    $.post(basepath+'Shop/GetShopInfo.action',param,function(data){
//	alert(JSON.stringify(data));
	if(data.rspCode=="000002"||data.rspCode=="000001"){
	}else{
		logo = basepath+data.objs[0].logourl;
		shopname=data.objs[0].shopNm;
		tel=data.objs[0].shopTel;
		shopurl = basepath+'pages/Shop/shopInfo.jsp?shop_id='+data.objs[0].shopId;
		$("#shoplogo").html('<a href="'+shopurl+'" target="_blank"> <img src="'+logo+'" title="'+shopname+'"></a>');
		$("#shopname").html('<a class="name" href="'+shopurl+'" target="_blank"> '+shopname+'</a>');
		$("#shoptel").html('<i class="concat-ico"></i>'+tel);
		$("#shopinfo").html('<span><a href="'+shopurl+'" target="_blank" class="btn-gray btn-shop-access" ><span>进店逛逛</span></a></span>');
	}
    },"json");
}
