var basepath=null; /*根目录*/
var offset = 8;
var shopList='start,';/*存放购物车中商家列表*/
var append=0;
var checkShopFlag=0;/*购物车中是否存放被选中商家*/
var checkShopList='';/*存放购物车中被选中商家*/

$(document).ready(function(){
	
	setAllDomain();
	//获取购物车商品
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
	
	$(window).scroll(function(){
        if ($(document).height() - $(this).scrollTop() - $(this).height()<50){
        	var curPageNo = $("#curPageNO").val();
        	if(isNull(curPageNo) || curPageNo == 0){
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
	
	//勾选
//    $(".checkLabel").click(function(){
//    	var flag = $(this).prev().is(':checked');
//    	if(flag){
//            $(this).prev().attr("checked",false);
//            
//            $("#buy-sele-all").attr("checked", false); //将全选勾除
//            $("#buy-sele-all").val(0);
//            
//        }else{
//        	
//            $(this).prev().attr("checked",true);
//            
//            //如果全部都选中了，将全选勾选
//            var groupUL = $(".container").find("ul[class='list-group']").get();
//            var checkUL = $(".container").find("div[class='icheck pull-left mr5'] :checkbox:checked").get();
//            if(groupUL.length == checkUL.length){
//            	$("#buy-sele-all").attr("checked", true);
//            	$("#buy-sele-all").val(1);
//            }
//        }
//    	
//      //计算总价
//	  calculateTotal();
//    });
//    
//    // 全选，全不选
//    $("#buy-sele-all").click(function() {
//        var flag = $(this).val();
//
//        if(flag ==1){
//            $(this).val(0);
//             $(".ids").attr("checked", false);
//        }else{
//            $(this).val(1);
//            $(".ids").attr("checked", true);
//        }
//        
//      //计算总价
//  	  calculateTotal();
//    });
    
	  //计算总价
	//  calculateTotal();
});


var setAllDomain = function(){
	basepath='';	
	$("#curPageNO").val(1);
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
	getBuyCarInfo();
	append=0;
	$('#ajax_loading').hide();
}

function appendData(){
	$('#ajax_loading').show();
	var start = $("#curPageNO").val();
	appendBuyCarInfo();
	append=1;
	$('#ajax_loading').hide();
}

function getBuyCarInfo(){
	
	shopList='start,';
	var GoodsList='';
	var keyword=$("#keyword").val();
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
	$.post('BuyCar/GetBuyCarListByBuyer.action',param,function(data){
		//alert(JSON.stringify(data));
			if(data.rspCode=="000000"){
				var len = data.result.length;
				var num= len < data.offset ? len :data.offset;
				var total = data.pageCount;
				var curPageNO = data.start;
				
				$("#rowcar").html(""); 
				$("#ListTotal").val(total);
				$("#curPageNO").val(curPageNO);
				for(var j=0;j<num;j++){
					goods = data.result[j];
					genGoodsInfo(goods,data.result);
			    }
				
				$(".shopcheckLabel").click(function(){
					var currShopId = $(this).prev().attr('itemkey');
			    	var flag = $(this).prev().is(':checked');
			    	if(flag){
			            $(this).prev().attr("checked",false);
			            $('#'+currShopId+' .ids').attr("checked", false);
			            checkShopFlag=0;
			            checkShopList='';
			        }else{
			        	if(checkShopFlag==1||checkShopFlag==2||checkShopFlag==3)
						{
							floatNotify.simple("只能选一家店铺商品结算！");
							return;
						}
			            $(this).prev().attr("checked",true);
			            $('#'+currShopId+' .ids').attr("checked", true);
			            checkShopFlag=1;
			            checkShopList=currShopId;
			        }
				     //计算总价
				     calculateTotal();
			    });
				//勾选
			    $(".checkLabel").click(function(){
			    	var flag = $(this).prev().is(':checked');
			    	var currShopId=$(this).prev().attr('shopId');
			    	//var result=$(this).prev().attr('itemkey').split(",");
			    	//var currShopId = result[0];
			    	//var currGoods = result[1];
			    	//alert(currShopId);
			    	if(flag){
			            $(this).prev().attr("checked",false);
			            $('#'+currShopId+' .top-ids').attr("checked", false);
			            
			            var list = $('#'+currShopId).find("li[class='list-group-item hproduct clearfix']").get();
			            var topflag=1;
			            var chooseflag=0;
			        	for(var i=0;i<list.length;i++){
			        		var selected = $(list[i]).find("div[class='icheck buy-car-check']>:checkbox").is(":checked");
			        		if(selected){
			        			chooseflag=1;
			        		}
			        		if(!selected){
			        			topflag=0;/*全部未选中*/
			        		}
			        		if(chooseflag && topflag==0){
			        			topflag=2;/*部分选中*/
			        		}
			        	}
			        	
			        	if(topflag==0 && checkShopList==currShopId)
			        	{
			        		checkShopList='';
			        		checkShopFlag=0;
			        	}else if(topflag==2)
			        	{
			        		checkShopFlag=3;
			        	}
			        	//alert(checkShopList+','+checkShopFlag);
			        	
			        }else{
			        	/*选中列表里不包含当前选中店铺并且选中店铺标志为所有商品*/
			        	//alert('a='+checkShopList+',b='+currShopId+',c='+checkShopFlag);
			            if(checkShopList!=currShopId&&checkShopFlag==1)
						{
							floatNotify.simple("只能选同一家店铺商品结算！");
							return;
						}
			            /*选中列表里不包含当前选中店铺并且选中店铺标志为部分商品*/
			            if(checkShopList!=currShopId&&checkShopFlag==2)
						{
							floatNotify.simple("只能选同一家店铺商品结算！");
							return;
						}
			            /*选中列表里不包含当前选中店铺并且选中店铺标志为部分商品*/
			            if(checkShopList!=currShopId&&checkShopFlag==3)
						{
							floatNotify.simple("只能选同一家店铺商品结算！");
							return;
						}
			            
			            $(this).prev().attr("checked",true);
			            var list = $('#'+currShopId).find("li[class='list-group-item hproduct clearfix']").get();
			            var topflag=1;
			            var chooseflag=0;
			        	for(var i=0;i<list.length;i++){
			        		var selected = $(list[i]).find("div[class='icheck buy-car-check']>:checkbox").is(":checked");
			        		if(selected){
			        			chooseflag=1;
			        		}
			        		if(!selected){
			        			topflag=0;/*全部未选中*/
			        		}
			        		if(chooseflag && topflag==0){
			        			topflag=2;/*部分选中*/
			        		}
			        	}
			        	//如果全部都选中了，将全选勾选
			        	//alert(topflag);
			        	if(topflag==1)
			        	{
			        		$('#'+currShopId+' .top-ids').attr("checked", true);
			        		checkShopFlag=1;
			        	}
			        	
			        	//部分勾选
			        	if(topflag==2)
			        	{
			        		checkShopFlag=2;
			        	}
			        	
				        checkShopList=currShopId;
			        }
			    	
			      //计算总价
				  calculateTotal();
			    });
				
			}else if(data.rspCode=="100001"){
				window.location = "pages/Login/userLogin.jsp";
			}else{
				$("#rowcar").html(""); 
				$("#ListTotal").val(1);
				$("#curPageNO").val(1);
				GoodsList+='<div class="notice-search">';
				GoodsList+='<div class="ns-wrap clearfix info">';
				GoodsList+='<div class="ns-content">';
				GoodsList+='<span>购物车空空如也，快去购物吧!</span>';
				GoodsList+='</div></div></div>';
				$("#rowcar").html(""); 
				$("#rowcar").html(GoodsList);
			}
		},"json");

}


function appendBuyCarInfo(){
	
	//shopList ='';
	var GoodsList='';
	var keyword=$("#keyword").val();
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
	$.post('BuyCar/GetBuyCarListByBuyer.action',param,function(data){
		//alert(JSON.stringify(data));
			if(data.rspCode=="000000"){
				var len = data.result.length;
				var num= len < data.offset ? len :data.offset;
				var total = data.pageCount;
				var curPageNO = data.start;
				
				$("#ListTotal").val(total);
				$("#curPageNO").val(curPageNO);
				for(var j=0;j<num;j++){
					goods = data.result[j];
					genGoodsInfo(goods,data.result);
			    }
				
				$(".shopcheckLabel").click(function(){
					var currShopId = $(this).prev().attr('itemkey');
			    	var flag = $(this).prev().is(':checked');
			    	if(flag){
			            $(this).prev().attr("checked",false);
			            $('#'+currShopId+' .ids').attr("checked", false);
			            checkShopFlag=0;
			            checkShopList='';
			        }else{
			        	if(checkShopFlag==1||checkShopFlag==2||checkShopFlag==3)
						{
							floatNotify.simple("只能选一家店铺商品结算！");
							return;
						}
			            $(this).prev().attr("checked",true);
			            $('#'+currShopId+' .ids').attr("checked", true);
			            checkShopFlag=1;
			            checkShopList=currShopId;
			        }
				     //计算总价
				     calculateTotal();
			    });
				//勾选
			    $(".checkLabel").click(function(){
			    	var flag = $(this).prev().is(':checked');
			    	var currShopId=$(this).prev().attr('shopId');
			    	//var result=$(this).prev().attr('itemkey').split(",");
			    	//var currShopId = result[0];
			    	//var currGoods = result[1];
			    	//alert(currShopId);
			    	if(flag){
			            $(this).prev().attr("checked",false);
			            $('#'+currShopId+' .top-ids').attr("checked", false);
			            
			            var list = $('#'+currShopId).find("li[class='list-group-item hproduct clearfix']").get();
			            var topflag=1;
			            var chooseflag=0;
			        	for(var i=0;i<list.length;i++){
			        		var selected = $(list[i]).find("div[class='icheck buy-car-check']>:checkbox").is(":checked");
			        		if(selected){
			        			chooseflag=1;
			        		}
			        		if(!selected){
			        			topflag=0;/*全部未选中*/
			        		}
			        		if(chooseflag && topflag==0){
			        			topflag=2;/*部分选中*/
			        		}
			        	}
			        	
			        	if(topflag==0 && checkShopList==currShopId)
			        	{
			        		checkShopList='';
			        		checkShopFlag=0;
			        	}else if(topflag==2)
			        	{
			        		checkShopFlag=3;
			        	}
			        	//alert(checkShopList+','+checkShopFlag);
			        	
			        }else{
			        	/*选中列表里不包含当前选中店铺并且选中店铺标志为所有商品*/
			        	//alert('a='+checkShopList+',b='+currShopId+',c='+checkShopFlag);
			            if(checkShopList!=currShopId&&checkShopFlag==1)
						{
							floatNotify.simple("只能选同一家店铺商品结算！");
							return;
						}
			            /*选中列表里不包含当前选中店铺并且选中店铺标志为部分商品*/
			            if(checkShopList!=currShopId&&checkShopFlag==2)
						{
							floatNotify.simple("只能选同一家店铺商品结算！");
							return;
						}
			            /*选中列表里不包含当前选中店铺并且选中店铺标志为部分商品*/
			            if(checkShopList!=currShopId&&checkShopFlag==3)
						{
							floatNotify.simple("只能选同一家店铺商品结算！");
							return;
						}
			            
			            $(this).prev().attr("checked",true);
			            var list = $('#'+currShopId).find("li[class='list-group-item hproduct clearfix']").get();
			            var topflag=1;
			            var chooseflag=0;
			        	for(var i=0;i<list.length;i++){
			        		var selected = $(list[i]).find("div[class='icheck buy-car-check']>:checkbox").is(":checked");
			        		if(selected){
			        			chooseflag=1;
			        		}
			        		if(!selected){
			        			topflag=0;/*全部未选中*/
			        		}
			        		if(chooseflag && topflag==0){
			        			topflag=2;/*部分选中*/
			        		}
			        	}
			        	//如果全部都选中了，将全选勾选
			        	//alert(topflag);
			        	if(topflag==1)
			        	{
			        		$('#'+currShopId+' .top-ids').attr("checked", true);
			        		checkShopFlag=1;
			        	}
			        	
			        	//部分勾选
			        	if(topflag==2)
			        	{
			        		checkShopFlag=2;
			        	}
			        	
				        checkShopList=currShopId;
			        }
			    	
			      //计算总价
				  calculateTotal();
			    });
				
			}else if(data.rspCode=="100001"){
				window.location = "pages/Login/userLogin.jsp";
			}else{
				//$("#rowcar").html(""); 
				GoodsList+='<div class="notice-search">';
				GoodsList+='<div class="ns-wrap clearfix info">';
				GoodsList+='<div class="ns-content">';
				GoodsList+='<span>没有数据了!</span>';
				GoodsList+='</div></div></div>';
				$("#rowcar").html(GoodsList);
			}
		},"json");

}

var genGoodsInfo = function(goodsInfo,data){
	
	var seqid,goodsid,goodsnm,amount,shopid,imgurl,typeid,typenm,buynum,goodsurl;
	seqid = goodsInfo.seqId;
	goodsid = goodsInfo.goodsId;
	goodsnm = goodsInfo.goodsNm;
	amount  = AmtToDecimal2(goodsInfo.amount);
	shopid  = goodsInfo.shopId;
	shopnm  = goodsInfo.shopNm;
	imgurl  = goodsInfo.mainPicUrl;
	typeid =  goodsInfo.typeId;
	typenm =  goodsInfo.typeNm;
	buynum = goodsInfo.buyNum;
	goodsurl = basepath+'pages/Goods/goodsInfo.jsp?goods_id='+goodsid+'&shop_id='+shopid;
	/*如果已经存在构建商家，则返回*/
	if(isContains(shopList,shopid))
	{
		if(append==1)
		{
			var empty = $('#goodsInfo').val();
			$('#'+shopid+' li').eq(1).after(empty.template(seqid,seqid,shopid,goodsurl,imgurl,goodsurl,goodsnm,typenm,goodsid,typeid,amount,seqid,shopid,goodsid,typeid));

			//$('#'+shopid+' li').eq(1).after(empty.template(shopid,goodsid,typeid,goodsurl,imgurl,goodsurl,goodsnm,typenm,goodsid,typeid,amount,shopid,goodsid,typeid));
		}
		return;
	}
	
	shopList+=shopid+',';
	/*首先构建商家信息*/
	var empty = $('#shopInfo').val();
	$('#rowcar').append(empty.template(shopid,shopid,shopnm));
	
	/*构建商品信息，如果是同一家店铺，同时构建*/
	var len = data.length;
	var index =0;
	for(var i=0;i<len;i++)
	{
		var tempShopId = data[i].shopId;
		if(shopid==tempShopId)
		{
			seqid = data[i].seqId;
			goodsid = data[i].goodsId;
			goodsnm = data[i].goodsNm;
			amount  = AmtToDecimal2(data[i].amount);
			imgurl  = data[i].mainPicUrl;
			typeid =  data[i].typeId;
			typenm =  data[i].typeNm;
			buynum = data[i].buyNum;
			goodsurl = basepath+'pages/Goods/goodsInfo.jsp?goods_id='+goodsid+'&shop_id='+shopid;	
			var empty = $('#goodsInfo').val();
			$('#'+shopid+' li').eq(index).after(empty.template(seqid,seqid,shopid,goodsurl,imgurl,goodsurl,goodsnm,typenm,goodsid,typeid,amount,seqid,shopid,goodsid,typeid));
			index +=1;
		}
	}
}


//相加
function increase(obj){
	var _this = $(obj);
	var _count_obj=_this.prev();
	var count =Number($(_count_obj).val());
	var currShopId = $(_count_obj).attr("itemkey");
	var goods_id=$(_count_obj).attr("prodId");
//	var prod_id=$(_count_obj).attr("prodId");
//	var sku_id=$(_count_obj).attr("skuId");
	
    var _num=parseInt(count)+1;
	var re = /^[1-9]+[0-9]*]*$/;  
	if( isNaN(_num) || ! re.test(_num)) {
	 	return ;
	}else if(_num==9999){
		return;
	}
	
	//var result = changeShopCartNumber(basket_id,_num,prod_id,sku_id,1);
	var result=1;
	if(result){
		$(_count_obj).val(count*1+1);
//		var cash = $(_this).parent().parent().find("em[class='price']").html().substring(1);//单价
//		var total_cash =  $('#'+currShopId).find("em[class='red productTotalPrice']").html().substring(1);//商品小计
//
//		var e_cash = Math.round((Number(total_cash)+Number(cash)*_num)*100)/100;
//		var pos_decimal = e_cash.toString().indexOf('.');
//		if (pos_decimal < 0)
//		{
//			e_cash += '.00';
//		}
//		$('#'+currShopId).find("em[class='red productTotalPrice']").html("¥"+e_cash);
		//计算总价
		calculateTotal();
	}
	
}

//减
function disDe(obj){
	var _this = $(obj);
	var _count_obj=_this.next();
	var count =Number($(_count_obj).val());
	var currbuyCarId = $(_count_obj).attr("itemkey");
//	var goods_id=$(_count_obj).attr("prodId");
//	var prod_id=$(_count_obj).attr("prodId");
//	var sku_id=$(_count_obj).attr("skuId");
	var _num=parseInt(count)-1;
	
	var re = /^[1-9]+[0-9]*]*$/;  
	if( isNaN(_num) || ! re.test(_num)) {
	 	return ;
	}else if(_num==0){
		return ;
	}
	//var result = changeShopCartNumber(basket_id,_num,prod_id,sku_id,0);
	var result=1;
	if(result){
		$(_count_obj).val(count*1-1);
//		var cash = $(_this).parent().parent().prev().find("em[class='price']").html().substring(1);//单价
//		var total_cash =  $(_this).parent().prev().find("em[class='red productTotalPrice']").html().substring(1);//商品小计		
//		var e_cash = Math.round((Number(total_cash)-Number(cash))*100)/100;
//		var pos_decimal = e_cash.toString().indexOf('.');
//		if (pos_decimal < 0)
//		{
//			e_cash += '.00';
//		}
//		$(_this).parent().prev().find("em").html("¥"+e_cash);
		
		//计算总价
		calculateTotal();
	}
}
//更新购物车商品数量
function changeShopCartNumber(BuyCarOrder){
	
	var param = {
		 	'BuyCarOrder':BuyCarOrder,
		 	'channel':wapChannel	
 	};
	$.post('BuyCar/ChangeBuyCarNum.action',param,function(data){
	//	alert(JSON.stringify(data));
		if(data.rspCode=="000000"){
			var seqList = data.objs;
			window.location = "pages/Order/confirmCarOrder.jsp?seqList="+seqList;
			return;
		}else if(data.rspCode=="100001"){
			window.location = "pages/Login/userLogin.jsp";
		}else{
			floatNotify.simple("网络错误！");
			return false;
		}
	},"json");
	
//	var config = false;
//	$.ajax({
//		url: contextPath+"/changeShopCartNum", 
//		data: {"num":_num,"basketId":_basketId,"prodId":_prodId,"skuId":_skuId,"type":type},
//		type:'post', 
//		async : false, //默认为true 异步   
//		dataType : 'json', 
//		error:function(data){
//		},  
//		success:function(result){
//			if(result.status=="OK"){
//				config = true;
//			}else if(result.fail=="RESTRICTION"){
//				floatNotify.simple("超出购买限制");
//			}else if(result.fail=="ERR"){
//				floatNotify.simple("更新失败");
//			}else if(result.fail=="PROD_RESTRICTION"){
//				floatNotify.simple("商品超出购买限制");
//			}else if(result.fail=="PARAM_ERR"){
//				floatNotify.simple("参数有误");
//			}
//		}
//	});
//	return config;
}

////更新购物车商品数量
//function changeShopCartNumber(_basketId,_num,_prodId,_skuId,type){
//	
//	
//	var config = false;
//	$.ajax({
//		url: contextPath+"/changeShopCartNum", 
//		data: {"num":_num,"basketId":_basketId,"prodId":_prodId,"skuId":_skuId,"type":type},
//		type:'post', 
//		async : false, //默认为true 异步   
//		dataType : 'json', 
//		error:function(data){
//		},  
//		success:function(result){
//			if(result.status=="OK"){
//				config = true;
//			}else if(result.fail=="RESTRICTION"){
//				floatNotify.simple("超出购买限制");
//			}else if(result.fail=="ERR"){
//				floatNotify.simple("更新失败");
//			}else if(result.fail=="PROD_RESTRICTION"){
//				floatNotify.simple("商品超出购买限制");
//			}else if(result.fail=="PARAM_ERR"){
//				floatNotify.simple("参数有误");
//			}
//		}
//	});
//	return config;
//}

//计算总价
function calculateTotal(){
	
	var allCash = 0;
	var currShopId = checkShopList;
	var list = $('#'+currShopId).find("li[class='list-group-item hproduct clearfix']").get();
	var allCash = 0;
	for(var i=0;i<list.length;i++){
		var selected = $(list[i]).find("div[class='icheck buy-car-check']>:checkbox").is(":checked");
		if(selected){
			var cash = $(list[i]).find("em[class='price']").html().substring(1);//取单价
			var count = $(list[i]).find("input[class='btn gary2 Amount']").val();//取数量
			allCash += Number(cash)*Number(count);
		}
	}
	allCash = Math.round(Number(allCash)*100)/100;
	var pos_decimal = allCash.toString().indexOf('.');
	if (pos_decimal < 0)
	{
		allCash += '.00';
	}
	$("#totalPrice").html(allCash);
}

//删除购物车商品
function deleteShopCart(goodsId,typeId){
	
	var param = {
		 	'goodsId':goodsId,
		 	'typeId':typeId,
		 	'channel':'1'
 	};
	$.post('BuyCar/DelGoodsInBuyCar.action',param,function(data){
//		alert(JSON.stringify(data));
		if(data.rspCode=="000000"){
			floatNotify.simple("购物车删除成功！");
			sendData();
		}else if(data.rspCode=="100001"){
			window.location = "pages/Login/userLogin.jsp";
			return ;
		}else{
			floatNotify.simple("网络错误！");
			return false;
		}
	},"json");
	
	//function deleteShopCart(_basketId,_basketName,_prodId,_skuId){	
//	if(confirm("删除后不可恢复, 确定要删除'"+_basketName+"'吗？")){
//		$.ajax({
//			url: contextPath+"/deletShopCart", 
//			data: {"basket_id":_basketId,"prod_id":_prodId,"sku_id":_skuId},
//			type:'post', 
//			async : true, //默认为true 异步   
//			dataType : 'json', 
//			error:function(data){
//			},   
//			success:function(data){
//				if(data=="OK"){
//					window.location.href= contextPath + "/shopcart";
//					return ;
//				}else{
//					floatNotify.simple("删除失败");
//					return false;
//				}
//				
//			}   
//		});         
//	} 
}


function submitShopCart(){
	var array = $(".ids:checked").get();
	if(array.length==0){
		floatNotify.simple("请选择要结算的商品");
		return;
	}
	
    var shopCartStr = "[";
	for(var i in array){
		if(i!=0){
			shopCartStr =shopCartStr+",";
		}
		var seq_id = $(array[i]).attr("itemkey");
		var count =Number($("#"+seq_id).find("input[class='btn gary2 Amount']").val());
		shopCartStr +='{"seqId":"'+seq_id+'","buyNum":'+count+'}';
		//shopCartStr=shopCartStr + basket_id;
	}
	shopCartStr+=']';
	//alert(shopCartStr);
	changeShopCartNumber(shopCartStr);
	//调用方法  
	//abstractForm(contextPath+'/p/orderDetails', shopCartStr);
}

function abstractForm(URL, shopCartIds){
	   var temp = document.createElement("form");        
	   temp.action = URL;        
	   temp.method = "post";        
	   temp.style.display = "none";        
	   var opt = document.createElement("textarea");        
	   opt.name = 'shopCartItems';        
	   opt.value = shopCartIds;        
	   temp.appendChild(opt);        
	   document.body.appendChild(temp);        
	   temp.submit();        
	   return temp;  
}