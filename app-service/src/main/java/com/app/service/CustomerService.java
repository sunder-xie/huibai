package com.app.service;
import com.app.common.model.Message;
import com.app.bean.TblCustomerInfo;

public interface CustomerService {
	/**
	 * 获取客户信息
	 * */
	public Message getCustomerInfo(TblCustomerInfo custInfo);
	
	/**
	 * 通过店铺编号获取客户信息
	 * */
	public Message getCustomerInfoByShopId(String shopId);

	public Message saveCustomerInfo(TblCustomerInfo custInfo, String userId, String shopId, String bindType);

	public Message updateCustomerInfo(TblCustomerInfo custInfo, String userId, String shopId, String bindType);

	public Message getCustomerInfoByUserId(String userId, String status, String bindType);
}
