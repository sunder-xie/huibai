
var basepath=null; /*根目录*/

$(function(){
	 setAllDomain();
	 getGoodsInfo();
	 getShopInfo();
	 getGoodsType();
	 getGoodsPicList();
});
 
var setAllDomain = function(){
	basepath=getRootPath();	
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
	var key ; //关键词
	//alert(window.location.href);
	key=GetQueryString("goods_id");
	var param = {goodsId:key};
//	alert(JSON.stringify(param));
	var url = basepath+'Goods/GetGoodsInfo.action';
    $.post(url,param,function(data){
//	alert(JSON.stringify(data));
    
	if(data.rspCode=="000000"){
		//picurl=data.objs[0].mainPicUrl;
		$("#goodsname").html('<h1>'+data.objs.goodsNm+'</h1>'+'<h2>'+data.objs.special+'</h2>');
		//$("#lhbc-price").html('￥'+data.objs[0].amount);
		//$("#preview").html('<span class="jqzoom"><img jqimg="'+picurl+'" src="'+picurl+'" /></span>');
		$("#goods-content").html(data.objs.content);
		
		//$(".jqzoom").jqueryzoom({xzoom:350,yzoom:410});
	}else{
		
	}
    },"json");
}

var getGoodsPicList = function(){
	var key ; //关键词
	//alert(window.location.href);
	key=GetQueryString("goods_id");
	var param = {
			goodsId:key			
			};
//	alert(JSON.stringify(param));
	var url = basepath+'Goods/GetGoodsPicInfo.action';
    $.post(url,param,function(data){
//	alert(JSON.stringify(data));
	if(data.rspCode=="000000"){
		var len = data.objs.length;
		var piclist ='';
		piclist+='<ul>';
		var picurl='';
		for(var i=0;i<len;i++)
		{
		    picurl=data.objs[i].url;
			piclist+='<li><img alt="" bimg="'+picurl+'" src="'+picurl+'" onmousemove="preview(this);"></li>';
			if(data.objs[i].type=="01")
			{
				$("#preview").html('<span class="jqzoom"><img jqimg="'+picurl+'" src="'+picurl+'" /></span>');
			}
		}
		piclist+='</ul>';

	    $("#preview_items").html(piclist);
	    $(".jqzoom").jqueryzoom({xzoom:350,yzoom:410});
	}else{
		
	}
    },"json");
}

var getGoodsType = function(){
	var key ; //关键词
	//alert(window.location.href);
	key=GetQueryString("goods_id");
	var param = {goodsId:key};
//	alert(JSON.stringify(param));
    $.post(basepath+'GoodsType/GetGoodsTypeInfo.action',param,function(data){
//	alert(JSON.stringify(data));
	if(data.rspCode=="000002"||data.rspCode=="000001"){
	}else{
		
		var len = data.objs.length;
		var typelist ='';
		typelist+='<div class="dt">型 号：</div>';
		typelist+='<div class="dd">';
		for(var i=0;i<len;i++)
		{
			if(i==0)
			{
				typelist+='<div class="item selected">';
			}
			else
			{
				typelist+='<div class="item">';
			}
			typelist+='<b></b><a href="javascript:;" data-typeid="'+data.objs[i].typeId+
			'" data-text="'+data.objs[i].typeNm+'" data-store="'+data.objs[i].store+
			'" data-price="'+AmtToDecimal2(data.objs[i].price)+'"><i>'+data.objs[i].typeNm+'</i></a>';
			typelist+='</div>';
		}
		typelist+='</div>';
		$("#choose-type").append(typelist);
		
		 $("#lhbc-price").html('￥'+AmtToDecimal2(data.objs[0].price));
		 $("#store").html('库存<em>'+data.objs[0].store+'</em>件'); 
		 $('#buyNum').attr('max',data.objs[0].store);
		 $('#buyNum').val('1');
		 $('#goodstype').val(data.objs[0].typeId+'');
		
		$(".p-choose-wrap .item a").click(function(){
			$(".item").removeClass(" selected");
			 var e = $(this),t = e.parent();
			 t.addClass(" selected");
			 var price =  $(this).data("price");
			 var store = $(this).data("store");
			 var typeid = $(this).data("typeid");
			 var typenm= $(this).data("text");
//			 alert(type);
			 $("#lhbc-price").html(price);
			 $("#store").html('库存<em>'+store+'</em>件'); 
//			 $("#buyNum").max(store);
			 $('#buyNum').attr('max',store);
			 $('#buyNum').val('1');
			 $('#goodstype').val(typeid+'');
			 $('#goodstype').attr('data-type',typenm);;
		});

	}
    },"json");
}



var getShopInfo = function(){
	var key ; //关键词
	//alert(window.location.href);
	key=GetQueryString("shop_id");
	var param = {shopId:key};
//	alert(JSON.stringify(param));
    $.post(basepath+'Shop/GetShopInfo.action',param,function(data){
	//alert(JSON.stringify(data));
	if(data.rspCode=="000002"||data.rspCode=="000001"){
	}else{
		logo = data.objs[0].logourl;
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
