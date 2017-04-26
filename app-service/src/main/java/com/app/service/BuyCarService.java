package com.app.service;
import com.app.common.model.Message;
import com.app.common.model.Pager;
import com.app.ReqModel.BuyCarOpertionModel;
import com.app.ReqModel.CarIdListModel;
import com.app.ReqModel.ChangeBuyCarNum;

public interface BuyCarService {
	/**
	 * 获取订单内容
	 * */
	public Pager getBuyCarList(Pager pages,String userId);
	
	/**
	 * 获取订单内容
	 * */
	public Message saveBuyCarInfo(BuyCarOpertionModel model, String userId);
	
	/**
	 * 获取订单内容
	 * @param userId 
	 * */
	public Message delBuyCarInfo(BuyCarOpertionModel model, String userId);


	public Message changeBuyCarNum(ChangeBuyCarNum model, String userId);

	public Message getBuyCarListByCarId(CarIdListModel model);
	
}
