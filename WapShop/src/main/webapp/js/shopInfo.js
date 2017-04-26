var basepath='';
var currShopId='';
var keyword='';
var offset = 8;

$(function(){
	setAllDomain();
	getShopInfo();
	
	getShopIndex();
	
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
	   
	 $('#shopContent > .bd > ul').eq(0).show();
	//首页菜单绑定 点击事件
	 $("#shopContent > .hd ul li").bind("click",function() {
		var id = $(this).attr("id");
		$("#shopContent > .hd ul li").each(function(i) {
			if (id != $(this).attr("id")) {
				$(this).removeClass("on");
			}
		});
		$(this).addClass("on");
		
		var index = $(this).index();
	    $('#shopContent > .bd > ul').css('display','none');
	    $('#shopContent > .bd > ul').eq(index).show();
	    if (id == 'index') {
	    	$("#orders").val('index');
	    	getShopIndex();
	    }
	    else if (id == 'all') {
	    	$("#orders").val('all');
	    	getShopAllGoods();
	    }
	    else if (id == 'new') {
	    	$("#orders").val('new');
	    	getShopNewGoods();
	    }
	    else if (id == 'message') {
	    	$("#orders").val('message');
	    	//getShopMessage();
	    }
	    else{
	    	$("#orders").val('index');
	    	getShopIndex();
	    }
	 });
	   
	 $(window).scroll(function(){
		
        if ($(document).height() - $(this).scrollTop() - $(this).height()<50){
        	
        	var curPageNo = $("#curPageNO").val();
        	if(isNull(curPageNo) || curPageNo == 0){
        		curPageNo = 1;
        	}
        	
        	curPageNo=parseInt(curPageNo)+1;
			var totalPage=parseInt($("#ListTotal").val());
			var id = $("#orders").val();
			if(curPageNo<=totalPage){
				$("#curPageNO").val(curPageNo);
				
				if (id == 'index') {
			    }
			    else if (id == 'all') {
			    	//alert('all');
			    	appendAllData();
			    }
			    else if (id == 'new') {
			    	appendNewData();
			    }
			    else if (id == 'message') {
			    	//appendData();
			    }
			    else{
			    }
			}
			else{
				//alert(1);
				if (id == 'index') {
			    }
			    else if (id == 'all') {
			    	//alert('all');
			    	$("#allnodata").show();
			    }
			    else if (id == 'new') {
			    	$("#newnodata").show();
			    }
			    else if (id == 'message') {
			    	//appendData();
			    }
			    else{
			    }
				
			}
        }
    });
});

var setAllDomain = function(){
	basepath='';
	currShopId=getQueryStringByName("shop_id");
	$("#shopId").val(currShopId);
	$("#keyword").val('');
	$("#curPageNO").val(0);
	/*页面标示*/
	$("#orders").val('index');
}

var getShopIndex = function(){
	getShopBannerList();
	$('#ajax_loading_index').show();
	$("#curPageNO").val(0);
	getShopGoodsInfo('shop-goods-arae');
	$('#ajax_loading_index').show();
	
}

var getShopAllGoods = function(){
	$('#ajax_loading_all').show();
	$("#curPageNO").val(0);
	getShopGoodsInfo('all-goods-arae');
	$('#ajax_loading_all').hide();
}

var getShopNewGoods = function(){
	$('#ajax_loading_new').show();
	$("#curPageNO").val(0);
	getShopGoodsInfo('new-goods-arae');
	$('#ajax_loading_new').hide();
}


var getShopGoodsInfo = function(area_id){
	var Result='';
	
	if(isNull(keyword))
	{
		keyword='';
	}
	var startPageNo = $("#curPageNO").val();
	var map={
		"keyword":keyword,
		shop_id:currShopId,
	};
	var param = {
			start:startPageNo,
			offset:offset,			
			conditions:map
	};
//	alert(JSON.stringify(param));
    $.post('Search/serGoodsShortInfListByKeyword.action',param,function(data){
	//alert(JSON.stringify(data));
	if(data.rspCode=="000000"){
		var len = data.result.length;
		var num= len < data.offset ? len :data.offset;
		var total = data.pageCount;
		var curPageNO = data.start;
		$('#'+area_id+' ul').html(""); 
		$("#ListTotal").val(total);
		$("#curPageNO").val(curPageNO);
		for(var j=0;j<num;j++){
			temps = data.result[j];
			genGoodsList(temps,area_id);
	    }
	}else{
		Result+='<div class="notice-search">';
		Result+='<div class="ns-wrap clearfix info">';
		Result+='<div class="ns-content">';
		Result+='<span>暂无商品!</span>';
		Result+='</div></div></div>';
		$('#'+area_id).html(""); 
		$('#'+area_id).html(Result);
	}
	
    },"json");
}

