package com.app.UnionPay.tencent.model;

import java.util.Date;

import com.hlb.utils.date.DateUtil;
import com.hlb.utils.security.UUID;

/**
 * 统一支付模型 
 * */
public class WxNoticeReslutRsp {
	//下述字段，均配置，不能通过setter方式设置
	private String returnCode ;//
	private String returnMsg ;
	public String getReturnCode() {
		return returnCode;
	}
	public void setReturnCode(String returnCode) {
		this.returnCode = returnCode;
	}
	public String getReturnMsg() {
		return returnMsg;
	}
	public void setReturnMsg(String returnMsg) {
		this.returnMsg = returnMsg;
	}
	
	
}
