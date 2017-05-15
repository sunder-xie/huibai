var basepath=''; /*根目录*/
var offset = 8;
var ord_sta='';
var keyword;
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
		if (id == 'waitbuy') {
			ord_sta='01';
		} else if (id == 'waitSend') {
			ord_sta='02';
		} else if (id == 'waitRecv') {
			ord_sta='03';
		} else if (id == 'default') {
			ord_sta='';
		}
		
		$("#ord_sta").val(ord_sta);
		$("#curPageNO").val(0);
		sendData();
	});
});

var setAllDomain = function(){
	basepath='';
	ord_sta=getQueryStringByName("ord_sta");
	if(isNull(ord_sta))
	ord_sta='';
	$("#keyword").val('');
	$("#ord_sta").val(ord_sta);
	$("#curPageNO").val(0);
	if(isWeiXinBrowse())
	{
		InitHeader();
	}
}

var InitHeader =function(){
	$('.header').hide();
}

function sendData(){
	$('#ajax_loading').show();
	$("#container").html(""); 
	getOrderLists();
	$('#ajax_loading').hide();
}

function appendData(){
	
	$('#ajax_loading').show();
	var start = $("#curPageNO").val();
	appendOrderLists();
	$('#ajax_loading').hide();
}

/**判断是否为空**/
function isBlank(_value){
	if(_value==null || _value=="" || _value==undefined){
		return true;
	}
	return false;
}

var getOrderLists = function(){
	var OrderList='';
	var startPageNo = $("#curPageNO").val();
	var map={
		"ordSta":ord_sta
	};
	var param = {
			start:startPageNo,
			offset:offset,			
			conditions:map
	};
//	alert(JSON.stringify(param));
    $.post('Order/GetOrderListByBuyer.action',param,function(data){
//	alert(JSON.stringify(data));
	if(data.rspCode=="000000"){
		var len = data.result.length;
		var num= len < data.offset ? len :data.offset;
		var total = data.pageCount;
		var curPageNO = data.start;
		$("#ListTotal").val(total);
		$("#curPageNO").val(curPageNO);
		for(var j=0;j<num;j++){
			orders = data.result[j];
			genOrderInfo(orders);
	    }
	}else if(data.rspCode=="100001"){
		window.location = "pages/Login/userLogin.jsp";
	}else{
		OrderList+='<div class="notice-search">';
		OrderList+='<div class="ns-wrap clearfix info">';
		OrderList+='<div class="ns-content">';
		OrderList+='<span>抱歉，没有找到订单!</span>';
		OrderList+='</div></div></div>';
		$("#container").html(""); 
		$("#container").html(OrderList);
	}
},"json");
}

var genOrderInfo = function(orders){
	var orderId,totalAmt,totalNum,shopId,shopNm,shopUrl,status,staDesc;
	orderId = orders.orderId;
	totalAmt  = AmtToDecimal2(orders.totalAmt);
	totalNum = orders.totalNum;
	shopId  = orders.shopId;
	
	shopNm = orders.shopNm;
	status = orders.ordSta;
	staDesc ='';
	var opertion = '';
	if(status=='01')
	{
		staDesc='等待买家付款';
		opertion +=' <a href="javascript:closeOrder(\''+orderId+'\')"><span class="gary order-opertion">取消订单</span></a>';
		opertion += '<a href="javascript:payOrder(\''+orderId+'\')"><span class="gary order-opertion">付款</span><a>';
	}else if(status=='02')
	{
		staDesc='等待卖家发货';
	}else if(status=='03')
	{
		staDesc='待收货';
		opertion += '<a href="javascript:recvOrder(\''+orderId+'\')"><span class="gary order-opertion">确认收货</span><a>';
	}else if(status=='04')
	{
		staDesc='交易完成';
		opertion += '<a href="javascript:delOrder(\''+orderId+'\')"><span class="gary order-opertion">删除订单</span><a>';
	}else if(status=='05')
	{
		staDesc='交易关闭';
		opertion += '<a href="javascript:delOrder(\''+orderId+'\')"><span class="gary order-opertion">删除订单</span><a>';
	}
	shopUrl = basepath+'pages/Shop/shopInfo.jsp?shop_id='+shopId;
	var empty = $('#orderInfo').val();
	$('#container').append(empty.template(orderId,shopUrl,shopNm,staDesc,totalNum,totalAmt,opertion));
	var num = orders.goodsList.length;
	var liNo = 0;
	var orderUrl='pages/Order/orderInfo.jsp?order_id='+orderId;
	for(var j=0;j<num;j++){
		goods = orders.goodsList[j];
		var goodsId=goods.goodsId;
		var imgUrl =goods.mainPicUrl;
		var goodsNm = goods.goodsNm;
		var typeNm = goods.typeNm;
		var price = AmtToDecimal2(goods.price);
		var buynum = goods.buynum;
		var empty = $('#goodsInfo').val();
		liNo=j;
		$('#'+orderId+' li').eq(liNo).after(empty.template(orderUrl,imgUrl,goodsNm,typeNm,buynum,price));
    }
}
var appendOrderLists = function(){
	
	var OrderList='';
	var startPageNo = $("#curPageNO").val();
	var map={
		"ordSta":ord_sta
	};
	var param = {
			start:startPageNo,
			offset:offset,			
			conditions:map
	};
//	alert(JSON.stringify(param));
    $.post('Order/GetOrderListByBuyer.action',param,function(data){
//	alert(JSON.stringify(data));
	if(data.rspCode=="000000"){
		var len = data.result.length;
		var num= len < data.offset ? len :data.offset;
		var total = data.pageCount;
		var curPageNO = data.start;
		$("#ListTotal").val(total);
		$("#curPageNO").val(curPageNO);
		for(var j=0;j<num;j++){
			var orders = data.result[j];
			genOrderInfo(orders);
	    }
	}else{
		OrderList+='<div class="notice-search">';
		OrderList+='<div class="ns-wrap clearfix info">';
		OrderList+='<span class="ns-icon"></span>';
		OrderList+='<div class="ns-content">';
		OrderList+='<span>抱歉，没有找到订单!</span>';
		OrderList+='</div></div></div>';
		$("#container").append(OrderList);
	}
},"json");
}
var payOrder= function(orderId){
	window.location = "pages/UnionPay/payCenter.jsp?order_id="+orderId;
}

var delOrder = function(orderId){
	var param = {
			'OrderId':orderId,
			'userFlag':'1'
		};
	var url =basepath+ "Order/OrderDel.action";
	$.post(url,param,function(data){
		if(data.rspCode=="000000"){
			floatNotify.simple("删除成功！");
			window.location = "pages/User/userOrder.jsp";
		}else{
			floatNotify.simple("系统异常");
		}
    },"json");
}
