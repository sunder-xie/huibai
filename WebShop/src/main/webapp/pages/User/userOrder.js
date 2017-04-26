var basepath=null; /*根目录*/
var user_id = null ;/*用户编号*/
var startpagenum =1;
var offset =10;

$(function(){
    setAllDomain();
    getUserMenu(basepath,user_id);
    getUserOrder(startpagenum,offset);
});
 
var setAllDomain = function(){
	basepath=getRootPath();	
	user_id =$("#LoginUser").attr('loginUserId');
}

//将yyyyMMdd格式转成yyyy-MM-dd

function formatStringyyyyMMddToyyyy_MM_dd(value){

	if(value.length == 8||value.length == 14){
		return value.substring(0, 4) + "-" + value.substring(4, 6) + "-" + value.substring(6, 8);
	} else if(value.length == 6){
		return value.substring(0, 4) + "-" + value.substring(4, 6);
	} else {
		return value;							
	}
}

//将yyyy-MM-dd格式转成yyyyMMdd

function formatStringyyyy_MM_ddToyyyyMMdd(value){

	if(value.length == 10){
		return value.substring(0, 4)  + value.substring(5, 7) +  value.substring(7, 9);
	} else if(value.length == 7){
		return value.substring(0, 4) + "-" + value.substring(5, 7);
	} else {
		return value;							
	}
}
var getUserOrder=function(pagenumber,offsize){
	var map={
	};
	var param = {
		start:pagenumber,
		offset:offsize,			
		conditions:map
	};
		
	var url =basepath+ "Order/GetOrderInfoByBuyer.action?userId="+user_id;
	var datatable='';
	$.post(url,param,function(data){
//		alert(JSON.stringify(data));
		if("000000"==data.rspCode) {
	    var num= data.result.length < data.offset ? data.result.length :data.offset;
		for (var i=0;i<num;i++)
		{
			var orderId= data.result[i].orderId;
			var orderDate= formatStringyyyyMMddToyyyy_MM_dd(data.result[i].applyDt);
			var orderDetailUrl=basepath+ 'pages/Order/orderDetail.jsp?order_id='+orderId;
			var shopUrl=basepath+ 'pages/Shop/shopInfo.jsp?shop_id='+data.result[i].shopId;
			var shopname = data.result[i].shopNm;
			var payamt = AmtToDecimal2(data.result[i].payAmt);
			var orderStatus =data.result[i].ordSta;
			
			datatable+=' <li >';
			datatable+=' <div class="auto_listTop clearfix">';
			datatable+=' <span  class="fl c333">'+orderDate+'</span>';
			datatable+=' <span  class="fl">订单编号：'+orderId+'</span>';
			datatable+=' <div class="order_oper fr">';
			datatable+=' <a target="_blank" href="'+orderDetailUrl+'" class="cm-orderLink">订单详情</a>';
			if(orderStatus=='01')/*待付款*/
			{
				datatable+='  <a id="ut54" class="btnMinR cm-btnPay mb10" href="javascript:openConfirmReceive(\'1100000014588645\');">立即付款</a>';
			}else if(orderStatus=='02')
			{
				datatable+='  <a id="ut54" class="btnMinR cm-btnPay mb10">待发货</a>';
			}
			else if(orderStatus=='03')
			{
				datatable+='  <a id="ut54" class="btnMinR cm-btnPay mb10" href="javascript:openConfirmReceive(\'1100000014588645\');">确认收货</a>';
			}
			else if(orderStatus=='04')
			{
				datatable+='  <a id="ut54" class="btnMinR cm-btnPay mb10">交易完成</a>';
			}
			else /*if(orderStatus=='05')*/
			{
				datatable+='  <a id="ut54" class="btnMinR cm-btnPay mb10">交易关闭</a>';
			}
			datatable+='</div>';
			datatable+=' <div class="cl_both"></div>';
			datatable+=' <div class="order_oper bus_message">';
			datatable+=' <a class="bus_name" href="'+shopUrl+'">';
			datatable+='   <em style="color:#888">商家：</em>'+shopname+'</a>';
			datatable+='   <span class="all_peice">总计：<label class="all_ab">'+payamt+'元</label></span>';
			
			
			datatable+='   </div>';
			datatable+=' </div>';
			datatable+=' <table class="tc order_list_td" border="0" cellpadding="0" cellspacing="0" width="100%">';
			datatable+=' <tbody id="'+orderId+'">';
			
			datatable+=' </tbody></table>';
			datatable+='</li>';
			
	    }
		
		$(".cTablea").html(datatable);
		$("#J_bottomPage").pager({ pagenumber: pagenumber, pagecount:data.pageCount,totalcount:data.total, buttonClickCallback: PageClick});  
		
		for (var i=0;i<num;i++)
		{
			var orderId =data.result[i].orderId;
			getOrderGoodsList(orderId);
		}
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

//回调函数  
var PageClick = function(pageclickednumber) {  
	getUserOrder(pageclickednumber,offset);  
}  

var getOrderGoodsList = function(orderId){
	
	var param = {
			"orderId":orderId			
	};
//	alert(JSON.stringify(param));
	var url = basepath+'Order/GetOrderGoodsByOrderId.action?userId='+user_id;
    $.post(url,param,function(data){
	//alert(JSON.stringify(data));
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
			//alert(datatable);
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


function showInfos(str){
	$("#common_errors").html(str);
	$("#common_errors").slideDown();
	setTimeout(hiddenUserRegTips,3000);
}
function hiddenUserRegTips(){
	$("#common_errors").slideUp();
}

function transferStr(value) {
	return value == null ? "" : value;
}
