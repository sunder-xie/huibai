<%@page import="com.app.bean.TblUserInfo"%>
<%@page import="com.app.common.utils.LTConstant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String tPath = request.getContextPath();
TblUserInfo userinfo =  (TblUserInfo)session.getAttribute(LTConstant.userInfo);
%>
<style>

.site_cmtop {
    font-size: 12px;
    margin: 0 auto;
    text-align: left;
    color: #888;
    background-color: #f2f2f2;
}

.site_cmtop > .topbar {
    width: 1200px;
    min-width: 1200px;
    height: 35px;
    margin: 0 auto;
}

/* .topbar {
    font-size: 12px;
    margin: 0 auto;
    text-align: left;
    color: #888;
    //background-color: #f2f2f2;
} */

/* .topbar {
	background: #f2f2f2 none repeat scroll 0 0;
	border-bottom: 1px solid #e5e5e5;
	height: 35px;
	width: 100%;
	position: relative !important;
	width: auto;
	z-index: 99999;
	padding: 0 100px 0 100px;
	font-family: Arial, Verdana, "宋体";
	min-width: 1200px;
} */

.site_cmtop .topbar_left {
	display: inline-block;
	float: left;
	line-height: 35px;
}

.site_cmtop > .topbar a {
	text-decoration: none;
	color: #666666;
}

.site_cmtop .topbar_left_1 {
	float: left;
	width: 82px;
	height: 35px;
	position: relative;
}

.site_cmtop .topbar_left_1_dh {
	display: block;
	position: relative;
	padding: 0 1px;
	width: 82px;
	line-height: 35px;
	height: 35px;
	
}

.site_cmtop .topbar_left_dh {
	width: 1080px;
	height: auto;
	position: absolute;
	border-left: 1px solid #ddd;
	border-right: 1px solid #ddd;
	border-bottom: 1px solid #ddd;
	background: #fff;
	display: none;
	z-index: 999999;
}

.topbar_left_1_dhon {
	display: block;
	background: #fff;
	border: 1px solid #ddd;
	border-bottom: 0;
	padding: 0 0px;
	width: 82px;
	line-height: 33px;
	height: 35px;
}

.dh_list {
	height: auto;
	width: 200px;
	margin-left: 8px;
	float: left;
	margin-top: 20px;
	border-right: 1px solid #ddd;
}

.lump-tit {
	margin-left: 10px;
	font-size: 14px;
}

.topbar_left_dh dd {
	width: 100%;
	overflow: hidden;
	margin-top: 13px;
}

.topbar_left_dh dd p {
	float: left;
	height: 25px;
	width: 78px;
	line-height: 25px;
}

.topbar_left_dh ul {
	list-style: none;
	margin: 0px;
	padding: 0px;
}

.topbar_left_dh a {
	margin-left: 10px;
}

.site_cmtop .topbar_left_2 {
	float: left;
	width: 60px;
	height: 35px;
	position: relative;
}

.topbar_left_2_message {
	display: block;
	position: relative;
	padding: 0 1px;
	width: 60px;
	line-height: 35px;
	height: 35px;
}

.topbar_left_message {
	width: 180px;
	height: 90px;
	position: absolute;
	border-left: 1px solid #ddd;
	border-right: 1px solid #ddd;
	border-bottom: 1px solid #ddd;
	background: #fff;
	display: none;
}

.topbar_left_2_messageon {
	display: block;
	background: #fff;
	border: 1px solid #ddd;
	border-bottom: 0;
	padding: 0 0px;
	width: 60px;
	line-height: 33px;
	height: 35px;
}

.newmessage {
	width: 180px;
	height: 64px;
	padding-bottom: 0px;
	border-bottom: 1px solid #ddd;
}

.topbar_left_message a {
	margin-left: 10px;
}

.site_cmtop  .topbar_right {
	display: inline-block;
	float: right;
	line-height: 35px;
	width: auto;
	height: 35px;
}

.topbar_right_login {
	float: left;
	height: 35px;
	position: relative;
}

.register {
	margin-left: 10px;
}

