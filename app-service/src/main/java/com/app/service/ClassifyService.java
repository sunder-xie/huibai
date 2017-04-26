package com.app.service;
import com.app.common.model.Message;
import com.app.common.model.Pager;
import com.app.bean.TblClassifyInfo;

public interface ClassifyService {
	/**
	 * 获取公告内容
	 * */
	public Message getClassifyInfo(TblClassifyInfo classifyInfo);

	public Message getClassifyPath(TblClassifyInfo classifyInfo);
	
	
}
