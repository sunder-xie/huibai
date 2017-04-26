package com.app.UnionPay.tencent.service.impl;

import java.io.IOException;
import java.io.StringWriter;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.xml.sax.SAXException;

import com.app.UnionPay.listener.StartupListener;
import com.app.UnionPay.tencent.common.Configure;
import com.app.UnionPay.tencent.common.Signature;
import com.app.UnionPay.tencent.common.XMLParser;
import com.app.UnionPay.tencent.model.WxH5Pay;
import com.app.UnionPay.tencent.model.WxUnifiedOrder;
import com.app.UnionPay.tencent.model.WxUnifiedOrderRsp;
import com.app.UnionPay.tencent.service.WeiXinPayService;
import com.app.UnionPay.utils.PayConstants;
import com.app.bean.TblPayDtl;
import com.app.common.model.Message;
import com.app.common.utils.LTConstant;
import com.hlb.utils.urlConnection.HttpUrlClient;
import com.hlb.utils.urlConnection.HttpUrlResponse;

import freemarker.template.Configuration;
import freemarker.template.TemplateException;
import freemarker.template.Version;

@Service
public class WeiXinPayServiceImpl implements WeiXinPayService{

	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public Message UnifiedOrder(TblPayDtl paydtl,String openId) throws IllegalAccessException, ParserConfigurationException, SAXException, TemplateException {
		
		Message msg = new Message();
		
		try{
		
		String orderId = paydtl.getOrderId();
		log.info("当前订单支付流水号为[{}]",paydtl.getPaySeq());
		WxUnifiedOrder pay = new WxUnifiedOrder();
		pay.setOut_trade_no(paydtl.getPaySeq());
		pay.setAttach(paydtl.getOrderId());
		pay.setBody(paydtl.getOrderDesc());
		pay.setProduct_id(paydtl.getOrderId());
		pay.setTime_start(paydtl.getTimeStart());
		pay.setTime_expire(paydtl.getPayTimeEnd());
		pay.setSpbill_create_ip("120.26.90.1");
		pay.setTotal_fee(Integer.parseInt(paydtl.getTotalAmt()));
		if(paydtl.getSendChannle().equals(LTConstant.WAP_SND))
		{
			pay.setTrade_type("JSAPI");
			pay.setOpenid(openId);
		}else if(paydtl.getSendChannle().equals(LTConstant.WEB_SND))
		{
			pay.setTrade_type("NATIVE");
		}
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
			log.info("当前订单号为：[{}],微信生成二维码签名异常",orderId);
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
		paydtl.setReturnCode(paydtData.getReturn_code());
		paydtl.setReturnMsg(paydtData.getReturn_msg());
		paydtl.setResultCode(paydtData.getReturn_code());
		paydtl.setErrCode(paydtData.getErr_code());
		paydtl.setErrCodeDes(paydtData.getErr_code_des());
		paydtl.setPrepayId(paydtData.getPrepay_id());
		paydtl.setCodeUrl(paydtData.getCode_url());
		paydtl.setPaySta(LTConstant.PAY_ING);
		
		msg.setRspCode("000000").setRspMsg("成功!");
		msg.setObjs(paydtData);
		
		}catch (IOException e) {  
        	msg.setRspCode("000002").setRspMsg("生成失败!");
            e.printStackTrace();  
        }  
		return msg;
	}
	
	@Override
	public Message H5PayApi(String PrepayId) throws IllegalAccessException{
		Message msg = new Message();
		
		WxH5Pay H5pay= new WxH5Pay();
		H5pay.setTimeStamp(System.currentTimeMillis()/1000+"");
		H5pay.setPackage_("prepay_id="+PrepayId);
		H5pay.setSignType("MD5");
		H5pay.setPaySign(Signature.getSign(H5pay));
		msg.setRspCode("000000").setRspMsg("成功!");
		msg.setObjs(H5pay);
		
		return msg;
	}

}
