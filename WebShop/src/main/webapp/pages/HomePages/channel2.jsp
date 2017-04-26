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
		<!-- <a href="http://ju.suning.com/" title="大聚惠"
			name="index3_homepage1_1843627701_pic01" target="_blank"
			class="enter1" data-swidth="">
			<div class="content">
				<p class="enter-title">大聚惠</p>
				<p class="s-title">
					有道理的便宜<span></span>
				</p>
				<p class="enter-desc">百草味年货大礼包</p>
				<img src="//image5.suning.cn/uimg/cms/img/148214853847681390.jpg"
					alt="百草味年货大礼包" >
			</div>
		</a> <a href="http://chaoshi.suning.com/" title="苏宁超市"
			name="index3_homepage1_1843627701_pic02" target="_blank"
			class="enter2">
			<div class="content">
				<p class="enter-title">苏宁超市</p>
				<p class="enter-desc">维达抽纸 细韧3层140抽软抽*18包</p>
				<img alt="维达抽纸 细韧3层140抽软抽*18包" class="lazy-loading"
					src="//image3.suning.cn/uimg/cms/img/148211504816913684.jpg" >
			</div>
		</a> -->
	</div>
	<ul class="feature-list" id="feature-list">
		<!-- <li>
			<a href="http://new.suning.com/" target="_blank" title="新欢"
				name="index3_homepage1_1843627702_widscr01"><img alt=""
					class="lazy-loading"
					src="//image4.suning.cn/uimg/cms/img/148222229077741050.jpg"></a>
		</li>
		<li><a href="http://zc.suning.com/" target="_blank" title="众筹"
			name="index3_homepage1_1843627702_widscr02"><img alt=""
				class="lazy-loading"
				src="//image4.suning.cn/uimg/cms/img/148214732219919665.jpg"></a></li>
		<li><a href="http://smarthome.suning.com/s_mall.html"
			target="_blank" title="智能生活"
			name="index3_homepage1_1843627702_widscr03"><img alt=""
				class="lazy-loading"
				src="//image2.suning.cn/uimg/cms/img/148219594907325381.jpg"></a></li>
		<li><a href="http://g.suning.com/" target="_blank" title="海外购"
			name="index3_homepage1_1843627702_widscr04"><img alt=""
				class="lazy-loading"
				src="//image1.suning.cn/uimg/cms/img/148221278460820865.jpg"></a></li>
		<li><a href="http://hx.suning.com/" target="_blank" title="以旧换新"
			name="index3_homepage1_1843627702_widscr05"><img alt=""
				class="lazy-loading"
				src="//image1.suning.cn/uimg/cms/img/148153432545113892.jpg"></a></li>
		<li><a
			href="https://licai.suning.com/lcportal/licaiIndex.htm?channelCode=PC_YGMstation"
			target="_blank" title="理财"
			name="index3_homepage1_1843627702_widscr06"><img alt=""
				class="lazy-loading"
				src="//image3.suning.cn/uimg/cms/img/148187668956370353.jpg"></a></li>
		<li><a href="http://china.suning.com/" target="_blank"
			title="中华特色馆" name="index3_homepage1_1843627702_widscr07"><img
				alt="" class="lazy-loading"
				src="//image1.suning.cn/uimg/cms/img/148212886019977295.jpg"></a></li>
		<li><a href="http://pindao.suning.com/fbs_index.html"
			target="_blank" title="名品20"
			name="index3_homepage1_1843627702_widscr08"><img alt=""
				class="lazy-loading"
				src="//image5.suning.cn/uimg/cms/img/148186884232907698.jpg"></a></li> -->
	</ul>
</div>

<script>
$(function(){
	var b_type='0001' ; //类型
	var param = {
			actType:b_type
	};
    $.post('Activity/GetActivityInfo.action',param,function(data){
	/*   alert(JSON.stringify(data));  */
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
			url = data.objs[j].url;		
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
			}else
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