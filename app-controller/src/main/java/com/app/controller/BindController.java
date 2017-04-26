package com.app.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.app.common.model.Message;
import com.app.common.model.Pager;
import com.app.service.BindService;
import com.app.bean.TblBindInfo;
import com.app.bean.TblUserInfo;
import com.app.common.utils.LTConstant;

@Controller
@RequestMapping("Bind")
public class BindController {
	
	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private BindService bindServiceImpl;
	/**
	 * 获取bind内容
	 * */
	@RequestMapping("GetBindInfo")
	public @ResponseBody Message GetBindInfo(TblBindInfo bindInfo,HttpSession session,HttpServletResponse response){
		Object obj=session.getAttribute(LTConstant.userInfo);
		String uid="";
		if(obj!=null)
		{
			TblUserInfo userinfo =(TblUserInfo)obj;
		    uid=userinfo.getId();
		}
		return bindServiceImpl.getBindInfo(bindInfo,uid);
	}
	
}
