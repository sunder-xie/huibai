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
	getGoodsLists();
	$('#ajax_loading').hide();
}

function appendData(){
	$('#ajax_loading').show();
	var start = $("#curPageNO").val();
	appendGoodsLists();
	$('#ajax_loading').hide();
}

/**判断是否为空**/
function isBlank(_value){
	if(_value==null || _value=="" || _value==undefined){
		return true;
	}
	return false;
}

var getGoodsLists = function(){
	
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
    $.post('InterestGoods/GetInterestGoodsList.action',param,function(data){
	//alert(JSON.stringify(data));
	if(data.rspCode=="000000"){
		var len = data.result.length;
		var num= len < data.offset ? len :data.offset;
		var total = data.total;
		var curPageNO = data.start;
		for(var j=0;j<num;j++){
			goods = data.result[j];
			GoodsList += genGoodsInfo(goods);
	    }
		$("#ListTotal").val(total);
		$("#curPageNO").val(curPageNO);
		$("#container").html(""); 
		$("#container").html(GoodsList);
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


var genGoodsInfo = function(goodsInfo){
	
	var goodsid,goodsnm,amount,shopid,imgurl,goodsurl;
	goodsid = goodsInfo.goodsId;
	goodsnm = goodsInfo.goodsNm;
	amount  = AmtToDecimal2(goodsInfo.amount);
	
	shopid  = goodsInfo.shopId;
	imgurl  = goodsInfo.mainPicUrl;
	
	goodsurl = basepath+'pages/Goods/goodsInfo.jsp?goods_id='+goodsid+'&shop_id='+shopid;	
	var GoodsList='';
	
	GoodsList+='<a href="'+goodsurl+'">';
	GoodsList+='	<div class="hproduct clearfix" style="background:#fff;border-top:0px;">';
	GoodsList+='		<div class="p-pic">';
	GoodsList+='	        <img style="max-height:100px;margin:auto;" class="img-responsive" src="'+imgurl+'">';
	GoodsList+='        </div>';
	GoodsList+='		<div class="p-info">';
	GoodsList+='		   <p class="p-title">'+goodsnm+'</p>';
	GoodsList+='		   <p class="p-origin">';
	GoodsList+='              <a class="close p-close" onclick="delInterGoods(\''+goodsid+'\')" href="javascript:void(0);">×</a>';
	GoodsList+='	          <em class="price">¥'+amount+'</em></p>';
	GoodsList+='		   <p class="mb0"><del class="old-price">¥'+amount+'</del></p>';
	GoodsList+='		</div>';
	GoodsList+='</div>';
	GoodsList+='</a> ';
	
	return GoodsList;
}

var delInterGoods = function(goodsid){
	var param = {
		 	goodsId:goodsid,
		 	channel:'1'		
 	};
	$.post('InterestGoods/DelInterestGoods.action',param,function(data){
//		alert(JSON.stringify(data));
		if(data.rspCode=="000000"){
			floatNotify.simple("取消收藏成功");
			getGoodsLists();
		}else if(data.rspCode=="100001"){
			window.location = "pages/Login/userLogin.jsp";
		}else{
			
		}
	},"json");
}


var appendGoodsLists = function(){
	
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
//	alert(JSON.stringify(param));
    $.post('Search/serGoodsShortInfListByKeyword.action',param,function(data){
//	alert(JSON.stringify(data));
	if(data.rspCode=="000000"){
		var len = data.result.length;
		var num= len < data.offset ? len :data.offset;
		var total = data.total;
		var curPageNO = data.start;
		
		for(var j=0;j<num;j++){
			goods = data.result[j];
			GoodsList+=genGoodsInfo(goods);
	    }
		$("#ListTotal").val(total);
		$("#curPageNO").val(curPageNO);
		$("#container").append(GoodsList);
	}else{
		
		GoodsList+='<div class="notice-search">';
		GoodsList+='<div class="ns-wrap clearfix info">';
		GoodsList+='<span class="ns-icon"></span>';
		GoodsList+='<div class="ns-content">';
		GoodsList+='<span>暂未收藏任何商品!</span>';
		GoodsList+='</div></div></div>';
		$("#container").append(GoodsList);
	}
},"json");
}