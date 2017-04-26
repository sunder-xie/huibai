$(function(){
   
	if(isWeiXinBrowse())
	{
		InitHeader();
	}
	
    getClassifyList();
});

var InitHeader =function(){
	$('.header').hide();
	$('.fix-top-search').addClass('top0');
	$('#sidebar').addClass('top44px');
}

var openSearch = function(){
	$('.fix-top-search').hide();
	$('#container').hide();
	$('#sbox').show();
};

var cancelSearch = function(){
	$('.fix-top-search').show();
	$('#container').show();
	$('#sbox').hide();
};

var search = function(keyword){
	window.location = "pages/search/searchGoods.jsp?keyword="+keyword;
};

function checkInputEvent(){
	$("#searchKey").keypress(onNormalLogonKeyPress);
}

//普通登录处理回车事件
function onNormalLogonKeyPress(evt) {
  	//兼容IE和Firefox获得keyBoardEvent对象
	evt = (evt) ? evt : ((window.event) ? window.event : "")
	//兼容IE和Firefox获得 keyBoardEvent对象的键值
	var keyCode = evt.keyCode?evt.keyCode:evt.which;
	if(keyCode==13) {
		var keyword = $('#searchKey').val();
		search(keyword);
	}
}

function getClassifyList(){
	//获取首页导航菜单
	var navType = '0001';
	var param = {
			'navType':navType,
			'pclassify':'00000000'
	};
	var requestUrl = 'NavClassify/GetTopNavClassifyInfo.action';
	//导航兰的添加
	$.post(requestUrl,param,function(data){
	//alert(JSON.stringify(data));
		if(data.rspCode=="000000"){
			var li='';
			var jsons = data.objs;
			var len;
			len = jsons.length;
			var name ='',classify='';
        	for(var i=0;i<len;i++){
        		name =jsons[i].cname;
        		classify=jsons[i].classify;
        		if(i==0)
        		{	
        			li +='<li class="active" have-data="no" id="p'+classify+'" classify="'+classify+'">'+name+ '</li>';
        			getClassifyChild(navType,classify,name);
        		}
        		else
        			li +='<li have-data="no" id="p'+classify+'" classify="'+classify+'">'+name+ '</li>';
        		$('#sidebar ul').empty();
	    		$('#sidebar ul').html(li);
        	}
        
        	
        $('#sidebar ul li').click(function(){
        		$(this).addClass('active').siblings('li').removeClass('active');
        		var havedata =$(this).attr('have-data');
        		var classify =$(this).attr('classify');
        		if(havedata=='yes')
        		{
        			$('.j-content').hide();
        			$('#'+classify).show();
        			return;
        		}
        		var navType='0001';
        		var name =$(this).html();
        		getClassifyChild(navType,classify,name);
        })
        	
		}
	},"json");	
}

var getClassifyChild = function(navType,pclassify,pname){
	/*此次拉取二级分类，包含分类图片等星星，目前暂时拉取商品信息*/
	//获取首页导航菜单
	var param = {
			'navType':navType,
			'pclassify':pclassify
	};
	var requestUrl = 'NavClassify/GetLastNavClassifyInfo.action';
	$.post(requestUrl,param,function(data){
		//alert(JSON.stringify(data));
		if(data.rspCode=="000000"){
			var ul='';
			var jsons = data.objs;
			var len,name,url,imgUrl,classify;
			len = jsons.length;
			
			var empty = $('#List1').val();
        	$('#right-list').append(empty.template(pclassify,pname));
        	
        	var list ='';
        	for(var i=0;i<len;i++){
        		name =jsons[i].cname;
        		classify = jsons[i].classify;
            	//url  =jsons[i].url+'?classify='+classify;
            	url  ='pages/search/searchGoods.jsp'+'?classify='+classify;
            	imgUrl ='images/logo/whale-256x256.png';
            	var empty = $('#List2').val();
            	list+=empty.template(url,imgUrl,name);
        	}
        	$('#'+pclassify+' ul').append(list);
        	$('#p'+pclassify).attr('have-data','yes');
        	$('.j-content').hide();
			$('#'+pclassify).show();
		}
		else
		{
		}	
	},"json");	
}