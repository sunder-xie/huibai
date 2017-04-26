package com.app.service;
import com.app.common.model.Message;
import com.app.common.model.Pager;
import com.app.bean.TblActivityInfo;

public interface ActivityService {
	/**
	 * 获取公告内容
	 * */
	public Message getActivityInfo(TblActivityInfo activityInfo);
	
	
}
