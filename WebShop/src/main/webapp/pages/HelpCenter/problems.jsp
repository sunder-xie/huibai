<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String tPath = request.getContextPath();
String tBasePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+tPath+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>常见问题</title>
<style type="text/css">
body{margin:0px;
	padding:0px;
	background-color: #f9f9f9;
}
#header{
width: 100%;
height:60px;}
.search-wrap {
    background-color: #f1f1f1;
    padding-top: 26px;
    padding-bottom: 26px;
    text-align: center;
    margin-bottom: 15px;
	height:60px;
	}
.w {
    width: 990px;
    margin: 0 auto;
	margin-left:200px;
	}
.search-wrap .sch-box {
    width: 826px;
    margin-left: auto;
    margin-right: auto;
    overflow: hidden;
    position: relative;
}
.search-wrap .f-text {
    border: 3px solid #6abb79;
    padding: 10px;
    height: 26px;
    width: 680px;
    vertical-align: top;
    float: left;
    color: #9e9e9e;
}
.search-wrap .btn-search {
    background-color: #6abb78;
    font-size: 20px;
    font-family: "microsoft yahei";
    color: #fff;
    border-radius: none;
    border: 0;
    vertical-align: top;
    height: 52px;
    width: 120px;
    float: left;
    font-weight: bold;
}
.main {
    overflow: hidden;
    overflow-x: hidden;
    overflow-y: hidden;
}
.w {
    width: 990px;
    margin: 0 auto;
    margin-top: 0px;
    margin-right: auto;
    margin-bottom: 0px;
    margin-left: auto;
}
.subside-box {
    float: left;
    width: 210px;
    margin-right: 10px;
}
.subside-mod{
    margin: 0;
    padding: 0;
}
.subside-box .h3-title {
	margin: 0;
    padding: 0;
    color: #fff;
    text-align: center;
    font-size: 18px;
    line-height: 40px;
    height: 40px;
    background-color: #7dd589;
    font-weight: normal;
}
.subside-box .subside-mod .icon02 {
    border-style: solid dashed;
    border-color: #999 transparent;
    border-width: 5px 5px 0;
    position: absolute;
    top: 17px;
    right: 20px;
    font-size: 0;
    line-height: 0;
    height: 0;
    overflow: hidden;
	margin: 0;
	padding: 0;
}
.subside-box .on .subside-cnt {
    display: block;
}
.subside-box .subside-cnt {
	margin-left:0px;
    display: none;
    background-color: #fff;
}
.subside-box .subside-mod .title {
    height: 40px;
    line-height: 40px;
    padding-left: 45px;
    background-color: #eaeaea;
    border-bottom: 1px solid #fff;
    font-size: 14px;
    font-family: "microsoft yahei";
    position: relative;
}
ol, ul {
    list-style: none;
}
.subside-box .subside-list .list-item {
    height: 30px;
    line-height: 30px;
    border-bottom: 1px solid #faf8f9;
}
.subside-box .subside-list .list-item a {
    color: #333;
}
a {
    color: #666;
    text-decoration: none;
}
.content {
    width: 770px;
    float: left;
    background-color: #fff;
    min-height: 800px;
}

</style>
<script type="text/javascript" src="<%=tPath%>/assets/js/jquery-1.11.0.js"></script>
<script type="text/javascript">
   $(function (){
		$(".subside-box .subside-list .list-item a").hover(
  			function () {
    				$(this).css("color","#00CC66");
 				 },
  			function () {
					$(this).css("color","");
  					}
				);
		$(".subside-box .subside-mod .title").hover(
  			function () {
    				$(this).css("background-color","#CCCCCC");
 				 },
  			function () {
					$(this).css("background-color","#eaeaea");
  					}
				);
		$(".subside-mod .title").click(function (){	
			if($(this).parent().attr("class")=='subside-mod'){
				$(this).parent().attr("class","subside-mod on");	
				$(this).children().css("border-width","0 5px 5px");
			}else{
				$(this).parent().attr("class","subside-mod");	
				$(this).children().css("border-width","5px 5px 0");	
			}
		});
		$(".f-text").focus(function (){
			if($(this).val()=="输入问题关键词"){
				$(this).val("");
			}
		});
		$(".f-text").blur(function (){
			if($(this).val()==""){
				$(this).val("输入问题关键词");
			}
		});
		
		
		});
</script>
</head>
<body>
<div style="width:100%">
	<jsp:include page="../HomePages/home_topbar.jsp" />
</div>
<div style="width:100%">
	<jsp:include page="header.jsp" />
</div>
	<div class="search-wrap">
    <div class="w">
        <form action="/issue/search">
            <div class="sch-box">
              <input type="text" class="f-text" name="keyword" value="输入问题关键词" >
        	  <input type="submit" class="btn-search" value="搜索">
            </div>
	    </form>
    </div>
</div>

