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
import com.app.service.ShopService;
import com.hlb.utils.string.StringUtils;
import com.app.bean.TblShopInfo;
import com.app.bean.TblUserInfo;
import com.app.common.utils.LTConstant;
import com.app.common.utils.ResCodeConstant;

@Controller
@RequestMapping("Shop")
public class ShopController {
	
	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private ShopService shopServiceImpl;
	/**
	 * 获取shop内容
	 * */
	@RequestMapping("GetShopInfo")
	public @ResponseBody Message GetShopInfo(String shopId){
		
		Message msg = new Message();
		
		if(StringUtils.isEmpty(shopId))
		{
			msg.setRspCode("100002").setRspMsg("店铺编号为空!");
			return msg;
		}
		TblShopInfo shopInfo = new TblShopInfo();
		shopInfo.setShopId(shopId);
		return shopServiceImpl.getShopInfo(shopInfo);
	}
	
	/**
	 * 获取shop内容
	 * */
	@RequestMapping("GetShopInfoByUserId")
	public @ResponseBody Message GetShopInfoByUserId(HttpServletRequest request){
		
		Message msg = new Message();
		//获取请求参数
		Map<String,String> params = LTConstant.getParameters(request);
		if(params == null){
			msg.setRspCode("000002").setRspMsg("参数为空!");
			return msg;
		}
		String userId = params.get("userId");
		String status = "0";
		return shopServiceImpl.getShopInfoByUserId(userId,status);
	}
	
	/**
	 * 获取shop内容
	 * */
	@RequestMapping("GetShopInfoByLoginUser")
	public @ResponseBody Message GetShopInfoByLoginUser(HttpSession session){
		
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
		String status = "0";
		return shopServiceImpl.getShopInfoByUserId(UserId,status);
	}
	
	/**
	 * 获取shop内容
	 * */
	@RequestMapping("GetRegShopInfo")
	public @ResponseBody Message GetRegShopInfo(HttpServletRequest request){
		
		Message msg = new Message();
		//获取请求参数
		Map<String,String> params = LTConstant.getParameters(request);
		if(params == null){
			msg.setRspCode("000002").setRspMsg("参数为空!");
			return msg;
		}
		String userId = params.get("userId");
		String status = "1";
		
		return shopServiceImpl.getShopInfoByUserId(userId,status);
	}
	
	/**
	 * 注册店铺信息
	 * */
	@RequestMapping("ShopRegister")
	public @ResponseBody Message ShopReg(TblShopInfo shopInfo,HttpSession session,HttpServletRequest request){
		Message msg = new Message();
		//获取请求参数
		Map<String,String> params = LTConstant.getParameters(request);
		if(params == null){
			msg.setRspCode("000002").setRspMsg("参数为空!");
			return msg;
		}
		String userId = params.get("userId");
		String enterType = params.get("enterType");
		if(enterType.equals("1"))/*企业商家进驻*/
		{
			msg=shopServiceImpl.saveShopInfoForEprise(shopInfo,params);
		}else{
			msg=shopServiceImpl.saveShopInfoForPerson(shopInfo,params);
		}
		return msg;
	}
	
	/**
	 * 更新店铺信息
	 * */
	@RequestMapping("UpdateShopInfo")
	public @ResponseBody Message UpdateShopInfo(TblShopInfo shopInfo,HttpSession session,HttpServletRequest request){
		Message msg = new Message();
		//获取请求参数
		Map<String,String> params = LTConstant.getParameters(request);
		if(params == null){
			msg.setRspCode("000002").setRspMsg("参数为空!");
			return msg;
		}
		msg=shopServiceImpl.updateShopInfo(shopInfo,params);
		
		return msg;
	}
	
	/**
	 * 更新进驻阶段店铺信息
	 * */
	@RequestMapping("UpdateEnterShopInfo")
	public @ResponseBody Message UpdateEnterShopInfo(TblShopInfo shopInfo,HttpSession session,HttpServletRequest request){
		Message msg = new Message();
		//获取请求参数
		Map<String,String> params = LTConstant.getParameters(request);
		if(params == null){
			msg.setRspCode("000002").setRspMsg("参数为空!");
			return msg;
		}
		String userId = params.get("userId");
		
		String enterType = params.get("enterType");
		if(enterType.equals("1"))/*企业商家进驻*/
		{
			msg=shopServiceImpl.updateShopInfoForEprise(shopInfo,params);
		}else{
			msg=shopServiceImpl.updateShopInfoForPerson(shopInfo,params);
		}
		
		return msg;
	}
	
	/**
	 * 更新店铺信息
	 * */
	@RequestMapping("UpdateShopImages")
	public @ResponseBody Message UpdateShopImages(HttpSession session,HttpServletRequest request){
		Message msg = new Message();
		//获取请求参数
		Map<String,String> params = LTConstant.getParameters(request);
		if(params == null){
			msg.setRspCode("000002").setRspMsg("参数为空!");
			return msg;
		}
		//String userId = params.get("userId");
		
		return shopServiceImpl.updateShopImages(params);
	}
	
}
