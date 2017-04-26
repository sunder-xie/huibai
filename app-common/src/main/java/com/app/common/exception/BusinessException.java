package com.app.common.exception;

public class BusinessException extends Exception {
	private static final long serialVersionUID = 1L;

	private String rspCode;
	private String rspMsg;
	
	public BusinessException() {}
	
	public BusinessException(String rspCode,String resMsg) {
		this.rspCode = rspCode;
		this.rspMsg =  resMsg;
	}

	public String getRspCode() {
		return rspCode;
	}
	public void setRspCode(String rspCode) {
		this.rspCode = rspCode;
	}
	public String getRspMsg() {
		return rspMsg;
	}
	public void setRspMsg(String rspMsg) {
		this.rspMsg = rspMsg;
	}
	
	@Override
	public String toString() {
		return this.rspCode+"["+this.rspMsg+"]";
	}
}
