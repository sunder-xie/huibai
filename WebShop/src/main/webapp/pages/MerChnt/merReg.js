var basepath=null; /*根目录*/
var user_id = null;
var shop_id = null;
var setAllDomain = function(){
	basepath=getRootPath();	
	user_id =$("#LoginUser").attr('loginUserId');
	
	$.datepicker.setDefaults($.datepicker.regional['zh-CN']);
	var dates = $('#startTime,#endTime,#BuildTime').datepicker({
		dateFormat: 'yy-mm-dd',
//		onSelect: function(selectedDate) {
//			var option = this.id == "startTime" ? "minDate" : "maxDate";
//			var instance = $(this).data("datepicker");
//			var date = $.datepicker.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings);
//			dates.not(this).datepicker("option", option, date);
//		},
		maxDate:'2099-1-1',
		changeMonth: true,
		changeYear: true
	});
	
}

var CheckRegStep = function(){
	var param = {
		userId:user_id
	};
//	alert(JSON.stringify(param));
	var url =basepath+'EnterStep/GetEnterStepInfo.action';
    $.post(url,param,function(data){
	// alert(JSON.stringify(data));
		if(data.rspCode=="000000"){
			var len =data.objs.length;
			var status=data.objs[0].enterSta;
			if(status=='2')
			{
				goToMerCenter();
				return;
			}
			var enterId =data.objs[0].enterId;
			var stepId = data.objs[0].stepId;
			var userId = data.objs[0].userId;
			var enterType = data.objs[0].enterType;
			
			var stepId =Number(stepId)-1;
			$("#regflow").attr('reg-flow','1');
			$("#regflow").attr('enter-id',enterId);
			$("#regflow").attr('enter-type',enterType);
			
			$(".reg_item_1").slideToggle();
			$(".reg_item_"+stepId).slideToggle();
			
			$(".badge").removeClass("badge-info");
			$(".badge").addClass("badge-default");
			$("#item_"+stepId).children("span").removeClass("badge-default");
			$("#item_"+stepId).children("span").addClass("badge-info");
			
//			alert(stepId);
			if(stepId==2)/*店铺信息*/
			{
				getRegShopInfo();
			}else if(stepId==3)/*企业信息*/
			{
				getRegEpriseInfo();
			}
			
		}else if(data.rspCode=="000002"){
				/*未找到*/
		}else{
			
		}
    },"json");
}

var getRegEpriseInfo = function(){
	
	var param = {
			userId:user_id
	};

	var url = basepath+'Eprise/GetRegEpriseInfo.action';
    $.post(url,param,function(data){
//			alert(JSON.stringify(data));
	if(data.rspCode=="000000"){
		var epriseIdVal = data.objs[0].epriseId;
		
		var epriseNmVal = data.objs[0].epriseNm;
		var LicenseIdVal = data.objs[0].licNo;
		var BuildTimeVal = formatStringyyyyMMddToyyyy_MM_dd(data.objs[0].buildDt);
		var BusTimeVal = data.objs[0].busiDt.split('-');
		var startTimeVal = formatStringyyyyMMddToyyyy_MM_dd(BusTimeVal[0]);
		var endTimeVal = formatStringyyyyMMddToyyyy_MM_dd(BusTimeVal[1]);
		var busiDtVal = data.objs[0].busiDt;
		var legalVal = data.objs[0].legal;
		var epriseTelVal = data.objs[0].epriseTel;
		var businessVal = data.objs[0].business;
		
		$("#epriseId").val(epriseIdVal);
		$("#epriseNm").val(epriseNmVal);
		$("#LicenseId").val(LicenseIdVal);
		$("#BuildTime").val(BuildTimeVal);
		$("#startTime").val(startTimeVal);
		$("#endTime").val(endTimeVal);
		$("#legal").val(legalVal);
		$("#epriseTel").val(epriseTelVal);
		$("#business").val(businessVal);
	}else{
		//alert(22);
	}	
    },"json");
}

