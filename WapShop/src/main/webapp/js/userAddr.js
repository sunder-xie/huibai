var basepath=null; /*根目录*/
var startpagenum =1;
var offset =10;
var CarIdList='';
var chooseflag =0;/*存放跳转类型*/
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
	
});


var setAllDomain = function(){
	basepath='';
	$("#curPageNO").val(1);
	chooseflag = getQueryStringByName("flag");
	if(chooseflag==1)
	{
		CarIdList = getQueryStringByName('seqList');
	}
	if(chooseflag==1)
	{
		
	}
}

function sendData(){
	$('#ajax_loading').show();
	getAddrInfo();
	$('#ajax_loading').hide();
}

function appendData(){
	
	$('#ajax_loading').show();
	appendAddrInfo();
	$('#ajax_loading').hide();
}

function getAddrInfo(){
	
	var map={
			  
	};
	var startPageNo = $("#curPageNO").val();
	var param = {
			start:startPageNo,
			offset:offset,			
			conditions:map
	};
	//alert(JSON.stringify(param));
	var url =basepath+ "Address/GetAddressInfo.action";
	$.post(url,param,function(data){
		//alert(JSON.stringify(data));
		if(data.rspCode=="000000"){
			var len = data.result.length;
			var num= len < data.offset ? len :data.offset;
			var total = data.pageCount;
			var curPageNO = data.start;
			$("#address").html(""); 
			for(var i=0;i<num;i++)
			{
				var addr= data.result[i];
				var addrId = addr.addrId;
				var address = addr.provice + addr.city + addr.zone + addr.address;
				var mobile = addr.mobile;
				var consignee = addr.consignee;
				var empty = $('#addr').val();
				$('#address').append(empty.template(addrId,mobile,consignee,address));
			}
			$("#ListTotal").val(total);
			$("#curPageNO").val(curPageNO);
		}else if(data.rspCode=="100001"){
			window.location = "pages/Login/userLogin.jsp";
		}else{
		}
	},"json");
}

function appendAddrInfo(){
	
	var map={
			  
	};
	var startPageNo = $("#curPageNO").val();
	var param = {
			start:startPageNo,
			offset:offset,			
			conditions:map
	};
	//alert(JSON.stringify(param));
	var url =basepath+ "Address/GetAddressInfo.action";
	$.post(url,param,function(data){
	//	alert(JSON.stringify(data));
		if(data.rspCode=="000000"){
			var len = data.result.length;
			var num= len < data.offset ? len :data.offset;
			var total = data.pageCount;
			var curPageNO = data.start;
			for(var i=0;i<num;i++)
			{
				var addr= data.result[i];
				var addrId = addr.addrId;
				var address = addr.provice + addr.city + addr.zone + addr.address;
				var mobile = addr.mobile;
				var consignee = addr.consignee;
				var empty = $('#addr').val();
				$('#address').append(empty.template(addrId,mobile,consignee,address));
			}
			$("#ListTotal").val(total);
			$("#curPageNO").val(curPageNO);
		}else if(data.rspCode=="100001"){
			window.location = "pages/Login/userLogin.jsp";
		}else{
		}
	},"json");
}

function chooseAddr(addrId){
	if(chooseflag==1)
	{
		var param ='seqList='+CarIdList+'&&addrId='+addrId;
		var url= 'pages/Order/orderByCar.jsp?'+param;
		window.location = url;
	}
}
