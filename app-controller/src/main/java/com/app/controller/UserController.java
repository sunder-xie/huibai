package com.app.controller;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.app.common.model.Message;
import com.app.service.UserService;
import com.hlb.utils.string.StringUtils;
import com.app.bean.TblUserInfo;
import com.app.common.utils.LTConstant;

/**
 * 用户模块
 * */
@Controller
@RequestMapping("user")
public class UserController {
	
	@Resource
	private UserService userServiceImpl;
	/**
	 * 用户注册服务
	 * */
	@RequestMapping("Register")
	public @ResponseBody Message userReg(TblUserInfo userInfo,HttpSession session,HttpServletResponse response){
		Message msg =new Message();
		if(StringUtils.isEmpty(userInfo.getUsername()))
		{
			msg.setRspCode("000003").setRspMsg("用户名为空！");
			return msg;
		}
		
		if(StringUtils.isEmpty(userInfo.getPassword()))
		{
			msg.setRspCode("000003").setRspMsg("密码为空！");
			return msg;
		}
		
		msg =  userServiceImpl.saveUser(userInfo,session);
		if(LTConstant.Success.equals(msg.getRspCode())){//注册成功，进行Cookie的保存
			BCryptPasswordEncoder encoder =new BCryptPasswordEncoder();
			
			String encoderStr = encoder.encode(userInfo.getUsername()+"122");
			LTConstant.userInfos.put(encoderStr, userInfo);
			Cookie cookie = new Cookie(LTConstant.userInfo,encoderStr);
			// cookie的有效期为1个月
			cookie.setMaxAge(24 * 60 * 60 * 30);
			response.addCookie(cookie);
		}
		return msg;
		
		//return userServiceImpl.saveUser(userInfo);
	}
	
	/**
	 * 用户登录服务
	 * */
	@RequestMapping("Login")
	public @ResponseBody Message userLogin(TblUserInfo userInfo,HttpSession session,HttpServletRequest request,HttpServletResponse response){
		Message msg =new Message();
		
		if(StringUtils.isEmpty(userInfo.getUsername()))
		{
			msg.setRspCode("000003").setRspMsg("用户名为空！");
			return msg;
		}
		
		if(StringUtils.isEmpty(userInfo.getPassword()))
		{
			msg.setRspCode("000003").setRspMsg("密码为空！");
			return msg;
		}
		
		msg =  userServiceImpl.LoginUser(userInfo,session);
		if(LTConstant.Success.equals(msg.getRspCode())){//登录成功，进行Cookie的保存
			BCryptPasswordEncoder encoder =new BCryptPasswordEncoder();
			
			String encoderStr = encoder.encode(userInfo.getUsername()+"122");
			LTConstant.userInfos.put(encoderStr, userInfo);
			Cookie cookie = new Cookie(LTConstant.userInfo,encoderStr);
			// cookie的有效期为1个月
			cookie.setMaxAge(24 * 60 * 60 * 30);
			response.addCookie(cookie);
			
		}
		return msg;
	}
	
	/**
	 * 获取用户信息
	 * */
	@RequestMapping("queryUserInfo")
	public @ResponseBody Message getUserInfo(HttpSession session) {
		TblUserInfo userInfo = (TblUserInfo) session.getAttribute(LTConstant.userInfo);
		Message msg = new Message();
		msg.setObjs(userInfo);
		return msg;
	}
	
	/**
	 * 更新用户信息
	 * */
	@RequestMapping("updateUserInfo")
	public @ResponseBody Message updateUserInfo(String username, String nickname, String useremail, String usertell, HttpSession session) {
		System.out.println("niaho");
		return userServiceImpl.updateUserInfo(username, nickname, useremail, usertell, session);
	}
	
	/**
	 * 用户退出服务
	 * */
	@RequestMapping("Logout")
	public @ResponseBody Message userLogout(HttpSession session){
		Message msg =  userServiceImpl.LoginoutUser(session);
		
		//session.getAttribute(LTConstant.userInfo);
//		session.removeAttribute(LTConstant.userInfo);  
//		response.sendRedirect("/Web/index.jsp");
//		response.sendRedirect("");
		return msg;
	}
	
	/**
	 * 修改用户密码
	 */
	@RequestMapping("updateUserPwd")
	public @ResponseBody Message updateUserPwd(String userId,String oldpwd,String newpwd, HttpSession session) {
		Object obj=session.getAttribute(LTConstant.userInfo);
		String uid="";
		String username="";
		if(obj!=null)
		{
			TblUserInfo userinfo =(TblUserInfo)obj;
		    uid=userinfo.getId();
		    username=userinfo.getUsername();
		}
		Message msg =  new Message();
		if(!userId.equals(uid))
		{
			msg.setRspCode("000003").setRspMsg("session 错误！");
			return msg;
		}
		
		return userServiceImpl.updateUserPwd(username, oldpwd,newpwd, session);
	}
}
