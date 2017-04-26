var basepath=null; /*根目录*/
var user_id = null ;/*用户编号*/
$(function(){
    setAllDomain();
    getUserMenu(basepath,user_id);
});
 
var setAllDomain = function(){
	basepath=getRootPath();	
	user_id =GetQueryString("user_id");
}



