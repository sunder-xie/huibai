package com.app.RspModel;

public class OrderPayInfo {
	
	private String OrderId;
	private String ShopId;
	private String ShopNm;
	private String OrderDesc;
	private String PayAmt;
	private String OrderDt;

	public String getOrderId() {
		return OrderId;
	}

	public void setOrderId(String orderId) {
		OrderId = orderId;
	}

	public String getShopId() {
		return ShopId;
	}

	public void setShopId(String shopId) {
		ShopId = shopId;
	}

	public String getShopNm() {
		return ShopNm;
	}

	public void setShopNm(String shopNm) {
		ShopNm = shopNm;
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

	public String getOrderDt() {
		return OrderDt;
	}

	public void setOrderDt(String orderDt) {
		OrderDt = orderDt;
	}

}
