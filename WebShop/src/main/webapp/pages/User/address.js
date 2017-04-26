var basepath=null; /*根目录*/
var user_id = null ;/*用户编号*/
var startpagenum =1;
var offset =10;

$(function(){
    setAllDomain();
    getUserMenu(basepath,user_id);
    getUserAddr(startpagenum,offset);
});
 
var setAllDomain = function(){
	basepath=getRootPath();	
	user_id =$("#LoginUser").attr('loginUserId');
}

$(function($) {
    $('.data-table').on('click', '.delete', function() {
       var a = $(this).parents('tr').data('id'); 
//       alert(a);
	   if(window.confirm("确认删除该地址？")) {
	   var url =basepath+ "Address/AddressDel.action";
		var param = {
				addrId:a
				};
		$.post(url,param,function(data){
			if("000000"==data.rspCode) {
				getUserAddr(startpagenum,offset);
				
			} else {
				alert(data.rspMsg);
			}
		},"json");
	   }
       
    });
    
    $('.data-table').on('click', '.modify', function() {
       var a = $(this).parents('tr').data('id'); 
        $('#modifyhtml').css("display","block");
	   	$('#addhtml').css("display","none");
	   	$('#addrlist').css("display","none");
	   	var url =basepath+ "Address/GetAddressInfoByAddrId.action";
		var param = {
				addrId:a
				};
		$.post(url,param,function(data){
//			alert(JSON.stringify(data));
			if("000000"==data.rspCode) {
				var provt = data.objs[0].provice;
				var cityt = data.objs[0].city;
				var distt = data.objs[0].zone;
				
				if(distt =='0')
				{
					$("#modifyselect").citySelect({
				       	prov:provt, 
				       	city:cityt,
				       	nodata:"none"
				   	}); 
					$("#modifydist").css('disabled',"disabled");
				}
				else
				{
					$("#modifyselect").citySelect({
				       	prov:provt, 
				       	city:cityt,
				   		dist:distt,
				   		nodata:"none"
				   	}); 
				}
				$("#addrId_m").val(data.objs[0].addrId);
				$("#address_m").val(data.objs[0].address);
				$("#consignee_m").val(data.objs[0].consignee);
				$("#phoneNum_m").val(data.objs[0].mobile);
				
				var ismain =document.getElementById('isDefault_m');
				
				if(data.objs[0].isMain=='Y')
				{
					ismain.checked =true;
				}
				else
    			{
					ismain.checked =false;
    			}
			} else {
				alert(data.rspMsg);
			}
		},"json");
		
	   
    });
    
    $('.data-table').on('click', '.default', function() {
       var a = $(this).parents('tr').data('id'); 
       var url =basepath+ "Address/AddressSetDefault.action";
		var param = {
				addrId:a
				};
		$.post(url,param,function(data){
			if("000000"==data.rspCode) {
				getUserAddr(startpagenum,offset);
			} else {
				alert(data.rspMsg);
			}
		},"json");
    });

});

var getUserAddr=function(pagenumber,offsize){
	
	var map={
	  
	};
	var param = {
		start:pagenumber,
		offset:offsize,			
		conditions:map
	};
		
	var url =basepath+ "Address/GetAddressInfo.action";
	
	$.post(url,param,function(data){
//		alert(JSON.stringify(data));
		if("000000"==data.rspCode) {
		var datatable='';
	    var num= data.result.length < data.offset ? data.result.length :data.offset;
//	    alert(num);
		for (var i=0;i<num;i++)
		{
			var addrId= data.result[i].addrId;
			var name = data.result[i].consignee;
			var addr1='';
			if(data.result[i].zone=='0')
			{
				addr1=data.result[i].provice+data.result[i].city;
			}
			else
			{
				addr1=data.result[i].provice+data.result[i].city+data.result[i].zone;
			}
			var addr2= data.result[i].address;
			var mobile = data.result[i].mobile;
			var isMain = data.result[i].isMain;
			datatable+='<tr data-id="'+addrId+'" style="display: table-row; opacity: 1;" class="">';
			datatable+= '<td>'+name+'</td>';
			datatable+= '<td>'+addr1+'</td>';
			datatable+= '<td>'+addr2+'</td>';
			datatable+= '<td>'+mobile+'</td>';
			datatable+= '<td class="add">';
			datatable+= '<a href="javascript:;" class="modify">修改</a>';
			datatable+= '<a href="javascript:;" class="delete">删除</a>';
			if(isMain=='Y')
			{
				datatable+= '<a href="javascript:;" class="isDefault">默认地址</a>';
			}
			else
			{
				datatable+= '<a href="javascript:;" class="default">设为默认</a>';
			}
			
			datatable+= '</td>';
			datatable+= '</tr>';
	    }
		
		$("#data-table-body").html(datatable);
		$("#J_bottomPage").pager({ pagenumber: pagenumber, pagecount:data.pageCount,totalcount:data.total, buttonClickCallback: PageClick});  

		} else {
			datatable+= '<tr><td ></td><td >还没有地址信息！</td></tr>';
			
			$("#data-table-body").html(datatable);
		}
	},"json");
	
}

