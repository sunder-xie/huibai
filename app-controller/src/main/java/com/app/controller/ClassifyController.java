package com.app.controller;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.app.common.model.Message;
import com.app.common.model.Pager;
import com.app.service.ClassifyService;
import com.app.service.MyClassifyService;
import com.app.bean.TblClassifyInfo;
import com.app.bean.TblMyClassifyInfo;

@Controller
@RequestMapping("Classify")
public class ClassifyController {
	
	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private ClassifyService classifyServiceImpl;
	
	@Resource
	private MyClassifyService myclassifyServiceImpl;
	/**
	 * 获取classify内容
	 * */
	@RequestMapping("GetClassifyInfo")
	public @ResponseBody Message GetClassifyInfo(TblClassifyInfo classifyInfo){
		return classifyServiceImpl.getClassifyInfo(classifyInfo);
	}
	
	/**
	 * 获取classify内容
	 * */
	@RequestMapping("GetClassifyPath")
	public @ResponseBody Message GetClassifyPath(TblClassifyInfo classifyInfo){
		return classifyServiceImpl.getClassifyPath(classifyInfo);
	}
	
	/**
	 * 获取classify内容
	 * */
	@RequestMapping("GetMyClassifyLatest")
	public @ResponseBody Message GetMyClassifyLatest(TblMyClassifyInfo myClassify){
		return myclassifyServiceImpl.getMyClassifyInfo(myClassify);
	}
	
}
