var getMerMenu = function(basepath,shop_id,user_id){
	var b_type='MM' ; //商家菜单类型MM
	var b_sysid='web';
	var param = {type:b_type,sysId:b_sysid};
	//底部菜单栏的添加
	$.post(basepath+'base/menu/getMenuNav.action',param,function(data){
		var items='';
		for(var i=0;i<data.length;i++){
			if(data[i].level==1){			
				items+='<dl><dt>'+data[i].name+'</dt>';
				items+=getChildren(data,data[i].id,shop_id,user_id);
				items+='</dl>';
			}
		}
		$("#menu").append(items);
		setMenuCss();
	},'json');
}

function getChildren(data,pid,shop_id,user_id){
	var items='';
	for(var i=0;i<data.length;i++){
		if(data[i].parentid == pid){
			items+='<dd><a id="mer_menu_'+data[i].id+'" href="'+basepath+data[i].url+'?mer_menu_id='+data[i].id+'&shop_id='+shop_id+'&user_id='+user_id+'" target="_self">'+data[i].name+'</a></dd>';
		}
	}
	return items;
}

var setMenuCss = function(){
	var map=parseQuery(window.location.href);
//	alert(JSON.stringify(map));
	menuid=GetQueryString("mer_menu_id");
//	alert(menuid);
	$("#mer_menu_"+menuid).css("color","red");	
}