//回调函数  
PageClick = function(pageclickednumber) {  
	getUserAddr(pageclickednumber,offset);  
}  

var addAddress=function(){
	$('#addhtml').css("display","block");
	$('#modifyhtml').css("display","none");
	$('#addrlist').css("display","none");
	$("#addselect").citySelect({
		nodata:"none",
		required:false
	}); 
	$("#address").val('');
	$("#consignee").val('');
	$("#phoneNum").val('');
}

$(".btn-g").bind('click',function(e){
	$('#modifyhtml').css("display","none");
	$('#addhtml').css("display","none");
	$('#addrlist').css("display","block");
});

function showInfos(str){
	$("#common_errors").html(str);
	$("#common_errors").slideDown();
	setTimeout(hiddenUserRegTips,3000);
}
function hiddenUserRegTips(){
	$("#common_errors").slideUp();
}
$(".addconfirm").bind('click',function(e){
	
	var prov=$("#addprov option:selected").val(); 

	if(prov=='')
	{	showInfos("请选择省份！");
		$("#addprov").focus;
		return;
	}
	var city=$("#addcity option:selected").val(); 
	if(city=='')
	{	showInfos("请选择城市！");
		$("#addcity").focus;
		return;
	}
	var dist='';
	if($("#adddist").is(":disabled"))	
	{
		dist='0';
	}else
	{
		dist=$("#adddist option:selected").val(); 
		if(dist=='')
		{	showInfos("请选择区县！");
			$("#addcity").focus;
			return;
		}
	}
	
	var addr = $('#address').val();
	if(addr=='')
	{	showInfos("请输入详细地址！");
		$("#addr").focus;
		return;
	}
	var person = $('#consignee').val();
	if(person=='')
	{	showInfos("请输入收件人！");
		$("#person").focus;
		return;
	}
	var mobil=  $('#phoneNum').val();
	if(mobil=='')
	{	showInfos("请输入联系人！");
		$("#mobil").focus;
		return;
	}
	
	var ismain =document.getElementById('isDefault');
	var mainFlag ='';
	if(ismain.checked)
	{
		mainFlag='Y';
	}
	else
	{
		mainFlag='N';
	}
	
	var url =basepath+ "Address/AddressAdd.action";
	var param = {
			provice:prov,
			city:city,
			zone:dist,
			address:addr,
			consignee:person,
			mobile :mobil,
			isMain:mainFlag
			};
	
	//alert(JSON.stringify(param));
	$.post(url,param,function(data){
		if("000000"==data.rspCode) {
			$('#modifyhtml').css("display","none");
			$('#addhtml').css("display","none");
			$('#addrlist').css("display","block");
			getUserAddr(startpagenum,offset);
		} else {
			alert(data.rspMsg);
		}
	},"json");
});


$(".confirm_modify").bind('click',function(e){
	
	var prov=$("#modifyprov option:selected").val(); 
	if(prov=='')
	{	showInfos("请选择省份！");
		$("#modifyprov").focus;
		return;
	}
	var city=$("#modifycity option:selected").val(); 
	if(city=='')
	{	showInfos("请选择城市！");
		$("#modifycity").focus;
		return;
	}
	var dist='';
	if($("#modifydist").is(":disabled"))	
	{
		dist='0';
	}else
	{
		dist=$("#modifydist option:selected").val(); 
		if(dist=='')
		{	showInfos("请选择区县！");
			$("#modifydist").focus;
			return;
		}
	}
	var addrid = $('#addrId_m').val();
	var addr = $('#address_m').val();
	if(addr=='')
	{	showInfos("请输入详细地址！");
		$("#address_m").focus;
		return;
	}
	var person = $('#consignee_m').val();
	if(person=='')
	{	showInfos("请输入收件人！");
		$("#consignee_m").focus;
		return;
	}
	var mobil=  $('#phoneNum_m').val();
	if(mobil=='')
	{	showInfos("请输入联系人！");
		$("#phoneNum_m").focus;
		return;
	}
	
	var ismain =document.getElementById('isDefault_m');
	if(ismain.checked)
	{
		ismain='Y';
	}
	else
	{
		ismain='N';
	}
	
	var url =basepath+ "Address/UpdateAddressInfo.action";
	var param = {
			addrId:addrid,
			provice:prov,
			city:city,
			zone:dist,
			address:addr,
			consignee:person,
			mobile :mobil,
			isMain:ismain
			};
//	alert(JSON.stringify(param));
	$.post(url,param,function(data){
		if("000000"==data.rspCode) {
			$('#modifyhtml').css("display","none");
			$('#addhtml').css("display","none");
			$('#addrlist').css("display","block");
			getUserAddr(startpagenum,offset);
		} else {
			alert(data.rspMsg);
		}
	},"json");
});
function transferStr(value) {
	return value == null ? "" : value;
}
