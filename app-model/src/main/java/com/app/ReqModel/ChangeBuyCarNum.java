package com.app.ReqModel;

public class ChangeBuyCarNum {
	/*buyCarOrder json 数组
	 * {
	 * "seqId":"1",
	 * buyNum:1
	 * }
	 * 
	 * 
	 * 
	 * */
	private String buyCarOrder;
	private String channel;
	
	public String getBuyCarOrder() {
		return buyCarOrder;
	}
	public void setBuyCarOrder(String buyCarOrder) {
		this.buyCarOrder = buyCarOrder;
	}
	public String getChannel() {
		return channel;
	}
	public void setChannel(String channel) {
		this.channel = channel;
	}

	
}
