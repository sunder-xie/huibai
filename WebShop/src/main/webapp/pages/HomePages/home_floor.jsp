<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="f_ad-show"></div>
<script rel="stylesheet" src="assets/plugs/jquery/jquery-1.11.3.min.js"></script>
<script>
var basepath=null; /*根目录*/
basepath=getRootPath();
$(function(){
	
	var b_type='0001' ; //首页类型
	
	var param = {'type':b_type};
	$.post('Floor/GetAllFloorInfo.action',param,function(data){
		/* alert(JSON.stringify(data)); */
		if(data.rspCode=="000000")
		{
    		var len = data.objs.length;
    		var title;
    		var imgurl;
    		var url;
    		var banner='';
    		var item='';
    		var FId,Fnm,tab1,tab2,keyword,floorAd;
    		var search = basepath+'pages/Search/SearchGoods.jsp?keyword=';
    		for(var i=0;i<len;i++)
    		{
    			FId= data.objs[i].FId;
    			FNm= data.objs[i].FNm;
    			tab1= data.objs[i].tab1;
    			tab2= data.objs[i].tab2;
    			keyword= data.objs[i].keyword;
    			floorAd=data.objs[i].FloorAdInfo;
    			banner+='<div class="ad-show">';
    			//头部
        		banner+='<div class="ad-nav">';
        		banner+='<h3>'+FNm+'</h3>';
        		banner+='<ul class="ad-main">';
        		banner+='<li class="tab-1 mouseen">'+tab1+'</li>';
        		banner+='<li class="tab-2 ">'+tab2+'</li>';
        		banner+='</ul>'; 
        		banner+='<ul class="ad-hot">';
        		var c=keyword.split('|');
        		for(var j=0;j<c.length;j++)
        		{
        			banner+='<li><a href="'+search+c[j]+'">'+c[j]+'</a></li>';
        		}
        		banner+='</ul>'; 
        		banner+='</div>';
        		
        		//具体内容
        		banner+='<div id="f_ad_'+FId+'" class="ad-image" data_id="'+FId+'" have-data="no">';
        		//热卖活动
        		banner+=createfloorAd(FId,floorAd);
        		//热卖商品
        		banner+='</div>';
        		banner+='</div>';
    		}
    		$("#f_ad-show").append(banner);
    		$('img.floor-lazy').lazyload({placeholder : "images/lazyimages/whale-780x450.png",effect: "fadeIn"});
    		$(document).ready(function(){
    	        $('.tab-1').mouseover(function(){
    	            $(this).addClass('mouseen');
    	            $(this).next().removeClass('mouseen');
    	            $(this).parent().parent().next().children().next().show();
    	            $(this).parent().parent().next().children().next().next().hide();
    	        });
    	        $('.tab-2').mouseover(function(){
    	            $(this).addClass('mouseen');
    	            $(this).prev().removeClass('mouseen');
    	            $(this).parent().parent().next().children().next().hide();
    	            $(this).parent().parent().next().children().next().next().show();
    	            var floorId=$(this).parent().parent().next().attr('data_id');
    	            var have_data = $(this).parent().parent().next().attr('have-data');
    	            if(have_data=='no'){
    	            	createfloorGoods(floorId);
    	            }
    	        });
    	    });
		}
	},"json");
}); 

function createfloorGoods(floorId){
	var f_ad='#f_ad_'+floorId;
	var f_goods='#f_goods_'+floorId;
	var ul='';
	
	var map={
			"keyword":''
	};
//		alert(JSON.stringify(map));
	var param = {
				start:1,
				offset:10,			
				conditions:map
	};
	$.post(basepath+'Search/serGoodsShortInfListByKeyword.action',param,function(data){
	   /*  alert(JSON.stringify(data)); */
		if(data.rspCode=="000000"){
			var len = data.result.length;
			var i;
			var url,imgUrl,goodsNm,price;
			var goods=data.result;
			for(i=0;i<len;i++)
			{
				url=basepath+'pages/Goods/goodsInfo.jsp?goods_id='+goods[i].goodsId;
				imgUrl=goods[i].mainPicUrl;
				goodsNm=goods[i].goodsNm;
				price=AmtToDecimal2(goods[i].amount);
				ul+='<li><p class="face">';
				ul+='<a href="'+url+'" target="_blank"><img class="floor-lazy" data-original="'+imgUrl+'" alt="'+goodsNm+'"/></a>';
				ul+='</p>';
				ul+='<p class="name"><a href="'+url+'" target="_blank">'+goodsNm+'</a></p>';
				ul+='<p class="price">';
				ul+='<i>¥</i>';
				ul+='<span>'+price+'</span>';
				ul+='</p>';
				ul+='</li>';
			}
			$(f_ad).attr('have-data','yes');
			$(f_goods).empty();
			$(f_goods).append(ul);
			$('img.floor-lazy').lazyload({placeholder : "images/lazyimages/whale-780x450.png",effect: "fadeIn"});
		}
		
	},"json");
}

