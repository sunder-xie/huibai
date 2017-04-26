package com.app.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.StringWriter;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.parsers.ParserConfigurationException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.xml.sax.SAXException;

import com.google.zxing.WriterException;
import com.google.zxing.qrcode.QRCodeWriter;
import com.app.common.model.Message;
import com.hlb.utils.date.DateUtil;
import com.hlb.utils.urlConnection.HttpUrlClient;
import com.hlb.utils.urlConnection.HttpUrlResponse;
import com.hlb.utils.zxing.ZXUtil;
import com.app.UnionPay.utils.PayConstants;
import com.app.UnionPay.utils.PayUtil;
import com.app.service.PayDtlService;
import com.app.service.UserService;
import com.app.bean.TblOauth2UserInfo;
import com.app.bean.TblPayDtl;
import com.app.bean.TblUserInfo;
import com.app.ReqModel.SendPayInfo;
import com.app.UnionPay.listener.StartupListener;
import com.app.UnionPay.tencent.model.WxNoticeReslutReq;
import com.app.UnionPay.tencent.model.WxNoticeReslutRsp;
import com.app.UnionPay.tencent.model.WxUnifiedOrder;
import com.app.UnionPay.tencent.model.WxUnifiedOrderRsp;
import com.app.UnionPay.tencent.service.WeiXinPayService;
import com.app.common.utils.LTConstant;
import com.app.common.utils.ResCodeConstant;
import com.app.UnionPay.tencent.common.Configure;
import com.app.UnionPay.tencent.common.Signature;
import com.app.UnionPay.tencent.common.XMLParser;

import freemarker.template.Configuration;
import freemarker.template.TemplateException;
import freemarker.template.Version;

@Controller
@RequestMapping("Pay")
public class PayController {
	
	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Resource
	private PayDtlService paydtlServerImpl;
	
	@Resource
	private WeiXinPayService weixinServerImpl;
	
	@Resource
	private UserService userServerImpl;
	
