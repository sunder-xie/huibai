package com.app.controller;

import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.app.common.model.Message;
import com.app.service.BindService;
import com.app.service.GoodsService;
import com.app.service.GoodsTypeService;
import com.app.service.ResourcesService;
import com.app.bean.TblBindInfo;
import com.app.bean.TblGoodsInfo;
import com.app.bean.TblGoodsTypeInfo;
import com.app.bean.TblResourcesInfo;
import com.app.bean.TblUserInfo;
import com.app.common.utils.LTConstant;
import com.app.common.utils.ResCodeConstant;
import com.app.ReqModel.CheckBuyGoodsReqModel;
@Controller
@RequestMapping("Goods")
public class GoodsController {
	
	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private GoodsService goodsServiceImpl;
	
	@Resource
	private ResourcesService resServiceImpl;
	
	@Resource
	private GoodsTypeService gtypeServiceImpl;
	
	@Resource
	private BindService bindServiceImpl;
	
	
	/**
	 * 获取goods内容
	 * */
	@RequestMapping("GetGoodsInfo")
	public @ResponseBody Message GetGoodsInfo(String goodsId){
		Message msg = new Message();
		
		if(goodsId.isEmpty())
		{
			msg.setRspCode("000002").setRspMsg("商品编号为空!");
			return msg;
		}
		
		TblGoodsInfo goodsInfo = new TblGoodsInfo();
		goodsInfo.setGoodsId(goodsId);
		return goodsServiceImpl.getGoodsInfo(goodsInfo);
	}
	
	/**
	 * 获取goods内容
	 * */
	@RequestMapping("GetGoodsPicInfo")
	public @ResponseBody Message GetGoodsPicInfo(HttpServletRequest request){
		Message msg = new Message();
		//获取请求参数
		Map<String,String> params = LTConstant.getParameters(request);
		if(params == null){
			msg.setRspCode("000002").setRspMsg("参数为空!");
			return msg;
		}
		TblResourcesInfo resInfo = new TblResourcesInfo();
		resInfo.setKeyid(params.get("goodsId"));
		return resServiceImpl.getGoodsPicInfo(resInfo);
	}
	
	/**
	 * 获取goods内容
	 * */
	@RequestMapping("GetGoodsTypeInfo")
	public @ResponseBody Message GetGoodsTypeInfo(HttpServletRequest request){
		Message msg = new Message();
		//获取请求参数
		Map<String,String> params = LTConstant.getParameters(request);
		if(params == null){
			msg.setRspCode("000002").setRspMsg("参数为空!");
			return msg;
		}
		TblGoodsTypeInfo gtypeInfo = new TblGoodsTypeInfo();
		gtypeInfo.setGoodsId(params.get("goodsId"));
		return gtypeServiceImpl.getGoodsTypeInfo(gtypeInfo);
	}
	
	/**
	 * 更新商品状态
	 * */
	@RequestMapping("UpdateGoodsStatus")
	public @ResponseBody Message UpdateGoodsStatus(HttpServletRequest request){
		Message msg = new Message();
		//获取请求参数
		Map<String,String> params = LTConstant.getParameters(request);
		if(params == null){
			msg.setRspCode("000002").setRspMsg("参数为空!");
			return msg;
		}
		return goodsServiceImpl.updateGoodsStatus(params);
	}
	
	/**
	 * 删除商品信息
	 * */
	@RequestMapping("DeleteGoodsInfo")
	public @ResponseBody Message DeleteGoodsInfo(HttpServletRequest request){
		Message msg = new Message();
		//获取请求参数
		Map<String,String> params = LTConstant.getParameters(request);
		if(params == null){
			msg.setRspCode("000002").setRspMsg("参数为空!");
			return msg;
		}
		return goodsServiceImpl.deleteGoodsInfo(params);
	}
	
	
	@RequestMapping("GetGoodsShortInfo")
	public @ResponseBody Message GetGoodsShortInfo(TblGoodsInfo goodsInfo){
		return goodsServiceImpl.getGoodsShortInfo(goodsInfo);
	}
	
	
	@RequestMapping("PublicGoodsCheck")
	public @ResponseBody Message PublicGoodsCheck(HttpServletRequest request){
		
		Message msg = new Message();
		
		//获取请求参数
		Map<String,String> params = LTConstant.getParameters(request);
		if(params == null){
			msg.setRspCode("000002").setRspMsg("参数为空!");
			return msg;
		}
		msg.setRspCode("000000").setRspMsg("校验成功!");
		return msg;
	}
	
