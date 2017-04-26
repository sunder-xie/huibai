package com.app.OAuth2.WeiXin.Utils;

public class WeiXinUtils {
	public static final String scope_url = "https://open.weixin.qq.com/connect/oauth2/authorize";
	
	//微信分配的公众号ID（开通公众号之后可以获取到）
	public static final String appID = "wx27188ab67282ea8e";
	
	private static String AppSecret = "8b6b11738cbf5a5b6359db1b15d0d0f7";
	
	//授权后重定向的回调链接地址，请使用urlEncode对链接进行处理
	public static final String redirect_uri = "http://pay.hbaicai.com";
		
	//返回类型，请填写code
	public static final String response_type = "code";
	
	//应用授权作用域，snsapi_base （不弹出授权页面，直接跳转，只能获取用户openid），
	//snsapi_userinfo （弹出授权页面，可通过openid拿到昵称、性别、所在地。并且，即使在未关注的情况下，只要用户授权，也能获取其信息）
	public static final String scope = "code";
		
	//重定向后会带上state参数，开发者可以填写a-zA-Z0-9的参数值，最多128字节
	public static final String state = "STATE#wechat_redirect";
		
	//无论直接打开还是做页面302重定向时候，必须带此参数
	//public static final String wechat_redirect = "#wechat_redirect";
	
	public static final String access_token_url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid="+appID+"&secret="+AppSecret;
	
	//填写为authorization_code 
	public static final String grant_type = "authorization_code";
	
	
	public static final String request_user_url = "https://api.weixin.qq.com/sns/userinfo?";
}
