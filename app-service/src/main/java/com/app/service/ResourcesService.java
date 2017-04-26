package com.app.service;
import com.app.common.model.Message;
import com.app.bean.TblResourcesInfo;

public interface ResourcesService {
	/**
	 * 获取公告内容
	 * */
	public Message getResourcesInfo(TblResourcesInfo resInfo);
	
	/**
	 * 获取公告内容
	 * */
	public Message saveResources(TblResourcesInfo resInfo);

	public Message getGoodsPicInfo(TblResourcesInfo resInfo);
		
}
