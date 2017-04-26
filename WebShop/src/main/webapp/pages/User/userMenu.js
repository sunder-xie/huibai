var getUserMenu = function(basepath,user_id){
	var b_type='UM' ; //菜单类型UM
	var b_sysid='web';
	var param = {type:b_type,sysId:b_sysid};
	//底部菜单栏的添加
	$.post(basepath+'base/menu/getMenuNav.action',param,function(data){
		var items='';
		for(var i=0;i<data.length;i++){
			if(data[i].level==1){			
				items+='<dl><dt>'+data[i].name+'</dt>';
				items+=getUserMenuChildren(basepath,data,data[i].id,user_id);
				items+='</dl>';
			}
		}
		$("#menu").append(items);
		setMenuCss();
	},'json');
}

function getUserMenuChildren(basepath,data,pid,user_id){
	var items='';
	for(var i=0;i<data.length;i++){
		if(data[i].parentid == pid){
			items+='<dd><a id="user_menu_'+data[i].id+'" href="'+basepath+data[i].url+'?user_id='+user_id+'&user_menu_id='+data[i].id+'" target="_self">'+data[i].name+'</a></dd>';
		}
	}
	return items;
}

var setMenuCss = function(){
	var map=parseQuery(window.location.href);
//	alert(JSON.stringify(map));
	var menuid=GetQueryString("user_menu_id");
//	alert(menuid);
	$("#user_menu_"+menuid).css("color","red");	
}