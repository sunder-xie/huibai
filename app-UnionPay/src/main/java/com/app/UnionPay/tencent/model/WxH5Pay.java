package com.app.UnionPay.tencent.model;

import com.hlb.utils.security.UUID;

public class WxH5Pay {

	private String appId = "wx27188ab67282ea8e";//公众账号
	
	private String timeStamp ;
	private String nonceStr;//随机数32
	
	private String package_;
	
	private String signType;

	private String paySign;
	
	public WxH5Pay(){
		this.nonceStr = UUID.getUUID();
	}
	

	public String getAppId() {
		return appId;
	}


	public void setAppId(String appId) {
		this.appId = appId;
	}


	public String getTimeStamp() {
		return timeStamp;
	}

	public void setTimeStamp(String timeStamp) {
		this.timeStamp = timeStamp;
	}

	

	public String getNonceStr() {
		return nonceStr;
	}


	public void setNonceStr(String nonceStr) {
		this.nonceStr = nonceStr;
	}


	public String getPackage_() {
		return package_;
	}

	public void setPackage_(String package_) {
		this.package_ = package_;
	}

	public String getSignType() {
		return signType;
	}

	public void setSignType(String signType) {
		this.signType = signType;
	}
	public String getPaySign() {
		return paySign;
	}
	public void setPaySign(String paySign) {
		this.paySign = paySign;
	}
	
	
	
}
