package com.app.OAuth2.WeiXin.service;

public interface WeiXinService {

	
	public String get_scope_snsapi_base_url();
	
	public String get_scope_snsapi_userinfo_url(String redirect_url);
	

	public String getWeiXinAccessToken(String code);

	public String getWeiXinUserInfo(String access_token, String openid);
}
