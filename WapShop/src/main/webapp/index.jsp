<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="yes" name="apple-touch-fullscreen">
<meta content="telephone=no" name="format-detection">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1;user-scalable=no;">
<%@ include file="pages/common/base.jsp" %>
<base href="<%=tBasePath%>"></base>

<script charset="utf-8" src="js/global.js?v=0.01"></script>
<script charset="utf-8" src="js/bootstrap.min.js?v=0.01"></script>
<script charset="utf-8" src="js/template.js?v=0.01"></script>

<link rel="stylesheet" href="css/bootstrap.css?v=0.01">
<link rel="stylesheet" href="css/style.css?v=1?v=0.01">

<title>乐汇百材hbaicai.com</title>
</head>
<body>
<header class="header">
	<div class="fix_nav">
		<div class="nav-serach">
			<div class="nav-left">
			  <a href="pages/category/category_m.jsp"><img src="images/index-white.png"></a>
			</div>
			<div class="navbar-search left-search">
					<input type="text" placeholder="搜索商品" class="form-control" onclick="javascript:openSearch();"/>
			</div>
			<div class="nav-right">
				<a><img src="images/logo/whale-256x256.png"></a>
			</div>
		</div>
	</div>
</header>
<div id="sbox" style="display: none">
	<div class="nav-serach">
			<div class="nav-left">
			  <a href="pages/category/category_m.jsp"><img src="images/index-white.png"></a>
			</div>
			<form id="searchform" name="searchform" action="" onsubmit="return false;">
				<div class="navbar-search left-search">
						<input type="search" id="searchKey" name="keyword" value="" placeholder="搜索商品" class="form-control"/>
				</div>
				<div class="nav-right mt5">
					<a href="javascript:cancelSearch();"><span class="pull-right white">取消</span></a>
				</div>
			</form>
	</div>
	
	<div class="container mb50">
		<div class="row mb10 search-keyword">
				<div class="list-group-item">
					最近搜索： <a><span class="pull-right opertion">删除</span></a>
				</div>
				<div class="list-group-item keyword-row">
					<ul class="tags">
						<li class="keyword"><a href="javascript:search('环氧')">环氧</a></li>
					</ul>
				</div>
				
				<div class="list-group-item">
					热门搜索： <a><span class="pull-right opertion">换一批</span></a>
				</div>
				<div class="list-group-item keyword-row">
				<ul class="tags">
						<li class="keyword"><a href="javascript:search('环氧')">环氧</a></li>
						<li class="keyword"><a href="javascript:search('固化剂')">固化剂</a></li>
					</ul>
				</div>
			</div>
	</div>	
</div>

<div class="container" id="container">
    <div class="row">
        <div id="slide">
         <div class="hd">
         		<ul></ul>
         </div>
         <div class="bd">
               <ul ></ul>
         </div>
        </div>
    </div>
		
<script charset="utf-8" src="js/TouchSlide.js"></script>

<script type="text/javascript">
    $(function(){
    	
    	$('#searchKey').bind('search', function () {
             var keyword = $('#searchKey').val();
             search(keyword);
    	 });
    	
    	checkInputEvent();
    	
		var b_type='0001' ; //banner类型
		var param = {Type:b_type};
	    $.post('Banner/GetBannerInfo.action',param,function(data){
			/* alert(JSON.stringify(data));  */
			var len = data.objs.length;
			var banner_hd='',banner_bd='';
			for(var j=0;j<len;j++){
				var title = data.objs[j].title;
				var imgurl = data.objs[j].imgUrl;
				var url = data.objs[j].url;		
				var background = data.objs[j].background;
				
				banner_hd+='<li>'+j+'</li>';
				
				banner_bd+='<li><a href ="'+url+'" target="_blank">';
				banner_bd+='	<img src="images/loading.gif" _src="'+imgurl+'"/>';
				banner_bd+='</a></li>';
			
			}
            $("#slide .hd ul").empty();
            $("#slide .bd ul").empty();
		    $("#slide .hd ul").append(banner_hd);
		    $("#slide .bd ul").append(banner_bd);
		    
		    TouchSlide({
				slideCell:"#slide",
				titCell:".hd ul", //开启自动分页 autoPage:true ，此时设置 titCell 为导航元素包裹层
				mainCell:".bd ul",
				effect:"left",
				autoPlay:true,//自动播放
				autoPage:true, //自动分页
				switchLoad:"_src" //切换加载，真实图片路径为"_src"
			});
			},"json"); 
	});
    
    var openSearch = function(){
    	$('.header').hide();
    	$('#container').hide();
    	$('#sbox').show();
    };
    
    var cancelSearch = function(){
    	$('.header').show();
    	$('#container').show();
    	$('#sbox').hide();
    };
    
    var search = function(keyword){
    	window.location = "pages/search/searchGoods.jsp?keyword="+keyword;
    };
    
    function checkInputEvent(){
		$("#searchKey").keypress(onNormalLogonKeyPress);
	}
	
	//普通登录处理回车事件
	function onNormalLogonKeyPress(evt) {
	  	//兼容IE和Firefox获得keyBoardEvent对象
		evt = (evt) ? evt : ((window.event) ? window.event : "")
		//兼容IE和Firefox获得 keyBoardEvent对象的键值
		var keyCode = evt.keyCode?evt.keyCode:evt.which;
		if(keyCode==13) {
			var keyword = $('#searchKey').val();
			search(keyword);
		}
	}
    
