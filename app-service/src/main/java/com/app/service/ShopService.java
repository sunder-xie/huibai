package com.app.service;
import java.util.Map;

import com.app.common.model.Message;
import com.app.bean.TblShopInfo;

public interface ShopService {
	/**
	 * 获取公告内容
	 * */
	public Message getShopInfo(TblShopInfo shopInfo);
	
	/**
	 * 获取公告内容
	 * */
	public Message saveShopInfoForEprise(TblShopInfo shopInfo,Map<String, String> params);
	
	public Message saveShopInfoForPerson(TblShopInfo shopInfo, Map<String, String> params);
	
	/**
	 * 更新店铺信息
	 * @param userId 
	 * */
	public Message updateShopInfo(TblShopInfo shopInfo, Map<String, String> params);
	

	public Message getShopInfoByUserId(String userId, String status);
	
	public Message updateShopInfoForEprise(TblShopInfo shopInfo, Map<String, String> params);
	public Message updateShopInfoForPerson(TblShopInfo shopInfo, Map<String, String> params);

	public Message updateShopImages(Map<String, String> params);
	
}
