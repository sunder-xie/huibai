var contextPath = 'user';

$(document).ready(function(){

	if(isWeiXinBrowse())
	{
		InitHeader();
	}
	
	  //性别：单选
	  /* $("#gradenameboy").click(function(){
	        var parent = document.getElementById("gradenameboy");
	        $("#gradenameboy").removeClass("checked");
	        parent.className = parent.className + " checked";
	        $("#gradenamegirl").removeClass("checked");
	        $('#sex').val(1);
	  });
	  $("#gradenamegirl").click(function(){
	        var parent = document.getElementById("gradenamegirl");
	        $("#gradenamegirl").removeClass("checked");
	        parent.className = parent.className + " checked";
	        $("#gradenameboy").removeClass("checked");
	        $('#sex').val(0);
	  }); */
	  
	  //当光标离开 姓名时，验证姓名
	  $("#username").blur(function(){
		  checkName();
	  });
	  
	  //当光标离开 手机时，验证手机
	  $("#mobile").blur(function(){
		  checkPhone();
	  });
	  
	//当光标离开 密码时，验证密码
	  $("#password").blur(function(){
		  checkPassword();
	  });
	  
	//当光标离开 密码时，验证密码
	  $("#repassword").blur(function(){
		  checkRePassword();
	  });
	  
	  //获取手机验证码
	  $('.get_mobile_code').click(function(){
		  //var randNum = $("#randNum").val();
		  var _this = this;
		  
	      if(checkPhone()){
	    	  var param ={
	    			  'username':$("#username").val(),
	    			  'telphone':$("#mobile").val()
	    	  }
	    	  $.post("Sms/SendRegSms.action",param,function(data){
	    		  //alert(JSON.stringify(data));
					if(data.rspCode=="000000"){
						var smsid = data.objs;
						//alert(smsid);
						$("#sms_id").val(smsid)
						mycountDown(_this,60);
					}else{
						floatNotify.simple('发送验证码失败，请重试！');
					}
				},"json");
		}
	      
	      /* if(checkPhone()){
	        	if(validateRandNum(contextPath)){
	      	  $.ajax({
	      			url: contextPath + "/sendSMSCode", 
	      			data:{"userName":$("#username").val(),"mobile":$("#mobile").val(),"randNum":randNum},
	      			type:'post', 
	      			dataType : 'json', 
	      			async : false,   
	      			error: function(jqXHR, textStatus, errorThrown) {
	      		 		alert(textStatus, errorThrown);
	      			},
	      			success:function(retData){		
	      				if(retData=="OK"){
	  	    		    	mycountDown(_this,60);
	      				}else{
	  						alert("图形验证码不正确");    					
	      				}
	      			}
	      	  });
	        }
	  	} */
	 });
 
});

var InitHeader =function(){
	$('.header').hide();
}

//切换图形验证码
 function changeRandImg(contextPath){
        var obj = document.getElementById("randImage") ;
        obj.src = contextPath + "/validCoder.random?d=" + new Date();
     }
     
//验证图形验证码
function validateRandNum (contextPath){
	var checkResult = checkRandNum();
	if(!checkResult){
		 //验证失败，返回
		return checkResult;
	}
	var randNum = document.getElementById("randNum").value;
	var result = true;
		var data = {
            	"randNum": randNum
            };
	    jQuery.ajax({
			url: contextPath + "/validateRandImg", 
			type:'post', 
			data:data,
			async : false, //默认为true 异步   
		    dataType : 'json', 
			error: function(jqXHR, textStatus, errorThrown) {
			},
			success:function(retData){
				 if(!retData){
					 	result = retData;
					 	alert("图形验证码错误");
					 	document.getElementById("randNum").value="";
					 	//document.getElementById('randNum').focus() ;
					 	changeRandImg(contextPath);
				 }
			}
			});	 
	 
	 return result;
}

function checkRandNum (){
	var error;
	var inputVal = document.getElementById('randNum');
	//如果找不到对象则表示不用验证
	if(inputVal == null){
		return true;
	}
	
	if(inputVal.value==null||inputVal.value==''){
	 	alert("请输入图形验证码");
	  //inputVal.focus() ;
	  return false; //验证失败
	 }
	 if(inputVal.value.length!=4){
		 alert("请输入4位图形验证码");
		return false; //验证失败
	 }
	 return true;
}



