package com.app.controller;

import java.util.List;

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
import com.app.service.GoodsTypeService;
import com.app.bean.TblGoodsTypeInfo;
import com.app.common.utils.LTConstant;

@Controller
@RequestMapping("GoodsType")
public class GoodsTypeController {
	
	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private GoodsTypeService gtypeServiceImpl;
	/**
	 * 获取gtype内容
	 * */
	@RequestMapping("GetGoodsTypeInfo")
	public @ResponseBody Message GetGoodsTypeInfo(TblGoodsTypeInfo gtypeInfo){
		return gtypeServiceImpl.getGoodsTypeInfo(gtypeInfo);
	}
	
}
