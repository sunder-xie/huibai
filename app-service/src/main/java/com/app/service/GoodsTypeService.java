package com.app.service;
import com.app.common.model.Message;
import com.app.bean.TblGoodsTypeInfo;

public interface GoodsTypeService {
	/**
	 * 获取商品属性内容
	 * */
	public Message getGoodsTypeInfo(TblGoodsTypeInfo gtypeInfo);

	public Message getGoodsTypeInfoByTypeId(String TypeId);
		
}
