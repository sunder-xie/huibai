package com.app.service;
import com.app.common.model.Message;
import com.app.bean.TblEpriseInfo;

public interface EpriseService {
	/**
	 * 获取公告内容
	 * */
	public Message getEpriseInfo(TblEpriseInfo epriseInfo);
	
	/**
	 * 获取公告内容
	 * */
	public Message getEpriseInfoByShopId(TblEpriseInfo epriseInfo);

	public Message saveEpriseInfo(TblEpriseInfo epriseInfo, String userId, String shopId);

	public Message updateEpriseInfo(TblEpriseInfo epriseInfo, String userId, String shopId);

	public Message getEpriseInfoByUserId(String userId, String status);
}
