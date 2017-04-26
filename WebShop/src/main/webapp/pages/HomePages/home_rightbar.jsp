<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String tPath = request.getContextPath();
String tBasePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+tPath+"/";
tBasePath = tPath;
%>

<style type="text/css">	
.right-bar a {
    color: #666;
    text-decoration: none;
}
.right-bar {
    width: 35px;
	height:100%;
	top:0px;
	background-color:#383838;
    position: fixed;  
    display: block;
}
.right-bar li {
list-style:none;
}
.shopcar{
width:35px;
height:120px;
margin-top:10px;
border-bottom:1px solid #4D4D4D;
border-top: 1px solid #4D4D4D;
}
.shopcaron{
width:35px;
height:120px;
margin-top:10px;
border-bottom:1px solid #4D4D4D;
border-top: 1px solid #4D4D4D;
background-color:#FFAA01;
}
.car{
background: url(<%=tPath%>/images/sidebaricon.png) no-repeat;
background-position: -31px -23px;
display: block;
position: relative;
width: 29px;
height: 30px;
margin-left:3px;
cursor: pointer;
}
.spand{
background: url(<%=tPath%>/images/sidebaricon.png) no-repeat;
position: absolute;
left: 0;
z-index: 3;
width: 4px;
height: 8px;
background-position: 0 -270px;
cursor: pointer;
display: none;
}
.shop{
display: block;
width: 20px;
margin-left:10px;
font-size:14px;
color: #FFF;
}
.number{
display: inline-block;
min-width: 20px;
height: 15px;
margin-left:8px;
padding-left:6px;
background-color: #D00;
color: #FFF;
line-height: 15px;
border-radius: 5px;
}
.shopcar_div{
position: absolute;
top: 0;
display:none;
right: 35px;
width: 280px;
height: 100%;
background-color: #FFF;
border-left:1px solid #CCCCCC;
}
.bar{
width:35px;
height:30px;
position: relative;
margin-top: 5px;
}
.bar_image{
display: block;
position: relative;
width: 35px;
height: 30px;
cursor: pointer;
background: url(<%=tPath%>/images/sidebaricon.png) no-repeat;
}
.bar_div{
position: absolute;
display:none;
top: 0;
right: 35px;
width: 70px;
height: 30px;
font-size:12px;
background-color: #FFAA01;
line-height: 30px;
color: #383838;
text-indent: 11px;
cursor: pointer;
z-index:1;
}
.user_div{
position: absolute;
display:none;
top: 130px;
right: 35px;
width: 280px;
height: 120px;
font-size:12px;
background-color: white;
box-shadow: 1px 0 4px #888;
z-index:1;
}
.user_div_li{
background: url(<%=tPath%>/images/sn-sidebar-member.png) -12px -170px no-repeat;
display: inline-block;
float: left;
position: relative;
color:black;
top: 3px;
margin-right: -15px;
width: 12px;
height: 11px;
}
.user_div_box{
height: 80px;
margin-left:16px;
margin-right: 16px;
border-bottom: dashed 1px;
}
.user_div_message{
margin-left:16px;
margin-top: 10px;
}
.bar1_div{
position: absolute;
top: 0;
display:none;
right: 35px;
width: 280px;
height: 100%;
background-color: #FFF;
border-left:1px solid #CCCCCC;
}
.bar6_div{
position: absolute;
display:none;
bottom:-44px;
right: 35px;
width: 132px;
height: 154px;
line-height: 30px;
background-color: #F9F9F9;
box-shadow: 1px 0 4px #888;
border: 1px solid #CCC;
cursor: pointer;
z-index:1;
}
.bar0{
width:35px;
height:30px;
position: relative;
margin-top: 5px;
}
.bar0_on{
width:35px;
height:30px;
position: relative;
margin-top: 5px;
background-color:#FFAA01;
}
.bar1{
width:35px;
height:30px;
position: relative;
margin-top: 5px;
}
.bar1_on{
width:35px;
height:30px;
position: relative;
margin-top: 5px;
background-color:#FFAA01;
}
.shopcar_box{
position: relative;
left: 0;
top: 30%;
width: 280px;
text-align: center;
}
.shopcar_box h5{
color: #BBB;
}
.shopcar_box_image{
background: url(<%=tPath%>/images/sidebar.png) no-repeat;
display: block;
width: 150px;
height: 96px;
margin: 0 auto;
background-position: 0 -291px;
}
.button_login{
display: inline-block;
padding: 0 20px;
line-height: 26px;
background: #F60;
font: 700 14px/26px;
color: #FFF;
border-radius: 2px;
}
.bar1_div_title{
margin-top:0px;
position: relative;
height: 45px;
background: url(<%=tPath%>/images/finprite.png) center -200px no-repeat;
overflow: hidden;
}
.bar1_div_title{
display: inline-block;
width: 100%;
font: 400 14px "Microsoft YaHei";
text-shadow: 1px 1px 1px rgba(255,235,97,.7);
text-align: center;
line-height: 40px;
}
.bar1_div_login{
width: 250px;
margin: 0 auto;
background: #fff;
text-align: center;
font-size:14px;
color: #BBB;
margin-bottom: 10px;
}
.bar1_div_login a{
color: blue;
}
.bar1_div_box{
width: 100%;
height: 108px;
margin-bottom: 20px;
background: #f8f8f8;
overflow: hidden;
}
.bar1_div_box a{
display: inline;
float: left;
width: 50px;
height: 88px;
margin: 0 8px;
margin-top:20px;
text-align: center;
}
.bar1_div_box span{
display: block;
width: 50px;
height: 33px;
font: 400 12px/33px 'Microsoft YaHei';
text-align: center;
cursor: pointer;
}
.bar1_div_box i{
display: block;
width: 50px;
height: 50px;
background: url(<%=tPath%>/images/finprite.png) #ddd;
overflow: hidden;
cursor: pointer;
}
.bar1_div_box .fund i{
background-position: 0 -20px;
}
.bar1_div_box .bill i{
background-position: -50px -20px;
}
.bar1_div_box .fixdate i{
background-position: -100px -20px;
}
.bar1_div_box .cash i{
background-position: -150px -20px;
}

