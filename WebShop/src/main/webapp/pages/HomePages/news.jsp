<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="box-all">
	     <div class="userLogin">
              <div class="isLogin isNone">
                <div class="clearfix h62">
                  <a class="userLogo" href="<%=request.getContextPath()%>/pages/User/userCenter.jsp">
                    <img src="images/user-bg.png" alt="" style="z-index:2;" class="logo_login">
                    <img src="images/user-bg.png" alt="" style="z-index:5;" >
                  </a>
                  <div class="isLoginMessage">
                    <span class=""></span>
                  </div>
                </div>
                <div class="userBtn">
                  <a class="w1" href="<%=request.getContextPath()%>/pages/User/userCenter.jsp" name="user_center01">我的汇百</a>
                </div>
              </div>
              <div class="noLogin">
                <div class="clearfix h62">
                  <div class="userLogo" style="background:url(images/user-bg.png) no-repeat center">
                    <img src="images/user-bg.png" alt=""/>
                  </div>
                  <span class="userName">Hi，你好！</span>
                </div>
                <div class="userBtn">
                  <a class="w2" href="<%=request.getContextPath()%>/pages/Login/userRegister.jsp" target="_blank" name="user_regist01">注册</a>
                  <a class="w2 ml" href="<%=request.getContextPath()%>/pages/Login/userLogin.jsp" name="user_login01">登录</a>
                </div>
              </div>
            </div>
		<div class="title">
			<em>公告</em> <a name="index2_none_gg_gd" target="_blank"
				href="<%=request.getContextPath()%>/pages/announce/annoAll.jsp"
				class="more">更多</a>
		</div>
		<div class="notice" id="index-notice">
			
		</div>
	 	<div class="title">
			<em>招商中心</em>
		</div>
		<div class="life">
			 <div class="userBtn">
                  <a class="w1" href="<%=request.getContextPath()%>/pages/Login/merRegGuide.jsp" name="user_center01">商家进驻</a>
                </div>
		</div> 
	</div>
	
<script type="text/javascript">
$(function(){
	
	var basepath=null; /*根目录*/
    var userId =$("#LoginUser").attr('loginUserId');
    
    basepath=getRootPath();
    if(!isNull(userId))
    {
    	var url =  basepath+"/user/queryUserInfo.action";
		$.post(url,function(data){
			
			$(".box-all").find(".noLogin").addClass("isNone"),
			$(".box-all").find(".isLogin").removeClass("isNone"),
			$(".box-all").find(".isLogin .logo_login").attr("src", "images/user-bg.png"),
			$(".box-all").find(".isLogin .logo_login").error(function() {
                e(this).attr("src", basepath + "images/user-bg.png")
            }),
            $(".box-all").find(".isLogin").find(".isLoginMessage").find("span").text(data.objs.username)
            
		},"json");
    }
});
</script>