package com.app.service;
import java.util.Map;

import com.app.common.model.Message;
import com.app.bean.TblShopBannerInfo;

public interface ShopBannerService {
	/**
	 * 获取公告内容
	 * */
	public Message getShopBannerInfo(TblShopBannerInfo shopbannerInfo);
	
	/**
	 * 获取公告内容
	 * */
	public Message saveShopBanner(Map<String, String> params);
	
	/**
	 * 获取公告内容
	 * */
	public Message updateShopBanner(Map<String, String> params);
	
	/**
	 * 获取公告内容
	 * */
	public Message delShopBanner(Map<String, String> params);
	
}
