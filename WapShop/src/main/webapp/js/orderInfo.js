var basepath=null; /*根目录*/
var currOrderId ='';

var intDiff = 739376062;//倒计时总秒数量
var status = 300;


$(document).ready(function(){
	
	setAllDomain();
	//获取订单信息
	sendData();
	//返回顶部
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
	
});


var setAllDomain = function(){
	basepath='';	
	currOrderId = getQueryStringByName('order_id');
	
	if(status == 100 || status == 300 || status == 303 || status == 200 || status == 201){
		//	timer(intDiff);
	}
}

function sendData(){
	$('#ajax_loading').show();
	getOrderInfo();
	$('#ajax_loading').hide();
}

function timer(intDiff){
    var interval = window.setInterval(function(){
    if(intDiff > 0){
        day=Math.floor(intDiff/(1000 * 60 * 60 * 24));
        hour=Math.floor(intDiff/(1000*60*60)) % 24;
        minute= Math.floor(intDiff/(1000*60)) % 60; 
        second=Math.floor(intDiff/1000) % 60; 
        //$('#countDown').show();
    } else {
    	//location.reload();
    	window.clearInterval(interval);
    	return;
    }
    if (minute <= 9) minute = '0' + minute;
    if (second <= 9) second = '0' + second;
    $('#day_show').html('<em>'+day+"</em>天");
    $('#hour_show').html('<em>'+hour+'</em>时');
    $('#minute_show').html('<em>'+minute+'</em>分');
    $('#second_show').html('<em>'+second+'</em>秒');
    intDiff -= 1000;
    }, 1000);
}

var calcTime = function(autoDt){
	//alert(autoDt);
	var endtime =formatStringyyyyMMddToyyyy_MM_ddhh_mm_ss(autoDt);
	endtime =endtime.replace(/-/g, "/");
	var date1=new Date(endtime);   //结束时间
	var date2=new Date();    //开始时间
	var date3=date1.getTime()-date2.getTime() ; //时间差的毫秒数
	timer(date3);
}

