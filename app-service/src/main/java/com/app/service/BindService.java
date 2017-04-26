package com.app.service;
import com.app.common.model.Message;
import com.app.bean.TblBindInfo;

public interface BindService {
	/**
	 * 获取公告内容
	 * */
	public Message getBindInfo(TblBindInfo bindInfo,String uid);
	
}
