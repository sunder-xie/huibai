package com.app.common.model;

/**
 * 前后台数据交换的简单的Msg 
 **/
public class Message {
	
	private String rspCode = "000000";
	private String rspMsg = "交易成功";
	private Object objs;
	public String getRspCode() {
		return rspCode;
	}
	public Message setRspCode(String rspCode) {
		this.rspCode = rspCode;
		return this;
	}
	public String getRspMsg() {
		return rspMsg;
	}
	public void setRspMsg(String rspMsg) {
		this.rspMsg = rspMsg;
	}
	public Object getObjs() {
		return objs;
	}
	public void setObjs(Object objs) {
		this.objs = objs;
	}
}
