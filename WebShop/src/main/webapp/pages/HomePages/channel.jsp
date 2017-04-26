<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style>
.lazy-floor {
    background: url(images/floor-bg.gif?v=7c19d) center center no-repeat;
}
.second-screen {
    position: relative;
    height: 430px;
    margin-top: 10px;
}
.second-screen .title {
    height: 40px;
    color: #222;
}
.second-screen .title h3 {
    float: left;
    font: bold 20px/40px 'microsoft yahei';
    margin: 0;
}
.second-screen .title h4 {
    float: left;
    padding-left: 6px;
	font: normal 16px/30px arial;
	margin: 5px 0 0 0;
}
.second-screen .feature-enter {
    float: left;
    width: 390px;
    height: 379px;
    margin-top: 10px;
    overflow: hidden;
}
.second-screen .feature-enter a {
    display: block;
    width: 390px;
    height: 188px;
    background: #fcf2f3;
    text-decoration: none;
}
.second-screen .feature-enter a .content {
    position: relative;
    float: left;
    width: 370px;
    height: 170px;
    margin: 10px 0 0 10px;
    background: #FFF;
}
.second-screen .feature-enter a .content p.enter-title {
    margin: 15px 0 0 20px;
    font: bold 20px/30px "Microsoft YaHei";
    color: #e23a54;
}
.second-screen .feature-enter a .content p.s-title {
    position: relative;
    width: 90px;
    height: 20px;
    margin: 1px 0 0 20px;
    background: #e23a51;
    color: #FFF;
    text-align: center;
    font: 14px/20px "Sim Sun";
}
.second-screen .feature-enter a .content p.enter-desc {
    width: 120px;
    height: 60px;
    overflow: hidden;
    margin: 8px 0 0 20px;
    font: 14px/20px "Microsoft YaHei";
    color: #999;
}
.second-screen .feature-enter a .content img {
    position: absolute;
    right: 40px;
    top: 10px;
}
.second-screen .feature-enter img {
    display: block;
    width: 150px;
    height: 150px;
}
.second-screen .feature-enter a.enter2 {
    height: 190px;
    margin-top: 1px;
    background: #eef7e6;
}
.second-screen .feature-enter a.enter2 .content p.enter-title {
    color: #79915f;
}
.second-screen .feature-list {
    float: left;
    width: 797px;
    height: 379px;
    background: #EEE;
    margin: 10px 0 0 12px;
}

.second-screen .feature-list li {
    float: left;
    width: 198px;
    height: 188px;
    margin: 1px 0 0 1px;
    overflow: hidden;
position: relative;
}

.second-screen .feature-list img {
    position: relative;
    display: block;
     width: 198px;
    height: 188px;
}

</style>
<div class="second-screen lazy-floor"
	data-fullid="184362">
	<div class="title">
		<h3>特色频道</h3>
		<h4>special</h4>
	</div>
	<div class="feature-enter">
		
	</div>
	<ul class="feature-list" id="feature-list">
		
	</ul>
</div>

<script>
$(function(){
	var b_type='0001' ; //类型
	var param = {
			actType:b_type
	};
    $.post('Activity/GetActivityInfo.action',param,function(data){
 /*  alert(JSON.stringify(data));   */
	if(data.rspCode=="000000"){		
		var len = data.objs.length;
		var title;
		var imgurl;
		var url;
		var subType;
		var temp1='',temp2='';
		for(var j=0;j<len;j++){
			actTitle = data.objs[j].actTitle;
			sTitle = data.objs[j].sTitle;
			actDesc = data.objs[j].actDesc;
			imgurl = data.objs[j].resUrl;
			url = data.objs[j].actUrl;		
			subType = data.objs[j].subType;
			if(subType=='01')
			{
				temp1+='<a href="'+url+'" title="'+actTitle+'"target="_blank" class="enter1" >';
				temp1+='<div class="content">';
				temp1+='<p class="enter-title">'+actTitle+'</p>';
				temp1+='<p class="s-title">'+sTitle+'<span></span></p>';
				temp1+='<p class="enter-desc">'+actDesc+'</p>';
				temp1+='<img src="'+imgurl+'"alt="'+actDesc+'" >';
				temp1+='</div>';
				temp1+='</a> ';
			}else if(subType=='02')
			{
				temp2+='<li >';
				temp2+='<a href="'+url+'" target="_blank" title="'+actTitle+'">';
				temp2+='<img alt="" class="lazy-loading" data-original="'+imgurl+'">';
				temp2+='</a>';
				temp2+='</li >';
			}
		}
		$(".second-screen .feature-enter").append(temp1);
		$(".second-screen .feature-list").append(temp2); 
		
		 $(".second-screen ul li").hover(function(){
				$(this).stop().fadeTo(500,0.5);
		},
		function(){
			$(this).stop().fadeTo(500,1);
		});
		
		$('img.lazy-loading').lazyload({placeholder : "images/lazyimages/whale-245x120.png",effect: "fadeIn"});
	}
	},"json");
	
    
   
});
</script>