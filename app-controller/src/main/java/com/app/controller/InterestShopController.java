package com.app.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.app.common.model.Message;
import com.app.common.model.Pager;
import com.app.service.InterestShopService;
import com.app.bean.TblInterestShopInfo;
import com.app.bean.TblUserInfo;
import com.app.common.utils.LTConstant;
import com.app.common.utils.ResCodeConstant;
@Controller
@RequestMapping("InterestShop")
public class InterestShopController {
	
	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private InterestShopService enterServiceImpl;
	/**
	 * 获取enter内容
	 * */
	@RequestMapping("GetInterestShopList")
	public @ResponseBody Pager GetInterestShopList(HttpSession session,Pager pages){
		
		
		Object obj=session.getAttribute(LTConstant.userInfo);
		String UserId="";
		if(obj!=null)
		{
			TblUserInfo userinfo =(TblUserInfo)obj;
			UserId=userinfo.getId();
		}
		else{
			pages.setRspCode(ResCodeConstant.MSG_NOT_LOGIN);
			pages.setRspMsg(ResCodeConstant.MSG_NOT_LOGIN_DESC);
			return pages;
		}
		
		return enterServiceImpl.getInterestShopInfo(UserId,pages);
	}
	
	/**
	 * 获取enter内容
	 * */
	@RequestMapping("AddInterestShop")
	public @ResponseBody Message AddInterestShop(HttpSession session,TblInterestShopInfo inter){
		
		Message msg = new Message();
		Object obj=session.getAttribute(LTConstant.userInfo);
		String uid="";
		String username="";
		if(obj!=null)
		{
			TblUserInfo userinfo =(TblUserInfo)obj;
		    uid=userinfo.getId();
		    username=userinfo.getUsername();
		}
		else{
			msg.setRspCode(ResCodeConstant.MSG_NOT_LOGIN).setRspMsg(ResCodeConstant.MSG_NOT_LOGIN_DESC);
			return msg;
		}
		inter.setUserId(uid);
		if(inter.getShopId().isEmpty())
		{
			msg.setRspCode(ResCodeConstant.MSG_PARAM_NOT_ENOUGH).setRspMsg(ResCodeConstant.MSG_PARAM_NOT_ENOUGH_DESC);
			return msg;
		}
		if(inter.getChannel().isEmpty())
		{
			msg.setRspCode(ResCodeConstant.MSG_PARAM_NOT_ENOUGH).setRspMsg(ResCodeConstant.MSG_PARAM_NOT_ENOUGH_DESC);
			return msg;
		}
		return enterServiceImpl.saveInterestShopInfo(inter);
	}
	
	/**
	 * 获取enter内容
	 * */
	@RequestMapping("DelInterestShop")
	public @ResponseBody Message DelInterestShop(HttpSession session,TblInterestShopInfo inter){
		
		Message msg = new Message();
		Object obj=session.getAttribute(LTConstant.userInfo);
		String uid="";
		String username="";
		if(obj!=null)
		{
			TblUserInfo userinfo =(TblUserInfo)obj;
		    uid=userinfo.getId();
		    username=userinfo.getUsername();
		}
		else{
			msg.setRspCode(ResCodeConstant.MSG_NOT_LOGIN).setRspMsg(ResCodeConstant.MSG_NOT_LOGIN_DESC);
			return msg;
		}
		inter.setUserId(uid);
		if(inter.getShopId().isEmpty())
		{
			msg.setRspCode(ResCodeConstant.MSG_PARAM_NOT_ENOUGH).setRspMsg(ResCodeConstant.MSG_PARAM_NOT_ENOUGH_DESC);
			return msg;
		}
		return enterServiceImpl.delInterestShopInfo(inter);
	}
	
}
