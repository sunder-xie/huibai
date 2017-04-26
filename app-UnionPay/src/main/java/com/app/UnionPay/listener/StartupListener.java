package com.app.UnionPay.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.app.UnionPay.utils.PayConstants;

import freemarker.template.Configuration;
import freemarker.template.Version;


/**
 * <p>StartupListener class used to initialize and database settings
 * and populate any application-wide drop-downs.
 * 
 * <p>Keep in mind that this listener is executed outside of OpenSessionInViewFilter,
 * so if you're using Hibernate you'll have to explicitly initialize all loaded data at the 
 * Dao or service level to avoid LazyInitializationException. Hibernate.initialize() works
 * well for doing this.
 *
 * @author NT
 */
public class StartupListener extends ContextLoaderListener
    implements ServletContextListener {
    
    private static final Logger log = LoggerFactory.getLogger(StartupListener.class);

    public void contextInitialized(ServletContextEvent event) {
        super.contextInitialized(event);
        ServletContext context = event.getServletContext();
        ApplicationContext ctx =
            WebApplicationContextUtils.getRequiredWebApplicationContext(context);
        log.debug("开始进行spring 容器的加载");
        setupContext(ctx);
    }

    public static void setupContext(ApplicationContext ctx) {
    	log.info("开始加载交易模板信息");
    	try{
    		/*模板定义*/
    		Configuration cfg =  new Configuration(new Version("2.3.23"));
    		cfg.setClassLoaderForTemplateLoading(StartupListener.class.getClassLoader(), "config/trans");
    		PayConstants.freemarkerTemplate = cfg;
    	}catch(Exception e){
    		log.error("加载交易模板信息失败！！",e);
    	}
    	log.info("模板信息加载完毕");
    }
}
