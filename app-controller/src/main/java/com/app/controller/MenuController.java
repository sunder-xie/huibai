package com.app.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.app.bean.SysFuncInfo;
import com.app.service.BaseService;

@Controller
@RequestMapping("base/menu")
public class MenuController {
	
	@Resource
	private BaseService baseServiceImpl;//BaseService
	
	/**
	 * 获取各种导航信息的Menu
	 * */
	@RequestMapping("getMenuNav")
	public  @ResponseBody List<SysFuncInfo> getMenuNavInfo(SysFuncInfo sysfuncinfo){
		return baseServiceImpl.getMenuNavInfo(sysfuncinfo);
	}
	
}
