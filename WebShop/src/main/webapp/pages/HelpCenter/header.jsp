<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String tPath = request.getContextPath();
String navclass = request.getParameter("navclass");
String tBasePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+tPath+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>
<style type="text/css">
body{margin:0px;padding:0px;
background-color: white;
}
#header{
width: 100%;
height:60px; }
#logo{
    float: left;
    width: 326px;
    height: 60px;
    margin-left: 200px;
}
#helpnav {
    float: right;
    height: 47px;
    margin-top: 13px;
    margin-right: 150px;
}
.fored{
background-color: #69bb76;
}
.fored a{
color: white;
}
.forehover{
background-color: #69bb76;
}
ul {
    list-style: none;
}
#helpnav li {
    float: left;
    margin-left: 10px;
    display: inline;
}
#helpnav li a {
    display: inline-block;
    padding: 0 10px;
    height: 47px;
    line-height: 47px;
    font-size: 14px;
    font-family: "microsoft yahei";
}
a {
    color: #666;
    text-decoration: none;
}
</style>
<script type="text/javascript" src="<%=tPath%>/assets/js/jquery-1.11.0.js"></script>
<script type="text/javascript">
   $(function (){		
		$(".fore").hover(
  			function () {
  					//$(".fore1").attr("class","fore");
    				$(this).attr("class","forehover");
    				$(this).children().attr("style","color: white;");
 				 },
  			function () {
					$(this).attr("class","fore");
					$(this).children().removeAttr("style");
  					}
				);
		
		$(".nav1").click(function (){
			$(".myform").attr('action','HelpIndex.jsp');
			$(".myform input").attr('value','1');
			$(".myform").submit();
		});
		$(".nav2").click(function (){
			$(".myform").attr('action','problems.jsp');
			$(".myform input").attr('value','2');
			$(".myform").submit();
		});
		$(".nav3").click(function (){
			$(".myform").attr('action','HelpCenter_serve.jsp');
			$(".myform input").attr('value','3');
			$(".myform").submit();
		});
	
	});
   
</script>
</head>
<body>	
      <div id="header" class="w">
        <div id="logo" class="ld"><a href="<%=request.getContextPath()%>/index.jsp" target="_blank"><img src="../../assets/images/ltlogo.png" width="326" height="60"></a></div>
		<ul id="helpnav">
			<li id="nav-home" class="<%if(navclass.equals("1")){out.write("fored");}else{out.write("fore");}%>"><a href="#" class="nav1">首页</a></li>
			<li id="nav-question" class="<%if(navclass.equals("2")){out.write("fored");}else{out.write("fore");}%>"><a href="#" class="nav2">常见问题</a></li>
			<li id="nav-service" class="<%if(navclass.equals("3")){out.write("fored");}else{out.write("fore");}%>"><a href="#" class="nav3">自助服务</a></li>
			<li id="nav-custom" class="fore"><a href="#">联系客服</a></li>
			<li id="nav-guide" class="fore"><a href="../HomePages/home_topbar.jsp" target="_blank">新手指南</a></li>
		</ul>
    </div>
    <form class="myform"  action="" method="post">
			<input type="hidden" name="navclass" value="">
	</form>
</body>
</html>