var basepath=null; /*根目录*/
var currOrderId ='';
var currPayChannle = '';
var currOrderDesc='';
var currOrderAmt='';
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
}

function sendData(){
	$('#ajax_loading').show();
	getOrderPayInfo();
	getPayChannle();
	$('#ajax_loading').hide();
}

function getPayChannle(){
	
	var url='';
	var param = {
			
	};
	
	var weixin= 'images/weixin_wap.png';
	var empty = $('#payChannle-text').val();
	$('#payChannle').append(empty.template(WeiXinPay,weixin));
	
	
	//属性选择
	$('#payChannle dd').click(function(e) {
		//clickChoose(this);
		clickChooseChannle(this);
	});
	
//	if(isNull(addrId))
//	{
//		url = 'Address/GetDefaultAddr.action';
//	}else
//	{
//		url = 'Address/GetAddressInfoByAddrId.action';
//		param={
//			'addrId':addrId
//		};
//	}
//	$.post(url,param,function(data){
//		//alert(JSON.stringify(data));
//		if(data.rspCode=="000000"){
//			var addr= data.objs[0];
//			var address = addr.provice + addr.city + addr.zone + addr.address;
//			var mobile = addr.mobile;
//			var consignee = addr.consignee;
//			var empty = $('#addr').val();
//			$('#address').append(empty.template(mobile,consignee,address));
//		}else if(data.rspCode=="100001"){
//			window.location = "pages/Login/userLogin.jsp";
//			
//		}else if(data.rspCode==NotFoundRecord){
//			$('#noAddr').show();
//		}else{
//			
//		}
//	},"json");
}
function getOrderPayInfo(){
	
	var GoodsList='';
	var param = {
		 	'OrderId':currOrderId
 	};
	//alert(JSON.stringify(param));
	$.post('Order/GetOrderPayInfo.action',param,function(data){
		//alert(JSON.stringify(data));
			if(data.rspCode=="000000"){
				$("#payinfo").html(""); 
				pay = data.objs;
				genPayInfo(pay);
			}else if(data.rspCode=="100001"){
				window.location = "pages/Login/userLogin.jsp";
			}else{
			}
		},"json");
}


var genPayInfo = function(pay){
	var orderId,orderDt,orderDesc,orderAmt;
	orderId = pay.OrderId;
	orderDt = formatStringyyyyMMddToyyyy_MM_ddhh_mm_ss(pay.OrderDt);
	orderDesc = pay.OrderDesc;
	orderAmt  = AmtToDecimal2(pay.PayAmt);
	var empty = $('#payinfo-text').val();
	$('#payinfo').append(empty.template(orderId,orderDesc,orderDt,orderAmt));
	currOrderId=orderId;
	currOrderDesc=orderDesc;
	currOrderAmt=pay.PayAmt;
}

function clickChooseChannle(object){
	$(object).addClass('check').siblings().removeClass('check');
	currPayChannle=$(object).attr('channle-id');
}

function submitPay(){
	
	if(isNull(currPayChannle))
	{
		floatNotify.simple("请选择支付方式！");
		return;
	}
	var param = {
		 	'OrderId':currOrderId,
		 	'OrderDesc':currOrderDesc,
		 	'PayAmt':currOrderAmt,
		 	'SendChannle':wapChannel,
		 	'PayChannle':currPayChannle
 	};
	$.post('Pay/PayUnifiedOrder.action',param,function(data){
		//alert(JSON.stringify(data));
			if(data.rspCode=="000000"){
				doWxpay(data.objs);
			}else if(data.rspCode=="100001"){
				window.location = "pages/Login/userLogin.jsp";
			}else{
				floatNotify.simple("系统异常");
			}
		},"json");
}

function doWxpay(WxInfo){
	
	if (typeof WeixinJSBridge == "undefined"){
		   if( document.addEventListener ){
		       document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
		   }else if (document.attachEvent){
		       document.attachEvent('WeixinJSBridgeReady', onBridgeReady); 
		       document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
		   }
		}else{
		onBridgeReady(WxInfo);
	} 
}

function onBridgeReady(WxInfo){
	   WeixinJSBridge.invoke(
	       'getBrandWCPayRequest', {
	           "appId":WxInfo.appId,     //公众号名称，由商户传入     
	           "timeStamp":WxInfo.timeStamp,         //时间戳，自1970年以来的秒数     
	           "nonceStr":WxInfo.nonceStr, //随机串     
	           "package":WxInfo.package_,     
	           "signType":WxInfo.signType,         //微信签名方式：     
	           "paySign":WxInfo.paySign //微信签名 
	       },
	       function(res){     
	    	   // 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回    ok，但并不保证它绝对可靠。
	    	   var result ='';
	           if(res.err_msg == "get_brand_wcpay_request:ok" ) {
	        	   result='S';
	           }  
	           else if(res.err_msg == "get_brand_wcpay_request:cancel" ) {
	        	   result='F';
	           } 
	           else if(res.err_msg == "get_brand_wcpay_request:fail" ) {
	        	   result='F';
	           } 
	           
	           window.location = "pages/UnionPay/payResult.jsp?result="+result;
	       }
	   ); 
}
	