var getRegShopInfo = function(){
	var param = {userId:user_id};
//	alert(JSON.stringify(param));
    $.post(basepath+'Shop/GetRegShopInfo.action',param,function(data){
//	alert(JSON.stringify(data));
	if(data.rspCode=="000000"){
		var shopIdVal = data.objs[0].shopId;
		var shopNmVal = data.objs[0].shopNm;
		var shopSalesVal = data.objs[0].sales;
		var shopAddrVal = data.objs[0].address;
		var shopTelVal = data.objs[0].shopTel;
		var shopContVal = data.objs[0].content;
		
		$("#shopId").val(shopIdVal);
		$("#shopNm").val(shopNmVal);
		$("#shopSales").val(shopSalesVal);
		$("#shopAddr").val(shopAddrVal);
		$("#shopTel").val(shopTelVal);
		$("#shopCont").val(shopContVal);
	}else{
	}
    },"json");
}	
var CheckRegMer = function(){
	var param = {
		userId:user_id
	};
//	alert(JSON.stringify(param));
	var url =basepath+'Shop/GetShopInfoByUserId.action';
    $.post(url,param,function(data){
//		alert(JSON.stringify(data));
		if(data.rspCode=="000000"){
			goToMerCenter();
		}else{
			CheckRegStep();
		}
    },"json");
}

