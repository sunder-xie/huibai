package com.app.common.utils;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import com.app.bean.TblUserInfo;

/**
 * 全局变量
 * */
public class LTConstant {
	public static final String MSG_SUCCESS_CODE ="0000";
	public static final String MSG_SUCCESS_DESC ="交易成功";
	
	public static final String MENU_TYPE_NAV="NA";
	public static final String valid_data = "1";
	public static final String invalid_data = "0";
	
	
	/*发起渠道*/
	public static final String WAP_SND = "1";
	public static final String WEB_SND= "2";
	public static final String APP_SND = "3";
	
	/*支付渠道*/
	public static final String WEIXIN_PAY="01";
	public static final String ALIPAY = "02";
	
	/*支付状态*/
	public static final String PAY_ING = "01";
	public static final String PAY_SUCCESS= "02";
	public static final String PAY_FAIL = "03";
	
	/*订单状态
	 * 01:待付款
		02:已付款
		03:待收货
		04:交易完成
		05:交易关闭
		99:删除状态
	*/
	public static final String ORDER_ALL = "99";
	public static final String ORDER_WAIT_PAY = "01";
	public static final String ORDER_PAY_END= "02";
	public static final String ORDER_WAIT_RECV = "03";
	public static final String ORDER_END = "04";
	public static final String ORDER_CLOSE = "05";
	
	public static final String ORDER_BUYER_DEL = "1";
	public static final String ORDER_SALER_DEL = "2";
	
	
	public static final String userInfo ="user_info";
	public static final String loginKey ="loginKey";
	public static final String Success = "000000";
	/*返回码*/
	public static final String UserNotLogin= "000010";
	
	public static final String CHARSET_UTF_8 ="UTF-8";
	public static final String CHARSET_ISO8859_1 ="ISO8859-1";
	
	public static final String TestFlag ="0";
	
	public static final String TEST_FILES_PATH ="/Users/haibo/upload/files";
	
	public static final String TEST_IMAGES_PATH ="/Users/haibo/upload/images";
	
	public static final String TEST_FILES_URL ="http://localhost:8080/upload/files";
	
	public static final String TEST_IMAGES_URL ="http://localhost:8080/upload/images";
	
	public static final String FILES_PATH ="/alidata/upload/files";
	
	public static final String IMAGES_PATH ="/alidata/upload/images";
	
	public static final String FILES_URL ="http://files.hbaicai.com/upload/files";
	
	public static final String IMAGES_URL ="http://images.hbaicai.com/upload/images";
	
	public static final Map<String,TblUserInfo>  userInfos =  new HashMap<String, TblUserInfo>();
	
	/*获取request请求的参数，返回Map*/
	public static Map<String,String> getParameters(HttpServletRequest request){
		try{
			//(1)获取encoding编码方式
			String encoding = request.getParameter("encoding");
			if(encoding == null){
				encoding = CHARSET_UTF_8;
			}
			
			Map<String,String[]> param = request.getParameterMap();
			Map<String,String> params = new HashMap<String, String>();
			Set<String> keys = param.keySet();
			for(String key:keys){
				String value = request.getParameter(key);
				value = new String(value.getBytes(CHARSET_UTF_8),encoding);
				params.put(key, value);
			}
			return params;
		}catch(Exception e){//如果商户在一个域中传递多次，将会转化错误，因此需抛出异常，参数异常
			return null;
		}
	}
}
