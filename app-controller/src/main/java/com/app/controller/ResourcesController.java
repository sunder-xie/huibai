package com.app.controller;

import java.util.List;

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
import com.app.service.ResourcesService;
import com.app.bean.TblResourcesInfo;
import com.app.common.utils.LTConstant;

@Controller
@RequestMapping("Resources")
public class ResourcesController {
	
	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private ResourcesService resServiceImpl;
	/**
	 * 获取res内容
	 * */
	@RequestMapping("GetResourcesByCondition")
	public @ResponseBody Message GetResourcesByCondition(TblResourcesInfo resInfo){
		return resServiceImpl.getResourcesInfo(resInfo);
	}
	
}
