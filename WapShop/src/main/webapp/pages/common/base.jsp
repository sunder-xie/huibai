<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String tPath = request.getContextPath();
String tBasePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+tPath+"/";
%>
<!-- 基础包 -->
<script charset="utf-8" src="<%=tBasePath%>/js/jquery.min.js?v=0.01"></script>
<%-- <script src="<%=tBasePath%>/js/jquery-1.11.3.min.js" type="text/javascript"></script> --%>
<script src="<%=tBasePath%>/js/comm.js" type="text/javascript"></script>
<link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
