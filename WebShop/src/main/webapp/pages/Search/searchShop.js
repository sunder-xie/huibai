
var basepath=null; /*根目录*/
var startpagenum =1;
var offset =5;

$(function(){
	 setAllDomain();
	 getShopLists(startpagenum,offset);	
	 getTgGoods(1,5);
});
 
var setAllDomain = function(){
	basepath=getRootPath();	
}

var getShopLists = function(pagenumber,offsize){
	var ShopList='';
	var key ; //关键词
	//alert(window.location.href);
	key=GetQueryString("keyword");
	var map={
		keyword:key
	};
	var param = {
			start:pagenumber,
			offset:offsize,			
			conditions:map
	};
//	alert(JSON.stringify(param));
    $.post(basepath+'Search/getSerMerInfByKeyword.action',param,function(data){
//	alert(JSON.stringify(data));
	if(data.rspCode=="000000"){
		var len = data.result.length;
		ShopList+='<div class="blank"></div>';
		ShopList+='<div id="L_breadcrumb" class="breadcrumb">';
		ShopList+='<span>找到“<em>';
		ShopList+= data.conditions.keyword+'</em>”相关店铺共“<em>'+data.total+'</em>”家</span>';
		ShopList+='</div>';	
		
		ShopList+='<div class="flow-wrap clearfix">';
        var num= data.result.length < data.offset ? data.result.length :data.offset;
		
		for(var j=0;j<num;j++){
		var shopid = data.result[j].shopId;
		var shopnm = data.result[j].shopNm;
		var sales = data.result[j].sales;
		var addr  = data.result[j].address;
		var logourl = data.result[j].logourl;
		
		var shopurl = basepath+'pages/Shop/shopInfo.jsp?shop_id='+shopid;	
		
		ShopList+='<div class="flow-item first"> ';
		ShopList+='<a href="'+shopurl+'" class="flow-datu" title="'+shopnm+'">';
		ShopList+='<img style="display: block;" title="'+shopnm+'" alt="" src="'+logourl+'"height="150" width="150" class="err-product"></a>';
		ShopList+='<div class="flow-content">';
		ShopList+='<h4 class="flow-title">';
		ShopList+='<a href="'+shopurl+'" title="'+shopnm+'"><span>'+shopnm+'</span></a> </h4>';
		ShopList+='<p class="flow-desc">';
		ShopList+='<span>主营：</span>'+sales+'</p>';
		ShopList+='<p class="flow-desc">';
		ShopList+='<span>所在地：</span>'+addr+'</p>';
		ShopList+='<p class="flow-desc">';
		ShopList+='<a href="'+shopurl+'" title="进入店铺，查看所有的商品">共<strong id="cnt_'+shopid+'">0</strong>件宝贝&gt;&gt;</a></p>';
		ShopList+='</div>';
		ShopList+='<div class="flow-score">';
		ShopList+='<h3>店铺动态评分</h3>';
		ShopList+='<p>描述相符：<span>5</span></p>';
		ShopList+='<p>服务态度：<span>5</span></p>';
		ShopList+='<p>发货速度：<span>5</span></p> </div>';
		ShopList+='<div class="flow-main">';
		ShopList+='<div class="picMarquee-left">';
		ShopList+='<div class="bda">';
		ShopList+='<div class="picListta" id="list_'+shopid+'">';
		ShopList+='</div> </div></div></div></div>';
	    }
		ShopList+='<div class="blank"></div>';
		ShopList+='</div>';
		
		ShopList+='<div class="page clearfix">';
		ShopList+='<div id="J_bottomPage" class="p-wrap"></div>';
		ShopList+='</div>';
		
		$("#SearchWrap").empty();
		$("#J_bottomPage").empty();
		$("#SearchWrap").html(ShopList);
		$("#J_bottomPage").pager({ pagenumber: pagenumber, pagecount:data.pageCount,totalcount:data.total, buttonClickCallback: PageClick});  
		
		getGoodsInfo(num,data.result);
	}else{
		
		ShopList+='<div class="notice-search">';
		ShopList+='<div class="ns-wrap clearfix info">';
		ShopList+='<span class="ns-icon"></span>';
		ShopList+='<div class="ns-content">';
		ShopList+='<span>抱歉，没有找到“<em>'+data.conditions.keyword+'</em>”的搜索结果!</span>';
		ShopList+='</div></div></div>';
		$("#SearchWrap").append(GoodsList);
	}
	    
},"json");
}

//回调函数  
PageClick = function(pageclickednumber) {  
	getShopLists(pageclickednumber,offset);  
}  

var getGoodsInfo = function(num,result){
	var GoodsList='';
	var shop_id =null;
	for(var i=0;i<num;i++){
		shop_id = result[i].shopId;
		var map={
			shopId:shop_id
		};
		var param = {
				start:1,
				offset:4,			
				conditions:map
		};
	//	alert(JSON.stringify(param));
	    $.post(basepath+'Search/serGoodsShortInfListByKeyword.action',param,function(data){
	//	alert(JSON.stringify(data));
		if(data.rspCode=="000000"){
			
			var len = data.result.length;
			GoodsList+='<ul>';
			var num= data.result.length < data.offset ? data.result.length :data.offset;
			
			for(var j=0;j<num;j++){
			goodsid = data.result[j].goodsId;
			goodsnm = data.result[j].goodsNm;
			amount=AmtToDecimal2(data.result[j].amount);
			shopid = data.result[j].shopId;
			shopnm = data.result[j].shopNm;
			imgurl = data.result[j].mainPicUrl;
			var url = basepath+'pages/Goods/goodsInfo.jsp?goods_id=';	
			
			GoodsList+='<li>';
			GoodsList+='<a target="_blank" title="'+goodsnm+'" href="'+url+goodsid+'" class="img">';
			GoodsList+='<img src="'+imgurl+'"><span>'+amount+'</span> </a> ';
			GoodsList+='<a target="_blank" title="'+goodsnm+'" href="'+url+goodsid+'" class="name">'+goodsnm+'</a> ';
			GoodsList+='</li>';
			
		    }
			GoodsList+='</ul>';
			$("#cnt_"+shopid).html(data.total);
			$("#list_"+shopid).html(GoodsList);
		}else{
			
		}
	    },"json");
	}
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
	//alert(JSON.stringify(param));
    $.post(basepath+'TuiG/getTgGoodsInfByKeyword.action',param,function(data){
	//alert(JSON.stringify(data));
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
