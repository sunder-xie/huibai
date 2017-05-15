package com.app.controller;

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
import com.app.service.OrderService;
import com.hlb.utils.string.StringUtils;
import com.app.ReqModel.BuyCarOrder;
import com.app.ReqModel.BuyOrderReqModel;
import com.app.bean.TblOrderInfo;
import com.app.bean.TblUserInfo;
import com.app.common.utils.LTConstant;
import com.app.common.utils.ResCodeConstant;

@Controller
@RequestMapping("Order")
public class OrderController {
	
	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private OrderService orderServiceImpl;
	/**
	 * 获取order内容
	 * */
	@RequestMapping("GetOrderInfoByBuyer")
	public @ResponseBody Pager GetOrderInfoByBuyer(Pager pages,HttpSession session,HttpServletRequest request,HttpServletResponse response){
		Pager msg = new Pager();
		//获取请求参数
		Map<String,String> params = LTConstant.getParameters(request);
		if(params == null){
			msg.setRspCode("000002");
			msg.setRspMsg("参数为空!");
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
			pages.setRspCode(ResCodeConstant.MSG_NOT_LOGIN);
			pages.setRspMsg(ResCodeConstant.MSG_NOT_LOGIN_DESC);
			return pages;
		}
		
		return orderServiceImpl.getUserOrderListInfo(pages,UserId);
	}
	
	/**
	 * 获取order内容
	 * */
	@RequestMapping("GetOrderListByBuyer")
	public @ResponseBody Pager GetOrderListByBuyer(Pager pages,HttpSession session){
		
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
		
		return orderServiceImpl.getUserOrderList(pages,UserId);
	}
	
	/**
	 * 获取order内容
	 * */
	@RequestMapping("GetOrderGoodsByOrderId")
	public @ResponseBody Message GetOrderGoodsByOrderId(HttpSession session,HttpServletRequest request,HttpServletResponse response){
		Message msg = new Message();
		//获取请求参数
		Map<String,String> params = LTConstant.getParameters(request);
		if(params == null){
			msg.setRspCode("000002");
			msg.setRspMsg("参数为空!");
			return msg;
		}
		Object obj=session.getAttribute(LTConstant.userInfo);
		TblUserInfo userinfo =(TblUserInfo)obj;
		String userId = userinfo.getId();
		if(!userinfo.getId().equals(params.get("userId")))
		{
			msg.setRspCode(LTConstant.UserNotLogin);
			msg.setRspMsg("用户登录失效!");
			return msg;
		}
		
		return orderServiceImpl.getOrderGoodsByOrderId(params);
	}
	
	/**
	 * 获取order内容
	 * */
	@RequestMapping("GetOrderGoodsShortInfoByOrderId")
	public @ResponseBody Message GetOrderGoodsShortInfoByOrderId(HttpSession session,String orderId){
		Message msg = new Message();
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
		if(StringUtils.isEmpty(orderId))
		{
			msg.setRspCode("000002").setRspMsg("参数[orderId]为空!");
			return msg;
		}
		
		return orderServiceImpl.getOrderGoodsShortInfoByOrderId(orderId);
	}
	
	/**
	 * 获取order内容
	 * */
	@RequestMapping("GetOrderInfoBySaler")
	public @ResponseBody Pager GetOrderInfoBySaler(Pager pages,HttpSession session,HttpServletRequest request,HttpServletResponse response){
		Pager msg = new Pager();
		Map<String,String> params = LTConstant.getParameters(request);
		if(params == null){
			msg.setRspCode("000002");
			msg.setRspMsg("参数为空!");
			return msg;
		}
		Object obj=session.getAttribute(LTConstant.userInfo);
		TblUserInfo userinfo =(TblUserInfo)obj;
		String userId = userinfo.getId();
		if(!userinfo.getId().equals(params.get("userId")))
		{
			msg.setRspCode("000002");
			msg.setRspMsg("用户登录失效!");
			return msg;
		}
		return orderServiceImpl.getMerOrderListInfo(pages);
	}
	
	/**
	 * 获取order内容
	 * */
	@RequestMapping("GetOrderListBySaler")
	public @ResponseBody Pager GetOrderListBySaler(Pager pages,HttpSession session){
		
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
		
		if(!pages.getConditions().containsKey("shopId")){
			pages.setRspCode(ResCodeConstant.MSG_PARAM_NOT_ENOUGH);
			pages.setRspMsg("商家编号为空");	
			return pages;
		}
		
		return orderServiceImpl.getMerOrderList(pages);
	}
	
	@RequestMapping("GetOrderInfoByOrderId")
	public @ResponseBody Message GetOrderInfoByOrderId(String orderId,HttpSession session){
		
		Message msg = new Message();
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
		if(StringUtils.isEmpty(orderId))
		{
			msg.setRspCode("000002").setRspMsg("参数[orderId]为空!");
			return msg;
		}
		TblOrderInfo orderInfo = new TblOrderInfo();
		orderInfo.setOrderId(orderId);
		return orderServiceImpl.getOrderInfoByOrderId(orderInfo);
	}
	
