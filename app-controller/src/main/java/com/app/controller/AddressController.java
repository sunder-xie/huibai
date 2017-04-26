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
import com.app.common.model.Pager;
import com.app.service.AddressService;
import com.app.bean.TblAddressInfo;
import com.app.bean.TblUserInfo;
import com.app.common.utils.LTConstant;
import com.app.common.utils.ResCodeConstant;

@Controller
@RequestMapping("Address")
public class AddressController {
	
	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private AddressService addrServiceImpl;
	/**
	 * 获取addr内容
	 * */
	@RequestMapping("GetAddressInfo")
	public @ResponseBody Pager GetAddressInfo(Pager pages,HttpSession session,HttpServletResponse response){
		Object obj=session.getAttribute(LTConstant.userInfo);
		String uid="";
		if(obj!=null)
		{
			TblUserInfo userinfo =(TblUserInfo)obj;
		    uid=userinfo.getId();
		}
		return addrServiceImpl.getAddressInfo(pages,uid);
	}
	
	@RequestMapping("GetAddressInfoByAddrId")
	public @ResponseBody Message GetAddressInfoByAddrId(String addrId,HttpSession session,HttpServletResponse response){
		
		Message msg = new Message();
		Object obj=session.getAttribute(LTConstant.userInfo);
		String uid="";
		if(obj!=null)
		{
			TblUserInfo userinfo =(TblUserInfo)obj;
		    uid=userinfo.getId();
		}else{
			msg.setRspCode(ResCodeConstant.MSG_NOT_LOGIN);
			msg.setRspMsg(ResCodeConstant.MSG_NOT_LOGIN_DESC);
			return msg;
		}
		TblAddressInfo addrInfo = new TblAddressInfo();
		addrInfo.setAddrId(addrId);
		addrInfo.setUserId(uid);
		msg = addrServiceImpl.getAddressInfoByAddrId(addrInfo,uid);
		return msg;
	}
	
	/**
	 * 添加收货地址信息
	 * */
	@RequestMapping("AddressAdd")
	public @ResponseBody Message AddressAdd(TblAddressInfo addrInfo,HttpSession session,HttpServletResponse response){
//		TblAddressInfo addrInfo=new TblAddressInfo();
//		addrInfo.setAddressNm(request.getAttribute(name));
		Object obj=session.getAttribute(LTConstant.userInfo);
		String uid="";
		if(obj!=null)
		{
			TblUserInfo userinfo =(TblUserInfo)obj;
		    uid=userinfo.getId();
		}
		return addrServiceImpl.saveAddressInfo(addrInfo,uid);
	}
	
	/**
	 * 更新收货地址信息
	 * */
	@RequestMapping("UpdateAddressInfo")
	public @ResponseBody Message UpdateAddressInfo(TblAddressInfo addrInfo,HttpSession session,HttpServletResponse response){
		Object obj=session.getAttribute(LTConstant.userInfo);
		String uid="";
		if(obj!=null)
		{
			TblUserInfo userinfo =(TblUserInfo)obj;
		    uid=userinfo.getId();
		}
		return addrServiceImpl.updateAddressInfo(addrInfo,uid);
	}
	
	/**
	 * 删除收货地址信息
	 * */
	@RequestMapping("AddressDel")
	public @ResponseBody Message AddressDel(TblAddressInfo addrInfo,HttpSession session,HttpServletResponse response){
		Object obj=session.getAttribute(LTConstant.userInfo);
		String uid="";
		if(obj!=null)
		{
			TblUserInfo userinfo =(TblUserInfo)obj;
		    uid=userinfo.getId();
		}
		return addrServiceImpl.deleteAddressInfo(addrInfo,uid);
	}
	
	/**
	 * 设置默认收货地址
	 * */
	@RequestMapping("AddressSetDefault")
	public @ResponseBody Message AddressSetDefault(TblAddressInfo addrInfo,HttpSession session,HttpServletResponse response){
		Object obj=session.getAttribute(LTConstant.userInfo);
		String uid="";
		if(obj!=null)
		{
			TblUserInfo userinfo =(TblUserInfo)obj;
		    uid=userinfo.getId();
		}
		return addrServiceImpl.setDefaultAddr(addrInfo,uid);
	}
	
	/**
	 * 设置默认收货地址
	 * */
	@RequestMapping("GetDefaultAddr")
	public @ResponseBody Message GetDefaultAddr(HttpSession session){
		
		Message msg = new Message();
		Object obj=session.getAttribute(LTConstant.userInfo);
		String uid="";
		if(obj!=null)
		{
			TblUserInfo userinfo =(TblUserInfo)obj;
		    uid=userinfo.getId();
		}else{
			msg.setRspCode(ResCodeConstant.MSG_NOT_LOGIN);
			msg.setRspMsg(ResCodeConstant.MSG_NOT_LOGIN_DESC);
			return msg;
		}
		TblAddressInfo addrInfo = new TblAddressInfo();
		addrInfo.setIsMain("Y");
		msg = addrServiceImpl.getDefaultAddr(addrInfo,uid);
		return msg;
	}
}
