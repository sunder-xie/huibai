var basepath=null; /*根目录*/
var user_id = null ;/*用户编号*/

var setAllDomain = function(){
	basepath=getRootPath();	
	user_id =$("#LoginUser").attr('loginUserId');
}

function toList() {
    window.location.href = basepath + 'pages/User/userOrder.jsp?user_id='+user_id;
}

$(function() {
	setAllDomain();
});


