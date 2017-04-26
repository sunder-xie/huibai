package com.app.service;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.app.common.model.Message;
import com.app.common.model.Pager;
import com.app.bean.TblGoodsInfo;

public interface GoodsService {
	/**
	 * 获取公告内容
	 * */
	public Message getGoodsInfo(TblGoodsInfo goodsInfo);
	
	/**
	 * 获取公告内容
	 * */
	public Message getGoodsShortInfo(TblGoodsInfo goodsInfo);
	
	/**
	 * 获取公告内容
	 * */

	public Message getShopGoodsShortInfo(TblGoodsInfo goodsInfo);
	
	public Pager getGoodsShortInfoList(Pager pages) ;

	public Message addGoodsInfo(Map<String, String> params);

	public Message updateGoodsStatus(Map <String ,String> params);

	public Message deleteGoodsInfo(Map<String, String> params);

	public Message editGoodsInfo(Map<String, String> params);

}
