
var basepath=null; /*根目录*/
var startpagenum =1;
var offset =20;
$(function(){
	 setAllDomain();
	 getGoodsLists(startpagenum,offset);	
	 getTgGoods(1,5);
});
 
var setAllDomain = function(){
	basepath=getRootPath();	
}

var getGoodsLists = function(pagenumber,offsize){
	var GoodsList='';
	var keyword ; //关键词
//	alert(window.location.href);
//	var map=parseQuery(window.location.href);
	keyword=GetQueryString("keyword");
	if(isNull(keyword))
	{
		keyword='';
	}
	var map={
		"keyword":keyword
	};
//	alert(JSON.stringify(map));
	var param = {
			start:pagenumber,
			offset:offsize,			
			conditions:map
	};
	//alert(JSON.stringify(param));
    $.post(basepath+'Search/serGoodsShortInfListByKeyword.action',param,function(data){
//	alert(JSON.stringify(data));
	if(data.rspCode=="000000"){
		$('#NullResult').css("display","none");
		$('#SearchResult').css("display","block");
		$('#RelateShop').css("display","none");
		var len = data.result.length;
		//GoodsList+='<div id="J_main" class="g-main2">';
		GoodsList+='<div class="m-list">';
		GoodsList+='<div class="ml-wrap">';
		
		GoodsList+='<div id="J_goodsList" class="goods-list-v1 gl-type-3 J-goods-list">';
		
		GoodsList+='<ul class="gl-warp clearfix" data-tpl="3">';
		var num= len < data.offset ? len :data.offset;
		
		for(var j=0;j<num;j++){
		goodsid = data.result[j].goodsId;
		goodsnm = data.result[j].goodsNm;
		amount= AmtToDecimal2(data.result[j].amount);
		shopid = data.result[j].shopId;
		shopnm = data.result[j].shopNm;
		//imgurl = basepath+data.result[j].mainPicUrl;
		imgurl = data.result[j].mainPicUrl;
		goodsurl = basepath+'pages/Goods/goodsInfo.jsp?goods_id='+goodsid+'&shop_id='+shopid;	
		shopurl = basepath+'pages/Shop/shopInfo.jsp?shop_id='+shopid;	
		GoodsList+='<li class="gl-item" >';
		GoodsList+='<div class="gl-i-wrap">';
		GoodsList+='<div class="p-img">';
		GoodsList+='<a target="_blank" href="'+goodsurl+'"> <img src="'+imgurl+'" class="err-product" data-img="1"></a>';
		GoodsList+='</div>';
		GoodsList+='<div class="p-price">';
		GoodsList+='<strong class="J_1856584"><em>¥</em><i>'+amount+'</i></strong>';
		GoodsList+='</div>';
		GoodsList+='<div class="p-name p-name-type-2">';
		GoodsList+='<a target="_blank" title="'+goodsnm+'" href="'+goodsurl+'"';
		GoodsList+='<em>'+goodsnm+'</em> <i class="promo-words" id="J_AD_1856584"></i>';
		GoodsList+='</a></div>';
		GoodsList+='<div class="p-shop" data-selfware="1" data-reputation="97" data-shopid="1000004067">';
		GoodsList+='<span>';
		GoodsList+='<a target="_blank" title='+shopnm+' href="'+shopurl+'">'+shopnm+'</a>';
		GoodsList+='</span>';
		GoodsList+='</div></div>';
		GoodsList+='</li>';
		
	    }
		GoodsList+='</ul>';
		
		GoodsList+='<span class="clr"></span>';
		GoodsList+='</div>';
		
		GoodsList+='</div>';
		GoodsList+='</div>';
		GoodsList+='</div>';
		
		
		//GoodsList+='</div>';
		
		//$("#SearchResult").empty();
		$("#J_bottomPage").empty();
		$("#J_main").append(GoodsList);
		$("#J_bottomPage").pager({ pagenumber: pagenumber, pagecount:data.pageCount,totalcount:data.total, buttonClickCallback: PageClick});  

		
	}else{
		
		GoodsList+='<div class="notice-search">';
		GoodsList+='<div class="ns-wrap clearfix info">';
		GoodsList+='<span class="ns-icon"></span>';
		GoodsList+='<div class="ns-content">';
		GoodsList+='<span>抱歉，没有找到“<em>'+data.conditions.keyword+'</em>”的搜索结果!</span>';
		GoodsList+='</div></div></div>';
		$("#NullResult").append(GoodsList);
	}
	
	getTopMerInfo();
	
},"json");
}

