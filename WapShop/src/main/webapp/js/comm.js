
/*设置全局变量*/
var wapChannel ='1';
var webChannel ='2';
var appChannel ='3';

/*设置全局变量*/
var WeiXinPay ='01';

var NotFoundRecord = '000002';

/*获取根目录*/
function getRootPath(){ 
	var basepath ;
	var test = 0;
	if(test)
	{
//		var strFullPath=window.document.location.href; 
//		var strPath=window.document.location.pathname; 
//		var pos=strFullPath.indexOf(strPath); 
//		var prePath=strFullPath.substring(0,pos); 
//		var postPath=strPath.substring(0,strPath.substr(1).indexOf('/')+1); 
//		basepath= prePath+postPath+'/'; 
		basepath ='http://localhost:8080/WapShop/';
	}
	else
	{
		//basepath ='../../';
		basepath ='http://m.hbaicai.com/';
	}
	return basepath;
} 

/*获取页面根目录*/
function getPagesPath(){ 
	
var strFullPath=window.document.location.href; 
var strPath=window.document.location.pathname; 
var pos=strFullPath.indexOf(strPath); 
var prePath=strFullPath.substring(0,pos); 
var postPath=strPath.substring(0,strPath.substr(1).indexOf('/')+1); 
return(prePath+postPath+'/'+'pages/'); 
} 

/*url 中根据字段获取值*/
function getQueryStringByName(name){
	var result = (RegExp(name + '=' + '(.+?)(&|$)').exec(location.search)||[,null])[1];
	return decodeURIComponent(result);
}
/*后续去掉这个函数*/
function GetQueryString(name) {
  if(0)
  {
	  var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)","i");
	   var r = window.location.search.substr(1).match(reg);
	   if (r!=null) return (r[2]); return null;
  }
  else
  {
	  var result = (RegExp(name + '=' + '(.+?)(&|$)').exec(location.search)||[,null])[1];
		return decodeURIComponent(result);
  }
}

/*判断是否为空*/
function isNull(data){
	var flag = false;
	if(data === "" || data === undefined || data === null || data === "null" || data ==="undefined")
		flag = true;
	else
		flag = false;
	return flag;
}

/*从指定url 中根据字段获取值*/
function GetValueByNameFromUrl(url,paras){  
    //var url = location.href;    
    var paraString = url.substring(url.indexOf("?")+1,url.length).split("&");    
    var paraObj = {};    
    for (i=0; j=paraString[i]; i++){    
        paraObj[j.substring(0,j.indexOf("=")).toLowerCase()] = j.substring(j.indexOf("=")+1,j.length);    
    }    
    var returnValue = paraObj[paras.toLowerCase()];    
    if(typeof(returnValue)=="undefined"){    
        return "";    
    }else{   
        return returnValue;   
    }  
}

/*从指定url 中根据字段获取值*/
function requestParam(url,paras){  
    //var url = location.href;    
    var paraString = url.substring(url.indexOf("?")+1,url.length).split("&");    
    var paraObj = {};    
    for (i=0; j=paraString[i]; i++){    
        paraObj[j.substring(0,j.indexOf("=")).toLowerCase()] = j.substring(j.indexOf("=")+1,j.length);    
    }    
    var returnValue = paraObj[paras.toLowerCase()];    
    if(typeof(returnValue)=="undefined"){    
        return "";    
    }else{   
        return returnValue;   
    }  
}


var  rquery = /^(?:[^?]*\?)?([\w\d\-\/=&%]+)/;

function parseQuery(str, separator) {
    var query = String(str).match(rquery),
        key,
        value;

    if (query == null) return hash;

    query = query.pop();
    separator = separator || '&';

    return query.split(separator).reduce(function(hash, pair) {
        if (pair.indexOf('=') > 0) {
            pair = decodeURIComponent(pair).split('=');

            key = pair.shift();
            // 如果query中某个变量值包含等号
            // 我们应该重新组合起来
            value = pair.join('=');

            if (value != void 0) {
                value = value.replace('+', ' ');
            }
        } else {
            key = decodeURIComponent(pair);
            value = void 0;
        } 

        hash[key] = value;

        return hash;
    }, {});
}

