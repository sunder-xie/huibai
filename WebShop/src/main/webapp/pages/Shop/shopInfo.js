
var basepath=null; /*根目录*/
var startpagenum =1;
var offset =20;
$(function(){
	 setAllDomain();
	 getShopInfo();
	 getShopBanner();
	 getGoodsLists(startpagenum,offset);	
});
 
var setAllDomain = function(){
	basepath=getRootPath();	
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
		var shopid=data.objs[0].shopId;
		var shopnm =data.objs[0].shopNm;
		var addr=data.objs[0].address;
		var logourl =data.objs[0].logourl;
		var totalscore = data.objs[0].totalscore;
		var shopscore = data.objs[0].shopscore;
		var serverscore = data.objs[0].serverscore;
		var expresscore = data.objs[0].expresscore;
		var shopsign = data.objs[0].shopsign;
		var server = data.objs[0].server;
		var shoptel = data.objs[0].shopTel;
		var shopurl = basepath+'pages/Shop/shopInfo.jsp?shop_id='+shopid;	
		var shopinfo = '';
		
		shopinfo+='	<div class="wrapper wrapper2">';
		shopinfo+='		<div class="g-search" style="z-index: 3;">';
		shopinfo+='			<form method="get">';
		shopinfo+='				<div class="search-inner clearfix">';
		shopinfo+='				    <input id="searchKeywords" class="search-keyword" value="" type="text">';
		shopinfo+='				    <input id="searchSubmit" class="search-btn" value="" style="padding: 0px;" type="button">';
		shopinfo+='					<input id="searchShopSubmit" class="search-btn searchstore-btn" value="" style="padding: 0px;" type="button">';
		shopinfo+='				</div>';
		shopinfo+='			</form>';
		shopinfo+='		</div>';
		shopinfo+=' <div class="g-logo">';
		shopinfo+='	  <a href="'+basepath+'index.jsp'+'" class="ng-logo"> ';
		shopinfo+='	 <img src="'+basepath+'images/lhbclogo.png" alt="乐汇百材">';
		shopinfo+='	  </a>';
		shopinfo+=' </div>';
		shopinfo+='	<div class="storname">';
		shopinfo+='		<div class="changeh3 shop-icon">';
		shopinfo+='		<i><a href="'+shopurl+'"';
		shopinfo+='			title="'+shopnm+'"><h1>'+shopnm+'</h1></a></i> <i class="fshop"></i>';
		shopinfo+='		</div>';
		shopinfo+='	<div class="bd clearfix">';
		shopinfo+='		<div class="store-grade">';
		shopinfo+='		<h4>店铺评分<span>&nbsp;'+totalscore+'分&nbsp;</span></h4>';
		shopinfo+='     <div  class="sg-details" style="display: none;">';
		shopinfo+='		<div class="clearfix">';
		shopinfo+='			<div class="com-grade">';
		shopinfo+='				<div class="hd clearfix">';
		shopinfo+='					<span class="l">店铺评分</span><span class="r">与同行业相比</span>';
		shopinfo+='				</div>';
		shopinfo+='				<p>';
		shopinfo+='				<span >商品满意度：'+shopscore+'分</span><span';
		shopinfo+='				class="per per-up"><em class="em1">16.33%</em></span>';
		shopinfo+='				</p>';
		shopinfo+='				<p>';
		shopinfo+='				<span >服务满意度：'+serverscore+'分</span><span';
		shopinfo+='				class="per per-up"><em class="em1">7.45%</em></span>';
		shopinfo+='				</p>';
		shopinfo+='				<p>';
		shopinfo+='				<span >物流满意度：'+expresscore+'分</span><span';
		shopinfo+='				class="per per-up"><em class="em1">15.64%</em></span>';
		shopinfo+='				</p>';
		shopinfo+='			</div>';
		shopinfo+='				<div class="store-logo">';
		shopinfo+='				<img src="'+logourl+'" height="80" width="80">';
		shopinfo+='				</div>';
		shopinfo+='		</div>';
		shopinfo+='			<ul class="store_contact" id="store_contact">';
		shopinfo+='         <li><span class="dt">服务承诺：</span> <span class="dd">';
		shopinfo+='         <i><img	src="'+basepath+'images/icon_serve3.png">&nbsp;正品保障</i>';
		shopinfo+='         </span></li>';
		shopinfo+='         <li><span class="dt">公司名称：</span><span';
		shopinfo+='         	class="dd JS_txtCtrl"><i id="lhbc_companyName"></i></span></li>';
		shopinfo+='         <li><span class="dt">所 在 地：</span><span';
		shopinfo+='	         class="dd JS_txtCtrl"><i >'+addr+'</i></span></li>';
		shopinfo+='         <li><span class="dt">客服电话：</span><span class="dd"';
		shopinfo+='       	>'+shoptel+'</span></li>';
		shopinfo+='			</ul>';
		shopinfo+='		</div>';
		shopinfo+='	</div>';
		shopinfo+='	</div>';
		shopinfo+='	</div>';
			
		shopinfo+='</div>';

		$("#shop_header").append(shopinfo);
		
		$('.bd > .store-grade').hover(function() {
			$(this).addClass('hover');
			$('.sg-details').css('display', 'block');
			$('.sg-details').show();
		}, function() {
			$(this).removeClass('hover');
			$('.sg-details').css('display', 'none');
			$('.sg-details').hide();
		});
		
		$("#searchSubmit").click(function(){
			var keyword=$("#searchKeywords").val();
			window.location = basepath+"pages/Search/SearchGoods.jsp?keyword="+keyword;
		});

		$("#searchShopSubmit").click(function(){
			var keyword=$("#searchKeywords").val();
			window.location = basepath+"pages/Search/SearchGoods.jsp?keyword="+keyword+"&&shopId="+shopid;
		});
		getEpriseInfo(data.objs[0]);
		getShopSing(data.objs[0]);
		getShopMenuList(data.objs[0]);
	}
	
},"json");
}

