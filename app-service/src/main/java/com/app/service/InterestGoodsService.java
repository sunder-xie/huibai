package com.app.service;
import java.util.Map;

import com.app.bean.TblInterestGoodsInfo;
import com.app.common.model.Message;
import com.app.common.model.Pager;

public interface InterestGoodsService {
	/**
	 * @param pager 
	 * 
	 * */
	public Pager getInterestGoodsInfo(String UserId, Pager pager);

	public Message saveInterestGoodsInfo(TblInterestGoodsInfo goods);

	public Message delInterestGoodsInfo(TblInterestGoodsInfo inter);
	
}