<div class="w main">
    <div class="subside-box">
        <div class="subside-in">
    <h3 class="h3-title">常见问题分类</h3>
            <dl class="subside-mod">
            <dt class="title">
                购物指南 <b class="icon02"></b>
            </dt>
            <dd class="subside-cnt">
                <ul class="subside-list">                  
                        <li class="list-item" data-id="28" data-name="交易条款" data-parent-id="21"
                            data-parent-name="购物指南">
                            <a href="index.html" target="if">交易条款</a>
                        </li>                  
                        <li class="list-item" data-id="29" data-name="购物流程" data-parent-id="21"
                            data-parent-name="购物指南">
                            <a href="https://www.baidu.com"  target="if">购物流程</a>
                        </li>                 
                        <li class="list-item" data-id="30" data-name="促销咨询" data-parent-id="21"
                            data-parent-name="购物指南">
                            <a href="https://www.baidu.com"  target="if">促销咨询</a>
                        </li>                   
                        <li class="list-item" data-id="31" data-name="商品咨询" data-parent-id="21"
                            data-parent-name="购物指南">
                            <a href="https://www.baidu.com"  target="if">商品咨询</a>
                        </li>                  
                        <li class="list-item" data-id="297" data-name="生活旅行" data-parent-id="21"
                            data-parent-name="购物指南">
                            <a href="problems_index.jsp">生活旅行</a>
                        </li>
                   </ul>
           		 </dd>
        		</dl>
       		<dl class="subside-mod">
            <dt class="title">
                订单百事通 <b class="icon02"></b>
            </dt>
            <dd class="subside-cnt">
                <ul class="subside-list">                   
                        <li class="list-item" data-id="47" data-name="订单查询" data-parent-id="22"
                            data-parent-name="订单百事通">
                            <a href="//help.jd.com/user/issue/list-47.html">订单查询</a>
                        </li>                    
                        <li class="list-item" data-id="48" data-name="提交订单" data-parent-id="22"
                            data-parent-name="订单百事通">
                            <a href="//help.jd.com/user/issue/list-48.html">提交订单</a>
                        </li>              
                        <li class="list-item" data-id="49" data-name="修改订单" data-parent-id="22"
                            data-parent-name="订单百事通">
                            <a href="//help.jd.com/user/issue/list-49.html">修改订单</a>
                        </li>                  
                        <li class="list-item" data-id="50" data-name="取消订单" data-parent-id="22"
                            data-parent-name="订单百事通">
                            <a href="//help.jd.com/user/issue/list-50.html">取消订单</a>
                        </li>                                                          
                        <li class="list-item" data-id="54" data-name="订单异常" data-parent-id="22"
                            data-parent-name="订单百事通">
                            <a href="//help.jd.com/user/issue/list-54.html">订单异常</a>
                        </li>
                        <li class="list-item" data-id="267" data-name="订单确认" data-parent-id="22"
                            data-parent-name="订单百事通">
                            <a href="//help.jd.com/user/issue/list-267.html">订单确认</a>
                        </li>
               		 </ul>
          		  </dd>
      		  </dl>
            <dl class="subside-mod">
            <dt class="title">
                配送方式 <b class="icon02"></b>
            </dt>
            <dd class="subside-cnt">
                <ul class="subside-list">                   
                        <li class="list-item" data-id="80" data-name="发货与签收" data-parent-id="23"
                            data-parent-name="配送方式">
                            <a href="//help.jd.com/user/issue/list-80.html">发货与签收</a>
                        </li>             
                        <li class="list-item" data-id="310" data-name="第三方配送" data-parent-id="23"
                            data-parent-name="配送方式">
                            <a href="//help.jd.com/user/issue/list-310.html">第三方配送</a>
                        </li>                   
                        <li class="list-item" data-id="85" data-name="配送运费收取说明" data-parent-id="23"
                            data-parent-name="配送方式">
                            <a href="//help.jd.com/user/issue/list-85.html">配送运费收取说明</a>
                        </li>                  
                        <li class="list-item" data-id="82" data-name="配送服务查询" data-parent-id="23"
                            data-parent-name="配送方式">
                            <a href="//help.jd.com/user/issue/list-82.html">配送服务查询</a>
                        </li>   
                        <li class="list-item" data-id="420" data-name="站点信息查询" data-parent-id="23"
                            data-parent-name="配送方式">
                            <a href="//help.jd.com/user/issue/list-420.html">站点信息查询</a>
                        </li>
                 </ul>
            	</dd>
        	</dl>
            <dl class="subside-mod">
            <dt class="title">
                支付及发票 <b class="icon02"></b>
            </dt>
            <dd class="subside-cnt">
                <ul class="subside-list">                  
                        <li class="list-item" data-id="171" data-name="支付流程" data-parent-id="27"
                            data-parent-name="支付及发票">
                            <a href="//help.jd.com/user/issue/list-171.html">支付流程</a>
                        </li>                    
                        <li class="list-item" data-id="172" data-name="货到付款" data-parent-id="27"
                            data-parent-name="支付及发票">
                            <a href="//help.jd.com/user/issue/list-172.html">货到付款</a>
                        </li>                   
                        <li class="list-item" data-id="173" data-name="在线支付" data-parent-id="27"
                            data-parent-name="支付及发票">
                            <a href="//help.jd.com/user/issue/list-173.html">在线支付</a>
                        </li>                                                           
                        <li class="list-item" data-id="175" data-name="公司转账" data-parent-id="27"
                            data-parent-name="支付及发票">
                            <a href="//help.jd.com/user/issue/list-175.html">公司转账</a>
                        </li>                  
                       <li class="list-item" data-id="176" data-name="分期付款" data-parent-id="27"
                            data-parent-name="支付及发票">
                            <a href="//help.jd.com/user/issue/list-176.html">分期付款</a>
                        </li>                                                                                  
                      </ul>
            		</dd>
        		</dl>
            <dl class="subside-mod">
            <dt class="title">
                售后服务 <b class="icon02"></b>
            </dt>
            <dd class="subside-cnt">
                <ul class="subside-list">                    
                        <li class="list-item" data-id="320" data-name="查询售后政策" data-parent-id="24"
                            data-parent-name="售后服务">
                            <a href="//help.jd.com/user/issue/list-320.html">查询售后政策</a>
                        </li>                    
                        <li class="list-item" data-id="112" data-name="售后政策（自营）" data-parent-id="24"
                            data-parent-name="售后服务">
                            <a href="//help.jd.com/user/issue/list-112.html">售后政策（自营）</a>
                        </li>                   
                        <li class="list-item" data-id="117" data-name="售后政策（三方）" data-parent-id="24"
                            data-parent-name="售后服务">
                            <a href="//help.jd.com/user/issue/list-117.html">售后政策（三方）</a>
                        </li>                  
                        <li class="list-item" data-id="113" data-name="退换货/返修申请" data-parent-id="24"
                            data-parent-name="售后服务">
                            <a href="//help.jd.com/user/issue/list-113.html">退换货/返修申请</a>
                        </li>                                                                                  
                      </ul>
            		</dd>
        		</dl>
            <dl class="subside-mod">
            <dt class="title">
                账户及会员 <b class="icon02"></b>
            </dt>
            <dd class="subside-cnt">
                <ul class="subside-list">
                        <li class="list-item" data-id="149" data-name="账户安全与账户信息" data-parent-id="26"
                            data-parent-name="账户及会员">
                            <a href="//help.jd.com/user/issue/list-149.html">账户安全与账户信息</a>
                        </li>           
                        <li class="list-item" data-id="150" data-name="账户资产" data-parent-id="26"
                            data-parent-name="账户及会员">
                            <a href="//help.jd.com/user/issue/list-150.html">账户资产</a>
                        </li>    
                        <li class="list-item" data-id="151" data-name="会员介绍" data-parent-id="26"
                            data-parent-name="账户及会员">
                            <a href="//help.jd.com/user/issue/list-151.html">会员介绍</a>
                        </li>
                        <li class="list-item" data-id="152" data-name="会员级别" data-parent-id="26"
                            data-parent-name="账户及会员">
                            <a href="//help.jd.com/user/issue/list-152.html">会员级别</a>
                        </li>
                 </ul>
            </dd>
        </dl>
        
        <dl class="subside-mod">
            <dt class="title">
                购物指南 <b class="icon02"></b>
            </dt>
            <dd class="subside-cnt">
                <ul class="subside-list">                  
                        <li class="list-item" data-id="28" data-name="交易条款" data-parent-id="21"
                            data-parent-name="购物指南">
                            <a href="//help.jd.com/user/issue/list-28.html">交易条款</a>
                        </li>                  
                        <li class="list-item" data-id="29" data-name="购物流程" data-parent-id="21"
                            data-parent-name="购物指南">
                            <a href="//help.jd.com/user/issue/list-29.html">购物流程</a>
                        </li>                 
                        <li class="list-item" data-id="30" data-name="促销咨询" data-parent-id="21"
                            data-parent-name="购物指南">
                            <a href="//help.jd.com/user/issue/list-30.html">促销咨询</a>
                        </li>                   
                        <li class="list-item" data-id="31" data-name="商品咨询" data-parent-id="21"
                            data-parent-name="购物指南">
                            <a href="//help.jd.com/user/issue/list-31.html">商品咨询</a>
                        </li>                  
                        <li class="list-item" data-id="297" data-name="生活旅行" data-parent-id="21"
                            data-parent-name="购物指南">
                            <a href="//help.jd.com/user/issue/list-297.html">生活旅行</a>
                        </li>
                   </ul>
            	</dd>
        	</dl>
		</div>
       </div>
       <div class="content">
       		<iframe src="problems_index.jsp" width="780" height="800" frameborder="0" scrolling="no" name="if"></iframe>
       </div>
       
     </div>
     <div style="width:100%">
	<jsp:include page="footer.jsp" />
	</div>
</body>
</html>