//回调函数  
PageClick = function(pageclickednumber) {  
	getGoodsLists(pageclickednumber,offset);  
  //  $("#result").html("Clicked Page " + pageclickednumber);  
}  
var getTopMerInfo = function(){
	var GoodsList='';
	GoodsList+='<div class="shop-bd">';
	GoodsList+='<div class="shop-logo">';
	GoodsList+='<a target="_blank" href=""> <img width="180" height="60"';
	GoodsList+='src="'+basepath+'images/product/f1_01_02.png"></img></a></div>';
	GoodsList+='<div class="shop-main">';
	GoodsList+='<div class="shop-name">';
	GoodsList+='<a class="title" target="_blank" href="#">云南乐天美旗舰店</a></div>';
	GoodsList+='<div class="shop-infor">主营品牌：乐天</div>';
	GoodsList+='<div class="shop-infor">店铺简介：乐天美旗舰店</div></div>';
	GoodsList+='<div class="shop-ext">';
	GoodsList+='<dl class="shop-score2">';
	GoodsList+='<dd class="score-infor">';
	GoodsList+='<div class="sum">';
	GoodsList+='<span class="tit">综合评分</span><em class="num J_total_score">10</em></div>';
	GoodsList+='<div class="part">';
	GoodsList+='<span class="tit">商品评分</span><em class="num J_ware_score">10</em></div>';
	GoodsList+='<div class="part">';
	GoodsList+='<span class="tit">服务评分</span><em class="num J_service_score">10</em></div>';
	GoodsList+='<div class="part">';
	GoodsList+='<span class="tit">物流评分</span><em class="num J_effective_score">10</em></div>';
	GoodsList+='</dd>';
	GoodsList+='</dl>';
	GoodsList+='<div class="shop-btn">';
	GoodsList+='<a href="#" target="_blank" class="shop-enter">进入店铺</a>';
	GoodsList+='</div>';
	GoodsList+='</div>';
	GoodsList+='</div>';
	$("#RelateShop").append(GoodsList);
}

var getTgGoods = function(pagenumber,offsize){
	var GoodsList='';
	var key ; //关键词
	//alert(window.location.href);
	key='';
	var map={
		keyword:key
	};
	var param = {
			start:1,
			offset:5,			
			conditions:map
	};
//	alert(JSON.stringify(param));
    $.post(basepath+'TuiG/getTgGoodsInfByKeyword.action',param,function(data){
//	alert(JSON.stringify(data));
	if(data.rspCode=="000000"){
		var len = data.result.length;
		GoodsList+='<ul>';
		var num= data.result.length < data.offset ? data.result.length :data.offset;
		
		for(var j=0;j<num;j++){
			
			var	goodsid = data.result[j].goodsId;
			var	goodsnm = data.result[j].goodsNm;
			var	amount= AmtToDecimal2(data.result[j].amount);
			var	shopid = data.result[j].shopId;
			var	shopnm = data.result[j].shopNm;
			//imgurl = basepath+data.result[j].mainPicUrl;
			var	imgUrl = data.result[j].mainPicUrl;
			
			var goodsUrl = basepath+'pages/Goods/goodsInfo.jsp?goods_id=' +goodsid;	
		
		GoodsList+='<li>';
		GoodsList+='<a target="_blank" href="'+goodsUrl+'"><p class="chosen-product-pic">';
		GoodsList+='<img class="search-loading" src="'+imgUrl+'" title="'+goodsnm+'" alt="'+goodsnm+'" height="160" width="160" ></p>';
		GoodsList+='<p class="chosen-produc-title">'+goodsnm;
		GoodsList+='</p></a>';
		GoodsList+='<p class="prive-tag"><em class="prive"><b>¥</b>'+amount+'</em>';
		GoodsList+='</p></li>';
		
	    }
		GoodsList+='</ul>';
		$("#seller-chosen-list").html(GoodsList);
		
	}else{

		GoodsList+='<div class="notice-search">';
		GoodsList+='<div class="ns-wrap clearfix info">';
		GoodsList+='<span class="ns-icon"></span>';
		GoodsList+='<div class="ns-content">';
		GoodsList+='<span>抱歉，没有找到“<em>'+data.conditions.keyword+'</em>”的搜索结果!</span>';
		GoodsList+='</div></div></div>';
		$("#seller-chosen-list").append(GoodsList);
		
	}
	
},"json");
}
