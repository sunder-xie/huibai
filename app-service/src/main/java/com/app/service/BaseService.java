package com.app.service;

import java.util.List;

import com.app.bean.SysFuncInfo;

public interface BaseService {
	
	/**
	 * 记载获取导航信息
	 * */
	public List<SysFuncInfo> getMenuNavInfo(SysFuncInfo sysfuncinfo);
	
}
