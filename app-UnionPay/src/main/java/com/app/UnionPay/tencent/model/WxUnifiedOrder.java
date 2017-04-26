package com.app.UnionPay.tencent.model;

import java.util.Date;

import com.hlb.utils.date.DateUtil;
import com.hlb.utils.security.UUID;

/**
 * 统一支付模型 
 * */
public class WxUnifiedOrder {
	//下述字段，均配置，不能通过setter方式设置
	private String appid = "wx27188ab67282ea8e";//公众账号
	private String mch_id = "1391279802";//商户号
	private String device_info = "WEB";//设备号
	private String nonce_str;//随机数32
	private String out_trade_no;//商户订单号
	private String fee_type = "CNY";//货币类型
	private String trade_type ;//交易类型
	private String notify_url = "http://www.hbaicai.com/Pay/WxNoticeResult.action";//我平台后台通知地址
	//private String notify_url = "http://pay.hbaicai.com/Pay/WxNoticeResult.action";//测试平台后台通知地址
	
	//下述字段可以进行setter
	private String sign;//签名数据
	private String body;//商品描述
	private String detail;//商品详情
	private String attach;//附加数据
	private int total_fee;//交易金额
	private String spbill_create_ip;//交易IP（客户端）
	private String product_id;//商品ID
	private String time_start;//订单生成时间
	private String time_expire;//订单超时时间
	private String openid ;//用户标识
	
	public WxUnifiedOrder() {
		this.nonce_str = UUID.getUUID();
//		this.out_trade_no = PayUtil.genPaySeqId();
//		this.time_start = DateUtil.getCurrentDate(DateUtil.DATE_FORMAT_14);
//		this.time_expire =  DateUtil.getDateToString(new Date(System.currentTimeMillis() + 60*60*1000),	 DateUtil.DATE_FORMAT_14);
	}

	public String getAppid() {
		return appid;
	}

	public void setAppid(String appid) {
		this.appid = appid;
	}

	public String getMch_id() {
		return mch_id;
	}

	public void setMch_id(String mch_id) {
		this.mch_id = mch_id;
	}

	public String getDevice_info() {
		return device_info;
	}

	public void setDevice_info(String device_info) {
		this.device_info = device_info;
	}

	public String getNonce_str() {
		return nonce_str;
	}

	public void setNonce_str(String nonce_str) {
		this.nonce_str = nonce_str;
	}

	public String getOut_trade_no() {
		return out_trade_no;
	}

	public void setOut_trade_no(String out_trade_no) {
		this.out_trade_no = out_trade_no;
	}

	public String getFee_type() {
		return fee_type;
	}

	public void setFee_type(String fee_type) {
		this.fee_type = fee_type;
	}

	public String getTrade_type() {
		return trade_type;
	}

	public void setTrade_type(String trade_type) {
		this.trade_type = trade_type;
	}

	public String getNotify_url() {
		return notify_url;
	}

	public void setNotify_url(String notify_url) {
		this.notify_url = notify_url;
	}

	public String getSign() {
		return sign;
	}

	public void setSign(String sign) {
		this.sign = sign;
	}

	public String getBody() {
		return body;
	}

	public void setBody(String body) {
		this.body = body;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getAttach() {
		return attach;
	}

	public void setAttach(String attach) {
		this.attach = attach;
	}

	public int getTotal_fee() {
		return total_fee;
	}

	public void setTotal_fee(int total_fee) {
		this.total_fee = total_fee;
	}

	public String getSpbill_create_ip() {
		return spbill_create_ip;
	}

	public void setSpbill_create_ip(String spbill_create_ip) {
		this.spbill_create_ip = spbill_create_ip;
	}

	public String getProduct_id() {
		return product_id;
	}

	public void setProduct_id(String product_id) {
		this.product_id = product_id;
	}

	public String getTime_start() {
		return time_start;
	}

	public void setTime_start(String time_start) {
		this.time_start = time_start;
	}

	public String getTime_expire() {
		return time_expire;
	}

	public void setTime_expire(String time_expire) {
		this.time_expire = time_expire;
	}

	public String getOpenid() {
		return openid;
	}

	public void setOpenid(String openid) {
		this.openid = openid;
	}
	
	
	
}
