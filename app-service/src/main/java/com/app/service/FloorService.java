package com.app.service;
import com.app.common.model.Message;
import com.app.common.model.Pager;
import com.app.bean.TblFloorInfo;

public interface FloorService {
	/**
	 * 获取公告内容
	 * */
	public Message getFloorInfo(TblFloorInfo floorInfo);

	public Message getAllFloorInfo(String type);
	
	
}
