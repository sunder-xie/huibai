var basepath=null; /*根目录*/
var user_id = null ;/*用户编号*/
$(function(){
    setAllDomain();
});
 
var setAllDomain = function(){
	basepath='';	
}

function userLogout(){
	
	$.post('user/Logout.action',function(data){
		if(data.rspCode=="000000"){
			window.location  = 'pages/Login/userLogin.jsp';
		}
	});
	
}


