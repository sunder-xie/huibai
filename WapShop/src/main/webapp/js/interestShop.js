var basepath=null; /*根目录*/
var offset = 8;

$(function(){
	
	setAllDomain();
	
	sendData();//一过来就调用
	
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
	
	
	$(window).scroll(function(){
        if ($(document).height() - $(this).scrollTop() - $(this).height()<50){
        	var curPageNo = $("#curPageNO").val();
        	if(isBlank(curPageNo) || curPageNo == 0){
        		curPageNo = 1;
        	}
        	
        	curPageNo=parseInt(curPageNo)+1;
			var totalPage=parseInt($("#ListTotal").val());
			if(curPageNo<=totalPage){
				$("#curPageNO").val(curPageNo);
				appendData();
			}
			else{
				$("#nodata").show();
			}
        }
    });

	
	 $("#sousou").click(function(){
		   $(".order_top_count").show();
	   });
	   
	   $("#nav-left_ll").click(function(){
		   $(".order_top_count").hide();
	   });
});

var setAllDomain = function(){
	basepath='';	
	$("#curPageNO").val('1');
	$("#keyword").val('');
}

function sendData(){
	$('#ajax_loading').show();
	getInterShopLists();
	$('#ajax_loading').hide();
}

function appendData(){
	$('#ajax_loading').show();
	var start = $("#curPageNO").val();
	appendInterShopLists();
	$('#ajax_loading').hide();
}

var getInterShopLists = function(){
	
	var GoodsList='';
	var keyword ; //关键词
//	alert(window.location.href);
	keyword=$("#keyword").val();
	if(isNull(keyword))
	{
		keyword='';
	}
	var startPageNo = $("#curPageNO").val();
	var map={
		"keyword":keyword
	};
	var param = {
			start:startPageNo,
			offset:offset,			
			conditions:map
	};
	//alert(JSON.stringify(param));
    $.post('InterestShop/GetInterestShopList.action',param,function(data){
	//alert(JSON.stringify(data));
	if(data.rspCode=="000000"){
		var len = data.result.length;
		var num= len < data.offset ? len :data.offset;
		var total = data.pageCount;
		var curPageNO = data.start;
		for(var j=0;j<num;j++){
			goods = data.result[j];
			GoodsList += genInterShopInfo(goods);
	    }
		$("#ListTotal").val(total);
		$("#curPageNO").val(curPageNO);
		$("#container").html(""); 
		$("#container").html(GoodsList);
	}else if(data.rspCode=="100001"){
		window.location = "pages/Login/userLogin.jsp";
	}else{
		
		GoodsList+='<div class="notice-search">';
		GoodsList+='<div class="ns-wrap clearfix info">';
		GoodsList+='<div class="ns-content">';
		GoodsList+='<span>暂未收藏任何商品!</span>';
		GoodsList+='</div></div></div>';
		$("#container").html(""); 
		$("#container").html(GoodsList);
	}
},"json");
}


var genInterShopInfo = function(data){
	
	var shopid,imgurl,shopurl;
	
	shopid  = data.shopId;
	shopnm = data.shopNm;
	imgurl  = data.logourl;
	
	shopurl = basepath+'pages/Shop/shopInfo.jsp?shop_id='+shopid;	
	var GoodsList='';
	
	GoodsList+='<a href="'+shopurl+'">';
	GoodsList+='	<div class="hproduct clearfix" style="background:#fff;border-top:0px;">';
	GoodsList+='		<div class="p-pic">';
	GoodsList+='	        <img style="max-height:100px;margin:auto;" class="img-responsive" src="'+imgurl+'">';
	GoodsList+='        </div>';
	GoodsList+='		<div class="p-info">';
	GoodsList+='		   <p class="p-title">'+shopnm+'</p>';
	GoodsList+='		   <p class="p-origin">';
	GoodsList+='              <a class="close p-close" onclick="delInterShop(\''+shopid+'\')" href="javascript:void(0);">×</a></p>';
	GoodsList+='		</div>';
	GoodsList+='</div>';
	GoodsList+='</a> ';
	
	return GoodsList;
}

var delInterShop = function(shopid){
	var param = {
		 	shopId:shopid,
		 	channel:'1'		
 	};
	$.post('InterestShop/DelInterestShop.action',param,function(data){
//		alert(JSON.stringify(data));
		if(data.rspCode=="000000"){
			floatNotify.simple("取消收藏成功");
			sendData();
		}else if(data.rspCode=="100001"){
			window.location = "pages/Login/userLogin.jsp";
		}else{
			
		}
	},"json");
}


var appendInterShopLists = function(){
	
	var GoodsList='';
	var keyword ; //关键词
//	alert(window.location.href);
	keyword=$("#keyword").val();
	if(isNull(keyword))
	{
		keyword='';
	}
	var startPageNo = $("#curPageNO").val();
	var map={
		"keyword":keyword
	};
	var param = {
			start:startPageNo,
			offset:offset,			
			conditions:map
	};
	//alert(JSON.stringify(param));
    $.post('InterestShop/GetInterestShopList.action',param,function(data){
	//alert(JSON.stringify(data));
	if(data.rspCode=="000000"){
		var len = data.result.length;
		var num= len < data.offset ? len :data.offset;
		var total = data.pageCount;
		var curPageNO = data.start;
		for(var j=0;j<num;j++){
			goods = data.result[j];
			GoodsList += genInterShopInfo(goods);
	    }
		$("#ListTotal").val(total);
		$("#curPageNO").val(curPageNO);
		$("#container").html(GoodsList);
	}else if(data.rspCode=="100001"){
		window.location = "pages/Login/userLogin.jsp";
	}else{
		
		GoodsList+='<div class="notice-search">';
		GoodsList+='<div class="ns-wrap clearfix info">';
		GoodsList+='<div class="ns-content">';
		GoodsList+='<span>暂未收藏任何商品!</span>';
		GoodsList+='</div></div></div>';
		$("#container").html(""); 
		$("#container").html(GoodsList);
	}
},"json");
}