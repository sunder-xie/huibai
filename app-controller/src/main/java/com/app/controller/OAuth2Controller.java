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
import com.app.bean.TblOauth2UserInfo;
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
 * OAuth2.0模块
 * */
@Controller
@RequestMapping("OAuth2")
public class OAuth2Controller{

	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private WeiXinService WeiXinServiceImpl;
	
	@Resource
	private UserService userServiceImpl;
	
	/**
	 * 第三方登录服务获取授权服务
	 * @param  AuthType(wap与web 处理方式不同) ：1:wap  2:web 
	 * @param  LoginMode ：1:微信 2:支付宝
	 * 
	 * @return ：授权跳转页面url
	 * @throws UnsupportedEncodingException 
	 * */
	@RequestMapping("GetAuthUrl")
	public @ResponseBody Message GetAuthUrl(String AuthType,String LoginMode,String redirect_url) 
	{
		Message msg =new Message();
		
		if(StringUtils.isEmpty(AuthType))
		{
			msg.setRspCode("000003").setRspMsg("授权发起渠道为空！");
			return msg;
		}
		
		if(StringUtils.isEmpty(LoginMode))
		{
			msg.setRspCode("000003").setRspMsg("登录方式参数为空！");
			return msg;
		}
		
		if(StringUtils.isEmpty(redirect_url))
		{
			msg.setRspCode("000003").setRspMsg("重定向url为空！");
			return msg;
		}
		log.info("发起渠道为:[{}],登录模式为：[{}]",AuthType,LoginMode);
		
		String url  = null;
		
		if(AuthType.equals(OAuth2Utils.WapChannel))
		{ 
			if(LoginMode.equals(OAuth2Utils.WeiXinLogin))
			{
				url = WeiXinServiceImpl.get_scope_snsapi_userinfo_url(redirect_url);
				msg.setObjs(url);
			}else
			{
				msg.setRspCode("000003").setRspMsg("当前渠道不支持，请检查！");
				return msg;
			}
		}else if(AuthType.equals(OAuth2Utils.WebChannel))
		{
			msg.setRspCode("000003").setRspMsg("当前渠道不支持，请检查！");
			return msg;
		}else{
			msg.setRspCode("000003").setRspMsg("当前渠道不支持，请检查！");
			return msg;
		}
		return msg;
	}
	
	
	/**
	 * 第三方登录服务授权登录服务
	 * @param  AuthType(wap与web 处理方式不同) ：1:wap  2:web 
	 * @param  LoginMode ：1:微信 2:支付宝
	 * 
	 * @return ：授权跳转页面url
	 * @throws UnsupportedEncodingException 
	 * */
	@RequestMapping("AuthLogin")
	public @ResponseBody Message AuthLogin(String AuthType,String LoginMode,String Code,HttpSession session) 
	{
		Message msg =new Message();
		
		if(StringUtils.isEmpty(AuthType))
		{
			msg.setRspCode("000003").setRspMsg("授权发起渠道为空！");
			return msg;
		}
		
		if(StringUtils.isEmpty(LoginMode))
		{
			msg.setRspCode("000003").setRspMsg("登录方式参数为空！");
			return msg;
		}
		
		if(StringUtils.isEmpty(Code))
		{
			msg.setRspCode("000003").setRspMsg("授权码为空！");
			return msg;
		}
		log.info("发起渠道为:[{}],登录模式为：[{}]",AuthType,LoginMode);
		
		String url  = null;
		
		if(AuthType.equals(OAuth2Utils.WapChannel))
		{ 
			if(LoginMode.equals(OAuth2Utils.WeiXinLogin))
			{
				String tokenStr ;
				String userInfoStr;
				WeiXinAccessToken token = new WeiXinAccessToken();
				tokenStr = WeiXinServiceImpl.getWeiXinAccessToken(Code);
				log.info("返回结果为:"+ tokenStr);
				JSONArray jsonArray = new JSONArray(tokenStr);
				int iSize = jsonArray.length();
				log.info("返回条数为［{}]", iSize);
				for (int i = 0; i < iSize; i++) {
					JSONObject jsonObj = jsonArray.getJSONObject(i);
					if(!jsonObj.has("errcode"))//返回的是boolean类型的
					{
						token.setAccess_token(jsonObj.getString("access_token"));
						token.setExpires_in(jsonObj.getInt("expires_in"));
						token.setOpenid(jsonObj.getString("openid"));
						token.setRefresh_token(jsonObj.getString("refresh_token"));
						token.setScope(jsonObj.getString("scope"));
					}else{
						msg.setRspCode(jsonObj.getInt("errcode")+"").setRspMsg(jsonObj.getString("errmsg"));
						return msg;
					}
				}
				
				userInfoStr = WeiXinServiceImpl.getWeiXinUserInfo(token.getAccess_token(), token.getOpenid());
				log.info("返回结果为:"+ userInfoStr);
				WeiXinUser WeiXinuser = new WeiXinUser();
				JSONArray  userArray = new JSONArray(userInfoStr);
				int iSize2 = userArray.length();
				log.info("返回条数为［{}]", iSize2);
				for (int i = 0; i < iSize; i++) {
					JSONObject jsonObj = userArray.getJSONObject(i);
					if(!jsonObj.has("errcode"))//返回的是boolean类型的
					{
						WeiXinuser.setOpenid(jsonObj.getString("openid"));
						WeiXinuser.setNickname(jsonObj.getString("nickname"));
						WeiXinuser.setSex(jsonObj.getInt("sex")+"");
						WeiXinuser.setProvince(jsonObj.getString("province"));
						WeiXinuser.setCity(jsonObj.getString("city"));
						WeiXinuser.setCountry(jsonObj.getString("country"));
						WeiXinuser.setHeadimgurl(jsonObj.getString("headimgurl"));
						//WeiXinuser.setPrivilege(jsonObj.getString("privilege"));
						//WeiXinuser.setUnionid(jsonObj.getString("unionid"));
					}else{
						msg.setRspCode(jsonObj.getInt("errcode")+"").setRspMsg(jsonObj.getString("errmsg"));
						return msg;
					}
				}
				TblUserInfo userInfo =new TblUserInfo();
				TblOauth2UserInfo oauth2user = new TblOauth2UserInfo();
				int random1 = (int) (Math.random()*9000+1000);
				userInfo.setUsername(WeiXinuser.getOpenid().substring(1, 10)+random1);
				userInfo.setPassword("1qaz2wsx");
				
				userInfo.setNickName(WeiXinuser.getNickname());
				userInfo.setPortrait(WeiXinuser.getHeadimgurl());
				
				oauth2user.setOpenid(WeiXinuser.getOpenid());
				oauth2user.setAccessToken(token.getAccess_token());
				oauth2user.setExpires(token.getExpires_in());
				oauth2user.setPlatform(AuthType);
				oauth2user.setChannel(LoginMode);
				oauth2user.setHeadimgurl(WeiXinuser.getHeadimgurl());
				
				msg =  userServiceImpl.saveOAuth2User(userInfo,oauth2user,session);
				
				
				msg.setObjs(userInfo);
			}else
			{
				msg.setRspCode("000003").setRspMsg("当前渠道不支持，请检查！");
				return msg;
			}
		}else if(AuthType.equals(OAuth2Utils.WebChannel))
		{
			msg.setRspCode("000003").setRspMsg("当前渠道不支持，请检查！");
			return msg;
		}else{
			msg.setRspCode("000003").setRspMsg("当前渠道不支持，请检查！");
			return msg;
		}
		
		return msg;
	}
	
