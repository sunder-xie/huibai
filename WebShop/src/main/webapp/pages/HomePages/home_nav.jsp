<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="global_nav">
<div class="global_nav_bar">
	<div class="goods_nav">
	    <div class="nav_index">
			<a target="_blank" href="#" class = "all_hook">
			<span>全部商品分类</span></a>
		</div>
		<div  id="wrap_nav" class="wrap_nav">
			<%-- <%@ include file="nav_box_list.jsp"%> --%>
		</div>
	</div>
	<div class="func_nav">
		<ul>
			<li>
			<a href="<%=request.getContextPath()%>/pages/chuzu/chuzu.jsp">汇百易租</a></li>
			<li><a href="#">汇百超市</a></li>
			<li><a href="#">汇百拍卖</a></li>
			<li><a href="#">汇百家装</a></li>
			<li><a href="#">汇百建材</a></li>
			<li><a href="#">汇百金融</a></li>
		</ul>
	</div>
	<div class="ng-nav-right-txtact">
		<a target=_blank href="#"><b></b>新人福利 10元红包</a>
	</div>
	
	
</div>
</div>
<script type="text/javascript">

	$(function(){
		
		var basepath=null; /*根目录*/
	    
	    basepath=getRootPath();
	  //获取首页导航菜单
		var param = {
				'navType':'0001',
				'pclassify':'00000000'
		};
		var requestUrl = 'NavClassify/GetTopNavClassifyInfo.action';
		//导航兰的添加
		$.post(requestUrl,param,function(data){
			//alert(JSON.stringify(data));
			if(data.rspCode=="000000"){
				var len = data.length;
				var level,firstMenuNum=0;
				var item=' ';
				var NavMenu = '<div class="all-sort-list">' ;
				item += createTree(data.objs,"00000000");
		
				NavMenu+=item;
				NavMenu+='</div>';
				$("#wrap_nav").append(NavMenu);
				
				//导航栏效果
				$('.all-sort-list > .item').hover(
				function() {
					var eq = $('.all-sort-list > .item').index(this), //获取当前滑过是第几个元素
					h = $('.all-sort-list').offset().top, //获取当前下拉菜单距离窗口多少像素
					s = $(window).scrollTop(), //获取游览器滚动了多少高度
					i = $(this).offset().top, //当前元素滑过距离窗口多少像素
					item = $(this).children('.item-list').height(), //下拉菜单子类内容容器的高度
					sort = $('.all-sort-list').height(); //父类分类列表容器的高度
		
					if (item < sort) { //如果子类的高度小于父类的高度
						if (eq == 0) {
							$(this).children('.item-list').css('top', 0);
							//$(this).children('.item-list').css('top', (i - h));
						} else {
							$(this).children('.item-list').css('top', 0);
							//$(this).children('.item-list').css('top', (i - h) + 1);
						}
					} else {
						if (s > h) { //判断子类的显示位置，如果滚动的高度大于所有分类列表容器的高度
							if (i - s > 0) { //则 继续判断当前滑过容器的位置 是否有一半超出窗口一半在窗口内显示的Bug,
								$(this).children('.item-list').css('top', (s - h) + 2);
							} else {
								$(this).children('.item-list').css('top',
										(s - h) - (-(i - s)) + 2);
							}
						} else {
							$(this).children('.item-list').css('top', 3);
						}
					}
					$(this).addClass('hover');
					$(this).children('.item-list').css('display', 'block');
					
					createTree2(eq);
					createRightCont(eq);
					
				}, function() {
					$(this).removeClass('hover');
					$(this).children('.item-list').css('display', 'none');
				});
				
			}
		},"json");	
	});
	
	function createTree(jsons,pid){
	     if(jsons != null){
	         var ul = ' ' ;
	         var j=0;
	         var len,cflag,childlen,childname ,childurl,classify;
	         var icon = 'images/logo/whale-256x256.png';
	         var childlist ='';
	         len = jsons.length;
	         for(var i=0;i<len;i++){
	             if(jsons[i].pclassify == pid){
	            	 ul += '<div class="item">' ;
	            	 ul +=	'<h3><span style="background:url('+icon+') center center no-repeat; background-size: cover;"></span>';
	            	 cflag = jsons[i].cflag;
	            	 classify = jsons[i].classify;
	            	 if(cflag==1)
	            	 {
	            		 childlist='';
	            		 childlen = jsons[i].childNavClassify.length;
	                     for(j=0;j<childlen;j++)
	                     {
	                    	 childname = jsons[i].childNavClassify[j].cname;
	                    	 childurl = jsons[i].childNavClassify[j].url;
	                    	 childlist += '<a href="'+childurl+'?keyword='+childname+'">' + childname  +'</a>/';
	                     } 
	                     ul += childlist.substr(0,childlist.length-1);
	            	 }
	            	 
	            	 ul +=  '</h3>';
	            	 ul +=	'<div class="item-list clearfix">';
	            	 ul +=	'<div class="subitem" have-data="no" classify-id="'+classify+'">';
	            //     ul += createTree2(jsons,jsons[i].classify) ;
	                 ul +=	'</div>';
	 				
	                 ul +=	'<div class="cat-right">';
	                 ul +=  '<div class="right-ad-top" have-data="no" classify-id="'+classify+'">';
	             	 ul +=  '</div>';
	             	 ul +=  '<div class="right-ad-down" have-data="no" classify-id="'+classify+'">';
	            	 ul +=  '</div>';
	            	
	                 ul += '</div>';
	 				
	                 ul +=	'</div>';
	                 ul +=	'</div>';
	             }
	         }
	    }
	     return ul ;
	 }

	function createTree2(index){	
		
		$('.all-sort-list > .item').index(index);
		var havadata=$('.all-sort-list > .item').eq(index).find(".subitem").attr('have-data');
		if(havadata=='no')
		{
			var classify=$('.all-sort-list > .item').eq(index).find(".subitem").attr('classify-id');
			//获取首页导航菜单
			var param = {
					'navType':'0001',
					'pclassify':classify
			};
			var requestUrl = 'NavClassify/GetLastNavClassifyInfo.action';
			//导航兰的添加
			$.post(requestUrl,param,function(data){
//				alert(JSON.stringify(data));
				if(data.rspCode=="000000"){
					var ul='';
					var jsons = data.objs;
					var len,name,url;
					len = jsons.length;
		        	for(var i=0;i<len;i++){
		        		name =jsons[i].cname;
		            	url  =jsons[i].url;
			        	ul += '<dl class="fore1">';
			       	    ul +='<dt><a href="'+url+'?keyword='+name+'">'+name+'</a></dt>';
			       	    ul +='<dd>';
			            ul += createTree3(jsons[i].childNavClassify);
			            ul+='</dd></dl>';
		        	}
		        	$('.all-sort-list > .item').eq(index).find(".subitem").empty();
		        	$('.all-sort-list > .item').eq(index).find(".subitem").append(ul);
		        	$('.all-sort-list > .item').eq(index).find(".subitem").attr('have-data','yes');
				}
				else
				{
				}	
			},"json");	
		}
	}

	function createTree3(jsons){
	    if(jsons != null){
	    	var ul=' ';
	    	var cflag,len,name,url;
	    	len = jsons.length;
	        for(var i=0;i<len;i++){
	            	name =jsons[i].cname;
	            	url  =jsons[i].url;
	            	ul +='<em><a href="'+url+'?keyword='+name+'">'+ name +'</a></em>'
	        }
	   }
	   return ul;
	}

	function createRightTop(index){
		var havadata=$('.all-sort-list > .item').eq(index).find(".cat-right").find(".right-ad-top").attr('have-data');
		if(havadata=='no')
		{
			var classify=$('.all-sort-list > .item').eq(index).find(".cat-right").find(".right-ad-top").attr('classify-id');
			//获取首页导航菜单
			var map={
					'pclassify':classify
				};
//			alert(JSON.stringify(map));
			var param = {
					start:1,
					offset:6,			
					conditions:map
			};
			var requestUrl = 'Brand/GetBrandInfo.action';
			$.post(requestUrl,param,function(data){
//			alert(JSON.stringify(data));
				if(data.rspCode=="000000"){
					var ul='';
					var jsons = data.objs;
					var len,brandNm,url;
					len = jsons.length;
					url = 'pages/Search/SearchGoods.jsp?goods_id=';
		        	for(var i=0;i<len;i++){
		        		brandNm =jsons[i].brandNm;
		        		imgurl  =jsons[i].resUrl;
		        		url += brandNm;
		            	ul +='<a href="'+url+'">';
		//				imgurl='images/product/f1_01_02.png';
			    		ul +='	<img class="ad-top-lazy" data-original="'+imgurl+'" alt="'+brandNm+'"/>'
			    		ul +='</a>';
		        	}
		        	$('.all-sort-list > .item').eq(index).find(".cat-right").find(".right-ad-top").empty();
		    		$('.all-sort-list > .item').eq(index).find(".cat-right").find(".right-ad-top").append(ul);
		    		$('.all-sort-list > .item').eq(index).find(".cat-right").find(".right-ad-top").attr('have-data','yes');
		    		$('img.ad-top-lazy').lazyload({placeholder : "images/lazyimages/whale-120x50.png",effect: "fadeIn"});
				}
			},"json");	
		}	
	}

	function createRightDown(index){
		var havadata=$('.all-sort-list > .item').eq(index).find(".cat-right").find(".right-ad-down").attr('have-data');
		if(havadata=='no')
		{
			var ul='';
			var adType,imgurl;
			for(i=0;i<2;i++)
			{
				adType='02';
				if(adType=='02')
				{
					ul +='<a href="'+'#'+'">';
					imgurl='images/product/f1_01_02.png';
		    		ul +='	<img class="ad-down-lazy" data-original="'+imgurl+'"/>'
		    		ul +='</a>';
				}
			}
			$('.all-sort-list > .item').eq(index).find(".cat-right").find(".right-ad-down").empty();
			$('.all-sort-list > .item').eq(index).find(".cat-right").find(".right-ad-down").append(ul);
			$('.all-sort-list > .item').eq(index).find(".cat-right").find(".right-ad-down").attr('have-data','yes');
			$('img.ad-down-lazy').lazyload({placeholder : "images/lazyimages/whale-245x120.png",effect: "fadeIn"});
		}
		
	}
	function createRightCont(index){	
		createRightTop(index);
		createRightDown(index);
	}

</script>