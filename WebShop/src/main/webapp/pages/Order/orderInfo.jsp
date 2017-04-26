<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8"></meta>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta name="description" content="乐汇百材-用户中心" />
	<meta name="author" content="hlb" />
			<%@ include file="../common/path.jsp" %>
	<%@ include file="../common/base.jsp" %>
    <base href="<%=tBasePath%>"></base>
	<title>乐汇百材-订单中心</title>
	<!-- website -->
    <link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/web/web_frame.css">
    <link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/web/web_manger_header.css">
    
	<link rel="stylesheet" href="<%=tPath%>/assets/css/fonts/linecons/css/linecons.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/bootstrap.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/xenon-core.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/xenon-forms.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/order.css">
	
	<link rel="shortcut icon" href="<%=tPath%>/favicon.ico" type="image/x-icon"/>
	<style type="text/css">
    </style>
</head>
<body>
	<div class="site_frame">
    <jsp:include page="../HomePages/home_topbar.jsp" />
    <jsp:include page="orderHeader.jsp" />
   <!-- main -->
           <div  class="site_frame_main">
    <div class="site_frame_wrap">
        <!--mask-->
    <div  class="ordercon">
      <div >
        <!--订单详情-->
        <div class="orderfloor-1"><span >确认订单信息</span></div>
        <!--收货地址-->
        <div  class="orderadress">
          <div  class="orderadress-title"><span >收货地址</span></div>
          <div  class="orderadress-detail">
            <div  class="selectadress-now-user">
              <dl >
                <dd ><span id="name"> </span><span id="mobile"> </span></dd>
                <dd id="address"> </dd>
              </dl>
            </div>
            <a id="editStoreAddr" href="../User/address.jsp" target="_blank" style="float: right;">管理收货地址</a>
          </div>
          <div id="ut168" class="clearfix"></div>
          <div id="orderadress-more" class="orderadress-more" style="display: none;">
          </div>
          <div id="ut170" class="clearfix"></div>
          <a name="" href="javascript:void(0)" class="moreadress">切换地址</a>
          <span id="refreshAddr"><img id="ut171" src="../../images/shua.jpg" height="18" width="18"></span>
        </div>
        <!--收货地址end-->
        <!--商品列表-->
        <div id="ut172">
          <div id="ut173" class="orderadress-title"><span id="ut174">订单详情</span></div>
          <div shopname="" shopid="" class="good-list" id="shopinfo">
          <div class="good-list-title">
          <div class="td good-name-td shop-name">
          </div>
          <div class="td good-prize-td good-prize">单价（元）</div>
          <div class="td good-num-td good-num">购买数量</div>
          <div class="td good-allprize-td good-allprize">小计（元)</div>
          </div>
          <div id="shopCon"></div>
          <div class="good-list-con" goodsname="" goodsid="" id="goodsinfo">
	          <div class="td-h good-name-td">
	          <div class="good-pic">
	         	</div>
	          <div class="good-info">
	        	 </div>
	          </div>
	          <div class="td-h good-prize-td goodprize"><em id="unit-price">0</em>元</div>
	          <div class="td-h good-num-td  proinfo-num">0</div>
	          <div class="td-h good-allprize-td  goodallprize">
	          <span>0</span>
	          <!-- <span class="yhj"><em>优惠</em></span>
	          <div class="float-juan"><p>优惠劵：本店通用500钱宝币优惠劵</p><p>已优惠：1000钱宝币</p></div>
	           --></div>
          </div>
          
          <!-- <div class="good-list-con" goodsname="" goodsid="" id="goodsinfo">
	          <div class="td-h good-name-td">
	          <div class="good-pic">
	         	</div>
	          <div class="good-info">
	        	 </div>
	          </div>
	          <div class="td-h good-prize-td goodprize"><em id="unit-price">0</em>元</div>
	          <div class="td-h good-num-td  proinfo-num">0</div>
	          <div class="td-h good-allprize-td  goodallprize">
	          <span>0</span>
	          <span class="yhj"><em>优惠</em></span>
	          <div class="float-juan"><p>优惠劵：本店通用500币优惠劵</p><p>已优惠：1000币</p></div>
	          </div>
          </div> -->
          
          
          <div class="busess-mes" >
          <div class="buessLy">
          <span>给商家留言</span>
          <textarea class="c-store-message content" placeholder="选填：对本次交易的补充说明，限100字"></textarea>
          </div>
          <div class="exp-way">
          <span>邮费</span>
          <select class="mode"><option value="">包邮</option></select>
          </div>
          </div>
          </div>
          
          <div id="ut175" class="paydetail">
              <dl id="ut176" class="juan">
                <dd id="ut177">
                <!-- <div id="ut178" class="qlog"><label id="ut179">&nbsp;</label>宝劵可抵扣元，订单提交后可使用宝券</div> -->
                <div id="ut180" class="totalNum">
                <li id="total">共<em id="ut181">0</em>件商品</li>
                <li id="totalPrice">合计(含运费)：<em id="ut182">0</em>元</li>
                </div>
                </dd>
              </dl>
              <!-- <dl id="ut183" class="paydetail-juan">
                 <dt id="ut184">
                  店铺优惠：
                 </dt>
                 <dd id="ut185">
                   <div class="select" id="select"><span id="ut186"></span><i id="qie"></i></div>
                   <div style="display: none;" class="option" id="option">

                   </div>
                 </dd>
              </dl> -->
              <dl id="ut187" class="paydetail-prize">
                <dt id="ut188">实际支付：</dt>
                <dd id="ut189">0</dd>
                <dd id="ut190">元</dd>
              </dl>
              <dl id="ut191" class="paydetail-back">
              </dl>
              <!-- <dl style="display: block;" id="ut192" class="poundage">本单将收取2.00元交易服务费</dl>
              <dl id="ut193" class="freight">退货运费险：<input id="ut43" name="seleFre" checked="checked" type="checkbox">商家确认发货时，您将会支付1元为退货承担的运费投保，赔付金额为12元<a id="ut44" class="helpIonic" target="_blank" href="http://www.hbaicai.com/announcement/announce-detail.htm?id=102032">[?]</a></dl>
               --><dl id="ut194">
                <a id="buycar" class="btn-order" href="#">返回购物车</a>
                <a id="creatOrder" class="btn-order" href="javascript:void(0)">提交订单</a>
              </dl>
            </div>
        </div>
      </div>
    </div>
    <div class="addrmod" style="display:none">
      <div  class="clearfix"></div>
      <div class="">
        <div style="float: left; width:44px; height:64px; line-height:64px; text-align: center">
          <input name="fare54" class="fare-radio J_fare_radio" type="radio">
        </div>
        <div  class="selectadress-now">
          <dl >
            <dd ><span ></span><span ></span></dd>
            <dd ></dd>
          </dl>
        </div>
      </div>
    </div>
    <input id="sellerId" value="" type="hidden">
    <input id="productId" value="" type="hidden">
    <input id="skuId" value="" type="hidden">
    <input id="skuText" value="" type="hidden">
    <div id="orderForm">
    </div>
    <div style="display: none; height: auto;" id="ut283" class="float"></div>
    <div style="top: 181px; left: 702.5px; display: none;" id="ut284" class="loading">
      <img id="ut285" src="../../images/load.gif" height="35" width="35">
     </div>
    <!--正文部分结束-->
    </div>
  </div>
  
    <!-- footer -->
     <jsp:include page="../HomePages/home_footerbar.jsp" />
     </div>
</body>
<script src="<%=tPath%>/assets/plugs/jquery/jquery-1.11.3.min.js"></script>
	<script src="<%=tPath%>/assets/plugs/bootstrap/js/bootstrap.min.js"></script>
	<script src="<%=tPath%>/pages/Order/orderInfo.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
	<script src="<%=tPath%>/assets/js/comm.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
</html>