$(function(){
	setAllDomain();
	
	/*增加判断是否注册过商家*/
	CheckRegMer();
	
	$("#RegistrationAgreement_btn").click(function(){
		
		if($('#regflow').attr("reg-flow")=='0')
		{
			var param = {
					userId:user_id,
					entryType:'1',
					stepId:'2',
					stepDesc:'填写店铺信息'
				};
		    var url =basepath+'EnterStep/SaveEnterStepInfo.action';
			$.post(url,param,function(data){
				if(data.rspCode=="000000"){
					var enterId =data.objs.enterId;
					var enterType = data.objs.enterType;
					$("#regflow").attr('reg-flow','1');
					$("#regflow").attr('enter-id',enterId);
					$("#regflow").attr('enter-type',enterType);
					
					$("#RegistrationAgreement_btn").parents(".item").slideToggle();
					$("#RegistrationAgreement_btn").parents(".item").next().slideToggle();
					var step = $("#RegistrationAgreement_btn").data("nextitem");
					$(".badge").removeClass("badge-info");
					$(".badge").addClass("badge-default");
					$("#"+step).children("span").removeClass("badge-default");
					$("#"+step).children("span").addClass("badge-info");
				}else{
					showInfos(data.rspMsg);
				}
			});
		}
		else
		{
			$("#RegistrationAgreement_btn").parents(".item").slideToggle();
			$("#RegistrationAgreement_btn").parents(".item").next().slideToggle();
			var step = $("#RegistrationAgreement_btn").data("nextitem");
			$(".badge").removeClass("badge-info");
			$(".badge").addClass("badge-default");
			$("#"+step).children("span").removeClass("badge-default");
			$("#"+step).children("span").addClass("badge-info");
		}
		
	});
	
	$("#BackReadRegAgreement").click(function(){
		$(this).parents(".item").slideToggle();
		$(this).parents(".item").prev().slideToggle();
		var step = $("#RegistrationAgreement_btn").data("lastitem");
		/* alert(step); */
		$(".badge").removeClass("badge-info");
		$(".badge").addClass("badge-default");
		$("#"+step).children("span").removeClass("badge-default");
		$("#"+step).children("span").addClass("badge-info");
	});
	
	$("#submitShopBtn").click(function(){
		var shopNmVal = $("#shopNm").val();
		var shopSalesVal = $("#shopSales").val();
		var shopAddrVal = $("#shopAddr").val();
		var shopTelVal = $("#shopTel").val();
		var shopContVal = $("#shopCont").val();
		if(shopNmVal==""){
			showInfos("店铺名称为空！");
			$("#shopNm").focus;
			return;
		}
		if(shopSalesVal==""){
			showInfos("店铺主营为空！");
			$("#shopSales").focus;
			return;
		}
		if(shopAddrVal==""){
			showInfos("店铺所在地为空！");
			$("#shopAddr").focus;
			return;
		}
		if(shopTelVal==""){
			showInfos("客服电话为空！");
			$("#shopTel").focus;
			return;
		}
		if(shopContVal==""){
			showInfos("店铺简介为空！");
			$("#shopCont").focus;
			return;
		}
		
		
		var url = '';
		var shopIdVal = $("#shopId").val();
		var enterType = $("#regflow").attr('enter-type');
		var enterId=$("#regflow").attr('enter-id');
		if($('#regflow').attr("reg-flow")=='1' && !isNull(shopIdVal))
		{
			var param = {
					shopId:shopIdVal,
					shopNm:shopNmVal,
					sales:shopSalesVal,
					address:shopAddrVal,
					shopTel:shopTelVal,
					content:shopContVal
			};
			url = basepath+'Shop/UpdateEnterShopInfo.action?userId='+user_id+'&&enterType='+enterType+'&&enterId='+enterId;
		}
		else
		{
			var param = {
					shopNm:shopNmVal,
					sales:shopSalesVal,
					address:shopAddrVal,
					shopTel:shopTelVal,
					content:shopContVal
			};
			url = basepath+'Shop/ShopRegister.action?userId='+user_id+'&&enterType='+enterType+'&&enterId='+enterId;
		}
		/* alert(JSON.stringify(param));*/
//		alert(url); 
		$.post(url,param,function(data){
			//alert(JSON.stringify(data));
			if(data.rspCode=="000000"){
				var shopIdVal = data.objs.shopId;
				$("#shopId").val(shopIdVal);
				$("#submitShopBtn").parents(".item").slideToggle();
				$("#submitShopBtn").parents(".item").next().slideToggle();
				var step = $("#submitShopBtn").data("nextitem");
				$(".badge").removeClass("badge-info");
				$(".badge").addClass("badge-default");
				$("#"+step).children("span").removeClass("badge-default");
				$("#"+step).children("span").addClass("badge-info");
			}else{
				showInfos(data.rspMsg);
			}
		},"json");
	});
	
	
	$('#JumpMerCenter').on('click',function() {
		goToMerCenter();
	});
	
	$("#ModifyShopInfo").click(function(){
		if($('#regflow').attr("reg-flow")=='1')
		{
			getRegShopInfo();
		}
		
		$(this).parents(".item").slideToggle();
		$(this).parents(".item").prev().slideToggle();
		var step = $(this).data("lastitem");
		/* alert(step); */
		$(".badge").removeClass("badge-info");
		$(".badge").addClass("badge-default");
		$("#"+step).children("span").removeClass("badge-default");
		$("#"+step).children("span").addClass("badge-info");
		
	});
	
	$("#submitEpriseBtn").click(function(){
		
			var epriseNmVal = $("#epriseNm").val();
			var LicenseIdVal = $("#LicenseId").val();
			var BuildTimeVal = $("#BuildTime").val().replace(/\-/g,'');
			var startTimeVal = $("#startTime").val().replace(/\-/g,'');
			var endTimeVal = $("#endTime").val().replace(/\-/g,'');
			var legalVal = $("#legal").val();
			var epriseTelVal = $("#epriseTel").val();
			var businessVal = $("#business").val();
			if(epriseNmVal==""){
				showInfos("企业名称为空！");
				$("#epriseNm").focus;
				return;
			}
			if(LicenseIdVal==""||LicenseIdVal.length>18){
				showInfos("营业执照编号为空或者大于18位长度");
				$("#LicenseId").focus;
				return;
			}
			if(BuildTimeVal==""){
				showInfos("成立时间为空！");
				$("#BuildTime").focus;
				return;
			}
			if(startTimeVal==""){
				showInfos("开始时间为空！");
				$("#startTime").focus;
				return;
			}
			if(endTimeVal==""){
				showInfos("结束时间为空！");
				$("#endTime").focus;
				return;
			}
			if(legalVal==""){
				showInfos("企业法人为空！");
				$("#legal").focus;
				return;
			}
			if(epriseTelVal==""){
				showInfos("联系电话为空！");
				$("#epriseTel").focus;
				return;
			}
			if(businessVal==""){
				showInfos("经营范围为空！");
				$("#business").focus;
				return;
			}
			
			var url = '';
			var busiDtVal =startTimeVal+'-'+endTimeVal;
			var epriseIdVal = $("#epriseId").val();
			var shopIdVal = $("#shopId").val();
			if($('#regflow').attr("reg-flow")=='1' && !isNull(epriseIdVal))
			{
				var param = {
						epriseId:epriseIdVal,
						epriseNm:epriseNmVal,
						licNo:LicenseIdVal,
						BuildDt:BuildTimeVal,
						busiDt:busiDtVal,
						legal:legalVal,
						epriseTel:epriseTelVal,
						business:businessVal
				};
				url = basepath+'Eprise/UpdateEpriseInfo.action?userId='+user_id+'&&shopId='+shopIdVal;
			}
			else
			{
				var param = {
						epriseNm:epriseNmVal,
						licNo:LicenseIdVal,
						BuildDt:BuildTimeVal,
						busiDt:busiDtVal,
						legal:legalVal,
						epriseTel:epriseTelVal,
						business:businessVal
				};
				url = basepath+'Eprise/EpriseRegister.action?userId='+user_id+'&&shopId='+shopIdVal;
			}
//			alert(JSON.stringify(param));
//			alert(url);
			$.post(url,param,function(data){
				if(data.rspCode=="000000"){
					$("#submitEpriseBtn").parents(".item").slideToggle();
					$("#submitEpriseBtn").parents(".item").next().slideToggle();
					var step = $("#submitEpriseBtn").data("nextitem");
					$(".badge").removeClass("badge-info");
					$(".badge").addClass("badge-default");
					$("#"+step).children("span").removeClass("badge-default");
					$("#"+step).children("span").addClass("badge-info");
					setInterval(refreshSec, 1000);
					setTimeout(goToMerCenter, 5000);
				}else{
					showInfos(data.rspMsg);
				}
			},"json");
	});
	
});

