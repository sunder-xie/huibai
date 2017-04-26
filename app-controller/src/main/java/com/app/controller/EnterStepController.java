package com.app.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.app.common.model.Message;
import com.app.service.EnterStepService;
import com.app.bean.TblEnterStepInfo;
import com.app.common.utils.LTConstant;
@Controller
@RequestMapping("EnterStep")
public class EnterStepController {
	
	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private EnterStepService enterServiceImpl;
	/**
	 * 获取enter内容
	 * */
	@RequestMapping("GetEnterStepInfo")
	public @ResponseBody Message GetEnterStepInfo(HttpServletRequest request){
		
		Message msg = new Message();
		//获取请求参数
		Map<String,String> params = LTConstant.getParameters(request);
		if(params == null){
			msg.setRspCode("000002").setRspMsg("参数为空!");
			return msg;
		}
		
		return enterServiceImpl.getEnterStepInfo(params);
	}
	
	/**
	 * 获取enter内容
	 * */
	@RequestMapping("SaveEnterStepInfo")
	public @ResponseBody Message SaveEnterStepInfo(HttpServletRequest request){
		
		Message msg = new Message();
		//获取请求参数
		Map<String,String> params = LTConstant.getParameters(request);
		if(params == null){
			msg.setRspCode("000002").setRspMsg("参数为空!");
			return msg;
		}
		
		return enterServiceImpl.saveEnterStepInfo(params);
	}
	
}
