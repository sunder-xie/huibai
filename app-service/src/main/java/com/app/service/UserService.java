package com.app.service;

import javax.servlet.http.HttpSession;

import com.app.common.model.Message;
import com.app.bean.TblOauth2UserInfo;
import com.app.bean.TblUserInfo;

public interface UserService {
	/**
	 * 用于用户信息的保存＋校验
	 * */
	public Message saveUser(TblUserInfo userInfo,HttpSession session);
	
	/**
	 * 用于第三方用户信息的保存
	 * */
	public Message saveOAuth2User(TblUserInfo userInfo,TblOauth2UserInfo oauth2user,HttpSession session);
	
	/**
	 * 用于用户登录校验
	 * */
	public Message LoginUser(TblUserInfo userInfo,HttpSession session);
	
	/**
	 * 用于用户退出
	 * */
	public Message LoginoutUser(HttpSession session);
	
	
	public Message updateUserInfo(String username, String nickname, String useremail, String usertell, HttpSession session);
	
	public Message updateUserPwd(String username,String oldpwd,String newpwd,HttpSession session);

	public Message GetOAuth2UserInfo(String userId, String Channle);

	public Message GetUserInfo(TblUserInfo userInfo);
	
}
