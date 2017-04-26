package com.app.ReqModel;

public class SendPayInfo {

	private String OrderId;
	private String OrderDesc;
	private String PayAmt;
	private String SendChannle;
	private String PayChannle;
	public String getOrderId() {
		return OrderId;
	}
	public void setOrderId(String orderId) {
		OrderId = orderId;
	}
	public String getOrderDesc() {
		return OrderDesc;
	}
	public void setOrderDesc(String orderDesc) {
		OrderDesc = orderDesc;
	}
	public String getPayAmt() {
		return PayAmt;
	}
	public void setPayAmt(String payAmt) {
		PayAmt = payAmt;
	}
	public String getSendChannle() {
		return SendChannle;
	}
	public void setSendChannle(String sendChannle) {
		SendChannle = sendChannle;
	}
	public String getPayChannle() {
		return PayChannle;
	}
	public void setPayChannle(String payChannle) {
		PayChannle = payChannle;
	}
	
	
}
