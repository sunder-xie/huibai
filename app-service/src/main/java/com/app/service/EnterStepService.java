package com.app.service;
import java.util.Map;

import com.app.common.model.Message;

public interface EnterStepService {
	/**
	 * 获取公告内容
	 * */
	public Message getEnterStepInfo(Map<String, String> params);

	public Message saveEnterStepInfo(Map<String, String> params);
	
}
