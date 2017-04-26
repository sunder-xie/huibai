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
import com.app.service.CustomerService;
import com.app.bean.TblCustomerInfo;
import com.app.common.utils.LTConstant;
@Controller
@RequestMapping("Customer")
public class CustomerController {
	
	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private CustomerService custServiceImpl;
	/**
	 * 获取cust内容
	 * */
	@RequestMapping("GetCustomerInfoByCustId")
	public @ResponseBody Message GetCustomerInfoByCustId(TblCustomerInfo custInfo){
		return custServiceImpl.getCustomerInfo(custInfo);
	}
	
	/**
	 * 获取cust内容
	 * */
	@RequestMapping("GetCustomerInfoByShopId")
	public @ResponseBody Message GetCustomerInfoByShopId(HttpServletRequest request){
		Message msg = new Message();
		//获取请求参数
		Map<String,String> params = LTConstant.getParameters(request);
		if(params == null){
			msg.setRspCode("000002").setRspMsg("参数为空!");
			return msg;
		}
		String shopId = params.get("shopId");
		
		return custServiceImpl.getCustomerInfoByShopId(shopId);
	}
	
	
	/**
	 * 获取shop内容
	 * */
	@RequestMapping("GetRegCustomerInfo")
	public @ResponseBody Message GetRegCustomerInfo(HttpServletRequest request){
		
		Message msg = new Message();
		//获取请求参数
		Map<String,String> params = LTConstant.getParameters(request);
		if(params == null){
			msg.setRspCode("000002").setRspMsg("参数为空!");
			return msg;
		}
		String userId = params.get("userId");
		String bindType = params.get("bindType");
		String status = "0";
		
		return custServiceImpl.getCustomerInfoByUserId(userId,status,bindType);
	}
	
	/**
	 * 注册店铺信息
	 * */
	@RequestMapping("SaveCustomerInfo")
	public @ResponseBody Message SaveCustomerInfo(TblCustomerInfo custInfo,HttpSession session,HttpServletRequest request){
		Message msg = new Message();
		//获取请求参数
		Map<String,String> params = LTConstant.getParameters(request);
		if(params == null){
			msg.setRspCode("000002").setRspMsg("参数为空!");
			return msg;
		}
		String userId = params.get("userId");
		String bindType = params.get("bindType");
		String shopId ="";
		if(!bindType.equals("01"))
		{
			shopId = params.get("shopId");
		}
		return custServiceImpl.saveCustomerInfo(custInfo,userId,shopId,bindType);
	}
	
	/**
	 * 更新客户信息
	 * */
	@RequestMapping("UpdateCustomerInfo")
	public @ResponseBody Message UpdateCustomerInfo(TblCustomerInfo custInfo,HttpSession session,HttpServletRequest request){
		Message msg = new Message();
		//获取请求参数
		Map<String,String> params = LTConstant.getParameters(request);
		if(params == null){
			msg.setRspCode("000002").setRspMsg("参数为空!");
			return msg;
		}
		String userId = params.get("userId");
		String bindType = params.get("bindType");
		String shopId ="";
		if(!bindType.equals("01"))
		{
			shopId = params.get("shopId");
		}
		
		return custServiceImpl.updateCustomerInfo(custInfo,userId,shopId,bindType);
	}
}
