<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style>
	.header{height: 120px;width: 100%;width: 1200px;margin: 0 auto;padding-top: 17px;}
    .header_box {width: 330px; float: left;overflow: hidden;/* height: 90px; */}
    .header_box .logo_set { width: 210px; float: left;height: 80px;}
    .header_box .logo_set img, .header_box .big_set img { width: 100%;height: 100%;border-radius: 8px;}
    .header_box .big_set {
     width: 70px;float: left;height: 50px;cursor: pointer;margin-top: 32px;margin-left: 12px;}

	.header .global-search{width: 575px;float: left;}
	.header .global-search .search-bd{height: 25px;}
	
	.header .global-search .search-bd li{list-style:none;font-size:12px;width:60px;height: 25px;line-height: 25px;text-align:center;float: left;cursor: pointer;background-color: #eee;color: #666;}
    .header .global-search .search-bd li.active{list-style:none;color: #fff;font-weight: 700;background-color: #B61D1D;}
    
    .header .global-search .search-hd{height:40px;background-color: #B61D1D;padding: 3px;position: relative;}
    .header .global-search .search-hd .search-input{width: 490px;height: 34px;line-height: 34px;padding: 6px 0;background: none;text-indent: 10px;border: 0;outline: none;position: relative;left: 3px;top: 0;#margin-left:-10px;}
    .header .global-search .search-hd .btn-search{width: 70px;height: 34px;line-height:34px;position: absolute;right: 3px;top: 3px;border: 0;cursor: pointer;font-size: 12px;color: #fff;font-weight: 700;background: none;outline: none;}
    .header .global-search .search-hd .pholder{display: inline-block;padding: 2px 0;font-size: 12px;color: #999;position: absolute;left: 13px;top: 11px;background: url(<%=request.getContextPath()%>/images/search.jpg) no-repeat 0 0;padding-left:25px;#top:11px;}
    
    .header .global-search .search-hd .search2,.global-search .search-hd #search2{display: none;}
    .header .global-search .search-bg{width: 495px;height: 34px;background-color: #fff;position: absolute;left: 3px;top: 3px;}
    
	#hot-query>li {display: inline-block;border-left: 1px solid #999;height: 13px;line-height: 13px;
	 width: auto;font-size: 12px; padding:0 12px 0 12px;}
	#hot-query a{text-decoration: none;color: #999;}  
	 
	 .header .header_right{float: right;}
	 .header_right .ad_set { width: 150px; float: right;height: 85px;margin-top: 10px;}
	 .header_right .ad_set img{ width: 100%;height: 100%;border-radius: 8px;}
	 
	  .search-fix {
      -webkit-animation: searchTop .5s ease-in-out;
       animation: searchTop .5s ease-in-out;
	  }
	.search-fix {
	    position: fixed;
	    z-index: 200;
	    width: 100%;
		top: 0;
	    border-bottom: 2px solid #b61d1d;
	    background-color: #fff;
	    box-shadow: 2px 2px 2px rgba(0,0,0,.2);
	    display:none;
	}
	.search-fix .search-m {
    margin: auto;
    width: 1190px;
    height: 48px;
	}
	.search-m {
	    position: relative;
	    z-index: 1;
	    height: 60px;
	}
	
	.search-fix .search-m .global-search{width: 575px;float: left;}
    .search-fix .search-m .global-search .search-hd{height:40px;background-color: #B61D1D;padding: 3px;position: relative;top: 22px;}
    .search-fix .search-m .global-search .search-hd .search-input{width: 490px;height: 34px;line-height: 34px;padding: 6px 0;background: none;text-indent: 10px;border: 0;outline: none;position: relative;left: 3px;top: 0;#margin-left:-10px;}
    .search-fix .search-m .global-search .search-hd .btn-search{width: 70px;height: 34px;line-height:34px;position: absolute;right: 3px;top: 3px;border: 0;cursor: pointer;font-size: 12px;color: #fff;font-weight: 700;background: none;outline: none;}
    .search-fix .search-m .global-search .search-hd .pholder{display: inline-block;padding: 2px 0;font-size: 12px;color: #999;position: absolute;left: 13px;top: 11px;background: url(<%=request.getContextPath()%>/images/search.jpg) no-repeat 0 0;padding-left:25px;#top:11px;}
	.search-fix .search-m .global-search .search-hd .search2,.global-search .search-hd #search2{display: none;}
    .search-fix .search-m .global-search .search-bg{width: 495px;height: 34px;background-color: #fff;position: absolute;left: 3px;top: 3px;}
    .search-fix .search-m .search_right{float: right;
	width: 240px;
	font-size: 16px;
	height: 42px;
	margin-top: 22px;}
	    .search-fix .search-m .search_right .search_right_bar{position: fixed;
	float: left;
	padding: 0 10px;
	overflow: hidden;
	line-height: 40px;
	height: 40px;}
		.search-fix .search-m .search_right .search_right_bar .reg {
	    position: relative;
	    margin-left: 10px;
	}
    .search-fix .search-m .search_right .search_right_bar a{color: #666;}
    
    .search_right .isNone{display: none;
    }
    .search_right .buy_car { width: 120px;
	padding: 0 10px;
	float: right;
	padding: 0 10px;
	overflow: hidden;
	line-height: 40px;
	height: 40px;
	background-color: #b61d1d;}

    .search_right .buy_car em{
    background: url(images/sidebaricon.png) no-repeat;
	background-position: -31px -23px;
	display: block;
	position: relative;
	width: 29px;
	height: 30px;
	margin-left: 3px;
	cursor: pointer;
	margin-top: 5px;}
	.search_right .buy_car span{
	    margin-top: -35px;
	float: right;
	color: #F8F4F4;}
	
</style>
<div class="site_frame_head">
<!--公司logo和一个搜索部分-->
<div class="header">
	<div class="header_box clearfix">
	<a  href="<%=request.getContextPath()%>/index.jsp" class="logo_set">
	<img alt="logo" src="<%=request.getContextPath()%>/images/lhbclogo.png">
	</a>
	<a href="<%=request.getContextPath()%>/index.jsp" class="big_set" >
	  <img alt="welcom" src="<%=request.getContextPath()%>/images/qingzhu.gif">
	</a>
	</div>
	<div class="global-search clearfix">
		<!--所有类型-->
		<div id="search-bd" class="search-bd">
			<ul>
				<li class="active">商品</li>
				<li>店铺</li>
			</ul>
		</div>

        <div id="search-hd" class="search-hd">
            <div class="search-bg"></div>
            <input type="text" id="search1" class="search-input" placeholder="环氧" default="环氧" onkeydown="javascript:if(event.keyCode==13) search();">
            <input type="text" id="search2" class="search-input" placeholder="乐天美官方旗舰店" default="乐天美官方旗舰店" onkeydown="javascript:if(event.keyCode==13) search();">
            <button class="btn-search" onclick="search();return false;">搜索</button>
        </div>
	   
		<!--热门查询-->
		<ul id="hot-query">
			<li style="border-left: none;">
			<a title="环氧" href="<%=request.getContextPath()%>/pages/Search/SearchGoods.jsp?keyword=环氧&&type=1">环氧</a></li>
			<li><a title="激光整平机" href="<%=request.getContextPath()%>/pages/Search/SearchGoods.jsp?keyword=激光整平机&&type=1">激光整平机</a></li>
			<li><a title="磨片" href="<%=request.getContextPath()%>/pages/Search/SearchGoods.jsp?keyword=磨片&&type=1">磨片</a></li>
			<li><a title="车位锁" href="<%=request.getContextPath()%>/pages/Search/SearchGoods.jsp?keyword=车位锁&&type=1">车位锁</a></li>
			<li><a title="扫地机" href="<%=request.getContextPath()%>/pages/Search/SearchGoods.jsp?keyword=扫地机&&type=1">扫地机</a></li>
		</ul>
	</div>
	<div class="header_right clearfix">
		<a  href="#" class="ad_set">
		  <img alt="新客有礼" src="<%=request.getContextPath()%>/images/index_ad.png">
		</a>
	</div>
</div>
<!--置顶搜索部分-->
<div id="top-search" class="search-fix">
    <div class="search-m">	
		<div class="header_box clearfix">
			<a  href="<%=request.getContextPath()%>/index.jsp" class="logo_set">
			<img alt="logo" src="<%=request.getContextPath()%>/images/lhbclogo.png">
			</a>
		</div>
		<div class="global-search clearfix">
			<!--所有类型-->
	        <div id="search-hd" class="search-hd">
	            <div class="search-bg"></div>
	            <input type="text" id="search3" class="search-input" placeholder="环氧" default="环氧" onkeydown="javascript:if(event.keyCode==13) top_search();">
	            <button class="btn-search" onclick="top_search();return false;">搜索</button>
	        </div>
		</div>
		<div class="search_right clearfix">
			<div class="search_right_bar isLogin isNone">
				<a class="login" href="<%=request.getContextPath()%>/pages/User/userCenter.jsp" >我的汇百</a>
			</div>
			<div class="search_right_bar noLogin">
				<a  href="#" class="login">登录</a>
				<a  href="#" class="login reg">注册</a>
			</div>
			<a  href="#" class="buy_car">
			  <em></em>
			  <span>购物车
			  	<b id="showTotalQty">0</b></span>
			</a>
	</div>
	</div>
</div>
</div>
<script type="text/javascript">

	//通用头部搜索切换
	$('#search-bd li').click(function(){
	    var index = $(this).index();
	    $('#search-hd .pholder').eq(index).show().siblings('.pholder').hide(0);
	    $('#search-hd .search-input').eq(index).show().siblings('.search-input').hide(0);
	    $(this).addClass('active').siblings().removeClass('active');
	    $('#search-hd .search-input').val('');
	});
	/* $('#search-hd .search-input').on('input propertychange',function(){
	    var val = $(this).val();
	    if(val.length > 0){
	        $('#search-hd .pholder').hide(0);
	    }else{
	        var index = $('#search-bd li.active').index();
	        $('#search-hd .pholder').eq(index).show().siblings('.pholder').hide(0);
	    }
	}) */
	
	function top_search()
	{
		var keyword=null;
		var s_type= null;/*1 商品搜索 2 店铺搜索*/
		//alert("search1 显示 商品搜索");
		var len=$("#search3").val().length;
		if($("#search3").val().length>0)
			keyword = $("#search3").val();
		else
		    keyword = $("#search3").attr("default");
		s_type = 1;
		window.location = getRootPath()+"pages/Search/SearchGoods.jsp?keyword="+keyword+"&&type="+s_type;
	};
	
	function search()
	{
		var keyword=null;
		var s_type= null;/*1 商品搜索 2 店铺搜索*/
		if($("#search1").is(":hidden"))	
	    {
			//alert("search2 显示店铺 搜索");
			var len=$("#search2").val().length;
			if($("#search2").val().length>0)
				keyword = $("#search2").val();
			else
			    keyword = $("#search2").attr("default");
			s_type = 2;
			window.location = getRootPath()+"pages/Search/SearchShop.jsp?keyword="+keyword+"&&type="+s_type;
	    }
		else
		{
			//alert("search1 显示 商品搜索");
			var len=$("#search1").val().length;
			if($("#search1").val().length>0)
				keyword = $("#search1").val();
			else
			    keyword = $("#search1").attr("default");
			    
			s_type = 1;
			//var url="keyword="+keyword;
			//url=encodeURI(encodeURI(url)); //用了2次encodeURI
			window.location = getRootPath()+"pages/Search/SearchGoods.jsp?keyword="+keyword+"&&type="+s_type;
		}
		
	};
	
	$(function(){
		
		var userId =$("#LoginUser").attr('loginUserId');
	    
	    basepath=getRootPath();
	    
	$.fn.smartFloat = function() {
		var position = function(element) {
		var top = element.position().top, pos = element.css('position');
		$(window).scroll(function() {
		var scrolls = $(this).scrollTop();
		if (scrolls > top) {
		if (window.XMLHttpRequest) {
		element.css({
		position: 'fixed',
		top: 0
		});
		} else {
		element.css({
		top: scrolls
		});
		}
		}else {
		element.css({
		position: pos,
		top: top
		});
		}
		});
		};
		return $(this).each(function() {
		position($(this));
		});
	};

	$('#top-search').smartFloat();

	var fiexd_height = $('#top-search').offset().top;

	$(window).scroll(function(){
	        var this_scrollTop = $(this).scrollTop();
	        if(this_scrollTop>fiexd_height){
	            $('#top-search').slideDown();
	        }else{
		    $('#top-search').hide();
		}
	});
	
    if(!isNull(userId))
    {
    	$(".search_right").find(".noLogin").addClass("isNone");
		$(".search_right").find(".isLogin").removeClass("isNone");
    }
});
</script>
