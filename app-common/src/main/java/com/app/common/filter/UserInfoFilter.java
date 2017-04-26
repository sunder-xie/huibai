package com.app.common.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.app.common.utils.LTConstant;

/**
 * Servlet Filter implementation class UserInfoFilter
 */
public class UserInfoFilter implements Filter {

	private Logger log = LoggerFactory.getLogger(this.getClass());
	private String redirectURL = "";  
    private List<String> notCheckURLList = null;
    /**
     * Default constructor. 
     */
    public UserInfoFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		 this.notCheckURLList.clear();  
		// TODO Auto-generated method stub
	}

//	/**
//	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
//	 */
//	public void doFilter(ServletRequest arg0, ServletResponse response, FilterChain chain) throws IOException, ServletException {
//		
//		HttpServletRequest request = (HttpServletRequest) arg0;
//		Cookie[] cokies = request.getCookies();
//		
//		if(cokies == null){
//			chain.doFilter(request, response);
//		}
//		
//		String encoderStr = "";
//		
//		for(int i=0;i<cokies.length;i++){
//			Cookie cookie = cokies[i];
//			if (cookie.getName().equals(LTConstant.userInfo)) {
//				encoderStr = cookie.getValue();
//			}
//		}
//		if(!encoderStr.equals("") && LTConstant.userInfos.get(encoderStr)!=null){
//			request.getSession().setAttribute(LTConstant.userInfo, LTConstant.userInfos.get(encoderStr));
//		}
//		chain.doFilter(request, response);
//	}
	
	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		HttpServletRequest req = (HttpServletRequest)request; 
        HttpServletResponse resp=(HttpServletResponse)response;   
        String path = req.getContextPath();  
        String basePath = req.getScheme()+"://"+req.getServerName()+":"+req.getServerPort()+path;  
        
        /** 
         * 判断是否是不需要执行过滤的页面，如果是则直接放行 
         */  
        String requestURI = req.getRequestURI();  
        for(String url : this.notCheckURLList){  
            if(requestURI.indexOf(url) != -1) {  
            	chain.doFilter(req, resp);
                return;  
            }  
        }  
        
      //权限验证
        HttpSession session = req.getSession(true);  
		
        /** 
         * 如果用户未登录，记录目前访问的页面，并跳转到登录页面 
         */  
        if(session == null || session.getAttribute(LTConstant.userInfo) == null) {  
        	log.info("requestURI为［{}]",requestURI);
        	
            if(requestURI.endsWith("jsp"))  
            {
            	Map<String, String[]> map = request.getParameterMap();
            	session.setAttribute("requestURI", requestURI);  
            	session.setAttribute("paraMap", getUrlParamsByMap(map));
            }
                
            resp.sendRedirect(basePath + "/" + redirectURL);  
            return;  
        }   
		/** 
         * loginKey为用户登录成功后写到session中的，在这里通过获取loginKey判断是否登录成功 
         * 如果登录成功，则跳转到登录前浏览的页面，如果登录前是从login.jsp过来的，则不跳转 
         */  
        Object loginKey = session.getAttribute(LTConstant.loginKey);  
        if(loginKey != null )
        	if(loginKey.toString().equals("success")) {  
            session.removeAttribute(LTConstant.loginKey);  
            Object uri = session.getAttribute("requestURI");  
            if(uri != null) {  
            	Object  map = session.getAttribute("paraMap");  
            	
            	log.info("uri为［{}]",uri.toString());
            	session.removeAttribute("requestURI"); 
            	session.removeAttribute("paraMap"); 
                resp.sendRedirect(uri.toString()+"?"+map.toString());  
                return;  
            }  
        }  
        
          
        
        chain.doFilter(req, resp);
	
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		//初始化配置的参数  
        redirectURL = fConfig.getInitParameter("redirectURL");  
        String notCheckURLStr = fConfig.getInitParameter("notCheckURLList");  
        if(notCheckURLStr != null) {  
            notCheckURLList = new ArrayList<String>();  
            notCheckURLList.clear();  
            String[] urls = notCheckURLStr.split(",");  
            for (String url : urls) {  
                notCheckURLList.add(url);  
            }  
        }  
	}
	
	/** 
	 * 将map转换成url 
	 * @param map 
	 * @return 
	 */  
	public static String getUrlParamsByMap(Map<String, String[]> map) {  
	    if (map == null) {  
	        return "";  
	    }  
	    StringBuffer sb = new StringBuffer();  
	    for (Map.Entry<String, String[]> entry : map.entrySet()) {  
	    	for (String i : entry.getValue()) 
	    	{
	    		 sb.append(entry.getKey().toString() + "=" + i); 
	    	}
	        sb.append("&");  
	    }  
	    String s = sb.toString();  
	    if (s.endsWith("&")) {  
	        s = s.substring(0, s.length()-1);  
	    }  
	    return s;  
	}  

}