.topbar_right_1 {
	float: left;
	width: 82px;
	height: 35px;
	position: relative;
}

.topbar_right_1_my {
	display: block;
	position: relative;
	padding: 0 1px;
	width: 82px;
	line-height: 35px;
	height: 35px;
}

.topbar_right_my {
	width: 82px;
	height: 140px;
	position: absolute;
	border-left: 1px solid #ddd;
	border-right: 1px solid #ddd;
	border-bottom: 1px solid #ddd;
	background: #fff;
	display: none;
}

.topbar_right_1_myon {
	display: block;
	background: #fff;
	border: 1px solid #ddd;
	border-bottom: 0;
	padding: 0 0px;
	width: 82px;
	line-height: 33px;
	height: 35px;
}

.topbar_right_my a {
	margin-left: 10px;
}

.topbar .spans {
	margin-left: 10px;
}

.arrow {
	background-image: url(<%=tPath%>/images/topbar.png)
		!important;
	background: url() no-repeat 0 -156px;
	display: block;
	position: absolute;
	width: 7px;
	height: 4px;
	overflow: hidden;
	top: 16px;
	right: 8px;
}

.topbar_right_2 {
	float: left;
	width: 82px;
	height: 35px;
	position: relative;
}

.topbar_right_mylh a {
	margin-left: 10px;
}

.topbar_right_2_mylh {
	display: block;
	position: relative;
	padding: 0 1px;
	width: 82px;
	line-height: 35px;
	//height: auto;
	//height: 35px;
}

.topbar_right_mylh {
	width: 82px;
	//height: 170px;
	position: absolute;
	border-left: 1px solid #ddd;
	border-right: 1px solid #ddd;
	border-bottom: 1px solid #ddd;
	background: #fff;
	display: none;
}

.topbar_right_2_mylhon {
	display: block;
	background: #fff;
	border: 1px solid #ddd;
	border-bottom: 0;
	padding: 0 0px;
	width: 82px;
	line-height: 33px;
	//height: auto;
	//height: 35px
}

.topbar_right_3 {
	float: left;
	width: 60px;
}

.topbar_right_4 {
	float: left;
	width: 60px;
}

.topbar_right_5 {
	float: left;
	width: 70px;
	height: 35px;
	position: relative;
}

.topbar_right_5_phone {
	display: block;
	position: relative;
	padding: 0 1px;
	width: 70px;
	line-height: 35px;
	height: 35px;
}

.topbar_right_5_phoneon {
	display: block;
	background: #fff;
	border: 1px solid #ddd;
	border-bottom: 0;
	padding: 0 0px;
	width: 70px;
	line-height: 33px;
	height: 35px;
}

.topbar_right_6 {
	float: left;
	width: 82px;
	position: relative;
}

.topbar_right_6_mer {
	display: block;
	position: relative;
	padding: 0 1px;
	width: 82px;
	line-height: 35px;
}

.topbar_right_mer {
	width: 82px;
	position: absolute;
	border-left: 1px solid #ddd;
	border-right: 1px solid #ddd;
	border-bottom: 1px solid #ddd;
	background: #fff;
	display: none;
}

.topbar_right_mer a {
    margin-left: 10px;
}

.topbar_right_6_merlhon {
	display: block;
	background: #fff;
	border: 1px solid #ddd;
	border-bottom: 0;
	padding: 0 0px;
	width: 82px;
	line-height: 33px;
	height: 35px;
}

.topbar_right_7 {
	float: left;
	width: 60px;
}

.topbar_right_5_panl {
	//width: 270px;
	height: 220px;
	position: absolute;
	border: 1px solid #ddd;
	border-top: 0;
	background: #fff;
	display: none;
	z-index: 1;
}

.topbar_right_5_panl img{
    height:148px;
    width:148px
}

.topbar_right_5_panl_left {
	width: 148px;
	height: 180px;
	float: left;
	margin-left: 10px;
	margin-top: 10px;
	border-right: 1px solid #eee;
}

.topbar_right_5_panl_left p {
	padding: 0;
	margin: 0;
}

