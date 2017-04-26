package com.app.ReqModel;

public class CheckBuyGoodsReqModel {

	private String GoodsId;
	private String ShopId;
	private String SkuId;
	private Integer BuyNum;
	private String SendChannel;
	
	public String getGoodsId() {
		return GoodsId;
	}
	public void setGoodsId(String goodsId) {
		GoodsId = goodsId;
	}
	
	
	public String getShopId() {
		return ShopId;
	}
	public void setShopId(String shopId) {
		ShopId = shopId;
	}
	public String getSkuId() {
		return SkuId;
	}
	public void setSkuId(String skuId) {
		SkuId = skuId;
	}
	public Integer getBuyNum() {
		return BuyNum;
	}
	public void setBuyNum(Integer buyNum) {
		BuyNum = buyNum;
	}
	public String getSendChannel() {
		return SendChannel;
	}
	public void setSendChannel(String sendChannel) {
		SendChannel = sendChannel;
	}
	
	
}
