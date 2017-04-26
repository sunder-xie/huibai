package com.app.service;
import com.app.common.model.Message;
import com.app.bean.TblPayDtl;

public interface PayDtlService {
	/**
	 * 检查交易支付状态并保存支付流水信息
	 * */
	public Message checkStaPayDtl(TblPayDtl paydtl);
	
	public Message savePayDtl(TblPayDtl paydtl);

	public Message updatePayDtl(TblPayDtl paydtl);

	public Message checkPayDtlSta(String OrderId);
	
}
