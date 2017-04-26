package com.app.service;
import com.app.common.model.Message;
import com.app.bean.TblMyClassifyInfo;;

public interface MyClassifyService {
	/**
	 * 获取公告内容
	 * */
	public Message getMyClassifyInfo(TblMyClassifyInfo myClassify);
	
	
}