</script>
<div class="row category">
        <a href="pages/search/searchGoods.jsp" class="col-xs-3">
            <img class="img-responsive" src="img/icon_rm.png">
            <h4>热门</h4>
        </a>
        <a href="pages/search/searchGoods.jsp" class="col-xs-3">
            <img class="img-responsive" src="img/icon_tm.png">
            <h4>精品</h4>
        </a>
        <a href="pages/search/searchGoods.jsp?classify=" class="col-xs-3">
            <img class="img-responsive" src="img/theme.png">
            <h4>专题列表</h4>
        </a>
        <a href="pages/search/searchGoods.jsp?classify=" class="col-xs-3">
            <img class="img-responsive" src="img/icon_pp.png">
            <h4>品牌</h4>
        </a>
    </div>
  
<div class="row" id="floor-row">

		<!--产品块-->
		<!-- <div class="tb_box">
			<h2 class="tab_tit">
				<a class="more" href="http://m.hbaicai.com/m_search/list?categoryId=36">更多</a>
				礼品箱包</h2>

				<div class="tb_type tb_type_even clearfix">
					<a class="tb_floor" href="views.html"> <img
						src="img/c2abb958-aca8-42f2-be52-ee1c072caec0.jpg"
						style="width: 100%;">
					</a> <a class="th_link" href="views.html"> <img class="tb_pic"
						src="img/e71099af-8a08-45f5-af16-4e8edf2f1bff.jpg"
						style="width: 100%;">
					</a> <a class="th_link tb_last" href="views.html"> <img
						class="tb_pic" src="img/33c256a8-7bff-4c6b-8686-f209bbad1301.jpg"
						style="width: 100%;">
					</a>
				</div>
			</div> -->
		<!--产品块-->
		<!-- <div class="tb_box">
			<h2 class="tab_tit">
				<a class="more" href="http://m.hbaicai.com/m_search/list?categoryId=38">更多</a>
				服饰鞋帽</h2>

				<div class="tb_type clearfix">
					<a class="tb_floor" href="views.html"> <img
						src="img/0bbbb6bf-0d00-45c0-92f7-347377f2edb5.jpg"
						style="width: 100%;">
					</a> <a class="th_link" href="views.html"> <img class="tb_pic"
						src="img/0d86960d-20b5-4dd3-afee-8453b5ea5e95.jpg"
						style="width: 100%;">
					</a> <a class="th_link tb_last" href="views.html"> <img
						class="tb_pic" src="img/1e13498f-419d-4ebd-a3b2-d0ad95ceaa39.jpg"
						style="width: 100%;">
					</a>
				</div>
			</div> -->
		<!--产品块-->
		<!-- <div class="tb_box">
			<h2 class="tab_tit">
				<a class="more" href="http://m.hbaicai.com/m_search/list?categoryId=35">更多</a>
				数码办公</h2>
			
			<div class="tb_type  tb_type_even clearfix"><a class="tb_floor" href="views.html">
								<img src="img/bd6771d9-f220-454d-83b2-d58d2046d23a.jpg" style="width:100%;">
							</a>
						<a class="th_link" href="views.html">
								<img class="tb_pic" src="img/04ef50d9-97f0-4fea-8359-ee21376df392.jpg" style="width:100%;">
	                		</a>
						<a class="th_link tb_last" href="views.html">
								<img class="tb_pic" src="img/d07a93ef-cdff-4b21-a12b-d817890aa6d6.jpg" style="width:100%;">
	                		</a>
			</div>
		</div> -->
		</div>
	 
</div>