	/**
	 * GetWeiXinQrcode
	 * @throws TemplateException 
	 * @throws IllegalAccessException 
	 * @throws ParserConfigurationException 
	 * @throws SAXException 
	 * */
	@RequestMapping("GetWeiXinQrcode")
	public @ResponseBody Message GetWeiXinQrcode(HttpSession session,HttpServletRequest request,HttpServletResponse response) throws TemplateException, IllegalAccessException, SAXException, ParserConfigurationException{
		
		Message msg = new Message();
		//获取请求参数
		Map<String,String> params = LTConstant.getParameters(request);
		if(params == null){
			msg.setRspCode("000002").setRspMsg("参数为空!");
			return msg;
		}
		
		log.info("当前订单号为：[{}]",params.get("orderId"));
		
		/*检查订单状态*/
		try{
			String orderId = params.get("orderId");
			String instDt = DateUtil.getCurrentDate(DateUtil.DATE_FORMAT_14);
			TblPayDtl paydt = new TblPayDtl();
			paydt.setOrderId(orderId);
			paydt.setPayChannle("01");
			msg = paydtlServerImpl.checkStaPayDtl(paydt);
			if(!msg.getRspCode().equals("000000"))/*该笔订单已经支付*/
			{
				log.info("当前订单号为：[{}],已支付或者数据库异常",params.get("orderId"));
				return msg;
			}
			
			String paySeq = PayUtil.genPaySeqId();
			paydt.setPaySeq(paySeq);
			paydt.setTotalAmt(params.get("payAmt"));
			paydt.setInstDt(instDt);
			paydt.setTimeStart(instDt);
			String endTime = DateUtil.getDateToString(new Date(System.currentTimeMillis() + 60*60*1000),	 DateUtil.DATE_FORMAT_14);
			paydt.setTimeExpire(endTime);
			paydt.setTradeType("NATIVE");
			
			log.info("当前订单支付流水号为[{}]",paydt.getPaySeq());
			WxUnifiedOrder pay = new WxUnifiedOrder();
			pay.setOut_trade_no(paySeq);
			pay.setAttach(orderId);
			pay.setBody(params.get("orderDesc"));
			pay.setProduct_id(orderId);
			pay.setTime_start(instDt);
			pay.setTime_expire(endTime);
			pay.setSpbill_create_ip("120.26.90.1");
			pay.setTotal_fee(Integer.parseInt(params.get("payAmt")));
			pay.setSign(Signature.getSign(pay));
			
			/*模板定义*/
			Configuration cfg =  new Configuration(new Version("2.3.23"));
			cfg.setClassLoaderForTemplateLoading(StartupListener.class.getClassLoader(), "/config/trans");
			PayConstants.freemarkerTemplate = cfg;
			StringWriter sw = new StringWriter();
			
			PayConstants.freemarkerTemplate.getTemplate("0001.xml").process(pay, sw);
			
			log.info("发送报文内容为:["+sw+"]");
	
			HttpUrlResponse rsp = HttpUrlClient.sendData(Configure.PAY_API, "UTF-8", sw.toString());
			
			log.info("收到报文内容为:["+rsp.getHtmlContent()+"]");
			
			if(!Signature.checkIsSignValidFromResponseString(rsp.getHtmlContent()))
			{
				log.info("当前订单号为：[{}],微信生成二维码签名异常",params.get("orderId"));
				msg.setRspCode("000088").setRspMsg("微信生成二维码签名异常");
				return msg;
			}
			log.info("签名校验成功!");
			WxUnifiedOrderRsp paydtData = new WxUnifiedOrderRsp();
			List infos = XMLParser.getUnifiedOrder(rsp.getHtmlContent());
			paydtData = (WxUnifiedOrderRsp)infos.get(0);
			
			log.info("返回结果为：["+paydtData.getResult_code()+"]");
			log.info("返回结果为：["+paydtData.getReturn_code()+"]");
			if(!paydtData.getReturn_code().equals("SUCCESS")||!paydtData.getResult_code().equals("SUCCESS"))
			{
				msg.setRspCode("000099").setRspMsg(paydtData.getReturn_msg());
				return msg;
			}
			paydt.setReturnCode(paydtData.getReturn_code());
			paydt.setReturnMsg(paydtData.getReturn_msg());
			paydt.setResultCode(paydtData.getReturn_code());
			paydt.setErrCode(paydtData.getErr_code());
			paydt.setErrCodeDes(paydtData.getErr_code_des());
			paydt.setPrepayId(paydtData.getPrepay_id());
			paydt.setCodeUrl(paydtData.getCode_url());
			paydt.setPaySta("01");
			
			log.info("二维码数据为：["+paydtData.getCode_url()+"]");
			
			log.info("开始生成二维码");
			QRCodeWriter writer = new QRCodeWriter();  
	        response.setHeader("Pragma", "No-cache");  
	        response.setHeader("Cache-Control", "no-cache");  
	        response.setDateHeader("Expires", 0);  
	        response.setContentType("image/jpeg"); 
	        
			String qrcode = paydtData.getCode_url();
			
        	String basePath = request.getSession().getServletContext().getRealPath("/");
        	
        	log.info("微信logo位置为:"+basePath+"images/weixin.png");
        	File wxLogo = new File(basePath+"images/weixin.png");
        	ZXUtil.writeToStream(qrcode,"jpeg",wxLogo, response.getOutputStream());
        //	ZXUtil.writeToStream(qrcode,"jpeg", response.getOutputStream());
            response.getOutputStream().flush();  
            response.getOutputStream().close();  
            
            msg = paydtlServerImpl.savePayDtl(paydt);
            
            msg.setRspCode("000000").setRspMsg("生成成功！");
	        } catch (WriterException e) {  
	        	msg.setRspCode("000002").setRspMsg("生成失败!");
	            e.printStackTrace();  
	        } catch (IOException e) {  
	        	msg.setRspCode("000002").setRspMsg("生成失败!");
	            e.printStackTrace();  
	        }  
	        log.info("生成二维码结束");
			return msg;
	}
	