//提交
function userReg(){
	
        var postData={};var flag = true;
        var chooseflag = false;
        chooseflag =$("input[type='checkbox']").is(':checked');
        if(chooseflag==false)
        {
        	floatNotify.simple('请同意注册协议！');
        	return;
        }
        var username = $('input[name=username]').val();
        if(checkName()){ //验证姓名
        	postData['username']=username;
        }else{
        	flag = false;
        	return;
        }
        
        if(checkPhone()){//验证手机
        	postData['telphone']=$('input[name=mobile]').val();
        }else{
        	flag = false;
        	return;
        }
        
        if(checkPassword()){//验证密码
            postData['password']=$('input[name=password]').val();
        }else{
        	flag = false;
        	return;
        }
        
//        var sex = $('input[name=sex]').val();
//        if(sex == '-1'){
//        	flag = false;
//        	floatNotify.simple('请选中性别');
//        	return;
//        }else{
//        	postData['sex'] = $('input[name=sex]').val();
//        }
//        
        postData['smsCode'] = $('input[name=mobile_code]').val();
        
        postData['smsId'] = $('input[name=sms_id]').val();
//        
//        postData['parentUserName'] = $("#parentUserName").val();
        var param = postData;
        
//        alert(JSON.stringify(param));
        
        if(flag){
        	
        	$.post("user/newUserReg.action",param,function(data){
        		
				if(data.rspCode=="000000"){
					window.location.href="pages/User/userCenter.jsp";
				}else{
					floatNotify.simple(data.rspMsg+'注册失败，请重试');
				}
			},"json");
        	
//        	$.ajax({
//    			url:contextPath+"/userReg",
//    			type:'POST',
//    			dataType:'text',
//    			data:postData,
//    			success:function(resp){
//    				if(resp=="success"){
//    					window.location.href=contextPath+"/userCenter.jsp";
//    				}else if(resp=="codeError"){
//    					//清空验证码
//    					$('input[name=mobile_code]').val("");
//    					floatNotify.simple('验证码错误');
//    				}else{
//    					floatNotify.simple('注册失败，请重试');
//    				}
//    			}
//    		});
        }
}

/**判断是否为空**/
function isBlank(_value){
	if(_value==null || _value=="" || _value==undefined){
		return true;
	}
	return false;
}

/**检查是否为手机号码形式**/
function isPhone(str){
	var mobile = /^1\d{10}$/;
	return mobile.test(str);
}

/**检查手机号码是否存在**/
function isPhoneExist(phone) {
	var result = true;
	$.ajax({
			url: contextPath + "/isPhoneExist.action", 
			data: {"telphone":phone},
			type:'post', 
			async : false, //默认为true 异步   
			dataType : 'json', 
			error: function(jqXHR, textStatus, errorThrown) {
				 //console.log(textStatus, errorThrown);
				},
			success:function(retData){
				if(retData.rspCode=="000000"){
		 			result=false;
				}
			}
		});
	return result;
}


//方法，验证姓名
function checkName(){
	var result=true;
	var username = $('input[name=username]').val();
	if(isBlank(username)){
		floatNotify.simple('请输入您的账号');
		return false;
	}else if(username.length < 2){
		floatNotify.simple('账号长度不能少于2个字符');
		return false;
	}else{
	       $.ajax({
				url: contextPath + "/isUserNameExist.action", 
				data: {"username":username},
				type:'post', 
				async : false, //默认为true 异步   
				error: function(jqXHR, textStatus, errorThrown) {
			 		 //console.log(textStatus, errorThrown);
				},
				success:function(retData){
			 		if(retData.rspCode=="000000"){
			 			floatNotify.simple('姓名已经存在');
			 			result=false;
					}
				}
			});
	}
	return result;
}

//方法，验证手机
function checkPhone(){
	
	var mobile = $('input[name=mobile]').val();
    
    if(isBlank(mobile)){
       floatNotify.simple('请输入您的手机号码');
       return false;
    }
    
    if(!isPhone(mobile)){
  	  floatNotify.simple('请输入正确的手机形式');
        return false;
    }
    
    if(!isPhoneExist(mobile)){
  	  floatNotify.simple('该手机号码已存在！');
        return false;
    }
    
    return true;
}

//方法，验证密码
function checkPassword(){
	
	var password = $('input[name=password]').val();
	
	if(isBlank(password)){
        floatNotify.simple('密码不能为空！');
        return false;
     }
	
	if(password.length<6){
        floatNotify.simple('密码长度不能小于6个字符！');
        return false;
    }
	
	return true;
}

//方法，验证密码
function checkRePassword(){
	
	var password = $('input[name=password]').val();
	
	var repassword = $('input[name=repassword]').val();
	
	if(password!=repassword){
        floatNotify.simple('两次密码不相同！');
        return false;
     }
	
	return true;
}

/** 倒计时函数 **/
function mycountDown(obj,second){

   // 如果秒数还是大于0，则表示倒计时还没结束
   if(second>=0){
       
       // 按钮置为不可点击状态
       $(obj).attr('disabled', true);
       
       // 按钮里的内容呈现倒计时状态
       $(obj).val("已发送"+'('+second+')');
       
       // 时间减一
       second--;
       
       // 一秒后重复执行
       setTimeout(function(){mycountDown(obj,second);},1000);
   
   }else{// 否则，按钮重置为初始状态
   	
       // 按钮置未可点击状态
       $(obj).attr('disabled', false);
       // 按钮里的内容恢复初始状态
       $(obj).val("获取手机验证码");
   }
    
}

/** 倒计时函数 **/
function bindingMycountDown(obj,second){

   // 如果秒数还是大于0，则表示倒计时还没结束
   if(second>=0){
       
       // 按钮置为不可点击状态
       $(obj).attr('disabled', true);
       
       // 按钮里的内容呈现倒计时状态
       $(obj).html("已发送"+'('+second+')');
       
       // 时间减一
       second--;
       
       // 一秒后重复执行
       setTimeout(function(){bindingMycountDown(obj,second);},1000);
   
   }else{// 否则，按钮重置为初始状态
   	
       // 按钮置未可点击状态
       $(obj).attr('disabled', false);
       // 按钮里的内容恢复初始状态
       $(obj).html("获取手机验证码");
   }
    
}