</style>
<script type="text/javascript" src="<%=tPath%>/assets/js/jquery-1.11.0.js"></script>
<script type="text/javascript">
   $(function (){	
	   $(".shopcar").hover(
	  			function () {
						$(this).css("background-color","#FFAA01");						
	 				 },
	  			function () {
	 					$(this).css("background-color","");
	  					}
					);
	   $(".shopcar").click(function(){
		   if($(".shopcar_div").css("display")=="none"){
		   		if($(".right-bar").children().eq(2).attr("class")=="bar1_on"){
				   $(".bar1_div").stop(true).animate({width: 'toggle'});  
				   $(".bar1_on").attr("class","bar1");
				   $(".bar1").css("background-color","#383838");
				   $(".bar1").children().eq(0).css("background-position",'-28px -84px');
				   $(".bar1").children().eq(2).css("display","none");					  
		  		 }
		   		if($(".right-bar").children().eq(0).attr("class")=="bar0_on"){
				   $(".user_div").stop(true).animate({width: 'toggle'});  
				   $(".bar0_on").attr("class","bar0");							   	
				   $(".bar0").css("background-color","#383838");
				   $(".bar0").children().eq(0).css("background-position",'-28px 5px');
				   $(".bar0").children().eq(1).css("display","none");				  
		 		  }		   
				   $(".shopcar").attr("class","shopcaron");	
				   $(".shopcaron").children().eq(1).css("display","block");
				   $(".shopcar_div").stop(true).animate({width: 'toggle'});  
			   }else{
				   $(".shopcaron").attr("class","shopcar");		
				   $(".shopcar").children().eq(1).css("display","none");
				   $(".shopcar_div").stop(true).animate({width: 'toggle'},100); 
				   $(".shopcar").css("background-color","#FFAA01");		
			  	 }
	  		 });
		$(".bar a").hover(
  			function () {
  					var v=$(this).children().eq(0).css("background-position");
					$(this).children().eq(0).css("background-color","#FFAA01");
					$(this).children().eq(0).css("color","#383838");	
					$(this).children().eq(0).css("background-position",'6px '+v.substr(5)+'');
					$(this).children().eq(1).stop(true).animate({width: 'toggle'});   
    				$(this).children().eq(1).css("background-color","#FFAA01");
					$(this).children().eq(1).css("color","#383838");
					$(this).children().eq(2).css("display","block");
 				 },
  			function () {
 					var v=$(this).children().eq(0).css("background-position");
					$(this).children().eq(0).css("background-color","#383838");
					$(this).children().eq(1).css("color","#FFAA01");	
					$(this).children().eq(0).css("background-position",'-28px '+v.substr(3)+'');  					
					$(this).children().eq(1).stop(true).animate({width: 'toggle'});  
					$(this).children().eq(1).css("background-color","#383838");
					$(this).children().eq(1).css("color","#FFAA01");
					$(this).children().eq(2).css("display","none");
  					}
				);
		$(".bar0").hover(
	  			function () {
						$(".bar0").css("background-color","#FFAA01");
						$(".bar0").children().eq(0).css("background-position",'6px 5px');										 					 
	 				 },
	  			function () {
						$(".bar0").css("background-color","#383838");
						$(".bar0").children().eq(0).css("background-position",'-28px 5px');  						
	  					}
					);
		$(".bar1").hover(
	  			function () {
						$(".bar1").css("background-color","#FFAA01");
						$(".bar1 .bar_div").css("background-color","#FFAA01");
						$(".bar1 .bar_div").css("color","#383838");		
						$(".bar1").children().eq(0).css("background-position",'6px -84px');
						$(".bar1 .bar_div").stop(true).animate({width: 'toggle'},300);   										 					 
	 				 },
	  			function () {
						$(".bar1").css("background-color","#383838");
						$(".bar1 .bar_div").css("background-color","#383838");
						$(".bar1 .bar_div").css("color","#FFAA01");
						$(".bar1").children().eq(0).css("background-position",'-28px -84px');  						
												
						if($(".bar1 .bar_div").css("display")=="none"){
							$(".bar1 .bar_div").css("display","none");
							}else{
								$(".bar1 .bar_div").stop(true).animate({width: 'toggle'},300);  
							}
	  					}
					);
		$(".bar0").click(function(){
			if($(".user_div").css("display")=="none"){
				if($(".right-bar").children().eq(1).attr("class")=="shopcaron"){
					   $(".shopcar_div").stop(true).animate({width: 'toggle'});  
					   $(".shopcaron").attr("class","shopcar");		
					   $(".shopcar").children().eq(1).css("display","none");					   
				   }
				if($(".right-bar").children().eq(2).attr("class")=="bar1_on"){
					   $(".bar1_div").stop(true).animate({width: 'toggle'});  
					   $(".bar1_on").attr("class","bar1");
					   $(".bar1").css("background-color","#383838");
					   $(".bar1").children().eq(0).css("background-position",'-28px -84px');
					   $(".bar1").children().eq(2).css("display","none");					  
				   }
				   $(".bar0").attr("class","bar0_on");
				   $(".user_div").stop(true).animate({width: 'toggle'});
				   $(this).children().eq(1).css("display","block");
			   }else{
				   $(".bar0_on").attr("class","bar0");
				   $(".user_div").stop(true).animate({width: 'toggle'},100);
				   $(this).children().eq(1).css("display","none");	
			   }
			});
		$(".bar1").click(function(){
			if($(".bar1_div").css("display")=="none"){
				if($(".right-bar").children().eq(1).attr("class")=="shopcaron"){
					   $(".shopcar_div").stop(true).animate({width: 'toggle'});  
					   $(".shopcaron").attr("class","shopcar");		
					   $(".shopcar").children().eq(1).css("display","none");					   
				   }
				if($(".right-bar").children().eq(0).attr("class")=="bar0_on"){
					   $(".user_div").stop(true).animate({width: 'toggle'});  
					   $(".bar0_on").attr("class","bar0");							   	
					   $(".bar0").css("background-color","#383838");
					   $(".bar0").children().eq(0).css("background-position",'-28px 5px');
					   $(".bar0").children().eq(1).css("display","none");
				   }
				   $(".bar1_div").stop(true).animate({width: 'toggle'});  
				   $(".bar1").attr("class","bar1_on");
				   $(".bar1_on").children().eq(2).css("display","block");
				   $(".bar1_on").children().eq(1).css("display","none");
				   $(".bar1_on").children().eq(0).css("background-position",'6px -84px');				   
			   }else{
				   $(".bar1_div").stop(true).animate({width: 'toggle'},100);  
				   $(".bar1_on").attr("class","bar1");
				   $(".bar1").children().eq(2).css("display","none");
			   }
			});
		
	});
   
  function gotoTop(){	  
	  $("html,body").animate({"scrollTop":0},500);
  }