function getOrderInfo(){
	var param = {
			'orderId':currOrderId
		};
	var url =basepath+ "Order/GetOrderInfoByOrderId.action";
	var datatable='';
	var clock='';
	$.post(url,param,function(data){
		//alert(JSON.stringify(data));
		if("000000"==data.rspCode) {
			var i=0;
			var orderInfo = data.objs[i];
			var orderId= orderInfo.orderId;
			var shopId = orderInfo.shopId;
			var shopUrl=basepath+ 'pages/Shop/shopInfo.jsp?shop_id='+shopId;
			var shopNm = data.objs[i].shopNm;
			
			/*首先构建商家信息*/
			var empty = $('#shopInfo').val();
			$('#order').append(empty.template(shopId,shopUrl,shopNm));
			
			/*构建地址信息*/
			var address = orderInfo.addrs;
			var mobile = orderInfo.mobile;
			var consignee = orderInfo.person;
			var empty = $('#addr').val();
			$('#address').append(empty.template(mobile,consignee,address));
			
			/*构建其它信息*/
			$('#BuyMsg').val(orderInfo.buyerMsg);
			
			var goodsAmt  = AmtToDecimal2(orderInfo.goodsAmt);
			var yfAmt =  AmtToDecimal2(orderInfo.yfAmt);
			var totalAmt =  AmtToDecimal2(orderInfo.totalAmt);
			var payAmt =  AmtToDecimal2(orderInfo.payAmt);
			var empty = $('#payinfo-text').val();
			$('#pay').append(empty.template(goodsAmt,yfAmt,totalAmt,payAmt));
			
			var status =orderInfo.ordSta;
			var staDesc='';
			var staShow='';
			var opertion='';
			var orderDtCont='';
			var autoDt = orderInfo.autoDt;
			var orderDate= formatStringyyyyMMddToyyyy_MM_ddhh_mm_ss(orderInfo.applyDt);
			var dtempty = $('#orderinfo-text').val();
			orderDtCont += dtempty.template('订单编号',orderId);
			orderDtCont += dtempty.template('下单时间',orderDate);
			
			if(status=='01')
			{
				staDesc='等待买家付款';
				staShow += '<h2 class="p5 ml50 white">'+staDesc+'</h2>';
				var empty = $('#clock').val();
				staShow+=empty.template('关闭订单');
				
				var empty = $('#opertion-text').val();
				opertion +=empty.template(orderId,'buy','立即付款');
				 
			}else if(status=='02')
			{
				staDesc='等待卖家发货';
				staShow += '<h2 class="p5 ml50 white">'+staDesc+'</h2>';
				var orderDate= formatStringyyyyMMddToyyyy_MM_ddhh_mm_ss(orderInfo.payDt);
				orderDtCont += dtempty.template('付款时间',orderDate);
			}else if(status=='03')
			{
				staDesc='待收货';
				staShow += '<h2 class="p5 ml50 white">'+staDesc+'</h2>';
				var empty = $('#opertion-text').val();
				opertion +=empty.template(orderId,'recv','确认收货');
				
				orderDate= formatStringyyyyMMddToyyyy_MM_ddhh_mm_ss(orderInfo.payDt);
				orderDtCont += dtempty.template('付款时间',orderDate);
				orderDate= formatStringyyyyMMddToyyyy_MM_ddhh_mm_ss(orderInfo.outDt);
				orderDtCont += dtempty.template('发货时间',orderDate);
				
			}else if(status=='04')
			{
				staDesc='交易完成';
				staShow += '<h2 class="p5 ml50 white">'+staDesc+'</h2>';
				
				orderDate= formatStringyyyyMMddToyyyy_MM_ddhh_mm_ss(orderInfo.payDt);
				orderDtCont += dtempty.template('付款时间',orderDate);
				orderDate= formatStringyyyyMMddToyyyy_MM_ddhh_mm_ss(orderInfo.outDt);
				orderDtCont += dtempty.template('发货时间',orderDate);
				orderDate= formatStringyyyyMMddToyyyy_MM_ddhh_mm_ss(orderInfo.confirmDt);
				orderDtCont += dtempty.template('成交时间',orderDate);
				
			}else if(status=='05')
			{
				staDesc='交易关闭';
				staShow += '<h2 class="p5 ml50 white">'+staDesc+'</h2>';
				var orderDate= formatStringyyyyMMddToyyyy_MM_ddhh_mm_ss(orderInfo.closeDt);
				orderDtCont += dtempty.template('关闭时间',orderDate);
				
				var empty = $('#opertion-text').val();
				opertion +=empty.template(orderId,'del','删除订单');
			}
			$('#orderSta').append(staShow);
			if(autoDt!=null)
		    {
		    	calcTime(autoDt);
		    }
			$('#opertion').append(opertion);
			
			$('#orderDtCont').append(orderDtCont);
			
		    getOrderGoodsList(orderId);
		} else {
			floatNotify.simple("系统异常");
		}
	},"json");
}

var toDo = function(orderId,mode){
	
	if(mode=='buy')
	{
		window.location = "pages/UnionPay/payCenter.jsp?order_id="+orderId;
	}else if(mode='del'){
		delOrder(delOrder);
	}
}

var delOrder = function(orderId){
	var param = {
			'OrderId':currOrderId
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

var getOrderGoodsList = function(orderId){
	
	var param = {
			"orderId":orderId			
	};
//	alert(JSON.stringify(param));
	var url = basepath+'Order/GetOrderGoodsShortInfoByOrderId.action';
    $.post(url,param,function(data){
	//alert(JSON.stringify(data));
	if(data.rspCode=="000000"){
		data = data.objs;
		/*构建商品信息，如果是同一家店铺，同时构建*/
		var len = data.length;
		var index =0;
		for(var i=0;i<len;i++)
		{
			shopid=data[i].shopId;
			goodsid = data[i].goodsId;
			goodsnm = data[i].goodsNm;
			amount  = AmtToDecimal2(data[i].price);
			imgurl  = data[i].mainPicUrl;
			typeid =  data[i].typeId;
			typenm =  data[i].typeNm;
			buynum = data[i].buynum;
			goodsurl = basepath+'pages/Goods/goodsInfo.jsp?goods_id='+goodsid+'&shop_id='+shopid;	
			var empty = $('#goodsInfo').val();
			$('#'+shopid+' li').eq(index).after(empty.template(goodsid,goodsurl,imgurl,goodsurl,goodsnm,typenm,buynum,amount));
			index +=1;
		}
	}else{
		floatNotify.simple("系统异常");
	}
    },"json");
}