	@RequestMapping("PublicGoods")
	public @ResponseBody Message PublicGoods(HttpServletRequest request){
		
		Message msg = new Message();
		
		//获取请求参数
		Map<String,String> params = LTConstant.getParameters(request);
		if(params == null){
			msg.setRspCode("000002").setRspMsg("参数为空!");
			return msg;
		}
		String goodsId = params.get("spuId");
		if(goodsId.equals("")||goodsId.equals(null))
		msg = goodsServiceImpl.addGoodsInfo(params);
		else
		msg = goodsServiceImpl.editGoodsInfo(params);
		
		return msg;
	}
	
	@RequestMapping("CheckBuyGoods")
	public @ResponseBody Message CheckBuyGoods(HttpSession session,CheckBuyGoodsReqModel model){
		
		Message msg = new Message();
		
		if(model.getGoodsId().isEmpty())
		{
			msg.setRspCode("100003");
			msg.setRspMsg("商品编号为空");
			return msg;
		}
		
		if(model.getShopId().isEmpty())
		{
			msg.setRspCode("100003");
			msg.setRspMsg("店铺编号为空");
			return msg;
		}
		
		if(model.getSkuId().isEmpty())
		{
			msg.setRspCode("100004");
			msg.setRspMsg("商品属性为空");
			return msg;
		}
		
		if(model.getSendChannel().isEmpty())
		{
			msg.setRspCode("100005");
			msg.setRspMsg("渠道为空");
			return msg;
		}
		
		if(model.getBuyNum()<0)
		{
			msg.setRspCode("100005");
			msg.setRspMsg("购买数量小于0");
			return msg;
		}
		
		Object obj=session.getAttribute(LTConstant.userInfo);
		String UserId="";
		if(obj!=null)
		{
			TblUserInfo userinfo =(TblUserInfo)obj;
			UserId=userinfo.getId();
		}
		else{
			msg.setRspCode(ResCodeConstant.MSG_NOT_LOGIN);
			msg.setRspMsg(ResCodeConstant.MSG_NOT_LOGIN_DESC);
			return msg;
		}
		
		/*检查登录账号是否与买家账号一致*/
		TblBindInfo bindInfo = new TblBindInfo();
		bindInfo.setKeyA(UserId);
		bindInfo.setMode("02");
		msg = bindServiceImpl.getBindInfo(bindInfo, UserId);
		if(!msg.getRspCode().equals(ResCodeConstant.MSG_NOT_FOUND)&&
		   !msg.getRspCode().equals(ResCodeConstant.MSG_SUCCESS_CODE)
		   )
		{
			msg.setRspCode("100008");
			msg.setRspMsg("获取商品信息失败！");
			return msg;
		}
		if(UserId.equals(bindInfo.getKeyB()))
		{
			msg.setRspCode("100008");
			msg.setRspMsg("您是商品主人, 不能购买此商品！");
			return msg;
		}
		
		/*检查商品信息*/
		TblGoodsInfo goodsInfo = new TblGoodsInfo();
		goodsInfo.setGoodsId(model.getGoodsId());
		msg= goodsServiceImpl.getGoodsInfo(goodsInfo);
		if(!msg.getRspCode().equals("000000"))
		{
			msg.setRspCode("100008");
			msg.setRspMsg("获取商品信息失败！");
			return msg;
		}
		
		goodsInfo = (TblGoodsInfo)msg.getObjs();
		if(!goodsInfo.getStatus().equals("0"))
		{
			msg.setRspCode("100008");
			msg.setRspMsg("商品已下架！");
			return msg;
		}
		
		if(!goodsInfo.getShopId().equals(model.getShopId()))
		{
			msg.setRspCode("100008");
			msg.setRspMsg("商品信息错误！");
			return msg;
		}
		
		/*检查商品库存*/
		msg= gtypeServiceImpl.getGoodsTypeInfoByTypeId(model.getSkuId());
		if(!msg.getRspCode().equals("000000"))
		{
			msg.setRspCode("100008");
			msg.setRspMsg("获取商品信息失败！");
			return msg;
		}
		TblGoodsTypeInfo  gt = new TblGoodsTypeInfo();
		gt = (TblGoodsTypeInfo)msg.getObjs();
		if(model.getBuyNum()>gt.getStore())
		{
			msg.setRspCode("100008");
			msg.setRspMsg("商品库存不足！");
			return msg;
		}
		
		msg.setRspCode("000000").setRspMsg("校验成功!");
		msg.setObjs("");
		return msg;
	}
	
}
