//提交
function formSubmit(){
	
        var postData={};var flag = true;
        
        var username = $('input[name=username]').val();
        if(checkName()){ //验证姓名
        	postData['username']=username;
        }else{
        	flag = false;
        	return;
        }
        
//        if(checkPhone()){//验证手机
//        	postData['mobile']=$('input[name=mobile]').val();
//        }else{
//        	flag = false;
//        	return;
//        }
        
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
//        postData['mobileCode'] = $('input[name=mobile_code]').val();
//        
//        postData['parentUserName'] = $("#parentUserName").val();
        var param = postData;
        
        if(flag){
        	
        	$.post("user/Register.action",param,function(data){
				if(data.rspCode=="000000"){
					window.location.href=contextPath+"/userCenter.jsp";
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
			url: contextPath + "/isPhoneExist", 
			data: {"phone":phone},
			type:'post', 
			async : false, //默认为true 异步   
			dataType : 'json', 
			error: function(jqXHR, textStatus, errorThrown) {
				 //console.log(textStatus, errorThrown);
				},
			success:function(retData){
				if(retData){
					result = false;
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
		floatNotify.simple('请输入您的姓名');
		return false;
	}else if(username.length < 2){
		floatNotify.simple('姓名长度不能少于2个字符');
		return false;
	}else{
	       $.ajax({
				url: contextPath + "/isNickNameExist", 
				data: {"nickName":username},
				type:'post', 
				async : false, //默认为true 异步   
				error: function(jqXHR, textStatus, errorThrown) {
			 		 //console.log(textStatus, errorThrown);
				},
				success:function(retData){
			 		if('true' == retData){
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

/** 倒计时函数 **/
function mycountDown(obj,second){

   // 如果秒数还是大于0，则表示倒计时还没结束
   if(second>=0){
       
       // 按钮置为不可点击状态
       $(obj).attr('disabled', true);
       
       // 按钮里的内容呈现倒计时状态
       $(obj).val("发送短信中"+'('+second+')');
       
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
       $(obj).html("发送短信中"+'('+second+')');
       
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