/*
 * 金额转换
 * 将后端分为单位金额转换成带2位小数金额
 * 
 * 
 * */
function AmtToDecimal2(x) {    
    var f = parseFloat(x);    
    if (isNaN(f)) {    
        return false;    
    }    
    var f = Math.round(x)/100;    
    var s = f.toString();    
    var rs = s.indexOf('.');    
    if (rs < 0) {    
        rs = s.length;    
        s += '.';    
    }    
    while (s.length <= rs + 2) {    
        s += '0';    
    }    
    return s;    
} 

/*
 * 金额转换
 * 将带2位小数金额转换成后端分为单位金额
 * 
 * 
 * */
function Decimal2ToAmt(x) {    
    
	var rs = x.indexOf('.');    
    if (rs < 0) {    
        rs = x.length;    
    }    
    var a = x.substr(0,rs);
    var b = x.substr(rs+1,x.length);
    a += x.substr(rs+1,x.length);
    var len = b.length
    while (len < 2) {    
        a += '0';
        len +=1;
    }  
    //return a;   
    return parseInt(a);
} 

//将yyyyMMddhhmmss格式转成yyyy-MM-dd hh:mm:ss

function formatStringyyyyMMddToyyyy_MM_ddhh_mm_ss(value){

	if(value.length == 14){
		return value.substring(0, 4) + "-" + value.substring(4, 6) + "-" + value.substring(6, 8)+' '+
		 value.substring(8, 10)+ ":" +value.substring(10, 12) + ":" + value.substring(12, 14) ;
	} else if(value.length == 6){
		return value.substring(0, 4) + "-" + value.substring(4, 6);
	} else {
		return value;							
	}
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


/* 
* 获得时间差,时间格式为 年-月-日 小时:分钟:秒 或者 年/月/日 小时：分钟：秒 
* 其中，年月日为全格式，例如 ： 2010-10-12 01:00:00 
* 返回精度为：秒，分，小时，天 
*/ 

function GetDateDiff(startTime, endTime, diffType) {
	// 将xxxx-xx-xx的时间格式，转换为 xxxx/xx/xx的格式
	startTime = startTime.replace(/-/g, "/");
	endTime = endTime.replace(/-/g, "/");
	// 将计算间隔类性字符转换为小写
	diffType = diffType.toLowerCase();
	var sTime = new Date(startTime); // 开始时间
	var eTime = new Date(endTime); // 结束时间
	// 作为除数的数字
	var divNum = 1;
	switch (diffType) {
	case "second":
		divNum = 1000;
		break;
	case "minute":
		divNum = 1000 * 60;
		break;
	case "hour":
		divNum = 1000 * 3600;
		break;
	case "day":
		divNum = 1000 * 3600 * 24;
		break;
	default:
		break;
	}
	return parseInt((eTime.getTime() - sTime.getTime()) / parseInt(divNum));
}


function getFormJson(form) {
	var o = {};
	var a = $(form).serializeArray();
	$.each(a, function () {
	if (o[this.name] !== undefined) {
	if (!o[this.name].push) {
	o[this.name] = [o[this.name]];
	}
	o[this.name].push(this.value || '');
	} else {
	o[this.name] = this.value || '';
	}
	});
	return o;
}

String.prototype.template = function() {
    var args = arguments,
        k = -1;
    return this.replace(/\{(\w+)\}/g, function() {
        k++;
        return args[k];
    });
};

String.prototype.trim = function() {
    return this.replace(/(^\s+)|(\s+$)/g, '');
};

/*是否包含某个字符串*/
function isContains(str, substr) {
	return str.indexOf(substr) >= 0;
}


function isWeiXinBrowse(){
	var ua = window.navigator.userAgent.toLowerCase();
	if(ua.match(/MicroMessenger/i) == 'micromessenger'){
		return true;
	}else{
		return false;
	}
} 