var getEpriseInfo = function(shopinfo){
	var shoptype=shopinfo.type;
//	alert(shoptype);
	var merinfo='';
	if(shoptype=='2')
	{
		var param = {epriseId:shopinfo.shopId};
//		alert(JSON.stringify(param));
	    $.post(basepath+'Eprise/GetEpriseInfoByShopId.action',param,function(data){
//		alert(JSON.stringify(data));
		if(data.rspCode=="000002"||data.rspCode=="000001"){
		}else{
			var epriseNm=data.objs[0].epriseNm;
			merinfo+=epriseNm;
			$("#lhbc_companyName").append(merinfo);
		}
	    },"json");
	}
	
}

var getShopSing = function(shopinfo){
	
	var shopsing='';
	shopsing+='<div class="sf-module990" pointx="F" modulestyle="990">';
	shopsing+='	<div sa-uv="banner" class="sf-moduleList sf-noPadding" style="margin-bottom: 0;">';
	shopsing+='	<div class="sf-nav" style="height: 120px;">';
	shopsing+='<p>';
	shopsing+='<img style="-webkit-user-select: none;"';
	shopsing+='	src="'+shopinfo.shopsign+'" height="121px" width="1210px"';
	shopsing+='	alt="">';
	shopsing+='	</p>';
	shopsing+='	</div>';
	shopsing+='</div>';
	shopsing+='</div>';
	$("#shopsign").append(shopsing);
	
}


var getShopMenuList = function(shopinfo){
	var shopurl = basepath+'pages/Shop/shopInfo.jsp?shop_id='+shopinfo.shopId;
	var shopsing='';
	shopsing+='<div class="sf-navbar clearfix">';
	shopsing+='	<dl class="sf-allcate"> '     ;
	shopsing+='		<dt>      '     ;
	shopsing+='			<span>本店所有商品</span>     '    ;
	shopsing+='		</dt>                '     ;
	shopsing+='	</dl>                                  '     ;
	shopsing+='	<ul class="sf-navlist clearfix">     '     ;
	shopsing+='		<li><a href="'+shopurl+'">店铺首页</a></li> '     ;
	shopsing+='		<li><a href="#">品牌介绍</a></li>      '      ;
	shopsing+='	</ul>                                   '     ;
	shopsing+='</div>                                  '     ;
   
	$("#shop_memuList").append(shopsing);
}
var getShopBanner = function(){
	var key ; //关键词
	//alert(window.location.href);
	key=GetQueryString("shop_id");
	var param = {
			shopId:key,
			type:'1'
				};
	
	$.post(basepath+'ShopBanner/GetShopBannerInfo.action',param,function(data){
	//	alert(JSON.stringify(data));
	var len = data.objs.length;
	var title;
	var imgurl;
	var url;
	var banner;
	banner='<div id="merreg-carousel" class="carousel slide" data-ride="carousel">';
	banner+='<ol class="carousel-indicators">';
	banner+='<li data-target="#merreg-carousel" data-slide-to="0" class="active"></li>';
	for(var i=1;i<len;i++)
	{
		banner+='<li data-target="#merreg-carousel" data-slide-to="'+i+'"></li>';
	}
	banner+='</ol>';
	banner+='<div class="carousel-inner" role="listbox">';
	banner+='<div class="item active">';
	banner+='<a target="_blank" href="'+basepath+data.objs[0].url+'"> <img src="'+data.objs[0].imgurl+'" alt="'+data.objs[0].title+'" style="height:450px"></a>';
	banner+='<div class="carousel-caption">'+'</div></div>';

	for(var j=1;j<len;j++){
		title = data.objs[j].title;
		imgurl = data.objs[j].imgurl;
		url = basepath+data.objs[j].url;			
		banner+='<div class="item">';
		banner+='<a target="_blank" href="'+basepath+url+'"> <img src="../../'+imgurl+'" alt="'+title+'" style="height:450px"></a>';
		banner+='<div class="carousel-caption">'+'</div></div>';
	}
	banner+='</div>';
	
	banner+='<a class="left carousel-control" href="#merreg-carousel" role="button" data-slide="prev">';
	banner+='<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>';
	banner+='<span class="sr-only">Previous</span>';
	banner+='</a>';
	banner+='<a class="right carousel-control" href="#merreg-carousel" role="button" data-slide="next">';
	banner+='<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>';
	banner+='<span class="sr-only">Next</span>';
	banner+='</a>';
	banner+='</div>';
	$("#merReg-banner").append(banner);
},"json");
}

