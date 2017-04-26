var basepath=null; /*根目录*/
var user_id = null ;/*用户编号*/
var intDiff = 739376062;//倒计时总秒数量
var status = 300;
$(function(){
    setAllDomain();
    getOrderInfo();
});
 
var setAllDomain = function(){
	basepath=getRootPath();	
	user_id =$("#LoginUser").attr('loginUserId');
}

function timer(intDiff){
    var interval = window.setInterval(function(){
    if(intDiff > 0){
        day=Math.floor(intDiff/(1000 * 60 * 60 * 24));
        hour=Math.floor(intDiff/(1000*60*60)) % 24;
        minute= Math.floor(intDiff/(1000*60)) % 60; 
        second=Math.floor(intDiff/1000) % 60; 
        $('#countDown').show();
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

$(function(){
	if(status == 100 || status == 300 || status == 303 || status == 200 || status == 201){
	//	timer(intDiff);
	}
}); 

var calcTime = function(autoDt){
	//alert(autoDt);
	var endtime =formatStringyyyyMMddToyyyy_MM_ddhh_mm_ss(autoDt);
	endtime =endtime.replace(/-/g, "/");
	var date1=new Date(endtime);   //结束时间
	var date2=new Date();    //开始时间
	var date3=date1.getTime()-date2.getTime() ; //时间差的毫秒数
	timer(date3);
}

var getOrderInfo=function(){
    var key=GetQueryString("order_id");
	var param = {orderId:key};
	var url =basepath+ "Order/GetOrderInfoByOrderId.action";
	var datatable='';
	var clock='';
	$.post(url,param,function(data){
//		alert(JSON.stringify(data));
		if("000000"==data.rspCode) {
			var i=0;
			var orderId= data.objs[i].orderId;
			var orderDate= formatStringyyyyMMddToyyyy_MM_dd(data.objs[i].applyDt);
			var orderDate1= formatStringyyyyMMddToyyyy_MM_ddhh_mm_ss(data.objs[i].applyDt);
			var shopUrl=basepath+ 'pages/Shop/shopInfo.jsp?shop_id='+data.objs[i].shopId;
			var shopname = data.objs[i].shopNm;
			var totalamt = AmtToDecimal2(data.objs[i].totalAmt);
			var orderStatus =data.objs[i].ordSta;
			var userId =data.objs[i].userId;
			var usernm =data.objs[i].userNm;
			var person = data.objs[i].person;
			var mobile = data.objs[i].mobile;
			var addr = data.objs[i].addrs;
			var buyMsg=data.objs[i].buyerMsg;
			var autoDt=null;
			datatable+=' <li >';
			datatable+=' <div class="auto_listTop clearfix" order-id ="'+orderId+'" > ';
			datatable+=' <span  class="fl c333">'+orderDate+'</span>';
			datatable+=' <span  class="fl" >订单编号：'+orderId+'</span>';
			datatable+=' <div class="order_oper fr">';
			if(orderStatus=='01')/*待付款*/
			{
				clock+='<i class="clock"></i>';
				clock+='<span class="timecounter">';
				clock+='<span class="d" id="day_show"><em></em>天</span>';
				clock+='<span class="h" id="hour_show"><em></em>时</span>';
				clock+='<span class="m" id="minute_show"><em></em>分</span>';
				clock+='<span class="s" id="second_show"><em></em>秒</span></span>后系统自动关闭订单';
				$("#countDown").html(clock);	
				autoDt =data.objs[i].autoDt;
				datatable+='<a  class="btnMinR cm-btnPay mb10" href="javascript:toPay()">立即付款</a>';
			}else if(orderStatus=='02')/*已付款*/
			{
				datatable+='<a  class="btnMinR cm-btnPay mb10">待发货</a>';
			}
			else if(orderStatus=='03')/*等待收货*/
			{
				clock+='<i class="clock"></i>';
				clock+='<span class="timecounter">';
				clock+='<span class="d" id="day_show"><em></em>天</span>';
				clock+='<span class="h" id="hour_show"><em></em>时</span>';
				clock+='<span class="m" id="minute_show"><em></em>分</span>';
				clock+='<span class="s" id="second_show"><em></em>秒</span></span>后系统自动确认收货';
				$("#countDown").html(clock);
				autoDt =data.objs[i].autoDt;
				datatable+='<a  class="cm-orderLink" href="javascript:openExchange(\'orderOptionPWD\')">查看物流</a>';
				datatable+='<a  class="cm-orderLink" href="javascript:openExchange(\'orderOptionPWD\')">退款退货</a>';
				datatable+='<a  class="cm-orderLink" href="javascript:openExchange(\'orderOptionPWD\')">延长收货</a>';
				datatable+='<a  class="btnMinR cm-btnPay mb10" href="javascript:openExchange(\'orderOptionPWD\')">确认收货</a>';
			}
			else if(orderStatus=='04')/*交易完成*/
			{   
				datatable+='<a  class="cm-orderLink" href="javascript:openExchange(\'orderOptionPWD\')">查看物流</a>';
			}
			else /*if(orderStatus=='05')交易关闭*/
			{
				
			}
			
			datatable+='</div>';
			datatable+=' <div class="cl_both"></div>';
			datatable+=' <div class="order_oper bus_message">';
			datatable+=' <a class="bus_name" shop-name="'+shopname+'" href="'+shopUrl+'">';
			datatable+='   <em style="color:#888">商家：</em>'+shopname+'</a>';
			datatable+=' <span class="all_peice">下单时间：'+orderDate1+'</span>';
			if(orderStatus=='01')/*待付款*/
			{
			}else if(orderStatus=='02')/*已付款*/
			{
				var payDate =formatStringyyyyMMddToyyyy_MM_ddhh_mm_ss(data.objs[i].payDt);
				datatable+=' <span  class="all_peice">付款时间：'+payDate+'</span>';
			}
			else if(orderStatus=='03')/*代收货*/
			{
				var payDate =formatStringyyyyMMddToyyyy_MM_ddhh_mm_ss(data.objs[i].payDt);
				var outDate =formatStringyyyyMMddToyyyy_MM_ddhh_mm_ss(data.objs[i].outDt);
				datatable+=' <span  class="all_peice">付款时间：'+payDate+'</span>';
				datatable+=' <span  class="all_peice">发货时间：'+outDate+'</span>';
			}
			else if(orderStatus=='04')/*交易完成*/
			{   
				var payDate =formatStringyyyyMMddToyyyy_MM_ddhh_mm_ss(data.objs[i].payDt);
				var outDate =formatStringyyyyMMddToyyyy_MM_ddhh_mm_ss(data.objs[i].outDt);
			    var confirmDate =formatStringyyyyMMddToyyyy_MM_ddhh_mm_ss(data.objs[i].confirmDt);
			    datatable+=' <span  class="all_peice">付款时间：'+payDate+'</span>';
			    datatable+=' <span  class="all_peice">发货时间：'+outDate+'</span>';
				datatable+=' <span  class="all_peice">确认时间：'+confirmDate+'</span>';
			}
			else /*if(orderStatus=='05')交易关闭*/
			{
				var closeDate =formatStringyyyyMMddToyyyy_MM_ddhh_mm_ss(data.objs[i].closeDt);
				datatable+=' <span  class="all_peice">关闭时间：'+closeDate+'</span>';
			}
			
			datatable+='   </div>';
			datatable+=' </div>';
			datatable+=' <table class="tc order_list_td" border="0" cellpadding="0" cellspacing="0" width="100%">';
			datatable+=' <tbody id="'+orderId+'">';

			datatable+=' </tbody></table>';
			datatable+='</li>';
		    $(".cTablea").html(datatable);
		    
		    $("#totalamt").html(totalamt);
		    
		    datatable='';
		    datatable+='<div class="o-title">收货信息</div>';
		    datatable+='<p >买家账号：'+usernm+'</p>';
		    datatable+='<p class="infor  clearfix">';
		    datatable+='<span class="infor_head">收货信息：</span>';
		    datatable+='<span class="name">'+person+'</span>';
		    datatable+='<span class="phone_number">'+mobile+'</span>';
		    datatable+='<span class="address_detail">'+addr+'</span></p>';
		    $("#recv_info").html(datatable);
            
		    datatable='';
		    datatable+='<p style="margin-bottom:10px;">买家留言：<span>'+buyMsg+'</span></p>';
		    datatable+='<p style="margin-bottom:10px;">商家留言：<span>无</span></p>';
		    $("#Message").append(datatable);
		    
		    if(autoDt!=null)
		    {
		    	calcTime(autoDt);
		    }
		    
		    getOrderGoodsList(orderId);
		    
		
		} else {
			datatable+=' <li >';
			datatable+=' <table class="tc order_list_td" border="0" cellpadding="0" cellspacing="0" width="100%">';
			datatable+= '<td >还没有订单信息！</td>';
			datatable+=' </table>';
			datatable+='</li>';
			$(".cTablea").html(datatable);
		}
	},"json");
	
}

var getOrderGoodsList = function(orderId){
	
	var param = {
			"orderId":orderId			
	};
//	alert(JSON.stringify(param));
	var url = basepath+'Order/GetOrderGoodsByOrderId.action?userId='+user_id;
    $.post(url,param,function(data){
//	alert(JSON.stringify(data));
	if(data.rspCode=="000000"){
		var len = data.objs.length;
		for (var i=0;i<len;i++)
		{
			var orderId =data.objs[i].orderId;
			var seqId =data.objs[i].seqId;
			var goodsId =data.objs[i].goodsId;
			var goodsUrl=basepath+ 'pages/Goods/goodsInfo.jsp?goods_id='+goodsId;
			var goodsname=data.objs[i].goodsNm;
			var typename =data.objs[i].typeNm;
			var price = AmtToDecimal2(data.objs[i].price);
			var buynum= data.objs[i].buynum;
			var totalAmt = AmtToDecimal2(data.objs[i].totalAmt);
			var orderStatus ='01';
			
			var datatable='';
			datatable+=' <tr >';
			datatable+=' <td class="tl clearfix" width="50%">';
			datatable+=' <div >';
			datatable+=' <div class="img fl" style="position: relative;">';
			datatable+='<a id="'+orderId+seqId+'" target="_blank" href="'+goodsUrl+'">';
	//		datatable+='<img id="ut211" src="#" height="80" width="80">';
			datatable+=' </a>';
			datatable+='</div>';
			datatable+='<div id="ut213" class="info" style="width:130px;">';
			datatable+=' <a id="ut57" target="_blank" href="'+goodsUrl+'">';
			datatable+=' <h3>'+goodsname+'</h3></a>';
			datatable+=' <p>'+typename+'</p>';
			datatable+='  </div>';
			datatable+='  </div>';
			datatable+='  </td>';
			datatable+='  <td id="ut216" class="tc" width="15%">';
			datatable+='  <div id="ut217">'+price+'</div>';
			datatable+='  </td>';
			datatable+=' <td id="ut218" class="tc" width="10%">X'+buynum+'</td>';
			datatable+=' <td id="ut218" class="tc" width="15%">'+totalAmt+'</td>';
			
			datatable+=' <td id="ut218" class="tc" width="20%">'+''+'</td>';
			
			datatable+='</tr>   ';
			$("#"+orderId).append(datatable);
		}
		
		for (var i=0;i<len;i++)
		{
			var goodsId =data.objs[i].goodsId;
			var seqId =data.objs[i].seqId;
		    getGoodsPicList(goodsId,orderId+seqId);
		}
		
	}else{
	}
    },"json");
}

var getGoodsPicList = function(goodsId,Id){
	var key ; //关键词
	
	var param = {"goodsId":goodsId};
//	alert(JSON.stringify(param));
    $.post(basepath+'Goods/GetGoodsShortInfo.action',param,function(data){
//	alert(JSON.stringify(data));
	if(data.rspCode=="000000"){
		var len = data.objs.length;
		var piclist ='';
		var picurl='';
		for(var i=0;i<len;i++)
		{
		    picurl=data.objs[i].mainPicUrl;
		    piclist+='<img src="'+picurl+'" height="80" width="80">';
		}
	    $("#"+Id).append(piclist);
	}else{
		
	}
    },"json");
}

var toPay = function(){
	var orderId= $('.auto_listTop').attr('order-id');
	var shopNm =$('.bus_name').attr('shop-name');
	var payAmt =Decimal2ToAmt($('#totalamt').text());
	
	window.location = basepath+"pages/UnifyPay/payCenter.jsp?orderId="+orderId+"&&shopNm="+shopNm+"&&payAmt="+payAmt;
}
