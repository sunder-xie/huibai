package com.app.controller;

import java.net.URLDecoder;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.app.common.model.Pager;
import com.app.service.GoodsService;

@Controller
@RequestMapping("TuiG")
public class TgGoodsController {
	
	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private GoodsService GoodsServiceImpl;
	/**
	 * 获取activity内容
	 * */
	@RequestMapping("getTgGoodsInfByKeyword")
	public @ResponseBody Pager getTgGoodsInfByKeyword(Pager keyword){
		
		return GoodsServiceImpl.getGoodsShortInfoList(keyword);
	}
	
}
