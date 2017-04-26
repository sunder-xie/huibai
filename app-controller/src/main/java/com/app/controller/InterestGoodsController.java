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
import com.app.service.InterestGoodsService;
import com.app.bean.TblInterestGoodsInfo;
import com.app.bean.TblUserInfo;
import com.app.common.utils.LTConstant;
import com.app.common.utils.ResCodeConstant;
@Controller
@RequestMapping("InterestGoods")
public class InterestGoodsController {
	
	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private InterestGoodsService enterServiceImpl;
	/**
	 * 获取enter内容
	 * */
	@RequestMapping("GetInterestGoodsList")
	public @ResponseBody Pager GetInterestGoodsList(HttpSession session,Pager pages){
		
		
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
		
		return enterServiceImpl.getInterestGoodsInfo(UserId,pages);
	}
	
	/**
	 * 获取enter内容
	 * */
	@RequestMapping("AddInterestGoods")
	public @ResponseBody Message AddInterestGoods(HttpSession session,TblInterestGoodsInfo inter){
		
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
		if(inter.getGoodsId().isEmpty())
		{
			msg.setRspCode(ResCodeConstant.MSG_PARAM_NOT_ENOUGH).setRspMsg(ResCodeConstant.MSG_PARAM_NOT_ENOUGH_DESC);
			return msg;
		}
		if(inter.getChannel().isEmpty())
		{
			msg.setRspCode(ResCodeConstant.MSG_PARAM_NOT_ENOUGH).setRspMsg(ResCodeConstant.MSG_PARAM_NOT_ENOUGH_DESC);
			return msg;
		}
		return enterServiceImpl.saveInterestGoodsInfo(inter);
	}
	
	/**
	 * 获取enter内容
	 * */
	@RequestMapping("DelInterestGoods")
	public @ResponseBody Message DelInterestGoods(HttpSession session,TblInterestGoodsInfo inter){
		
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
		if(inter.getGoodsId().isEmpty())
		{
			msg.setRspCode(ResCodeConstant.MSG_PARAM_NOT_ENOUGH).setRspMsg(ResCodeConstant.MSG_PARAM_NOT_ENOUGH_DESC);
			return msg;
		}
		return enterServiceImpl.delInterestGoodsInfo(inter);
	}
	
}
