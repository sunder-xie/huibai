<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style>
.content_middle {
    height: 450px;
    margin: 0px auto;
    position: relative;
    border: 1px solid #ccc;
}

.content_middle .common_da
{ width: 780px;
margin: 0px auto;
position: relative;
}

.content_middle:hover .common_da .common{
	display: block;
}
/*左右切换图标*/
.common_da .common{
	display: block;
	width:50px;
	height: 100px;
	position: absolute;
	z-index: 25;
    top:72%;
    margin-top: 150px;
    display: none;
}
.common_da .btnLeft{
	opacity: 0.5;
	left:0px;
	background: url(images/sprite.png) no-repeat 0px 0;
}
.common_da .btnRight{
	opacity: 0.5;
	right:0px; 
	background: url(images/sprite.png) no-repeat -50px 0;
}
/*左右切换图标*/
.content_middle ul li{
	width:100%;
	height:450px; 
	opacity: 0;
	filter: alpha(opacity=0);
	position: absolute;
	margin:0px auto;
}

.content_middle ul li a {
	width:100%;
	height:450px; 
	display: block;
}

.content_middle ul li a img{
	width: 780px;
height: 450px;
display: block !important;
margin: 0 auto;
}

/*切换小图标*/
.content_middle .table{
	width:740px; 
	height:33px;
	position: absolute;
	bottom:10px;
	left:50%;
	z-index:9;
	margin-left:-355px;  
	line-height: 24px; 
}
.content_middle .table a{
    width:115px;
    height:33px;  
    background:#E3DEE1;
    opacity: 0.8;
    text-align:center;
    line-height: 33px;
    margin-left:3px; 
    display: block;
    float:left;  
}

.content_middle .table a.small_active{
	background:#e31939;
	color: #fff;
	 
} 

img {
    margin: 0;
    padding: 0;
    border: 0;
    font-size: 100%;
    font: inherit;
    vertical-align: middle;
    -webkit-tap-highlight-color: transparent;
}

</style>
<div class="center_banner">
	<!-- 轮播图开始区域 -->
	<div class="content_middle">
		<div class="common_da">
			<a class="common btnLeft" href="javascript:;"></a>
			<a class="common btnRight" href="javascript:;"></a>
		</div>
		<ul>
		</ul>
		<div class="table">
		</div>
	</div>
</div>

