package com.app.service;

import com.app.bean.TblInterestShopInfo;
import com.app.common.model.Message;
import com.app.common.model.Pager;

public interface InterestShopService {
	/**
	 * @param pages 
	 * 
	 * */
	public Pager getInterestShopInfo(String UserId, Pager pages);

	public Message saveInterestShopInfo(TblInterestShopInfo shop);

	public Message delInterestShopInfo(TblInterestShopInfo inter);
	
}