var getGoodsLists = function(pagenumber,offsize){
	var GoodsList='';
	var key ; //关键词
	//alert(window.location.href);
	key=GetQueryString("shop_id");
	var map={
		shop_id:key,
		keyword:''
	};
	var param = {
		start:pagenumber,
		offset:offsize,			
		conditions:map
	};
//	alert(JSON.stringify(param));
    $.post(basepath+'Search/serGoodsShortInfListByKeyword.action',param,function(data){
//	alert(JSON.stringify(data));
	if(data.rspCode=="000002"||data.rspCode=="000001"){
		GoodsList+='<div class="notice-search">';
		GoodsList+='<div class="ns-wrap clearfix info">';
		GoodsList+='<span class="ns-icon"></span>';
		GoodsList+='<div class="ns-content">';
		GoodsList+='<span>抱歉，没有找到“<em>'+data.conditions.keyword+'</em>”的搜索结果!</span>';
		GoodsList+='</div></div></div>';
		$("#SearchWrap").append(GoodsList);
	}else{
		var len = data.result.length;
		
		GoodsList+='<div id="J_main" class="g-main2">';
		GoodsList+='<div class="m-list">';
		GoodsList+='<div class="ml-wrap">';
		
		GoodsList+='<div id="J_goodsList" class="goods-list-v1 gl-type-3 J-goods-list">';
		
		GoodsList+='<ul class="gl-warp clearfix" data-tpl="3">';
		var num= data.result.length < data.offset ? data.result.length :data.offset;
		
		for(var j=0;j<num;j++){
		goodsid = data.result[j].goodsId;
		goodsnm = data.result[j].goodsNm;
		amount= AmtToDecimal2(data.result[j].amount);
		shopid = data.result[j].shopId;
		shopnm = data.result[j].shopNm;
		imgurl = data.result[j].mainPicUrl;
		url = basepath+'pages/Goods/goodsInfo.jsp?goods_id=';	
		shopurl = basepath+'pages/Goods/goodsInfo.jsp?goods_id=';	
		GoodsList+='<li class="gl-item" >';
		GoodsList+='<div class="gl-i-wrap">';
		GoodsList+='<div class="p-img">';
		GoodsList+='<a target="_blank" href="'+url+goodsid+'"> <img src="'+imgurl+'" class="err-product" data-img="1"></a>';
		GoodsList+='</div>';
		GoodsList+='<div class="p-price">';
		GoodsList+='<strong class="J_1856584" data-price="4888.00"><em>¥</em><i>'+amount+'</i></strong>';
		GoodsList+='</div>';
		GoodsList+='<div class="p-name p-name-type-2">';
		GoodsList+='<a target="_blank" title="'+goodsnm+'" href="'+url+goodsid+'"';
		GoodsList+='<em>'+goodsnm+'</em> <i class="promo-words" id="J_AD_1856584"></i>';
		GoodsList+='</a></div>';
		GoodsList+='<div class="p-shop" data-selfware="1" data-reputation="97" data-shopid="1000004067">';
		GoodsList+='<span>';
		GoodsList+='<a target="_blank" title='+shopnm+' href="'+shopurl+shopid+'">'+shopnm+'</a>';
		GoodsList+='</span>';
		GoodsList+='</div></div>';
		GoodsList+='</li>';
		
	    }
		GoodsList+='</ul>';
		
		GoodsList+='<span class="clr"></span>';
		GoodsList+='</div>';
		GoodsList+='<div class="page clearfix">';
		GoodsList+='<div id="J_bottomPage" class="p-wrap"></div>';
		GoodsList+='</div>';
		
		GoodsList+='</div>';
		GoodsList+='</div>';
		GoodsList+='</div>';
		
		
		
		$("#SearchWrap").empty();
		$("#J_bottomPage").empty();
		$("#SearchWrap").html(GoodsList);
		$("#J_bottomPage").pager({ pagenumber: pagenumber, pagecount:data.pageCount,totalcount:data.total, buttonClickCallback: PageClick});  

	}
	
},"json");
}

//回调函数  
PageClick = function(pageclickednumber) {  
	getGoodsLists(pageclickednumber,offset);  
}  

