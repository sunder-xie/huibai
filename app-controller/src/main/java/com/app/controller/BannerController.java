package com.app.controller;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.app.bean.TblBannerInfo;
import com.app.common.model.Message;
import com.app.common.model.Pager;
import com.app.service.BannerService;

@Controller
@RequestMapping("Banner")
public class BannerController {
	
	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private BannerService bannerServiceImpl;
	/**
	 * 获取banner内容
	 * */
	@RequestMapping("GetBannerInfo")
	public @ResponseBody Message GetBannerInfo(TblBannerInfo bannerInfo){
		return bannerServiceImpl.getBannerInfo(bannerInfo);
	}
	
}
