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
import com.app.service.ShopBannerService;
import com.app.bean.TblShopBannerInfo;
import com.app.common.utils.LTConstant;

@Controller
@RequestMapping("ShopBanner")
public class ShopBannerController {
	
	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private ShopBannerService shopbannerServiceImpl;
	/**
	 * 获取shopbanner内容
	 * */
	@RequestMapping("GetShopBannerInfo")
	public @ResponseBody Message GetShopBannerInfo(TblShopBannerInfo shopbannerInfo){
		return shopbannerServiceImpl.getShopBannerInfo(shopbannerInfo);
	}
	
	/**
	 * 获取shopbanner内容
	 * */
	@RequestMapping("SaveShopBanner")
	public @ResponseBody Message SaveShopBanner(HttpSession session,HttpServletRequest request){
		
		Message msg = new Message();
		//获取请求参数
		Map<String,String> params = LTConstant.getParameters(request);
		if(params == null){
			msg.setRspCode("000002").setRspMsg("参数为空!");
			return msg;
		}
		//String userId = params.get("userId");
		
		return shopbannerServiceImpl.saveShopBanner(params);
	}
	
	/**
	 * 获取shopbanner内容
	 * */
	@RequestMapping("UpdateShopBanner")
	public @ResponseBody Message UpdateShopBanner(HttpSession session,HttpServletRequest request){
		
		Message msg = new Message();
		//获取请求参数
		Map<String,String> params = LTConstant.getParameters(request);
		if(params == null){
			msg.setRspCode("000002").setRspMsg("参数为空!");
			return msg;
		}
		//String userId = params.get("userId");
		return shopbannerServiceImpl.updateShopBanner(params);
	}
	
	/**
	 * 获取shopbanner内容
	 * */
	@RequestMapping("DelShopBanner")
	public @ResponseBody Message DelShopBanner(HttpSession session,HttpServletRequest request){
		
		Message msg = new Message();
		//获取请求参数
		Map<String,String> params = LTConstant.getParameters(request);
		if(params == null){
			msg.setRspCode("000002").setRspMsg("参数为空!");
			return msg;
		}
		//String userId = params.get("userId");
		return shopbannerServiceImpl.delShopBanner(params);
	}
	
}
