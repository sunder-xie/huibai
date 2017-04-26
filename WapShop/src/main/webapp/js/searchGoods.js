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
	
	
	//绑定 点击事件
	$(".row ul li").bind("click",function() {
		var id = $(this).attr("id");
		var orderDir = "";
		$(".row ul li").each(function(i) {
			if (id != $(this).attr("id")) {
				$(this).removeClass("active");
			}
		});
		$(this).addClass("active");
		var iElement=$(this).find("i");
		if (id == 'cash') {
			if ($(iElement).hasClass("icon_sort_up")) {
				orderDir = "cash,asc";
				$(iElement).attr("class","icon_sort_down");
				
			} else if($(iElement).hasClass("icon_sort_down")){
				orderDir = "cash,desc";
				$(iElement).attr("class","icon_sort_up");
				
			}else{
				orderDir = "cash,desc";
				$(iElement).attr("class","icon_sort_up");
			}
		} else if (id == 'buys') {
			if ($(iElement).hasClass("icon_sort_down")) {
				orderDir = "buys,desc";
				$(iElement).attr("class","icon_sort_up");
				
			} else if($(iElement).hasClass("icon_sort_up")){
				orderDir = "buys,asc";
				$(iElement).attr("class","icon_sort_down");
				
			}else{
				orderDir = "buys,desc";
				$(iElement).attr("class","icon_sort_up");
			}
		} else if (id == 'comments') {
			if ($(iElement).hasClass("icon_sort_down")) {
				orderDir = "comments,desc";
				$(iElement).attr("class","icon_sort_up");
				
			} else if($(iElement).hasClass("icon_sort_up")){
				orderDir = "comments,asc";
				$(iElement).attr("class","icon_sort_down");
				
			}else{
				orderDir = "comments,desc";
				$(iElement).attr("class","icon_sort_up");
			}
		} else if (id == 'default') {
			orderDir = "recDate,desc";
		}
		
		$(this).siblings().find("i").attr("class","icon_sort");
		
		$("#orders").val(orderDir);
		var no_results=$.trim($("#no_results").html());
		if(no_results!="" && no_results!=null && no_results!=undefined){
			return false;
		}
		$("#curPageNO").val(0);
		sendData();
	});
});

var setAllDomain = function(){
	basepath='';	
	var keyword=getQueryStringByName("keyword");
	$("#keyword").val(keyword);
	$("#curPageNO").val(0);
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
//	alert(JSON.stringify(param));
    $.post('Search/serGoodsShortInfListByKeyword.action',param,function(data){
//	alert(JSON.stringify(data));
	if(data.rspCode=="000000"){
		var len = data.result.length;
		var num= len < data.offset ? len :data.offset;
		var total = data.pageCount;
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
		GoodsList+='<span>抱歉，没有找到“<em>'+data.conditions.keyword+'</em>”的搜索结果!</span>';
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
	GoodsList+='		<p class="p-title">'+goodsnm+'</p>';
	GoodsList+='		<p class="p-origin"><em class="price">¥'+amount+'</em></p>';
	GoodsList+='		<p class="mb0"><del class="old-price">¥'+amount+'</del></p>';
	GoodsList+='		</div>';
	GoodsList+='</div>';
	GoodsList+='</a> ';
	
	return GoodsList;
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
		var total = data.pageCount;
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
		GoodsList+='<span>抱歉，没有找到“<em>'+data.conditions.keyword+'</em>”的搜索结果!</span>';
		GoodsList+='</div></div></div>';
		$("#container").append(GoodsList);
	}
},"json");
}