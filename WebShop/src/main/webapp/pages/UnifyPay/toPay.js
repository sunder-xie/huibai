var basepath=null; /*根目录*/
var user_id = null ;/*用户编号*/

$(function(){
    setAllDomain();
    setPayInfo();
    getQrcodeInfo();
    
    setTimeout(function () {
        DeferredExe();
    }, 7000);
});
 
var setAllDomain = function(){
	basepath=getRootPath();	
	user_id =$("#LoginUser").attr('loginUserId');
}

var setPayInfo = function(){
	var payAmt = AmtToDecimal2(GetQueryString("payAmt"));	
	$(".pay_weixin p span:eq(0)").text('¥'+payAmt);
	$("#hidCheckSuccess").val('1');
	$("#hidOrderID").val(GetQueryString("orderId"));
}

var getQrcodeInfo = function(){
	var payAmt = GetQueryString("payAmt");	
//	var payAmt = '1';	
	var orderId = GetQueryString("orderId");
	var shopNm = GetQueryString("shopNm");
	var orderDesc = GetQueryString("orderDesc");
	
	var url =basepath+ "Order/GetOrderInfoByOrderId.action";
	var datatable='';
	var clock='';
	
	var url =basepath+ "Pay/GetWeiXinQrcode.action?orderId="+orderId+"&&payAmt="+payAmt+"&&orderDesc="+orderDesc;
	
	$("#qrCode").attr("src",url);
}
//loading
var loading=function(){
  float('','loading');
}

//unloading
var unloading=function(){
$('.loading').hide();
$('.float').hide();
}
//浮窗
var float=function(m,clas){
    var width=$(window).width();
    var height=$(window).height();
    var width1=$('.'+clas).width();
    var height1=$('.'+clas).height();
    var h=$(document.body).height();
    var heights=0;
     var top=(height-height1)/2;
     var left=(width-width1)/2;
     $('.'+clas).css({
       'top':top+'px',
       'left':left+'px'
     });
     
     heights=height>h? height:h;
     $('.float').css({
        'height':heights+'px'
     });
    $('.'+clas).show();
}	 

// 延迟执行
function DeferredExe() {
    CheckQRCodeIsCorrect();
}

// 检查后台校验是否通过
function CheckQRCodeIsCorrect() {
	
    // 检查失败或异常的场合、不做支付状态查询动作
    if ($("#hidCheckSuccess").val() == "2") {
        return;
    }
    // 二维码和检查通过的场合、开始读取支付状态
    if ($("#qrCode").attr('src') != "" && $("#hidCheckSuccess").val() == "1") {
        LoadPayResult();
        return;
    }
    setTimeout(function () {
        CheckQRCodeIsCorrect();
    }, 1000);
}

// 定时获取支付状态
function LoadPayResult() {
    setTimeout(function () {
        var orderId = $("#hidOrderID").val();
        // 主键获取失败的场合停止获取
        if (orderId == "" || orderId == "0") {
            return;
        }
        var param = {
        	"orderId":orderId
        };
        		
    	var url =basepath+ "Order/GetOrderInfoByOrderId.action?userId="+user_id;
    	$.post(url,param,function(data){
//    		alert(JSON.stringify(data));
    		if("000000"==data.rspCode) {
    			var paySta = data.objs[0].paySta;
    			if(paySta=='02')
    			{
    				CallBackToOnlinePage();
    				return;
    			}
    			LoadPayResult();
    		}else{
    			LoadPayResult();
    		}
    	},"json");
    }, 1000);
}

// 返回Online支付站点页面
function CallBackToOnlinePage() {

	window.location = basepath+"pages/UnifyPay/PayResult.jsp";
}