	/**
	 * WxNoticeResult
	 * @throws TemplateException 
	 * @throws IllegalAccessException 
	 * @throws ParserConfigurationException 
	 * @throws SAXException 
	 * @throws IOException 
	 * */
	@RequestMapping("WxNoticeResult")
	public @ResponseBody Message WxNoticeResult(HttpSession session,HttpServletRequest request,HttpServletResponse response) throws TemplateException, IllegalAccessException, SAXException, ParserConfigurationException, IOException{
		
		Message msg = new Message();
		log.info("开始处理数据");
		
		byte[] buffer = new byte[64*1024];
		InputStream in = request.getInputStream();
		int length = in.read(buffer);
		String encode = request.getCharacterEncoding();
		
		byte[] data = new byte[length];
		System.arraycopy(buffer, 0, data, 0, length);
		String context = new String(data, encode);
		
		log.info("收到报文内容为:["+context+"]");
		
		String resultCode = "";
		String resultMsg ="";
		
		/*验证签名*/
		if(!Signature.checkIsSignValidFromResponseString(context))
		{
			log.info("签名校验失败!");
			resultCode = "FAIL";
			resultMsg = "签名验证失败";
		}
		else
		{
			log.info("签名校验成功!");
			resultCode = "SUCCESS";
			resultMsg = "OK";
		}
		
		WxNoticeReslutReq resultData = new WxNoticeReslutReq();
		List infos = XMLParser.getWxResultNotice(context);
		resultData = (WxNoticeReslutReq)infos.get(0);
		
		log.info("返回结果为：["+resultData.getResult_code()+"]");
		log.info("返回结果为：["+resultData.getReturn_code()+"]");
		if(!resultData.getResult_code().equals("SUCCESS")||!resultData.getReturn_code().equals("SUCCESS"))
		{
			resultCode = "FAIL";
			resultMsg = "签名验证失败";
		}
		else{
			TblPayDtl paydt = new TblPayDtl();
			paydt.setPaySeq(resultData.getOut_trade_no());
			paydt.setOrderId(resultData.getAttach());
			paydt.setPayTimeEnd(resultData.getTime_end());
			paydt.setTransactionId(resultData.getTransaction_id());
			paydt.setTotalAmt(resultData.getTotal_fee()+"");
			paydt.setPaySta("02");
			paydt.setPayChannle("01");
			msg = paydtlServerImpl.updatePayDtl(paydt);
			
			if(!msg.getRspCode().equals("000000"))/*该笔订单异常*/
			{
				log.info("当前订单号为：[{}],已支付或者数据库异常");
				resultCode = "FAIL";
				resultMsg = "数据异常";
			}
			
		}
		
		/*模板定义*/
		Configuration cfg =  new Configuration(new Version("2.3.23"));
		cfg.setClassLoaderForTemplateLoading(StartupListener.class.getClassLoader(), "/config/trans");
		PayConstants.freemarkerTemplate = cfg;
		StringWriter sw = new StringWriter();
		
		WxNoticeReslutRsp noticd = new WxNoticeReslutRsp();
		noticd.setReturnCode(resultCode);
		noticd.setReturnMsg(resultMsg);
		PayConstants.freemarkerTemplate.getTemplate("0003.xml").process(noticd, sw);
		
		log.info("发送报文内容为:["+sw.toString()+"]");
		
		try {  
            //把xml字符串写入响应     
            byte[] xmlData = sw.toString().getBytes();     
  
            response.setContentLength(xmlData.length); 
            ServletOutputStream os = response.getOutputStream();  
            os.write(xmlData);    
            os.flush();     
            os.close();    
        } catch (IOException e) {  
            e.printStackTrace();  
        }
		
	    return msg;
	}
	
	
	/**
	 * GetWeiXinQrcode
	 * @throws TemplateException 
	 * @throws IllegalAccessException 
	 * @throws ParserConfigurationException 
	 * @throws SAXException 
	 * */
	@RequestMapping("PayUnifiedOrder")
	public @ResponseBody Message PayUnifiedOrder(HttpSession session,SendPayInfo model,HttpServletResponse response) throws TemplateException, IllegalAccessException, ParserConfigurationException, SAXException{
		
		Message msg = new Message();
		
		Object obj=session.getAttribute(LTConstant.userInfo);
		String UserId="";
		if(obj!=null)
		{
			TblUserInfo userinfo =(TblUserInfo)obj;
			UserId=userinfo.getId();
		}
		else{
			msg.setRspCode(ResCodeConstant.MSG_NOT_LOGIN);
			msg.setRspMsg(ResCodeConstant.MSG_NOT_LOGIN_DESC);
			return msg;
		}
		
		if(model.getOrderId().isEmpty())
		{
			msg.setRspCode("100005");
			msg.setRspMsg("订单号为空");
			return msg;
		}
		if(model.getOrderDesc().isEmpty())
		{
			msg.setRspCode("100005");
			msg.setRspMsg("订单摘要为空");
			return msg;
		}
		if(model.getPayAmt().isEmpty())
		{
			msg.setRspCode("100005");
			msg.setRspMsg("订单金额为空");
			return msg;
		}
		if(model.getSendChannle().isEmpty())
		{
			msg.setRspCode("100005");
			msg.setRspMsg("发起渠道为空");
			return msg;
		}
		if(model.getPayChannle().isEmpty())
		{
			msg.setRspCode("100005");
			msg.setRspMsg("支付渠道为空");
			return msg;
		}
		
		/*检查订单状态*/
		try{
			String orderId = model.getOrderId();
			String openId ="";
			String instDt = DateUtil.getCurrentDate(DateUtil.DATE_FORMAT_14);
			
			msg = paydtlServerImpl.checkPayDtlSta(orderId);
			if(!msg.getRspCode().equals("000000"))/*该笔订单已经支付*/
			{
				log.info("当前订单号为：[{}],已支付或者数据库异常",orderId);
				return msg;
			}
			
			String paySeq = PayUtil.genPaySeqId();
			String endTime = DateUtil.getDateToString(new Date(System.currentTimeMillis() + 60*60*1000),DateUtil.DATE_FORMAT_14);
			
			TblPayDtl paydt = new TblPayDtl();
			paydt.setOrderId(orderId);
			paydt.setPayChannle(LTConstant.WEIXIN_PAY);
			paydt.setPaySeq(paySeq);
			paydt.setTotalAmt(model.getPayAmt());
			paydt.setInstDt(instDt);
			paydt.setTimeStart(instDt);
			paydt.setTimeExpire(endTime);
			paydt.setSendChannle(model.getSendChannle());
			paydt.setOrderDesc(model.getOrderDesc());
			paydt.setTradeType("NATIVE");
			
			if(model.getPayChannle().equals(LTConstant.WEIXIN_PAY))
			{
				if(model.getSendChannle().equals(LTConstant.WAP_SND))
				{
					msg=userServerImpl.GetOAuth2UserInfo(UserId, model.getPayChannle().substring(1,2));
					if(!msg.getRspCode().equals("000000"))
					{
						log.info("获取用户openid异常,[{}]",UserId);
						return msg;
					}
					TblOauth2UserInfo Ouser= new TblOauth2UserInfo();
					Ouser=(TblOauth2UserInfo)msg.getObjs();
					openId=Ouser.getOpenid();
				}
				msg=weixinServerImpl.UnifiedOrder(paydt,openId);
			}else{
				msg.setRspCode("100005");
				msg.setRspMsg("不支持当前渠道");
				return msg;
			}
			
			msg = paydtlServerImpl.savePayDtl(paydt);
			
			if(model.getSendChannle().equals(LTConstant.WAP_SND))
			{
				log.info("开始组装jsapi调用");
				String PrepayId= paydt.getPrepayId();
				log.info("PrepayId=[{}]",PrepayId);
				msg=weixinServerImpl.H5PayApi(PrepayId);
				
			}else if(model.getSendChannle().equals(LTConstant.WEB_SND))
			{
				String Code_url= paydt.getCodeUrl();
				log.info("开始生成二维码");
				QRCodeWriter writer = new QRCodeWriter();  
		        response.setHeader("Pragma", "No-cache");  
		        response.setHeader("Cache-Control", "no-cache");  
		        response.setDateHeader("Expires", 0);  
		        response.setContentType("image/jpeg"); 
				String qrcode = Code_url;
	        	String basePath = session.getServletContext().getRealPath("/");
	        	log.info("微信logo位置为:"+basePath+"images/weixin.png");
	        	File wxLogo = new File(basePath+"images/weixin.png");
	        	ZXUtil.writeToStream(qrcode,"jpeg",wxLogo, response.getOutputStream());
	        //	ZXUtil.writeToStream(qrcode,"jpeg", response.getOutputStream());
	            response.getOutputStream().flush();  
	            response.getOutputStream().close();  
	            log.info("生成二维码结束");
			}
			
            msg.setRspCode("000000").setRspMsg("生成成功！");
	        } catch (WriterException e) {  
	        	msg.setRspCode("000002").setRspMsg("生成失败!");
	            e.printStackTrace();  
	        } catch (IOException e) {  
	        	msg.setRspCode("000002").setRspMsg("生成失败!");
	            e.printStackTrace();  
	        }  
	        
			return msg;
	}
	
}