.topbar_right_5_panl_right {
	width: 110px;
	height: 190px;
	float: left;
}

.topbar_right_5_panl_right_image {
	width: 100px;
	height: 90px;
	margin-top: 50px;
}

.app {
	margin-left: 14px;
	padding-top: 10px;
}

.closediv1 {
	width: 22px;
	height: 22px;
	float: right;
	margin-right: 10px;
}

.closediv2 {
	width: 22px;
	height: 22px;
	float: right;
}

#close {
	font-size: 22px;
	width: 22px;
	height: 22px;
	color: black;
}
</style>
<script type="text/javascript"
	src="<%=tPath%>/assets/plugs/jquery/jquery-1.11.3.min.js"></script>
<script type="text/javascript">
    function TopcreateTree(jsons,pid){
	   if(jsons != null){
	   	var ul=' ';
	       for(var i=0;i<jsons.length;i++){
	           if(jsons[i].parentid == pid){
	        	   ul +='<p><a href="'+jsons[i].url+'" target="_blank" >'+ jsons[i].name +'</a></p>'   ;
	           }
	       }
	  }
	   return ul ;
	}
	//导航兰的添加
	$(function(){
		//获取顶部网址导航菜单
		var b_type='NT' ; 
		var b_sysid='web';
		var param = {type:b_type,sysId:b_sysid};
		$.post('<%=tPath%>/base/menu/getMenuNav.action',param,function(data){
		//	alert(JSON.stringify(data));
			var len = data.length;
			var item=' ';
			var NavMenu = ' ' ;
			var firstnum=0,j=0;
			for(var i=0;i<len;i++)
			{
				if(data[i].level==1)
					firstnum+=1;
			}
			for(var i=0;i<len;i++)
			{
				if(data[i].level==1)
			    {
					j+=1;
					if(j==firstnum)
					{
						item+='<dl class="dh_list" style="border-right: none;">';
						item+='<dt class="lump-tit">'+data[i].name+'</dt>';
						item+='<dd>';
						item += TopcreateTree(data,data[0].id);
						item+='</dd>';
						item+='</dl>';
						break;
					}
					else
					{
						item+='<dl class="dh_list">';
						item+='<dt class="lump-tit">'+data[i].name+'</dt>';
						item+='<dd>';
						item += TopcreateTree(data,data[0].id);
						item+='</dd>';
						item+='</dl>';
					}
			    }
			}
			NavMenu+=item;
			$("#topbar_left_dh").append(NavMenu);
		},"json");
	});

