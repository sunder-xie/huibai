<%@page import="com.app.bean.TblUserInfo"%>
<%@page import="com.app.common.utils.LTConstant"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String tPath = request.getContextPath();
TblUserInfo userinfo =  (TblUserInfo)session.getAttribute(LTConstant.userInfo);
%>
<div class="site_frame_head">
<div class="manger_header">
	<div class="wrap">
		<div class="manger_header_left">
			<a href="<%=request.getContextPath()%>/index.jsp" target="_blank" class="fore1">
			<img alt="logo" src="<%=request.getContextPath()%>/images/lhbclogo.png"></a> 
			<a href="<%=tPath%>/pages/MerChnt/MerCenter.jsp?user_id=<%=userinfo.getId()%>" target="_self" class="fore2">商家平台</a>
		    <a href="<%=request.getContextPath()%>/index.jsp" target="_blank" class="fore3">返回乐汇首页</a>
		</div>
		
		<div class="manger_header_right">
			<div id="search">
					<input type="text"
						onkeydown="javascript:if(event.keyCode==13) search();"
						autocomplete="off" id="key" accesskey="s" class="text" />
					<button onclick="search('key');return false;"
						class="button" type="button">
						<i></i>搜索
					</button>
			</div>
		</div>
	</div>
</div>
</div>
<script type="text/javascript">
function search()
{
	var keyword =$("#key").val();
	window.location = "<%=request.getContextPath()%>/pages/Search/SearchGoods.jsp?keyword="+keyword;
};
</script>
