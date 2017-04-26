package com.app.OAuth2.WeiXin.service.impl;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.app.OAuth2.WeiXin.Utils.WeiXinUtils;
import com.app.OAuth2.WeiXin.model.WeiXinUser;
import com.app.OAuth2.WeiXin.service.*;
import com.hlb.utils.Url.UrlUtil;
import com.hlb.utils.urlConnection.HttpUrlClient;
import com.hlb.utils.urlConnection.HttpUrlResponse;

@Service
public class WeiXinServiceImpl implements WeiXinService{
	
	private Logger log = LoggerFactory.getLogger(this.getClass());


	@Override
	public String get_scope_snsapi_base_url() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String get_scope_snsapi_userinfo_url(String redirect_url) {

		
		String url ="";
		String wechatRedirece;
		try {
			wechatRedirece = UrlUtil.encode(redirect_url);
	        url = WeiXinUtils.scope_url+"?appid="+WeiXinUtils.appID+"&redirect_uri=" + wechatRedirece + "&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect";
	        log.info("url:" + url);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
       
        
		return url;
	}
	
	
	@Override
	public String getWeiXinAccessToken(String code) {
		
		String RspStr;
		String url = WeiXinUtils.access_token_url;
		
		url +="&code="+code+"&grant_type="+WeiXinUtils.grant_type;
		
		log.info("getWeiXinAccessToken 发送url为:["+url+"]");
		
		HttpUrlResponse rsp = HttpUrlClient.sendData(url,"UTF-8",url);
		
		log.info("收到报文内容为:["+rsp.getHtmlContent()+"]");
		
		RspStr = "["+rsp.getHtmlContent()+"]";
		
		return RspStr;
	}
	
	@Override
	public String getWeiXinUserInfo(String access_token, String openid) {
		
		String RspStr;
		String url = WeiXinUtils.request_user_url;
		WeiXinUser user = new WeiXinUser();
		Map<String , String> map = new HashMap<String , String>();
		map.put("access_token", access_token);
		map.put("openid",openid);
		map.put("lang","zh_CN");
		HttpUrlResponse rsp = HttpUrlClient.send(url,"POST","UTF-8",map);
		
		log.info("收到报文内容为:["+rsp.getHtmlContent()+"]");
		
		RspStr = "["+rsp.getHtmlContent()+"]";
		
		return RspStr;
	}

}
