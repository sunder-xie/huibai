package com.hlb.utils.Url;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

public class UrlUtil {
	
	/**
	 * 
	 * @throws UnsupportedEncodingException 
	 */
	public static String encode(String url) throws UnsupportedEncodingException{
		
		String output = URLEncoder.encode(url, "UTF-8");
		return output;
	   
	}
	
	
	/**
	 * \
	 * @throws UnsupportedEncodingException 
	 */
	public static String decode(String url) throws UnsupportedEncodingException{
		
		String output = URLDecoder.decode(url, "UTF-8");
		
		return output;
	   
	}

}
