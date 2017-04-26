package com.app.ReqModel;

public class BuyCarOrder {
	
	private String CarIdList;
	private String ShopId;
	private String ShopNm;
	private String Address;
	private String Person;
	private String Mobile;
	private String YfAmt;
	private String TotalNum;
	private String TotalAmt;
	private String PayAmt;
	
	private String SendChannel;
	private String BuyMsg;
	public String getCarIdList() {
		return CarIdList;
	}
	public void setCarIdList(String carIdList) {
		CarIdList = carIdList;
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
	
	public String getAddress() {
		return Address;
	}
	public void setAddress(String address) {
		Address = address;
	}
	
	
	public String getPerson() {
		return Person;
	}
	public void setPerson(String person) {
		Person = person;
	}
	public String getMobile() {
		return Mobile;
	}
	public void setMobile(String mobile) {
		Mobile = mobile;
	}
	public String getTotalNum() {
		return TotalNum;
	}
	public void setTotalNum(String totalNum) {
		TotalNum = totalNum;
	}
	public String getYfAmt() {
		return YfAmt;
	}
	public void setYfAmt(String yfAmt) {
		YfAmt = yfAmt;
	}
	public String getTotalAmt() {
		return TotalAmt;
	}
	
	
	public void setTotalAmt(String totalAmt) {
		TotalAmt = totalAmt;
	}
	
	
	public String getPayAmt() {
		return PayAmt;
	}
	public void setPayAmt(String payAmt) {
		PayAmt = payAmt;
	}
	
	
	public String getSendChannel() {
		return SendChannel;
	}
	public void setSendChannel(String sendChannel) {
		SendChannel = sendChannel;
	}
	public String getBuyMsg() {
		return BuyMsg;
	}
	public void setBuyMsg(String buyMsg) {
		BuyMsg = buyMsg;
	}
	
	
	

	
}