<script type="text/javascript">	
	$(function(){
		var b_type='0001' ; //banner类型
		var param = {Type:b_type};
	    $.post('Banner/GetBannerInfo.action',param,function(data){
		/*   alert(JSON.stringify(data)); */
		var len = data.objs.length;
		var title;
		var imgurl;
		var url;
		var backgroud;
		var banner='';
        var banner_title= '';
		for(var j=0;j<len;j++){
			title = data.objs[j].title;
			imgurl = data.objs[j].imgUrl;
			url = data.objs[j].url;		
			background = data.objs[j].background;
			if(j==0)
			{
				banner+='<li style="opacity: 100; filter: alpha(opacity = 1);">';
				banner+='<a href ="'+url+'" style="background: #'+background+';">';
				banner+='	<img class="lazy" data-original="'+imgurl+'"/>';
				banner+='</a>';
				banner_title+='<a class="small_active" href="javascript:;">'+title+'</a> ';
			}else
			{
				banner+='<li >';
				banner+='<a href ="'+url+'" style="background: #'+background+';">';
				banner+='	<img class="lazy" data-original="'+imgurl+'" />';
				banner+='</a>';
				banner_title+='<a href="javascript:;">'+title+'</a> ';
			}
		}
		
		$(".content_middle ul").append(banner);
		$(".content_middle .table").append(banner_title); 
		
		 // 轮播图开始 
	    var left = $('.content_middle .btnLeft');//获取左点击
	    var right = $('.content_middle .btnRight');//获取右点击
	    var aSmall = $('.content_middle .table a');
	    var aLi = $('.content_middle ul li');
	    var iNow = 0;
	    var maxNum = len-1;
	     // 左点击  
	    left.click(function(){
	        iNow--;
	         // 判断回流
	        if(iNow<0){
	             iNow=maxNum;
	        }
	        aLi.eq(iNow).siblings().stop().animate({
	         opacity:0
	        
	       },1000);
	       aLi.eq(iNow).stop().animate({
	         opacity:1
	          
	       },1000);
	        aSmall.eq(iNow).addClass('small_active').siblings().removeClass('small_active');
	    });
	      // 右点击切换
	      right.click(function(){
	        iNow++;
	        if(iNow>maxNum){
	             iNow=0;
	        }
	        aLi.eq(iNow).siblings().stop().animate({
	         opacity:0
	        
	       },1000);
	       aLi.eq(iNow).stop().animate({
	         opacity:1
	          
	       },1000);
	        aSmall.eq(iNow).addClass('small_active').siblings().removeClass('small_active');

	    });

	      //手动切换
	    aSmall.mouseover(function(){
			var n = $(this).index();
			iNow = n;
	        aLi.eq(iNow).siblings().stop().animate({
	         opacity:0
	        
	       },1000);
	       aLi.eq(iNow).stop().animate({
	         opacity:1
	          
	       },1000);
	        aSmall.eq(iNow).addClass('small_active').siblings().removeClass('small_active');

	    });
	      
	    // 封装函数体
	    function move1(){
	         aLi.eq(iNow).siblings().stop().animate({
	             opacity:0
	            
	           },1000);
	           aLi.eq(iNow).stop().animate({
	             opacity:1
	           },1000);
	         
	           aSmall.eq(iNow).addClass('small_active').siblings().removeClass('small_active');
	    }

	    // 定个定时器的初始值
	    function run2(){ 
	         iNow++;
	          if(iNow>maxNum){
	                 iNow=0;
	            }
	          move1();  
	    }

	    //定时器
	    timer = setInterval(run2,5000);

	    //当鼠标划入，停止轮播图切换
	     $(".content_middle").hover(function(){
	       clearInterval(timer);
	    },function(){
	       timer = setInterval(run2,5000);
	    }) ;
	    
	    $('img.lazy').lazyload({placeholder : "images/lazyimages/whale-780x450.png",effect: "fadeIn"});
	},"json");
});
	
	
$(function(){
var map={
	keyword:''
};
var param = {
	start:1,
	offset:5,			
	conditions:map
};
//向服务器发送请求，查询满足条件的记录  
$.post("Notice/GetNoticeAll.action",param,function(data){
	if(data.rspCode=="000000"){			
	//	alert(JSON.stringify(data));
		var datatable='';
		datatable ='<ul class="list">';
	    var num= data.result.length < data.offset ? data.result.length :data.offset;
	   
		for (var i=0;i<num;i++)
		{
			var noteType= data.result[i].type;
			if(data.result[i].type=='01')
			{
				noteType = '公告';
			}else if(data.result[i].type=='02')
			{
				noteType = '促销';
			}else{
				noteType = '公告';
			}
		    if(data.result[i].hot==1)
			{
		    	datatable+= '<li class="hot"> <a href="pages/announce/annoDetail.jsp?noteId=' ;
				datatable+= data.result[i].noteId;
				datatable+= '" rel="nofollow" target="_blank">';
				datatable+= '<i>【'+noteType+'】</i>'+'<em>'+data.result[i].title+'</em>';
				datatable+="</a>" ;
				datatable+="</li>";
			}
			else
			{
				datatable+= '<li> <a href="pages/announce/annoDetail.jsp?noteId=' ;
				datatable+= data.result[i].noteId;
				datatable+= '" rel="nofollow" target="_blank">';
				datatable+= '<i>【'+noteType+'】</i>'+'<em>'+data.result[i].title+'</em>';
				datatable+="</a>" ;
				datatable+="</li>";
			}
	    }
		datatable+= "</ul>";
		$("#index-notice").append(datatable);
	}
	},"json");
});
</script>
		