var appendAllData = function(){
	$('#ajax_loading_all').show();
	apendGoodsInfo('all-goods-arae');
	$('#ajax_loading_all').hide();
}

var appendNewData = function(){
	$('#ajax_loading_new').show();
	apendGoodsInfo('new-goods-arae');
	$('#ajax_loading_new').hide();
}

var apendGoodsInfo = function(area_id){
	var Result='';
	
	if(isNull(keyword))
	{
		keyword='';
	}
	var startPageNo = $("#curPageNO").val();
	var map={
		"keyword":keyword,
		shop_id:currShopId,
	};
	var param = {
			start:startPageNo,
			offset:offset,			
			conditions:map
	};
//	alert(JSON.stringify(param));
    $.post('Search/serGoodsShortInfListByKeyword.action',param,function(data){
//	alert(JSON.stringify(data));
	if(data.rspCode=="000000"){
		var len = data.result.length;
		var num= len < data.offset ? len :data.offset;
		var total = data.pageCount;
		var curPageNO = data.start;
		//$('#'+area_id+' ul').html(""); 
		$("#ListTotal").val(total);
		$("#curPageNO").val(curPageNO);
		for(var j=0;j<num;j++){
			temps = data.result[j];
			genGoodsList(temps,area_id);
	    }
	}else{
		Result+='<div class="notice-search">';
		Result+='<div class="ns-wrap clearfix info">';
		Result+='<div class="ns-content">';
		Result+='<span>暂无商品!</span>';
		Result+='</div></div></div>';
		$('#'+area_id).html(""); 
		$('#'+area_id).html(Result);
	}
	
    },"json");
}

var genGoodsList = function(temps,area_id){
	
	var width= $(document).width();
	if(width>768)
	{
		width=768;
	}
	width=width/2;
	var goodsid,goodsnm,amount,shopid,imgurl,goodsurl;
	goodsid = temps.goodsId;
	goodsnm = temps.goodsNm;
	amount  = AmtToDecimal2(temps.amount);
	shopid  = temps.shopId;
	imgurl  = temps.mainPicUrl;
	goodsurl = basepath+'pages/Goods/goodsInfo.jsp?goods_id='+goodsid+'&shop_id='+shopid;	
	
	var empty = $('#goodsInfo').val();
	$('#'+area_id+' ul').append(empty.template(width,goodsurl,imgurl,goodsurl,goodsnm,amount));
	
}
var getShopBannerList = function(){
	
	var param = {
			'shopId':currShopId,
			'type':'1'
	};
//	alert(JSON.stringify(param));
	var url = basepath+'ShopBanner/GetShopBannerInfo.action';
    $.post(url,param,function(data){
//	alert(JSON.stringify(data));
	if(data.rspCode=="000000"){
		var len = data.objs.length;
		var picurl='';
		var str = "";
		var strCounts = "";
		for(var i=0;i<len;i++)
		{
		    picurl=data.objs[i].imgurl;
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

/** 收藏商品 **/
function addInterest(obj){
	
	 var _this = $(obj);
	 var param = {
			 	shopId:currShopId,
			 	channel:'1'		
	 	};
	 var flag = $("#guanzhu").attr('flag');
	 if(flag=='1')
	 {
		 $.post('InterestShop/DelInterestShop.action',param,function(data){
//				alert(JSON.stringify(data));
				if(data.rspCode=="000000"){
					//更换样式
					$("#guanzhu").attr('flag','0');
					$("#guanzhu").html('关注店铺');
					floatNotify.simple("取消收藏成功");
				}else if(data.rspCode=="100001"){
					window.location = "pages/Login/userLogin.jsp";
				}else{
					
				}
			},"json");
	 }
	 else{
		 $.post('InterestShop/AddInterestShop.action',param,function(data){
//				alert(JSON.stringify(data));
				if(data.rspCode=="000000"){
					//更换样式
					$("#guanzhu").attr('flag','1');
					$("#guanzhu").html('已关注');
					floatNotify.simple("关注成功");
				}else if(data.rspCode=="100001"){
					window.location = "pages/Login/userLogin.jsp";
				}else{
					
				}
			},"json");
	 }
}

var getShopInfo = function(){
	var param = {
			'shopId':currShopId
		};
	//alert(JSON.stringify(param));
    $.post(basepath+'Shop/GetShopInfo.action',param,function(data){
	//alert(JSON.stringify(data));
	if(data.rspCode=="000000"){
		var shopid=data.objs[0].shopId;
		var shopnm =data.objs[0].shopNm;
		var type = data.objs[0].type;
		var logourl =data.objs[0].logourl;
		var shoplogo = '<img src="'+logourl+'">';
		$("#shop-logo").html(shoplogo);
		$("#shop-nm").html(shopnm);
		if(type==1)
		$("#shop-type").html('企业店铺');
		else if(type==2)
		$("#shop-type").html('个人店铺');
	}
	
},"json");
}
