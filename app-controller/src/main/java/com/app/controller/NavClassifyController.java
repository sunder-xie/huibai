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
import com.app.service.NavClassifyService;
import com.app.bean.TblNavClassifyInfo;
import com.app.common.utils.LTConstant;

@Controller
@RequestMapping("NavClassify")
public class NavClassifyController {
	
	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private NavClassifyService navClassServiceImpl;
	
	/**
	 * 获取classify内容
	 * */
	@RequestMapping("GetTopNavClassifyInfo")
	public @ResponseBody Message GetTopNavClassifyInfo(HttpSession session,HttpServletRequest request,HttpServletResponse response){
		log.info("GetTopNavClassifyInfo start:");
		Message msg = new Message();
		//获取请求参数
		Map<String,String> params = LTConstant.getParameters(request);
		if(params == null){
			msg.setRspCode("000002");
			msg.setRspMsg("参数为空!");
			return msg;
		}		 
		String navType = params.get("navType");
		String pclassify = params.get("pclassify");
		String clevel = params.get("clevel");
		TblNavClassifyInfo classifyInfo = new TblNavClassifyInfo();
		classifyInfo.setCtype(navType);
		classifyInfo.setPclassify(pclassify);
		classifyInfo.setClevel(clevel);
		msg = navClassServiceImpl.getTopNavClassifyInfo(classifyInfo);
		return msg;
	}
	
	/**
	 * 获取classify内容
	 * */
	@RequestMapping("GetLastNavClassifyInfo")
	public @ResponseBody Message GetLastNavClassifyInfo(HttpSession session,HttpServletRequest request,HttpServletResponse response){
		log.info("GetLastNavClassifyInfo start:");
		Message msg = new Message();
		//获取请求参数
		Map<String,String> params = LTConstant.getParameters(request);
		if(params == null){
			msg.setRspCode("000002");
			msg.setRspMsg("参数为空!");
			return msg;
		}		 
		String navType = params.get("navType");
		String pclassify = params.get("pclassify");
		TblNavClassifyInfo classifyInfo = new TblNavClassifyInfo();
		classifyInfo.setCtype(navType);
		classifyInfo.setPclassify(pclassify);
		msg = navClassServiceImpl.getLastNavClassifyInfo(classifyInfo);
		return msg;
	}
	
}