function createfloorAd(FId,floorAd){
    if(floorAd != null){
    	var i=0;
    	var ul='';
    	var url,resUrl,adType;
    	var fidname='f_goods_'+FId;
        var len=floorAd.length;
  		ul +='<div class="ad-com">';
  		ul +='<div class="ad-tel">';
  		for(i=0;i<len;i++)
  		{
  			adType=floorAd[i].adType;
  			url=floorAd[i].url;
  			resUrl=floorAd[i].resUrl;
  			if(adType=='00')
  			{
  				ul +='<a href="'+url+'">';
          		ul +='<img class="floor-lazy" data-original="'+resUrl+'"/>';
          		ul +='</a>';
          		break;
  			}
  		}
  		ul +='</div>';
  		
  		ul +='<div class="ad-pp">';
  		for(i=0;i<len;i++)
  		{
  			adType=floorAd[i].adType;
  			url=floorAd[i].url;
  			resUrl=floorAd[i].resUrl;
  			if(adType=='01')
  			{
  				ul +='<a href="'+url+'">';
          		ul +='<img width="90" height="52" class="floor-lazy" data-original="'+resUrl+'"/>';
          		ul +='</a>';
  			}
  		}
  		ul +='</div>';
  		
  		ul +='</div>';
  		
  		ul +='<div class="ad-coms tab--1">';
  		
   		ul +='<div class="ad-left">';
   		for(i=0;i<len;i++)
   		{
  			adType=floorAd[i].adType;
  			url=floorAd[i].url;
  			resUrl=floorAd[i].resUrl;
   			if(adType=='02')
   			{
   				ul +='<a href="'+url+'">';
           		ul +='<img class="floor-lazy" data-original="'+resUrl+'"/>';
           		ul +='</a>';
   			}
   		}
   		ul +='</div>';
  		
   		ul +='<div class="ad-center">';
   		ul+='<ul>';
   		for(i=0;i<len;i++)
   		{
  			adType=floorAd[i].adType;
  			url=floorAd[i].url;
  			resUrl=floorAd[i].resUrl;
   			if(adType=='03')
   			{
   				ul +='<li><a href="'+url+'">';
           		ul +='<img class="floor-lazy" data-original="'+resUrl+'"></img>';
           		ul +='</a></li>';
   			}
   		}
   		ul+='</ul>';
   		ul +='</div>';
  		
   		ul +='<div class="ad-right">';
   		ul+='<ul>';
   		for(i=0;i<len;i++)
   		{
  			adType=floorAd[i].adType;
  			url=floorAd[i].url;
  			resUrl=floorAd[i].resUrl;
   			if(adType=='04')
   			{
   				ul +='<li><a href="'+url+'">';
           		ul +='<img class="floor-lazy" data-original="'+resUrl+'"/>';
           		ul +='</a></li>';
   			}
   		}
   		ul+='</ul>';
   		ul +='</div>';
  		ul +='</div>';
  		
  		ul+='<div class="ad-coms tab--2"  style="display:none">';
  		ul+='<ul class="tab2" id="'+fidname+'">';
  		   /* for(x=0;x<10;x++)
  			{
	    		ul+='<li><p class="face">';
	    		ul+='<a href="" target="_blank"><img src="assets/images/shopping/tel1.jpg" alt=""/></a>';
	    		ul+='</p>';
	    		ul+='<p class="name">Apple iPhone SE 16GB 玫瑰金色</p>';
	    		ul+='<p class="price">';
	    		ul+='<i>¥</i>';
	    		ul+='<span><b>3625</b> ".00"</span>';
	    		ul+='</p>';
	    		ul+='</li>';
  			} */
  		ul+='</ul>';   
  		ul+='</div>';  
  		
  		return ul;
   }          
}

   /*  function createbrand2(fid){	
   	    var banner='';
   	    var fidname='f_ad_image_'+fid;
   	    banner+='<div class="ad-coms tab--2"  style="display:none">';
   	 	banner+='<ul class="tab2">';
   		banner+='<li><p class="face">';
   		banner+='<a href="" target="_blank"><img src="assets/images/shopping/tel1.jpg" alt=""/></a>';
   		banner+='</p>';
   		banner+='<p class="name">Apple iPhone SE 16GB 玫瑰金色</p>';
   		banner+='<p class="price">';
   		banner+='<i>¥</i>';
   		banner+='<span><b>3625</b> ".00"</span>';
   		banner+='</p>';
   		banner+='</li>';
   		banner+='</ul>';  
   		banner+='</div>';  
   		$("#"+fidname).append(banner);
    }
    function createbrand1(fid){
        if(fid != null){
        	var i=0;
        	var ul='';
        	var fidname='f_ad_image_'+fid;
        	var param = {    
        			'fid':fid,
        			'type':'0001'
        	};
            $.post('FloorAd/GetFloorAdInfo.action',param,function(data){
            	alert(JSON.stringify(data)); 
        		if(data.rspCode=="000000")
        		{
	        		ul +='<div class="ad-com">';
	        		ul +='<div class="ad-tel">';
	        		for(i=0;i<data.objs.length;i++)
	        		{
	        			if(data.objs[i].adType=='00')
	        			{
	        				ul +='<a href="'+data.objs[i].url+'">';
	                		ul +='<img  src="'+data.objs[i].resUrl+'"/>';
	                		ul +='</a>';
	                		break;
	        			}
	        		}
	        		ul +='</div>';
	        		
	        		ul +='<div class="ad-pp">';
	        		for(i=0;i<data.objs.length;i++)
	        		{
	        			if(data.objs[i].adType=='01')
	        			{
	        				ul +='<a href="'+data.objs[i].url+'">';
	                		ul +='<img width="90" height="52" src="'+data.objs[i].resUrl+'"/>';
	                		ul +='</a>';
	        			}
	        		}
	        		ul +='</div>';
	        		
	        		ul +='</div>';
	        		
	        		ul +='<div class="ad-coms tab--1">';
	        		
		        		ul +='<div class="ad-left">';
		        		for(i=0;i<data.objs.length;i++)
		        		{
		        			if(data.objs[i].adType=='02')
		        			{
		        				ul +='<a href="'+data.objs[i].url+'">';
		                		ul +='<img src="'+data.objs[i].resUrl+'"/>';
		                		ul +='</a>';
		        			}
		        		}
		        		ul +='</div>';
	        		
		        		ul +='<div class="ad-center">';
		        		ul+='<ul>';
		        		for(i=0;i<data.objs.length;i++)
		        		{
		        			if(data.objs[i].adType=='03')
		        			{
		        				ul +='<li><a href="'+data.objs[i].url+'">';
		                		ul +='<img src="'+data.objs[i].imgUrl+'"></img>';
		                		ul +='</a></li>';
		        			}
		        		}
		        		ul+='</ul>';
		        		ul +='</div>';
	        		
		        		ul +='<div class="ad-right">';
		        		ul+='<ul>';
		        		for(i=0;i<data.objs.length;i++)
		        		{
		        			if(data.objs[i].adType=='04')
		        			{
		        				ul +='<li><a href="'+data.objs[i].url+'">';
		                		ul +='<img src="'+data.objs[i].imgUrl+'"/>';
		                		ul +='</a></li>';
		        			}
		        		}
		        		ul+='</ul>';
		        		ul +='</div>';
	        		ul +='</div>';
	        		
	        		ul+='<div class="ad-coms tab--2"  style="display:none">';
	        			ul+='<ul class="tab2">';
	        		   for(x=0;x<10;x++)
	        			{
			        		ul+='<li><p class="face">';
			        		ul+='<a href="" target="_blank"><img src="assets/images/shopping/tel1.jpg" alt=""/></a>';
			        		ul+='</p>';
			        		ul+='<p class="name">Apple iPhone SE 16GB 玫瑰金色</p>';
			        		ul+='<p class="price">';
			        		ul+='<i>¥</i>';
			        		ul+='<span><b>3625</b> ".00"</span>';
			        		ul+='</p>';
			        		ul+='</li>';
	        			}
	        		   ul+='</ul>';   
	        		ul+='</div>';  
	        		
	        		$("#"+fidname).append(ul);
        		
        		}   
        	},"json");
       }          
    } */
   
 </script>