	/**
	 * 添加订单信息
	 * */
	@RequestMapping("OrderAdd")
	public @ResponseBody Message OrderAdd(HttpSession session,HttpServletRequest request){
		
		Message msg = new Message();
		//获取请求参数
		Map<String,String> params = LTConstant.getParameters(request);
		if(params == null){
			msg.setRspCode("000002").setRspMsg("参数为空!");
			return msg;
		}
		Object obj=session.getAttribute(LTConstant.userInfo);
		TblUserInfo userinfo =(TblUserInfo)obj;
		if(!userinfo.getId().equals(params.get("userId")))
		{
			msg.setRspCode("000002").setRspMsg("用户登录失效!");
			return msg;
		}
		params.put("username",userinfo.getUsername());
		return orderServiceImpl.saveOrderInfo(params);
	}
	
	/**
	 * 添加订单信息
	 * */
	@RequestMapping("BuyOrderSubmit")
	public @ResponseBody Message BuyOrderSubmit(HttpSession session,BuyOrderReqModel model){
		
		Message msg = new Message();
		Object obj=session.getAttribute(LTConstant.userInfo);
		String UserId="";
		String userNm="";
		String emptyString="";
		if(obj!=null)
		{
			TblUserInfo userinfo =(TblUserInfo)obj;
			UserId=userinfo.getId();
			userNm = userinfo.getUsername();
		}
		else{
			msg.setRspCode(ResCodeConstant.MSG_NOT_LOGIN);
			msg.setRspMsg(ResCodeConstant.MSG_NOT_LOGIN_DESC);
			return msg;
		}
		try {
			emptyString = StringUtils.checkObjectIsEmpty(model);
			if(emptyString!=null)
			{
				msg.setRspCode("000002").setRspMsg("参数["+emptyString+"]为空!");
				return msg;
			}
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			msg.setRspCode("000002").setRspMsg("参数["+emptyString+"]为空!");
			return msg;
		}
		return orderServiceImpl.saveNewOrder(model,UserId,userNm);
	}
	
	/**
	 * 添加订单信息
	 * */
	@RequestMapping("OrderAddByCar")
	public @ResponseBody Message OrderAddByCar(HttpSession session,BuyCarOrder model){
		
		Message msg = new Message();
		Object obj=session.getAttribute(LTConstant.userInfo);
		String UserId="";
		String userNm="";
		if(obj!=null)
		{
			TblUserInfo userinfo =(TblUserInfo)obj;
			UserId=userinfo.getId();
			userNm = userinfo.getUsername();
		}
		else{
			msg.setRspCode(ResCodeConstant.MSG_NOT_LOGIN);
			msg.setRspMsg(ResCodeConstant.MSG_NOT_LOGIN_DESC);
			return msg;
		}
		return orderServiceImpl.saveOrderInfoByCar(model,UserId,userNm);
	}
	
	/**
	 * 更新订单信息
	 * */
	@RequestMapping("UpdateOrderInfo")
	public @ResponseBody Message UpdateOrderInfo(TblOrderInfo orderInfo,HttpSession session,HttpServletResponse response){
		Object obj=session.getAttribute(LTConstant.userInfo);
		String uid="";
		if(obj!=null)
		{
			TblUserInfo userinfo =(TblUserInfo)obj;
		    uid=userinfo.getId();
		}
		return orderServiceImpl.updateOrderInfo(orderInfo,uid);
	}
	
	/**
	 * 更新订单信息
	 * */
	@RequestMapping("UpdateOrderInfoByTime")
	public @ResponseBody Message UpdateOrderInfoByTime(TblOrderInfo orderInfo,HttpSession session,HttpServletResponse response){
		Message msg = new Message();
		Object obj=session.getAttribute(LTConstant.userInfo);
		String uid="";
		if(obj!=null)
		{
			TblUserInfo userinfo =(TblUserInfo)obj;
		    uid=userinfo.getId();
		}
		orderServiceImpl.updateOrderInfoBySetTime();
		return msg;
	}
	
	@RequestMapping("GetOrderPayInfo")
	public @ResponseBody Message GetOrderPayInfo(HttpSession session,String OrderId){
		Message msg = new Message();
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
		if(OrderId.isEmpty())
		{
			msg.setRspCode("000002").setRspMsg("参数为空!");
			return msg;
		}
		return orderServiceImpl.getOrderPayInfo(OrderId,UserId);
	}
	
	/**
	 * 删除订单信息
	 * */
	@RequestMapping("OrderDel")
	public @ResponseBody Message OrderDel(HttpSession session,String OrderId,String userFlag){
		
		Message msg = new Message();
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
		if(StringUtils.isEmpty(OrderId))
		{
			msg.setRspCode("000002").setRspMsg("参数[OrderId]为空!");
			return msg;
		}
		
		if(StringUtils.isEmpty(userFlag))
		{
			msg.setRspCode("000002").setRspMsg("参数[userFlag]为空!");
			return msg;
		}
		String ordSta = "";
		if(userFlag.equals("1"))
			ordSta=LTConstant.ORDER_BUYER_DEL;
		else
			ordSta=LTConstant.ORDER_SALER_DEL;
		
		return orderServiceImpl.delOrderInfo(OrderId,ordSta);
	}
	
}
