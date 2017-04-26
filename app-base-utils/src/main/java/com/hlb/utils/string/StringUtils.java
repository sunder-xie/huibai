package com.hlb.utils.string;

import java.lang.reflect.Field;

public class StringUtils {
	
	/**
	 * 判断一个字符串是否为 空 ""/null
	 * @param str 判断的字符串
	 * @return boolean
	 * */
	public static boolean isEmpty(String str){
		if(str == null || "".equals(str.trim())){
			return true;
		}
		return false;
	}
	
	/**
	 * 获取一个被trim的值
	 * */
	public static String getVal(Object obj){
		if(obj==null || isEmpty(obj.toString())){
			return "";
		}else{
			return obj.toString().trim();
		}
	}
	
	/**
     * 判断一个对象里面的所有的值是否为空
     * @param o 要判断数据对象
     * @return true/false
     * @throws IllegalAccessException
     */
    @SuppressWarnings("rawtypes")
	public static String checkObjectIsEmpty(Object o) throws IllegalAccessException {
        Class cls = o.getClass();
        String empty="";
        Field[] fields = cls.getDeclaredFields();
        for (Field f : fields) {
            f.setAccessible(true);
            if (f.get(o) == null || f.get(o) == "") {
            	empty= f.getName();
            	return empty;
            }
        }
        return null;
    }
	
	
}
