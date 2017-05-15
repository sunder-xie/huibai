package com.app.SMS.service;

import com.app.SMS.model.CheckSmsValidModel;
import com.app.bean.TblSmsInfo;
import com.app.common.model.Message;

public interface SmsDealService {

	public Message saveSendSms(TblSmsInfo sms);

	public Message checkSmsVaild(CheckSmsValidModel sms);
}