function showInfos(str){
	$("#userRegTips").html("<strong>注册失败</strong>&nbsp;&nbsp;&nbsp;&nbsp;"+str);
	$("#userRegTips").slideDown();
	setTimeout(hiddenUserRegTips,3000);
}

function hiddenUserRegTips(){
	$("#userRegTips").slideUp();
}
function validTel(str){
	var reg = /^(13[0-9]|14[0-9]|15[0-9]|18[0-9])\d{8}$/;
	if (reg.test(str)) {
	      return true;
	 }else{
		  return false;
	 };
}
function validEmail(str){
	var reg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	if(reg.test(str)){
		return true;
	}else{
		return false;
	}
}


function goToMerCenter(){
	//window.location = basepath+'pages/MerChnt/MerCenter.jsp?user_id=' +user_id;
	window.location = basepath+'pages/MerChnt/MerCenter.jsp';
}
function goToHomePage(){
	window.location = basepath;
}
function refreshSec() {
	var sec = $("#second_id").html();
	$("#second_id").html((sec - 1));
}

function validBusId(val){
	if(val.length!=15){
		return false;
	}else{
		return true;
	}
}	

function validId(val){
	 var city={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江 ",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北 ",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏 ",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外 "};
        var tip = "";
        var pass= true;
        
        if(!code || !/^\d{6}(18|19|20)?\d{2}(0[1-9]|1[12])(0[1-9]|[12]\d|3[01])\d{3}(\d|X)$/i.test(code)){
            tip = "身份证号格式错误";
            pass = false;
        }
        
       else if(!city[code.substr(0,2)]){
            tip = "地址编码错误";
            pass = false;
        }
        else{
            //18位身份证需要验证最后一位校验位
            if(code.length == 18){
                code = code.split('');
                //∑(ai×Wi)(mod 11)
                //加权因子
                var factor = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 ];
                //校验位
                var parity = [ 1, 0, 'X', 9, 8, 7, 6, 5, 4, 3, 2 ];
                var sum = 0;
                var ai = 0;
                var wi = 0;
                for (var i = 0; i < 17; i++)
                {
                    ai = code[i];
                    wi = factor[i];
                    sum += ai * wi;
                }
                var last = parity[sum % 11];
                if(parity[sum % 11] != code[17]){
                    tip = "校验位错误";
                    pass =false;
                }
            }
        }
        
        return pass;

}