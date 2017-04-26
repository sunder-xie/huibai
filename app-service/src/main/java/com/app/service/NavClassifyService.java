package com.app.service;
import com.app.common.model.Message;
import com.app.bean.TblNavClassifyInfo;

public interface NavClassifyService {
	/**
	 * 获取公告内容
	 * */
	public Message getLastNavClassifyInfo(TblNavClassifyInfo classifyInfo);

	public Message getTopNavClassifyInfo(TblNavClassifyInfo classifyInfo);

	
}