</script>

<div class="right-bar">
	<div class="bar0" style="margin-top:180px;">
        	<li class="bar_image" style="background-position:-28px 5px;"></li>
        	<li class="spand" style="margin-top: -18px;"></li>   
    </div>

	<div class="shopcar">		
    	<li class="car"></li>
    	<li class="spand" style="margin-top: 26px;"></li>
        <span class="shop">购物车</span>
        <span class="number">0</span>      
    </div>
    <div class="bar1">      	
    	<li class="bar_image" style="background-position:-28px -84px; margin-top: 40px;"></li>       
        <span class="bar_div" style="width: 50px;">理财</span>
        <li class="spand" style="margin-top: -18px;"></li>        
    </div>
    <div class="bar">
    	<a href="javascript:bar2click()">
    	<li class="bar_image" style="background-position:-28px -114px;"></li>
        <span class="bar_div" style="width: 50px;">足迹</span>
        </a>
    </div>
    <div class="bar">
    	<a href="">
    	<li class="bar_image" style="background-position:-28px -284px;"></li>
        <span class="bar_div" style="width: 50px;">签到</span>
        </a>
    </div>
    <div class="bar">
    	<a href="">
    	<li class="bar_image" style="background-position:-28px -174px;"></li>
        <span class="bar_div">在线咨询</span>
        </a>
    </div>
    <div class="bar">
    	<a href="">
    	<li class="bar_image" style="background-position:-28px -204px;"></li>
        <span class="bar_div">意见反馈</span>
        </a>
    </div>
    <div class="bar">
    	<a href="">
    	<li class="bar_image" style="background-position:-28px -144px;"></li>
        <span class="bar6_div">
        	<img src="<%=tPath%>/assets/images/HomePages/code-img.png">
        </span>
        <li class="spand" style="margin-top: -18px;"></li>
        </a>
    </div>
	<div class="bar">		
		<a href="javascript:gotoTop()" title="返回顶部">
        	<li class="bar_image" style="background-position:-28px -234px;"></li>
        	<span class="bar_div">返回顶部</span>
        </a>
	</div>
	<div class="user_div">
        		<div class="user_div_box">
        			您好，请先<a href="" class="login">登录</a>
        		</div>
        		<div class="user_div_message">
        			<li class="user_div_li"></li>
        			<a href="" style="margin-left: 20px;">0首付低月供，任性购物快行动！点击查额。</a>
        		</div>
        	</div>    
    <div class="shopcar_div">
    	<div class="shopcar_box">
    		<li class="shopcar_box_image"></li>
    		<h5>不要让您的购物车空着哦，快去逛逛吧<br/><br/>
    			如果您已添加过宝贝，那就赶紧登录查看吧</h5>
    		<a href="<%=tPath%>/pages/HomePages/home_footerbar.jsp" class="button_login" style="color: white;">登录</a> 
    	</div>
    </div>
     <div class="bar1_div">
    		<div class="bar1_div_title">
    			<span>我的理财</span>
    		</div>
    		<div class="bar1_div_login">
    			<img src="<%=tPath%>/assets/images/HomePages/fin_unlogin.png"></img>
    			<span>想让赚钱更简单？赶快 <a href="">登陆</a> 吧！</span>
    		</div>
    		<div class="bar1_div_box">
    			<a target="_blank" title="基金理财" class="fund" href="">
    				<i></i>
    				<span>基金理财</span></a>
    			<a target="_blank" title="票据理财" class="bill" href="">
    				<i></i>
    				<span>票据理财</span></a>
    			<a target="_blank" title="定期理财" class="fixdate" href="">
    				<i></i>
    				<span>定期理财</span></a>
    			<a target="_blank" title="变现贷" class="cash" href="">
    				<i></i>
    				<span>变现贷</span></a>    		
    		</div>
    </div>
</div>
