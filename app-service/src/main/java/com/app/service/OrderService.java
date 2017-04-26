package com.app.service;
import java.util.Map;

import com.app.common.model.Message;
import com.app.common.model.Pager;
import com.app.ReqModel.BuyCarOrder;
import com.app.ReqModel.BuyOrderReqModel;
import com.app.bean.TblOrderInfo;
import com.app.bean.TblUserInfo;

public interface OrderService {
	/**
	 * 获取订单内容
	 * */
	public Pager getUserOrderListInfo(Pager pages,String userId);
	
	
	/**
	 * 获取订单内容
	 * */
	public Pager getUserOrderList(Pager pages,String userId);
	
	/**
	 * 获取订单内容
	 * */
	public Pager getMerOrderListInfo(Pager pages);
	
	/**
	 * 获取订单内容
	 * */
	public Message getOrderInfoByOrderId(TblOrderInfo orderInfo);
	
	/**
	 * 获取订单内容
	 * */
	public Message saveOrderInfo(Map <String ,String> params);
	
	
	/**
	 * 更新店铺信息
	 * */
	public Message updateOrderInfo(TblOrderInfo orderInfo,String uid);
	
	public void updateOrderInfoBySetTime();

	public Message getOrderGoodsByOrderId(Map<String, String> params);


	public Message saveOrderInfoByCar(BuyCarOrder model, String userId);


	public Message getOrderPayInfo(String orderId, String userId);


	public Message saveNewOrder(BuyOrderReqModel model, String userId);


	public Message getOrderGoodsShortInfoByOrderId(String orderId);


	public Message delOrderInfo(String orderId);
	
}
