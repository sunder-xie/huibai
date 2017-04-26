var basepath=null; /*根目录*/
var startpagenum =1;
var offset =10;

$(function(){
    setAllDomain();
    getOrderInfo();
    $(".moreorderinfo").unbind().click(function() {
        $(".orderinfo-detail").slideToggle();
    	if($(this).attr('name')==1){
    		$(this).attr('name',0);
            $('.moreorderinfo').text('收起');
            preservation($(this));
    	  return;
    	}else{
        $(this).attr('name',1);
        $('.moreorderinfo').text('展开');
    	  return;
    	}
    });
    
    $('.paytool_head_bd li').click(function(){
        var index = $(this).index();
        $('.paytool_body_bd .tab_aera').css('display','none');
        $('.paytool_body_bd .tab_aera').eq(index).show();
        $(this).addClass('active').siblings().removeClass('active');
        $(".paytool_head_bd").attr('now-pay-tool',index);
    });
    
    $(".paytool_button").on("click",".pay_next_btn",function(){
    	var payTool = $(".paytool_head_bd").attr('now-pay-tool');
    	var orderId=$("#order_id span:eq(0)").text();
		var shopNm =$("#order_shop span:eq(0)").text();
		var payAmt =Decimal2ToAmt($(".paytool .paytool-title span:eq(0)").text());
		var orderDesc=$("#order_desc span:eq(0)").text();
    	if(payTool=='0')	/*微信支付*/
    	{
    		window.location = basepath+"pages/UnifyPay/toPay.jsp?payChannel="+"01&&orderId="+orderId+"&&shopNm="+shopNm+"&&payAmt="+payAmt+"&&orderDesc="+orderDesc;
    	}
    });
    
});
 
var setAllDomain = function(){
	basepath=getRootPath();	
}

var getOrderInfo = function(){
	var payAmt = AmtToDecimal2(GetQueryString("payAmt"));	
	var orderId = GetQueryString("orderId");
	var shopNm = GetQueryString("shopNm");
	var orderDesc = GetQueryString("orderDesc");
	$(".payfloor .title_right span:eq(0)").text('¥'+payAmt);
	$(".paytool .paytool-title span:eq(0)").text(payAmt);
	
	$("#order_id span:eq(0)").text(orderId);
	$("#order_shop span:eq(0)").text(shopNm);
	$("#order_desc span:eq(0)").text(orderDesc);
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
