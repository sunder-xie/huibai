package com.app.controller;

import java.io.UnsupportedEncodingException;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javax.servlet.http.Cookie;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.app.OAuth2.Utils.OAuth2Utils;
import com.app.OAuth2.WeiXin.Utils.WeiXinUtils;
import com.app.OAuth2.WeiXin.model.WeiXinAccessToken;
import com.app.OAuth2.WeiXin.model.WeiXinUser;
import com.app.OAuth2.WeiXin.service.WeiXinService;
import com.app.ReqModel.SmsRegUserReq;
import com.app.SMS.service.SmsDealService;
import com.app.SMS.service.SmsService;
import com.app.bean.TblOauth2UserInfo;
import com.app.bean.TblSmsInfo;
import com.app.bean.TblUserInfo;
import com.app.common.Cookie.CookieUtil;
import com.app.common.exception.DBException;
import com.app.common.model.Message;
import com.app.common.utils.LTConstant;
import com.app.service.UserService;
import com.hlb.utils.Url.UrlUtil;
import com.hlb.utils.security.UUID;
import com.hlb.utils.string.StringUtils;
/**
 * 短信接口模块
 * */
@Controller
@RequestMapping("Sms")
public class SmsController{

	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private SmsService smsServiceImpl;
	
	@Resource
	private SmsDealService smsdealServiceImpl;
	
	/**
	 * 注册用户发送短信接口
	 * */
	@RequestMapping("SendRegSms")
	public @ResponseBody Message SendRegSms(SmsRegUserReq smsReg) 
	{
		Message msg =new Message();
		Message msg1 =new Message();
		if(StringUtils.isEmpty(smsReg.getUsername()))
		{
			msg.setRspCode("000003").setRspMsg("用户名为空！");
			return msg;
		}
		
		if(StringUtils.isEmpty(smsReg.getTelphone()))
		{
			msg.setRspCode("000003").setRspMsg("电话号码为空！");
			return msg;
		}
		
		log.info("用户名为:[{}],电话号码为：[{}]",smsReg.getUsername(),smsReg.getTelphone());
		
		/*开始记录数据库*/
		TblSmsInfo sms = new TblSmsInfo();
		
		int random1 = (int) (Math.random()*9000+1000);
		int SeqNo = random1+100000;
		if(SeqNo>999999)
		{
			SeqNo=365487;
		}
		String smscode = SeqNo+"";
		sms.setSmsCode(smscode);
		sms.setSmsType("01");
		sms.setTelphone(smsReg.getTelphone());
		sms.setErrNum(0);
		sms.setExpires(300);
		msg = smsdealServiceImpl.saveSendSms(sms);
		
		if(!msg.getRspCode().equals("000000"))
		{
			return msg;
		}
		
		msg = smsServiceImpl.send_reg_user_code(smsReg.getTelphone(),smscode);
		if(!msg.getRspCode().equals("000000"))
		{
			return msg;
		}
		msg.setObjs(sms.getSmsId());
		return msg;
	}
	
}
