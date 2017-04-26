package com.app.service;
import com.app.common.model.Message;
import com.app.common.model.Pager;
import com.app.bean.TblNoticeInfo;

public interface NoticeService {
	/**
	 * 获取公告内容
	 * */
	public Message getNoticeDetail(TblNoticeInfo noticeInfo);
	
	/**
	 * 获取公告列表
	 * */
	public Pager getNoticeAll(Pager pager);
	
	
	//public Pager getNoticeList(Object obj, String queryName,Object[] conditions);

}
