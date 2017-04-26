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
import com.hlb.utils.string.StringUtils;
import com.app.service.FloorService;
import com.app.bean.TblFloorInfo;
import com.app.common.utils.LTConstant;

@Controller
@RequestMapping("Floor")
public class FloorController {
	
	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private FloorService floorServiceImpl;
	/**
	 * 获取floor内容
	 * */
	@RequestMapping("GetFloorInfo")
	public @ResponseBody Message GetFloorInfo(HttpSession session,HttpServletRequest request,HttpServletResponse response){
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
		TblFloorInfo floorInfo =new TblFloorInfo();
		floorInfo.setFType(Type);
		return floorServiceImpl.getFloorInfo(floorInfo);
	}
	
	/**
	 * 获取floor内容
	 * */
	@RequestMapping("GetAllFloorInfo")
	public @ResponseBody Message GetAllFloorInfo(HttpSession session,HttpServletRequest request,HttpServletResponse response){
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
//		TblFloorInfo floorInfo =new TblFloorInfo();
//		floorInfo.setFType(Type);
//		msg=floorServiceImpl.getFloorInfo(floorInfo);
//		if(msg.getRspCode().equals("000000"))
//		{
//			List floorList;
//			Object obj = msg.getObjs();
//			if(obj instanceof List){
//				floorList = (List)obj;
//				for(Object object : floorList){
//					
//				}
//			}
//		}
		return floorServiceImpl.getAllFloorInfo(Type);
	}
	
}
