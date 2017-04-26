package com.app.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.app.common.model.Message;
import com.app.common.model.Pager;
import com.app.service.BuyCarService;
import com.app.ReqModel.BuyCarOpertionModel;
import com.app.ReqModel.ChangeBuyCarNum;
import com.app.ReqModel.CarIdListModel;
import com.app.bean.TblBuyCarInfo;
import com.app.bean.TblUserInfo;
import com.app.common.utils.LTConstant;
import com.app.common.utils.ResCodeConstant;

@Controller
@RequestMapping("BuyCar")
public class BuyCarController {
	
	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private BuyCarService buyServiceImpl;
	
	/**
	 * 获取order内容
	 * */
	@RequestMapping("GetBuyCarListByBuyer")
	public @ResponseBody Pager GetBuyCarListByBuyer(Pager pages,HttpSession session){
		
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
		
		return buyServiceImpl.getBuyCarList(pages,UserId);
	}
	
	/**
	 * 获取order内容
	 * */
	@RequestMapping("GetBuyCarListByCarId")
	public @ResponseBody Message GetBuyCarListByCarId(HttpSession session,CarIdListModel model){
		
		Message msg = new Message();
		
		if(model.getCarIdList().isEmpty())
		{
			msg.setRspCode("100003");
			msg.setRspMsg("商品编号为空");
			return msg;
		}
		
		if(model.getChannel().isEmpty())
		{
			msg.setRspCode("100002");
			msg.setRspMsg("店铺编号为空");
			return msg;
		}
		Object obj=session.getAttribute(LTConstant.userInfo);
		String UserId="";
		if(obj!=null)
		{
			TblUserInfo userinfo =(TblUserInfo)obj;
			UserId=userinfo.getId();
		}
		else{
			msg.setRspCode(ResCodeConstant.MSG_NOT_LOGIN);
			msg.setRspMsg(ResCodeConstant.MSG_NOT_LOGIN_DESC);
			return msg;
		}
		
		return buyServiceImpl.getBuyCarListByCarId(model);
	}
	
	/**
	 * 添加购物车
	 * */
	@RequestMapping("AddGoodsInBuyCar")
	public @ResponseBody Message AddGoodsInBuyCar(HttpSession session,BuyCarOpertionModel model){
		
		Message msg = new Message();
		
		if(model.getGoodsId().isEmpty())
		{
			msg.setRspCode("100003");
			msg.setRspMsg("商品编号为空");
			return msg;
		}
		
		if(model.getShopId().isEmpty())
		{
			msg.setRspCode("100002");
			msg.setRspMsg("店铺编号为空");
			return msg;
		}
		
		if(model.getTypeId().isEmpty())
		{
			msg.setRspCode("100004");
			msg.setRspMsg("商品属性为空");
			return msg;
		}
		
		if(model.getChannel().isEmpty())
		{
			msg.setRspCode("100005");
			msg.setRspMsg("渠道为空");
			return msg;
		}
		
		if(model.getBuyNum()<0)
		{
			msg.setRspCode("100006");
			msg.setRspMsg("数量为空");
			return msg;
		}
		Object obj=session.getAttribute(LTConstant.userInfo);
		String UserId="";
		if(obj!=null)
		{
			TblUserInfo userinfo =(TblUserInfo)obj;
			UserId=userinfo.getId();
		}
		else{
			msg.setRspCode(ResCodeConstant.MSG_NOT_LOGIN);
			msg.setRspMsg(ResCodeConstant.MSG_NOT_LOGIN_DESC);
			return msg;
		}
		return buyServiceImpl.saveBuyCarInfo(model,UserId);
	}
	
	/**
	 * 添加购物车
	 * */
	@RequestMapping("DelGoodsInBuyCar")
	public @ResponseBody Message DelGoodsInBuyCar(HttpSession session,BuyCarOpertionModel model){
		
		Message msg = new Message();
		if(model.getGoodsId().isEmpty())
		{
			msg.setRspCode("100003");
			msg.setRspMsg("商品编号为空");
			return msg;
		}
		
		if(model.getTypeId().isEmpty())
		{
			msg.setRspCode("100004");
			msg.setRspMsg("商品属性为空");
			return msg;
		}
		
		if(model.getChannel().isEmpty())
		{
			msg.setRspCode("100005");
			msg.setRspMsg("渠道为空");
			return msg;
		}
		
		Object obj=session.getAttribute(LTConstant.userInfo);
		String UserId="";
		if(obj!=null)
		{
			TblUserInfo userinfo =(TblUserInfo)obj;
			UserId=userinfo.getId();
		}
		else{
			msg.setRspCode(ResCodeConstant.MSG_NOT_LOGIN);
			msg.setRspMsg(ResCodeConstant.MSG_NOT_LOGIN_DESC);
			return msg;
		}
		return buyServiceImpl.delBuyCarInfo(model,UserId);
	}
	
	
	/**
	 * 添加购物车
	 * */
	@RequestMapping("ChangeBuyCarNum")
	public @ResponseBody Message ChangeBuyCarNum(HttpSession session,ChangeBuyCarNum model){
		
		Message msg = new Message();
		
		if(model.getBuyCarOrder().isEmpty())
		{
			msg.setRspCode("100005");
			msg.setRspMsg("购物车信息为空");
			return msg;
		}
		if(model.getChannel().isEmpty())
		{
			msg.setRspCode("100005");
			msg.setRspMsg("渠道为空");
			return msg;
		}
		
		Object obj=session.getAttribute(LTConstant.userInfo);
		String UserId="";
		if(obj!=null)
		{
			TblUserInfo userinfo =(TblUserInfo)obj;
			UserId=userinfo.getId();
		}
		else{
			msg.setRspCode(ResCodeConstant.MSG_NOT_LOGIN);
			msg.setRspMsg(ResCodeConstant.MSG_NOT_LOGIN_DESC);
			return msg;
		}
		return buyServiceImpl.changeBuyCarNum(model,UserId);
	}
	
}
