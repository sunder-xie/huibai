package com.app.controller;

import java.net.URLDecoder;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.app.common.model.Pager;
import com.app.service.GoodsService;
import com.app.service.SearchService;
import com.hlb.utils.json.JsonUtil;
import com.app.common.utils.LTConstant;

@Controller
@RequestMapping("Search")
public class SearchController {
	
	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private SearchService SearchServiceImpl;
	
	@Resource
	private GoodsService GoodsServiceImpl;
	
	/**
	 * 根据keywork获取商品信息列表
	 * */
	@RequestMapping("serGoodsShortInfListByKeyword")
	public @ResponseBody Pager serGoodsShortInfListByKeyword(Pager keyword){
		
		return GoodsServiceImpl.getGoodsShortInfoList(keyword);
	}
	
	/**
	 * 根据keywork获取商品信息列表
	 * */
	@RequestMapping("SearchList")
	public @ResponseBody  ModelAndView SearchList(HttpServletRequest req,HttpServletRequest rsp){
		
		Pager page = new Pager();
		//获取请求参数
		Map<String,String> params = LTConstant.getParameters(req);
		if(params == null){
		}
		page.setStart(1);
		page.setOffset(10);
		page.setConditions(params);
		Pager a = GoodsServiceImpl.getGoodsShortInfoList(page);
		
		ModelAndView mv = new ModelAndView("search/prodlist");  
		
		String result =JsonUtil.Object2Json(a);
        mv.addObject("pager", result); 
        return mv;  
//		rsp.setAttribute("pager", a);
//		return new ModelAndView("search/prodlist") ;
	}
	
	/**
	 * 根据keywork获取商家信息
	 * */
	@RequestMapping("getSerMerInfByKeyword")
	public @ResponseBody Pager getSerMerInfByKeyword(Pager keyword){
		
		return SearchServiceImpl.getMerInf(keyword);
	}
	
}
