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
import com.app.service.EpriseService;
import com.app.bean.TblEpriseInfo;
import com.app.bean.TblShopInfo;
import com.app.bean.TblUserInfo;
import com.app.common.utils.LTConstant;
@Controller
@RequestMapping("Eprise")
public class EpriseController {
	
	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private EpriseService epriseServiceImpl;
	/**
	 * 获取eprise内容
	 * */
	@RequestMapping("GetEpriseInfoByEpId")
	public @ResponseBody Message GetEpriseInfoByEpId(TblEpriseInfo epriseInfo){
		return epriseServiceImpl.getEpriseInfo(epriseInfo);
	}
	
	/**
	 * 获取eprise内容
	 * */
	@RequestMapping("GetEpriseInfoByShopId")
	public @ResponseBody Message GetEpriseInfoByShopId(TblEpriseInfo epriseInfo){
		return epriseServiceImpl.getEpriseInfoByShopId(epriseInfo);
	}
	
	
	/**
	 * 获取shop内容
	 * */
	@RequestMapping("GetRegEpriseInfo")
	public @ResponseBody Message GetRegEpriseInfo(HttpServletRequest request){
		
		Message msg = new Message();
		//获取请求参数
		Map<String,String> params = LTConstant.getParameters(request);
		if(params == null){
			msg.setRspCode("000002").setRspMsg("参数为空!");
			return msg;
		}
		String userId = params.get("userId");
		String status = "0";
		
		return epriseServiceImpl.getEpriseInfoByUserId(userId,status);
	}
	
	/**
	 * 注册店铺信息
	 * */
	@RequestMapping("EpriseRegister")
	public @ResponseBody Message EpriseRegister(TblEpriseInfo epriseInfo,HttpSession session,HttpServletRequest request){
		Message msg = new Message();
		//获取请求参数
		Map<String,String> params = LTConstant.getParameters(request);
		if(params == null){
			msg.setRspCode("000002").setRspMsg("参数为空!");
			return msg;
		}
		String userId = params.get("userId");
		String shopId = params.get("shopId");
		
		return epriseServiceImpl.saveEpriseInfo(epriseInfo,userId,shopId);
	}
	
	/**
	 * 更新企业信息
	 * */
	@RequestMapping("UpdateEpriseInfo")
	public @ResponseBody Message UpdateEpriseInfo(TblEpriseInfo epriseInfo,HttpSession session,HttpServletRequest request){
		Message msg = new Message();
		//获取请求参数
		Map<String,String> params = LTConstant.getParameters(request);
		if(params == null){
			msg.setRspCode("000002").setRspMsg("参数为空!");
			return msg;
		}
		String userId = params.get("userId");
		String shopId = params.get("shopId");
		return epriseServiceImpl.updateEpriseInfo(epriseInfo,userId,shopId);
	}
}
