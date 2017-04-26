package com.hlb.utils.json;

import net.sf.json.JSONObject;

public class JsonUtil {
	
	public JsonUtil() {  
        // TODO Auto-generated constructor stub  
    }  
	
	public static String Object2Json(Object obj){  
        JSONObject json = JSONObject.fromObject(obj);//将java对象转换为json对象  
        String str = json.toString();//将json对象转换为字符串  
          
        return str;  
    }  

}