	/**
     * 
     * @param type 0-测试, 1-正式, 2-跳转获取CODE,3:认证过的测试号
     * @param menuType
     * @param request
     * @param wechatUserId
     * @param response
     * @return
	 * @throws UnsupportedEncodingException 
     */
    @RequestMapping("view")
    public ModelAndView view(Integer type,Integer menuType, Integer wechatUserId, String redirect,HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException 
    {
        Cookie cookie = CookieUtil.getCookieByName(request, "wechatUserId");
        log.info("type:" + type + ",menuType:" + menuType + ",wechatUserId:" + wechatUserId + ",redirect:" + redirect);

        String url  = null;
        UUID uuid =new UUID();
        if(cookie == null)
        {
            log.info("Cookie已过期.....");
            if(type == 0)
            {
                CookieUtil.addCookie(response, "wechatUserId", uuid.getUUID()+"", 60 * 10);       /* 测试环境 */
                url = "view?format=json&type=0&menuType=" + menuType + "&redirect=" + redirect;
                log.info("url:" + url);
                return new ModelAndView(new RedirectView(url));
            }
            else if(type == 1)
            {
                CookieUtil.addCookie(response, "wechatUserId", wechatUserId+"", (60 * 60 * 10)); 
                /* 生产环境 */
                url = "view?format=json&type=1&menuType=" + menuType  + "&redirect=" + redirect;
                log.info("url:" + url);
                return new ModelAndView(new RedirectView(url));
            }
            else if(type == 2)
            {
                String wechatRedirece = UrlUtil.encode(WeiXinUtils.redirect_uri + "/pages/wechat/user/auth?format=json&type=1&menuType=" + menuType + "&redirect=" + redirect);
                /**
                 * 授权的链接 
                 * 注意redirect_uri为重定向地址,/auth在下面的代码中
                 * public String getAUTHORIZE_URL() {
                 * return "https://open.weixin.qq.com/connect/oauth2/authorize?appid="+getAPPID() +"&redirect_uri=";
    				}
                 */ 
                url = WeiXinUtils.scope_url+"?appid="+WeiXinUtils.appID+"&redirect_uri=" + wechatRedirece + "&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect";
                log.info("url:" + url);
                return new ModelAndView(new RedirectView(url));
            }
            else
            {
                return new ModelAndView(new RedirectView(url));
            }
        }
        else
        {
            log.info("Cookie未过期.....");
            if(type == 0)
            {
                switch (menuType) 
                {
//                    case 0:
//                        url = AESCryptoSecurity.decrypt(redirect, wechatConfig.getAPPID());
//                        break;
//                    case 1:
//                        //社区
//                        url = wechatConfig.getHOST_FRONT() + "page/topicList.html";
//                        break;
//                    case 2:
//                        //活动
//                        url = wechatConfig.getHOST_FRONT() + "page/activityList.html";
//                        break;
                }
            }
            else
            {
                    switch (menuType) 
                    {
//                        case 0:
//                            url = AESCryptoSecurity.decrypt(redirect, wechatConfig.getAPPID());
//                            break;
//                        case 1:
//                            //社区
//                            url = wechatConfig.getHOST_FRONT() + "page/topicList.html";
//                            break;
//                        case 2:
//                            //活动
//                            url = wechatConfig.getHOST_FRONT() + "page/activityList.html";
//                            break;
                    }
            }
            return new ModelAndView(new RedirectView(url));
        }
    }
    
    @RequestMapping("/auth")
    public ModelAndView auth(String code, Integer type, Integer menuType, String redirect) throws Exception
    {
        log.info("code:" + code + ",type:" + type + ",menuType:" + menuType);
        /* 向微信发请求获取access_token */
      //  Map<String, String> map = WeiXinServiceImpl.getPageAccessToken(code);
        /* 向微信发请求，用access_token获取用户信息并保存 */
    //    WeiXinUser pageWXUser = WeiXinServiceImpl.getPageWechatUser(map.get("access_token").toString(), map.get("openid").toString());
        String url  = null;
        if(type == 1)
        {
            /* 权限认证完成后，将type改为1或者0,重定向进入上面的方法进行页面跳转 */
          //  url = wechatConfig.getHOST() + "wechat/menu/view?&type=1&menuType=" + menuType + "&wechatUserId=" + pageWXUser.getOpenid() + "&redirect=" + redirect;
       //     url = "wechat/menu/view?&type=1&menuType=" + menuType + "&wechatUserId=" + pageWXUser.getOpenid() + "&redirect=" + redirect;

            log.info("url:" + url);
        }
        return new ModelAndView(new RedirectView(url));
    }
}
