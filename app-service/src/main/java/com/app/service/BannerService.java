package com.app.service;
import com.app.bean.TblBannerInfo;
import com.app.common.model.Message;

public interface BannerService {
	/**
	 * 获取公告内容
	 * */
	public Message getBannerInfo(TblBannerInfo bannerInfo);
	
	
}
