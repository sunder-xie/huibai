package com.app.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.app.common.model.Message;
import com.app.service.ActivityService;
import com.app.bean.TblActivityInfo;
import com.app.common.utils.LTConstant;
import com.hlb.utils.string.StringUtils;

@Controller
@RequestMapping("Activity")
public class ActivityController {
	
	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private ActivityService activityServiceImpl;
	/**
	 * 获取activity内容
	 * */
	@RequestMapping("GetActivityInfo")
	public @ResponseBody Message GetActivityInfo(HttpSession session,HttpServletRequest request,HttpServletResponse response){
		
		Message msg = new Message();
		//获取请求参数
		Map<String,String> params = LTConstant.getParameters(request);
		if(params == null){
			msg.setRspCode("000002");
			msg.setRspMsg("参数为空!");
			return msg;
		}
		String actType = params.get("actType");
		if(StringUtils.isEmpty(actType))
		{
			msg.setRspCode("000002");
			msg.setRspMsg("参数为空!");
			return msg;
		}
		TblActivityInfo activityInfo = new TblActivityInfo();
		activityInfo.setActType(actType);
		return activityServiceImpl.getActivityInfo(activityInfo);
	}
	
}