$(function (){	
	   $(".topbar_left_1").hover(function(){
		   $(this).find(".arrow").css("background","url() no-repeat -7px -156px");
		   trigger = setInterval(function(){
			    $(".topbar_left_dh").slideDown(100);
				$(".topbar_left_dh").css("display","block");		
				$(".topbar_left_1_dh").attr("class","topbar_left_1_dhon");
        },100); 
	   },
	   function(){
		   clearInterval(trigger);
		   $(".topbar_left_dh").slideUp(100);
		   $(".topbar_left_1_dhon").attr("class","topbar_left_1_dh");
		   $(this).find(".arrow").css("background","url() no-repeat 0 -156px");				
	   });
	   
	    $(".topbar_left_2").hover(
	  			function () {
	    				$(".topbar_left_message").stop(true).animate({height: 'toggle'},100);  
						$(".topbar_left_2_message").attr("class","topbar_left_2_messageon");
						$(this).find(".arrow").css("background","url() no-repeat -7px -156px");
	 				 },
	  			function () {
						$(".topbar_left_message").stop(true).animate({height: 'toggle'},100);  
						$(".topbar_left_2_messageon").attr("class","topbar_left_2_message");
						$(this).find(".arrow").css("background","url() no-repeat 0 -156px");
	  					}
					);
		$(".topbar_right_1").hover(
  			function () {
    				$(".topbar_right_my").stop(true).animate({height: 'toggle'},100); 
					$(".topbar_right_1_my").attr("class","topbar_right_1_myon");
					$(this).find(".arrow").css("background","url() no-repeat -7px -156px");
 				 },
  			function () {
					$(".topbar_right_my").stop(true).animate({height: 'toggle'},100); 
					$(".topbar_right_1_myon").attr("class","topbar_right_1_my");
					$(this).find(".arrow").css("background","url() no-repeat 0 -156px");
  					}
				);
		$(".topbar_right_2").hover(
  			function () {
    				$(".topbar_right_mylh").stop(true).animate({height: 'toggle'},100); 
					$(".topbar_right_2_mylh").attr("class","topbar_right_2_mylhon");
					$(this).find(".arrow").css("background","url() no-repeat -7px -156px");
 				 },
  			function () {
					$(".topbar_right_mylh").stop(true).animate({height: 'toggle'},100); 
					$(".topbar_right_2_mylhon").attr("class","topbar_right_2_mylh");
					$(this).find(".arrow").css("background","url() no-repeat 0 -156px");
  					}
				);
				
		$(".topbar_right_5").hover(
  			function () {
    				$(".topbar_right_5_panl").stop(true).animate({height: 'toggle'},100); 
					$(".topbar_right_5_phone").attr("class","topbar_right_5_phoneon");
					$(this).find(".arrow").css("background","url() no-repeat -7px -156px");
 				 },
  			function () {
					$(".topbar_right_5_panl").css("display","none");
					$(".topbar_right_5_phoneon").attr("class","topbar_right_5_phone");
					$(this).find(".arrow").css("background","url() no-repeat 0 -156px");
  					}
				);
		
		$(".topbar_right_6").hover(
	  			function () {
	    				$(".topbar_right_mer").stop(true).animate({height: 'toggle'},100); 
						$(".topbar_right_6_mer").attr("class","topbar_right_6_merlhon");
						$(this).find(".arrow").css("background","url() no-repeat -7px -156px");
	 				 },
	  			function () {
						$(".topbar_right_mer").stop(true).animate({height: 'toggle'},100); 
						$(".topbar_right_6_merlhon").attr("class","topbar_right_6_mer");
						$(this).find(".arrow").css("background","url() no-repeat 0 -156px");
	  					}
					);
		
		$(".topbar").on('mouseover mouseout',"a",function(event){
			if(event.type == "mouseover"){
				$(this).css("color","red");
			}else if(event.type == "mouseout"){
				$(this).css("color","");
			 }
		}); 
});
		function clos1() {
    			$(".topbar_left_dh").css("display","none");
 				 }
		function clos2() {
				$(".topbar_right_5_panl").css("display","none");
			 }
		
		function logout(){
			$.post('<%=tPath%>/user/Logout.action',function(data){
				//alert(JSON.stringify(data));
				if(data.rspCode=="000000"){
					window.location  = '<%=tPath%>/pages/Login/userLogin.jsp';
				}
			});
		}
</script>
<div class="site_frame_top">
		   <div class ="site_cmtop">
