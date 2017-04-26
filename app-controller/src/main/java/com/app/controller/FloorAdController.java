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
import com.app.common.model.Pager;
import com.hlb.utils.string.StringUtils;
import com.app.service.FloorAdService;
import com.app.bean.TblFloorAdInfo;
import com.app.common.utils.LTConstant;

@Controller
@RequestMapping("FloorAd")
public class FloorAdController {
	
	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private FloorAdService flooradServiceImpl;
	/**
	 * 获取floorad内容
	 * */
	@RequestMapping("GetFloorAdInfo")
	public @ResponseBody Message GetFloorAdInfo(HttpSession session,HttpServletRequest request,HttpServletResponse response){
		Message msg = new Message();
		//获取请求参数
		Map<String,String> params = LTConstant.getParameters(request);
		if(params == null){
			msg.setRspCode("000002");
			msg.setRspMsg("参数为空!");
			return msg;
		}
		String Type = params.get("type");
		if(StringUtils.isEmpty(Type))
		{
			msg.setRspCode("000002");
			msg.setRspMsg("参数为空!");
			return msg;
		}
		String FId = params.get("fid");
		if(StringUtils.isEmpty(FId))
		{
			msg.setRspCode("000002");
			msg.setRspMsg("参数为空!");
			return msg;
		}
		
		TblFloorAdInfo fadInfo = new TblFloorAdInfo();
		fadInfo.setFType(Type);
		fadInfo.setFId(FId);
		return flooradServiceImpl.getFloorAdInfo(fadInfo);
	}
	
}
