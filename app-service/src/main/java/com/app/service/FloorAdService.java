package com.app.service;
import com.app.common.model.Message;
import com.app.common.model.Pager;
import com.app.bean.TblFloorAdInfo;

public interface FloorAdService {
	/**
	 * 获取公告内容
	 * */
	public Message getFloorAdInfo(TblFloorAdInfo flooradInfo);
	
	
}