<script type="text/javascript">
    $(function(){
    	var b_type='0001' ; //首页类型
    	var param = {'type':b_type};
    	var floorNum;
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
        		var moreUrl= 'pages/search/searchGoods.jsp?classify=';
        		for(var i=0;i<len;i++)
        		{
        			FId= data.objs[i].FId;
        			FNm= data.objs[i].FNm;
        			classify = data.objs[i].classify;
        			banner+='<div class="tb_box">';
        			banner+='<h2 class="tab_tit">';
        			banner+='	<a class="more" href="'+moreUrl+classify+'">更多</a>'+FNm+'</h2>';
        			
        			if(i%2)
        			banner+='<div class="tb_type  tb_type_even clearfix" id="f_'+FId+'">';
        			else
        			banner+='<div class="tb_type clearfix" id="f_'+FId+'">';
        			
        			/* banner+='	<a class="tb_floor" href="views.html">';
        			banner+='		<img src="img/bd6771d9-f220-454d-83b2-d58d2046d23a.jpg" style="width:100%;">';
        			banner+='	</a>';
        			banner+='	<a class="th_link" href="views.html">';
        			banner+='		<img class="tb_pic" src="img/04ef50d9-97f0-4fea-8359-ee21376df392.jpg" style="width:100%;">';
        			banner+='     </a>';
        			banner+='	<a class="th_link tb_last" href="views.html">';
        			banner+='		<img class="tb_pic" src="img/d07a93ef-cdff-4b21-a12b-d817890aa6d6.jpg" style="width:100%;">';
        			banner+='    </a>';  */
        			banner+='</div>';
        			banner+='</div>';
        		}
        		$("#floor-row").append(banner);
        		
        		for(var i=0;i<len;i++)
        		{
        			FId= data.objs[i].FId;
        			createfloorGoods(FId);
        		}
        		//$('img.floor-lazy').lazyload({placeholder : "images/lazyimages/whale-780x450.png",effect: "fadeIn"});
    		}
    	},"json");
    	
    	
	});
    
    function createfloorGoods(floorId){
    	var f_goods='#f_'+floorId;
    	var ul='';
    	
    	var map={
    			"keyword":''
    	};
//    		alert(JSON.stringify(map));
    	var param = {
    				start:1,
    				offset:3,			
    				conditions:map
    	};
    	$.post('Search/serGoodsShortInfListByKeyword.action',param,function(data){
    	    /* alert(JSON.stringify(data)); */
    		if(data.rspCode=="000000"){
    			var len = data.result.length;
    			var i;
    			var url,imgUrl,goodsNm,price;
    			var goods=data.result;
    			for(i=0;i<len;i++)
    			{
    				url='pages/Goods/goodsInfo.jsp?goods_id='+goods[i].goodsId+'&shop_id='+goods[i].shopId;
    				imgUrl=goods[i].mainPicUrl;
    				/* goodsNm=goods[i].goodsNm;
    				price=AmtToDecimal2(goods[i].amount); */
    				
    				if(i==0)
    				{
	    				ul+='	<a class="tb_floor" href="'+url+'">';
	    				ul+='		<img src="'+imgUrl+'" style="width:100%;">';
	    				ul+='	</a>';
    				}else if(i==1){
    					ul+='	<a class="th_link" href="'+url+'">';
        				ul+='		<img class="tb_pic" src="'+imgUrl+'" style="width:100%;">';
        				ul+='     </a>';
    				}
    				else{
	    				ul+='	<a class="th_link tb_last" href="'+url+'">';
	    				ul+='		<img class="tb_pic" src="'+imgUrl+'" style="width:100%;">';
	    				ul+='    </a>';
    				}
        			
    				/* ul+='<li><p class="face">';
    				ul+='<a href="'+url+'" target="_blank"><img class="floor-lazy" data-original="'+imgUrl+'" alt="'+goodsNm+'"/></a>';
    				ul+='</p>';
    				ul+='<p class="name"><a href="'+url+'" target="_blank">'+goodsNm+'</a></p>';
    				ul+='<p class="price">';
    				ul+='<i>¥</i>';
    				ul+='<span>'+price+'</span>';
    				ul+='</p>';
    				ul+='</li>'; */
    			}
    			$(f_goods).empty();
    			$(f_goods).append(ul);
    			//$('img.floor-lazy').lazyload({placeholder : "images/lazyimages/whale-780x450.png",effect: "fadeIn"});
    		}
    		
    	},"json");
    }
    
	</script>   
	
<jsp:include page="pages/common/index_footerbar.jsp" />

<script type="text/javascript">
	$(document).ready(function(){
		$("#slide img").each(function(){
		var img_src=$(this).attr("_src");
		$(this).attr("src",img_src);
		});
	});
	
	/* function searchproduct(){
		   var keyword = document.getElementById("keyword").value;
		   if(isNull(keyword)){
		     floatNotify.simple("请输入搜索关键字！");
		     return false;
		   }
		   //document.getElementById("searchform").submit();
		   window.location = "pages/search/searchGoods.jsp?keyword="+keyword;
		} */
</script>
</body></html>

