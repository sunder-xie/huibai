package com.app.service;
import com.app.common.model.*;
import com.app.bean.TblAddressInfo;

public interface AddressService {
	/**
	 * 获取公告内容
	 * */
	public Pager getAddressInfo(Pager pages,String uid);
	
	/**
	 * 获取公告内容
	 * */
	public Message getAddressInfoByAddrId(TblAddressInfo addrInfo,String uid);
	
	/**
	 * 获取公告内容
	 * */
	public Message saveAddressInfo(TblAddressInfo addrInfo,String uid);
	
	/**
	 * 获取公告内容
	 * */
	public Message deleteAddressInfo(TblAddressInfo addrInfo,String uid);
	
	/**
	 * 获取公告内容
	 * */
	public Message setDefaultAddr(TblAddressInfo addrInfo,String uid);
	
	/**
	 * 更新店铺信息
	 * */
	public Message updateAddressInfo(TblAddressInfo addrInfo,String uid);

	public Message getDefaultAddr(TblAddressInfo addrInfo, String uid);
	
}