<div class="topbar">
	<!--头部工具栏的左边部分-->
	<div class="topbar_left">
		<div class="topbar_left_1">
			<a class="topbar_left_1_dh" href="#"><span class="spans">网站导航</span><span
				class="arrow"></span></a>
			<div id="topbar_left_dh" class="topbar_left_dh">
			<!--<dl class="dh_list">
					<dt class="lump-tit">个人信息</dt>
					<dd>
						<p><a href="" target="_blank">基本信息</a></p>
					</dd>
				</dl> -->
				<div class="closediv1">
					<a id="close" href="javascript:clos1()">&#10005;</a>
				</div>
			</div>
		</div>
		<div class="topbar_left_2">
			<a class="topbar_left_2_message" href="#"><span class="spans">消息</span><span
				class="arrow"></span></a>
			<div class="topbar_left_message">
				<div class="newmessage">
				    <span><img src="<%=tPath%>/images/lt.ico"></span>
					<span> ~嗷~ 没有新消息...</span>
				</div>
				<a style="margin-right: 6px; float: right; margin-top: -6px;"
					href="#" target="_blank">查看更多</a>
			</div>
		</div>
	</div>
	<!--头部工具栏的右边部分-->
	<div class="topbar_right">
		<div class="topbar_right_login">
			<%if(userinfo == null){%>
			<span class="login"> <a href="<%=tPath%>/pages/Login/userLogin.jsp">登录</a></span> 
			<span class="register"><a href="<%=tPath%>/pages/Login/userRegister.jsp">注册</a></span>
			<%}else{ %>
				欢迎您，<%=userinfo.getUsername() %>
				<span class="register"><a href="javascript:logout();">退出</a></span>
			<%} %>
		</div>
		<!-- <div class="topbar_right_1">
			<a class="topbar_right_1_my" href="#"><span class="spans">我的订单</span><span
				class="arrow"></span></a>
			<div class="topbar_right_my">
				<a href="#" target="_blank">待支付</a></br> <a
					href="#" target="_blank">待收货</a></br> <a
					href="#" target="_blank">待评价</a></br> <a
					href="#" target="_blank">修改订单</a>
			</div>
		</div> -->
		<div class="topbar_right_2">
			<a class="topbar_right_2_mylh" href="<%=tPath%>/pages/User/userCenter.jsp">
			<span class="spans">我的乐汇</span>
			<span class="arrow"></span></a>
			<div class="topbar_right_mylh">
				<a href="<%=tPath%>/pages/User/UserOrder.jsp" target="_blank">我的订单</a>
				<!-- </br> <a
					href="#" target="_blank">我的二手</a></br> <a
					href="#" target="_blank">我的二手</a></br> <a
					href="#" target="_blank">我的二手</a></br> <a
					href="#" target="_blank">我的二手</a> -->
			</div>
		</div>
		<div class="topbar_right_3 hide">
			<center>
				<a href="#" target="_blank">购物车</a>
			</center>
		</div>
		<div class="topbar_right_4 hide">
			<center>
				<a href="">收藏夹</a>
			</center>
		</div>
		<div class="topbar_right_5">
			<a class="topbar_right_5_phone" href="#"><span class="spans">手机版</span><span
				class="arrow" style="left: 50px;"></span></a>
			<div class="topbar_right_5_panl">
				<div class="topbar_right_5_panl_left">
					<p>
						<a href="#">扫一扫，下载手机客户端</a>
					</p>
					<img src="<%=tPath%>/images/hbaicai.png">
				</div>
			<%-- 	<div class="topbar_right_5_panl_right">
					<div class="closediv2">
						<a id="close" href="javascript:clos2()">&#10005;</a>
					</div>
					<div class="topbar_right_5_panl_right_image">
						<a href="#" class="app"><img
							src="<%=request.getContextPath()%>/pages/HelpCenter/images/app-ebook.png"></a>
						<a href="#" class="app"><img
							src="<%=request.getContextPath()%>/pages/HelpCenter/images/app-sn.png"></a>
						<a href="#" class="app"><img
							src="<%=request.getContextPath()%>/pages/HelpCenter/images/app-pptv.png"></a>
						<a href="#" class="app"><img
							src="<%=request.getContextPath()%>/pages/HelpCenter/images/app-suning.png"
							height="32" width="32"></a>
					</div>
				</div>
				<a href="#">扫一扫，下载手机客户端</a> --%>
			</div>
		</div>
		
		<div class="topbar_right_6">
			<a class="topbar_right_6_mer" href="<%=tPath%>/pages/MerChnt/MerCenter.jsp"><span class="spans">商家平台</span><span
				class="arrow"></span></a>
			<div class="topbar_right_mer">
				<a href="<%=tPath%>/pages/MerChnt/merRegGuide.jsp" target="_blank">商家入驻</a></br> 
				<a href="<%=tPath%>/pages/MerChnt/merRegister.jsp" target="_blank">进度查询</a></br> 
			</div>
		</div>
		<div class="topbar_right_7">
			<center>
				<a href="#" target="_blank">帮助中心</a>
			</center>
		</div>
	</div>
	
</div>

	</div>
	
</div>