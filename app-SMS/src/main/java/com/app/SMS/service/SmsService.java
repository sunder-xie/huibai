package com.app.SMS.service;

import com.app.common.model.Message;

public interface SmsService {

	public Message send_reg_user_code(String telphone, String smscode);
}
