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
import com.app.service.NoticeService;
import com.app.bean.TblNoticeInfo;

@Controller
@RequestMapping("Notice")
public class NoticeController {
	
	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private NoticeService noticeServiceImpl;
	/**
	 * 获取公告内容
	 * */
	@RequestMapping("GetNoticeDetail")
	public @ResponseBody Message GetNoticeDetail(TblNoticeInfo noticeInfo){
		return noticeServiceImpl.getNoticeDetail(noticeInfo);
	}
	
	/**
	 * 获取公告列表
	 * */
	@RequestMapping("GetNoticeAll")
	public @ResponseBody Pager GetNoticeAll(Pager pagecont){
		log.info("获取公告列表");
		return noticeServiceImpl.getNoticeAll(pagecont);
	}
	
}
