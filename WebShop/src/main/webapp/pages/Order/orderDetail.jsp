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
	<title>乐汇百材-用户中心</title>
	<!-- website -->
    <link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/web/web_frame.css">
    <link rel="stylesheet" type="text/css" href="<%=tPath%>/assets/css/web/web_manger_header.css">
    
	<link rel="stylesheet" href="<%=tPath%>/assets/css/fonts/linecons/css/linecons.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/bootstrap.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/xenon-core.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/xenon-forms.css">
	<link rel="stylesheet" href="<%=tPath%>/assets/css/order.css">
	
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
    <div id="ut133" class="u2_box clearfix">
	    <h2 id="ut134" class="title">订单详情</h2>
	    <div id="ut135" class="amountInfo" style="padding: 10px 0 20px;">
				<span class="counter" style="font-size: 16px; float: left;" id="countDown">
				</span>
            	<p>
				    <b >订单实付款：</b>
					    <em id="totalamt">0.00</em>元
		            	<!-- <span id="ut145" class="baoquan" style="display: block;margin-top:5px;">
		            	<em id="ut146">9800</em>券</span> -->
			    </p>
	    </div>
        <div id="ut147" class="mt10">
            <div id="ut148" class="autoList cm-mercOrder cm-bookingDetail">
		        <table id="ut149" class="tc auto_listTitle" border="0" cellpadding="0" cellspacing="0" width="100%">
			        <thead id="ut150">
			        <tr id="ut151">
			              <th class="tc" width="50%">商品信息</th>
                          <th class="tc" width="15%">单价(元)</th>
                          <th class="tc" width="10%">数量</th>
                          <th class="tc" width="15%">商品总价(元)</th>
                          <th class="tc" width="20%">订单状态</th>
			        </tr>
			        </thead>
		        </table>
		        <ul id="ut158" class="cTablea">
		        <li></li>
			      
		        </ul>
		        <div class="cut">
				</div>
	        </div>
            
            <ul class="mt10 cm_orderDetail">
            	<li >
                        <div id="ut194" class="clearfix">
                        <div id="recv_info" class="fl change_add " style="width: 685px;">
                        </div>
                      
                        </div>
                </li>
                <li >
		            <h2 id="ut207" class="order_title">留言信息</h2>
		            <div id="Message" class="clearfix" >
                    	<!-- <p id="ut209" style="margin-bottom:10px;">
                    		买家留言：
                    		<span id="ut210"></span>
                    	</p>
                    	<p id="ut211" style="margin-bottom:10px;">
                    		商家留言：
                    		<span id="ut212">无</span>
                    	</p> -->
	                </div>
	            </li>
            </ul>
        </div>
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
	<script src="<%=tPath%>/pages/Order/orderDetail.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
	<script src="<%=tPath%>/assets/js/comm.js?rnd=<%=Math.random()%>" type="text/javascript"></script>
</html>